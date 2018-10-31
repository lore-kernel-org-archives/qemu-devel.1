Received: from eggs.gnu.org ([2001:4830:134:3::10]:37529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHou1-0002ki-C7
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHotw-0002Zm-MT
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:43:13 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHotw-0002Yx-D1
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:43:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id r63-v6so14816866wma.4
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 04:43:08 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-10-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-10-cota@braap.org>
Date: Wed, 31 Oct 2018 11:43:05 +0000
Message-ID: <87in1i8hpy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 10/71] hppa: convert to
 helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/hppa/translate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index ce05d5619d..df9179e70f 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2845,8 +2845,7 @@ static DisasJumpType trans_pause(DisasContext *ctx,=
 uint32_t insn,
>
>      /* Tell the qemu main loop to halt until this cpu has work.  */
>      tmp =3D tcg_const_i32(1);
> -    tcg_gen_st_i32(tmp, cpu_env, -offsetof(HPPACPU, env) +
> -                                 offsetof(CPUState, halted));
> +    gen_helper_cpu_halted_set(cpu_env, tmp);
>      tcg_temp_free_i32(tmp);
>      gen_excp_1(EXCP_HALTED);


--
Alex Benn=C3=A9e
