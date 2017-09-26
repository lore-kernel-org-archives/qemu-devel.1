Received: from eggs.gnu.org ([2001:4830:134:3::10]:34099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dwvZw-0002q4-Eh
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dwvZt-0005IB-8q
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:31:36 -0400
Date: Tue, 26 Sep 2017 22:31:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170926223046-mutt-send-email-mst@kernel.org>
References: <1506049617-25716-1-git-send-email-thuth@redhat.com>
	<513bbb2d-280b-92f8-b45f-89963f7118e2@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <513bbb2d-280b-92f8-b45f-89963f7118e2@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] [PATCH] tests/boot-sector: Increase timeout to 600
 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>, Victor Kaplansky <victork@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On Mon, Sep 25, 2017 at 12:06:40AM +0300, Michael Tokarev wrote:
> 22.09.2017 06:06, Thomas Huth wrote:
> > If QEMU has been compiled with the flags --enable-tcg-interpreter and
> > --enable-debug, the guest is running incredibly slow. The pxe boot test
> > can take up to 400 seconds when testing the pseries ppc64 machine. While
> > we should still look for ways to speed up the test on the pseries machine,
> > it's better to increase the timeout in this test to 600 seconds anyway to
> > allow the test to pass successfully now with this unusal configuration
> > already.
> 
> Applied to -trivial, thanks!
> 
> /mjt

Please do not apply this, trivial is not appropriate for functional
changes like this.
