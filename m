Received: from eggs.gnu.org ([2001:4830:134:3::10]:32875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOmGS-0004qQ-Ej
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOmGP-0007zI-RA
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:14:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eOmGP-0007yu-Kq
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:14:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8042861B37
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 15:14:32 +0000 (UTC)
References: <20171212150909.1831-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <aeb8709b-e774-5520-b0e4-a28493f4e94b@redhat.com>
Date: Tue, 12 Dec 2017 16:14:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171212150909.1831-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump: fix note_name_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: drjones@redhat.com

On 12/12/17 16:09, Marc-Andr=C3=A9 Lureau wrote:
> Use the function argument "name" instead of hardcoded
> "VMCOREINFO". All callers use "VMCOREINFO" as argument, so this isn't
> an exposed bug, thankfully.
>=20
> Simplify a little bit the code while touching this.
>=20
> Suggested-by: Andrew Jones <drjones@redhat.com>
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  dump.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/dump.c b/dump.c
> index d4a8c942eb..e9dfed060a 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -788,12 +788,7 @@ static bool note_name_equal(DumpState *s,
>      get_note_sizes(s, note, &head_size, &name_size, NULL);
>      head_size =3D ROUND_UP(head_size, 4);
> =20
> -    if (name_size !=3D len ||
> -        memcmp(note + head_size, "VMCOREINFO", len)) {
> -        return false;
> -    }
> -
> -    return true;
> +    return name_size =3D=3D len && memcmp(note + head_size, name, len)=
 =3D=3D 0;
>  }
> =20
>  /* write common header, sub header and elf note to vmcore */
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
