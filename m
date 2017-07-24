Received: from eggs.gnu.org ([2001:4830:134:3::10]:40335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZZwX-00065u-5a
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZZwW-0006S9-Gd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:46:25 -0400
Date: Mon, 24 Jul 2017 11:46:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170724094614.GF4630@noname.str.redhat.com>
References: <20170627154120.20346-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627154120.20346-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] docs: add qemu-block-drivers(7) man page
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

Am 27.06.2017 um 17:41 hat Stefan Hajnoczi geschrieben:
> Block driver documentation is available in qemu-doc.html.  It would be
> convenient to have documentation for formats, protocols, and filter
> drivers in a man page.

This is specifically for create options, which is a good start.

I think we should probably also plan how to integrate run-time options
(basically the equivalent of the QAPI schema comments for blockdev-add).
Maybe we can even generate this from the schema in order to avoid that
the documentation becomes outdated?

> Extract the relevant part of qemu-doc.html into a new file called
> docs/qemu-block-drivers.texi.  This file can also be built as a
> stand-alone document (man, html, etc).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Looks good, but doesn't apply any more.

A rebased version can still be included in QEMU 2.10, documentation
improvements are fine during the freeze.

Kevin
