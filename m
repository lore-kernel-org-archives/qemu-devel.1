Received: from eggs.gnu.org ([2001:4830:134:3::10]:47321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1did6t-0004k1-Nd
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1did6q-00028A-Mr
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:58:31 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170818031019.3723-6-el13635@mail.ntua.gr>
References: <20170818031019.3723-1-el13635@mail.ntua.gr>
	<20170818031019.3723-6-el13635@mail.ntua.gr>
Date: Fri, 18 Aug 2017 10:23:09 +0200
Message-ID: <w51wp615loy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 5/6] block: add throttle block filter
 driver
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

On Fri 18 Aug 2017 05:10:18 AM CEST, Manos Pitsidianakis wrote:
> block/throttle.c uses existing I/O throttle infrastructure inside a
> block filter driver. I/O operations are intercepted in the filter's
> read/write coroutines, and referred to block/throttle-groups.c
>
> The driver can be used with the syntax
> -drive driver=throttle,file.filename=foo.qcow2, \
>         limits.iops-total=...,throttle-group=bar

I had understood that we would get rid of the limits.* options in this
driver, or did I get it wrong?

Other than that, the rest of the code looks perfect to me.

Berto
