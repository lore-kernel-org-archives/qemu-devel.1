Received: from eggs.gnu.org ([2001:4830:134:3::10]:46263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHowE-00023I-B0
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHowB-0006Ux-Jg
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:36:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cHowB-0006Up-Df
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:36:23 -0500
Message-ID: <1481880980.8967.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Dec 2016 10:36:20 +0100
In-Reply-To: <20161216002706-mutt-send-email-mst@kernel.org>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215170523-mutt-send-email-mst@kernel.org>
	<1481819150.21413.21.camel@redhat.com>
	<20161216002706-mutt-send-email-mst@kernel.org>
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

> > [ 2.6 good, 2.7, 2.8 bad ]

> > It doesn't reproduce here.  There must be some other factor which is
> > needed to trigger this.  What desktop you are using?  gnome?  kde?
> > something else?  Xorg or wayland?
> >=20
> > Can you try to bisect it?
> >=20
> > cheers,
> >   Gerd
>=20
>=20
> Looks like 2.6 does not work either :(

That is in line with my assumption that there must be something else
needed in addition to trigger it.  Maybe it happens on F25 only and F24
used to work fine for you?

> Gerd, are you using F25?

RHEL-7 with gnome here.

cheers,
  Gerd
