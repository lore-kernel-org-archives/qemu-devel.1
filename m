Received: from eggs.gnu.org ([2001:4830:134:3::10]:52800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn1tT-0007bo-J3
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn1tQ-0004x0-EI
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:19:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fn1tQ-0004wu-8Q
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:19:20 -0400
Date: Tue, 7 Aug 2018 15:19:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180807131918.22bgcmfv2wu4bjda@sirius.home.kraxel.org>
References: <20180720081948.23644-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720081948.23644-1-remy.noel@blade-group.com>
Subject: Re: [Qemu-devel] [PATCH] secondary-vga: unregister vram on unplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: remy.noel@blade-group.com
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Fri, Jul 20, 2018 at 10:19:48AM +0200, remy.noel@blade-group.com wrote:
> From: "Remy Noel" <remy.noel@blade-group.com>
> 
> When removing a secondary-vga device and then adding it back (or adding
> an other one), qemu aborts with:
>     "RAMBlock "0000:00:02.0/vga.vram" already registered, abort!".
> 
> It is caused by the vram staying registered, preventing vga replugging.

David?  Does that look ok?

This balances the

     vmstate_register_ram(&s->vram, s->global_vmstate ?  NULL : DEVICE(obj));

call in vga_common_init().  I'm wondering whenever the manual cleanup is
actually needed in case owner is not NULL?

thanks,
  Gerd
