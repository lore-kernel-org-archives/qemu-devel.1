Received: from eggs.gnu.org ([2001:4830:134:3::10]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1douKs-0003Yu-AN
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1douKn-0001Yy-Mq
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:34:54 -0400
Date: Mon, 4 Sep 2017 18:34:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170904163432.GH14032@localhost.localdomain>
References: <20170726130337.24102-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726130337.24102-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, el13635@mail.ntua.gr

Am 26.07.2017 um 15:03 hat Stefan Hajnoczi geschrieben:
> Block driver documentation is available in qemu-doc.html.  It would be
> convenient to have documentation for formats, protocols, and filter
> drivers in a man page.
> 
> Extract the relevant part of qemu-doc.html into a new file called
> docs/qemu-block-drivers.texi.  This file can also be built as a
> stand-alone document (man, html, etc).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

This was still in my block-next branch even though I had to drop it from
a pull request for 2.10. I'm now dropping it from block-next, too,
because it conflicts with other recent changes (I never thought that we
had that much churn in the documentation, I take it as a good sign).

Please rebase and resend.

Kevin
