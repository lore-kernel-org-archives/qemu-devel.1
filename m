Received: from eggs.gnu.org ([209.51.188.92]:39014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h2LVA-0000VH-Rb
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h2LV9-0006W0-49
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:49:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h2LV8-0006VI-Kx
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:49:50 -0500
Date: Fri, 8 Mar 2019 11:49:42 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Message-ID: <20190308194941.GC20066@heatpipe>
References: <20190307072025.8041-1-elena.ufimtseva@oracle.com>
	<20190307104550.GE2843@stefanha-x1.localdomain>
	<CAJ+F1CK_Lr+UKkzicLvfwcBRa4kTTrOQTm0wN8cEHek+Tkj=dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK_Lr+UKkzicLvfwcBRa4kTTrOQTm0wN8cEHek+Tkj=dw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 00/37] Initial support of
 multi-process qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, john.g.johnson@oracle.com, Stefano Stabellini <sstabellini@kernel.org>, jag.raman@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, QEMU <qemu-devel@nongnu.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>, kanth.ghatraju@oracle.com

On Thu, Mar 07, 2019 at 02:27:57PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Mar 7, 2019 at 11:46 AM Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> >
> > On Wed, Mar 06, 2019 at 11:20:25PM -0800, elena.ufimtseva@oracle.com =
wrote:
> > > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > >
> > > Initial support of multi-process qemu
> >
> > Hi Elena,
> > Please use the following setting when sending future patch series:
> >
> >   $ git config sendemail.thread shallow
> >
> > This way all patches are part of a single email thread (starting with
> > your PATCH 00 cover letter).  Reviewers find this more convenient so
> > that individual emails don't get separated and lost.

Thanks Stefan, will do.
> >
>=20
> Please also check that there is no regression after each commit. In
> particular, the build shouldn't fail, so we can easily study, apply
> and bisect patches one by one.
>=20


Yep, we try to make sure each commit builds and will automate for future
series as well, maybe with some simple tests.

Elena

> thanks
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau
