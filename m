Received: from eggs.gnu.org ([2001:4830:134:3::10]:53362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJdt-00006p-VS
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJdq-0003L9-SQ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:33:33 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVJdq-0003K6-Lm
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:33:30 -0400
Received: by mail-wr0-x22b.google.com with SMTP id k67so38213237wrc.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:33:30 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-19-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-19-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 16:33:27 +0100
Message-ID: <878tjt8ybc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/22] tcg: define TCG_HIGHWATER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Will come in handy very soon.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg/tcg.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index c19c473..2f003a0 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -115,6 +115,8 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
>  static void tcg_out_tb_init(TCGContext *s);
>  static bool tcg_out_tb_finalize(TCGContext *s);
>
> +#define TCG_HIGHWATER 1024
> +
>  static QemuMutex tcg_lock;
>
>  /*
> @@ -453,7 +455,7 @@ void tcg_prologue_init(TCGContext *s)
>      /* Compute a high-water mark, at which we voluntarily flush the buffer
>         and start over.  The size here is arbitrary, significantly larger
>         than we expect the code generation for any one opcode to require.  */
> -    s->code_gen_highwater = s->code_gen_buffer + (total_size - 1024);
> +    s->code_gen_highwater = s->code_gen_buffer + (total_size - TCG_HIGHWATER);
>
>      tcg_register_jit(s->code_gen_buffer, total_size);


--
Alex Bennée
