Received: from eggs.gnu.org ([2001:4830:134:3::10]:51649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8Kgn-0007ch-4V
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8Kgf-0001wr-D4
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:06:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f8Kgf-0001uD-7I
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:05:57 -0400
Date: Tue, 17 Apr 2018 09:05:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180417070547.ralgzrmxmdlznhms@sirius.home.kraxel.org>
References: <1523698174-22832-1-git-send-email-agk@godking.net>
	<20180416082944.fkgqs5htp2rr3yi5@sirius.home.kraxel.org>
	<b751dfad-7548-63f1-4f79-7b068a5952aa@godking.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b751dfad-7548-63f1-4f79-7b068a5952aa@godking.net>
Subject: Re: [Qemu-devel] qapi: [PATCH v2] Implement query-usbhost QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Kappner <agk@godking.net>
Cc: armbru@redhat.com, qemu-devel@nongnu.org

On Mon, Apr 16, 2018 at 03:52:03PM -0700, Alexander Kappner wrote:
> Hi Gerd,
> 
> thanks for reviewing. I'll follow up with a v3 of the patch addressing your proposed changes.
> 
> >> This allows a QMP client to query which USB devices may be available
> >> for redirection.
> 
> > At least libvirt sandboxes qemu, for security reasons, and you wouldn't
> > get any useful results because qemu hasn't the permissions needed to
> > scan the usb bus.
> Then at least this tells you that you can't make anything available via redirection either, which is also useful information.

Well, you can, but you have to go through libvirt instead.  Libvirt will
whitelist the usb device you want assign then (and only that one) so
qemu can access it.

> > I'm wondering what the use case is?

> I'm working on a smartphone client that talks to a QEMU instance via
> QMP, and that allows the user to switch USB devices between host and
> QEMU guest. This removes the need for a separate set of input devices
> permanently assigned to the host (since if I pass through a
> keyboard/mouse to the VM, I can't use that same keyboard/mouse to run
> a command that re-attaches those devices to the host, so I need some
> external channel). Basically using the phone as a KVM switch.

That wouldn't work for any libvirt-managed guests.

Also: Do you know input-linux (see ui/input-linux.c)?  That allows
switching input devices between host and (one) guest by keyboard hotkey.

cheers,
  Gerd
