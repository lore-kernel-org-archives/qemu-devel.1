Received: from eggs.gnu.org ([2001:4830:134:3::10]:49766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHp8R-000627-Mg
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHp8L-0006h2-Lx
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:49:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cHp8L-0006gY-G7
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:48:57 -0500
Message-ID: <1481881734.8967.13.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Dec 2016 10:48:54 +0100
In-Reply-To: <20161215211838-mutt-send-email-mst@kernel.org>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215170523-mutt-send-email-mst@kernel.org>
	<1481819150.21413.21.camel@redhat.com>
	<20161215202505-mutt-send-email-mst@kernel.org>
	<20161215211838-mutt-send-email-mst@kernel.org>
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

> One strange thing - I only see it when guest is in graphical mode.
> If guest is in text mode it works ok.

grabbing works slightly different depending on whenever the mouse is in
absolute or relative mode, which is probably the reason for that.

With absolute mouse mode being active (using vmmouse or usb-tablet or
virtio-tablet) SDL grabs the keyboard if the mouse is within the qemu
window, and ungrabs if the mouse leaves the window.  Ungrab keyboard via
Ctrl-Alt still works for me, until you wiggle the mouse next time.  But
that is good enough to send specific keys to the host, i.e. just
pressing the window key sends it to the guest, and I see the gnome
window overview in the guest.  Pressing Ctrl-Alt, then the window key
shows the host gnome window overview.

cheers,
  Gerd
