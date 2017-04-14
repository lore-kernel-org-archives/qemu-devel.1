Received: from eggs.gnu.org ([2001:4830:134:3::10]:56578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cyuEQ-00056X-Q1
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cyuEL-00014v-Kb
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:57:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cyuEL-000123-Er
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:57:13 -0400
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<134776c2-a85d-d06f-5f98-2e664f9c8ca9@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d33b0150-5ed2-56cc-9261-da7deb1d0bfb@redhat.com>
Date: Fri, 14 Apr 2017 13:57:04 +0800
MIME-Version: 1.0
In-Reply-To: <134776c2-a85d-d06f-5f98-2e664f9c8ca9@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/15] colo-compare: implement the process
 of checkpoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com



On 2017=E5=B9=B402=E6=9C=8822=E6=97=A5 17:31, Zhang Chen wrote:
>
>
> On 02/22/2017 11:42 AM, zhanghailiang wrote:
>> While do checkpoint, we need to flush all the unhandled packets,
>> By using the filter notifier mechanism, we can easily to notify
>> every compare object to do this process, which runs inside
>> of compare threads as a coroutine.
>
> Hi~ Jason and Hailiang.
>
> I will send a patch set later about colo-compare notify mechanism for=20
> Xen like this patch.
> I want to add a new chardev socket way in colo-comapre connect to Xen=20
> colo, for notify
> checkpoint or failover, Because We have no choice to use this way=20
> communicate with Xen codes.
> That's means we will have two notify mechanism.
> What do you think about this?
>
>
> Thanks
> Zhang Chen=20

I was thinking the possibility of using similar way to for colo compare.=20
E.g can we use socket? This can saves duplicated codes more or less.

Thanks
