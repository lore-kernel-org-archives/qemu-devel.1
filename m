Received: from eggs.gnu.org ([2001:4830:134:3::10]:37110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etyAO-0003B4-EH
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etyAK-0006Ea-FH
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:13:16 -0500
Date: Thu, 8 Mar 2018 16:13:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180308161309.GF2769@stefanha-x1.localdomain>
References: <20180307162958.11232-1-nia.alarie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline
In-Reply-To: <20180307162958.11232-1-nia.alarie@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/virtio: Convert virtio-ccw from
 *_exit to *_unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com, jim@groklearning.com, joel@jms.id.au


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2018 at 04:29:58PM +0000, Nia Alarie wrote:
> @@ -760,12 +760,12 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
>      if (sch) {
>          css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
>          g_free(sch);
> +        ccw_dev->sch = NULL;

This change is unrelated to the topic of the patch and not mentioned in
the commit description.  I think it was probably made for consistency,
rather than a bug fix or functional change.  That's a valid reason too
but please mention secondary changes like this in future patches so
reviewers know why you made them.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaoWEVAAoJEJykq7OBq3PISC8IALij0P6v/xOpDzVY1Yr5wwEC
X3FgleIyas475lkzJhFbGmXk6XVbQsOeu1LdAayMb75XxVJ4z1rxmrhNBzhC8HIf
Ac4z34YCMMllFhtCAXleJFsqhUsAkGUjMwu5gbZbI9x1cAu1C1hjREDmG0GyicNP
AIzBI+gk/6nk197F3JbnmS3Yu16vIupFPaBKo0uw5ZzDBFWVB0azRyBqkJI1TRao
PJgxliduOFRKOcG9uR2bccHdNsjeRvbbJAF3OGMxyBrMhNpoqfC5Sw9IuK2VRyRc
HLnzQMoVrrDG/W/UBHQM55q8Ghr/nYSw7kN0pBgJUtu4l9VlPrnB4zPh1eWjuDY=
=taNL
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
