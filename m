Received: from eggs.gnu.org ([2001:4830:134:3::10]:48047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjTGv-0004YN-O9
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjTGu-0007Bp-QV
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:08:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjTGu-0007B4-Hd
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:08:04 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C069FC04BD4C
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 16:08:04 +0000 (UTC)
References: <20170302123746.9694-1-berrange@redhat.com>
	<20170302123746.9694-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b2152672-8e78-3e82-0623-fc88118e901e@redhat.com>
Date: Thu, 2 Mar 2017 10:08:01 -0600
MIME-Version: 1.0
In-Reply-To: <20170302123746.9694-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tsKpqnxQIdCKrjC58GLHHbfSsUT3WEbja"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] migration: always report tls-creds
 & tls-hostname migrate parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Ferlan <jferlan@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tsKpqnxQIdCKrjC58GLHHbfSsUT3WEbja
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela
 <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 John Ferlan <jferlan@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Message-ID: <b2152672-8e78-3e82-0623-fc88118e901e@redhat.com>
Subject: Re: [PATCH v2 2/2] migration: always report tls-creds & tls-hostname
 migrate parameters
References: <20170302123746.9694-1-berrange@redhat.com>
 <20170302123746.9694-3-berrange@redhat.com>
In-Reply-To: <20170302123746.9694-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 06:37 AM, Daniel P. Berrange wrote:
> Currently the query-migrate-parameters command will omit reporting
> of the tls-creds & tls-hostname parameters if their value is NULL.
> This makes it impossible for an app to detect if these parameters
> are supported by QEMU, without trying to actually set them and
> catching the error. Since the code is treating "" and NULL as
> equivalent, we can simply always report these values and give them
> a value of "". This allows apps like libvirt to detect the fact
> that these parameters are supported by QEMU.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  migration/migration.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

The .c changes look fine, but I agree that we want to document the
special-case of "" in the .json file.  Looking forward to v3.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--tsKpqnxQIdCKrjC58GLHHbfSsUT3WEbja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuENhAAoJEKeha0olJ0NqyUkIAJLmq9Jx/GENFcslxxevfPZ/
pDZ7nHHsjjF3MV5TeGl0/4POx8r8fiRdwpeZ83n/DmzZkGiG4mRSB6vvvqs8dkGA
NQF+j79ynign2Erbta4GvhYehOcqo8RdZ126iPETZU5UTyZW1fJ4ZnrYj56yY9S8
fzG5ZEYlhkUMARj17nX/nmtcc40xWg39Tf+JxBIM6DEHZGx2QqJA8SAj1f+kFsjj
P/PF8i5/D7Xh5PqpOuDwBg+sEWIf/9t4XPCOcVn3MrxK+Gh7zpnkDQnNeIxuYiS2
vbxuO1tlfuABYYOTMIeCE9ydLgeVp/AcE2Lxle6kZhIXTyneaC/jYRBM4NkeAlo=
=pJZi
-----END PGP SIGNATURE-----

--tsKpqnxQIdCKrjC58GLHHbfSsUT3WEbja--
