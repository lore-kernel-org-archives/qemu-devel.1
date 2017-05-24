Received: from eggs.gnu.org ([2001:4830:134:3::10]:49177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDXJe-0003Qn-48
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDXJa-0004iD-73
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:31:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDXJZ-0004hi-U1
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:31:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A937A4E339
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 14:31:04 +0000 (UTC)
References: <20170520020914.14562-1-ehabkost@redhat.com>
	<87o9uj64ro.fsf@dusky.pond.sub.org>
	<20170523143443.GE32274@thinpad.lan.raisama.net>
	<87zie2pi5f.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <033e3361-bddd-e780-7d25-495c1e60995b@redhat.com>
Date: Wed, 24 May 2017 09:31:03 -0500
MIME-Version: 1.0
In-Reply-To: <87zie2pi5f.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nFXPos97KNfouuviQSEQtN0Caq3K6lcA2"
Subject: Re: [Qemu-devel] [RFC 0/3] qmp: Return extra information on
 qom-list-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nFXPos97KNfouuviQSEQtN0Caq3K6lcA2
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <033e3361-bddd-e780-7d25-495c1e60995b@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/3] qmp: Return extra information on
 qom-list-types
References: <20170520020914.14562-1-ehabkost@redhat.com>
 <87o9uj64ro.fsf@dusky.pond.sub.org>
 <20170523143443.GE32274@thinpad.lan.raisama.net>
 <87zie2pi5f.fsf@dusky.pond.sub.org>
In-Reply-To: <87zie2pi5f.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/24/2017 07:13 AM, Markus Armbruster wrote:

>>> Might lead to more traffic rather than less.  Depends on what
>>> information the client needs to query.
>>
>> I think queries that return all available QOM types are likely to
>> (should?) be cached by clients.
>=20
> Perhaps libvirt developers can help us here.

Libvirt is very likely going to cache things (libvirt already tries to
cache as much information as it needs from a single run of a qemu
binary, and only recomputes the cache when either libvirt or qemu
binaries are detected to have changed to a newer timestamp).  Reading
the entire list, and then libvirt computing transitive closure on that
list if needed, is probably acceptable, compared to qemu having to
compute transitive closure up front for a larger QMP message.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nFXPos97KNfouuviQSEQtN0Caq3K6lcA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJZknAAoJEKeha0olJ0Nq5SYH/15aoEyiA5PgOswifa4//Emn
oqg6oHZ17BEbeQvnZmXCH2e+K2vLEf22wQjCK/EFAvKDsDW9PEOn6PzRNPUMj3FC
rYzuDK4ZakJ70Ul9oZgZm6PyDM/U7CM3Nof2By4Bl7SNN/d+ja5KPeDHqBBHqR0G
g6zZyo8fMqAPPB7NYf9qSLzJW1xl6/ncpB1z0+TcnxuBaz2b94OD0xdrbjaHSSpf
84xLhpfYeF9ALq2UVu7vVwUvtpTzwtN5vbSypPtO2vT6tESWzPb8iWDDhU7IyEYF
tnsGtGLNYhtvfew2gtUpcJQoPRvgenlvNNAXi7t1BPvcMapy6hQgDzR5CORYR7I=
=iaRr
-----END PGP SIGNATURE-----

--nFXPos97KNfouuviQSEQtN0Caq3K6lcA2--
