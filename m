Received: from eggs.gnu.org ([2001:4830:134:3::10]:53572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d89WR-0000NS-Bg
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d89WN-0001j0-Bn
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:06:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d89WM-0001ia-TE
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:06:03 -0400
Date: Tue, 9 May 2017 21:05:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170509210530-mutt-send-email-mst@kernel.org>
References: <1494330527-24163-1-git-send-email-mst@redhat.com>
	<149434473463.264.16180527721284428575@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149434473463.264.16180527721284428575@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [PULL 0/8] pci, virtio, vhost: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org

On Tue, May 09, 2017 at 08:45:35AM -0700, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [PULL 0/8] pci, virtio, vhost: fixes
> Type: series
> Message-id: 1494330527-24163-1-git-send-email-mst@redhat.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> 
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
> 
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> 
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
> 
> exit $failed
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 1aaf234 ACPI: don't call acpi_pcihp_device_plug_cb on xen
> 3b6e1b3 iommu: Don't crash if machine is not PC_MACHINE
> 5e3f027 pc: add 2.10 machine type
> a611b9d pc/fwcfg: unbreak migration from qemu-2.5 and qemu-2.6 during firmware boot
> 2ece0f6 libvhost-user: fix crash when rings aren't ready
> c9d2f84 hw/virtio: fix vhost user fails to startup when MQ
> f24260b hw/arm/virt: generate 64-bit addressable ACPI objects
> 6f01b84 hw/acpi-defs: replace leading X with x_ in FADT field names
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/8: hw/acpi-defs: replace leading X with x_ in FADT field names...
> Checking PATCH 2/8: hw/arm/virt: generate 64-bit addressable ACPI objects...
> ERROR: open brace '{' following struct go on the same line
> #157: FILE: include/hw/acpi/acpi-defs.h:244:
> +struct AcpiXsdtDescriptorRev2
> +{
> 
> total: 1 errors, 0 warnings, 125 lines checked

Yes but it's consistent with Rev1. So I'll keep it as is
and apply a tweak on top.

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 3/8: hw/virtio: fix vhost user fails to startup when MQ...
> Checking PATCH 4/8: libvhost-user: fix crash when rings aren't ready...
> Checking PATCH 5/8: pc/fwcfg: unbreak migration from qemu-2.5 and qemu-2.6 during firmware boot...
> Checking PATCH 6/8: pc: add 2.10 machine type...
> Checking PATCH 7/8: iommu: Don't crash if machine is not PC_MACHINE...
> Checking PATCH 8/8: ACPI: don't call acpi_pcihp_device_plug_cb on xen...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
