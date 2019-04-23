Received: from eggs.gnu.org ([209.51.188.92]:57801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hIrWG-0001Fl-38
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hIrWF-0002i5-1p
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:15:15 -0400
Date: Tue, 23 Apr 2019 11:15:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190423091505.GE9041@localhost.localdomain>
References: <20190422152315.74361-1-vsementsov@virtuozzo.com>
	<20190422152315.74361-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422152315.74361-4-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] iotests: test big qcow2 shrink
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, den@virtuozzo.com, eblake@redhat.com

Am 22.04.2019 um 17:23 hat Vladimir Sementsov-Ogievskiy geschrieben:
> This test checks bug in qcow2_process_discards, fixed by previous
> commit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Tested-by: Eric Blake <eblake@redhat.com>

Doesn't work for me (the exact value probably depends on the file
system, I'm testing on XFS):

--- /home/kwolf/source/qemu/tests/qemu-iotests/250.out  2019-04-23 10:41:27.972959135 +0200
+++ /home/kwolf/source/qemu/tests/qemu-iotests/250.out.bad      2019-04-23 11:09:48.035092870 +0200
@@ -12,10 +12,10 @@
 0               0xa00000        0x82f00000      TEST_DIR/t.qcow2
 0x82a00000      0xa00000        0x500000        TEST_DIR/t.qcow2
 virtual size: 2.05 GiB (2202009600 bytes)
-disk size: 24 MiB
+disk size: 25 MiB
 cluster_size: 1048576
 Image resized.
 virtual size: 5 MiB (5242880 bytes)
-disk size: 9 MiB
+disk size: 10 MiB
 cluster_size: 1048576
 *** done

Maybe the output of 'qemu-img map -f raw' would be more reliable?

Kevin
