Received: from eggs.gnu.org ([2001:4830:134:3::10]:51741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3g09-0006ti-Ie
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3g04-0006Mw-UR
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:50:49 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3g04-0006LF-Mr
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:50:44 -0400
Received: by mail-wr0-x242.google.com with SMTP id s18so21848652wrg.9
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:50:44 -0700 (PDT)
References: <1521034084-17344-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1521034084-17344-2-git-send-email-abdallah.bouassida@lauterbach.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1521034084-17344-2-git-send-email-abdallah.bouassida@lauterbach.com>
Date: Wed, 04 Apr 2018 11:50:42 +0100
Message-ID: <87k1tnckjh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 1/3] target/arm: Add
 "ARM_CP_NO_GDB" as a new bit field for ARMCPRegInfo type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, khaled.jmal@lauterbach.com, qemu-arm@nongnu.org


Abdallah Bouassida <abdallah.bouassida@lauterbach.com> writes:

> This is a preparation for the coming feature of creating dynamically an X=
ML
> description for the ARM sysregs.
> A register has ARM_CP_NO_GDB enabled will not be shown in the dynamic XML.
> This bit is enabled automatically when creating CP_ANY wildcard aliases.
> This bit could be enabled manually for any register we want to remove fro=
m the
> dynamic XML description.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h    | 3 ++-
>  target/arm/helper.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 1e7e1f8..5a6ea24 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1815,10 +1815,11 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t c=
pregid)
>  #define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
>  #define ARM_CP_FPU               0x1000
>  #define ARM_CP_SVE               0x2000
> +#define ARM_CP_NO_GDB            0x4000
>  /* Used only as a terminator for ARMCPRegInfo lists */
>  #define ARM_CP_SENTINEL          0xffff
>  /* Mask of only the flag bits in a type field */
> -#define ARM_CP_FLAG_MASK         0x30ff
> +#define ARM_CP_FLAG_MASK         0x70ff
>
>  /* Valid values for ARMCPRegInfo state field, indicating which of
>   * the AArch32 and AArch64 execution states this register is visible in.
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 09893e3..db8c925 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5664,7 +5664,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, con=
st ARMCPRegInfo *r,
>      if (((r->crm =3D=3D CP_ANY) && crm !=3D 0) ||
>          ((r->opc1 =3D=3D CP_ANY) && opc1 !=3D 0) ||
>          ((r->opc2 =3D=3D CP_ANY) && opc2 !=3D 0)) {
> -        r2->type |=3D ARM_CP_ALIAS;
> +        r2->type |=3D ARM_CP_ALIAS | ARM_CP_NO_GDB;
>      }
>
>      /* Check that raw accesses are either forbidden or handled. Note that


--
Alex Benn=C3=A9e
