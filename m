Received: from eggs.gnu.org ([209.51.188.92]:43875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1grzan-0006tJ-DP
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1grzam-0000Rc-CQ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:24:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1grzam-0000Nr-3W
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:24:52 -0500
Date: Fri, 8 Feb 2019 14:24:41 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190208062441.GF16257@stefanha-x1.localdomain>
References: <2932080.UxbmD43V0u@neil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline
In-Reply-To: <2932080.UxbmD43V0u@neil>
Subject: Re: [Qemu-devel] [regression] Clock jump on VM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Neil Skrypuch <neil@tembosocial.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 05:33:25PM -0500, Neil Skrypuch wrote:

Thanks for your email!

Please post your QEMU command-line.

> The clock jump numbers above are from NTP, but you can see that they are =
quite=20
> close to the amount of time spent in raw_co_invalidate_cache. So, it look=
s=20
> like flushing the cache is just taking a long time and stalling the guest=
,=20
> which causes the clock jump. This isn't too surprising as the entire disk=
=20
> image was just written as part of the block mirror and would likely still=
 be=20
> in the cache.
>=20
> I see the use case for this feature, but I don't think it applies here, a=
s=20
> we're not technically using shared storage. I believe an option to toggle=
 this=20
> behaviour on/off and/or some sort of heuristic to guess whether or not it=
=20
> should be enabled by default would be in order here.

It would be good to figure out how to perform the flush without
affecting guest time at all.  The clock jump will also inconvenience
users who do need the flush, so I rather not work around the clock jump
for a subset of users only.

Stefan

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcXSCpAAoJEJykq7OBq3PI3tAH/Rc2rD2P782RGPUrT/HdQglZ
T9e7a7/ZUMWS86N0+y+Oin6qu2BRpF50Ra4+q+TG3tw9CCN+go0DEPP19Ta0ebYm
2+WxLSoddfQOSd5euh4s63rG23fAtyCNtxJuMN7YjnzqdVvY+EPy4cb22SmP9uWV
gRUG2xhMrmk8nYPXYjM3eV+LeIaGuNTd9a4luwN0NAoEMCkdpv2/uOwxaXta66ge
GyobQwFQI/F86ZfpIS3k6HgQFAklmsv4dXPtetpQ52ZPOXpdoDDC1Ahs9/IlQqR5
dEURX9/lvQMR2iMS/AwpXcjH2rwzT53wbsNJWQ5mmto3Jry6DIThc4QpzrcucOE=
=u6jw
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
