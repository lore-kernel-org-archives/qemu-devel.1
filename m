Received: from eggs.gnu.org ([2001:4830:134:3::10]:60263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXPjj-0007Gk-Fq
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXPje-0004Ce-6U
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:05:03 -0500
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:51678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gXPjd-0004C3-U4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:04:58 -0500
Received: from player778.ha.ovh.net (unknown [10.109.160.93])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 09F7D1EDD6C
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 13:04:55 +0100 (CET)
Date: Thu, 13 Dec 2018 13:04:51 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181213130451.7c607540@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <154470004963.15371.12464064082311637710@02a1dbf831e2>
References: <20181213090343.1137475-1-groug@kaod.org>
	<154470004963.15371.12464064082311637710@02a1dbf831e2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/3] 9p patches 2018-12-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org

On Thu, 13 Dec 2018 03:20:50 -0800 (PST)
no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/20181213090343.1137475-1-groug@kaod.org/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20181213090343.1137475-1-groug@kaod.org
> Subject: [Qemu-devel] [PULL 0/3] 9p patches 2018-12-13
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
> error: RPC failed; result=18, HTTP code = 200
> fatal: The remote end hung up unexpectedly
> error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384

Huh... I really don't know where this SHA1 is coming from...

Fam, any idea what's going on here ?


> Traceback (most recent call last):
>   File "patchew-tester/src/patchew-cli", line 521, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf, True)
>   File "patchew-tester/src/patchew-cli", line 48, in git_clone_repo
>     stdout=logf, stderr=logf)
>   File "/usr/lib64/python3.4/subprocess.py", line 558, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f', '--mirror=fetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384', 'https://github.com/patchew-project/qemu']' returned non-zero exit status 1
> 
> 
> 
> The full log is available at
> http://patchew.org/logs/20181213090343.1137475-1-groug@kaod.org/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
