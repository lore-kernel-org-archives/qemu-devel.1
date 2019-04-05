Received: from eggs.gnu.org ([209.51.188.92]:40258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hCJU9-0001C3-97
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hCJU8-0002cb-Et
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:42:01 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190404150746.12585-1-kwolf@redhat.com>
References: <20190404150746.12585-1-kwolf@redhat.com>
Date: Fri, 05 Apr 2019 09:36:36 +0200
Message-ID: <w51ftqwq4xn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-4.0] block: Forward
 'discard' to temporary overlay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

On Thu 04 Apr 2019 05:07:46 PM CEST, Kevin Wolf wrote:
> When bdrv_temp_snapshot_options() is called for snapshot=on, the
> 'discard' option in the options QDict hasn't been parsed and merged into
> the flags yet. So copy the dict entry to make sure that the temporary
> overlay enables discard when it was requested for the drive.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
