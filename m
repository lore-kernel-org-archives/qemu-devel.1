Received: from eggs.gnu.org ([2001:4830:134:3::10]:58240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvma-0000Rp-BG
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 06:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvmX-0005vn-1c
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 06:14:56 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36375
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvmW-0005vX-PQ
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 06:14:52 -0500
References: <151765628012.7956.10328434781906082742@b81a8a9ec60f>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1f823744-92d8-5bc7-ad16-b43a343dce5d@ilande.co.uk>
Date: Sat, 3 Feb 2018 11:14:42 +0000
MIME-Version: 1.0
In-Reply-To: <151765628012.7956.10328434781906082742@b81a8a9ec60f>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/10] cuda: various fixes,
 and move 6522 to separate device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, lvivier@redhat.com

On 03/02/18 11:11, no-reply@patchew.org wrote:

> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20180203103727.26457-1-mark.cave-ayland@ilande.co.uk
> Subject: [Qemu-devel] [PATCH 00/10] cuda: various fixes, and move 6522 to separate device
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
>      echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>      if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>          failed=1
>          echo
>      fi
>      n=$((n+1))
> done
> 
> exit $failed
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 58c3da1206 cuda: convert to use the shared mos6522 device
> a110feb761 misc: introduce new mos6522 VIA device and enable it for ppc builds
> 00fdbc1124 cuda: factor out timebase-derived counter value and load time
> 8271348dd5 cuda: set timer 1 frequency property to CUDA_TIMER_FREQ
> 78543ffe92 cuda: minor cosmetic tidy-ups to get_next_irq_time()
> edafc73786 cuda: rename frequency property to tb_frequency
> 57d4dd6fc8 cuda: introduce CUDAState parameter to get_counter()
> 61fb181587 cuda: don't call cuda_update() when writing to ACR register
> 994240a346 cuda: don't allow writes to port output pins
> 5cbba0de9b cuda: do not use old_mmio accesses
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/10: cuda: do not use old_mmio accesses...
> Checking PATCH 2/10: cuda: don't allow writes to port output pins...
> Checking PATCH 3/10: cuda: don't call cuda_update() when writing to ACR register...
> Checking PATCH 4/10: cuda: introduce CUDAState parameter to get_counter()...
> Checking PATCH 5/10: cuda: rename frequency property to tb_frequency...
> Checking PATCH 6/10: cuda: minor cosmetic tidy-ups to get_next_irq_time()...
> Checking PATCH 7/10: cuda: set timer 1 frequency property to CUDA_TIMER_FREQ...
> Checking PATCH 8/10: cuda: factor out timebase-derived counter value and load time...
> Checking PATCH 9/10: misc: introduce new mos6522 VIA device and enable it for ppc builds...
> Checking PATCH 10/10: cuda: convert to use the shared mos6522 device...
> ERROR: do not use C99 // comments
> #31: FILE: hw/misc/macio/cuda.c:36:
> +//#define DEBUG_CUDA_PACKET
> 
> total: 1 errors, 0 warnings, 897 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===

This is fine - it's old debug infrastructure in CUDA which is unrelated 
to this patchset.


ATB,

Mark.
