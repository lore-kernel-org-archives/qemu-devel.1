Received: from eggs.gnu.org ([2001:4830:134:3::10]:51745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dhciX-0006wL-9N
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dhciU-0007TA-44
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:21:13 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170809140256.25584-3-el13635@mail.ntua.gr>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
	<20170809140256.25584-3-el13635@mail.ntua.gr>
Date: Tue, 15 Aug 2017 16:21:07 +0200
Message-ID: <w51d17wzzcc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/6] block: add options parameter to
 bdrv_new_open_driver()
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

On Wed 09 Aug 2017 04:02:52 PM CEST, Manos Pitsidianakis wrote:
> Allow passing a QDict *options parameter to bdrv_new_open_driver() so
> that it can be used if a driver needs it upon creation. The previous
> behaviour (empty bs->options and bs->explicit_options) remains when
> options is NULL.
>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
