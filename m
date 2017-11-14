Received: from eggs.gnu.org ([2001:4830:134:3::10]:33564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEbK3-0001Fu-Ul
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEbK2-0003bi-Qs
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:32:15 -0500
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
	<CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
	<94700229-5afe-159f-9453-f507b9c83085@redhat.com>
	<0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
Date: Tue, 14 Nov 2017 14:32:05 +0100
MIME-Version: 1.0
In-Reply-To: <0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KffxMskVWqd17H4tIr0eM02i4DwouqgAD"
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow
 v1 to v2 creates a qcow v3 file?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KffxMskVWqd17H4tIr0eM02i4DwouqgAD
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Message-ID: <9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow v1
 to v2 creates a qcow v3 file?
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
 <CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
 <94700229-5afe-159f-9453-f507b9c83085@redhat.com>
 <0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
In-Reply-To: <0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-13 19:08, Eric Blake wrote:
> On 11/13/2017 11:58 AM, Eric Blake wrote:
>=20
>>>> qemu-system-aarch64: -drive if=3Dnone,file=3Dhda.qcow2,format=3Dqcow=
,id=3Dhd:
>>>> Unsupported qcow version 3
>>>
>>> ah, this means it wants "format=3Dqcow2".
>>
>> Oh, I should have read this followup before writing my other reply.
>>
>>>
>>> This is pretty confusing, especially the error message, the
>>> output of "file", and the fact that "format=3Dqcow" can't just
>>> DTRT if it gets a qcow version 3 (2?), since it can clearly
>>> identify what it's got.
>>
>> Indeed, making the qcow driver smart enough to reopen with the qcow2
>> driver (for both v2 and v3 images) might be an interesting ease-of-use=
 hack.
>=20
> And having the qcow2 driverautomatically be able to open a qcow v1 imag=
e
> read-only might also be nice - although v1 is lacking so many features
> that we'd be insane to let a read-write request of the qcow2 driver
> downgrade to qcow.

Both seem to be hacks to me, though, which needlessly complicate everythi=
ng.

Just issuing a deprecation warning when creating qcow v1 images and
improving the warning when opening qcow2 (v2/v3) images with the qcow
driver should be enough.

> Another observation: is there any official documentation for the qcow
> (v1) format?  I know it's an outdated format that we no longer recommen=
d
> for new image creation, but it's sad when I have to resort to a google
> search to find old posts like this:
>=20
> https://people.gnome.org/~markmc/qcow-image-format-version-1.html
>=20
> rather than being able to see the documentation of v1 alongside v2 in
> the qemu.git repository.

Well, do you want to document it?  I'd rather deprecate it altogether.

Max

> At any rate, since qcow and qcow2 share the same 4-byte magic number an=
d
> version field, it explains why both drivers are able to identify (but
> fail to open) the files of the other version number.


--KffxMskVWqd17H4tIr0eM02i4DwouqgAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloK8FUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AY+YIAK8M8TnxIx9/bsLj3jPrTmv50CxDWUB2
rnIefVUqk3G3EaP6qxdXYVBMjX24z+EL8EWWTo3u4uAUrt65e0j066pbpPpmK2l0
yeftbEH1+gyMtTDj9msRN38EV4LRxclQwzySMCIMZSFCCEwhD7tvqTh5DXOQGFmx
azOQBzk2gF1IPMD809yYlyigYxWy0DFpqetXiz3D+LOevRBTWrqfPSQZgEtW4kiN
KwMDH6i1zWzTuLrp4EJ6hUHE3NghPTViDVSnMy066pidXOamcpNqewHpULnGXOKm
lA/hQROQU38Q3wZR/x/YiwDSW3RzHHae2z6m2igQQIWh+SwPSSPr7w4=
=1MeB
-----END PGP SIGNATURE-----

--KffxMskVWqd17H4tIr0eM02i4DwouqgAD--
