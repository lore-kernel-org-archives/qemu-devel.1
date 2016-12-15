Received: from eggs.gnu.org ([2001:4830:134:3::10]:59802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHSAv-0002w2-J9
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHSAs-0002yW-Cx
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:18:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cHSAs-0002yK-77
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:18:02 -0500
Message-ID: <1481793479.21413.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 15 Dec 2016 10:17:59 +0100
In-Reply-To: <20161215075028.GD26169@stefanha-x1.localdomain>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

On Do, 2016-12-15 at 07:50 +0000, Stefan Hajnoczi wrote:
> On Thu, Dec 15, 2016 at 06:35:39AM +0200, Michael S. Tsirkin wrote:
> > The problem always reproduces for me:
> > - start qemu with -sdl
> > - wait for guest to boot
> > - click anywhere within guest screen
> > - message "press ctrl+alt to exit capture" appears on screen,
> >   but pressing that immediately restarts capture again
> >=20
> > Note:
> > - had to exit to another VT and kill qemu
> > - why was I able to do that?
> >   should not ctrl-alt-Fn be captured too?
>=20
> Sounds related to:
>=20
> commit 56f289f383a871e871f944c7226920b35794efe6
> Author: Cole Robinson <crobinso@redhat.com>
> Date:   Fri May 6 14:03:06 2016 -0400
>=20
>     ui: sdl2: Release grab before opening console window
>=20
> Stefan

Doesn't look related to me, also this is in the v2.7 release already.
There are no SDL updates in 2.8.  Hmm.  /me looks a bit puzzled.

What is the known-good setup?

cheers,
  Gerd
