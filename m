Received: from eggs.gnu.org ([209.51.188.92]:46358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkBks-0002ZN-J8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkBkr-0004Ps-KP
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:47:02 -0500
References: <20190117153321.29749-1-eblake@redhat.com>
	<20190117153321.29749-2-eblake@redhat.com>
	<20190117163939.GB6761@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e800129e-724e-edeb-1706-f17b6cf16153@redhat.com>
Date: Thu, 17 Jan 2019 11:46:49 -0600
MIME-Version: 1.0
In-Reply-To: <20190117163939.GB6761@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6j2vmKwqeuGLjSWJrUxHm4u6wmjAu63Hr"
Subject: Re: [Qemu-devel] [PATCH 1/3] block: Expose protocol-specific data
 to 'qemu-img info'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6j2vmKwqeuGLjSWJrUxHm4u6wmjAu63Hr
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <e800129e-724e-edeb-1706-f17b6cf16153@redhat.com>
Subject: Re: [PATCH 1/3] block: Expose protocol-specific data to 'qemu-img
 info'
References: <20190117153321.29749-1-eblake@redhat.com>
 <20190117153321.29749-2-eblake@redhat.com>
 <20190117163939.GB6761@localhost.localdomain>
In-Reply-To: <20190117163939.GB6761@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 10:39 AM, Kevin Wolf wrote:
> Am 17.01.2019 um 16:33 hat Eric Blake geschrieben:
>> 'qemu-img info' is useful for showing additional information
>> about an image - but sometimes the interesting information is
>> specific to the protocol rather than to the format layer.  Set
>> the groundwork for showing this information; further patches
>> will then enable specific pieces of information.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Isn't this making invalid assumptions about the structure of the block
> graph? Who says that I don't have a quorum node below the format layer
> with five different protocol layer children? Some of which may have
> filter nodes on top?

Does quorum have bs->file?  If not, then this field is not populated for
quorum, so it doesn't make invalid assumptions.

You do have a point about bs->file pointing to filters being an
interesting case, though.  Max had a series proposal back in August that
tries to do smarter role-based descent through the graph rather than
just hard-coding assumptions based on bs->file:

https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg01644.html

Maybe we need to get that in place first, at which point it then becomes
easier to reason about what related BDS information to visit in addition
to the format layer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6j2vmKwqeuGLjSWJrUxHm4u6wmjAu63Hr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAv4kACgkQp6FrSiUn
Q2rnhAgAgGc7f9l8+Pxg0BPrKJSHpn5my3yb4EG+LOYZG5k51jPxSse6bJqw4wME
+SVo+gARiApgy1lGPeQa8lw1mKNScir5wuO5hnjohTzhst8ZFRiOSVWUBnITpE/x
aowD/+a4lSfYMAVvpIPnSkAesC/uMLULDwrORgYi+hkOkHGyoKYpK9Tn0lJlMGXV
AfydGKNF9knhr+uxoWkH8ut7ViUap1Oqa07DY8BSa64sgrLOmBpIqwhgyoyXUPUp
VrrxbHFIJkt6ajefvVpb9c9cv3uL5wQEb+0Sad/vuCRLrixmRfTS5GT9yQYoWITH
uubEnL0j+Tnfd8nrx0mTqQX8NjZJ1Q==
=9x7l
-----END PGP SIGNATURE-----

--6j2vmKwqeuGLjSWJrUxHm4u6wmjAu63Hr--
