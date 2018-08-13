Received: from eggs.gnu.org ([2001:4830:134:3::10]:55278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fpAUn-00069B-Df
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fpAUh-000097-FW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:54:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fpAUh-00008a-9T
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:54:39 -0400
Date: Mon, 13 Aug 2018 12:54:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180813105434.wf3av75adodadt6x@sirius.home.kraxel.org>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
	<20180810101438.5yfxte2yojhaivtj@sirius.home.kraxel.org>
	<C1C2761F-F9A0-442C-8B11-21EB645FEC5C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1C2761F-F9A0-442C-8B11-21EB645FEC5C@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 00/29]: vmsvga: Various fixes and
 enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com

  Hi,

> > But gdm doesn't start, neither with X11 nor with wayland.  Which is a
> > regression, because the xorg vmware driver manages to handle the current
> > qemu emulation just fine so gnome @ X11 works.
> 
> Interesting. Thanks for finding this out. Will have a look.
> Can you give more exact details about how you reproduced this issue?

xorg is easiest, because Fedora 28 uses that by default for vmware svga:

  (1) download Fedora 28 workstation live iso.
  (2) boot in qemu with -vga vmware.

To try wayland you have to install fedora to disk (can be done using the
workstation live iso).

You can switch between xorg and wayland using /etc/gdm/custom.conf then,
by commenting/uncommenting the WaylandEnable line ...

   [daemon]
   # Uncoment the line below to force the login screen to use Xorg
   #WaylandEnable=false

... and rebooting.

> I prefer to have a similar setup to make sure we have fixed the
> regression in this series.

xorg regression needs fixing.

Having wayland working too would be nice, but wayland doesn't work with
the current emulation either.  So it isn't a regression and can be done
as separate patch series later on.

cheers,
  Gerd
