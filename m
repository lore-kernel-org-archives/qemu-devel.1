Received: from eggs.gnu.org ([2001:4830:134:3::10]:46467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEFPy-0003HM-E0
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEFPt-0006az-D7
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:08:54 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <d725567e-787d-bdea-36aa-d20877d8d288@redhat.com>
References: <cover.1510339534.git.berto@igalia.com>
	<071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com>
	<d725567e-787d-bdea-36aa-d20877d8d288@redhat.com>
Date: Mon, 13 Nov 2017 15:08:45 +0100
Message-ID: <w51fu9i9spe.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test I/O limits with
 removable media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, sochin jiang <sochin.jiang@huawei.com>

On Fri 10 Nov 2017 11:21:27 PM CET, Max Reitz wrote:

> By the way, I just noticed that this test tests that
> x-blockdev-remove-medium and x-blockdev-insert-medium do not destroy
> throttling information -- which is exactly why those commands had been
> declared experimental in the first place.

Oh, was that the reason?

> So I guess this means we can drop the x- now. :-)

Sure.

Berto
