Received: from eggs.gnu.org ([2001:4830:134:3::10]:59904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPn0G-0002gQ-00
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPn0C-0002pW-Qr
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:41:48 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPn0C-0002pA-Js
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:41:44 -0400
Received: by mail-wm0-x234.google.com with SMTP id 62so19329905wmw.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 02:41:44 -0700 (PDT)
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-13-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170621024831.26019-13-rth@twiddle.net>
Date: Tue, 27 Jun 2017 10:42:34 +0100
Message-ID: <87shilwyut.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/16] tcg: Remove unused
 TCG_CALL_DUMMY_TCGV
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg/tcg.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 1eeeca5..4f69d0c 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -503,7 +503,6 @@ static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
>  #define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)
>
>  /* used to align parameters */
> -#define TCG_CALL_DUMMY_TCGV     MAKE_TCGV_I32(-1)
>  #define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
>
>  /* Conditions.  Note that these are laid out for easy manipulation by


--
Alex Bennée
