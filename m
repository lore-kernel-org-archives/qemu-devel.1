Received: from eggs.gnu.org ([2001:4830:134:3::10]:58517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dddKe-0005Z4-U7
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ddbVK-0002tZ-K0
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:16:43 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170731095443.28211-3-el13635@mail.ntua.gr>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-3-el13635@mail.ntua.gr>
Date: Fri, 04 Aug 2017 14:14:54 +0200
Message-ID: <w51o9rvv8ap.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/7] block: add aio_context field in
 ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Mon 31 Jul 2017 11:54:38 AM CEST, Manos Pitsidianakis wrote:
> timer_cb() needs to know about the current Aio context of the throttle
> request that is woken up. In order to make ThrottleGroupMember backend
> agnostic, this information is stored in an aio_context field instead of
> accessing it from BlockBackend.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
