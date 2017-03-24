Received: from eggs.gnu.org ([2001:4830:134:3::10]:55564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crRK3-0005Wf-33
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crRK0-0007Ji-13
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:40:15 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1crRJz-0007JP-R4
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:40:11 -0400
Received: by mail-wr0-x243.google.com with SMTP id 20so981166wrx.0
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 08:40:11 -0700 (PDT)
Date: Fri, 24 Mar 2017 15:40:07 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170324154007.GB5849@stefanha-x1.localdomain>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900632968.27090.15435012868487968230.stgit@brijesh-build-machine>
	<20170323113517.GC12560@stefanha-x1.localdomain>
	<6ed30368-1433-cf00-ee2e-611faf2a98e3@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <6ed30368-1433-cf00-ee2e-611faf2a98e3@amd.com>
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


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 01:59:48PM -0500, Brijesh Singh wrote:
> Hi Stefan,
>=20
>=20
> On 03/23/2017 06:35 AM, Stefan Hajnoczi wrote:
> > On Wed, Mar 08, 2017 at 03:52:09PM -0500, Brijesh Singh wrote:
> > > The object can be used to define global security policy for the guest.
> >=20
> > "security-policy" is very vague.  Lots of parts of QEMU have security
> > related options (e.g. VNC display, networking, etc).
> >=20
> > I'd prefer a
> > -machine memory-encryption=3Don|off,memory-encryption-debug=3Don|off
> > or -m encryption=3Don|off,encryption-debug=3Don|off switch instead of a=
 new
> > security policy object with questionable scope.
> >=20
>=20
> In v1 [1], I had something similar but not exactly the same. I had a new =
command
> line switch but the overall feedback was to consider creating new securit=
y object
> which can be used to define a machine security policy.
>=20
> [1] http://marc.info/?t=3D147378617700002&r=3D1&w=3D2
>=20
> some more discussion here [2]
>=20
> [2] http://marc.info/?t=3D147378241700011&r=3D1&w=3D2
>=20
> IMHO, a new object is helpful because it provide options to launch a gues=
t without
> memory encryption support but still can take a advantage of disabling the=
 debug
> feature. e.g on non SEV platform we can launch guest with "-object securi=
ty-policy,id=3Dsecure0,debug=3Doff'
> which will reject the guest memory accesses via gdbstub or qemu monitor c=
ommand line interface.

Having one security policy doesn't make sense to me.  As mentioned,
there are many different areas of QEMU that have security relevant
configuration.  They are all unrelated so combining them into one object
with vague parameter names like "debug" makes for a confusing
command-line interface.

If the object is called sev-security-policy then I'm happy.

Stefan

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY1T3XAAoJEJykq7OBq3PITOYH/1ZWLukikTSSpVayR8cIy6Ov
w8a2Xr/eXGur39FzegoPHTUBk0uoi9TjGbCUsLaLgZz19/VsGTbiBiwpjCBizDri
ctq6V78jEIIAAe8DtLAGWBzWX8qxG2+FJU54Y5arAqTcP+uypYcssL86jsyyAA5d
JgMm//O9cL6JKMUdC2mWCekIRdGJJdEk3uH0jEgq1Mffl4xTI8+PQxdUv+NVHW0o
EwVYnbqiaqMuArljMw+RxvR3TeRzpgZfyQUUPFfM01ZX+X4N0tds5FA5yQdF2t9D
7wUuSmmYISYNBTTByoJWjoIyWY6KT+GWatbFLuWo3HiHEg1aq8e34pxxLOmgsN4=
=85qJ
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
