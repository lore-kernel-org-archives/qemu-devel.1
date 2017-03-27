Received: from eggs.gnu.org ([2001:4830:134:3::10]:40196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csTNd-0007Nt-Ty
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csTNY-0002z7-LP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:04:13 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1csTNY-0002yr-FS
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:04:08 -0400
Received: by mail-wr0-x243.google.com with SMTP id u1so12565573wra.3
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 05:04:08 -0700 (PDT)
Date: Mon, 27 Mar 2017 13:04:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170327120404.GA28620@stefanha-x1.localdomain>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900632968.27090.15435012868487968230.stgit@brijesh-build-machine>
	<20170323113517.GC12560@stefanha-x1.localdomain>
	<6ed30368-1433-cf00-ee2e-611faf2a98e3@amd.com>
	<20170324154007.GB5849@stefanha-x1.localdomain>
	<3b210d06-b6f9-af04-ff68-e7cee1c8033f@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <3b210d06-b6f9-af04-ff68-e7cee1c8033f@amd.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 06/20] core: add new security-policy
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 02:42:47PM -0500, Brijesh Singh wrote:
>=20
> On 03/24/2017 10:40 AM, Stefan Hajnoczi wrote:
>=20
> >=20
> > Having one security policy doesn't make sense to me.  As mentioned,
> > there are many different areas of QEMU that have security relevant
> > configuration.  They are all unrelated so combining them into one object
> > with vague parameter names like "debug" makes for a confusing
> > command-line interface.
> >=20
> > If the object is called sev-security-policy then I'm happy.
> >=20
>=20
> Works for with me but one of the feedback was to use security-policy [1].
> IIRC, the main reason for using 'security-policy' instead of 'sev-securit=
y-policy'
> was to add a layer of abstraction so that in future if other platforms su=
pports
> memory encryption in slightly different way then all we need to do is to =
create
> new object without needing to add a new parameter in -machine.
>=20
> [1] http://marc.info/?l=3Dqemu-devel&m=3D147388592213137&w=3D2
>=20
> How about using 'memory-encryption-id' instead of security-policy ? If us=
er wants
> to launch SEV guest then memory-encryption-id should be set SEV specific =
object.
> Something like this:
>=20
> -machine ..,memory-encryption-id=3Dsev0 \
> -object sev-guest,id=3Dsev,debug=3Doff,launch=3Dlaunch0 \
> -object sev-launch-info,id=3Dlaunch0 \

Something like that sounds good.  I think "-id" typically isn't included
in the option name.

So just the following is fine:

 -machine memory-encryption=3Dsev0 \
 ...

Other examples: -device virtio-blk-pci,drive=3Ddrive0 and -device
e1000,netdev=3Dnetdev0.

Stefan

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2P+0AAoJEJykq7OBq3PIIxYIAIp04fq/ChPNGnOd32d69Zn5
uN7bo8yXSf01aqOqAMf/1/9g8PVjnHXzlKOZgeoF1IUGJMoO1l3G9FJOHyESX0v3
AE60eODfyasY85bvuZkQZ1FY+1Do63NlGSYtA+ekPf5EllZ9D+81KOEFZLn9CvGn
0tbttXGzmdHsKY8jRhPWwrSgcAGZ6NeRFLAcYGYKDRAZYSiG6GYkeCYxFqHt5wOy
20KG7QBN6QQbOeA21e/O+n0q7xIdafurDrDA08YPco7k9824SmlWWMf+ssFSNy54
AiFQZGrbXpH1V123NKqNDNBwQveESWkWwJFZB+JZ3e3bhaXBXILQGB2rbGXotpY=
=yqWY
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
