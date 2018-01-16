Received: from eggs.gnu.org ([2001:4830:134:3::10]:41783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ebOPC-0007Ae-42
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ebOPB-000061-3D
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:23:46 -0500
Date: Tue, 16 Jan 2018 11:23:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180116102326.GA5719@localhost.localdomain>
References: <20180111195225.4226-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/10] x-blockdev-create for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Am 11.01.2018 um 20:52 hat Kevin Wolf geschrieben:
> This series implements a minimal QMP command that allows to create an
> image format on a given block node. The interface is still going to
> change to some kind of an async command (possibly a block job), so I
> prefixed x- for now.
> 
> At this point, I'm mostly interested in comments about
> BlockdevCreateOptions in the schema, the .bdrv_co_create callback and
> the way that legacy .bdrv_create is implemented in qcow2 now.
> 
> It looks to me as if we will have to keep .bdrv_create in addition to
> the new .bdrv_co_create for a while in all drivers, where the
> implementation of .bdrv_create would call .bdrv_co_create like this
> series does it for qcow2. We'll only be able to drop the old interface
> after deprecating and eventually removing all of the driver-specific
> compatibility work that remains. The example of qcow2 shows that the
> "translation" from old to new is managable, but there are a few
> differences.

Peter? Eric? Any opinions so far?

Kevin
