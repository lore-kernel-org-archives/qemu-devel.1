Received: from eggs.gnu.org ([2001:4830:134:3::10]:58190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eYZ9n-0001tf-B3
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eYZ9l-0005YM-1k
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:16:11 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171221142251.18366-9-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
	<20171221142251.18366-9-kwolf@redhat.com>
Date: Mon, 08 Jan 2018 16:15:58 +0100
Message-ID: <w51r2r08jpt.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 08/19] block: Don't
 block_job_pause_all() in bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Thu 21 Dec 2017 03:22:40 PM CET, Kevin Wolf wrote:
> Block jobs are already paused using the BdrvChildRole drain callbacks,
> so we don't need an additionall block_job_pause_all() call.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
