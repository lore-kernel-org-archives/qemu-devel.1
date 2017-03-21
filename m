Received: from eggs.gnu.org ([2001:4830:134:3::10]:60689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cqCzn-000206-SG
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 02:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cqCzi-0005gH-UZ
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 02:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cqCzi-0005fe-Nt
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 02:10:10 -0400
References: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<22303218-697c-7166-406b-050888efdfd5@redhat.com>
	<cc051a40-9142-9364-8bc8-de8ec453ebe2@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8901e058-dcda-5c4a-e43a-38fca5814eb5@redhat.com>
Date: Tue, 21 Mar 2017 14:10:04 +0800
MIME-Version: 1.0
In-Reply-To: <cc051a40-9142-9364-8bc8-de8ec453ebe2@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B403=E6=9C=8821=E6=97=A5 13:47, Zhang Chen wrote:
>
>
> On 03/21/2017 11:39 AM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B403=E6=9C=8816=E6=97=A5 17:52, Zhang Chen wrote:
>>> If user use -device virtio-net-pci, virtio-net driver will add a head=
er
>>> to raw net packet that colo-proxy can't handle it. COLO-proxy just
>>> focus on the packet payload, so we skip the virtio-net header to=20
>>> compare
>>> the sent packet that primary guest's to secondary guest's.
>>>
>>>
>>> Zhang Chen (3):
>>>    COLO-proxy: Add virtio-net packet parse function
>>>    COLO-proxy: Add a tag to mark virtio-net packet
>>>    COLO-compare: Add virtio-net packet compare support
>>>
>>>   net/colo-compare.c    | 42 +++++++++++++++++++++++++++++++++-------=
--
>>>   net/colo.c            | 14 ++++++++++----
>>>   net/colo.h            |  7 ++++++-
>>>   net/filter-rewriter.c | 15 ++++++++++-----
>>>   4 files changed, 59 insertions(+), 19 deletions(-)
>>>
>>
>> Hi:
>>
>> Git grep told us virtio-net is not the only user for vnet header.=20
>> E1000e and vmxnet3 uses it too.
>>
>> So we need solve them all instead of being virtio-net specific.
>>
>
> Yes, In this series I just try to parse vnet header, if failed I will=20
> try to parse normal net packet.
> So, I just focus on vnet header rather than virtio-net driver.
> But the patch comments really make people confused , Should I fix all=20
> the comments send the V2 ?

Yes, please. Beside this, instead of using fixed vnet header len macro,=20
you should query the backend for the length of vnet header.

Thanks

>
> Thanks
> Zhang Chen
>
>> Thanks
>>
>>
>>
>
