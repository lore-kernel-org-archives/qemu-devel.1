Received: from eggs.gnu.org ([2001:4830:134:3::10]:53826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPU06-0002ty-No
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPU02-0003EH-3J
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:24:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPU01-0003DF-Pt
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:24:18 -0400
References: <20170615141715.17708-1-sferdjao@redhat.com>
	<20170615141715.17708-2-sferdjao@redhat.com>
	<2bb5a8a3-37c9-3dd2-4483-c8a2fed5bb4d@redhat.com>
	<20170618031516.GN22043@thinpad.lan.raisama.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8965c06b-0859-0819-1fc4-d09dd287fec8@redhat.com>
Date: Mon, 26 Jun 2017 07:23:50 -0600
MIME-Version: 1.0
In-Reply-To: <20170618031516.GN22043@thinpad.lan.raisama.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OnpItpkugMiSBUDIiHlS5N0OwTI0M995X"
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu: add capability for vhost-net
 busy polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Laine Stump <laine@redhat.com>
Cc: libvir-list@redhat.com, sferdjao@redhat.com, berrange@redhat.com, Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OnpItpkugMiSBUDIiHlS5N0OwTI0M995X
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Laine Stump <laine@redhat.com>
Cc: libvir-list@redhat.com, sferdjao@redhat.com, berrange@redhat.com,
 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Message-ID: <8965c06b-0859-0819-1fc4-d09dd287fec8@redhat.com>
Subject: Re: [PATCH 1/3] qemu: add capability for vhost-net busy polling
References: <20170615141715.17708-1-sferdjao@redhat.com>
 <20170615141715.17708-2-sferdjao@redhat.com>
 <2bb5a8a3-37c9-3dd2-4483-c8a2fed5bb4d@redhat.com>
 <20170618031516.GN22043@thinpad.lan.raisama.net>
In-Reply-To: <20170618031516.GN22043@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/17/2017 09:15 PM, Eduardo Habkost wrote:
> (CCing qemu-devel and the QAPI maintainers.  I have a question
> about introspection below.)
>=20

>=20
> Fortunately, netdev options are modelled in the QAPI schema as
> union Netdev.  However, 'query-qmp-schema' doesn't seem to
> include union Netdev because it is not referenced by any QMP
> command or event.

I've posted patches in the past (qemu 2.6 timeframe, if I recall) that
changed netdev_add into a fully-advertised interface, but we didn't take
it then because we weren't sure how to handle the fact that netdev_add
can currently accept both an integer (1) and a string ("1") as
identical, and we didn't want to risk breaking clients that passed a
string when the promoted command would only accept integers.  I guess we
should revive that.

>=20
> Markus, Eric, Michael: is there any way libvirt can query the
> definition of union Netdev from the schema with current QEMU?

Really, we need to promote netdev_add to a full-fledged QMP command.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OnpItpkugMiSBUDIiHlS5N0OwTI0M995X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUQrmAAoJEKeha0olJ0NqAqkIAIUGcjHLnulR+Jh/2MKSLcoy
pWKo2cG4x//Wju0iFvctF196nj3tppUoJXKBGnBXLokwFVhEqRZQIchWRyMvX6w4
jAOWiJ0XH5U27MKLoc3CAlQBhJKCfjBGdK+SK4S7HN3RiGYqIOM89EpDKWTEUfKU
8yq2YHfnHZ+l2H3P87DRKuxs2W13m8inpzlIi5WazcLqAen0qQLo/+ng3uavS3gz
F0/UsA4zH5/MB6NMGt34EPR6jbj2sG7ZLakiemf1VYXdvaV6VLGi/aam2DWWE8j7
slI0ix/ZKfrc5CmXhFajEaPkxUk2z4Xl4k7eaJWR4QTGVsB/0gMQX8/wLJeyneo=
=M01j
-----END PGP SIGNATURE-----

--OnpItpkugMiSBUDIiHlS5N0OwTI0M995X--
