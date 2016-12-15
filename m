Received: from eggs.gnu.org ([2001:4830:134:3::10]:60948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHYqz-00032E-7q
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHYqv-00030L-Bh
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:25:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cHYqv-0002yc-5L
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:25:53 -0500
Message-ID: <1481819150.21413.21.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 15 Dec 2016 17:25:50 +0100
In-Reply-To: <20161215170523-mutt-send-email-mst@kernel.org>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215170523-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] regression in 2.8: unable to exit screen grab in
 SDL mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

  Hi,

> > > > The problem always reproduces for me:
> > > > - start qemu with -sdl
> > > > - wait for guest to boot
> > > > - click anywhere within guest screen
> > > > - message "press ctrl+alt to exit capture" appears on screen,
> > > >   but pressing that immediately restarts capture again

[ 2.6 good, 2.7, 2.8 bad ]

> I'd say SDL is mostly useless with this bug.
>=20
> Do we fix this or disable SDL altogether?

Well, it can't be *that* bad, otherwise it would not went unnoticed for
a whole release cycle.

It doesn't reproduce here.  There must be some other factor which is
needed to trigger this.  What desktop you are using?  gnome?  kde?
something else?  Xorg or wayland?

Can you try to bisect it?

cheers,
  Gerd
