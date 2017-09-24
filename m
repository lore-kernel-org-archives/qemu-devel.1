Received: from eggs.gnu.org ([2001:4830:134:3::10]:39717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwE6x-0002bp-D8
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwE6s-0004yB-Ev
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:06:47 -0400
References: <1506049617-25716-1-git-send-email-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <513bbb2d-280b-92f8-b45f-89963f7118e2@msgid.tls.msk.ru>
Date: Mon, 25 Sep 2017 00:06:40 +0300
MIME-Version: 1.0
In-Reply-To: <1506049617-25716-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>, Victor Kaplansky <victork@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

22.09.2017 06:06, Thomas Huth wrote:
> If QEMU has been compiled with the flags --enable-tcg-interpreter and
> --enable-debug, the guest is running incredibly slow. The pxe boot test
> can take up to 400 seconds when testing the pseries ppc64 machine. While
> we should still look for ways to speed up the test on the pseries machine,
> it's better to increase the timeout in this test to 600 seconds anyway to
> allow the test to pass successfully now with this unusal configuration
> already.

Applied to -trivial, thanks!

/mjt
