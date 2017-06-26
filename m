Received: from eggs.gnu.org ([2001:4830:134:3::10]:40687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPTGg-0000iD-Ex
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPTGb-0002En-Il
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:37:26 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:55899 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPTGb-0002Eg-6N
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:37:21 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149838046604.6497.6648018844505723967.stgit@frigg.lan>
	<20170626100422.6390-1-alex.bennee@linaro.org>
Date: Mon, 26 Jun 2017 15:37:10 +0300
In-Reply-To: <20170626100422.6390-1-alex.bennee@linaro.org> ("Alex
	=?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Mon, 26 Jun 2017 11:04:22 +0100")
Message-ID: <8737an9b7t.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fixup! Pass generic CPUState to
 gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>, qemu-devel@nongnu.org, Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>

Alex Benn=C3=A9e writes:

> ---
>  target/hppa/translate.c     | 5 ++---
>  target/nios2/translate.c    | 5 ++---
>  target/openrisc/translate.c | 3 +--
>  3 files changed, 5 insertions(+), 8 deletions(-)

I rebased the patches and forgot to test the compilation of other
architectures. Sorry about that.

Thanks,
  Lluis



> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index e10abc5e04..900870cd5a 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3740,10 +3740,9 @@ static ExitStatus translate_one(DisasContext *ctx,=
 uint32_t insn)
>      return gen_illegal(ctx);
>  }
=20
> -void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *t=
b)
> +void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
>  {
> -    HPPACPU *cpu =3D hppa_env_get_cpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUHPPAState *env =3D cs->env_ptr;
>      DisasContext ctx;
>      ExitStatus ret;
>      int num_insns, max_insns, i;
> diff --git a/target/nios2/translate.c b/target/nios2/translate.c
> index 2f3c2e5dfb..8b97d6585f 100644
> --- a/target/nios2/translate.c
> +++ b/target/nios2/translate.c
> @@ -799,10 +799,9 @@ static void gen_exception(DisasContext *dc, uint32_t=
 excp)
>  }
=20
>  /* generate intermediate code for basic block 'tb'.  */
> -void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
> +void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>  {
> -    Nios2CPU *cpu =3D nios2_env_get_cpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUNios2State *env =3D cs->env_ptr;
>      DisasContext dc1, *dc =3D &dc1;
>      int num_insns;
>      int max_insns;
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index aaac359d5b..4a28c96e53 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -1520,9 +1520,8 @@ static void disas_openrisc_insn(DisasContext *dc, O=
penRISCCPU *cpu)
=20
>  void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
>  {
> -    OpenRISCState *env =3D cpu->env_ptr;
> +    CPUOpenRISCState *env =3D cpu->env_ptr;
>      OpenRISCCPU *or_cpu =3D openrisc_env_get_cpu(env);
> -    CPUState *cs =3D CPU(cpu);
>      struct DisasContext ctx, *dc =3D &ctx;
>      uint32_t pc_start;
>      uint32_t next_page_start;
> --=20
> 2.13.0
