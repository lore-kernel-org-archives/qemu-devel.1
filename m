Received: from eggs.gnu.org ([2001:4830:134:3::10]:35588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cer75-0002Ty-IZ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cer70-00029S-Mw
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:34:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cer70-00028v-Fv
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:34:46 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73DA183F38
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 22:34:46 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b886937d-ed47-6ae5-f7da-3bea4f2d122d@redhat.com>
Date: Fri, 17 Feb 2017 16:34:44 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IhL9x8f26coHnhMU0Vig0lRDccD3iMEpx"
Subject: Re: [Qemu-devel] [PATCH 02/14] check-qdict: Simplify
 qdict_crumple_test_recursive()
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
--IhL9x8f26coHnhMU0Vig0lRDccD3iMEpx
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b886937d-ed47-6ae5-f7da-3bea4f2d122d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/14] check-qdict: Simplify
 qdict_crumple_test_recursive()
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> Use qdict_get_qdict(), qdict_get_qlist() instead of qdict_get()
> followed by qobject_to_qdict(), qobject_to_qlist().

Worth a Coccinelle script to make sure we catch it all?

>=20
> While there, drop some redundant code.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qdict.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IhL9x8f26coHnhMU0Vig0lRDccD3iMEpx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp3qEAAoJEKeha0olJ0NqQVkIAJ8m0vr4LdotPzTplywFVnjV
9nRR/f+zk+X/tZIw1MZwq/3MPoeG1LSoX0PJH+jmNyFTXB5K6CMOVTMvs/+V7C9K
UU60zmVWA/e4RZW5nqC60xpMA4b2r5PpeJVwG+79R4h1teIWj99uQETLrdHL7nfp
vcjHBTZOmczoVKuxyg7Bj7NS347QtssmNDu6jctojZ2U77Qjm0WL2ybw6f8NOLSw
3yPkIX63MYdblcoxmpjm9XPNv+bHY6myVorYwNxOVPG2Ko9pjsnh+zj+bvDT7Y+d
S0lE0jZLyK7ILUpZVn5PAe47hUGIKdeVo8NGObPgN4bGujMkii9a6Meqp5EQ2m0=
=rJcE
-----END PGP SIGNATURE-----

--IhL9x8f26coHnhMU0Vig0lRDccD3iMEpx--
