Received: from eggs.gnu.org ([2001:4830:134:3::10]:50807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEIBn-0002cG-54
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEIBj-0002bh-0K
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:06:27 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:55026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eEIBi-0002bJ-QD
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:06:22 -0500
Received: by mail-wr0-x241.google.com with SMTP id l22so15024108wrc.11
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:06:22 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-9-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171004184325.24157-9-richard.henderson@linaro.org>
Date: Mon, 13 Nov 2017 17:06:20 +0000
Message-ID: <87po8m9khf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 08/12] target/arm: Add
 ARM_FEATURE_V8_FCMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

As per previous nit about slightly more expansive commit comment.
Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h     | 1 +
>  linux-user/elfload.c | 1 +
>  target/arm/cpu.c     | 1 +
>  target/arm/cpu64.c   | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index c5c9cef834..fdf72534d0 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1313,6 +1313,7 @@ enum arm_features {
>      ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
>      ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
>      ARM_FEATURE_V8_1_SIMD, /* has ARMv8.1-SIMD */
> +    ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions. =
 */
>  };
>
>  static inline int arm_feature(CPUARMState *env, int feature)
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 003d9420b7..788e46229b 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -541,6 +541,7 @@ static uint32_t get_elf_hwcap(void)
>      GET_FEATURE(ARM_FEATURE_V8_SHA256, ARM_HWCAP_A64_SHA2);
>      GET_FEATURE(ARM_FEATURE_CRC, ARM_HWCAP_A64_CRC32);
>      GET_FEATURE(ARM_FEATURE_V8_1_SIMD, ARM_HWCAP_A64_ASIMDRDM);
> +    GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
>  #undef GET_FEATURE
>
>      return hwcaps;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 276c996e9f..722d2806a7 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1604,6 +1604,7 @@ static void arm_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
>      set_feature(&cpu->env, ARM_FEATURE_V8_1_SIMD);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
>      cpu->midr =3D 0xffffffff;
>  }
>  #endif
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index b05c904ad2..96320ac0d6 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -227,6 +227,7 @@ static void aarch64_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
>      set_feature(&cpu->env, ARM_FEATURE_V8_1_SIMD);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
>      cpu->ctr =3D 0x80038003; /* 32 byte I and D cacheline size, VIPT ica=
che */
>      cpu->dcz_blocksize =3D 7; /*  512 bytes */
>  }


--
Alex Benn=C3=A9e
