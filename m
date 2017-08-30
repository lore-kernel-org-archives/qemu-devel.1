Received: from eggs.gnu.org ([2001:4830:134:3::10]:40662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn5Kt-0001iv-BZ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn5Ko-0003bQ-HE
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:55:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dn5Ko-0003b5-6q
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:55:18 -0400
References: <20170818170526.13496-1-apahim@redhat.com>
	<20170818170526.13496-8-apahim@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <aff4b90a-1109-8fee-43de-1e1f42f893ea@redhat.com>
Date: Wed, 30 Aug 2017 11:55:05 -0400
MIME-Version: 1.0
In-Reply-To: <20170818170526.13496-8-apahim@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4Q3UtHsMEqHgrMbd5HtKQW8jP9eGmBIBh"
Subject: Re: [Qemu-devel] [PATCH v7 07/11] qemu.py: include debug
 information on launch error
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
--4Q3UtHsMEqHgrMbd5HtKQW8jP9eGmBIBh
From: Cleber Rosa <crosa@redhat.com>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com,
 ldoktor@redhat.com
Message-ID: <aff4b90a-1109-8fee-43de-1e1f42f893ea@redhat.com>
Subject: Re: [PATCH v7 07/11] qemu.py: include debug information on launch
 error
References: <20170818170526.13496-1-apahim@redhat.com>
 <20170818170526.13496-8-apahim@redhat.com>
In-Reply-To: <20170818170526.13496-8-apahim@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/18/2017 01:05 PM, Amador Pahim wrote:
> When launching a VM, if an exception happens and the VM is not
> initiated, it might be useful to see the qemu command line and
> the qemu command output.
>=20
> This patch creates that message. Notice that self._iolog needs to be
> cleaned up in the beginning of the launch() to make sure we will not
> expose the qemu log from a previous launch if the current one fails.
>=20
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 0bcec4b3b1..29fd2469f9 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -147,6 +147,7 @@ class QEMUMachine(object):
> =20
>      def launch(self):
>          '''Launch the VM and establish a QMP connection'''
> +        self._iolog =3D None
>          self._qemu_full_args =3D None
>          devnull =3D open(os.path.devnull, 'rb')
>          qemulog =3D open(self._qemu_log_path, 'wb')
> @@ -162,6 +163,13 @@ class QEMUMachine(object):
>              self._post_launch()
>          except:
>              self.shutdown()
> +
> +            LOG.debug('Error launching VM')
> +            if self._qemu_full_args:
> +                LOG.debug('Command: %r', ' '.join(self._qemu_full_args=
))
> +            if self._iolog:
> +                LOG.debug('Output: %r', self._iolog)
> +

Based on Fam's comment about the signal message being a warning (worth
showing by default), I also think this deserves more than a "debug"
classification.

- Cleber.

>              raise
> =20
>      def shutdown(self):
>=20


--4Q3UtHsMEqHgrMbd5HtKQW8jP9eGmBIBh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmm39kACgkQZX6NM6Xy
CfMsdBAAhIhVKDj7gGQe0HTT8xLFfsIpP/vSYyo5aXd//NW4BjAdLgQ8KetSn/se
67/thquOfFgP0q9QUnbPJdpaeL0mPLY14yPrx5gdz/VnBV02GwzTNXfa+vINIeuz
HkCpS3x5L74svCP+2w00QR3Iw/vmwhQDzukTw6P/qc0R2g9uhFzqf8frvzL+Sxjv
98wr25MOW4hXiC0FPDZCMxJzRFKHtE/YWdiJv8ynIQ6m5r9abKlW1LYei4nNq3Yw
il1nWaXujNxYjqkO+c4XsrvISakxRnGfBoCVJqkFKno8f5yRklzmLdjUcgo7uBNe
SCU5TkfOEUEXAA+0bD4BmrFe+IHVE3gRw/cgJGHrC3JyRsMnsf7rbj/rrZ0vrChd
9E9V842Mtm4uOXYdkPbWxBbEUStgZ8k2WkZY9Kpsb1rmFchncrkBIWsnvQ0UZLVL
HhKvPr+6UcpWLekMuu1W1Jpcq4r0QYyaGgIV7XUefmlCipudZb+Vi9lTG4F7fNZP
zObggkfwkE2sK0bfYzifnQQXsx6QAIRU+OuCHtLDkq3vKZpwjFr4wFjCkVmBE62P
qCAGvoAaZ8YgjsDqRfD88RQ31zFDlktw7bGJR2xbNQpIVe9awCJ74yTvF/gmmE0G
h0lg2Tx43lrw7vl9EnDxTFXBCLJCh9BPZra9cNVUvixpIs/gwJg=
=wTsj
-----END PGP SIGNATURE-----

--4Q3UtHsMEqHgrMbd5HtKQW8jP9eGmBIBh--
