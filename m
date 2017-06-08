Received: from eggs.gnu.org ([2001:4830:134:3::10]:37671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIycf-0005jl-Ti
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIycc-0004ka-1C
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:41:17 -0400
Date: Fri, 9 Jun 2017 00:41:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608144106.GG25805@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LiQwW4YX+w4axhAx"
Content-Disposition: inline
Subject: [Qemu-devel] unplug_request and migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilber@redhat.com, quintela@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--LiQwW4YX+w4axhAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave & Juan,

I'm hoping one of you can answer this.

I'm currently grappling with (amongst other things) a pseries machine
racing a hot unplug operation with a migrate.  There's various issues
with what interim state we need, and which bits of it need to be
migrated that I'm still investigating.  But, there's a more general
question that I'm guessing must have already been addressed for x86.

For any "soft" unplug device - i.e. using ->unplug_request, rather
than ->unplug, giving a device_del command will just ask the guest
nicely to release the device, with the completion of the unplug
happening only if and when the guest indicates it's ready for the
device to go away.  AFAICT, the device_del command will return as soon
as the request is made, but if the guest is busy, the completion of
the hot unplug could take arbitrarily long.

So, what happens if there's a migration in between the unplug_request
and the guest completing the unplug?  How does libvirt (or whatever)
know whether to include the device on the destination machine command
line?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LiQwW4YX+w4axhAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOWICAAoJEGw4ysog2bOST4oQAIZkz0+xQSLVRPkwG9eiDl1b
eKHteKH3c6TFCToEDVQ1nudFcIWv4VKw91+bQhEgSmiw0ezkRjoDxP73sT5n9YcX
1c1vf0X7NKqOPtdAN6LzG5jLVhCX6wdrwVtfnEWwZX42rAUy0/1UbBHA+/n6hy2T
jii5R9/OISJ3E4QUK9AqpkWp1RxQAHO9utwJiyCROcOnrONgdFX1idbNfT424Xm1
Rm6ZhM8OxkcUO/CPNBrBlmqoknWu8fsA+KsTIr8A2JARSu4ZgzXEp3E2XFUKM4S+
t230eYCItsuWIHiOE1VPD1QTkV15AjjlwlACISB5xOUvSotvq7USPjTTBQADlRQs
mn9Z95khT49WUsFjWJsQWVU55qoJj4j51o4zPsEAaar7gVJHJsVOpJPUmGYKVi9j
NUcsBF6RZ+RWoYhgYwaJpMoht2UphJTkTCxlkur29pTFSDlzEh5w0M2SmSeA73au
7d4TUL5juzfRM3XyO2k1VY8TK9liYB7oul67p4Z27CH6DxoiBae8lIiXrFZpL+XW
DtL0CglpSHgMeaKxSYNaMFT+/XaC2hkbssRCOlUfq032vP3YsvhJYS4L9fpEw0DR
Cv5C/4DjhM+tCRn4Ozc2JBLxQAyMPOiarRadtYUAWy7WQagM51NxLfZoRCnGrqE8
/bmAUVhaptyYzcqjbnFn
=zcui
-----END PGP SIGNATURE-----

--LiQwW4YX+w4axhAx--
