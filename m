Received: from eggs.gnu.org ([2001:4830:134:3::10]:35145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cijsS-00071D-P2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cijsQ-0005Nj-65
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:39:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cijsP-0005NJ-U7
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:39:46 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16B417FB9F
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 15:39:46 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-19-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08607c1c-0293-1f5c-787a-029d08b92ef3@redhat.com>
Date: Tue, 28 Feb 2017 09:39:43 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-19-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T3x4oM8qlq5kowfuVe7J6mN8EdwltvuA6"
Subject: Re: [Qemu-devel] [PATCH v2 18/26] tests-qobject-input-strict: Merge
 into test-qobject-input-visitor
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
--T3x4oM8qlq5kowfuVe7J6mN8EdwltvuA6
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <08607c1c-0293-1f5c-787a-029d08b92ef3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 18/26] tests-qobject-input-strict: Merge
 into test-qobject-input-visitor
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-19-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> Much test-qobject-input-strict.c duplicates

s/Much/Much of/

> test-qobject-input-strict.c less assertions on expected output:

s/less/, but with less/

=2E..
>=20
> Merge the remaining test cases into test-qobject-input-visitor.c, and
> drop the now redundant test-qobject-input-strict.c.
>=20
> Test case "/visitor/input-strict/fail/list" isn't really about lists,
> it's about a bad struct nested in a list.  Rename accordingly.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---


> -static void test_validate_struct_nested(TestInputVisitorData *data,
> -                                         const void *unused)
> -{
> -    UserDefTwo *udp =3D NULL;
> -    Visitor *v;
> -
> -    v =3D validate_test_init(data, "{ 'string0': 'string0', "
> -                           "'dict1': { 'string1': 'string1', "
> -                           "'dict2': { 'userdef': { 'integer': 42, "
> -                           "'string': 'string' }, 'string': 'string2'}=
}}");
> -

Old code had semi-sane line wrapping...


> +++ b/tests/test-qobject-input-visitor.c
> @@ -5,6 +5,7 @@
>   *

> +static void test_visitor_in_fail_struct_nested(TestInputVisitorData *d=
ata,
> +                                               const void *unused)
> +{
> +    UserDefTwo *udp =3D NULL;
> +    Error *err =3D NULL;
> +    Visitor *v;
> +
> +    v =3D visitor_input_test_init(data, "{ 'string0': 'string0', 'dict=
1': { 'string1': 'string1', 'dict2': { 'userdef1': { 'integer': 42, 'stri=
ng': 'string', 'extra': [42, 23, {'foo':'bar'}] }, 'string2': 'string2'}}=
}");


=2E..new code has insanely long lines.  Not a show-stopper, but I wouldn'=
t
mind if you added line breaks.

It's a little bit hard to follow the patch alone, but I didn't spot any
obvious loss of coverage and the commit message definitely helps.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--T3x4oM8qlq5kowfuVe7J6mN8EdwltvuA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtZm/AAoJEKeha0olJ0NqkbUH/iKzxtOKppyAfUq95x6Z1Cfw
nIQMPp802M9rX9VZaGj84C5xxDZhGYq1xULQqvF+i/u6Xt+NWy8+ZWpGsj/4RMdS
qN9IRGeJnSywyf4KwwMx3La5nZv2y3TuzyH94Gi/VBc8mlCuop+TS0jfyIvYKPuA
k6Fu7jEvfSU0iMOI4HMePEJRPHMI1RDgJJJd+3+PdW5fUCFC3DoYB21Xwr3WfZRS
akkRytjUj0EnPqKCuN0aL8/ldKHm8ZesGVMySoKlPwHWMG149kUqqxPFs/+MBdLo
RD6CJcEgTqi23CCkcgPpIOy7IThnL2q7BKP+1L5upBmbvgTzb5gpHFQd8bmuTe8=
=2+wI
-----END PGP SIGNATURE-----

--T3x4oM8qlq5kowfuVe7J6mN8EdwltvuA6--
