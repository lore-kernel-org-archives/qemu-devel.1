Received: from eggs.gnu.org ([2001:4830:134:3::10]:43998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMwDD-0008Tw-1y
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMwDC-0008Gb-AS
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:55:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dMwDC-0008GF-4G
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:55:22 -0400
Date: Mon, 19 Jun 2017 14:55:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170619125517.GE6113@noname.redhat.com>
References: <20170615163813.7255-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615163813.7255-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] qemu-iotests: test savevm/loadvm
 iothread (and make it work!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>

Am 15.06.2017 um 18:38 hat Stefan Hajnoczi geschrieben:
> This series extends qemu-iotests 068 to also run with iothread enabled.  Doing
> so was harder than expected because:
> 
> 1. ioeventfd is disabled without -M accel=kvm even though it should work
> 2. loadvm still has an iothread bug
> 
> Instead of adding a ./check -iothread option I decided to always run the test.
> Kevin recently recommended this approach; the advantage is that iothread *will*
> always be tested iothread mode whereas people won't run ./check -iothread.

Thanks, fixed the intermediate state after patch 3 (without changing the
final state after applying all patches) and applied to the block branch.

Kevin
