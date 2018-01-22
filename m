Received: from eggs.gnu.org ([2001:4830:134:3::10]:53061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edaqq-00055J-WE
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edaqn-0000kt-GB
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:05:24 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edaqn-0000jy-6Q
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:05:21 -0500
Received: by mail-wm0-x244.google.com with SMTP id b21so16328540wme.4
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 04:05:21 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-11-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-11-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 12:05:18 +0000
Message-ID: <87tvvejdz5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/16] target/arm: Add ARM_FEATURE_SVE
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

> Not enabled anywhere so far.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 132da359b5..0a923e42d8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1371,6 +1371,7 @@ enum arm_features {
>      ARM_FEATURE_VBAR, /* has cp15 VBAR */
>      ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
>      ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
> +    ARM_FEATURE_SVE, /* has Scalable Vector Extension */
>  };
>
>  static inline int arm_feature(CPUARMState *env, int feature)


--
Alex Benn=C3=A9e
