Received: from eggs.gnu.org ([2001:4830:134:3::10]:47437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhh2T-0005Ww-Hr
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhh2P-00055i-Kj
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:58:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhh2P-00055V-Ay
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21EB0806D4
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 18:58:00 +0000 (UTC)
References: <20170814215748.5158-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aaa8f7cd-5f55-0e3b-6eee-c45c9b45cbff@redhat.com>
Date: Tue, 15 Aug 2017 13:57:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UWEbArr229HRNVBJTc2O9XX0lXtHgcDsc"
Subject: Re: [Qemu-devel] [RFC v4 00/13] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>
Cc: libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UWEbArr229HRNVBJTc2O9XX0lXtHgcDsc
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Laine Stump <laine@redhat.com>
Cc: libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>
Message-ID: <aaa8f7cd-5f55-0e3b-6eee-c45c9b45cbff@redhat.com>
Subject: Re: [RFC v4 00/13] qmp: query-device-slots command
References: <20170814215748.5158-1-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/14/2017 04:57 PM, Eduardo Habkost wrote:
> Changelog
> ---------
>=20
> Changes v3 -> v4:
> * New compact representation of slot sets.
> * New generic code to automatically merge similar slots
>   into a single entry in the command output while keeping
>   implementations of the method simpler.
> * Example implementation of IDE and USB bus enumeration

>=20
> Slot sets are represented by a list of option names and sets of
> possible values for each of those options.  The command uses a
> compact representation for the set of valid values for an option.
> For example, the following set of 5 PCI functions:
>=20
>       bus: pcie.0
>       device-number: 31
>       functions: 1,4,5,6,7
>=20
> would be represented in the JSON data as:
>=20
>   {"available":false,"count":5,
>    "device-types":["pci-device"],"hotpluggable":false,
>    "opts":[
>       {"option":"function","values":[1,[4,7]]},

A list (and not just a single-type list, but a list that mixes scalar
and sublist),

>       {"option":"device-number","values":31},

vs. a scalar.  Why not a one-element array?

>       {"option":"bus","values":"pcie.0"}],
>    "opts-complete":true}
>=20
> I planned to use QAPI alternates to model/document that in the
> schema, but it would require implementing a few missing features
> in QAPI alternate support.

Yeah, I can see how existing QAPI alternates do not yet support arrays,
which becomes important to your representation.  Do you need help
getting the QAPI generator improved to support a particular feature that
you found to be lacking?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UWEbArr229HRNVBJTc2O9XX0lXtHgcDsc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTRC4ACgkQp6FrSiUn
Q2rrkwgAgtsdKjBpz0ybkV2TuAAM95p6HlrHBujv5uaS26zchQLmOjtZswf4LhEC
P8u4BujYVqs1YeQ3X0Nw4GTOujfQFR9RQd1OOQ25JQnkjMwqGtXaR75O9L7z2CSx
g7OxoTVD8lX4x5S30N8xK8Z/PLYt6fyTRXzR9rWnlgSaxp+DCxPBpBP0GvMUc54b
vPLFvJP9cFjV9IELIwUmCbI6EmdYSDKLpWaakv9+lPxPc+CK3spRB3trkn/3pl4+
tm7OYGrgQAWpOvp4wiTWAFezEXS3/SqyO295svYVQN7FM4H4HIjLKsnqGXFgUrA/
X2x93N5Us2BGV0KfLYzNCnAS5SFCDQ==
=83ly
-----END PGP SIGNATURE-----

--UWEbArr229HRNVBJTc2O9XX0lXtHgcDsc--
