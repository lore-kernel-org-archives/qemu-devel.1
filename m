Received: from eggs.gnu.org ([2001:4830:134:3::10]:58894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP3yj-0007YZ-DD
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP3yg-0002cy-Bv
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:09:29 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eP3yg-0002ce-4u
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:09:26 -0500
Received: by mail-wr0-x242.google.com with SMTP id g53so1589806wra.2
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 02:09:25 -0800 (PST)
Date: Wed, 13 Dec 2017 10:09:22 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213100922.GB16782@stefanha-x1.localdomain>
References: <20171213042312.8781-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20171213042312.8781-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] kvm: Add kvm_set_user_memory
 tracepoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 03:23:12PM +1100, Alexey Kardashevskiy wrote:
> This adds a tracepoint to trace the KVM_SET_USER_MEMORY_REGION ioctl
> parameters which is quite useful for debugging VFIO memory regions
> being actually registered with KVM.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  accel/kvm/kvm-all.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Did you forget to include the accel/kvm/trace-events change in this
patch?  Patchew is unable to find trace_kvm_set_user_memory() because it
hasn't been defined.

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMPxSAAoJEJykq7OBq3PIGDgIAKcaEat/z4w0SfNgYhdQA5Al
9jD3VgKDjjkB8+PRWEz5aTo/9kuiVbZ6A4ZeccxP3NZNfyOsX3rdTPC2+jxk7vBs
6X2sMvfUQCAdxmT21tkgec0C/NnGYdcvBVZXyn5AEDnn+5adh//JE+omGpj/gGGW
SCCva/gH244C6AMqzI5ELbWXFSfXv/JNqngEGx9yRl57mKNGUUSVyInuu8YDadox
45Mw3sznmo02Z/OXOLVtXumKDGepHvELs82g3zMqJFJHMf0sIxBM7is16zix2eVS
4hdph5hmJoQQEVbyGoPY7Hs0EfqCrtnUrWc1UTmetqeqqjuZNc++X/V8Kx/8EOo=
=BK7B
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
