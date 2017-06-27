Received: from eggs.gnu.org ([2001:4830:134:3::10]:40293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPxpB-0003lR-1J
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPxp6-0002To-Ci
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:15:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPxp6-0002Ta-3e
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:15:00 -0400
References: <1498282754-2573-1-git-send-email-indiffPig@126.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07f317b7-906e-dc8b-feb0-62e4788b637f@redhat.com>
Date: Tue, 27 Jun 2017 16:14:57 -0500
MIME-Version: 1.0
In-Reply-To: <1498282754-2573-1-git-send-email-indiffPig@126.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LG4lxRvfn95OoUCOQwLBEUV7vHresG2ns"
Subject: Re: [Qemu-devel] [PATCH] qga:windows os lost ip when network nic
 change pic order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: indiffPig@126.com, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LG4lxRvfn95OoUCOQwLBEUV7vHresG2ns
From: Eric Blake <eblake@redhat.com>
To: indiffPig@126.com, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org
Message-ID: <07f317b7-906e-dc8b-feb0-62e4788b637f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qga:windows os lost ip when network nic
 change pic order
References: <1498282754-2573-1-git-send-email-indiffPig@126.com>
In-Reply-To: <1498282754-2573-1-git-send-email-indiffPig@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/24/2017 12:39 AM, indiffPig@126.com wrote:
> From: "yin.zuowei" <indiffPig@126.com>
>=20
> Signed-off-by: yin.zuowei <indiffPig@126.com>
>=20
> bug description: In the windows virtual machine, if there are multiple =
network cards, the hypothesis is that A/B/C is equipped with a different =
IP address. Once you delete a B card in the middle and restart the virtua=
l machine, you will find that the A/C of the network card IP has been con=
fused, and the IP of the C network card has become the address of B, and =
the service has been interrupted. So we did a IP recovery function in qga=
=2EThis is a serious problem that can lead to business disruption. If you=
 have a better plan, we would like to offer it to you.
> ---
>  qga/restoreIp.cpp | 1848 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 1848 insertions(+)
>  create mode 100755 qga/restoreIp.cpp
>=20
> diff --git a/qga/restoreIp.cpp b/qga/restoreIp.cpp
> new file mode 100755
> index 0000000..2382136
> --- /dev/null
> +++ b/qga/restoreIp.cpp
> @@ -0,0 +1,1848 @@
> +// restoreIp.cpp : =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=CC=A8=D3=A6=EF=BF=BD=C3=B3=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=DA=B5=E3=A1=A3

Your mail header said:

> Content-Type: text/plain; charset=3Dyes

which looks like a bug with your git settings (typically, it should be
charset=3DUTF-8).  Much of the message didn't render for me (not sure if
it lack of fonts on my end, or if it really was garbled en route rather
than being valid UTF-8 round-trip).  But we much prefer /* */ comments
over // (even in C++ code), and prefer those comments to be in English.

> +//#pragma comment(lib,"iphlpapi.lib")

Dead code?

> +
> +/*=D2=AA=D7=A2=EF=BF=BD=E2=A3=AC=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDun=
icode=EF=BF=BD=EF=BF=BD memcpy=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=D2=AA=CA=B9=EF=BF=BD=EF=BF=BD=
XXX_LEN * sizeof(TCHAR)*/

More encoding awkwardness.

It's hard to review the patch when the content is difficult to read.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LG4lxRvfn95OoUCOQwLBEUV7vHresG2ns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUsrRAAoJEKeha0olJ0NqzNkH/3GqZeougVkVOp8rNbyX3+qD
n6/tgvBMOPNa1UpUqsGwMsd9aaUo9F/NgegDkVxYoMO0JPiIwChAADPF+3MW0rAU
DqXR1s4kWvEudqlEy2Uf1R/eqsMQTZELw41ps6Vz5ANo/M98UrbEGLp9EB3mE2CS
yGN3Q+CKL86uEAb99M1ds0ugj4tRGTGpUE4x5Kqh9n0R+innbEIZtr6IO3YatEg0
z4Vro4eo8MxyI264qxWAZxzJDyJYNsrNCejTYAmSnge8Isq5a38Jg/2VYlfTpha9
7rTfw2cMQH06cbw+oOVTOMSp0XzFUjnkSVpyGlKCm6KWWvSpUUfDeaW4JEOy3Fc=
=6Chb
-----END PGP SIGNATURE-----

--LG4lxRvfn95OoUCOQwLBEUV7vHresG2ns--
