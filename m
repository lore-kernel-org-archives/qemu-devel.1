Received: from eggs.gnu.org ([209.51.188.92]:43639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gz0Z6-0000ok-9i
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gz0Z4-0003UO-Cn
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:52:08 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gz0Z2-0002rV-Je
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:52:06 -0500
Received: by mail-wr1-x42c.google.com with SMTP id r5so18266768wrg.9
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 06:51:20 -0800 (PST)
Date: Wed, 27 Feb 2019 14:51:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190227145117.GD22539@stefanha-x1.localdomain>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
	<20190225092846.GA4757@angien.pipo.sk>
	<20190225174001.GI379@stefanha-x1.localdomain>
	<87a7iincg0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
In-Reply-To: <87a7iincg0.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2019 at 10:09:19AM +0100, Markus Armbruster wrote:
> The migrate-with-cache-direct-off-on-linux case is compile-time static.

By the way, I will change "migrate-with-cache-direct-off-on-linux" to
"migrate-with-cache-direct-off".  Linux builds will report this feature
while non-Linux builds will not.  If we ever add non-Linux support, then
we can report this feature in those builds too.

Stefan

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdqPlAAoJEJykq7OBq3PI/boIAKEeGI9bHCguPBtJ5Nm7fOpk
pyWH3TqdQ5pWhpFbwEiDrcfCpnwFgCLT5tpAr4eJowau74TzE8xpZ/vGFO3YpybC
JpNKLd5hxm963zarEhJIWutYY9JBTx5b+sCvr2xbiSIx5OWgUG2NdQNAF8u7rR9r
ecbmz37G/56WCWjry7Ute616GENV4J4IDv9l1UtJP7matPqhASTaYs8Fgab6yA+A
Hlbbs8OLDYpLjR5xLmv7WA2Ppripa05o6vkjf/T014i5XR1clRp5J3UJcbgI8W3V
GyRZNP0ohCDEMdx3eFFDHOubIx85zB9swHz8GmVZM3DwjVeYxr0ksXbEUxz3czE=
=FDbN
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
