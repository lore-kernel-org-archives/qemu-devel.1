Received: from eggs.gnu.org ([2001:4830:134:3::10]:47971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPm8q-0005fp-9f
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPm8n-00083n-8n
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:46:36 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:34442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPm8n-00083B-1a
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:46:33 -0400
Received: by mail-wm0-x236.google.com with SMTP id t129so4143376wmt.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 01:46:32 -0700 (PDT)
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-8-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170621024831.26019-8-rth@twiddle.net>
Date: Tue, 27 Jun 2017 09:47:22 +0100
Message-ID: <87wp7xx1et.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/16] tcg: Return NULL temp for
 TCG_CALL_DUMMY_ARG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net


Richard Henderson <rth@twiddle.net> writes:

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/tcg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 3b35344..6c357e7 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -730,7 +730,7 @@ extern bool parallel_cpus;
>
>  static inline TCGTemp *arg_temp(TCGArg a)
>  {
> -    return &tcg_ctx.temps[a];
> +    return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
>  }

It doesn't look like a lot of calls to arg_temp are able to deal with a
NULL return and may well immediately deref the value. Are we sure the
cases the TCG_CALL_DUMMY arg is involved are narrowly defined?

>
>  static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)


--
Alex Bennée
