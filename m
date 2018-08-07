Received: from eggs.gnu.org ([2001:4830:134:3::10]:46798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn30w-0001Pp-Oe
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn30v-0007dA-SX
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:31:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180628000745.4477-4-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-4-mreitz@redhat.com>
Date: Tue, 07 Aug 2018 16:31:02 +0200
Message-ID: <w51zhxy8d09.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 03/31] block: Skip implicit
 nodes for filename info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Thu 28 Jun 2018 02:07:17 AM CEST, Max Reitz wrote:
> bdrv_refresh_filename() should simply skip all implicit nodes.  They are
> supposed to be invisible to the user, so they should not appear in
> filename information.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
