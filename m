Received: from eggs.gnu.org ([2001:4830:134:3::10]:57107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpJBL-0007EO-Vj
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpJBH-0002hc-A8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:06:43 -0400
Date: Tue, 5 Sep 2017 21:06:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905190621.GQ4633@localhost.localdomain>
References: <20170825132028.6184-1-el13635@mail.ntua.gr>
	<20170825132028.6184-7-el13635@mail.ntua.gr>
	<20170905161643.GO4633@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170905161643.GO4633@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 6/6] qemu-iotests: add 184
 for throttle filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>

Am 05.09.2017 um 18:16 hat Kevin Wolf geschrieben:
> Am 25.08.2017 um 15:20 hat Manos Pitsidianakis geschrieben:
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> 
> Does this test actually (still) pass for you? I can't see that it's
> related to any recent change in master, but this is the diff that I get.
> 
> I can update the reference output while applying, but obviously if it's
> currently passing for you, it will fail after I "fix" it.

For the record, we discussed this on IRC. The test works correctly on
master, but on my block branch there is a conflict with "block: pass
bdrv_* methods to bs->file by default in block filters".

The correct action is to merge this throttle driver series after the
conflicting patch because throttle doesn't implement .bdrv_get_info and
needs the forwarding that the other patch implements.

I updated the test output accordingly and applied the series to my block
branch.

Kevin
