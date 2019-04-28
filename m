Received: from eggs.gnu.org ([209.51.188.92]:33271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKlDj-00070i-Sf
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKlDi-0003Vp-MN
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:55:59 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:35306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hKlDi-0003VO-FL
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:55:58 -0400
Received: by mail-ot1-x32b.google.com with SMTP id g24so1943569otq.2
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 07:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190426182210.10442-1-richard.henderson@linaro.org>
In-Reply-To: <20190426182210.10442-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Apr 2019 15:55:45 +0100
Message-ID: <CAFEAcA8BwY07Z9NdnVy=FS78kEYzQgw8AzU=7g+w3kOtBtKCgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] target/hppa patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 26 Apr 2019 at 19:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999=
b6:
>
>   Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22'=
 into staging (2019-04-24 13:19:41 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-hppa-20190426
>
> for you to fetch changes up to 647ad90a1eb6c016071d21e4f1e22b9cd4986417:
>
>   target/hppa: Always return EXCP_DMAR for protection id trap (2019-04-26=
 11:09:22 -0700)
>
> ----------------------------------------------------------------
> Implement fast tlb insert insns.
> Fix data tlb exception for pa 1.1.
>
> ----------------------------------------------------------------

Hi; this doesn't seem to build:

/home/pm215/qemu/target/hppa/translate.c: In function =E2=80=98trans_ixtlbx=
f=E2=80=99:
/home/pm215/qemu/target/hppa/translate.c:2544:5: error: too many
arguments to function =E2=80=98tcg_temp_new_i64=E2=80=99
     atl =3D tcg_temp_new_tl(ctx);
     ^
In file included from /home/pm215/qemu/tcg/tcg-op.h:28:0,
                 from /home/pm215/qemu/target/hppa/translate.c:25:
/home/pm215/qemu/tcg/tcg.h:975:24: note: declared here
 static inline TCGv_i64 tcg_temp_new_i64(void)
                        ^
/home/pm215/qemu/target/hppa/translate.c:2545:5: error: too many
arguments to function =E2=80=98tcg_temp_new_i64=E2=80=99
     stl =3D tcg_temp_new_tl(ctx);
     ^
In file included from /home/pm215/qemu/tcg/tcg-op.h:28:0,
                 from /home/pm215/qemu/target/hppa/translate.c:25:
/home/pm215/qemu/tcg/tcg.h:975:24: note: declared here
 static inline TCGv_i64 tcg_temp_new_i64(void)
                        ^
/home/pm215/qemu/target/hppa/translate.c:2546:5: error: too many
arguments to function =E2=80=98tcg_temp_new_i64=E2=80=99
     addr =3D tcg_temp_new_tl(ctx);
     ^
In file included from /home/pm215/qemu/tcg/tcg-op.h:28:0,
                 from /home/pm215/qemu/target/hppa/translate.c:25:
/home/pm215/qemu/tcg/tcg.h:975:24: note: declared here
 static inline TCGv_i64 tcg_temp_new_i64(void)
                        ^

(maybe a conflict with your other pullreq I just applied?)

thanks
-- PMM
