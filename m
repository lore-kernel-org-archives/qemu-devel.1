Received: from eggs.gnu.org ([2001:4830:134:3::10]:37499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnlOM-0000TX-Hr
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnlOL-0003aF-J4
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:17:30 -0400
Date: Tue, 14 Mar 2017 13:17:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170314121720.GG3952@noname.str.redhat.com>
References: <1489492012-8002-1-git-send-email-xiecl.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489492012-8002-1-git-send-email-xiecl.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH V1] replication: clarify permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Am 14.03.2017 um 12:46 hat Changlong Xie geschrieben:
> Even if hidden_disk, secondary_disk are backing files, they all need
> write permissions in replication scenario. Otherwise we will encouter
> below exceptions on secondary side during adding nbd server:
> 
> {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk', 'writable': true } }
> {"error": {"class": "GenericError", "desc": "Conflicts with use by hidden-qcow2-driver as 'backing', which does not allow 'write' on sec-qcow2-driver-for-nbd"}}
> 
> CC: Zhang Hailiang <zhang.zhanghailiang@huawei.com>
> CC: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> CC: Wen Congyang <wencongyang2@huawei.com>
> Signed-off-by: Changlong Xie <xiecl.fnst@cn.fujitsu.com>

Thanks, applied to the block branch.

Kevin
