Received: from eggs.gnu.org ([2001:4830:134:3::10]:45306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gAf49-0008Jn-3Q
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gAf45-0007dS-PT
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gAf45-0007bh-Id
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:48:01 -0400
Date: Thu, 11 Oct 2018 14:47:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181011174756.GA31050@habkost.net>
References: <20181001063803.22330-1-clg@kaod.org>
	<20f2bf61-8c11-47cb-a05c-7248d51a53a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20f2bf61-8c11-47cb-a05c-7248d51a53a8@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] net: convert SysBus init method
 to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Wed, Oct 10, 2018 at 03:30:25PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing Eduardo since it might make sens to have this series go via his
> machine-next tree, rather than Jason's net tree.

Queued on machine-next, thanks!

>=20
> On 01/10/2018 08:37, C=E9dric Le Goater wrote:
> > Hello,
> >=20
> > Here is my take to the SysBus init to realize method conversion. I
> > picked the /net directory and did them all. Also added a couple of
> > reset methods in separate patches.
> >=20
> > make check tested
> >=20
> > Thanks,
> >=20
> > C.
> >=20
> > Changes since v1:
> >=20
> >  - dropped changes in lan9118_init() and smc91c111_init()
> >  - fix alignment in milkymist_minimac2_realize()
> >  - improved etraxfs reset method
> > =20
> >=20
> > C=E9dric Le Goater (11):
> >   net: etraxfs_eth: convert SysBus init method to a realize method
> >   net: etraxfs_eth: add a reset method
> >   net: lan9118: convert SysBus init method to a realize method
> >   net: lance: convert SysBus init method to a realize method
> >   net: milkymist_minimac2: convert SysBus init method to a realize
> >     method
> >   net: mipsnet: convert SysBus init method to a realize method
> >   net: opencores_eth: convert SysBus init method to a realize method
> >   net: smc91c111: convert SysBus init method to a realize method
> >   net: stellaris_enet: convert SysBus init method to a realize method
> >   net: stellaris_enet: add a reset method
> >   net: xgmac: convert SysBus init method to a realize method
> >=20
> >  hw/net/etraxfs_eth.c        | 44 ++++++++++++++++++++++++++---------=
--
> >  hw/net/lan9118.c            |  9 +++-----
> >  hw/net/lance.c              |  8 +++----
> >  hw/net/milkymist-minimac2.c |  9 +++-----
> >  hw/net/mipsnet.c            |  9 +++-----
> >  hw/net/opencores_eth.c      |  8 +++----
> >  hw/net/smc91c111.c          |  8 +++----
> >  hw/net/stellaris_enet.c     | 15 ++++++-------
> >  hw/net/xgmac.c              |  9 +++-----
> >  9 files changed, 59 insertions(+), 60 deletions(-)
> >=20
>=20

--=20
Eduardo
