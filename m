Received: from eggs.gnu.org ([2001:4830:134:3::10]:41655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ecWjJ-0003MN-73
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ecWjG-0007Ax-1r
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:29:13 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <6d5d984f-5d25-a2da-b50d-71c7a49e3de3@redhat.com>
References: <cover.1513342045.git.berto@igalia.com>
	<ef848b9847fecf18fbb05f9a9824436e6601a09d.1513342045.git.berto@igalia.com>
	<6d5d984f-5d25-a2da-b50d-71c7a49e3de3@redhat.com>
Date: Fri, 19 Jan 2018 14:28:32 +0100
Message-ID: <w51y3ku2d1b.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 18/32] qcow2: Update
 qcow2_get_cluster_offset() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 16 Jan 2018 11:42:45 PM CET, Eric Blake wrote:
> Callers like 'qemu-img map' will potentially have to iterate in more
> steps over an entire image; but that's not a severe limitation.  The
> block_status() functions already document that as long as drivers make
> progress, callers must be prepared for back-to-back calls that return
> the same status, so you are not breaking semantics with a shorter
> clamping limit.
>
> Maybe some of that is worth mentioning in the commit message.  Either
> way,

Yes indeed, for 4KB slices and 64KB clusters each slice can only map
32MB. Then again I don't think that it makes sense to change the slice
size for qemu-img map, or in general for anything that does pure
sequential I/O.

But it's probably worth mentioning in the commit message.

Berto
