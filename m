Received: from eggs.gnu.org ([2001:4830:134:3::10]:40369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsUug-0003F9-8o
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsUua-00070g-Cb
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:19:14 -0400
References: <20180822144039.5796-1-pavel.zbitskiy@gmail.com>
	<20180822144039.5796-2-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aaf7a5b1-4143-b209-9626-ce1309fb628b@redhat.com>
Date: Wed, 22 Aug 2018 17:19:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180822144039.5796-2-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] target/s390x: use regular spaces in
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, richard.henderson@linaro.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 22.08.2018 16:40, Pavel Zbitskiy wrote:
> In a few places translate.c contains non-breaking spaces (0xc2 0xa0)
> instead of regular ones (0x20):
>=20
>   7c 7c c2 a0 63 63
>   7c 7c 20    63 63
>   |  |        c  c
>=20
> This confuses some text editors.
>=20
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 40e12ca2c4..7363aabf3a 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -842,7 +842,7 @@ static void disas_jcc(DisasContext *s, DisasCompare=
 *c, uint32_t mask)
>              cond =3D TCG_COND_NE;
>              c->u.s32.b =3D tcg_const_i32(1);
>              break;
> -        case 0x8 | 0x2: /* cc =3D=3D 0 ||=C2=A0cc =3D=3D 2 =3D> (cc & =
1) =3D=3D 0 */
> +        case 0x8 | 0x2: /* cc =3D=3D 0 || cc =3D=3D 2 =3D> (cc & 1) =3D=
=3D 0 */
>              cond =3D TCG_COND_EQ;
>              c->g1 =3D false;
>              c->u.s32.a =3D tcg_temp_new_i32();
> @@ -861,7 +861,7 @@ static void disas_jcc(DisasContext *s, DisasCompare=
 *c, uint32_t mask)
>              cond =3D TCG_COND_NE;
>              c->u.s32.b =3D tcg_const_i32(0);
>              break;
> -        case 0x4 | 0x1: /* cc =3D=3D 1 ||=C2=A0cc =3D=3D 3 =3D> (cc & =
1) !=3D 0 */
> +        case 0x4 | 0x1: /* cc =3D=3D 1 || cc =3D=3D 3 =3D> (cc & 1) !=3D=
 0 */
>              cond =3D TCG_COND_NE;
>              c->g1 =3D false;
>              c->u.s32.a =3D tcg_temp_new_i32();
>=20

(can't spot a difference in my mail editor ;) )

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb
