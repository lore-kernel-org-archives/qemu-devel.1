Received: from eggs.gnu.org ([2001:4830:134:3::10]:56642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPlk-0006Oe-AT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPlg-0003Rw-2J
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:07:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBPlf-0003RM-Sq
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:07:52 -0400
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<20180425124631.17182.86824.stgit@pasha-VirtualBox>
From: Eric Blake <eblake@redhat.com>
Message-ID: <65c38edd-c24f-81ac-651a-99146f31c9e3@redhat.com>
Date: Wed, 25 Apr 2018 14:07:43 -0500
MIME-Version: 1.0
In-Reply-To: <20180425124631.17182.86824.stgit@pasha-VirtualBox>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3QS2ixVi3PgbguFwPqX6jBv0XEEHdRe9P"
Subject: Re: [Qemu-devel] [RFC PATCH 10/17] replay: implement replay_seek
 command to proceed to the desired step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3QS2ixVi3PgbguFwPqX6jBv0XEEHdRe9P
From: Eric Blake <eblake@redhat.com>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com,
 armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org,
 dgilbert@redhat.com, rth@twiddle.net
Message-ID: <65c38edd-c24f-81ac-651a-99146f31c9e3@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 10/17] replay: implement replay_seek
 command to proceed to the desired step
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
 <20180425124631.17182.86824.stgit@pasha-VirtualBox>
In-Reply-To: <20180425124631.17182.86824.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 07:46 AM, Pavel Dovgalyuk wrote:
> This patch adds hmp/qmp command replay_seek which proceeds the executio=
n
> to the specified step.
> It automatically loads nearest snapshot and replays the execution to fi=
nd
> the desired step.
>=20
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---

> +++ b/qapi/misc.json
> @@ -3502,3 +3502,19 @@
>  #
>  ##
>  { 'command': 'replay_break', 'data': { 'step': 'int' } }
> +
> +##
> +# @replay_seek:

This should be 'replay-seek'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3QS2ixVi3PgbguFwPqX6jBv0XEEHdRe9P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrg0gAACgkQp6FrSiUn
Q2qEfAf/YB99ASUxUIyM5zOq+XWSrRQ2E916VtDsJgjusjfCkbMOeeac50EBo2Lr
CAXq4gamTKssHr25gAKN+NrDfVql5f4AgmmvvyGObW46J6pYSi6wEvNsXKcb4Sys
KPJB3FoAsr7V02ZAKzeB4RQTdx2vUMd9FAZK23juOoEKqLbu3CIDQqv6J6CS9dT1
fB03zYEuIPFrbZTop/gZi5DOmgFQKiWG4Jq8xmcUVUD3UCYuYpumuecUZAil8xgX
DnACPCqE67ZEN8bYfLUsT7573Q+t0LcA1AfbG/cDhunTfzRYWSuxD/iOuCPCrmU1
cfQ/V57u1kjMfQspWWLt+rPp/fTB4A==
=NYrx
-----END PGP SIGNATURE-----

--3QS2ixVi3PgbguFwPqX6jBv0XEEHdRe9P--
