Received: from eggs.gnu.org ([2001:4830:134:3::10]:60766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIwnE-0004GK-4D
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIwn9-0004cw-5o
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:44:04 -0400
References: <1496907604-2393-1-git-send-email-thuth@redhat.com>
	<20170608111616.GA14424@lemon.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9b595fb3-e73e-92a8-559d-c55382545879@redhat.com>
Date: Thu, 8 Jun 2017 14:43:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170608111616.GA14424@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="E5nov9BOTvPeL5kG9iiC7ucXNSIXl8ucx"
Subject: Re: [Qemu-devel] [PATCH v2] Makefile: Do not generate files if
 "configure" has not been run yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E5nov9BOTvPeL5kG9iiC7ucXNSIXl8ucx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.06.2017 13:16, Fam Zheng wrote:
> On Thu, 06/08 09:40, Thomas Huth wrote:
>> When doing a "make -j10" in the vanilla QEMU source tree (without
>> running "configure first), the Makefile currently generates two
>> files already, qemu-version.h and qemu-options.def. This should not
>> happen, so let's make these targets depend on config-host.mak.
>> Also the targets that use python  can not be executed without the
>> $(PYTHON) from config-host.mak, so these should depend on the config-
>> host.mak file, too (these targets generate some ugly error messages
>> otherwise during "make -j10").
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2:
>>  - Add the dependency to the targets that use $(PYTHON) instead of
>>    adding it to $(qapi-py)
>>
>>  Makefile | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index c830d7a..b5e0731 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -286,7 +286,7 @@ endif
>> =20
>>  all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
>=20
> Is it enough to add a
>=20
>     $(filter-out $(GENERATED_FILES),config-host.mak): config-host.mak
>=20
> after the variable is fully built?  (Seems config-host.mak is not inclu=
ded, but
> filtering out is safer.)

That works for the files that I've mentioned in the patch description,
but I then suddenly see lots of *.pyc files in scripts/tracetool instead.=
=2E.

Anyway, I think I've now found a way that works even more reliable:
Simply disable the "Makefile: $(GENERATED_FILES)" rule if
config-host.mak is missing. I'll send a v3 patch in a minute...

 Thomas


--E5nov9BOTvPeL5kG9iiC7ucXNSIXl8ucx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZOUaIAAoJEC7Z13T+cC210vcQAIq6edH7rfQRpdV2VNhDig5F
VgGgSvxZGLlbZU485LHExpglKhzchaNKVkJbdGeuuqUo+ixTAJMsaozV6pSTDN2u
M/B2VdqHwQQRIiYgcqNv7AqCzeBJnJxAjKORxcr4V7pgvPlMdgqmhSkoersz8WAp
6RjSBp95SC0oZh5o4s9BC3GA75I7XsPPjlsGxCxQFqvGpKi16FtjiP0EJ48dr2lE
BypfBlLj1MkEjYnQVH2p6R+/klpTz2HvuQ8IeAB5bEOH09dQ34uI/Xn7le8PosJ4
Y/8/oBcS11QZkf7vCwE7BFNHARbv2ruwgLxd4waG8HNzQ6OUihaC3bZK+v/QrnAb
2OQxKVxjzAAr3zGB0AGf7aHScskGDYnx9bZU2dhdf4VqWeLU2QN6HdVUm+r2E55h
tt3tVQNeRqYxBCd5dl6NK3gDe6C6JJ9CYLV5J3CK3Gkr5ybDpZS26qSaql7hJRUX
UECv1MdHsJogcri3d4zJJ+HKJ9QbzRNHXgenDFJxDEalXGqJNbEbHBMxm466P65b
p6ck2cGId4TE6C0y/sGaekBSsbQDy25acEiCv75BD6/xtzf/TTO5rJZRf2S4CYdP
HrYWZ4tblV+KFpl05g2bXPEn4PIfvUD0fP12HNiDlIq4nv1j9yDlUXXw7mLBYUmJ
DegJBa/pXd6s9Qfa4OhW
=SaAE
-----END PGP SIGNATURE-----

--E5nov9BOTvPeL5kG9iiC7ucXNSIXl8ucx--
