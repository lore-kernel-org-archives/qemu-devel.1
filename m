Received: from eggs.gnu.org ([2001:4830:134:3::10]:59239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eYvY2-0005jE-9E
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eYvXz-0006tJ-5Y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:10:42 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:33442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eYvXy-0006sI-Uf
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:10:39 -0500
Received: by mail-wm0-x22a.google.com with SMTP id 123so1355918wme.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 07:10:38 -0800 (PST)
Date: Tue, 9 Jan 2018 15:10:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180109151035.GA1197@stefanha-x1.localdomain>
References: <1515433816-5700-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <1515433816-5700-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vhost-user: factor out msg head and
 payload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 08, 2018 at 07:50:38PM +0200, Michael S. Tsirkin wrote:
>  static VhostUserMsg m __attribute__ ((unused));

Can m be dropped now?

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVNtrAAoJEJykq7OBq3PIG9wH/R6QPzGR6fSLlKQ04M73HHtH
INr518ifkUo+y9Fmxz0Kvn7lgOvwnM0feNlbL+CxuNNaE9iihO7Mu5sTIbmzBV62
9EdHq2OVdVKd71nWdcyMJYf8yDZrx97YLPelrQ6QeD0hFcSy5QzMInzl0jojuiiT
U9mUX2vzqwgM2dhuG2OA252W1RXhgGhaZHTJYIz/pmIkTIe58RTb0grjxTJZeg0n
blz9/y9shKbOc58NtNItTKxuU08QNTl9m/ukJSkLA2c3BQenWDTQeAEHiMFEaTdE
ru/f/b3JFuBfuRld0BdL1ziuLu2Jcm/OHr9cpOICnL30g3cVEJ0ipnJoTBFg3/g=
=SXGA
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
