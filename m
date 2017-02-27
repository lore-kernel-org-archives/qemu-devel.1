Received: from eggs.gnu.org ([2001:4830:134:3::10]:53373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciObV-0001uH-Di
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciObS-0000N5-GD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:56:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciObS-0000MY-7M
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:56:50 -0500
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
	<9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
	<f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
	<c207e00d-25a6-45bb-a849-235d0cd2be0d@redhat.com>
	<2b0840d7-7540-d732-36ac-af7a512d2c8f@kamp.de>
	<b59eb68b-5dac-b18b-c2f7-1ea820f4d747@redhat.com>
	<589533ff-2e7d-0ffb-e0b9-5b2e055813b6@redhat.com>
	<5E0A3205-E866-44C3-86C5-7B3B4F9923B4@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7a65cf5-5c06-b4a8-5130-d79130af60a6@redhat.com>
Date: Mon, 27 Feb 2017 10:56:46 -0600
MIME-Version: 1.0
In-Reply-To: <5E0A3205-E866-44C3-86C5-7B3B4F9923B4@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MevR373b4G08LGrupAOkknKqu8fNqDC84"
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Christian Theune <ct@flyingcircus.io>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MevR373b4G08LGrupAOkknKqu8fNqDC84
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>
Cc: John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Christian Theune <ct@flyingcircus.io>
Message-ID: <a7a65cf5-5c06-b4a8-5130-d79130af60a6@redhat.com>
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
 <9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
 <f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
 <c207e00d-25a6-45bb-a849-235d0cd2be0d@redhat.com>
 <2b0840d7-7540-d732-36ac-af7a512d2c8f@kamp.de>
 <b59eb68b-5dac-b18b-c2f7-1ea820f4d747@redhat.com>
 <589533ff-2e7d-0ffb-e0b9-5b2e055813b6@redhat.com>
 <5E0A3205-E866-44C3-86C5-7B3B4F9923B4@kamp.de>
In-Reply-To: <5E0A3205-E866-44C3-86C5-7B3B4F9923B4@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 02:41 PM, Peter Lieven wrote:
> The live-snapshot/live-commit stuff could indeed help in my scenario. I=
f I understand correctly this is
> something that already works today, correct? If I have taken a live-sna=
pshot, is live-migration and
> stop/start of the VM still possible? What about live-migration and star=
t/stop during live-commit?

Yes, a guest can be started or stopped while migration and/or
live-commit are underway.  You probably have to keep the qemu process
around (stopping the guest but keeping qemu alive is different than
stopping qemu altogether), which is where the persistence factors into
it (once we have persistent bitmaps, then stopping qemu altogether
becomes possible).

> I don=E2=80=99t talk about the dirty bitmap tracking I understand that =
persistence and live-migration support
> is still in the works, I=E2=80=99m just interested in the snapshot/comm=
it part.
>=20
> Thanks
> Peter
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MevR373b4G08LGrupAOkknKqu8fNqDC84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtFpOAAoJEKeha0olJ0NqzaQH+wYj9T5Gzv+WaULruRvTMetk
C6PYt35meZI80CS/Rj90vZAQe1WtLhfTi/+ohiVHunbM/zGWoXW/hqlz8AZYLkeJ
1i0qiAmf2fTZ8FsGFgelp0xG0jI6VCNUlSxcCw6I8fzBFZxS8Ln7afBT7mwcBbAq
5yeBlGUnV+L3mDaY2w4p2Yq6MT8OYOISICrgjvUT7CBshhoa/gSYKhUhYy2gAS3G
fmfr+KT1KvOKFDEh4VcSKIAwfyH2pn48Zij/6KUsf08/IgjUCuQGQTyH6F5MZyn4
h/w7E1VtKfIzeuXEQpmn17WMzg+PDViPrYJXpOqzW9qqQAVlbojBzTQxcKrWlh0=
=uuLz
-----END PGP SIGNATURE-----

--MevR373b4G08LGrupAOkknKqu8fNqDC84--
