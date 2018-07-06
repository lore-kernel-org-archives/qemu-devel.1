Received: from eggs.gnu.org ([2001:4830:134:3::10]:46971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fbL0M-0004qB-KJ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fbL0L-0004no-MZ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:18:10 -0400
Date: Fri, 6 Jul 2018 15:17:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180706071754.GB9946@lemon.usersys.redhat.com>
References: <20180705074638.770905-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705074638.770905-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] fix image fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org

On Thu, 07/05 10:46, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
> 
> This fixes image fleecing scheme for 3.0, details are in 04 patch.

Looks like this breaks 'test-replication':

http://patchew.org/QEMU/20180705074638.770905-1-vsementsov@virtuozzo.com/

test-replication: /stor/work/qemu/block/io.c:725: wait_serialising_requests: Assertion `qemu_coroutine_self() != req->co' failed.
GTester: last random seed: R02Se49967625f19c5be9918a2503fb2fff5
test-replication: /stor/work/qemu/block/io.c:725: wait_serialising_requests: Assertion `qemu_coroutine_self() != req->co' failed.
  GTESTER tests/test-qht-par
GTester: last random seed: R02S8fad2bb2daddc51eb51623bb7c86cb67
test-replication: /stor/work/qemu/block/io.c:725: wait_serialising_requests: Assertion `qemu_coroutine_self() != req->co' failed.
GTester: last random seed: R02S024718e9b1e2b1facafe254c43e1430b

Fam
