Received: from eggs.gnu.org ([2001:4830:134:3::10]:42551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbh5d-0006UW-Pu
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbh5a-0007QY-LK
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:16:17 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbh5a-0007QP-HK
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:16:14 -0500
Received: by mail-qt0-x243.google.com with SMTP id h53so26049982qth.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 21:16:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170209045154.16868-1-rth@twiddle.net>
	<20170209045154.16868-15-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <825ead35-bcdf-89a0-e90c-d2122d608294@gmail.com>
Date: Thu, 9 Feb 2017 02:16:11 -0300
MIME-Version: 1.0
In-Reply-To: <20170209045154.16868-15-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/22] target/openrisc: Set flags on helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, shorne@gmail.com



On 02/09/2017 01:51 AM, Richard Henderson wrote:
> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/helper.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
> index f4d97a2..78a123d 100644
> --- a/target/openrisc/helper.h
> +++ b/target/openrisc/helper.h
> @@ -18,26 +18,26 @@
>   */
>
>  /* exception */
> -DEF_HELPER_FLAGS_2(exception, 0, void, env, i32)
> +DEF_HELPER_FLAGS_2(exception, TCG_CALL_NO_WG, void, env, i32)
>  DEF_HELPER_FLAGS_1(ove_cy, TCG_CALL_NO_WG, void, env)
>  DEF_HELPER_FLAGS_1(ove_ov, TCG_CALL_NO_WG, void, env)
>  DEF_HELPER_FLAGS_1(ove_cyov, TCG_CALL_NO_WG, void, env)
>
>  /* float */
> -DEF_HELPER_FLAGS_2(itofd, 0, i64, env, i64)
> -DEF_HELPER_FLAGS_2(itofs, 0, i32, env, i32)
> -DEF_HELPER_FLAGS_2(ftoid, 0, i64, env, i64)
> -DEF_HELPER_FLAGS_2(ftois, 0, i32, env, i32)
> +DEF_HELPER_FLAGS_2(itofd, TCG_CALL_NO_WG, i64, env, i64)
> +DEF_HELPER_FLAGS_2(itofs, TCG_CALL_NO_WG, i32, env, i32)
> +DEF_HELPER_FLAGS_2(ftoid, TCG_CALL_NO_WG, i64, env, i64)
> +DEF_HELPER_FLAGS_2(ftois, TCG_CALL_NO_WG, i32, env, i32)
>
>  #define FOP_MADD(op)                                             \
> -DEF_HELPER_FLAGS_3(float_ ## op ## _s, 0, i32, env, i32, i32)    \
> -DEF_HELPER_FLAGS_3(float_ ## op ## _d, 0, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
> +DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
>  FOP_MADD(muladd)
>  #undef FOP_MADD
>
>  #define FOP_CALC(op)                                            \
> -DEF_HELPER_FLAGS_3(float_ ## op ## _s, 0, i32, env, i32, i32)    \
> -DEF_HELPER_FLAGS_3(float_ ## op ## _d, 0, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
> +DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
>  FOP_CALC(add)
>  FOP_CALC(sub)
>  FOP_CALC(mul)
> @@ -46,8 +46,8 @@ FOP_CALC(rem)
>  #undef FOP_CALC
>
>  #define FOP_CMP(op)                                              \
> -DEF_HELPER_FLAGS_3(float_ ## op ## _s, 0, i32, env, i32, i32)    \
> -DEF_HELPER_FLAGS_3(float_ ## op ## _d, 0, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
> +DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
>  FOP_CMP(eq)
>  FOP_CMP(lt)
>  FOP_CMP(le)
> @@ -61,4 +61,4 @@ DEF_HELPER_FLAGS_1(rfe, 0, void, env)
>
>  /* sys */
>  DEF_HELPER_FLAGS_4(mtspr, 0, void, env, tl, tl, tl)
> -DEF_HELPER_FLAGS_4(mfspr, 0, tl, env, tl, tl, tl)
> +DEF_HELPER_FLAGS_4(mfspr, TCG_CALL_NO_WG, tl, env, tl, tl, tl)
>
