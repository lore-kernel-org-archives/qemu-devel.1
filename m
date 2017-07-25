Received: from eggs.gnu.org ([2001:4830:134:3::10]:54285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0VP-0001LY-Ku
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0VK-0001ZM-1u
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:08:11 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da0VJ-0001Yi-SA
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:08:05 -0400
Received: by mail-wr0-x242.google.com with SMTP id 12so11938093wrb.4
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:08:05 -0700 (PDT)
Date: Tue, 25 Jul 2017 15:08:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725140802.GM23343@stefanha-x1.localdomain>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-8-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OQhbRXNHSL5w/5po"
Content-Disposition: inline
In-Reply-To: <1500645206-13559-8-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/9] tests: Clean up wait for event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--OQhbRXNHSL5w/5po
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 03:53:24PM +0200, Markus Armbruster wrote:
> We still use hacks like qmp("") to wait for an event, even though we
> have qmp_eventwait() since commit 8fe941f, and qmp_eventwait_ref()
> since commit 7ffe312.  Both commits neglected to convert all the
> existing hacks.  Make up what they missed.
>=20
> Bonus: gets rid of empty format strings.  A step towards compile-time
> format string checking without triggering -Wformat-zero-length.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/boot-order-test.c   |  2 +-
>  tests/libqos/pci-pc.c     |  6 +-----
>  tests/tco-test.c          |  3 +--
>  tests/usb-hcd-uhci-test.c |  6 +-----
>  tests/usb-hcd-xhci-test.c | 12 ++----------
>  tests/wdt_ib700-test.c    | 35 ++++++++++-------------------------
>  6 files changed, 16 insertions(+), 48 deletions(-)

Nice!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OQhbRXNHSL5w/5po
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd1DCAAoJEJykq7OBq3PIHykH/il0LTHR78nJM/tfX6ebgcI7
DcdvQGu4g6SrXVCIDCqVgYTalqRjoo1iKowyT1v1t8YVEva1sxoAlk2+MbuRQVqN
RnSg6LfkK6hT/MWe85S9950fJDvg0qwWIZtmQjuvxRgqZNAp6WmODiocaO3CwocC
2MSPqqedTahq6aZ7qkOvJ/BVAej0h4qERDnIr8wNEkpA3wfvCDWVFucTx0BIq0GC
G6XM2wnzsQvxOCeJjMHtJOK5Tw1yM9fFEgB9nS4dOZQCM2y3RqlyBxRzkhrDarNM
M2UpuTx7rQ2xDjti7/AhKvjdXgOqn4Vz7yTEaTFLUkMYnw8jK5YhQ+J/KfFM1Uo=
=zYGb
-----END PGP SIGNATURE-----

--OQhbRXNHSL5w/5po--
