Received: from eggs.gnu.org ([2001:4830:134:3::10]:51771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePnqe-00050G-Lt
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePnqZ-0006Fj-35
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:08:12 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171215105905.21338-1-kwolf@redhat.com>
References: <20171215105905.21338-1-kwolf@redhat.com>
Date: Fri, 15 Dec 2017 12:07:22 +0100
Message-ID: <w51fu8c9rmd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Document that
 x-blockdev-change breaks quorum children list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On Fri 15 Dec 2017 11:59:05 AM CET, Kevin Wolf wrote:
> Removing a quorum child node with x-blockdev-change results in a quorum
> driver state that cannot be recreated with create options because it
> would require a list with gaps. This causes trouble in at least
> .bdrv_refresh_filename().
>
> Document this problem so that we won't accidentally mark the command
> stable without having addressed it.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
