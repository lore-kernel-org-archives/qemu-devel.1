Received: from eggs.gnu.org ([2001:4830:134:3::10]:51516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiFgD-0001mu-Mc
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiFg8-00051H-VI
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:01:55 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:39426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1fiFg8-000501-QK
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:01:52 -0400
Received: by mail-it0-x243.google.com with SMTP id g141-v6so7625878ita.4
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 02:01:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725084824.GA12855@redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725084824.GA12855@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 25 Jul 2018 11:01:50 +0200
Message-ID: <CAKv+Gu_RHsed0KAH8njKB8UPvbUDeoTZ5sP76f_br6azisZzSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>

On 25 July 2018 at 10:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
>> For the Aarch64, there is one machine 'virt', it is primarily meant to
>> run on KVM and execute virtualization workloads, but we need an
>> environment as faithful as possible to physical hardware, for supporting
>> firmware and OS development for pysical Aarch64 machines.
>>
>> This patch introduces new machine type 'Enterprise' with main features:
>
> The 'enterprise' name is really awful - this is essentially a marketing
> term completely devoid of any useful meaning.
>
> You had previously called this "sbsa" which IIUC was related to a real
> world hardware specification that it was based on. IOW, I think this old
> name was preferrable to calling it "enterprise".
>

I couldn't agree more. However, IIUC this change was made at the
request of one of the reviewers, although I wasn't part of the
discussion at that point, so I'm not sure who it was.

Hongbo, could you please share a link to that discussion?

Thanks,
Ard.

>>  - Based on 'virt' machine type.
>>  - Re-designed memory map.
>>  - EL2 and EL3 are enabled by default.
>>  - GIC version 3 by default.
>>  - AHCI controller attached to system bus, and then CDROM and hard disc
>>    can be added to it.
>>  - EHCI controller attached to system bus, with USB mouse and key board
>>    installed by default.
>>  - E1000E ethernet card on PCIE bus.
>>  - VGA display adaptor on PCIE bus.
>>  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
>>  - No virtio functions enabled, since this is to emulate real hardware.
>>  - No paravirtualized fw_cfg device either.
>>
>> Arm Trusted Firmware and UEFI porting to this are done accordingly.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>> ---
>> Changes since v1:
>>  - rebase on v3.0.0-rc0
>>  - introduce another auxillary patch as 1/2, so this is 2/2
>>  - rename 'sbsa' to 'enterprise'
>>  - remove paravirualized fw_cfg
>>  - set gic_vertion to 3 instead of 2
>>  - edit commit message to describe purpose of this platform
>>
>>  hw/arm/virt-acpi-build.c |  59 +++++++++++++-
>>  hw/arm/virt.c            | 199 ++++++++++++++++++++++++++++++++++++++++=
++++++-
>>  include/hw/arm/virt.h    |   3 +
>>  3 files changed, 255 insertions(+), 6 deletions(-)
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
