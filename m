Received: from eggs.gnu.org ([2001:4830:134:3::10]:54368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fMrmK-0006CV-JU
	for qemu-devel@nongnu.org; Sun, 27 May 2018 05:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fMrmH-0002kD-FS
	for qemu-devel@nongnu.org; Sun, 27 May 2018 05:15:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fMrmH-0002jM-9Y
	for qemu-devel@nongnu.org; Sun, 27 May 2018 05:15:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 321EB8424E
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 09:15:48 +0000 (UTC)
Date: Sun, 27 May 2018 11:15:42 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180527091542.GC22274@dnr>
References: <20180525015042.31778-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20180525015042.31778-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: use g_free for ram load bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 09:50:42AM +0800, Peter Xu wrote:
>Buffers allocated with bitmap_new() should be freed with g_free().
>
>Both reported by Coverity:
>
>*** CID 1391300:  API usage errors  (ALLOC_FREE_MISMATCH)
>/migration/ram.c: 3517 in ram_dirty_bitmap_reload()
>3511          * the last one to sync, we need to notify the main send thre=
ad.
>3512          */
>3513         ram_dirty_bitmap_reload_notify(s);
>3514
>3515         ret =3D 0;
>3516     out:
>>>>     CID 1391300:  API usage errors  (ALLOC_FREE_MISMATCH)
>>>>     Calling "free" frees "le_bitmap" using "free" but it should have b=
een freed using "g_free".
>3517         free(le_bitmap);
>3518         return ret;
>3519     }
>3520
>3521     static int ram_resume_prepare(MigrationState *s, void *opaque)
>3522     {
>
>*** CID 1391292:  API usage errors  (ALLOC_FREE_MISMATCH)
>/migration/ram.c: 249 in ramblock_recv_bitmap_send()
>243          * Mark as an end, in case the middle part is screwed up due to
>244          * some "misterious" reason.
>245          */
>246         qemu_put_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);
>247         qemu_fflush(file);
>248
>>>>     CID 1391292:  API usage errors  (ALLOC_FREE_MISMATCH)
>>>>     Calling "free" frees "le_bitmap" using "free" but it should have b=
een freed using "g_free".
>249         free(le_bitmap);
>250
>251         if (qemu_file_get_error(file)) {
>252             return qemu_file_get_error(file);
>253         }
>254
>
>Signed-off-by: Peter Xu <peterx@redhat.com>
>---
> migration/ram.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAlsKdzcACgkQyvpdPXT/
Amn7FA//SCymsLnIFkVIQMW09OlvTR+1ZiuY1kaPZMayYpVr2/Kde3iYYw0A55/n
YXF+rWEAs/5xjBtjWjtXwLn0RJIJeVtDyiS2phRYosyKty7L+eSxn+7KARchvPCP
ViX14sT+CmobUhtViqWg2Pu2XSpqdTM+iA+hBkMnGTp677t8eGCdJ6Mwo6eR3aI9
QTTLlcQMBlfMNIc67ji3E3e+jzk/iiYuRdmf6EO8QwPdmYyXyzUJ34QS1Uu3FydE
dk3/nqI6K37gpwBQR9H+bp89336xsVv+VtQZFOumm8gJ4LnAHOPQSnv77O1NeDTh
JoLx5lerNBnB9ktmnESODqBFK7R3AJvM8WFnwLga44+jYqWuVCs9x1mzA3ksGlTW
8xxoA2nAdR0vTWT2HpZxfHSSnBtiethcWmGFUDIhcMNJwYdJxM73gFVv52Xb+i+7
TIpPACBMPLkaqIfUyWh1lX1Hff8JzaWfExBMfUfAmT1Faimxq+1RB7EW6CyMoNJd
cZyHjlYK46FEtFxTTfzvNt2QyyCeJlgKVqIBZMQjP2ayfR11tQxI0qUmrV+Z5vAg
mxpQ1nJz9BkqDjqOZL4XqiTA7e3vxuSBL8rQINSr0bHurAIiLexgHs39k8nUkrrB
GGs8UChzSh838OrS7vKfej3EIE1vUYdIJ0IlIXji+iobGgIyp3w=
=NsU6
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
