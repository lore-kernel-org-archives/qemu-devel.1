Received: from eggs.gnu.org ([2001:4830:134:3::10]:43652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCNJd-0006Yo-EE
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCNJa-0001wk-AH
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:10:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eCNJa-0001wJ-3r
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:10:34 -0500
Date: Wed, 8 Nov 2017 11:10:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171108101031.6z3yqsjw6n5saxcr@sirius.home.kraxel.org>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
	<27e88186-fa91-fac3-1564-9c81a55fecd4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27e88186-fa91-fac3-1564-9c81a55fecd4@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] sdl2: Only accept the hotkeys on the
 main window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>
Cc: =?utf-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>, qemu-devel@nongnu.org

On Sun, Nov 05, 2017 at 09:10:45AM -0500, Cole Robinson wrote:
> On 11/02/2017 01:12 PM, Jind=C5=99ich Makovi=C4=8Dka wrote:
> > This fixes the following case:
> >=20
> > 1) Ctrl-Alt-2 for console is pressed
> > 2) console pops up and gets focus
> > 3) console receives the Ctrl-Alt-2 keypress event
> > 4) console closes
> > 5) focus returns to the main window
> > 6) main window gets the keypress event
> > 7) goto 2 until the key is released, with 50% chance that the console
> > window is shown at the end
>=20
> Sounds similar to what I reported in my comment here a while back:
> https://bugzilla.libsdl.org/show_bug.cgi?id=3D3287

Hmm, so it seems to be a SDL bug.  I'm running SDL 2.0.3 here, which
explains why I can't reproduce it.  According to the bug it seem to be
*repeat* keydown events, so is simply ignoring repeat events enough to
avoid this issue?

Also: Jind=C5=99ich, do you plan to send a new of the patch series with t=
he
issues discussed fixed?

cheers,
  Gerd
