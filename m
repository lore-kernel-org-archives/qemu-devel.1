Received: from eggs.gnu.org ([2001:4830:134:3::10]:39931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0oal-0008Av-9Z
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0oak-0000of-HD
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:20:15 -0400
References: <20170401155751.14322-1-mreitz@redhat.com>
	<20170401155751.14322-5-mreitz@redhat.com>
	<20170419112859.GC14508@lemon.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9d135f07-4b16-7798-a9fa-f5bbce6eb3d5@redhat.com>
Date: Wed, 19 Apr 2017 14:19:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170419112859.GC14508@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cCHVlWAtxeKFApOUCKTTLLWWGTDSBbWOw"
Subject: Re: [Qemu-devel] [RFC for-3.0 4/4] block/qcow2-rust: Register block
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cCHVlWAtxeKFApOUCKTTLLWWGTDSBbWOw
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Message-ID: <9d135f07-4b16-7798-a9fa-f5bbce6eb3d5@redhat.com>
Subject: Re: [Qemu-devel] [RFC for-3.0 4/4] block/qcow2-rust: Register block
 driver
References: <20170401155751.14322-1-mreitz@redhat.com>
 <20170401155751.14322-5-mreitz@redhat.com> <20170419112859.GC14508@lemon.lan>
In-Reply-To: <20170419112859.GC14508@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.04.2017 13:28, Fam Zheng wrote:
> On Sat, 04/01 17:57, Max Reitz wrote:
>> +/* This is just for the module loading system to detect this driver *=
/
>> +static BlockDriver _ __attribute__((used)) =3D {
>> +    .format_name =3D "qcow2-rust",
>> +};
>=20
> You see why I didn't like that system in the first place.

Yes. We will have to adjust the module loading system before 3.0, but
I'm confident we can port all block drivers to Rust by then so this will
be a matter of course.

OTOH, why would you ever not load the rust block driver? In the final
version, we'd call it "qcow2", throw the legacy driver out and not even
care about whether the module system detects this one (because it'll be
statically linked anyway).

(Honestly, I think this is just an artifact from beginning of last week
where I wanted to make this driver a module... Beware, my April Fool's
patches may not be polished.)

Max


--cCHVlWAtxeKFApOUCKTTLLWWGTDSBbWOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj3VegSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9GkIAJTr1Ab6hmd3Ao3+lXG0GWcSgxxAU6vu
YqI8epzIUJnlb1hFx8VEg3dAGkoI8BfIYMN473vh/uOYx25oyHtAnx59m0KVnpU5
Px1y2xLfHJXp8dpdRUvw6NPB4FeEQ9wHKuP+NT4PLdnfhK8mUhZHI+sLgpjkD2Gu
DcMXzniESkLa4rcQhLY+aNTuFU72tbXbAHOoHSiYhYO+WBDGj+SWqQo2ZOc3f97C
ikt4Q3WkDTbvdOvYItdsaMl2AaH+5seeVpEvRxMvW21przCFME3Ddr9V6l/okn2d
OLVKDnxyH+3E6GFx/U5GgN4eP+4TSoSgKju4QktDFf7QfMU2rwm3HN4=
=sfRX
-----END PGP SIGNATURE-----

--cCHVlWAtxeKFApOUCKTTLLWWGTDSBbWOw--
