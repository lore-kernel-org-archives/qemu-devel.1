Received: from eggs.gnu.org ([2001:4830:134:3::10]:59677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cgVXT-0003Ck-7h
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cgVXS-0006vj-AW
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:56:55 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NbQNzrUUCAS2e5Xso0rg6H3+nzDjTc9i8Tc+GLpXvLw@mail.gmail.com>
References: <1487313115-9510-1-git-send-email-vijay.kilari@gmail.com>
	<1487313115-9510-3-git-send-email-vijay.kilari@gmail.com>
	<CAFEAcA8618+LGejFq6SpBEwGrNpfamBBX3MFWjss-ZxJ7Xk8mg@mail.gmail.com>
	<CALicx6tqxXZxBTxYvF55ydBg5CB1to3MsEkhaohucx4EAZcEJA@mail.gmail.com>
	<CAFEAcA_NbQNzrUUCAS2e5Xso0rg6H3+nzDjTc9i8Tc+GLpXvLw@mail.gmail.com>
From: Vijay Kilari <vijay.kilari@gmail.com>
Date: Wed, 22 Feb 2017 17:26:47 +0530
Message-ID: <CALicx6uiFYXsOMaiCH9HYW_jxbMSg+QSCrbVr0D-UKWwtf+TwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v8 2/5] hw/intc/arm_gicv3_kvm: Add
 ICC_SRE_EL1 register to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Hi Christoffer,

On Mon, Feb 20, 2017 at 3:21 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 20 February 2017 at 06:21, Vijay Kilari <vijay.kilari@gmail.com> wrote:
>> Hi Peter,
>>
>> On Fri, Feb 17, 2017 at 7:25 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> [on the guest-visible ICC_SRE_EL1 value]
>>> Is there a situation where KVM might allow a value other
>>> than 0x7?
>>
>> In KVM, the SRE_EL1 value is 0x1. During save, value
>> read from KVM is 0x1 though we reset to 0x7.
>
> 0x1 meanss "System Register Interface enabled, IRQ
> bypass enabled, FIQ bypass enabled". This seems
> rather a weird setting, because it means "the GICv3
> CPU interface functionality is disabled and the GICv3
> should signal interrupts via legacy IRQ and FIQ".
> Does KVM really support IRQ/FIQ bypass and does Linux
> really leave it enabled rather than turning it off
> by writing the value to 1?
>
> My expectation was that the KVM GICv3 emulation would
> make these bits RAO/WI like the TCG implementation.
> Is there maybe a bug in the kernel side where it
> doesn't implement bypass but has made these bits be
> RAZ/WI rather than RAO/WI ?

Do you have any inputs on this?
