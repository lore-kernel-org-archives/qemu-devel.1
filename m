Received: from eggs.gnu.org ([2001:4830:134:3::10]:51627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdUPU-0005zj-D0
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdUPQ-0004bR-DY
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:08:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cdUPQ-0004bF-7g
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:08:08 -0500
References: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485266748-15340-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<4d0b52bc-bcdd-5b96-465c-f0e624cb4add@redhat.com>
	<58983015.40300@huawei.com>
	<0b5891cc-0170-0773-a4b2-31cf3ff2b6d7@redhat.com>
	<589859CA.5030903@huawei.com>
	<3c6e13ab-4f5a-fbe3-ef95-196c6b3e59c9@redhat.com>
	<58997D40.60604@huawei.com>
	<e8c2510f-f755-3ec1-f085-e3053480b772@redhat.com>
	<5899831D.30005@huawei.com>
	<2e301620-0362-f43e-9194-e438f2091546@redhat.com>
	<58A26C35.9070309@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3b158bac-a92d-be3d-88a9-8c23a0d065dd@redhat.com>
Date: Tue, 14 Feb 2017 12:08:01 +0800
MIME-Version: 1.0
In-Reply-To: <58A26C35.9070309@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] colo-compare: reconstruct the mutex
 lock usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, lizhijian@cn.fujitsu.com



On 2017=E5=B9=B402=E6=9C=8814=E6=97=A5 10:32, Hailiang Zhang wrote:
>>>
>>
>
> Hi Jason,
>
>> I think the better way is notify the comparing thread and let it do th=
e
>> releasing. You probably need similar mechanism to notify from comparin=
g
>> thread to checkpoint thread.
>>
>
> It seems that there is no available APIs in glib to notify a thread whi=
ch
> are run coroutine to do something (idle source ?). What about using=20
> anonymous pipe
> as the GPollFD to communicate between colo comparing thread and colo=20
> thread ?
>
> Any ideas ?
>
> Hailiang

Haven't thought this deeply. But I think you can try event notifier=20
first which was designed for such kind of notification.

Thanks
