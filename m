Received: from eggs.gnu.org ([2001:4830:134:3::10]:57188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXTeR-0005JZ-DB
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXTeO-0004cc-Mz
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:11:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eXTeO-0004Wj-G7
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:11:16 -0500
Date: Fri, 5 Jan 2018 15:11:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180105151105.GC28322@stefanha-x1.localdomain>
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20180103214925.16677-2-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdbus: add a QMP command to access
 a SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 06:49:22PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Use Base64 to serialize the binary blobs in JSON.
> So far at most 512 bytes will be transfered, which result
> in a 684 bytes payload.
> Since this command is intented for qtesting, it is acceptable.

Not a requirement, but have you considered adding a qtest command
instead?

  > sdbus-command <qom-path> <args...>
  < OK <result...>

The (small) advantage is that it keeps test-only commands in the qtest
protocol and out of the QMP schema.

The downside of qtest is that qapi parsing is not available, so it
involves manual marshalling code.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaT5WJAAoJEJykq7OBq3PIFiYH/2nT9gSKIPAJevoDI9hx1nr0
cmGENxf3bV6773NPjDWIkN0GP7Qkoyo9Zrkx43rDflDIM1Wq2aKBH4ykthF8ILSK
SIs7DVEWKmxuNO6bnwfw4izpoIr6HsY1QWHRQbOHxkqMml8UHjTCi32aY1S4EBRo
jZi004jS0ZzerG4S4mnrmVkeDqdtN1eLh4Ru69Th0SB5SvCH6wPiwToWcna59w0d
zR3bE4WS9FFwYfRy/MQRMN7t0W5CQH03JgLQqayK4Pswl03rSSLk8Fveo4tFbps5
sQnrd2Vvnc2DwozCaHurUd8BxdvJ83g0fv3nl7L2RWmT03+hPPxXvGks3svus3c=
=oUPl
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
