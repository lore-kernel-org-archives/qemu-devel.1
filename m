Received: from eggs.gnu.org ([2001:4830:134:3::10]:54469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1zM-0001U2-7b
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1zG-0006rg-6K
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:26:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1zF-0006rE-UU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:26:02 -0400
Date: Tue, 21 Aug 2018 10:26:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821082600.v43rkxpqfteqh3y2@sirius.home.kraxel.org>
References: <20180729191928.11254-1-mail@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729191928.11254-1-mail@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] ohci: Clear the interrupt counter for
 erroneous transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org

On Sun, Jul 29, 2018 at 09:19:28PM +0200, Sebastian Bauer wrote:
> This is mandated by the ohci specification. It tells at 6.4.4 on page 104
> that for transfer descriptors that are retired with an error the done
> queue interrupt counter is cleared as if the interrupt delay field of the
> descriptions were zero.
> 
> Before this change, error conditions were handled similarly to the
> successful condition which is especially troublesome for control transfers.
> Some drivers (e.g., the AmigaOS-one) as well as the example code in the
> spec, set the setup stage with an interrupt delay of seven (which means no
> interrupt). This is fine under normal conditions, because one usually
> doesn't want to be notified about the completion of this stage. However, if
> an error occurs in this stage, these drivers will not get notified with the
> current implementation. The fix addresses this by following the spec more
> closely. Also, otherwise, the ability to set interrupt delay to seven would
> be useless.
> 
> Note that Linux drivers that I looked at don't seem to be affected as they
> set six as the interrupt delay presumably for the reason that they won't
> get notified otherwise.

Added to usb queue.

thanks,
  Gerd
