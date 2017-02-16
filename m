Received: from eggs.gnu.org ([2001:4830:134:3::10]:34412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ceSrW-0006d5-KL
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 15:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ceSrV-0005Q1-PQ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 15:41:10 -0500
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-10-git-send-email-vsementsov@virtuozzo.com>
	<20170216114533.GC4869@noname.redhat.com>
	<20170216124753.GE4869@noname.redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3d1d8c91-17b9-329f-4649-c6127e0e982e@redhat.com>
Date: Thu, 16 Feb 2017 15:40:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170216124753.GE4869@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v15 09/25] qcow2: add
 .bdrv_load_autoloading_dirty_bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, mreitz@redhat.com



On 02/16/2017 07:47 AM, Kevin Wolf wrote:
> Can we make the whole thing a little less confusing by entirely removing
> sectors from the block dirty bitmap interfaces? I find it challenging
> enough to deal with just bytes, qcow2 clusters and bitmap clusters.

I'll take a look to see how easy that is to do. For now, it's the
dominant paradigm.

--js
