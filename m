Received: from eggs.gnu.org ([2001:4830:134:3::10]:56636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB7XB-000131-60
	for qemu-devel@nongnu.org; Wed, 17 May 2017 18:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB7X8-0006Ux-3e
	for qemu-devel@nongnu.org; Wed, 17 May 2017 18:35:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dB7X7-0006Un-Qg
	for qemu-devel@nongnu.org; Wed, 17 May 2017 18:35:06 -0400
Date: Thu, 18 May 2017 01:34:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170518013348-mutt-send-email-mst@kernel.org>
References: <1495057396-13387-1-git-send-email-mst@redhat.com>
	<149506017263.588.6063103635211388415@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149506017263.588.6063103635211388415@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [PULL 00/13] pci, virtio, vhost: fixes
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

On Wed, May 17, 2017 at 03:29:33PM -0700, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 1495057396-13387-1-git-send-email-mst@redhat.com
> Subject: [Qemu-devel] [PULL 00/13] pci, virtio, vhost: fixes
> Type: series
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
> 17bfbca exec: abstract address_space_do_translate()
> 8bb02e7 pci: deassert intx when pci device unrealize
> 1e14278 virtio: allow broken device to notify guest
> dc29a74 Revert "hw/pci: disable pci-bridge's shpc by default"
> 3398123 acpi-defs: clean up open brace usage
> c25b309 ACPI: don't call acpi_pcihp_device_plug_cb on xen
> 02d833c iommu: Don't crash if machine is not PC_MACHINE
> 013b6f7 pc: add 2.10 machine type
> f8df4b9 pc/fwcfg: unbreak migration from qemu-2.5 and qemu-2.6 during firmware boot
> 39fbfab libvhost-user: fix crash when rings aren't ready
> 1b9f61d hw/virtio: fix vhost user fails to startup when MQ
> e03f60a hw/arm/virt: generate 64-bit addressable ACPI objects
> 6fc4238 hw/acpi-defs: replace leading X with x_ in FADT field names
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/13: hw/acpi-defs: replace leading X with x_ in FADT field names...
> Checking PATCH 2/13: hw/arm/virt: generate 64-bit addressable ACPI objects...
> ERROR: open brace '{' following struct go on the same line
> #157: FILE: include/hw/acpi/acpi-defs.h:239:
> +struct AcpiXsdtDescriptorRev2
> +{
> 
> total: 1 errors, 0 warnings, 125 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 3/13: hw/virtio: fix vhost user fails to startup when MQ...
> Checking PATCH 4/13: libvhost-user: fix crash when rings aren't ready...
> Checking PATCH 5/13: pc/fwcfg: unbreak migration from qemu-2.5 and qemu-2.6 during firmware boot...
> Checking PATCH 6/13: pc: add 2.10 machine type...
> Checking PATCH 7/13: iommu: Don't crash if machine is not PC_MACHINE...
> Checking PATCH 8/13: ACPI: don't call acpi_pcihp_device_plug_cb on xen...
> Checking PATCH 9/13: acpi-defs: clean up open brace usage...
> Checking PATCH 10/13: Revert "hw/pci: disable pci-bridge's shpc by default"...
> Checking PATCH 11/13: virtio: allow broken device to notify guest...
> Checking PATCH 12/13: pci: deassert intx when pci device unrealize...
> Checking PATCH 13/13: exec: abstract address_space_do_translate()...
> WARNING: line over 80 characters
> #46: FILE: exec.c:479:
> +        section = address_space_translate_internal(d, addr, &addr, plen, is_mmio);
> 
> total: 0 errors, 1 warnings, 142 lines checked

Not by a lot, and seems much clearer this way, so I think it's ok to ignore.

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
