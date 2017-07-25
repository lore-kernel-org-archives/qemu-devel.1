Received: from eggs.gnu.org ([2001:4830:134:3::10]:53114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZww6-000100-Kb
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 06:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZww3-000690-Vc
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 06:19:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZww3-00068r-PD
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 06:19:27 -0400
Date: Tue, 25 Jul 2017 12:19:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170725121918.7c3f1d56@gondolin>
In-Reply-To: <150097670624.105.11799417719809984169@5d477a5b5989>
References: <20170725094026.5376-1-cohuck@redhat.com>
	<150097670624.105.11799417719809984169@5d477a5b5989>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL for-2.10 00/14] A set of s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, famz@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, david@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net

On Tue, 25 Jul 2017 02:58:27 -0700 (PDT)
no-reply@patchew.org wrote:

> Hi,
> 
> This series failed build test on FreeBSD host. Please find the details below.
> 
> Message-id: 20170725094026.5376-1-cohuck@redhat.com
> Subject: [Qemu-devel] [PULL for-2.10 00/14] A set of s390x patches
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/sh
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "base"
> # branch
> set -e
> echo "=== ENV ==="
> env
> echo "=== PACKAGES ==="
> pkg info
> echo "=== TEST BEGIN ==="
> CC=/usr/local/libexec/ccache/cc
> INSTALL=$PWD/install
> BUILD=$PWD/build
> echo -n "Using CC: "
> realpath $CC
> mkdir -p $BUILD $INSTALL
> SRC=$PWD
> cd $BUILD
> $SRC/configure --cc=$CC --prefix=$INSTALL --target-list=x86_64-softmmu
> gmake -j4
> # XXX: we need reliable clean up
> # make check -j4 V=1
> gmake install
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> fatal: unable to access 'https://github.com/patchew-project/qemu/': OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to github.com:443 

Hm... connection issues?

> error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Traceback (most recent call last):
>   File "/home/patchew-tester/patchew/patchew-cli", line 412, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf)
>   File "/home/patchew-tester/patchew/patchew-cli", line 48, in git_clone_repo
>     stdout=logf, stderr=logf)
>   File "/usr/local/lib/python3.5/subprocess.py", line 271, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f', '--mirror=fetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384', 'https://github.com/patchew-project/qemu']' returned non-zero exit status 1
> 
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
