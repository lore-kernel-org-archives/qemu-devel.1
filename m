Received: from eggs.gnu.org ([2001:4830:134:3::10]:44896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eYYfl-000823-IY
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eYYfh-0002wX-Pr
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:45:09 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171221142251.18366-7-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
	<20171221142251.18366-7-kwolf@redhat.com>
Date: Mon, 08 Jan 2018 15:44:23 +0100
Message-ID: <w51tvvw8l6g.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 06/19] blockjob: Pause job
 on draining any job BDS
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

On Thu 21 Dec 2017 03:22:38 PM CET, Kevin Wolf wrote:
> Block jobs already paused themselves when their main BlockBackend
> entered a drained section. This is not good enough: We also want to
> pause a block job and may not submit new requests if, for example, the
> mirror target node should be drained.
>
> This implements .drained_begin/end callbacks in child_job in order to
> consider all block nodes related to the job, and removes the
> BlockBackend callbacks which are unnecessary now because the root of the
> job main BlockBackend is always referenced with a child_job, too.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
