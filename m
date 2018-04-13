Received: from eggs.gnu.org ([2001:4830:134:3::10]:33031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70Ez-0005Vg-5p
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70Ey-0005WH-88
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:03:53 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f70Ey-0005Vm-1U
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:03:52 -0400
Received: by mail-ot0-x241.google.com with SMTP id f47-v6so10199469oth.2
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 08:03:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180406151752.10854-5-christophe.lyon@st.com>
References: <20180406151752.10854-1-christophe.lyon@st.com>
	<20180406151752.10854-5-christophe.lyon@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 16:03:30 +0100
Message-ID: <CAFEAcA8MHx0cPhhNAj_HwgmDL0DG9koNSZ-6Ob17A8u2=girZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ARM/FDPIC 4/4] linux-user: ARM-FDPIC: Add arm get
 tls syscall support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>

On 6 April 2018 at 16:17, Christophe Lyon <christophe.lyon@st.com> wrote:
> Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
> Signed-off-by: Christophe Lyon <christophe.lyon@st.com>
>
> diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_sysc=
all.h
> index 94e2a42..afc0772 100644
> --- a/linux-user/arm/target_syscall.h
> +++ b/linux-user/arm/target_syscall.h
> @@ -16,6 +16,7 @@ struct target_pt_regs {
>  #define ARM_NR_breakpoint (ARM_NR_BASE + 1)
>  #define ARM_NR_cacheflush (ARM_NR_BASE + 2)
>  #define ARM_NR_set_tls   (ARM_NR_BASE + 5)
> +#define ARM_NR_get_tls    (ARM_NR_BASE + 6)
>
>  #define ARM_NR_semihosting       0x123456
>  #define ARM_NR_thumb_semihosting  0xAB
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 00810d6..1814578 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -720,6 +720,9 @@ void cpu_loop(CPUARMState *env)
>                          case ARM_NR_breakpoint:
>                              env->regs[15] -=3D env->thumb ? 2 : 4;
>                              goto excp_debug;
> +                        case ARM_NR_get_tls:
> +                            env->regs[0] =3D cpu_get_tls(env);
> +                            break;
>                          default:
>                              gemu_log("qemu: Unsupported ARM syscall: 0x%=
x\n",
>                                       n);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

This is a bug fix unrelated to FDPIC, I think.

thanks
-- PMM
