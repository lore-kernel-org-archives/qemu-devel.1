Received: from eggs.gnu.org ([2001:4830:134:3::10]:37354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIXLD-0005Vd-MD
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIXLA-00039I-7p
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:37:57 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIXLA-00038l-0Y
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:37:56 -0400
Received: by mail-wm0-x243.google.com with SMTP id j5-v6so103257wme.5
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:37:55 -0700 (PDT)
References: <20180512003217.9105-1-richard.henderson@linaro.org>
	<20180512003217.9105-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180512003217.9105-3-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 11:37:53 +0100
Message-ID: <87vabpfblq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/11] target/arm: Early exit after
 unallocated_encoding in disas_fp_int_conv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> No sense in emitting code after the exception.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 5b8cf75e9f..11d8c07943 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5780,7 +5780,7 @@ static void disas_fp_int_conv(DisasContext *s, uint=
32_t insn)
>          default:
>              /* all other sf/type/rmode combinations are invalid */
>              unallocated_encoding(s);
> -            break;
> +            return;
>          }
>
>          if (!fp_access_check(s)) {


--
Alex Benn=C3=A9e
