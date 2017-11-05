Received: from eggs.gnu.org ([2001:4830:134:3::10]:36591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1eBLdV-0001NY-Bx
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1eBLdS-00037m-6b
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:10:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1eBLdR-00036U-WE
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:10:50 -0500
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <27e88186-fa91-fac3-1564-9c81a55fecd4@redhat.com>
Date: Sun, 5 Nov 2017 09:10:45 -0500
MIME-Version: 1.0
In-Reply-To: <CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Jind=c5=99ich_Makovi=c4=8dka?= <makovick@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 11/02/2017 01:12 PM, Jind=C5=99ich Makovi=C4=8Dka wrote:
> This fixes the following case:
>=20
> 1) Ctrl-Alt-2 for console is pressed
> 2) console pops up and gets focus
> 3) console receives the Ctrl-Alt-2 keypress event
> 4) console closes
> 5) focus returns to the main window
> 6) main window gets the keypress event
> 7) goto 2 until the key is released, with 50% chance that the console
> window is shown at the end

Sounds similar to what I reported in my comment here a while back:
https://bugzilla.libsdl.org/show_bug.cgi?id=3D3287

- Cole
