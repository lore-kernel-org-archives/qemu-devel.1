Received: from eggs.gnu.org ([2001:4830:134:3::10]:39414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddBAs-0000b1-FB
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 04:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddBAr-0001Ji-Hx
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 04:08:06 -0400
Date: Thu, 3 Aug 2017 10:07:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170803080750.GB4456@dhcp-200-186.str.redhat.com>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-8-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170731095443.28211-8-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 7/7] block: add throttle block filter
 driver interface tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

Am 31.07.2017 um 11:54 hat Manos Pitsidianakis geschrieben:
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

I would add at least two more cases:

* Both limits and throttle-group are given in blockdev-add
* limits and throttle-group are both missing

It would also be nice to test that query-block reflects the new throttle
group limits correctly when they are changed after the fact.

Kevin
