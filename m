Received: from eggs.gnu.org ([2001:4830:134:3::10]:48752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dn0xn-0001rG-Dx
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dn0xm-00014q-6C
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:15:15 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
	<b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
	<cfcca274-9e3b-a9d5-6470-6c8917085da4@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <46ac5b4a-b50d-4d0e-a874-12f127f3ab40@redhat.com>
Date: Wed, 30 Aug 2017 13:14:51 +0200
MIME-Version: 1.0
In-Reply-To: <cfcca274-9e3b-a9d5-6470-6c8917085da4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kCRtn2xvAsuij3nxmeN4JTskBQx2WiL5r"
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kCRtn2xvAsuij3nxmeN4JTskBQx2WiL5r
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <46ac5b4a-b50d-4d0e-a874-12f127f3ab40@redhat.com>
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
 <a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
 <cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
 <0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
 <b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
 <cfcca274-9e3b-a9d5-6470-6c8917085da4@redhat.com>
In-Reply-To: <cfcca274-9e3b-a9d5-6470-6c8917085da4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-29 03:18, John Snow wrote:
>=20
>=20
> On 08/25/2017 09:44 AM, Max Reitz wrote:
>> On 2017-08-25 02:55, John Snow wrote:

[...]

>>> In (1), we avoid saving or specifying the relationship between these =
two
>>> data stores in any way. This is certainly easy to do, and will save u=
s
>>> some headache on the CLI. As a downside, we now have random orphaned
>>> files that aren't very interesting or useful on their own. The
>>> likelihood for desync between metadata and data increases. The use of=

>>> management software is all but necessitated.
>>>
>>> In (2) We have to now specify, with a dizzying long list of
>>> possibilities, the location of the implementation data. qcow2 only ha=
s a
>>> filename for backing files presently, but this is likely inadequate.
>>> What if the data store isn't a locally kept file? What if it's a sock=
et,
>>> or a stream, or literally anything else?
>>
>> I don't see the difference.  In (1), your data image gets a "bitmap" o=
r
>> "metadata" child.  In (2), your qcow2 image gets the usual "backing"
>> child, or maybe call it "passthrough" or whatever, if you want to make=

>> the difference more explicit than just passing an option to the qcow2
>> image to pass writes to its backing file.
>>
>=20
> The difference in the relationship in-memory is actually kind of
> uninteresting.
>=20
> The difference as I see it is primarily how we specify the relationship=

> between the qcow2 and the implementation storage; in (1) It's defined
> on-disk, and in (2) It's defined via CLI only, so
>=20
> (1) Incurs a cost of having to define the link syntax (possibly causing=

> a rather qemu-specific syntax), and
> (2) Avoids that cost, but leaves the data on-disk unrelated, which you =
hate.

What I meant was that in the end both have some parent-child
relationship in the BDS graph, so you can freely define both on the CLI.
So for (1), it usually is defined on-disk, yes, but you can also define
it on the command line -- just like it works for backing files.

>>> We'd have to develop a new syntax for specifying these resources that=

>>> can be stored in a qcow2 file,
>>
>> It's called the json-pseudo-protocol and was developed exactly for thi=
s.
>>
>=20
> That's what I was hinting at for "or otherwise co-opt an existing
> syntax" but I was unaware that it was intended for "exactly" this.
>=20
> Do we actually use it in any on-disk format, currently? qcow2 only lets=

> you specify simple filenames in the qcow2 metadata, right?

I don't think it's specified.  And I'm pretty sure that people would
agree that e.g. HTTP URLs are fine to specify in the backing link field.
 So I think that non-simple filenames are fine, too, but the question of
course is where to draw the line.

I'd argue that every time your start to allow filenames to have
protocols, you end up with some that not all programs can interpret;
like the json: protocol.

>>>                                or otherwise co-opt an existing syntax=

>>> in-use by QEMU. This syntax would likely be useful only to QEMU, whic=
h
>>> would steer the qcow2 format in a direction not too useful by other
>>> emulators, and qcow2 is an open format, so we may want to avoid this.=

>>
>> Storing a file name in the backing link field that cannot be interpret=
ed
>> by other programs is in my opinion still very much better than not
>> storing any information whatsoever, because in the former case other
>> programs can at least say "sorry, I have no idea what this means" (or
>> maybe they can indeed interpret it, who knows), whereas in the latter
>> they may not even know that the qcow2 image is incomplete.
>>
>=20
> I don't disagree personally, but I seem to recall that Kevin was adaman=
t
> that the qcow2 bitmap extension should remain useful and semantically
> meaningful to third parties, so I try to keep that in mind. Maybe I
> should let him chime in instead of try to "concern troll" my own
> suggestions into the ground.

I seem to recall that I was adamant, too. :-)

All I'm saying is if you allow qcow2 to have writable backing files, it
doesn't make it any less meaningful to 3rd party programs than the
backing link field currently is.

>> Also note that we are making an effort to be able to generate plain fi=
le
>> names (such as URLs which should be usable by other programs) whenever=

>> possible.
>>
>=20
> Noted. Do we have a useful discriminator anywhere that allows us to
> easily check if a filename/locator/URI/whatever is in an accepted
> format, or if we still have QEMU-specific garbage?

Are NBD URLs qemu-specific? :-)

I think protocol URLs are just always icky.  If it's json: (when
bs->exact_filename is empty), you can be sure it's qemu-specific --
otherwise, it may be.

> We could always just disallow QEMU-specific protocol-talk from getting
> written and allow this only for configurations that QEMU understands to=

> be universal...

I'd say it's too late for that, and also that json: was introduced
precisely to be able to get full BDS graph configuration into a backing
filename field.

[...]

>> OTOH, there is one issue I have with the R/W backing approach: Every
>> request to the raw file has to go through the qcow2 layer.  And since
>> you probably want to use raw because of the speed, this is not so nice=
=2E
>>
>=20
> We probably could fix that by changing the relationship so that it isn'=
t
> *really* a backing file, but that maybe creates other problems.

Yes.  This will be reflected in the BDS graph relationship, and it's
just weird that sometimes a qcow2 backing file would be loaded as its
parent.

Max


--kCRtn2xvAsuij3nxmeN4JTskBQx2WiL5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlmmnisSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aj1MH/i0/Ds8aLZ5CSk7uzvPEqa+PPl+sarlI
EGtrIsrmKzTQXMwG/qysDOpld3vJ9O93htvZnub8ndxiGY3nNzrQhxFmPeNG9eyj
68MaRgF7cCsjEDWr0Sg0Kecu6BAnyXBKbJqbIWKYpKx9gUEbxWUFhNEyEVzB0EGK
uyv/18h0YoPPa5QvhnccLbf6HPzeyq8DdGEZ5UxCANX5RGLXp59+o3Uz4GssTJeS
Y1Fp1IHjAwz9jWdgPERgf3FJBrAh4tm8tm2qV+Tw9NeB0bkd6RzA5fR3NUiQ4+v/
olCgi/nRed2N52jb8+FbdOqlv2IMR/1vtb2zO4vux/s90J7d5lsn+Ko=
=CmK2
-----END PGP SIGNATURE-----

--kCRtn2xvAsuij3nxmeN4JTskBQx2WiL5r--
