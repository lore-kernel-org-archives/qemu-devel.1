Received: from eggs.gnu.org ([2001:4830:134:3::10]:50932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3d8k-0005FZ-1d
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 03:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3d8f-0004Ix-JN
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 03:15:13 -0400
Received: from chuckie.co.uk ([82.165.15.123]:37768
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e3d8f-0004Gl-9T
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 03:15:09 -0400
References: <150800900348.320.15378863365157681326@b58463cdfd5f>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <05ecaa71-61cd-8743-cc53-fbd9ef4b428e@ilande.co.uk>
Date: Sun, 15 Oct 2017 08:14:47 +0100
MIME-Version: 1.0
In-Reply-To: <150800900348.320.15378863365157681326@b58463cdfd5f>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 00/13] sun4m: sparc32_dma tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org
Cc: famz@redhat.com, atar4qemu@gmail.com

On 14/10/17 20:23, no-reply@patchew.org wrote:

> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk
> Subject: [Qemu-devel] [PATCHv3 00/13] sun4m: sparc32_dma tidy-ups
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
> 49376f2097 sparc32_dma: add len to esp/le DMA memory tracing
> d1747b9946 sparc32_dma: remove is_ledma hack and replace with memory region alias
> aff708b794 sparc32_dma: introduce new SPARC32_DMA type container object
> c1d8e324e2 sparc32_dma: make lance device child of ledma device
> 89f91116dd lance: move TYPE_LANCE and SysBusPCNetState from lance.c to sun4m.h
> dead665d1d sparc32_dma: make esp device child of espdma device
> 1afaa63bbd esp: move TYPE_ESP and SysBusESPState from esp.c to esp.h
> 9e05523632 sparc32_dma: use object link instead of qdev property to pass IOMMU reference
> 80b9835896 sun4m_iommu: move TYPE_SUN4M_IOMMU declaration to sun4m.h
> 66a36aaa11 sun4m: move DMA device wiring from sparc32_dma_init() to sun4m_hw_init()
> d2fd9ca3eb sparc32_dma: move type declarations from sparc32_dma.c to sparc32_dma.h
> 74c5135edf sparc32_dma: split esp and le into separate DMA devices
> cc07b7035d sparc32_dma: rename SPARC32_DMA type to SPARC32_DMA_DEVICE
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/13: sparc32_dma: rename SPARC32_DMA type to SPARC32_DMA_DEVICE...
> Checking PATCH 2/13: sparc32_dma: split esp and le into separate DMA devices...
> Checking PATCH 3/13: sparc32_dma: move type declarations from sparc32_dma.c to sparc32_dma.h...
> Checking PATCH 4/13: sun4m: move DMA device wiring from sparc32_dma_init() to sun4m_hw_init()...
> ERROR: spaces required around that '*' (ctx:WxV)
> #51: FILE: hw/sparc/sun4m.c:824:
> +    qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
>               ^
> 
> total: 1 errors, 0 warnings, 66 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 5/13: sun4m_iommu: move TYPE_SUN4M_IOMMU declaration to sun4m.h...
> Checking PATCH 6/13: sparc32_dma: use object link instead of qdev property to pass IOMMU reference...
> Checking PATCH 7/13: esp: move TYPE_ESP and SysBusESPState from esp.c to esp.h...
> Checking PATCH 8/13: sparc32_dma: make esp device child of espdma device...
> Checking PATCH 9/13: lance: move TYPE_LANCE and SysBusPCNetState from lance.c to sun4m.h...
> Checking PATCH 10/13: sparc32_dma: make lance device child of ledma device...
> Checking PATCH 11/13: sparc32_dma: introduce new SPARC32_DMA type container object...
> Checking PATCH 12/13: sparc32_dma: remove is_ledma hack and replace with memory region alias...
> Checking PATCH 13/13: sparc32_dma: add len to esp/le DMA memory tracing...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

I had a brief chat with Fam about this on IRC and he agreed it was a
false positive - however I am still confused as to why I don't see this
locally?

>From my github repository at https://github.com/mcayland/qemu.git:

$ git checkout for-fam
Previous HEAD position was f90ea7b... Merge remote-tracking branch
'remotes/pmaydell/tags/pull-target-arm-20171012' into staging
Branch for-fam set up to track remote branch for-fam from mcayland-github.
Switched to a new branch 'for-fam'

$ git format-patch -o /tmp/qemu f90ea7b
/tmp/qemu/0001-sparc32_dma-rename-SPARC32_DMA-type-to-SPARC32_DMA_D.patch
/tmp/qemu/0002-sparc32_dma-split-esp-and-le-into-separate-DMA-devic.patch
/tmp/qemu/0003-sparc32_dma-move-type-declarations-from-sparc32_dma..patch
/tmp/qemu/0004-sun4m-move-DMA-device-wiring-from-sparc32_dma_init-t.patch
/tmp/qemu/0005-sun4m_iommu-move-TYPE_SUN4M_IOMMU-declaration-to-sun.patch
/tmp/qemu/0006-sparc32_dma-use-object-link-instead-of-qdev-property.patch
/tmp/qemu/0007-esp-move-TYPE_ESP-and-SysBusESPState-from-esp.c-to-e.patch
/tmp/qemu/0008-sparc32_dma-make-esp-device-child-of-espdma-device.patch
/tmp/qemu/0009-lance-move-TYPE_LANCE-and-SysBusPCNetState-from-lanc.patch
/tmp/qemu/0010-sparc32_dma-make-lance-device-child-of-ledma-device.patch
/tmp/qemu/0011-sparc32_dma-introduce-new-SPARC32_DMA-type-container.patch
/tmp/qemu/0012-sparc32_dma-remove-is_ledma-hack-and-replace-with-me.patch
/tmp/qemu/0013-sparc32_dma-add-len-to-esp-le-DMA-memory-tracing.patch

$ ./scripts/checkpatch.pl /tmp/qemu/*
total: 0 errors, 0 warnings, 175 lines checked

/tmp/qemu/0001-sparc32_dma-rename-SPARC32_DMA-type-to-SPARC32_DMA_D.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 107 lines checked

/tmp/qemu/0002-sparc32_dma-split-esp-and-le-into-separate-DMA-devic.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 89 lines checked

/tmp/qemu/0003-sparc32_dma-move-type-declarations-from-sparc32_dma..patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 66 lines checked

/tmp/qemu/0004-sun4m-move-DMA-device-wiring-from-sparc32_dma_init-t.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 52 lines checked

/tmp/qemu/0005-sun4m_iommu-move-TYPE_SUN4M_IOMMU-declaration-to-sun.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 45 lines checked

/tmp/qemu/0006-sparc32_dma-use-object-link-instead-of-qdev-property.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 45 lines checked

/tmp/qemu/0007-esp-move-TYPE_ESP-and-SysBusESPState-from-esp.c-to-e.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 91 lines checked

/tmp/qemu/0008-sparc32_dma-make-esp-device-child-of-espdma-device.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 40 lines checked

/tmp/qemu/0009-lance-move-TYPE_LANCE-and-SysBusPCNetState-from-lanc.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 110 lines checked

/tmp/qemu/0010-sparc32_dma-make-lance-device-child-of-ledma-device.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 198 lines checked

/tmp/qemu/0011-sparc32_dma-introduce-new-SPARC32_DMA-type-container.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 64 lines checked

/tmp/qemu/0012-sparc32_dma-remove-is_ledma-hack-and-replace-with-me.patch
has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 48 lines checked

/tmp/qemu/0013-sparc32_dma-add-len-to-esp-le-DMA-memory-tracing.patch
has no obvious style problems and is ready for submission.

So I don't see the warning here at all?

$ md5sum scripts/checkpatch.pl
6c5d64bb35ab9fbe2a2da67d8c151d86  scripts/checkpatch.pl


ATB,

Mark.
