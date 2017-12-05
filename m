Received: from eggs.gnu.org ([2001:4830:134:3::10]:50622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMBzn-00080e-Bk
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMBzk-0008Um-Mq
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:06:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMBzk-0008US-Fw
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:06:40 -0500
Date: Tue, 5 Dec 2017 12:06:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205120623.GB31150@stefanha-x1.localdomain>
References: <20171205063313.GB4102@yangzhon-Virtual>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <20171205063313.GB4102@yangzhon-Virtual>
Subject: Re: [Qemu-devel] About the light VM solution!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 02:33:13PM +0800, Yang Zhong wrote:
> As you know, AWS has decided to switch to KVM in their clouds. This news =
make almost all
> china CSPs(clouds service provider) pay more attention on KVM/Qemu, espec=
ially light VM
> solution.
>=20
> Below are intel solution for light VM, qemu-lite.
> http://events.linuxfoundation.org/sites/events/files/slides/Light%20weigh=
t%20virtualization%20with%20QEMU%26KVM_0.pdf
>=20
> My question is whether community has some plan to implement light VM or a=
lternative solutions? If no, whether our=20
> qemu-lite solution is suitable for upstream again? Many thanks!

Booting VMs faster is appreciated upstream.  I think there is interest
in patches that further this goal and hope you have time to contribute.

What caused a lot of discussion and held back progress was the approach
that was taken.  The basic philosophy seems to be bypassing or
special-casing components in order to avoid slow operations.  This
requires special QEMU, firmware, and/or guest kernel binaries and causes
extra work for the management stack, distributions, and testers.  It is
preferrable to have just one binary and no special configuration
settings.

I think patches are more likely to be merged with the following
approach:
1. Benchmark or profile to find slow operations.
2. Perform an experiment to see if bypassing the operations improves
   performance.  If no, go back to step 1.
3. Investigate the slow operation to see if it can be optimized or
   skipped completely based on run-time knowledge.  This means no
   special '-lite' binaries or new config options.
4. Implement patches to do this, retest, and send them upstream.

My view is that qemu-lite only got to Step 2 in some cases.  Going to
Step 4 is more work but the result will be easier to merge.

Stefan

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJou/AAoJEJykq7OBq3PINzUH/1yRauqRJTGl/DRf+NU1lri0
Not32pRuODZlBZI+DqWFrQqQcOozYf3ruNXpFZW0QTAEn5oGl3UOeYaYxJaVk6Ub
VHnG7LoYhkoGSkQ1zmNUbA6dB1k7x4dMEh/VoDmuDVI3GqpU9OmdW7OrN0lf16Em
zO+gIMne8WGLgGrQGFca3f+ReemtUshhdEgiSixGfR2u4zsVG+TO/ztTnkDiujgT
zpFgDhN/6+stouISgSGUAjFWNTdCudbfCOIu8DqpQKBJerqXOahExv4qxgMvbnRG
xfft4kf02X0zGKkCl39+z/bTcycjTtxd2PF6yipXtwpN9K2TE1/WAkThiokM6yE=
=uXT+
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
