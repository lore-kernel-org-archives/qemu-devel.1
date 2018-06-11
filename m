Received: from eggs.gnu.org ([2001:4830:134:3::10]:54495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSM3k-000899-MB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSM3h-0003oi-JP
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:36:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fSM3h-0003oE-EV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:36:29 -0400
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
	<77604174-3c15-a8d3-3ea3-53a1759cd885@redhat.com>
	<e2e0ff2b-139e-0582-c8f9-9a716780ff1f@redhat.com>
	<56943de0-74f6-0746-c2c2-eeb9fdeabd74@redhat.com>
	<4409ea2d-971d-8898-bd1a-9e9b9e9172dc@redhat.com>
	<ced449d6-1778-6641-d055-4fedda442a47@redhat.com>
	<AE460DFB-87F8-45A3-A007-E59C3B23BB67@zju.edu.cn>
	<679ab02f-b110-c80a-c99e-1301b7fa1725@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB015FC4@dggeml511-mbx.china.huawei.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <97a9b33e-7dc1-e2cb-ce7d-ea0adb1a4dbe@redhat.com>
Date: Mon, 11 Jun 2018 14:36:24 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB015FC4@dggeml511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] An emulation failure occurs,
 if I hotplug vcpus immediately after the VM start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, =?UTF-8?B?5rWZ5aSn6YKu566x?= <linzc@zju.edu.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 11.06.2018 14:25, Gonglei (Arei) wrote:
>=20
> Hi David and Paolo,
>=20
>> -----Original Message-----
>> From: David Hildenbrand [mailto:david@redhat.com]
>> Sent: Monday, June 11, 2018 6:44 PM
>> To: =E6=B5=99=E5=A4=A7=E9=82=AE=E7=AE=B1 <linzc@zju.edu.cn>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>; Gonglei (Arei)
>> <arei.gonglei@huawei.com>; Igor Mammedov <imammedo@redhat.com>;
>> xuyandong <xuyandong2@huawei.com>; Zhanghailiang
>> <zhang.zhanghailiang@huawei.com>; wangxin (U)
>> <wangxinxin.wang@huawei.com>; lidonglin <lidonglin@huawei.com>;
>> kvm@vger.kernel.org; qemu-devel@nongnu.org; Huangweidong (C)
>> <weidong.huang@huawei.com>
>> Subject: Re: An emulation failure occurs,if I hotplug vcpus immediatel=
y after the
>> VM start
>>
>> On 07.06.2018 18:03, =E6=B5=99=E5=A4=A7=E9=82=AE=E7=AE=B1 wrote:
>>> Hi=EF=BC=8Call
>>> I still have a question after reading your discussion: Will seabios d=
etect the
>> change of address space even if we add_region and del_region automatic=
ally? I
>> guess that seabios may not take this change into consideration.
>>
>> Hi,
>>
>> We would just change the way how KVM memory slots are updated. This is
>> right now not atomic, but would be later on. It should not have any
>> other effect.
>>
> Yes. Do you have any plans to do that?=20

Well, I have plans to work on atomically resizable memory regions
(atomic del + add), and what Paolo described could also work for that
use case. However, I won't have time to look into that in the near
future. So if somebody else wants to jump it, perfect. If not, it will
have to wait unfortunately.

>=20
> Thanks,
> -Gonglei
>=20


--=20

Thanks,

David / dhildenb
