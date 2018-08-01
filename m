Received: from eggs.gnu.org ([2001:4830:134:3::10]:47618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkrQL-0004aK-Hg
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkrQG-00052y-HG
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:44:21 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fkrQG-00051L-7Q
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:44:16 -0400
Received: by mail-wm0-x242.google.com with SMTP id r24-v6so13867415wmh.0
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 06:44:14 -0700 (PDT)
References: <20180801123111.3595-1-richard.henderson@linaro.org>
	<20180801123111.3595-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180801123111.3595-5-richard.henderson@linaro.org>
Date: Wed, 01 Aug 2018 14:44:12 +0100
Message-ID: <87pnz28amr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/4] target/arm: Fix typo in
 helper_sve_movz_d
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/sve_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 87594a8adb..c3cbec9cf5 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1042,7 +1042,7 @@ void HELPER(sve_movz_d)(void *vd, void *vn, void *v=
g, uint32_t desc)
>      uint64_t *d =3D vd, *n =3D vn;
>      uint8_t *pg =3D vg;
>      for (i =3D 0; i < opr_sz; i +=3D 1) {
> -        d[i] =3D n[1] & -(uint64_t)(pg[H1(i)] & 1);
> +        d[i] =3D n[i] & -(uint64_t)(pg[H1(i)] & 1);
>      }
>  }


--
Alex Benn=C3=A9e
