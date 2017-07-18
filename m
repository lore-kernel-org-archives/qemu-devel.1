Received: from eggs.gnu.org ([2001:4830:134:3::10]:40517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dXMPx-0007zv-PR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dXMPx-0008Ug-3F
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:55:37 -0400
Date: Tue, 18 Jul 2017 12:25:25 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20170717160503.GL5301@noname.redhat.com>
Message-ID: <alpine.LFD.2.20.1707181221260.2603@wniryva>
References: <20170717130130.29211-1-ppandit@redhat.com>
	<20170717160503.GL5301@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v1] ide: check BlockBackend
 object in ide_cancel_dma_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Chensongnian <chensongnian@huawei.com>

  Hello Kevin,

+-- On Mon, 17 Jul 2017, Kevin Wolf wrote --+
| I think Stefan didn't only mean a stack trace, but an actual instruction
| how to reproduce this. VM configuration, what actions to take, etc.
| 
| In fact, I will add that we will probably want a qtest case as a
| regression test anyway, and tests are always great for describing how to
| reproduce a problem, too.

It was found via a fuzzing exercise; I've requested a reproducer from original 
reporter, will try to create a qtest once it's available.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
