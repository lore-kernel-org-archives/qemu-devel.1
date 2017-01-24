Received: from eggs.gnu.org ([2001:4830:134:3::10]:36603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cW28x-0003g0-Ne
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cW28u-0004VQ-K2
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:32:19 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170124095350.16679-1-stefanha@redhat.com>
References: <20170124095350.16679-1-stefanha@redhat.com>
Date: Tue, 24 Jan 2017 15:31:38 +0100
Message-ID: <w51wpdk8r79.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] aio-posix: honor is_external in AioContext
 polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>

On Tue 24 Jan 2017 10:53:50 AM CET, Stefan Hajnoczi wrote:
> AioHandlers marked ->is_external must be skipped when aio_node_check()
> fails.  bdrv_drained_begin() needs this to prevent dataplane from
> submitting new I/O requests while another thread accesses the device and
> relies on it being quiesced.
>
> Thanks to Fam Zheng <famz@redhat.com> for identifying the root cause of
> this crash.
>
> Reported-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Tested-by: Alberto Garcia <berto@igalia.com>

Berto
