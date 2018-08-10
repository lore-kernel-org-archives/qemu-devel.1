Received: from eggs.gnu.org ([2001:4830:134:3::10]:39337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo4RP-0005op-T0
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo4RM-0007RG-MC
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:14:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fo4RM-0007R5-Gy
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:14:40 -0400
Date: Fri, 10 Aug 2018 12:14:38 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180810101438.5yfxte2yojhaivtj@sirius.home.kraxel.org>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
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

On Thu, Aug 09, 2018 at 02:46:13PM +0300, Liran Alon wrote:
> Hi,
> 
> This patch series aim to fix many issues in vmware-svga emulation
> which have prevented it from being fully functional in a wide-variety
> of guests.

Nice job in modernizing the vmware svga emulation.

What guests this was tested with?  I've tried Fedora 28.  The vmware kms
driver loads fine, fbcon runs fine.  Nice.

But gdm doesn't start, neither with X11 nor with wayland.  Which is a
regression, because the xorg vmware driver manages to handle the current
qemu emulation just fine so gnome @ X11 works.

cheers,
  Gerd
