Received: from eggs.gnu.org ([2001:4830:134:3::10]:50691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ecX7t-00022w-77
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ecX7o-0002FK-H4
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:54:37 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ecX7o-0002Eq-9w
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:54:32 -0500
Received: by mail-wm0-x244.google.com with SMTP id v71so3726550wmv.2
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 05:54:31 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-2-richard.henderson@linaro.org>
Date: Fri, 19 Jan 2018 13:54:29 +0000
Message-ID: <87mv1anecq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/16] target/arm: Mark
 disas_set_insn_syndrome inline
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

> If it isn't used when translate.h is included,
> we'll get a compiler Werror.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index cd7313ace7..3f4df91e5e 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -108,7 +108,7 @@ static inline int default_exception_el(DisasContext *=
s)
>              ? 3 : MAX(1, s->current_el);
>  }
>
> -static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
> +static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
>  {
>      /* We don't need to save all of the syndrome so we mask and shift
>       * out unneeded bits to help the sleb128 encoder do a better job.


--
Alex Benn=C3=A9e
