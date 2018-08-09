Received: from eggs.gnu.org ([2001:4830:134:3::10]:37308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fngiy-00010V-ML
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 04:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fngiu-0000Jf-RN
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 04:55:16 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180808221138.5770-4-lbloch@janustech.com>
References: <20180808221138.5770-1-lbloch@janustech.com>
	<20180808221138.5770-4-lbloch@janustech.com>
Date: Thu, 09 Aug 2018 10:55:07 +0200
Message-ID: <w5136vndims.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/5] qcow2: Resize the cache upon image
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 12:11:36 AM CEST, Leonid Bloch wrote:
> The caches are now recalculated upon image resizing. This is done
> because the new default behavior of assigning L2 cache relatively to
> the image size, implies that the cache will be adapted accordingly
> after an image resize.
>
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
