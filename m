Received: from eggs.gnu.org ([2001:4830:134:3::10]:48836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikUe-0007nv-SC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikUa-0003vA-UU
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:19:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cikUa-0003ur-LL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:19:12 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2C5B6331E
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:19:12 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-25-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a4afec7f-2364-cef8-6b34-87c39f40c062@redhat.com>
Date: Tue, 28 Feb 2017 10:19:10 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-25-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2nEs24ugD0j63fqO8ng3dsvmSFndf2BaG"
Subject: Re: [Qemu-devel] [PATCH v2 24/26] tests: Cover input visit beyond
 end of list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2nEs24ugD0j63fqO8ng3dsvmSFndf2BaG
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a4afec7f-2364-cef8-6b34-87c39f40c062@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 24/26] tests: Cover input visit beyond end
 of list
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-25-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> When you try to visit beyond the end of a list, the qobject input
> visitor crashes, and the string visitor screws returns garbage.  The
> generated list visits never go beyond the list end, but manual visits
> could.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-opts-visitor.c          | 39 ++++++++++++++++++++++++++++++=
++++++++
>  tests/test-qobject-input-visitor.c | 10 ++++++++++
>  tests/test-string-input-visitor.c  | 16 ++++++++++++++++
>  3 files changed, 65 insertions(+)
>=20

> =20
> +static void
> +test_opts_range_beyond(void)
> +{

> +
> +    /* Would be simpler if the visitor genuinely supported virtual wal=
ks */
> +    visit_start_list(v, "ilist", (GenericList **)&list, sizeof(*list),=

> +                     &error_abort);
> +    tail =3D list;
> +    visit_type_int(v, NULL, &tail->value, &error_abort);
> +    g_assert_cmpint(tail->value, =3D=3D, 0);
> +    tail =3D (intList *)visit_next_list(v, (GenericList *)tail, sizeof=
(*tail));
> +    g_assert(!tail);
> +    visit_type_int(v, NULL, &val, &err);
> +    error_free_or_abort(&err);
> +    visit_end_list(v, (void **)&list);
> +

Wow - something the opts visitor does better than the qobject visitor! Ga=
sp!

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2nEs24ugD0j63fqO8ng3dsvmSFndf2BaG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtaL+AAoJEKeha0olJ0Nq0kUH/2P05yd1Isr05HfKQ+ecYsxP
GLL0oXxtbFwGJsQAL4/F0770OJV/PWCnOyC78W6qMOKVjBc/PYJFi3AcdOXssyNC
vz4cvv/X+aXUrFI5g9cfTfb7o4Ge4DyYFNplfuzNHGOuRmc8EEn55azynrkqEjaw
ISBC1yUGZpPefBHgZbUrSuuiajjq2EQjebNj671PXFYlbe0566LsCWjRpCpKTeRx
4QlUGRfoYYb5bmM8KQSRwspsJlEAqnt6IkVJz2ZImu7E4iIwnvbsGj9xDkPNrWj7
g7b4XdGMdoJr3pPZDQ2SFZ+5miQzd71SnvzAonJFV4y7abZ549+K3nHZyJTmJ9A=
=+1K/
-----END PGP SIGNATURE-----

--2nEs24ugD0j63fqO8ng3dsvmSFndf2BaG--
