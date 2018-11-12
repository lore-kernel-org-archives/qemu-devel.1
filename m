Received: from eggs.gnu.org ([2001:4830:134:3::10]:36628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMAAB-0007hA-QN
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMAA7-0005pY-NY
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:13:51 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMAA7-0005o9-CY
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:13:47 -0500
Received: by mail-wm1-x343.google.com with SMTP id u13-v6so7728103wmc.4
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 03:13:46 -0800 (PST)
References: <20181110121711.15257-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181110121711.15257-1-richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 11:13:44 +0000
Message-ID: <87muqeeefr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-3.1] target/arm: Fix typo in
 tlbi_aa64_vmalle1_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This would cause an infinite recursion or loop.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I feel the title undersells the importance of the fix ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 96301930cc..a327988c66 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3155,7 +3155,7 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *en=
v, const ARMCPRegInfo *ri,
>      CPUState *cs =3D ENV_GET_CPU(env);
>
>      if (tlb_force_broadcast(env)) {
> -        tlbi_aa64_vmalle1_write(env, NULL, value);
> +        tlbi_aa64_vmalle1is_write(env, NULL, value);
>          return;
>      }


--
Alex Benn=C3=A9e
