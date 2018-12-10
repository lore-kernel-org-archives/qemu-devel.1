Received: from eggs.gnu.org ([2001:4830:134:3::10]:33068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLOh-0006Zl-Mv
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLOc-0001Tn-Ql
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:14:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWLOc-0001TJ-JU
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:14:50 -0500
Date: Mon, 10 Dec 2018 14:14:46 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181210131446.4yqpeplud2wmribm@sirius.home.kraxel.org>
References: <20181206133923.30105-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206133923.30105-1-jgross@suse.com>
Subject: Re: [Qemu-devel] [PATCH] pvusb: set max grants only in initialise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, sstabellini@kernel.org

On Thu, Dec 06, 2018 at 02:39:23PM +0100, Juergen Gross wrote:
> Don't call xen_be_set_max_grant_refs() in usbback_alloc(), as the
> gnttabdev pointer won't be initialised yet. The call can easily be
> moved to usbback_connect().

Added to usb queue.

thanks,
  Gerd
