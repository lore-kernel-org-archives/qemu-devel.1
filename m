Received: from eggs.gnu.org ([2001:4830:134:3::10]:35067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d0I4y-0007gX-Sa
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d0I4u-0005OJ-Kg
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:37:16 -0400
References: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
	<1489756546-27142-3-git-send-email-kwolf@redhat.com>
	<ac3e7855-9dfb-5bc7-daee-6d062173f6cb@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58F56D90.50509@huawei.com>
Date: Tue, 18 Apr 2017 09:36:16 +0800
MIME-Version: 1.0
In-Reply-To: <ac3e7855-9dfb-5bc7-daee-6d062173f6cb@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/8] replication: clarify permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: xuquan8@huawei.com, Wen Congyang <wencongyang@gmail.com>, Wen Congyang <wencongyang2@huawei.com>, qemu-devel@nongnu.org, xiecl.fnst@cn.fujitsu.com

On 2017/4/18 9:23, Eric Blake wrote:
> On 03/17/2017 08:15 AM, Kevin Wolf wrote:
>> From: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
>>
>> Even if hidden_disk, secondary_disk are backing files, they all need
>> write permissions in replication scenario. Otherwise we will encouter
>> below exceptions on secondary side during adding nbd server:
>>
>> {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk', 'writable': true } }
>> {"error": {"class": "GenericError", "desc": "Conflicts with use by hidden-qcow2-driver as 'backing', which does not allow 'write' on sec-qcow2-driver-for-nbd"}}
>>
>> CC: Zhang Hailiang <zhang.zhanghailiang@huawei.com>
>> CC: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> CC: Wen Congyang <wencongyang2@huawei.com>
> This address for Wen Congyang is different than the one listed in
> MAINTAINERS for replication (M: Wen Congyang <wency@cn.fujitsu.com>),
> and different still from addresses my mailer has harvested from other
> posts (wencongyang@gmail.com).  The MAINTAINERS entry is now resulting
> in 'undelivered mail' bounce messages, can you please submit an update
> to MAINTAINERS with your new preferred address? [or gently correct me if
> I'm confusing two people with the same name?]
>

No, the same people, he just left his job from fujitsu, the entry in MAINTAINERS
file needs to be updated.

Cc: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
Hi Changlong, would you please send a patch to update it ?

Hailiang
