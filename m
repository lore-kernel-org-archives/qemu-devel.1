Received: from eggs.gnu.org ([2001:4830:134:3::10]:57908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e1o7M-0006rv-TP
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 02:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e1o7I-0006wN-55
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 02:34:16 -0400
Received: from chuckie.co.uk ([82.165.15.123]:43495
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e1o7H-0006vp-UP
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 02:34:12 -0400
References: <150758778512.270.15107434222651481306@b58463cdfd5f>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <bccb4e7a-cc09-1643-1dc4-bd1c9f58d592@ilande.co.uk>
Date: Tue, 10 Oct 2017 07:33:48 +0100
MIME-Version: 1.0
In-Reply-To: <150758778512.270.15107434222651481306@b58463cdfd5f>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/8] sun4m : sparc32_dma tidy-ups
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

On 09/10/17 23:23, no-reply@patchew.org wrote:

> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 1507583223-14819-1-git-send-email-mark.cave-ayland@ilande.co.uk
> Subject: [Qemu-devel] [PATCH 0/8] sun4m : sparc32_dma tidy-ups
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
> 9381599b5f sparc32_dma: remove is_ledma hack and replace with memory region alias
> 351ac18a76 sparc32_dma: introduce new SPARC32_DMA type container object
> 2d199e96ee sparc32_dma: use object link instead of qdev property to pass IOMMU reference
> 3d1e0d1ab6 sun4m_iommu: move TYPE_SUN4M_IOMMU declaration to sun4m.h
> 6b2427a590 sun4m: move DMA device wiring from sparc32_dma_init() to sun4m_hw_init()
> 21c607d831 sparc32_dma: move type declarations from sparc32_dma.c to sparc32_dma.h
> 76cb2ba4ba sparc32_dma: split esp and le into separate DMA devices
> c31bca2fb4 sparc32_dma: rename SPARC32_DMA type to SPARC32_DMA_DEVICE
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/8: sparc32_dma: rename SPARC32_DMA type to SPARC32_DMA_DEVICE...
> Checking PATCH 2/8: sparc32_dma: split esp and le into separate DMA devices...
> Checking PATCH 3/8: sparc32_dma: move type declarations from sparc32_dma.c to sparc32_dma.h...
> Checking PATCH 4/8: sun4m: move DMA device wiring from sparc32_dma_init() to sun4m_hw_init()...
> ERROR: spaces required around that '*' (ctx:WxV)
> #47: FILE: hw/sparc/sun4m.c:824:
> +    qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
>               ^
> 
> total: 1 errors, 0 warnings, 66 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 5/8: sun4m_iommu: move TYPE_SUN4M_IOMMU declaration to sun4m.h...
> Checking PATCH 6/8: sparc32_dma: use object link instead of qdev property to pass IOMMU reference...
> Checking PATCH 7/8: sparc32_dma: introduce new SPARC32_DMA type container object...
> Checking PATCH 8/8: sparc32_dma: remove is_ledma hack and replace with memory region alias...
> === OUTPUT END ===
> 
> Test command exited with code: 1

This is strange - I get no errors when I run scripts/checkpatch.pl from
git master locally on the output of git format-patch.

I'm not convinced this is correct either as there are plenty of other
"Type *foo" declarations within the patch itself. Presumably this is
because there are extra rules somewhere for qemu_irq?


ATB,

Mark.
