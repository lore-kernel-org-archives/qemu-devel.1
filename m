Received: from eggs.gnu.org ([2001:4830:134:3::10]:42374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyUB-0000Zq-FM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyU8-0003tE-Dh
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:52:47 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cqyU8-0003t0-7w
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:52:44 -0400
Received: by mail-wm0-x241.google.com with SMTP id z133so15154631wmb.2
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 01:52:44 -0700 (PDT)
Date: Thu, 23 Mar 2017 08:52:40 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323085240.GJ16717@stefanha-x1.localdomain>
References: <1490092792-30957-1-git-send-email-thuth@redhat.com>
	<1490092792-30957-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEkEgRdBLZYkpbX2"
Content-Disposition: inline
In-Reply-To: <1490092792-30957-2-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] libqtest: Ignore QMP events when
 parsing the response for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2017 at 11:39:50AM +0100, Thomas Huth wrote:
> When running certain HMP commands (like "device_del") via QMP, we
> can sometimes get a QMP event in the response first, so that the
> "g_assert(ret)" statement in qtest_hmp() triggers and the test
> fails. So ignore such QMP events when looking for the real
> return value from QMP.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/libqtest.c | 6 ++++++
>  1 file changed, 6 insertions(+)

qmp.py keeps a queue of events so they can be processed later.  I guess
an event queue will be needed eventually because discarding events makes
it hard to write reliable test cases that check for events.

But as long as current qtests work correctly:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY04zYAAoJEJykq7OBq3PI4zAH/R7SzLl6uglg2F4HmLs15lA0
PuVEVst6YbKxCVjWNdquJuBQEBS0CIyOIs256JdwbGygHNltf4+yV5ZH+voGscbz
hmL5UG4KAKY0Cq0VeEvYaJ9+1uFQJR91+Um1EYH7ZiuG4IFXC5R2LoSRrdOpbgnO
p8+cmxoKdUflV3XKXfhgXYHSU+shihhzC/i/nJ9fiI49QyllNsOmejjO1N9H8+va
l2DTE3jYUT2Oz+rMsJYZtP0whgV9m3Axvgw5gT+qj9obTnSx82RC1h8BrIXO48zX
bInC6F1ZxjIvROM9AEKgX5EDfTltWkRzsOMDFVzvJLm/Qv4rc5dxDSnjwrbU2rw=
=rWaN
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--
