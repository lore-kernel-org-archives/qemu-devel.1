Received: from eggs.gnu.org ([2001:4830:134:3::10]:48338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkrRt-0005hg-L1
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkrRo-0005ha-PC
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:45:57 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fkrRo-0005gz-Iq
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:45:52 -0400
Received: by mail-wm0-x22f.google.com with SMTP id o18-v6so7176999wmc.0
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 06:45:52 -0700 (PDT)
References: <20180801123111.3595-1-richard.henderson@linaro.org>
	<20180801123111.3595-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180801123111.3595-2-richard.henderson@linaro.org>
Date: Wed, 01 Aug 2018 14:45:50 +0100
Message-ID: <87o9em8ak1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/4] target/arm: Fix sign of
 sve_cmpeq_ppzw/sve_cmpne_ppzw
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

> The normal vector element is sign-extended before
> comparing with the wide vector element.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/sve_helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 54795c9194..9bd0694d55 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2436,13 +2436,13 @@ uint32_t HELPER(NAME)(void *vd, void *vn, void *v=
m, void *vg, uint32_t desc) \
>  #define DO_CMP_PPZW_S(NAME, TYPE, TYPEW, OP) \
>      DO_CMP_PPZW(NAME, TYPE, TYPEW, OP, H1_4, 0x1111111111111111ull)
>
> -DO_CMP_PPZW_B(sve_cmpeq_ppzw_b, uint8_t,  uint64_t, =3D=3D)
> -DO_CMP_PPZW_H(sve_cmpeq_ppzw_h, uint16_t, uint64_t, =3D=3D)
> -DO_CMP_PPZW_S(sve_cmpeq_ppzw_s, uint32_t, uint64_t, =3D=3D)
> +DO_CMP_PPZW_B(sve_cmpeq_ppzw_b, int8_t,  uint64_t, =3D=3D)
> +DO_CMP_PPZW_H(sve_cmpeq_ppzw_h, int16_t, uint64_t, =3D=3D)
> +DO_CMP_PPZW_S(sve_cmpeq_ppzw_s, int32_t, uint64_t, =3D=3D)
>
> -DO_CMP_PPZW_B(sve_cmpne_ppzw_b, uint8_t,  uint64_t, !=3D)
> -DO_CMP_PPZW_H(sve_cmpne_ppzw_h, uint16_t, uint64_t, !=3D)
> -DO_CMP_PPZW_S(sve_cmpne_ppzw_s, uint32_t, uint64_t, !=3D)
> +DO_CMP_PPZW_B(sve_cmpne_ppzw_b, int8_t,  uint64_t, !=3D)
> +DO_CMP_PPZW_H(sve_cmpne_ppzw_h, int16_t, uint64_t, !=3D)
> +DO_CMP_PPZW_S(sve_cmpne_ppzw_s, int32_t, uint64_t, !=3D)
>
>  DO_CMP_PPZW_B(sve_cmpgt_ppzw_b, int8_t,   int64_t, >)
>  DO_CMP_PPZW_H(sve_cmpgt_ppzw_h, int16_t,  int64_t, >)


--
Alex Benn=C3=A9e
