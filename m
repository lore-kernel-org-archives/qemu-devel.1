Received: from eggs.gnu.org ([2001:4830:134:3::10]:59447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTmrT-00043k-3U
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTmrP-0001VC-8U
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:48:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cTmrP-0001V2-2w
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:48:55 -0500
Date: Wed, 18 Jan 2017 17:48:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170118094849.GD6199@lemon>
References: <20161201052844.31819-1-bobby.prani@gmail.com>
	<148472643642.214.7504531151595764217@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148472643642.214.7504531151595764217@790289a7ca88>
Subject: Re: [Qemu-devel] [PATCH v5 0/3] Add litmus tests for MTTCG
 consistency tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: bobby.prani@gmail.com, alex.bennee@linaro.org, rth@twiddle.net

On Wed, 01/18 00:00, no-reply@patchew.org wrote:
> Hi,
> 
> Your series seems to have some coding style problems. See output below for
> more information:

Sorry for the noise, looks like it's a network issue during preparation,
unrelated to this series. I'll look into suppressing such errors in the future.

Fam

> 
> Message-id: 20161201052844.31819-1-bobby.prani@gmail.com
> Subject: [Qemu-devel] [PATCH v5 0/3] Add litmus tests for MTTCG consistency tests
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
> fatal: unable to access 'https://github.com/patchew-project/qemu/': Failed connect to github.com:443; Operation now in progress
> error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Traceback (most recent call last):
>   File "/usr/bin/patchew", line 406, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf)
>   File "/usr/bin/patchew", line 47, in git_clone_repo
>     stdout=logf, stderr=logf)
>   File "/usr/lib64/python3.4/subprocess.py", line 561, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f', '--mirror=fetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384', 'https://github.com/patchew-project/qemu']' returned non-zero exit status 1
> 
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
