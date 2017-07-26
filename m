Received: from eggs.gnu.org ([2001:4830:134:3::10]:43954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daM46-00033N-AO
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daM45-0005rW-7n
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:09:26 -0400
Date: Wed, 26 Jul 2017 14:09:13 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170726130913.GM7620@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170726130337.24102-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, el13635@mail.ntua.gr

On Wed, Jul 26, 2017 at 02:03:37PM +0100, Stefan Hajnoczi wrote:
> Block driver documentation is available in qemu-doc.html.  It would be
> convenient to have documentation for formats, protocols, and filter
> drivers in a man page.
> 
> Extract the relevant part of qemu-doc.html into a new file called
> docs/qemu-block-drivers.texi.  This file can also be built as a
> stand-alone document (man, html, etc).

Is there perhaps benefit it taking it further and creating one
man page per block driver. Many of the block drivers are optional
and can be turned off, so this would let us leave out the docs
for disabled block drivers too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
