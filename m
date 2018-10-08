Received: from eggs.gnu.org ([2001:4830:134:3::10]:36662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9RYj-0007X3-5A
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9RYi-0002yY-Fe
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:10:37 -0400
Date: Mon, 8 Oct 2018 11:10:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181008091022.GA4604@localhost.localdomain>
References: <20181006183851.3797-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006183851.3797-1-sw@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH] qemu-io-cmds: Fix two format strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 06.10.2018 um 20:38 hat Stefan Weil geschrieben:
> Use %zu instead of %zd for unsigned numbers.
> 
> This fixes two error messages from the LSTM static code analyzer:
> 
> This argument should be of type 'ssize_t' but is of type 'unsigned long'
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Thanks, applied to the block branch.

Kevin
