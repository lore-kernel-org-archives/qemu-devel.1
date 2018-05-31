Received: from eggs.gnu.org ([2001:4830:134:3::10]:52362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fONKv-0005Pt-TQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fONKr-00048b-By
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:09:49 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fONKr-00047z-4u
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:09:45 -0400
Received: by mail-wr0-x242.google.com with SMTP id f16-v6so17632987wrm.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 06:09:45 -0700 (PDT)
Date: Thu, 31 May 2018 14:09:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180531130942.GK27838@stefanha-x1.localdomain>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
	<1525918138-6189-3-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6K2R/cS9K4qvcBNq"
Content-Disposition: inline
In-Reply-To: <1525918138-6189-3-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 2/9 V5] hostmem-file: add the 'pmem' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--6K2R/cS9K4qvcBNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 10:08:51AM +0800, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
>=20
> When QEMU emulates vNVDIMM labels and migrates vNVDIMM devices, it
> needs to know whether the backend storage is a real persistent memory,
> in order to decide whether special operations should be performed to
> ensure the data persistence.
>=20
> This boolean option 'pmem' allows users to specify whether the backend
> storage of memory-backend-file is a real persistent memory. If
> 'pmem=3Don', QEMU will set the flag RAM_PMEM in the RAM block of the
> corresponding memory region.

I'm still not sure if this option is necessary since pmem_is_pmem() is
available with the introduction of the libpmem dependency.  Why can't it
be used?

Stefan

--6K2R/cS9K4qvcBNq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD/QWAAoJEJykq7OBq3PI5a4IALzORzbYq5K04YQFMwAkZazw
FFK8Tls3pL/nNEb3DPn4vBe2MEf9rAhAam50ZJiA6aeagvLvcRnXvAhLkQ4BkQdV
VzTHbxz8UpmYau8YYwYM1Vdp1PrdRwtfKxDNeAUk8quZv0KY33iG9nc6HpRTBFWO
cXNHiz2/SwYvX7a9dxutg3uIPs1NiS467v7Ogj5HOTdPDKXuD7tC3mfx3p+h6QQK
b9xFL32n48K5nEFC+4prKLK33UkWsr81dC58k7XeIp73uayYCpt9VBI05ozEEt2O
+QfMgIPW6iwIBFL2+/Qx73ilIcoBVgkB1L0EGQm1sCSCstoOkxYeurhE4Lh6KVM=
=VNiO
-----END PGP SIGNATURE-----

--6K2R/cS9K4qvcBNq--
