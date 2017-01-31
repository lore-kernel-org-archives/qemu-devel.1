Received: from eggs.gnu.org ([2001:4830:134:3::10]:48176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYbJy-0000bV-HG
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYbJx-0003BU-OQ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:30:18 -0500
Date: Tue, 31 Jan 2017 16:30:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131163010.GW18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-18-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y974o0GblB/Ae/yP"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-18-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 17/21] backup: make all reads not
 serializing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--Y974o0GblB/Ae/yP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:29:00PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> To simplify things make all reads not serializing, not only from
> notifiers. This is needed because after the following patch, there would
> not be strong division between reads from notifiers or not - they all
> would be called from one place.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Y974o0GblB/Ae/yP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkLuSAAoJEJykq7OBq3PI+QIIAIX5eqIgIp9jDFeGn22AYuPB
2ifiwyrNRNL0nbsOdfWb/JEuXICswRSFI0St9quzMW9D9F34kwBNSSAF6H2tYcge
Eu6YAbacjJrWfmFmndRCVCSUqyxcoKJuiSdjrIXSkniLox0+wvZq76+NqEYxRlwP
J3u/9zW1aRqyCr9D5GLeTEInSUXSYCnMamPA0uAP7zF610JKdUGrLip/IFhXsR4K
Th7za9b4wIzCy+4jECgIVhvkGkkj7x2znzi0c96lORi2TbF0hNeioHwPs6R1JYd/
/8E82mGXtsyHw80VvinSehzyKKIEabYIwcPMkuG3BQIYbD63oNWybxboAeeNG28=
=iOna
-----END PGP SIGNATURE-----

--Y974o0GblB/Ae/yP--
