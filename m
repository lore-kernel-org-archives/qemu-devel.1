Received: from eggs.gnu.org ([2001:4830:134:3::10]:48677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQ7H-0005Cl-9q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQ7G-0006RF-E1
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:35 -0400
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-28-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-28-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 03:52:26 -0700
Message-ID: <CAJ+F1CKN2UUrEzq2Ut+HWWgFnYtuZ8opOF5TF5GqM-289UKLGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 27/29] tests/hbitmap: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu trival <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, QEMU <qemu-devel@nongnu.org>

On Mon, Jul 17, 2017 at 11:10 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/test-hbitmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
> index 1acb353889..628e72122b 100644
> --- a/tests/test-hbitmap.c
> +++ b/tests/test-hbitmap.c
> @@ -813,7 +813,7 @@ static void test_hbitmap_serialize_basic(TestHBitmapD=
ata *data,
>      size_t buf_size;
>      uint8_t *buf;
>      uint64_t positions[] =3D { 0, 1, L1 - 1, L1, L2 - 1, L2, L2 + 1, L3 =
- 1 };
> -    int num_positions =3D sizeof(positions) / sizeof(positions[0]);
> +    int num_positions =3D ARRAY_SIZE(positions);
>
>      hbitmap_test_init(data, L3, 0);
>      g_assert(hbitmap_is_serializable(data->hb));
> @@ -838,7 +838,7 @@ static void test_hbitmap_serialize_part(TestHBitmapDa=
ta *data,
>      size_t buf_size;
>      uint8_t *buf;
>      uint64_t positions[] =3D { 0, 1, L1 - 1, L1, L2 - 1, L2, L2 + 1, L3 =
- 1 };
> -    int num_positions =3D sizeof(positions) / sizeof(positions[0]);
> +    int num_positions =3D ARRAY_SIZE(positions);
>
>      hbitmap_test_init(data, L3, 0);
>      buf_size =3D L2;
> @@ -880,7 +880,7 @@ static void test_hbitmap_serialize_zeroes(TestHBitmap=
Data *data,
>      int64_t next;
>      uint64_t min_l1 =3D MAX(L1, 64);
>      uint64_t positions[] =3D { 0, min_l1, L2, L3 - min_l1};
> -    int num_positions =3D sizeof(positions) / sizeof(positions[0]);
> +    int num_positions =3D ARRAY_SIZE(positions);
>
>      hbitmap_test_init(data, L3, 0);
>
> --
> 2.13.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
