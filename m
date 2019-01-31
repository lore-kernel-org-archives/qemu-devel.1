Received: from eggs.gnu.org ([209.51.188.92]:42568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gp7KF-0004JT-FN
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gp7KE-0007Zt-NC
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:03:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gp7KE-0007ZD-Ga
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:03:54 -0500
Date: Thu, 31 Jan 2019 09:03:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190131080352.nymxlr5nc7xtqiom@sirius.home.kraxel.org>
References: <1548859022-3969-1-git-send-email-liam.merwick@oracle.com>
	<1548859022-3969-3-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548859022-3969-3-git-send-email-liam.merwick@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] usb: deal with potential Null pointer
 returned by usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, Darren.Kenny@oracle.com, Mark.Kanda@oracle.com, ameya.more@oracle.com

On Wed, Jan 30, 2019 at 02:37:02PM +0000, Liam Merwick wrote:
> From: Liam Merwick <Liam.Merwick@oracle.com>
> 
> usb_ep_get() can return a Null pointer in the (albeit unlikely) case
> that a NULL USBDevice is passed in via the 'dev' parameter.

That should never ever happen.

> Reported by the Parfait static code analysis tool

Try add "assert(dev != NULL)" to usb_ep_get() instead of sprinkling
pointless checks all over the place.

thanks,
  Gerd
