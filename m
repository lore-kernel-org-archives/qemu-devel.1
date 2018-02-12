Received: from eggs.gnu.org ([2001:4830:134:3::10]:38597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elIf5-0006pE-Iv
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elIf4-0005AV-Lc
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:17:07 -0500
Date: Mon, 12 Feb 2018 19:17:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180212181701.GJ5103@localhost.localdomain>
References: <20171208133416.28978-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171208133416.28978-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: fix EOF Ctrl-D handling in
 qemu-io readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Am 08.12.2017 um 14:34 hat Daniel P. Berrange geschrieben:
> qemu-io puts the TTY into non-canonical mode, which means no EOF processing is
> done and thus getchar() will never return the EOF constant. Instead we have to
> query the TTY attributes to determine the configured EOF character (usually
> Ctrl-D / 0x4), and then explicitly check for that value. This fixes the
> regression that prevented Ctrl-D from triggering an exit of qemu-io that has
> existed since readline was first added in
> 
>   commit 0cf17e181798063c3824c8200ba46f25f54faa1a
>   Author: Stefan Hajnoczi <stefanha@redhat.com>
>   Date:   Thu Nov 14 11:54:17 2013 +0100
> 
>     qemu-io: use readline.c
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Thanks, applied to the block branch.

It would be nice if we also printed a newline when Ctrl-D is pressed. If
you want to send a v3 for this, I'll just update the patch in my queue.

Kevin
