Received: from eggs.gnu.org ([2001:4830:134:3::10]:39580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb8O8-0003Mn-Tx
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb8O6-0007IO-8u
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:17:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eb8O6-0007HZ-0E
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:17:34 -0500
References: <20180115170243.24578-1-berrange@redhat.com>
	<20180115170243.24578-11-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88039710-1259-3868-0d67-febff24d36db@redhat.com>
Date: Mon, 15 Jan 2018 11:17:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180115170243.24578-11-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2PgHUI6maDshdZcdbcqiqas6s68qu1YP3"
Subject: Re: [Qemu-devel] [PATCH v4 10/13] input: add missing JIS keys to
 virtio input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Miika S <miika9764@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2PgHUI6maDshdZcdbcqiqas6s68qu1YP3
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miika S <miika9764@gmail.com>
Message-ID: <88039710-1259-3868-0d67-febff24d36db@redhat.com>
Subject: Re: [PATCH v4 10/13] input: add missing JIS keys to virtio input
References: <20180115170243.24578-1-berrange@redhat.com>
 <20180115170243.24578-11-berrange@redhat.com>
In-Reply-To: <20180115170243.24578-11-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 11:02 AM, Daniel P. Berrange wrote:
> From: Miika S <miika9764@gmail.com>
>=20
> keycodemapdb updated to add the QKeyCodes muhenkan and katakanahiragana=

>=20
> Signed-off-by: Miika S <miika9764@gmail.com>
> ---
>  hw/input/virtio-input-hid.c | 7 +++++++
>  qapi/ui.json                | 5 ++++-
>  ui/keycodemapdb             | 2 +-
>  3 files changed, 12 insertions(+), 2 deletions(-)

Why are you bumping the submodule here and again in 11/13? Can those two
patches be squashed together?


> +++ b/ui/keycodemapdb
> @@ -1 +1 @@
> -Subproject commit 10739aa26051a5d49d88132604539d3ed085e72e
> +Subproject commit 05dad417e9d0b37ee1fba33056d91a6b734b3357
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2PgHUI6maDshdZcdbcqiqas6s68qu1YP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpc4hsACgkQp6FrSiUn
Q2pGfwf7BoJqYhSMRRey1YjfhAZt4vAF01lgeL2bGMlVYAa0AhfG2V4Y7WbLTmO/
TMCv8hdBqU4N/+L6n7J5k9ouie+dMiI7jTB7MEzYQA5Y+RjT6sk58LjlrvTAYSwV
tNGgtRqaM0OC6wsUdahV9C7Kr6cRZPqCZPGiESq7XctTjYow3gSJPAIVujxCZ34v
7gb8J3PTfdLxyhkBJnfMRltZlKTiFS2Y00094DfQtV44lsqa5wgEawJfajOIQofe
NpygcC8jx9MGmxQOeO/9c0Le9TWS7/Xc4O+Mp8klBpX4Vy9Gjkn+LMnQOIBRDVJN
p+PW3UixOK8EHqew4O9gD7sMvLQM8w==
=Kk51
-----END PGP SIGNATURE-----

--2PgHUI6maDshdZcdbcqiqas6s68qu1YP3--
