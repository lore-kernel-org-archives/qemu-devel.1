Received: from eggs.gnu.org ([2001:4830:134:3::10]:40943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZEMo-0000i3-T1
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZEIe-0007aB-Lu
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:07:35 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:36508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZEIe-0007ZE-E6
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:07:32 -0500
Received: by mail-wj0-x242.google.com with SMTP id kq3so371662wjc.3
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 02:07:32 -0800 (PST)
Date: Thu, 2 Feb 2017 10:07:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170202100728.GA20760@stefanha-x1.localdomain>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
	<CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
	<E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
	<CAJSP0QUWmU_XbB9TGxvL0hH-SCzRSWDciNhpZrarDDcE22RF_w@mail.gmail.com>
	<D1304CAA-9C32-4E42-AA65-27B3277130E8@veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <D1304CAA-9C32-4E42-AA65-27B3277130E8@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v7 RFC] block/vxhs: Initial commit to add
 Veritas HyperScale VxHS block device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Cc: Buddhi Madhav <Buddhi.Madhav@veritas.com>, ashish mittal <ashmit602@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Gaurav Bhandarkar <Gaurav.Bhandarkar@veritas.com>, Abhishek Kane <Abhishek.Kane@veritas.com>, Ketan Mahajan <Ketan.Mahajan@veritas.com>, Niranjan Pendharkar <Niranjan.Pendharkar@veritas.com>, Nirendra Awasthi <Nirendra.Awasthi@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 11:59:53PM +0000, Ketan Nilangekar wrote:
> Patch for secure implementation in libqnio is available for review here:
>=20
> https://github.com/VeritasHyperScale/libqnio/pull/12
>=20
> libqnio client initialization now has an option to use X.509 certificates=
 to authenticate itself to the vxhs server. =20
> Also each client IO request now includes an instance id that is used by t=
he vxhs server to authorize the request.
> A test client has also been added.
> Libqnio.so so is renamed to libvxhs.so. We will rename the repository onc=
e the latest patches are merged.
> QEMU patch to use the new secure interface will follow shortly.

I have left comments on specific lines of code on GitHub.

The server should do something based on the client X.509 certificate.
Is the code actually verifying certificates on the client side?

Right now the code is just going through the motions of SSL but not
protecting against man-in-the-middle attacks.

I noticed that the code uses OpenSSL.  QEMU uses GnuTLS instead of
OpenSSL.  In practice it's hard to avoid duplication of SSL libraries:
GlusterFS and Ceph use OpenSSL and NSS.  That means QEMU KVM may drag in
GnuTLS, OpenSSL, and NSS!  But from a QEMU point of view it would be
nicest to use GnuTLS to keep extra library dependencies minimal.

Stefan

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkwTgAAoJEJykq7OBq3PIjAIIAIOX8ZlUAAg3uAVYF6E15i69
BeCo9J/ojydXxJ4lh3hANKxVGZTeCRVc+oP9svx8l10aVXM512AX76otxkRTWSCq
exVh3u9n4EaaiZUFsnqHDw2VixiZKTkuh3LFJjRqSYJPiX6U1+LAhp8UNtm8hBZX
DFS17wQCNQ/n7opBscDPcFu/N/NfH2sXHahBSh0Ye2DdxlYFX6f26vYoYg3gaPps
f0SVNxuoFwk3wYCGz7Vnj/cuwzj/ob5Z9BOLUPNpz03P6x0+GajXiB5ViH4jJCqZ
AXgZyAIWcS9KeYsqe/BZb1W/WGj0ZiarIkZGZSJjVRRqFeL+NSvlb6rQYvoJWjw=
=DZ7B
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
