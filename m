Received: from eggs.gnu.org ([2001:4830:134:3::10]:41181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTnV5-0004ua-Ow
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTnV2-0000Tx-NM
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:29:55 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cTnV2-0000TW-Fd
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:29:52 -0500
Received: by mail-wm0-x242.google.com with SMTP id d140so2966319wmd.2
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 02:29:50 -0800 (PST)
Date: Wed, 18 Jan 2017 10:29:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170118102942.GA5284@stefanha-x1.localdomain>
References: <CAAKRE72RN=DvVqxYMba5KdnWQ+jrAXTpxQc7Qdgiymu6oByosg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <CAAKRE72RN=DvVqxYMba5KdnWQ+jrAXTpxQc7Qdgiymu6oByosg@mail.gmail.com>
Subject: Re: [Qemu-devel] VM Hung issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Umar Draz <unix.co@gmail.com>
Cc: qemu-devel@nongnu.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 01:51:26PM +0500, Umar Draz wrote:
> I am running qemu-kvm on CentOS 7.3, I have few vms of CentOS and Windows
> 2012 servers.
>=20
> Randomly they are hung, but the status of virtual machine keep running, v=
nc
> and network not responding.

It's not clear whether the guest is hung or QEMU is hung.

Does the VNC client connect successfully?  If the client fails to
connect then QEMU is hung.  If the client connects but the guest doesn't
respond to input then only the guest is hanging.

If QEMU is hung please post a backtrace:

  # gstack $PID_OF_QEMU

Stefan

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf0OWAAoJEJykq7OBq3PIngYH/2w6QPNBVCvA1QUxU4CgxyZx
ml/19VGtGfpfEYc+hXPKsXcpM/iQGrZhBvwbGgSUgcKS/KQ4iGfLDtVxASavbbLV
tlR6MyCUWuAqZ3e6nkKhnc/Y908+FnRRgcoBY5uH0yk+igqNtESIsDZDtz+BnKOj
dKhNuWxOeqTFb84oQFA0o1QhXBmDJcyC2Q99wgBqtvK4UKphjSXxNS+2P/NvR9hV
RQXJcqJ9q1aEmi89HR7sKOPVrOAjyGLrJx/yjqOSSAOU+MQj8bgaJapp+ou4wt+s
CVKyaduyID/8++lzlrjbJZ+93gehXrMggrTd20EqHy7JGwj6DhpPx+qSQ8mttUY=
=5u2z
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
