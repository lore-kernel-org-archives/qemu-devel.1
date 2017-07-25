Received: from eggs.gnu.org ([2001:4830:134:3::10]:44299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1da5Ck-00028D-I2
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1da5Ch-0002tH-Dr
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:09:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64877)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1da5Ch-0002sb-3N
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:09:11 -0400
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-4-apahim@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <75816277-a3cd-3114-2732-d138eb4fb21f@redhat.com>
Date: Tue, 25 Jul 2017 15:08:56 -0400
MIME-Version: 1.0
In-Reply-To: <20170725171014.25193-4-apahim@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5nh6vtHXgWtjcjoOC0JGhAxwlB07ac3kl"
Subject: Re: [Qemu-devel] [PATCH v5 3/6] qemu.py: cleanup message on
 negative exit code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, ldoktor@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5nh6vtHXgWtjcjoOC0JGhAxwlB07ac3kl
From: Cleber Rosa <crosa@redhat.com>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com,
 ldoktor@redhat.com
Message-ID: <75816277-a3cd-3114-2732-d138eb4fb21f@redhat.com>
Subject: Re: [PATCH v5 3/6] qemu.py: cleanup message on negative exit code
References: <20170725171014.25193-1-apahim@redhat.com>
 <20170725171014.25193-4-apahim@redhat.com>
In-Reply-To: <20170725171014.25193-4-apahim@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/25/2017 01:10 PM, Amador Pahim wrote:
> The message contains the self._args, which has only part of the
> options used in the qemu command line and is not representative
> enough to figure out what happened to the process.
>=20
> This patch drops the self._args part of the message.
>=20

Since this patch comes after the proposed "self._args" rename, it should
use the new name.

> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index f37e2fe58e..56142ed59b 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -154,7 +154,8 @@ class QEMUMachine(object):
> =20
>              exitcode =3D self._popen.wait()
>              if exitcode < 0:
> -                sys.stderr.write('qemu received signal %i: %s\n' % (-e=
xitcode, ' '.join(self.args)))
> +                sys.stderr.write('qemu received signal %i\n' % -exitco=
de)
> +
>              self._load_io_log()
>              self._post_shutdown()
> =20
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--5nh6vtHXgWtjcjoOC0JGhAxwlB07ac3kl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZd5dIAAoJEGV+jTOl8gnzd2oP/ReZiC3AXOD0ztfjzxJyQad7
+QG7DJXf7qS9qhPN6EkclD7F2u6W8YTokDWRtOtNgj6WWpJt07/aFW/gTka3Pb0e
dtMdFHI95AKGl+RFDw3CZIKIHXV4fKUOAYUMjiBR9ADt+BulBTA36z2ytb4sXAC4
dLnGPdK0ywf5W1uMcevTtabIx/RH5OjGUDZrbYcFzCG7WBi8hGHRfxkQAlGEEnNN
QNNIRQ0bU7q8NF8eWLDHyb7vmQ4rxg8sbbqR8yI/x5btYxTWogaySMHlzw8c6Ifg
6T/iiCj7INl52A5oN5FAdW1W4agXE9rHmmhkmq2H5hCStZp0efR8qcajQUf1Xzum
/V96QpKqNvSIMmfPIGjrjKWQUaK6qCHrssQPrc4Hbcei3MeUCdDcn2GPHnpky/S0
EMrPwOinxvnSogc1Ky09TZWHJSOl82zYFVMQEr0qXU5yFrDYjTWIHHujOUWMsU9R
h6ABDk9HcxDfgDy7GrYpwLAf3HyKlHHttWi0Qvib8/5InWIDMFZxFpQdZpteRMEU
0J+D1rr0YgBKwdgrvqra9afKHqb+MhsRczR47QrE4nUjba8+edVx+D64gLhNxGll
T/e8pA3+jW2E9FCvF0viKqb/IyKjpdxUP9ocAxxIqq1ydVCvxGEb4DW4GjeneKIO
pbMf0eJLZub4xjLyIubo
=0Kn5
-----END PGP SIGNATURE-----

--5nh6vtHXgWtjcjoOC0JGhAxwlB07ac3kl--
