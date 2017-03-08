Received: from eggs.gnu.org ([2001:4830:134:3::10]:55500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cldYJ-0002yL-2Y
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cldYG-0000LO-Da
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:30:59 -0500
References: <20170308151544.7606-1-eblake@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <31ef7e2c-54c9-ea18-f581-d46b44d929e7@redhat.com>
Date: Wed, 8 Mar 2017 16:30:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170308151544.7606-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-2.9? v2] tests: Ignore
 more test executables
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

On 08/03/2017 16:15, Eric Blake wrote:
> Ignore test executables when building in-tree:
> test-arm-mptimer introduced in commit 882fac3
> test-crypto-hmac introduced in commit 4fd460b
> test-aio-multithread introduced in commit 0c330a7
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
> 
> v2: pick up another built binary [Laurent]
> 
> Doesn't affect the built binaries, but does make it harder to
> accidentally commit an unintended binary when doing 'git add .'.
> Therefore, it's up to the maintainer if this is 2.9 or 2.10
> material.  (test-arm-mptimer has been around since the 2.8 release)
> 
>  tests/.gitignore | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/.gitignore b/tests/.gitignore
> index dc37519..73598b6 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -11,6 +11,8 @@ check-qom-proplist
>  qht-bench
>  rcutorture
>  test-aio
> +test-aio-multithread
> +test-arm-mptimer
>  test-base64
>  test-bitops
>  test-bitcnt
> @@ -24,6 +26,7 @@ test-crypto-afsplit
>  test-crypto-block
>  test-crypto-cipher
>  test-crypto-hash
> +test-crypto-hmac
>  test-crypto-ivgen
>  test-crypto-pbkdf
>  test-crypto-secret
> 
