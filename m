Received: from eggs.gnu.org ([2001:4830:134:3::10]:43725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ejPn9-0006pg-BP
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ejPn8-0000h3-7z
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:29:39 -0500
References: <151800962781.204.820918804384569617@bdbb90650ae5>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f4623a77-131f-dce7-a02a-2095e84f6935@virtuozzo.com>
Date: Wed, 7 Feb 2018 16:29:23 +0300
MIME-Version: 1.0
In-Reply-To: <151800962781.204.820918804384569617@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

looks strange and unrelated.

07.02.2018 16:20, no-reply@patchew.org wrote:
> Hi,
>
> This series failed build test on ppc host. Please find the details below.
>
> Type: series
> Subject: [Qemu-devel] [PATCH v2 0/2] block latency histogram
> Message-id: 20180207125037.13510-1-vsementsov@virtuozzo.com
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "base"
> # branch
> set -e
> echo "=== ENV ==="
> env
> echo "=== PACKAGES ==="
> rpm -qa
> echo "=== TEST BEGIN ==="
> INSTALL=$PWD/install
> BUILD=$PWD/build
> mkdir -p $BUILD $INSTALL
> SRC=$PWD
> cd $BUILD
> $SRC/configure --prefix=$INSTALL
> make -j100
> # XXX: we need reliable clean up
> # make check -j100 V=1
> make install
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> error: RPC failed; result=18, HTTP code = 200
> fatal: The remote end hung up unexpectedly
> error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Traceback (most recent call last):
>    File "/home/patchew/patchew/patchew-cli", line 504, in test_one
>      git_clone_repo(clone, r["repo"], r["head"], logf)
>    File "/home/patchew/patchew/patchew-cli", line 48, in git_clone_repo
>      stdout=logf, stderr=logf)
>    File "/usr/lib64/python3.4/subprocess.py", line 558, in check_call
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f', '--mirror=fetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384', 'https://github.com/patchew-project/qemu']' returned non-zero exit status 1
>
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org


-- 
Best regards,
Vladimir
