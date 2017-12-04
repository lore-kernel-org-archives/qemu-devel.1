Received: from eggs.gnu.org ([2001:4830:134:3::10]:60771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLvKM-0005VT-Hb
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLvKL-00088j-Fh
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:18:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eLvKL-00088B-5V
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:18:49 -0500
References: <20171204151741.14485-1-danielhb@linux.vnet.ibm.com>
	<20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2074679b-addd-49d6-503b-ca33e3a5a8af@redhat.com>
Date: Mon, 4 Dec 2017 19:18:45 +0100
MIME-Version: 1.0
In-Reply-To: <20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ISWgLqf9EQgBoVW6SEoW3j9QOKvf6hRi2"
Subject: Re: [Qemu-devel] [PATCH v4 1/1] tests/qemu-iotests: adding
 savevm/loadvm with postcopy flag test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ISWgLqf9EQgBoVW6SEoW3j9QOKvf6hRi2
From: Max Reitz <mreitz@redhat.com>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Message-ID: <2074679b-addd-49d6-503b-ca33e3a5a8af@redhat.com>
Subject: Re: [PATCH v4 1/1] tests/qemu-iotests: adding savevm/loadvm with
 postcopy flag test
References: <20171204151741.14485-1-danielhb@linux.vnet.ibm.com>
 <20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
In-Reply-To: <20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-04 16:17, Daniel Henrique Barboza wrote:
> This patch implements a test case for the scenario that was failing
> prior to the patch "migration/ram.c: do not set 'postcopy_running' in
> POSTCOPY_INCOMING_END", commit acab30b85d.
>=20
> This new test file 201 was derived from the test file 181 authored
> by Kevin Wolf.
>=20
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  tests/qemu-iotests/201     | 116 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/201.out |  23 +++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 140 insertions(+)
>  create mode 100755 tests/qemu-iotests/201
>  create mode 100644 tests/qemu-iotests/201.out

Thanks, I've added the patch to my block-next branch for 2.12:

https://github.com/XanClic/qemu/commits/block-next

(Technically, tests can be added at any time, but I guess we don't want
any patches before the release at this point.)

Max


--ISWgLqf9EQgBoVW6SEoW3j9QOKvf6hRi2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlolkYUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANekIALtAPHLiZPh3pmV7/0DI7AGE36UQXZ3p
9bk3jbAHVtJKZCJLdilhUKfsanu/FvRQYd+jd1DBbQ6JajBvyoE+m2wy+WKmHhun
UO41QS3NXurP5yrvwru82W96Pka1DyJ3LLFGN9JH1/NCBgRkcJxNPRJR+2nVhHbM
Bjbq6tsiAMRig2CAJihGbLMoTJpjpPe9L9n657JbO177AVb6Ua3rXb2v24yPnzne
9DniUMg99BDsT3Y/uNcW5NO2QEv1cr9atf9lxo38yT3WUutOxEAlJd100y3ldxS9
LqoTPbmfSt2gS4XWIt5R2knWQl5mdCkAJvJ6Z0TFr7ldi/U8brwsQf0=
=5zcN
-----END PGP SIGNATURE-----

--ISWgLqf9EQgBoVW6SEoW3j9QOKvf6hRi2--
