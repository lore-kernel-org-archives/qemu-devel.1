Received: from eggs.gnu.org ([2001:4830:134:3::10]:51488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eEA5b-0005DQ-Gh
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eEA5a-0006Oe-NI
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:27:31 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
	<1510341591-22817-10-git-send-email-gengdongjiu@huawei.com>
	<3017b1b9-24d7-565b-1180-a0eb93c6d57a@redhat.com>
	<572b8361-ee14-35ed-6c85-a5e5d8ae5b1a@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b948cb25-dad9-ec7e-8406-b829d21cac26@redhat.com>
Date: Mon, 13 Nov 2017 09:27:14 +0100
MIME-Version: 1.0
In-Reply-To: <572b8361-ee14-35ed-6c85-a5e5d8ae5b1a@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 09/12] Move related hwpoison page
 function to accel/kvm/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, james.morse@arm.com, lersek@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, guohanjun@huawei.com, lijinyue@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com, linuxarm@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 13/11/2017 02:45, gengdongjiu wrote:
> On 2017/11/10 19:32, Paolo Bonzini wrote:
>> On 10/11/2017 20:19, Dongjiu Geng wrote:
>>> +typedef struct HWPoisonPage {
>>> +    ram_addr_t ram_addr;
>>> +    QLIST_ENTRY(HWPoisonPage) list;
>>> +} HWPoisonPage;
>>> +
>>
>> Is this actually needed outside accel/kvm/kvm-all.c?
> Paolo,
>    Thanks for the comments, this structure is added in the accel/kvm/kvm-all.c is also OK.
> My previous thought is that this is structure definition, so I move it to a header file.
> If you think this structure should be added in accel/kvm/kvm-all.c, I will move it.

It can be done later; but if you have to send a v13 series, I would be
grateful if you included this change as well.

Paolo

> thanks!
> 
>>
>> Thanks,
>>
>> Paolo
>>
>> .
>>
> 
