Received: from eggs.gnu.org ([2001:4830:134:3::10]:52831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eReFi-0002q1-AG
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eReFh-00039z-CD
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:17:42 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171220130815.20708-1-laurent@vivier.eu>
References: <20171220130815.20708-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 20 Dec 2017 10:17:40 -0300
Message-ID: <CAAdtpL6byoHzPmYOJexD33SrJszK0s6neqgo=PxXfK92X4w5Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] target/m68k: remove unused
 variable gen_throws_exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On Wed, Dec 20, 2017 at 10:08 AM, Laurent Vivier <laurent@vivier.eu> wrote:
> It has been introduced by e6e5906b6e ("ColdFire target."),
> but the content is never used.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/m68k/translate.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index b60909222c..dfb2d5dad2 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -181,11 +181,6 @@ static void do_writebacks(DisasContext *s)
>  #define IS_USER(s) s->user
>  #endif
>
> -/* XXX: move that elsewhere */
> -/* ??? Fix exceptions.  */
> -static void *gen_throws_exception;
> -#define gen_last_qop NULL
> -
>  typedef void (*disas_proc)(CPUM68KState *env, DisasContext *s, uint16_t =
insn);
>
>  #ifdef DEBUG_DISPATCH
> @@ -310,7 +305,6 @@ static inline TCGv gen_load(DisasContext * s, int ops=
ize, TCGv addr, int sign)
>      default:
>          g_assert_not_reached();
>      }
> -    gen_throws_exception =3D gen_last_qop;
>      return tmp;
>  }
>
> @@ -331,7 +325,6 @@ static inline void gen_store(DisasContext *s, int ops=
ize, TCGv addr, TCGv val)
>      default:
>          g_assert_not_reached();
>      }
> -    gen_throws_exception =3D gen_last_qop;
>  }
>
>  typedef enum {
> @@ -1001,7 +994,6 @@ static void gen_load_fp(DisasContext *s, int opsize,=
 TCGv addr, TCGv_ptr fp)
>      }
>      tcg_temp_free(tmp);
>      tcg_temp_free_i64(t64);
> -    gen_throws_exception =3D gen_last_qop;
>  }
>
>  static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_pt=
r fp)
> @@ -1056,7 +1048,6 @@ static void gen_store_fp(DisasContext *s, int opsiz=
e, TCGv addr, TCGv_ptr fp)
>      }
>      tcg_temp_free(tmp);
>      tcg_temp_free_i64(t64);
> -    gen_throws_exception =3D gen_last_qop;
>  }
>
>  static void gen_ldst_fp(DisasContext *s, int opsize, TCGv addr,
> @@ -5561,7 +5552,6 @@ void gen_intermediate_code(CPUState *cs, Translatio=
nBlock *tb)
>      gen_tb_start(tb);
>      do {
>          pc_offset =3D dc->pc - pc_start;
> -        gen_throws_exception =3D NULL;
>          tcg_gen_insn_start(dc->pc, dc->cc_op);
>          num_insns++;
>
> --
> 2.14.3
>
>
