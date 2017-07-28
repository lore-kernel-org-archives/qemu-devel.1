Received: from eggs.gnu.org ([2001:4830:134:3::10]:43658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4SD-0002mT-Fx
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4S9-0000lN-Sj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:33:17 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1db4S9-0000ke-Lw
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:33:13 -0400
Received: by mail-wm0-x232.google.com with SMTP id m85so20743951wma.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 05:33:13 -0700 (PDT)
Date: Fri, 28 Jul 2017 13:33:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728123310.GN12364@stefanha-x1.localdomain>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZihrQ6eCIduWT38"
Content-Disposition: inline
In-Reply-To: <20170725211523.3998-7-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/12] tests/libqos/usb: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com


--dZihrQ6eCIduWT38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 04:15:17PM -0500, Eric Blake wrote:
> From: Markus Armbruster <armbru@redhat.com>
>=20
> Leaving interpolation into JSON to qmp() is more robust than building
> QMP input manually, as explained in the previous commit.
>=20
> The case in usb_test_hotplug() is slightly more complicated: it
> interpolates *into* JSON values.  Clean it up by building the values
> separately, so we can again leave interpolation to qmp().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <1500645206-13559-6-git-send-email-armbru@redhat.com>
> [fix commit message typo]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqos/usb.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dZihrQ6eCIduWT38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZey8GAAoJEJykq7OBq3PIfScIAJ2yJ8FZKrLVRrRF5+Jq1CSm
A8tSfcYMyh7WqUi8RH8Tj1LXIJkJhneRWaBdCgYnwWco/hpZWmuOI4CilmlVmuVD
Xam6pXyffRfH+56//TS5BJX1qRIFCekYx9/Vb4Lg+dOio3XcPzugQ+OSwBzbN5ok
nAqpl7Twg3KC72KCWfYaCsjouZEp/QTTG9GUU9OhU7BTNMoGV5DE5Fx+RxjouT+J
/fowqFA006KMqATTiI/NBukjV48T3ojKPOYJup1qKyz+QB446vo4SIQPtmYuMYRu
8mQacbP8SnO2g+WtUtVD4qtby9L8tGhAGJ08M+jDzexboqhjYLgMu0mf8Ub9Th8=
=5Ttd
-----END PGP SIGNATURE-----

--dZihrQ6eCIduWT38--
