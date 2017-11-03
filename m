Received: from eggs.gnu.org ([2001:4830:134:3::10]:58133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAYFg-0007DC-88
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAYFd-0006Va-4h
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAYFc-0006Uo-Ue
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:26:57 -0400
Message-ID: <1509701213.31823.11.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 10:26:53 +0100
In-Reply-To: <CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: =?UTF-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, 2017-11-02 at 17:12 +0000, Jind=C5=99ich Makovi=C4=8Dka wrote:
> This fixes the following case:
>=20
> 1) Ctrl-Alt-2 for console is pressed
> 2) console pops up and gets focus
> 3) console receives the Ctrl-Alt-2 keypress event

Hmm, doesn't reproduce here.
Also: why should the same event be delivered twice?

Ignoring autorepeat events (as the patch does, but which the commit
message doesn't mention) makes sense.  But I still fail to see why we
should limit hotkeys to the main window.

cheers,
  Gerd
