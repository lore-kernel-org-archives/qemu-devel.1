Received: from eggs.gnu.org ([209.51.188.92]:36360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggpnl-00050d-Ua
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggpnh-0003Z4-5A
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:44:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggpng-0003XQ-Up
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:44:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2923F461CF
	for <qemu-devel@nongnu.org>; Tue,  8 Jan 2019 11:44:04 +0000 (UTC)
Date: Tue, 8 Jan 2019 12:44:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190108114403.ozhtaryyufd5izwn@sirius.home.kraxel.org>
References: <1545064358-4601-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545064358-4601-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] usb: move
 ehci_create_ich9_with_companions to hw/i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Dec 17, 2018 at 05:32:38PM +0100, Paolo Bonzini wrote:
> This function is only needed when Q35 is in use.  Moving it to
> the same file that uses it lets you disable the entire USB
> subsystem in x86_64-softmmu.mak; of course doing that will
> cause -usb to break horribly, but one thing at a time.

Added to usb queue.

thanks,
  Gerd
