Received: from eggs.gnu.org ([2001:4830:134:3::10]:45072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gPsU5-0007l9-IM
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gPsU1-00051S-4J
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:09:45 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gPsU0-00050W-U0
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:09:41 -0500
Received: by mail-wr1-x42b.google.com with SMTP id j10so9932925wru.4
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 09:09:40 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-12-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-12-cota@braap.org>
Date: Thu, 22 Nov 2018 17:09:38 +0000
Message-ID: <8736rthwdp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 11/48] atomic_template: fix indentation in
 GEN_ATOMIC_HELPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/atomic_template.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> index efde12fdb2..8d177fefef 100644
> --- a/accel/tcg/atomic_template.h
> +++ b/accel/tcg/atomic_template.h
> @@ -284,7 +284,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_=
ulong addr,
>
>  #define GEN_ATOMIC_HELPER(X)                                        \
>  ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
> -                 ABI_TYPE val EXTRA_ARGS)                           \
> +                        ABI_TYPE val EXTRA_ARGS)                    \
>  {                                                                   \
>      ATOMIC_MMU_DECLS;                                               \
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;                           \


--
Alex Benn=C3=A9e
