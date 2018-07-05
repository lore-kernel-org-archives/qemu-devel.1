Received: from eggs.gnu.org ([2001:4830:134:3::10]:52878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb6e1-00046S-5f
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb6e0-0004v9-Ez
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:58:09 -0400
Date: Thu, 5 Jul 2018 17:57:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705155755.GN3309@localhost.localdomain>
References: <20180705073701.10558-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705073701.10558-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] block: Fix dst reading after tail
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 05.07.2018 um 09:36 hat Fam Zheng geschrieben:
> Qcow2 allocates new clusters after the end of the file. If it is the destinaton
> of copy offloading, we must adjust dst->bs->total_sectors. Otherwise, further
> reads will drop to the "beyond EOF" code path and return zeroes, which problem
> is caught by iotests 222.
> 
> Follow the logic in the normal write code and update bs->total_sectors after
> I/O is done.
> 
> While at it, add a few convenient trace points to aid future debug experiences
> in the topic.

Apart from the comments I made, this series also conflicts with
Vladimir's "[PATCH v3 0/4] fix image fleecing". Can you please rebase on
top of his series for the next version?

Kevin
