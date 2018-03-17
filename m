Received: from eggs.gnu.org ([2001:4830:134:3::10]:56896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1ewzIb-0008SB-NP
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 20:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1ewzIa-0003eT-6P
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 20:02:13 -0400
Date: Fri, 16 Mar 2018 20:01:52 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180317000151.GA24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<152123390250.78.14000079057958081515@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152123390250.78.14000079057958081515@71c20359a636>
Subject: Re: [Qemu-devel] [PATCH v3 00/22] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-arm@nongnu.org, peter.maydell@linaro.org, alistair.francis@xilinx.com, wei@redhat.com, crosthwaite.peter@gmail.com, mspradli@codeaurora.org, digantd@codeaurora.org

My apologies for the below style issues - I've already fixed them up for
v4...

-Aaron

On Mar 16 13:58, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 1521232280-13089-1-git-send-email-alindsay@codeaurora.org
> Subject: [Qemu-devel] [PATCH v3 00/22] More fully implement ARM PMUv3
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
> git config --local diff.algorithm histogram
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
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/1521232280-13089-1-git-send-email-alindsay@codeaurora.org -> patchew/1521232280-13089-1-git-send-email-alindsay@codeaurora.org
> Switched to a new branch 'test'
> d81791b184 target/arm: Implement PMSWINC
> 512124d018 target/arm: PMU: Set PMCR.N to 4
> b748e97306 target/arm: PMU: Add instruction and cycle events
> 7e46a77f89 target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
> 82cffef855 target/arm: Add array for supported PMU events, generate PMCEID[01]
> d635021d0a target/arm: Split arm_ccnt_enabled into generic pmu_counter_enabled
> 3e1b438deb target/arm: Implement PMOVSSET
> c13c832988 target/arm: Add ARM_FEATURE_V7VE for v7 Virtualization Extensions
> 9c80af4d82 target/arm: Make PMOVSCLR 64 bits wide
> 8ffbcd3dd8 target/arm: Allow AArch32 access for PMCCFILTR
> 7dc4ec9715 target/arm: Filter cycle counter based on PMCCFILTR_EL0
> f1e40f9fff target/arm: Fix bitmask for PMCCFILTR writes
> eb142b42b4 target/arm: Allow EL change hooks to do IO
> d37186abdd target/arm: Add pre-EL change hooks
> ae12e161da target/arm: Support multiple EL change hooks
> 9bfa99805d target/arm: Fetch GICv3 state directly from CPUARMState
> 881bee5e96 target/arm: Mask PMU register writes based on PMCR_EL0.N
> 890ad6472b target/arm: Reorganize PMCCNTR read, write, sync
> 922eec023b target/arm: Treat PMCCNTR as alias of PMCCNTR_EL0
> 5b1ce33c0b target/arm: Check PMCNTEN for whether PMCCNTR is enabled
> 2ecb09ae04 target/arm: A15 PMCEID0 initialization style nit
> 0f26a1568a target/arm: A53: Initialize PMCEID[01]
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/22: target/arm: A53: Initialize PMCEID[01]...
> Checking PATCH 2/22: target/arm: A15 PMCEID0 initialization style nit...
> Checking PATCH 3/22: target/arm: Check PMCNTEN for whether PMCCNTR is enabled...
> Checking PATCH 4/22: target/arm: Treat PMCCNTR as alias of PMCCNTR_EL0...
> Checking PATCH 5/22: target/arm: Reorganize PMCCNTR read, write, sync...
> Checking PATCH 6/22: target/arm: Mask PMU register writes based on PMCR_EL0.N...
> Checking PATCH 7/22: target/arm: Fetch GICv3 state directly from CPUARMState...
> Checking PATCH 8/22: target/arm: Support multiple EL change hooks...
> ERROR: space prohibited between function name and open parenthesis '('
> #26: FILE: target/arm/cpu.c:62:
> +    entry = g_malloc0(sizeof (*entry));
> 
> total: 1 errors, 0 warnings, 87 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 9/22: target/arm: Add pre-EL change hooks...
> ERROR: space prohibited between function name and open parenthesis '('
> #26: FILE: target/arm/cpu.c:62:
> +    entry = g_malloc0(sizeof (*entry));
> 
> total: 1 errors, 0 warnings, 110 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 10/22: target/arm: Allow EL change hooks to do IO...
> Checking PATCH 11/22: target/arm: Fix bitmask for PMCCFILTR writes...
> Checking PATCH 12/22: target/arm: Filter cycle counter based on PMCCFILTR_EL0...
> Checking PATCH 13/22: target/arm: Allow AArch32 access for PMCCFILTR...
> Checking PATCH 14/22: target/arm: Make PMOVSCLR 64 bits wide...
> Checking PATCH 15/22: target/arm: Add ARM_FEATURE_V7VE for v7 Virtualization Extensions...
> Checking PATCH 16/22: target/arm: Implement PMOVSSET...
> WARNING: line over 80 characters
> #39: FILE: target/arm/helper.c:1417:
> +      .access = PL0_RW, .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
> 
> total: 0 errors, 1 warnings, 59 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 17/22: target/arm: Split arm_ccnt_enabled into generic pmu_counter_enabled...
> Checking PATCH 18/22: target/arm: Add array for supported PMU events, generate PMCEID[01]...
> Checking PATCH 19/22: target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER...
> Checking PATCH 20/22: target/arm: PMU: Add instruction and cycle events...
> Checking PATCH 21/22: target/arm: PMU: Set PMCR.N to 4...
> Checking PATCH 22/22: target/arm: Implement PMSWINC...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
