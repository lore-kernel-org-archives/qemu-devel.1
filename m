Received: from eggs.gnu.org ([2001:4830:134:3::10]:48104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvSk-0008Pv-4J
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvSf-00064B-7v
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:48:18 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPvSe-00063n-TT
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:48:13 -0400
References: <20180601073050.8054-1-richard.henderson@linaro.org>
	<20180601073050.8054-8-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2e7a6d66-aa05-3e11-ea5f-10814b2cd813@vivier.eu>
Date: Mon, 4 Jun 2018 21:48:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180601073050.8054-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/33] linux-user: Propagate goto fail to
 return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Le 01/06/2018 à 09:30, Richard Henderson a écrit :
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 62 ++++++++++++++++----------------------------
>  1 file changed, 23 insertions(+), 39 deletions(-)
> 

> @@ -9951,18 +9947,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              case TARGET_SYSLOG_ACTION_READ_CLEAR:    /* Read/clear msgs */
>              case TARGET_SYSLOG_ACTION_READ_ALL:      /* Read last messages */
>                  {
> -                    ret = -TARGET_EINVAL;
>                      if (len < 0) {
> -                        goto fail;
> +                        return -TARGET_EINVAL;
>                      }
> -                    ret = 0;
>                      if (len == 0) {
> -                        return ret;
> +                        return 0;

I think you should do this change in '[PATCH 02/33] linux-user: Relax
single exit from "break"'

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
