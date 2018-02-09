Received: from eggs.gnu.org ([2001:4830:134:3::10]:49472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekE9M-0004ly-I0
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekE9L-00067N-EI
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:15:56 -0500
References: <151820354708.363.17461195274790908336@bdbb90650ae5>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ac77d4ff-7c8c-2465-a600-4e6c988154c9@ilande.co.uk>
Date: Fri, 9 Feb 2018 19:15:36 +0000
MIME-Version: 1.0
In-Reply-To: <151820354708.363.17461195274790908336@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 00/12] cuda: various fixes, tidy-ups,
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
Cc: famz@redhat.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

On 09/02/18 19:12, no-reply@patchew.org wrote:

> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20180209185142.17151-1-mark.cave-ayland@ilande.co.uk
> Subject: [Qemu-devel] [PATCHv2 00/12] cuda: various fixes, tidy-ups, and move 6522 to separate device
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
>  From https://github.com/patchew-project/qemu
>   * [new tag]               patchew/20180209185142.17151-1-mark.cave-ayland@ilande.co.uk -> patchew/20180209185142.17151-1-mark.cave-ayland@ilande.co.uk
> Switched to a new branch 'test'
> 8ffc09de07 cuda: convert to trace-events
> e2e6817bf3 ppc: move CUDAState and other CUDA-related definitions into separate cuda.h file
> a49d2800aa cuda: convert to use the shared mos6522 device
> 783d299115 misc: introduce new mos6522 VIA device and enable it for ppc builds
> 467b07e22d cuda: factor out timebase-derived counter value and load time
> 1bf294c5a4 cuda: set timer 1 frequency property to CUDA_TIMER_FREQ
> fdd2899c88 cuda: minor cosmetic tidy-ups to get_next_irq_time()
> 1b9a70ecf8 cuda: rename frequency property to tb_frequency
> f80a0ed8ee cuda: introduce CUDAState parameter to get_counter()
> 1d814a15da cuda: don't call cuda_update() when writing to ACR register
> c37f165538 cuda: don't allow writes to port output pins
> 167b6d50f8 cuda: do not use old_mmio accesses
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/12: cuda: do not use old_mmio accesses...
> Checking PATCH 2/12: cuda: don't allow writes to port output pins...
> Checking PATCH 3/12: cuda: don't call cuda_update() when writing to ACR register...
> Checking PATCH 4/12: cuda: introduce CUDAState parameter to get_counter()...
> Checking PATCH 5/12: cuda: rename frequency property to tb_frequency...
> Checking PATCH 6/12: cuda: minor cosmetic tidy-ups to get_next_irq_time()...
> Checking PATCH 7/12: cuda: set timer 1 frequency property to CUDA_TIMER_FREQ...
> Checking PATCH 8/12: cuda: factor out timebase-derived counter value and load time...
> Checking PATCH 9/12: misc: introduce new mos6522 VIA device and enable it for ppc builds...
> Checking PATCH 10/12: cuda: convert to use the shared mos6522 device...
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
> Checking PATCH 11/12: ppc: move CUDAState and other CUDA-related definitions into separate cuda.h file...
> Checking PATCH 12/12: cuda: convert to trace-events...
> === OUTPUT END ===
> 
> Test command exited with code: 1

As before, this is a false positive (especially since v2 patch 12 
converts CUDA to use trace-events and so these lines disappear anyhow).


ATB,

Mark.
