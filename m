Received: from eggs.gnu.org ([2001:4830:134:3::10]:49688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa1vK-0003vl-AK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa1vF-000832-F4
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:43:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa1vF-00082X-7k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:43:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 626918762D
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:43:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-220.phx2.redhat.com
	[10.3.116.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2391B16D23
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:43:28 +0000 (UTC)
Date: Mon, 2 Jul 2018 18:43:27 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180702164326.ry3qghgjkjrshouh@sirius.home.kraxel.org>
References: <20180702163345.17892-1-kraxel@redhat.com>
	<20180702163345.17892-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702163345.17892-2-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] warn about two vga cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Mon, Jul 02, 2018 at 06:33:45PM +0200, Gerd Hoffmann wrote:
> Two vga cards will try to register for the same legacy (isa) ioports.
> Due to this conflict only one of the two cards will work correctly in
> vga mode.
> 
> Print a warning message in that case.  Also try registering the ports
> only once, so the first vga added to the system will work properly.

Scratch that, not working as expected.
Looked like a simple change but appearently isn't.

cheers,
  Gerd
