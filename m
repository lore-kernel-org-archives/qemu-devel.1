Received: from eggs.gnu.org ([2001:4830:134:3::10]:40921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGjb-00052c-Rl
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGja-0007wI-VX
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:02:59 -0400
Date: Fri, 7 Jul 2017 08:02:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170707000253.GD5149@lemon.lan>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
	<149938499324.27.18405371128773967269@7a482c8a7db2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149938499324.27.18405371128773967269@7a482c8a7db2>
Subject: Re: [Qemu-devel] [PATCH V2 0/8] add Qcow2 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pl@kamp.de, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, lersek@redhat.com

On Thu, 07/06 16:49, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [PATCH V2 0/8] add Qcow2 compress format extension
> Message-id: 1498733831-15254-1-git-send-email-pl@kamp.de
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
> fatal: Cannot update paths and switch to branch 'test' at the same time.
> Did you intend to checkout 'origin/patchew/1498733831-15254-1-git-send-email-pl@kamp.de' which can not be resolved as commit?
> Traceback (most recent call last):
>   File "/home/fam/bin/patchew", line 440, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf)
>   File "/home/fam/bin/patchew", line 53, in git_clone_repo
>     cwd=clone)
>   File "/usr/lib64/python3.5/subprocess.py", line 271, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'checkout', 'origin/patchew/1498733831-15254-1-git-send-email-pl@kamp.de', '-b', 'test']' returned non-zero exit status 128

Ignore this please, patchew is recovering from a bad state.
