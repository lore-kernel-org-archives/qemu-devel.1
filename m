Received: from eggs.gnu.org ([2001:4830:134:3::10]:54361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnJT4-0007BK-ED
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnJT2-0001kU-Hw
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:28:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnJT2-0001kP-BV
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:28:28 -0400
References: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<ca75b31f-1337-6fef-c799-6902f79798a5@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8959bc26-bf4d-1ecb-a606-b602f6699a9f@redhat.com>
Date: Mon, 13 Mar 2017 14:28:21 +0800
MIME-Version: 1.0
In-Reply-To: <ca75b31f-1337-6fef-c799-6902f79798a5@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] COLO-compare: Make COLO-compare
 support Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Stefano Stabellini <sstabellini@kernel.org>



On 2017=E5=B9=B403=E6=9C=8813=E6=97=A5 14:18, Zhang Chen wrote:
> Hi~~~ All~
>
> No news for a long time, anyone can give me some comments?

Hi,

A question is why use two kinds of colo-frames? This seems not good as=20
lots of the code were duplicated.

Thanks

>
>
> Thanks
>
> Zhang Chen
>
>
> On 02/28/2017 06:48 PM, Zhang Chen wrote:
>> This series focus on COLO Xen support.
>> We add a new chardev socket in colo-compare as the way
>> of communicate with Xen COLO-frame.
>> Xen part:
>> https://lists.xenproject.org/archives/html/xen-devel/2017-02/msg02067.=
html=20
>>
>>
>> This series is a frame, have some TODO job depend on this patch:
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05055.html
>>
>>
>> Zhang Chen (3):
>>    COLO-compare: Add new parameter for communicate with Xen colo-frame
>>    COLO-compare: Add Xen notify chardev socket handler frame
>>    COLO-compare: Add colo-compare Xen notify
>>
>>   net/colo-compare.c | 77=20
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   qemu-options.hx    | 38 ++++++++++++++++++++++++---
>>   2 files changed, 111 insertions(+), 4 deletions(-)
>>
>
