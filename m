Received: from eggs.gnu.org ([2001:4830:134:3::10]:36799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eij7k-0006Lr-KA
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eij7h-00052m-HG
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:56:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eij7h-00050S-6x
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:56:01 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-10-armbru@redhat.com>
	<1ec446ca-a469-7950-bea1-c832cbaf9fa3@redhat.com>
	<878tca4ez9.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13b80daf-db39-8183-2836-a13b2d4ef21b@redhat.com>
Date: Mon, 5 Feb 2018 09:55:54 -0600
MIME-Version: 1.0
In-Reply-To: <878tca4ez9.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K2sRP1oQtNAAczdKM5eRVPhv02KBPGxsO"
Subject: Re: [Qemu-devel] [PATCH RFC 09/21] qapi: Don't absolutize include
 file name in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K2sRP1oQtNAAczdKM5eRVPhv02KBPGxsO
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <13b80daf-db39-8183-2836-a13b2d4ef21b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 09/21] qapi: Don't absolutize include
 file name in error messages
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-10-armbru@redhat.com>
 <1ec446ca-a469-7950-bea1-c832cbaf9fa3@redhat.com>
 <878tca4ez9.fsf@dusky.pond.sub.org>
In-Reply-To: <878tca4ez9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2018 03:08 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>>> Error messages print absolute filenames of included files even gave a=

>>
>> s/even gave/even when given/
>=20
> I meant to write "even if the user gave".  Is that okay?

Yes, that works too.

>=20
>>> relative one on the command line:
>>>
>>>      PYTHONPATH=3Dscripts python -B tests/qapi-schema/test-qapi.py te=
sts/qapi-schema/include-cycle.json
>>>     In file included from tests/qapi-schema/include-cycle.json:1:
>>>     In file included from /work/armbru/qemu/tests/qapi-schema/include=
-cycle-b.json:1:
>>>     /work/armbru/qemu/tests/qapi-schema/include-cycle-c.json:1: Inclu=
sion loop for include-cycle.json
>>>
>>> Improve this to
>>>
>>>     In file included from tests/qapi-schema/include-cycle.json:1:
>>>     In file included from tests/qapi-schema/include-cycle-b.json:1:
>>>     tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for incl=
ude-cycle.json
>>
>> Nice, and makes developing new qapi tests a little less painful since
>> it's less modification to qapi-schema/*.err additions.
>=20
> Probably not, as our make rule strips off $(SRC_PATH):
>=20
> 	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -q $(SRC_PATH)/=
$*.err -
>=20
> I've kept that, because it might also occur in stack backtraces.  I
> think.

I still recall having to hand-edit .err files when doing a naive "run
the test to get the failure, then 'mv' the bad files into the expected
filenames, then rerun the tests"; so I'm not sure if our make rule was
properly munging absolute names out of the file in the first place.  I'm
not too fussed about it, though, as adding new tests is less frequent
and it's still fairly easy to learn if you did it right or not by
whether 'make check' succeeds.

>=20
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  scripts/qapi/common.py                | 12 ++++++------
>>>  tests/qapi-schema/include-no-file.err |  2 +-
>>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Thanks!
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--K2sRP1oQtNAAczdKM5eRVPhv02KBPGxsO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp4fooACgkQp6FrSiUn
Q2oYRAgAn+SpDOmF+O4+b2IB2Ilr6iy1UoHShk517HcFTDqwS0hafCFygPw89Olp
W4aTA8rk+ALD74FVZXNRYWgBybGvkeM4f7TmYgW3/Fh6sTFJOSpvQA1XuI1+SKJp
qbD/MJlq8Tjy3dUqS9xYXNcbvFrSeUh3vUroWAZPOBwQHd1AHX4zpLBGOGZOgEAA
OaUNSzVP6xbCeVPbO1F2IaMJGWWkmlyex5u1TVyb0ZbbgSwc9Hh2DFbaIYWmQgka
cQo6KWC6UGQLa0v4lQ7VaT+LZ8r4Ajp4+oyF34dbEz9dObgCJ61/hNGiGzhIIh6z
+UmsRr0mWwFut8jjjykMgHFs8xwyUw==
=ALMB
-----END PGP SIGNATURE-----

--K2sRP1oQtNAAczdKM5eRVPhv02KBPGxsO--
