Received: from eggs.gnu.org ([2001:4830:134:3::10]:40049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <briansteffens@gmail.com>) id 1dpFVM-0004kR-KH
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <briansteffens@gmail.com>) id 1dpFVC-0007DR-Oo
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:11:08 -0400
MIME-Version: 1.0
In-Reply-To: <20170905095610.GF17449@stefanha-x1.localdomain>
References: <20170901201054.11738-1-briansteffens@gmail.com>
	<20170905095610.GF17449@stefanha-x1.localdomain>
From: Brian Steffens <briansteffens@gmail.com>
Date: Tue, 5 Sep 2017 11:10:55 -0400
Message-ID: <CALGxsMdOM_pv-uqMoC0MSVo0ai1vm_nHdZ5U8BNt+YNMXQEpkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] block: add block device shared field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Thanks for taking a look at the patch and fixing the missing CC
addresses!

> Have you considered extending the 'migrate' command with a list of
> drives instead?

That was my original plan but I thought having information on whether a
device is shared or not could potentially be useful to other systems. If
not then you're right, it would be a lighter touch to add it only to the
'migrate' command.

> In case you haven't seen it, the preferred approach for non-shared
> storage migration is drive-mirror + NBD.  The block/migration.c code is
> an older feature that is less flexible.  More info on drive-mirror +
> NBD:

I didn't realize drive-mirror + NBD was the preferred approach. Are
there any plans to drop support for the block/migration.c style?
