Received: from eggs.gnu.org ([2001:4830:134:3::10]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOmLu-0001gC-6u
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOmLq-0003Qs-8B
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:20:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1eOmLq-0003PE-1g
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:20:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 568EE61467
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 15:20:09 +0000 (UTC)
Date: Tue, 12 Dec 2017 16:20:03 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171212152003.q2ayv3gtz7wbtwoj@kamzik.brq.redhat.com>
References: <20171212150909.1831-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171212150909.1831-1-marcandre.lureau@redhat.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com

On Tue, Dec 12, 2017 at 04:09:09PM +0100, Marc-Andr=E9 Lureau wrote:
> Use the function argument "name" instead of hardcoded
> "VMCOREINFO". All callers use "VMCOREINFO" as argument, so this isn't
> an exposed bug, thankfully.
>=20
> Simplify a little bit the code while touching this.
>=20
> Suggested-by: Andrew Jones <drjones@redhat.com>
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
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
> --=20
> 2.15.1.355.g36791d7216
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
