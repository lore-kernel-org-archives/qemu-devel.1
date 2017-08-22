Received: from eggs.gnu.org ([2001:4830:134:3::10]:37828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk88Q-0002uo-3P
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk88L-0003ee-PZ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:18:18 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170809140256.25584-7-el13635@mail.ntua.gr>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
	<20170809140256.25584-7-el13635@mail.ntua.gr>
Date: Tue, 22 Aug 2017 14:17:34 +0200
Message-ID: <w51378jhk4h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 6/6] block: remove BlockBackendPublic
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

On Wed 09 Aug 2017 04:02:56 PM CEST, Manos Pitsidianakis wrote:
> All BlockBackend level throttling (via the implicit throttle filter node) is
> done in block/block-backend.c and block/throttle-groups.c doesn't know
> about BlockBackends anymore. Since BlockBackendPublic is not needed anymore, remove it.
>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
