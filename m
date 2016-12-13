Received: from eggs.gnu.org ([2001:4830:134:3::10]:33878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cGihf-0004h9-1s
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cGihW-0004hW-Eq
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:44:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cGihW-0004gk-7z
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:44:42 -0500
Message-ID: <1481616362.27088.74.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Dec 2016 09:06:02 +0100
In-Reply-To: <f460049b-211e-194b-d4c3-a3cc34e4d289@cendio.se>
References: <f460049b-211e-194b-d4c3-a3cc34e4d289@cendio.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] VNC LED state buggy, interop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Ossman <ossman@cendio.se>
Cc: qemu-devel@nongnu.org

  Hi,

> The basic problem is that the code right now assumes that XK_Caps_Lock=
=20
> and XK_Num_Lock will toggle their respective states. It is however not=
=20
> assumed that XK_Scroll_Lock toggles any state.

The whole thing is more intended to make sure guest and host have the
same idea about numlock and capslock state, so input works propery, not
so much about making the leds blink properly.

And, yes, it assumes you don't remap capslock + numlock keys to
something else (in the guest).  vnc has an option (lock-key-sync) to
turn off this logic in case it causes problems because the assumtion
doesn't hold for a specific guest.

>   b) Remove the assumption from the code and the protocol.

Patches are welcome.

cheers,
  Gerd
