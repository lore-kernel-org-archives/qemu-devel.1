Received: from eggs.gnu.org ([2001:4830:134:3::10]:55703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL1oh-000877-LP
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL1oe-0000yB-Ho
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:30:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL1oe-0000xU-Bb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:30:08 -0400
Message-ID: <1497421805.11748.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 08:30:05 +0200
In-Reply-To: <1497411544-80213-1-git-send-email-liqiang6-s@360.cn>
References: <1497411544-80213-1-git-send-email-liqiang6-s@360.cn>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb: xhci: fix info leak when writing
 event to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org
Cc: liqiang6-s@360.cn, ppandit@redhat.com

On Tue, 2017-06-13 at 20:39 -0700, Li Qiang wrote:
> From: Li Qiang <liq3ea@gmail.com>
> 
> In 'xhci_write_event' function, the 'ev_trb' is not full initialized.
> This will lead an info leak issue. This patch avoid this.

I don't think so.  Note that only the first 16 bytes (TRB_SIZE) and not
the whole struct is copied to guest memory.

cheers,
  Gerd
