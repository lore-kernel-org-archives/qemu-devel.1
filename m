Received: from eggs.gnu.org ([2001:4830:134:3::10]:49387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiFTO-000474-21
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiFTL-00050n-3N
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:48:42 -0400
Date: Wed, 25 Jul 2018 09:48:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180725084824.GA12855@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, radoslaw.biernacki@linaro.org, leif.lindholm@linaro.org, ard.biesheuvel@linaro.org

On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
> For the Aarch64, there is one machine 'virt', it is primarily meant to
> run on KVM and execute virtualization workloads, but we need an
> environment as faithful as possible to physical hardware, for supporting
> firmware and OS development for pysical Aarch64 machines.
> 
> This patch introduces new machine type 'Enterprise' with main features:

The 'enterprise' name is really awful - this is essentially a marketing
term completely devoid of any useful meaning.

You had previously called this "sbsa" which IIUC was related to a real
world hardware specification that it was based on. IOW, I think this old
name was preferrable to calling it "enterprise".

>  - Based on 'virt' machine type.
>  - Re-designed memory map.
>  - EL2 and EL3 are enabled by default.
>  - GIC version 3 by default.
>  - AHCI controller attached to system bus, and then CDROM and hard disc
>    can be added to it.
>  - EHCI controller attached to system bus, with USB mouse and key board
>    installed by default.
>  - E1000E ethernet card on PCIE bus.
>  - VGA display adaptor on PCIE bus.
>  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
>  - No virtio functions enabled, since this is to emulate real hardware.
>  - No paravirtualized fw_cfg device either.
> 
> Arm Trusted Firmware and UEFI porting to this are done accordingly.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
> Changes since v1:
>  - rebase on v3.0.0-rc0
>  - introduce another auxillary patch as 1/2, so this is 2/2
>  - rename 'sbsa' to 'enterprise'
>  - remove paravirualized fw_cfg
>  - set gic_vertion to 3 instead of 2
>  - edit commit message to describe purpose of this platform
> 
>  hw/arm/virt-acpi-build.c |  59 +++++++++++++-
>  hw/arm/virt.c            | 199 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/hw/arm/virt.h    |   3 +
>  3 files changed, 255 insertions(+), 6 deletions(-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
