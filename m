Received: from eggs.gnu.org ([2001:4830:134:3::10]:38674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrR1-0001wP-9F
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrQy-0002Ll-IC
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:47:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCrQy-0002LM-Bp
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:47:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 458377F771
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 17:47:55 +0000 (UTC)
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
	<1495471335-23707-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe5bc363-b557-3c4a-8668-25039426fcc0@redhat.com>
Date: Mon, 22 May 2017 12:47:54 -0500
MIME-Version: 1.0
In-Reply-To: <1495471335-23707-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qCmCMAi6BmXNC44dFgBCtmlVBJ9NBJJaW"
Subject: Re: [Qemu-devel] [PATCH 2/4] qapi: Document visit_type_any() issues
 with keyval input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mlureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qCmCMAi6BmXNC44dFgBCtmlVBJ9NBJJaW
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mlureau@redhat.com
Message-ID: <fe5bc363-b557-3c4a-8668-25039426fcc0@redhat.com>
Subject: Re: [PATCH 2/4] qapi: Document visit_type_any() issues with keyval
 input
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
 <1495471335-23707-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1495471335-23707-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 11:42 AM, Markus Armbruster wrote:
> It's already documented in keyval.c (commit 0ee9ae7), but visitor.h
> can use a note, too.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/visitor.h | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qCmCMAi6BmXNC44dFgBCtmlVBJ9NBJJaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIyRKAAoJEKeha0olJ0Nq7ucIAJY27ZwhDBX5reFTfS9VPQBp
CyHCKOlFBPJ0TGuixvNtGdaAKEdt3DhUZwLTi7rA6uXwoGIFx+x6ecct7iOvRvkx
PK0oMeLCxdTJEiULoFPEtFiUgHj8GrRL8oG7x4K4NFeAaZEmVUJ5pBAUMbFO9zt7
+SCeeRjnVEcHsP3nJKRK8XTuYWnf1O5qXfD7ThPZkWnYGcMuBJBT44EcZqw9phZF
KnCahHZZZkoZVXkCNeuDjm6idC3eyWWBbPiplU7yNg3ZdTN4f6JrHbNltl85L46J
ip2WuBU+c7dKGz3i7/jXgQudz7U8iTDqvSNWdAr4cCMm4ziwcDSuBHho8Dt1WmM=
=TAzq
-----END PGP SIGNATURE-----

--qCmCMAi6BmXNC44dFgBCtmlVBJ9NBJJaW--
