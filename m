Received: from eggs.gnu.org ([2001:4830:134:3::10]:43690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRHT2-0000de-Km
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRHSy-00010J-Js
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:57:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRHSy-0000zG-Ex
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:57:52 -0500
References: <20171204120322.GA32151@yangzhon-Virtual>
	<5A253EF5.6040300@huawei.com> <20171205060047.GA4102@yangzhon-Virtual>
	<024fd897-a16a-f69e-94dc-07affb3ef724@redhat.com>
	<20171206092625.GA19639@yangzhon-Virtual>
	<6bfac215-b5ba-fd09-d17b-310a2c843a2b@redhat.com>
	<20171207150629.GA7387@yangzhon-Virtual>
	<af4a7e59-ac0a-1d5f-3cc5-458dd5fc6fc9@redhat.com>
	<20171212065419.GB26607@yangzhon-Virtual> <5A376B8D.5080008@huawei.com>
	<20171218075115.GA15707@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d187c3d1-cd6f-13fe-8bfa-4fc2bf94a4b0@redhat.com>
Date: Tue, 19 Dec 2017 13:57:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171218075115.GA15707@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, berrange@redhat.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com

On 18/12/2017 08:51, Yang Zhong wrote:
> On Mon, Dec 18, 2017 at 03:17:33PM +0800, Shannon Zhao wrote:
>>
>>
>> On 2017/12/12 14:54, Yang Zhong wrote:
>>>>> 2) what effect it has on boot time in Shannon's case.
>>>   Hello Shannon,
>>>
>>>   It's hard for me to reproduce your commands in my x86 enviornment, =
as a compare test,
>>>   would you please help me use above two TEMP patches to verify VM bo=
otup time again?
>>>
>>>   Those data can help Paolo to decide which patch will be used or how=
 to adjust delta
>>>   parameter.  Many thanks!
>> We have tested these two patches. Both don't increase the VM bootup ti=
me
>> in my case.
>>
>   Thanks for Shannon's great help!
>=20
>   Paolo, please make decision which TEMP solution is prefered ? I can s=
end out V4 patch soon.

I would go with the simpler patch then.

Thanks,

Paolo
