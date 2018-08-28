Received: from eggs.gnu.org ([2001:4830:134:3::10]:41991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fueOn-00011Z-St
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fueOn-0007mL-6f
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:51:13 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-27-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-27-mreitz@redhat.com>
Date: Tue, 28 Aug 2018 15:50:59 +0200
Message-ID: <w51y3cqr458.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 26/31] block/nvme: Fix
 bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 11:35:23 PM CEST, Max Reitz wrote:
> Currently, nvme's bdrv_refresh_filename() is an exact copy of null's
> implementation.  However, for null, "null-co://" and "null-aio://" are
> indeed valid filenames -- for nvme, they are not, as a device address is
> still required.
>
> The correct implementation should generate a filename of the form
> "nvme://[PCI address]/[namespace]" (as the comment above
> nvme_parse_filename() describes).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
