Received: from eggs.gnu.org ([2001:4830:134:3::10]:59290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIp73-0002w8-2H
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIp6z-0003JV-3g
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:32:01 -0400
References: <1496862674-23626-1-git-send-email-thuth@redhat.com>
	<df973d1f-cbb1-22c1-5763-f29001a16fd8@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <41c49a06-d8ce-ebd5-8956-2e6e1f010c36@redhat.com>
Date: Thu, 8 Jun 2017 06:31:45 +0200
MIME-Version: 1.0
In-Reply-To: <df973d1f-cbb1-22c1-5763-f29001a16fd8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dGLupwaRi0R5qaVpbaklkpq3x7lhN4Uxc"
Subject: Re: [Qemu-devel] [PATCH] Makefile: Do not generate files if
 "configure" has not been run yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dGLupwaRi0R5qaVpbaklkpq3x7lhN4Uxc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.06.2017 22:59, Eric Blake wrote:
> On 06/07/2017 02:11 PM, Thomas Huth wrote:
>> When doing a "make -j10" in the vanilla QEMU source tree (without
>> running "configure first), the Makefile currently generates two
>=20
> s/"configure/"configure"/
>=20
>> files already, qemu-version.h and qemu-options.def. This should not
>> happen, so let's make these targets depend on config-host.mak.
>> Also the python files can not be executed without $(PYTHON), so
>> these scripts should depend on config-host.mak, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Makefile | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index c830d7a..6786dc2 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -286,7 +286,7 @@ endif
>> =20
>>  all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
>> =20
>> -qemu-version.h: FORCE
>> +qemu-version.h: config-host.mak FORCE
>=20
> This one makes sense.
>=20
>> @@ -393,6 +394,8 @@ gen-out-type =3D $(subst .,-,$(suffix $@))
>> =20
>>  qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddi=
ct.py
>> =20
>> +$(qapi-py): config-host.mak
>=20
> But this one is weird. How can a pre-existing file have a dependency?
> Remember, $(qapi-py) is not the list of built files, but the list of
> files used to build other files.  It seems like you either want
> config-host.mak includes in $(qapi-py), or...
>=20
>> +
>>  qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types=
=2Eh :\
>>  $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(=
qapi-py)
>=20
> ...that THIS should be the rule that depends on config-host.mak in
> addition do depending on $(qapi-py).

Yes, it's all those targets that use $(PYTHON) which should depend on
config-host.mak instead. But there are lots of them, and all of them
depend on $(qapi-py) already, so it seemed simpler to make $(qapy-py)
depend on config-host.mak instead of adding that dependency to all those
targets ... but maybe that's too confusing in the long run, so I'll add
it to those targets instead.

 Thomas


--dGLupwaRi0R5qaVpbaklkpq3x7lhN4Uxc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZONM2AAoJEC7Z13T+cC212a0QAJPQoyQDASit4KgDe3JhL7l/
NPmNIu3wAi85KS+E3YYJpiKM4Y2TUE7W8MajLwiMJnC8jlDQvQGbnsFuAASnqPCa
/uoS+EQp3wNRQ4XbA3lkIufHdIGKUTWhlzIoML2A6nCcVTxuL0B+Wum+sCGNGAPI
HVknAbYMFi+GfhYVNDCwQk42am6HLOYdfgQqJMjkLvQZxb2Pe7BLaeXIo3mXrgIf
tlYJ0QxvW4PAuDSMlfcH1PsobTX3o0ss56PjOGIq+uILkIpiAqiVRL8N7uUL8r5g
ISHs2tt6vxDN7jLz1nTIhPCVP/Oe+Bnd9OVcsBasrwtSeF9QGqqfAZs71f+CabQb
qiOZcM1ybmw2ZY1JQ8SbYS7zGNmNJ3+i2NA1JiCDyzVez8Kf6uq/Khpl+rSsFzwy
ae1ZmN4NnfUPIp7SRnJIW/2naJhT4tYlWnewRpjCtaOWr9w0VOGvKEfqv1B3vJwf
W5hnSfxbBWRnf7rLFE/5xjIgmdx8m0KA/y8bLL+I8Ew8z3nMVQTeevtxFOWliUCb
7ZR0z4Pq2/gYKHMbzC4Eb7wkg5ZsFiaybdRu7eeRbd+ovID45TC5Cp1NaDIOOJyk
GTDtmzjtn3vNCQYB2QwV8Exsp372xMFSH8u6iU8dNXGFUIH5okhuvyay6ZTtm7aj
E+Q9c5ETQS0oiYdLSv2M
=HVmM
-----END PGP SIGNATURE-----

--dGLupwaRi0R5qaVpbaklkpq3x7lhN4Uxc--
