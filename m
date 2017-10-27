Received: from eggs.gnu.org ([2001:4830:134:3::10]:50790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7ys4-0000N5-Ig
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7ys0-0005Wo-M7
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:16:00 -0400
Date: Fri, 27 Oct 2017 09:15:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171027071544.GA3368@localhost.localdomain>
References: <1508914283-2531-1-git-send-email-wang.guang55@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508914283-2531-1-git-send-email-wang.guang55@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH] replication: Fix replication open fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang Guang <wang.guang55@zte.com.cn>
Cc: wencongyang2@huawei.com, xiechanglong.d@gmail.com, mreitz@redhat.com, zhang.zhanghailiang@huawei.com, zhangckid@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Wang Yong <wang.yong155@zte.com.cn>

Am 25.10.2017 um 08:51 hat Wang Guang geschrieben:
> replication_child_perm request write
> permissions for all child which will lead bdrv_check_perm fail.
> replication_child_perm() should request write
> permissions only if it is writable itself.
> 
> Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>
> Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>

Thanks, applied to the block branch.

Kevin
