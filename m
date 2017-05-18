Received: from eggs.gnu.org ([2001:4830:134:3::10]:38851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dBGK8-0006P1-NJ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dBGK8-0005yY-17
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:58:16 -0400
Date: Thu, 18 May 2017 09:57:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170518075759.GA4646@noname.redhat.com>
References: <20170517170941.25850-1-stefanha@redhat.com>
	<20170517170941.25850-3-stefanha@redhat.com>
	<e6d9417e-87bb-a88f-4f55-0a72aae0a212@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <e6d9417e-87bb-a88f-4f55-0a72aae0a212@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] block: use BDRV_POLL_WHILE() in
 bdrv_rw_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.05.2017 um 22:16 hat Eric Blake geschrieben:
> On 05/17/2017 12:09 PM, Stefan Hajnoczi wrote:
> > Calling aio_poll() directly may have been fine previously, but this is
> > the future, man!
>=20
> lol
>=20
> >  The difference between an aio_poll() loop and
> > BDRV_POLL_WHILE() is that BDRV_POLL_WHILE() releases the AioContext
> > around aio_poll().
> >=20
> > This allows the IOThread to run fd handlers or BHs to complete the
> > request.  Failure to release the AioContext causes deadlocks.
> >=20
> > Using BDRV_POLL_WHILE() partially fixes a 'savevm' hang with -object
> > iothread.
>=20
> I'm surprised at how many separate hangs we actually had!

How hard would it be to write some test cases for this? Dataplane has
a serious lack of automated testing.

Kevin

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZHVQGAAoJEH8JsnLIjy/WZEYQAIVmwmWnoNXaQCAsxwiUV0O8
TozlfsNZCExkBfHbLBCi6ngGUlvsLECi3aastfTPgSR57beO6te7GEcUcWH0xmMe
1d1mqZMV8L9NgLq+Gv4fuupMzQ9vf8F0D0BS9unLN3iG1HcnLYlJ5DPQSMUQlZGL
FDJ36IQh8r8ba+YNmuzCzdcKgecAkNdv4DAhhUuxktxBKH08gghhMWrxZCC4Q0BT
djRzBeEY2LSkeQNBDv4NT6WLZq5fmuR//L09RXQb1B3STqaUAH7u8fSsGtVTJLuZ
cRMPJI5nYgRw0B7U/YliaSQr5dts4G3JzxvuAJjRYLNagg2/YpqeprrEJy0UqBQY
zzxtpT8Wi1BzROuv2cN8lm03Mjw9WrID8fFMnrhHHpSYbRPTF1ozA/pkUF8A+QxX
kgClZiim6CuQkVOUH62G1EH+Jq7Mq0rnAqo+2KkLha9aWsZDg/d3FEdppjXO8o+s
FKiuAgTs+fzEOJYmxg3MOrDvbLjpozrv+5bEqSpVpsfwgfKyKnV++KMoU02Degwb
u9/7TI+1+vnqWuFohZqkQqMzpKk7m0izwM646BV3/Jnf1XioxjEhZ+OMFviblT6W
qVZEEMLAdFRm9AgfsGKadUX5Az+lMyik8mfVpFZT533VcZ3KTRy5TIWOpEhdB5d7
nrnjA1MTv+JhhljwVBy5
=nSDO
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
