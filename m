Received: from eggs.gnu.org ([2001:4830:134:3::10]:59450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPs46-0005LW-GQ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPs44-0006Dq-SF
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:06:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPs44-0006Ar-Jv
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B3127D0EB
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 15:06:02 +0000 (UTC)
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-2-git-send-email-peterx@redhat.com>
	<20170627145507.GY12152@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a5b994d8-3e87-379b-65b6-f7c7e6946a80@redhat.com>
Date: Tue, 27 Jun 2017 10:05:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170627145507.GY12152@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vSlCbKGOvV6hn7215Po1FeHgP62OspiGX"
Subject: Re: [Qemu-devel] [PATCH v6 01/10] machine: export
 register_compat_prop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vSlCbKGOvV6hn7215Po1FeHgP62OspiGX
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <a5b994d8-3e87-379b-65b6-f7c7e6946a80@redhat.com>
Subject: Re: [PATCH v6 01/10] machine: export register_compat_prop()
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
 <1498536619-14548-2-git-send-email-peterx@redhat.com>
 <20170627145507.GY12152@localhost.localdomain>
In-Reply-To: <20170627145507.GY12152@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2017 09:55 AM, Eduardo Habkost wrote:

>> + *
>> + * The property values set using this function must be always valid a=
nd
>> + * never report setter errors, as they property have
>=20
> Typo (my fault, sorry).  It should be "the property have", or "the
> property will have".
>=20

"the property will have"

> With this fixed (which may be done manually by the maintainer when
> applying):
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
>> + * GlobalProperty::errp set to &error_abort.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vSlCbKGOvV6hn7215Po1FeHgP62OspiGX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUnRSAAoJEKeha0olJ0NqSWEH/0dd01R39aVajtAZ5PeQOKyd
RoYYsYlSqEQwM79EqY5l+Gt62wsrCvb56Zn4hNQ2BCqyzSE7ToqMAeggENTAox5E
dmTUZH5KLn0ZlkFqdhDNWgD9sXAoLRjYfbdUm1T52pWaKGClhUoEAHTvVDG5wL/0
TSoDV+WYB36xW0svLV4z6w2/FI3UymmCjWBocftt2S4Upm6b0IXipYWAFWYi3TCI
CNpBLeumsJDgYM5pZJ/Y+l8KBXLpkpBjCQdNVDmX848ngs/8/tDhZFrq2imjquoh
GfKMkQDgjFmuC5+M2G8YKkuyTmRjMTpiufw3EwNJDBKdDs2ZxsGvGFweox28Eyo=
=JjbH
-----END PGP SIGNATURE-----

--vSlCbKGOvV6hn7215Po1FeHgP62OspiGX--
