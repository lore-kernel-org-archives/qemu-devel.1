Received: from eggs.gnu.org ([2001:4830:134:3::10]:53511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gShmA-0003A1-HZ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gShm6-0003KD-O0
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:20:05 -0500
Date: Fri, 30 Nov 2018 13:19:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181130121947.GD5106@localhost.localdomain>
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129101801.6421-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, jcody@redhat.com, pbonzini@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org, qemu-stable@nongnu.org

Am 29.11.2018 um 11:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
> This test is broken without previous commit fixing dead-lock in mirror.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--- /home/kwolf/source/qemu/tests/qemu-iotests/235.out  2018-11-30 12:57:11.275937057 +0100
+++ /home/kwolf/source/qemu/tests/qemu-iotests/235.out.bad      2018-11-30 13:17:33.890988974 +0100
@@ -1 +1 @@
-{u'return': {}}
+{'return': {}}
Failures: 235
Failed 1 of 1 tests


I think this is because you use print() (which produces output that is
inconsistent between Python 2 and 3) instead of iotests.log().

Kevin
