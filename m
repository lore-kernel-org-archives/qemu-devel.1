Received: from eggs.gnu.org ([2001:4830:134:3::10]:42463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmJFl-0005DG-E5
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmJFh-0007Q5-6D
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:34:53 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170825132332.6734-5-el13635@mail.ntua.gr>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-5-el13635@mail.ntua.gr>
Date: Mon, 28 Aug 2017 14:00:41 +0200
Message-ID: <w51lgm3vr4m.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 25 Aug 2017 03:23:29 PM CEST, Manos Pitsidianakis wrote:
> This commit removes all I/O throttling from block/block-backend.c. In
> order to support the existing interface, it is changed to use the
> block/throttle.c filter driver.
>
> The throttle filter node that is created by the legacy interface is
> stored in a 'throttle_node' field in the BlockBackendPublic of the
> device. The legacy throttle node is managed by the legacy interface
> completely. More advanced configurations with the filter drive are
> possible using the QMP API, but these will be ignored by the legacy
> interface.
>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
