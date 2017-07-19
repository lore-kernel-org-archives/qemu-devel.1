Received: from eggs.gnu.org ([2001:4830:134:3::10]:59904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dXkaZ-0006Jm-A9
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dXkaW-0006Ca-17
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:44:11 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dXkaV-0006BH-Of
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:44:07 -0400
Received: by mail-wm0-x244.google.com with SMTP id 65so2621734wmf.0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 01:44:06 -0700 (PDT)
Date: Wed, 19 Jul 2017 09:44:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170719084402.GA5628@stefanha-x1.localdomain>
References: <20170712094149.23069-1-jfreimann@redhat.com>
	<20170712180550-mutt-send-email-mst@kernel.org>
	<20170712211305.ajtizorj4yq6jble@localhost.localdomain>
	<20170713012811-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20170713012811-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH RFC 0/3] tests/pxe-testt: add testcase
 using vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Freimann <jfreimann@redhat.com>, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, victork@redhat.com, qemu-devel@nongnu.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 01:33:43AM +0300, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2017 at 11:13:05PM +0200, Jens Freimann wrote:
> > On Wed, Jul 12, 2017 at 06:10:05PM +0300, Michael S. Tsirkin wrote:
> > > On Wed, Jul 12, 2017 at 11:41:46AM +0200, Jens Freimann wrote:
> > > > This implements a testcase for pxe-test using the vhost-user interf=
ace. Spawn a
> > > > vhost-user-bridge process and connect it to the qemu process.
> > > >=20
> > > > It is send as an RFC because:
> > > >  - Patch 3/3: there must be cleaner way to do this.
> > > >  - Does Patch 1/3 make sense or should I just redirect all output t=
o /dev/null?
> > > >  - don't hardcode port numbers in qemu cmdline, create socket and p=
ass
> > > >     fd to -netdev (need to figure out how to do this)
> > >=20
> > > Doesn't this work?
> > >=20
> > > -netdev socket,id=3Dstr[,fd=3Dh]
> >=20
> > It should. But I get this:
> >=20
> >        dded sock 5 for watching. max_sock: 5
> >        Sock 3 removed from dispatcher watch.
> >        qemu: error: specified mcastaddr "127.0.0.1" (0x7f000001) does n=
ot contain a multicast address
> >        qemu-system-x86_64: -netdev socket,id=3Dn1,fd=3D3: Device 'socke=
t' could not be initialized
> >        Broken pipe
>=20
> Not sure what's wrong with it, should not be too hard to debug.

Jens asked me this question on IRC.  I didn't know the answer either but
git-log(1) shows what happened:

-net socket,fd=3D was broken for SOCK_DGRAM from the moment mcast was
introduced by commit 3d830459b1eccdb61b75e2712fd364012ce5a115 ("'-net
socket,mcast=3D' option support (initial patch by Juan Jose Ciarlante)").

The issue is probably that the fd init code doesn't know whether the
user wanted mcast or not.  Right now it's hardcoded to assume that mcast
is desired.  It may be necessary to extend the command-line syntax to
specify mcast explicitly with fd=3D.

Stefan

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbxvSAAoJEJykq7OBq3PIGqkH+wdPtQTtO2gm+s5PUrDnpkGl
1UUbt104kHaedcjlYW70aCG+EPxu3A6vQN3Sh+wcMLMztK2/th20deYZhJsJeTaa
QD6MrFJGmOnKYQJv4CiO3IeoE9Zk2dgcbRvuykKss5bW+Bbmqg8OgLkjlSRP8l1d
DHiHynvDuLPrq/vhUgjSmjA+bNt0jq6JIMzwWgO2Dyx0pZZkmSosPy2pa9F1xpfa
aLRRnHQGRdDqJ4ce32DuqW1kObjJSO5lZ/Fb+QrU7r96nPNaArEM5R8QnMtCXzYa
0VQyAg/YWRsqqnNDdf8TiKEfMmjN8CeqE+Y6ugxR1IaC9Mb9dn2NyJ1Rwtu03Oc=
=r7Rq
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
