Received: from eggs.gnu.org ([2001:4830:134:3::10]:36556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekDGn-0003O4-TH
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekDGn-0001Hs-2h
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:19:33 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-10-kwolf@redhat.com>
	<1386f182-a2c9-1c86-cb0e-ac01c50cde4e@redhat.com>
Message-ID: <e388e9fd-132f-1938-f09a-260abc9c2231@redhat.com>
Date: Fri, 9 Feb 2018 19:19:25 +0100
MIME-Version: 1.0
In-Reply-To: <1386f182-a2c9-1c86-cb0e-ac01c50cde4e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Da4f8hkQ4hHlXMZ4yEjCsqBjEHDWd2vwk"
Subject: Re: [Qemu-devel] [PATCH 09/27] qdict: Introduce qdict_rename_keys()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Da4f8hkQ4hHlXMZ4yEjCsqBjEHDWd2vwk
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <e388e9fd-132f-1938-f09a-260abc9c2231@redhat.com>
Subject: Re: [PATCH 09/27] qdict: Introduce qdict_rename_keys()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-10-kwolf@redhat.com>
 <1386f182-a2c9-1c86-cb0e-ac01c50cde4e@redhat.com>
In-Reply-To: <1386f182-a2c9-1c86-cb0e-ac01c50cde4e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-09 19:18, Max Reitz wrote:
> On 2018-02-08 20:23, Kevin Wolf wrote:
>> A few block drivers will need to rename .bdrv_create options for their=

>> QAPIfication, so let's have a helper function for that.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  include/qapi/qmp/qdict.h |  6 ++++++
>>  qobject/qdict.c          | 30 ++++++++++++++++++++++++++++++
>>  2 files changed, 36 insertions(+)
>=20
> Hmmm, looks OK, but I wonder whether this is going to be any more
> efficient than if we simply had a qdict_rename_key() function that you
> call multiple times.
>=20
> ("efficient" both in terms of code readability and runtime efficiency)
>=20
> So, I'll give you a
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> and let you decide.

Ah, I see, error handling is much easier this way, that's right.  OK,
R-b stands then.

Max


--Da4f8hkQ4hHlXMZ4yEjCsqBjEHDWd2vwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp95i0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AFXgIAKMupGM1BRrbnURrPGUSbvEr/oyND6qs
1EMpIk85GAiXRI9HIwPaGQrepa0nNS1+Nu8vAg48HiWWmk6CoBO90yVaBdN/lML0
LDK0NIfZWvyapT+TAOwzvvnSvdVrt0Q68NZv1gG3og2tdTMoz28ZKjR/y9dq4xXv
WAJ6hBDV+6MYqeDltao9spy73g/Q5oSLMfTXsIplXi8ECTImoMsIpZlJm/45IEg6
4bKXUMJAW02H8dcs25neX8/EjDtO9+mkB0bxURlU7PL372leUNlbtZJQCfK+bb/o
03R1GoAWr0HTtNhipnZ42V1M0R4Ra9EgR9qCbH83y880G3MpMQrZloM=
=oiaW
-----END PGP SIGNATURE-----

--Da4f8hkQ4hHlXMZ4yEjCsqBjEHDWd2vwk--
