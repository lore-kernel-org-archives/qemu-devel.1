Received: from eggs.gnu.org ([2001:4830:134:3::10]:50191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehcmF-0003qZ-35
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehcmB-0001ZO-1L
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:19 -0500
References: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <be898714-bffb-7fdf-0b91-e3c276559fc7@redhat.com>
Date: Fri, 2 Feb 2018 14:37:29 +0100
MIME-Version: 1.0
In-Reply-To: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eZXqLa86VdqzCXcM2PheLQD9sCCVMmimv"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fixed grammatical error in
 dump_human_image_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shravan Rajinikanth <shravan2x@utexas.edu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eZXqLa86VdqzCXcM2PheLQD9sCCVMmimv
From: Max Reitz <mreitz@redhat.com>
To: Shravan Rajinikanth <shravan2x@utexas.edu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <be898714-bffb-7fdf-0b91-e3c276559fc7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fixed grammatical error in
 dump_human_image_check
References: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
In-Reply-To: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-02 23:37, Shravan Rajinikanth wrote:
> Signed-off-by: Shravan Rajinikanth <shravan2x@utexas.edu>
> ---
>  qemu-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 68b375f..bea9268 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -580,7 +580,7 @@ static void dump_human_image_check(ImageCheck *chec=
k, bool quiet)
>          if (check->leaks) {
>              qprintf(quiet,
>                      "\n%" PRId64 " leaked clusters were found on the i=
mage.\n"
> -                    "This means waste of disk space, but no harm to da=
ta.\n",
> +                    "This means disk space is wasted, but data is safe=
=2E\n",
>                      check->leaks);
>          }

Sorry, somehow I never applied this.  (Maybe I thought it would go
through trivial...)

Applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--eZXqLa86VdqzCXcM2PheLQD9sCCVMmimv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp0aZkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvFAH/3sRKKws4yVA23nAYpoIbrlKnhq4EKTs
KkMNiAWg9iOE5ZIJUgOxsp7TkWCqG1vbbpptP28Nu9OpbzW8KqqsikKtzZeHcxxf
ywCVGQwy7h4ixhDypzHylxPjjvNjvjPzj9Dx9FHu/zH42hto3NdVGw+6nn4RdOxF
nmcIDia+0tJUDGzjP+sLBn/n7RrokZesuw7gRq2LW5fmAplXjyuQet1VTw9P8WsK
Up9fWsngIr6XlBIevTNcYuZrulseoSd1niwackz55T6BYbLHNUE+655krsnFKCtz
G+/0JkhpNomA4WO21WeCbVxcIkUndCx2Ff+oyOJODa9jjETXc6vRzyY=
=6Ao1
-----END PGP SIGNATURE-----

--eZXqLa86VdqzCXcM2PheLQD9sCCVMmimv--
