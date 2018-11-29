Received: from eggs.gnu.org ([2001:4830:134:3::10]:45111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSLoN-0007u8-Rb
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSLoI-0005UH-Qw
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:52:55 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gSLoI-0005U4-KF
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:52:50 -0500
Received: by mail-wm1-x341.google.com with SMTP id k198so2121163wmd.3
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 04:52:50 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123144558.5048-3-richard.henderson@linaro.org>
Date: Thu, 29 Nov 2018 12:52:47 +0000
Message-ID: <871s743v1c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 02/37] tcg/i386: Move
 TCG_REG_CALL_STACK from define to enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/i386/tcg-target.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 7488c3d869..2441658865 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -86,10 +86,10 @@ typedef enum {
>      TCG_REG_RDI =3D TCG_REG_EDI,
>
>      TCG_AREG0 =3D TCG_REG_EBP,
> +    TCG_REG_CALL_STACK =3D TCG_REG_ESP
>  } TCGReg;
>
>  /* used for function call generation */
> -#define TCG_REG_CALL_STACK TCG_REG_ESP
>  #define TCG_TARGET_STACK_ALIGN 16
>  #if defined(_WIN64)
>  #define TCG_TARGET_CALL_STACK_OFFSET 32


--
Alex Benn=C3=A9e
