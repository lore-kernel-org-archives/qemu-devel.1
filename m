Received: from eggs.gnu.org ([2001:4830:134:3::10]:33858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gXiM9-00046G-4b
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 02:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gXiM5-00036V-S4
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 02:57:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gXiM5-000362-M5
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 02:57:53 -0500
Date: Fri, 14 Dec 2018 08:57:51 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181214075751.tr4lhpywq55avstt@sirius.home.kraxel.org>
References: <ab70659d8d5c580bdf150a5f7d5cc60c8e374ffc.1544740018.git.public@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab70659d8d5c580bdf150a5f7d5cc60c8e374ffc.1544740018.git.public@hansmi.ch>
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: Limit filename to object
 information size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Hanselmann <public@hansmi.ch>
Cc: qemu-devel@nongnu.org

On Thu, Dec 13, 2018 at 10:37:06PM +0000, Michael Hanselmann wrote:
> The filename length in MTP metadata is specified by the guest. By
> trusting it directly it'd theoretically be possible to get the host to
> write memory parts outside the filename buffer into a filename. In
> practice though there are usually NUL bytes stopping the string
> operations.
> 
> Also use the opportunity to not assign the filename member twice.

Added to usb patch queue.

thanks,
  Gerd
