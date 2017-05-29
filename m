Received: from eggs.gnu.org ([2001:4830:134:3::10]:37933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dFLbB-0008Uu-SN
	for qemu-devel@nongnu.org; Mon, 29 May 2017 10:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dFLb6-0003sG-T2
	for qemu-devel@nongnu.org; Mon, 29 May 2017 10:24:45 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170525163225.29954-10-pbonzini@redhat.com>
References: <20170525163225.29954-1-pbonzini@redhat.com>
	<20170525163225.29954-10-pbonzini@redhat.com>
Date: Mon, 29 May 2017 16:24:37 +0200
Message-ID: <w51a85v4u6y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/18] throttle-groups:
 protect throttled requests with a CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

On Thu 25 May 2017 06:32:16 PM CEST, Paolo Bonzini wrote:
> Another possibility is to use tg->lock, which we're holding anyway in
> both schedule_next_request and throttle_group_co_io_limits_intercept.
> This would require open-coding the CoQueue however, so I've chosen this
> alternative.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
