Received: from eggs.gnu.org ([2001:4830:134:3::10]:51266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsVbD-0003Zf-If
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsVb7-0006Eb-Rq
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:03:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:49197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsVb7-0006DN-Hn
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:03:05 -0400
References: <20180818190118.12911-1-richard.henderson@linaro.org>
	<20180818190118.12911-12-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ddef3113-69e4-ea94-a017-bb63b702da14@vivier.eu>
Date: Wed, 22 Aug 2018 18:03:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180818190118.12911-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 11/16] linux-user: Split out preadv,
 pwritev, readv, writev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 18/08/2018 à 21:01, Richard Henderson a écrit :
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall-file.inc.c | 98 +++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c          | 75 ++-------------------------
>  linux-user/strace.list        | 12 -----
>  3 files changed, 102 insertions(+), 83 deletions(-)
> 
...
> +SYSCALL_IMPL(pwritev)
> +{
> +    struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
> +    unsigned long lo, hi;
> +    abi_long ret;
> +
> +    if (vec == NULL) {
> +        ret = -host_to_target_errno(errno);

           return -host_to_target_errno(errno);

Found while testing with LTP

Thanks,
Laurent
