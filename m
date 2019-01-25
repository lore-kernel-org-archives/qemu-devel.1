Received: from eggs.gnu.org ([209.51.188.92]:46379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gn1aB-0002jQ-Vy
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gn1aB-0002TA-7e
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gn1aA-0002Sg-UO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:43 -0500
References: <003301d4b494$775585c0$66009140$@ru>
	<20190125101032.GA4498@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c01e8238-5da8-aaf5-8ab2-1484f8cd0871@redhat.com>
Date: Fri, 25 Jan 2019 07:31:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190125101032.GA4498@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QSLWj2H8zbWvQ8qkW4W4EKl8NhS1WGgz5"
Subject: Re: [Qemu-devel] Querying possible -cpu variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, =?UTF-8?B?J9Ck0YPRgNGB0L7QstCwINCd0LDRgtCw0LvQuNGPJw==?= <Natalia.Fursova@ispras.ru>, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QSLWj2H8zbWvQ8qkW4W4EKl8NhS1WGgz5
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 =?UTF-8?B?J9Ck0YPRgNGB0L7QstCwINCd0LDRgtCw0LvQuNGPJw==?=
 <Natalia.Fursova@ispras.ru>, armbru@redhat.com
Message-ID: <c01e8238-5da8-aaf5-8ab2-1484f8cd0871@redhat.com>
Subject: Re: [Qemu-devel] Querying possible -cpu variants
References: <003301d4b494$775585c0$66009140$@ru>
 <20190125101032.GA4498@redhat.com>
In-Reply-To: <20190125101032.GA4498@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/25/19 4:10 AM, Daniel P. Berrang=C3=A9 wrote:

>=20
>> 2.       Add QMP command for requesting this list.
>=20
> This already exists as the 'query-cpu-definitions' command

What's more, you can use libvirt code as an example of how to parse QMP
commands to see what features are present.  And if the existing QMP
commands don't answer a question you need answered, enhancing QMP is a
worthwhile patch (other projects, like libvirt, will probably also end
up using those enhancements).  Among other things, we know that our
command-line parameters are not yet fully queryable by QMP.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--QSLWj2H8zbWvQ8qkW4W4EKl8NhS1WGgz5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxLD7cACgkQp6FrSiUn
Q2oflgf/Z68U8qbZHxNDNUVd1iqiP6y0NGe8BLW5+bhAZbpLqn74QRM1ZSWYidiO
mzJC2SyzzBTLkc7Y3qinFxqVHLhwY/xoDmVDTA12pmWBRVVXhtYuEHNVZrZeDzhL
f7TvJb4er4AZZkEk5rVKy78YrhlCyF1ZWwDoTy5EEFKjTW+BUW4XRF9JBkJOC5qS
CNITExFurCT/6GDNp3u1lIngWKWJQQ/BiXu6UlxTydEv5P/xDi3SCL5k/QMLM/vK
OMwVJab8ZXGHLaSwRCb6LHvg32Fl2qZ7xpCfQzWrCDAk6nKPdLu40p32WkI0L/py
csoXT1tQ3GLRaen47/aMY75Mx+0bfg==
=YNnu
-----END PGP SIGNATURE-----

--QSLWj2H8zbWvQ8qkW4W4EKl8NhS1WGgz5--
