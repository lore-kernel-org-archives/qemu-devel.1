Received: from eggs.gnu.org ([2001:4830:134:3::10]:39559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ezP9j-0000fc-D0
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ezP9f-00068T-KZ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:03:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ezP9f-00067V-F7
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:02:59 -0400
Date: Fri, 23 Mar 2018 16:02:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180323160252.GA27131@stefanha-x1.localdomain>
References: <22f7f184-c295-4e18-c186-3fd9fdcce213@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <22f7f184-c295-4e18-c186-3fd9fdcce213@linux.intel.com>
Subject: Re: [Qemu-devel] [Consult] nfs-vsocks support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, yang.zhong@intel.com


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 05:54:53PM +0800, Liu, Jing2 wrote:
> I am currently trying to use nfs-vsocks on x86 for vitural machine
> filesystem by some manuals on
> https://www.spinics.net/lists/linux-nfs/msg64563.html
> and https://lwn.net/Articles/647516/
>=20
> It tells the quickstart steps with the following codes but I got some
> problems as listed.
>  * Linux kernel: https://github.com/stefanha/linux.git vsock-nfs
>  * QEMU virtio-vsock device: https://github.com/stefanha/qemu.git vsock
>  * nfs-utils vsock: https://github.com/stefanha/nfs-utils.git vsock
>=20
> 1. I would like to ask what is the current status of these codes? If
> there're some updates? :)

Please use https://github.com/stefanha/linux/commits/vsock-nfsd to get
both client and server support.  The vsock-nfs branch you posted only
contains client support.

> 2. nfs-utils codes could not compile for me... I refered to the README but
> failed for both ways. It seems no configure script and
> autoheader/automake... So I don't know how to install this.

Please see "2. COMPILING FROM GIT" in the nfs-utils ./README.  You need
to run ./autogen.sh to generate the ./configure script.

> 3. For the 5th step (Start nfsd), I'd like to know the rpc.nfsd --vsock is
> enabled by which codes? Is it the CONFIG_VHOST_VSOCK kernel module in hos=
t?
> Because I installed the kernel with vsock-nfs repo with the specified con=
fig
> options but failed to do rpc.nfsd --vsock.
>=20
>=20
> Could you give me some help and thanks in advance!

Here is a script that launches nfsd and runs a guest:
https://github.com/stefanha/linux/commit/38cbc15661a6dd44b69c4f318091f2047d=
707035#diff-05f3fe8941076453942a8c059b409009

Regarding rpc.nfsd, on my Fedora 27 system rfc.nfsd is launched by
/usr/lib/systemd/system/nfs.service.  When developing NFS over AF_VSOCK
I disable the NFS service and launch nfsd manually from the script
above.

Stefan

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJatSUrAAoJEJykq7OBq3PIxk4IAITfaGUOLxASqPziM1gldR2d
ZMgkfROwW7AvQOq3/uJlLiRQ7bNQoY+F9uUBxW4f7QAI1tjqpGjkl3mkDDpxC6X4
3VHoC83cT2pnW1WUes6UVhc2LABk2GL8vBdxWDB+A8zW69UDTqf6P7L24AZdsJka
jzCVF3dhfTlC/hAsVWw60vf66pt1flnZuYP8umCVwGQU++muIMgjawljJwJWK1ix
tgCbtOp1CJgRdz3eYywhohltBE5TkXlMKdE3ft1Wro4kd3II6ZeZ2DdsTdfEonJa
aXczTlsyNLa7dF2BWhH5QJ5uaRjLyeUFP1SHD0tbFTRcZx+W6TUQgj+QjWA81Z4=
=ZUgF
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
