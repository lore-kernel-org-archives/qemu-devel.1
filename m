Received: from eggs.gnu.org ([2001:4830:134:3::10]:57359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqmNh-0007jl-0G
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqmNe-0007kV-Ng
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:01:49 -0500
References: <151948268391.967.15904941335963452518@bdbb90650ae5>
From: John Snow <jsnow@redhat.com>
Message-ID: <6afb67e2-791f-ca17-4028-906f6f01abfa@redhat.com>
Date: Tue, 27 Feb 2018 16:01:21 -0500
MIME-Version: 1.0
In-Reply-To: <151948268391.967.15904941335963452518@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 00/21] blockjobs: add explicit job
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com



On 02/24/2018 09:31 AM, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20180223235142.21501-1-jsnow@redhat.com
> Subject: [Qemu-devel] [RFC v4 00/21] blockjobs: add explicit job management
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
> Switched to a new branch 'test'
> 230e578fa2 blockjobs: add manual_mgmt option to transactions
> f278a5155a iotests: test manual job dismissal
> 8e473ab4a8 blockjobs: Expose manual property
> 7ad2d0164f blockjobs: add block-job-finalize
> 3857c91315 blockjobs: add PENDING status and event
> 18eb8a4130 blockjobs: add waiting status
> daf9613432 blockjobs: add prepare callback
> 78be501212 blockjobs: add block_job_txn_apply function
> 4b659abe69 blockjobs: add commit, abort, clean helpers
> 4023046d76 blockjobs: ensure abort is called for cancelled jobs
> e9300b122e blockjobs: add block_job_dismiss
> 4fc045eae4 blockjobs: add NULL state
> e6aa454753 blockjobs: add CONCLUDED state
> 78efa2f937 blockjobs: add ABORTING state
> 057ad2472f blockjobs: add block_job_verb permission table
> c62c5b75a3 iotests: add pause_wait
> 4aadb9c38c blockjobs: add state transition table
> afc594c4b0 blockjobs: add status enum
> 434d3811fa blockjobs: add manual property
> fc3e3eebc9 blockjobs: model single jobs as transactions
> 8d32662676 blockjobs: fix set-speed kick
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/21: blockjobs: fix set-speed kick...
> Checking PATCH 2/21: blockjobs: model single jobs as transactions...
> Checking PATCH 3/21: blockjobs: add manual property...
> Checking PATCH 4/21: blockjobs: add status enum...
> Checking PATCH 5/21: blockjobs: add state transition table...
> ERROR: space prohibited before open square bracket '['
> #81: FILE: blockjob.c:48:
> +    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #82: FILE: blockjob.c:49:
> +    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #83: FILE: blockjob.c:50:
> +    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #84: FILE: blockjob.c:51:
> +    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #85: FILE: blockjob.c:52:
> +    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #86: FILE: blockjob.c:53:
> +    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0},
> 
> total: 6 errors, 0 warnings, 90 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 

-EWONTFIX unless someone screams louder than me.

> Checking PATCH 6/21: iotests: add pause_wait...
> Checking PATCH 7/21: blockjobs: add block_job_verb permission table...
> Checking PATCH 8/21: blockjobs: add ABORTING state...
> ERROR: space prohibited before open square bracket '['
> #61: FILE: blockjob.c:48:
> +    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #62: FILE: blockjob.c:49:
> +    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #63: FILE: blockjob.c:50:
> +    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #64: FILE: blockjob.c:51:
> +    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #65: FILE: blockjob.c:52:
> +    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #66: FILE: blockjob.c:53:
> +    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #67: FILE: blockjob.c:54:
> +    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0},
> 
> total: 7 errors, 0 warnings, 62 lines checked

-EWONTFIX

> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 9/21: blockjobs: add CONCLUDED state...
> ERROR: space prohibited before open square bracket '['
> #63: FILE: blockjob.c:48:
> +    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #64: FILE: blockjob.c:49:
> +    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #65: FILE: blockjob.c:50:
> +    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #66: FILE: blockjob.c:51:
> +    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #67: FILE: blockjob.c:52:
> +    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #68: FILE: blockjob.c:53:
> +    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #69: FILE: blockjob.c:54:
> +    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #70: FILE: blockjob.c:55:
> +    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0},
> 
> total: 8 errors, 0 warnings, 91 lines checked

-EWONTFIX

> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 10/21: blockjobs: add NULL state...
> ERROR: space prohibited before open square bracket '['
> #65: FILE: blockjob.c:48:
> +    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #66: FILE: blockjob.c:49:
> +    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #67: FILE: blockjob.c:50:
> +    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #68: FILE: blockjob.c:51:
> +    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #69: FILE: blockjob.c:52:
> +    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #70: FILE: blockjob.c:53:
> +    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #71: FILE: blockjob.c:54:
> +    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 1, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #72: FILE: blockjob.c:55:
> +    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #73: FILE: blockjob.c:56:
> +    /* N: */ [BLOCK_JOB_STATUS_NULL]      = {0, 0, 0, 0, 0, 0, 0, 0, 0},
> 
> total: 9 errors, 0 warnings, 71 lines checked

-EWONTFIX

> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 11/21: blockjobs: add block_job_dismiss...
> Checking PATCH 12/21: blockjobs: ensure abort is called for cancelled jobs...
> Checking PATCH 13/21: blockjobs: add commit, abort, clean helpers...
> Checking PATCH 14/21: blockjobs: add block_job_txn_apply function...
> Checking PATCH 15/21: blockjobs: add prepare callback...
> Checking PATCH 16/21: blockjobs: add waiting status...
> ERROR: space prohibited before open square bracket '['
> #80: FILE: blockjob.c:48:
> +    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #81: FILE: blockjob.c:49:
> +    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0, 0, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #82: FILE: blockjob.c:50:
> +    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #83: FILE: blockjob.c:51:
> +    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #84: FILE: blockjob.c:52:
> +    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #85: FILE: blockjob.c:53:
> +    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #86: FILE: blockjob.c:54:
> +    /* W: */ [BLOCK_JOB_STATUS_WAITING]   = {0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #87: FILE: blockjob.c:55:
> +    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #88: FILE: blockjob.c:56:
> +    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #89: FILE: blockjob.c:57:
> +    /* N: */ [BLOCK_JOB_STATUS_NULL]      = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
> 
> total: 10 errors, 0 warnings, 99 lines checked

-EWONTFIX

> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 17/21: blockjobs: add PENDING status and event...
> ERROR: space prohibited before open square bracket '['
> #84: FILE: blockjob.c:48:
> +    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #85: FILE: blockjob.c:49:
> +    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #86: FILE: blockjob.c:50:
> +    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #87: FILE: blockjob.c:51:
> +    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #88: FILE: blockjob.c:52:
> +    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #89: FILE: blockjob.c:53:
> +    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #90: FILE: blockjob.c:54:
> +    /* W: */ [BLOCK_JOB_STATUS_WAITING]   = {0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #91: FILE: blockjob.c:55:
> +    /* D: */ [BLOCK_JOB_STATUS_PENDING]   = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #92: FILE: blockjob.c:56:
> +    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
> 
> ERROR: space prohibited before open square bracket '['
> #93: FILE: blockjob.c:57:
> +    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
> 
> ERROR: space prohibited before open square bracket '['
> #94: FILE: blockjob.c:58:
> +    /* N: */ [BLOCK_JOB_STATUS_NULL]      = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
> 
> total: 11 errors, 0 warnings, 161 lines checked

-EWONTFIX

> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 18/21: blockjobs: add block-job-finalize...
> Checking PATCH 19/21: blockjobs: Expose manual property...
> Checking PATCH 20/21: iotests: test manual job dismissal...
> Checking PATCH 21/21: blockjobs: add manual_mgmt option to transactions...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
> 

All false positives unless someone really would like to advocate for me
to change the format of the table.

--js
