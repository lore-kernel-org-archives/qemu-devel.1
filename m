Received: from eggs.gnu.org ([2001:4830:134:3::10]:36823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d4Rbg-0004Tp-Kh
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d4Rbd-0001Ag-Hi
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:36:12 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1d4Rbd-0001AO-9D
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:36:09 -0400
Received: by mail-pf0-x244.google.com with SMTP id v14so21285080pfd.3
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 05:36:08 -0700 (PDT)
References: <149346893378.132.3063923710149667629@c05f1edc8ed1>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8874ac16-9e54-7c67-8e56-8ed92942ee58@ozlabs.ru>
Date: Sat, 29 Apr 2017 22:36:00 +1000
MIME-Version: 1.0
In-Reply-To: <149346893378.132.3063923710149667629@c05f1edc8ed1>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, f4bug@amsat.org, peterx@redhat.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On 29/04/17 22:28, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [PATCH qemu v4] memory/iommu: QOM'fy IOMMU MemoryRegion
> Message-id: 20170429115509.27551-1-aik@ozlabs.ru
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
> # Useful git options
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
> 72187b4 memory/iommu: QOM'fy IOMMU MemoryRegion
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: memory/iommu: QOM'fy IOMMU MemoryRegion...
> ERROR: spaces required around that '*' (ctx:WxO)
> #156: FILE: hw/dma/rc4030.c:720:
> +DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr)


What does the script really want here? I am confused.



>                                      ^
> 
> total: 1 errors, 0 warnings, 828 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
> 


-- 
Alexey
