Received: from eggs.gnu.org ([2001:4830:134:3::10]:48150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQcx6-0002lX-UA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQcx6-0002Oh-0k
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:37:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQcx5-0002OH-Qk
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:37:43 -0500
Date: Mon, 9 Jan 2017 16:28:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170109162847.GI30228@stefanha-x1.localdomain>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Content-Disposition: inline
In-Reply-To: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] hypertrace: Lightweight
 guest-to-QEMU trace channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2016 at 09:34:38PM +0100, Llu=EDs Vilanova wrote:
> The hypertrace channel allows guest code to emit events in QEMU (the host=
) using
> its tracing infrastructure (see "docs/trace.txt"). This works in both 'sy=
stem'
> and 'user' modes, is architecture-agnostic and introduces minimal noise o=
n the
> guest.
>=20
> See first commit for a full description, use-cases and an example.

As mentioned previously, the -system mode "1 vmexit per trace event"
approach is too heavyweight for for performance analysis or high
frequency tracing.  It might be useful for things like system bringup or
TCG development though.

The -user approach is more promising because overheads are lower when
guest code really just jumps into QEMU code.

I have left comments on the patches.

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYc7o/AAoJEJykq7OBq3PI74MIALtS30W5IrL+OaavQwT1oWI+
hRG2Ldvlsoml7eO9ehz34AVTZotdyJFdnQcatQjVVDTbDg6kFKls61UI9rcs82oB
PjID0l/i0PWsW2YSs0l0Ps3Ld06v3nN17v14phAc1JF+cMybahk/5RBaH8BTqRBW
bXFdbdUMKZLImFdgzIkYK4L8dPwPGjtf5Aw4jIuBNg7aye+w1Eoij+zxqnMYQd+G
thAZaLffPEsZ1DK1n+z+15QfW3ETYR3rJZCfDW4Byc7+8rTDqj7pnmiFiTGZIFGy
kMFsAWnlfoVT0W1F5aN5uj6c2M6LYrFjKi39kRFcFg2xrTF87DDuaToAjt9uREA=
=3WiX
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--
