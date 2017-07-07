Received: from eggs.gnu.org ([2001:4830:134:3::10]:41920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGm4-0007K9-Mw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGm3-0000vZ-Mh
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:05:32 -0400
Date: Fri, 7 Jul 2017 08:05:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170707000523.GK5149@lemon.lan>
References: <20170629060300.29869-1-el13635@mail.ntua.gr>
	<149938496797.27.11708429179775046632@7a482c8a7db2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149938496797.27.11708429179775046632@7a482c8a7db2>
Subject: Re: [Qemu-devel] [PATCH] block: fix bs->file leak in
 bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Thu, 07/06 16:49, no-reply@patchew.org wrote:
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> fatal: Cannot update paths and switch to branch 'test' at the same time.
> Did you intend to checkout 'origin/patchew/20170629060300.29869-1-el13635@mail.ntua.gr' which can not be resolved as commit?
> Traceback (most recent call last):
>   File "/home/fam/bin/patchew", line 440, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf)
>   File "/home/fam/bin/patchew", line 53, in git_clone_repo
>     cwd=clone)
>   File "/usr/lib64/python3.5/subprocess.py", line 271, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'checkout', 'origin/patchew/20170629060300.29869-1-el13635@mail.ntua.gr', '-b', 'test']' returned non-zero exit status 128

Ignore this please, patchew is recovering from a bad state.
