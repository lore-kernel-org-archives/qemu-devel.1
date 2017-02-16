Received: from eggs.gnu.org ([2001:4830:134:3::10]:37982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceEJH-0000Ht-Po
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceEJD-0007pG-7d
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:08:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ceEJD-0007oo-1N
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:08:47 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<9358a09d-d65f-2b44-9bce-7027b133f1f8@redhat.com>
	<alpine.DEB.2.10.1702131228110.6418@sstabellini-ThinkPad-X260>
	<b1cc9438-3f49-dbf9-8334-1dbdb4aa9704@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3c0c0156-b984-859f-c51f-d76599a976bb@redhat.com>
Date: Thu, 16 Feb 2017 13:08:39 +0800
MIME-Version: 1.0
In-Reply-To: <b1cc9438-3f49-dbf9-8334-1dbdb4aa9704@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Eric Blake <eblake@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu devel <qemu-devel@nongnu.org>, Wen Congyang <wencongyang@gmail.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 11:25, Zhang Chen wrote:
> Ping...
>
> No new for a long time.
>
> Who can pick up this patch?
>

I believe you'd better cc migration maintainers (cced), have you tried=20
scripts/get_maintainer ?

Thanks

>
> Thanks
>
> Zhang Chen
>
>
> On 02/14/2017 04:28 AM, Stefano Stabellini wrote:
>> On Wed, 8 Feb 2017, Eric Blake wrote:
>>> On 02/07/2017 11:24 PM, Zhang Chen wrote:
>>>> We can call this qmp command to do checkpoint outside of qemu.
>>>> Xen colo will need this function.
>>>>
>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>>>> ---
>>>>   migration/colo.c | 17 ++++++++++++++++
>>>>   qapi-schema.json | 60=20
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   2 files changed, 77 insertions(+)
>>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Given that the series is all acked, are you going to take care of the
>> pull request?
>>
>>
>> .
>>
>
