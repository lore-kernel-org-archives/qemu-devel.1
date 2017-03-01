Received: from eggs.gnu.org ([2001:4830:134:3::10]:33170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciue2-00022n-N4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciue1-0003Yq-TA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:09:38 -0500
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484884080-28836-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170227164600.GH10201@stefanha-x1.localdomain>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58B63B57.5090804@huawei.com>
Date: Wed, 1 Mar 2017 11:09:11 +0800
MIME-Version: 1.0
In-Reply-To: <20170227164600.GH10201@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/6] docs/block-replication: Add
 description for shared-disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, Wen Congyang <wency@cn.fujitsu.com>

On 2017/2/28 0:46, Stefan Hajnoczi wrote:
> On Fri, Jan 20, 2017 at 11:47:55AM +0800, zhanghailiang wrote:
>> +Secondary:
>> + -drive if=none,driver=qcow2,file.filename=/mnt/ramfs/hidden_disk.img,id=hidden_disk0,\
>> +        backing.driver=raw,backing.file.filename=1.raw \
>> + -drive if=virtio,id=active-disk0,driver=replication,mode=secondary,\
>> +        file.driver=qcow2,top-id=active-disk0,\
>> +        file.file.filename=/mnt/ramfs/active_disk.img,\
>> +        file.backing=hidden_disk0,shared-disk=on
>
> I don't see where this patch series adds a -drive shared-disk=on option.
> Did I miss it?
>

In patch 2, we add this option.

Thanks.
