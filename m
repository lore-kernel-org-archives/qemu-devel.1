Received: from eggs.gnu.org ([2001:4830:134:3::10]:52468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1clYOf-0001JX-QK
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1clYOa-0005a6-3U
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:00:41 -0500
References: <20170307184517.21521-1-eblake@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <32c14d52-e8d0-09a7-4232-52dab2ae3e8c@redhat.com>
Date: Wed, 8 Mar 2017 11:00:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170307184517.21521-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-2.9?] tests: Ignore more
 test executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

and tests/test-arm-mptimer?

Laurent

On 07/03/2017 19:45, Eric Blake wrote:
> Ignore test executables when building in-tree:
> test-crypto-hmac introduced in commit 4fd460b
> test-aio-multithread introduced in commit 0c330a7
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> Doesn't affect the built binaries, but does make it harder to
> accidentally commit an unintended binary when doing 'git add .'.
> Therefore, it's up to the maintainer if this is 2.9 or 2.10
> material.
> 
>  tests/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/.gitignore b/tests/.gitignore
> index dc37519..71521ac 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -11,6 +11,7 @@ check-qom-proplist
>  qht-bench
>  rcutorture
>  test-aio
> +test-aio-multithread
>  test-base64
>  test-bitops
>  test-bitcnt
> @@ -24,6 +25,7 @@ test-crypto-afsplit
>  test-crypto-block
>  test-crypto-cipher
>  test-crypto-hash
> +test-crypto-hmac
>  test-crypto-ivgen
>  test-crypto-pbkdf
>  test-crypto-secret
> 
