Received: from eggs.gnu.org ([2001:4830:134:3::10]:57837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMayZ-0005Pj-Vn
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMayV-0005Ws-2T
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:42:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cMayU-0005WV-P5
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:42:30 -0500
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
	<20161219010743.GA2719@lemon>
	<20161219135529.GE17374@stefanha-x1.localdomain>
	<aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
	<4fb58e00-63bf-ce50-677d-cec2ed5684a9@redhat.com>
	<f8f625d2-fd0d-f152-7521-6ef2b3d74309@imatronix.cl>
	<a982da67-2971-3134-de18-7d470b1fb4d2@imatronix.cl>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c087ebdd-e266-ceba-1390-66b2d38cab16@redhat.com>
Date: Thu, 29 Dec 2016 07:42:28 -0600
MIME-Version: 1.0
In-Reply-To: <a982da67-2971-3134-de18-7d470b1fb4d2@imatronix.cl>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vESsVW4SbK08P9beGHbLkIdD4JWiPscqK"
Subject: Re: [Qemu-devel] Can qemu reopen image files?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christopher Pereira <kripper@imatronix.cl>, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vESsVW4SbK08P9beGHbLkIdD4JWiPscqK
From: Eric Blake <eblake@redhat.com>
To: Christopher Pereira <kripper@imatronix.cl>,
 Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <c087ebdd-e266-ceba-1390-66b2d38cab16@redhat.com>
Subject: Re: [Qemu-devel] Can qemu reopen image files?
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
 <20161219010743.GA2719@lemon>
 <20161219135529.GE17374@stefanha-x1.localdomain>
 <aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
 <4fb58e00-63bf-ce50-677d-cec2ed5684a9@redhat.com>
 <f8f625d2-fd0d-f152-7521-6ef2b3d74309@imatronix.cl>
 <a982da67-2971-3134-de18-7d470b1fb4d2@imatronix.cl>
In-Reply-To: <a982da67-2971-3134-de18-7d470b1fb4d2@imatronix.cl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/28/2016 12:51 PM, Christopher Pereira wrote:
> Hi Eric,
>=20
> There is something I don't understand.
>=20
> We are doing: "virsh save", "qemu-img convert", "qemu-img rebase" and
> "virsh restore".
> We only touch the backing chain by doing the rebase while the VM is dow=
n.
> Is there any chance this procedure can destroy data?

Since there are never two active writers to the file (you have made sure
that qemu-img and qemu are not both holding the same file open at once),
there is no chance for corruption on that front.  There's still a
possibility of corruption if you botch the instructions, and don't
rebuild the chain in such a way that the guest would see the same data,
but that's harder to say without seeing an actual transcript.

> If so, is there any difference between shutting down and just
> saving/restoring the VM?

Shutting down vs. saving/restoring shouldn't matter other than the
length of time that the guest is offline (including rebooting time with
a shut down, which is not present for an incoming migration restoration).=


> Maybe save/restore keeps a cache?

No. Both shutting down and saving end the qemu process, and therefore
flush everything to the disk.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vESsVW4SbK08P9beGHbLkIdD4JWiPscqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYZRLEAAoJEKeha0olJ0Nqt7UH/RYqEX9drljDkvU1/vFzlrY/
xvaAjIvQ32WZS4wXioDg5E6cJTbG6JYClbTdy5tkCRI3Z2LD/s8CBLyhRWnf+GlN
sPEgx1X/KiAdqe83TvRky65heEfJMTT4+Nx5cNVLQCFNWkDZOX4TZ2kd5u0EatN7
3pOBwgv4rkLzZMwWesZ1XnOJ3ks9b4+YcKcU9Yzx8n6KS9/kvZxhE1zRnom3046U
tO4YSFasRcYLWzMHzf4BDPRSD8rc09fijyHcSBIoZtePd8J37zIFySlAWb40Uq7N
PJqCpOXYeoDFDfZGrfBPuv8Of7iFaM3Bu8en73raEuGCogF0v8DWLh/wPVVfywo=
=NOER
-----END PGP SIGNATURE-----

--vESsVW4SbK08P9beGHbLkIdD4JWiPscqK--
