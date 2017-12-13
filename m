Received: from eggs.gnu.org ([2001:4830:134:3::10]:51160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePBW6-0004Ex-4e
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePBW5-0007A2-2e
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:26 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePBW4-00079K-TT
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:25 -0500
Received: by mail-oi0-x244.google.com with SMTP id u193so2174197oie.1
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 10:12:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e36ec13c-e597-caae-4ae8-81b320e8f461@huawei.com>
References: <1511807966-23936-1-git-send-email-gengdongjiu@huawei.com>
	<470c9df5-f2e8-974b-b37f-eff84a6f3d71@huawei.com>
	<18906953-f464-d9f4-23b4-fd7118d45e2f@huawei.com>
	<20171211143220.7a359462@redhat.com>
	<e36ec13c-e597-caae-4ae8-81b320e8f461@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:03 +0000
Message-ID: <CAFEAcA-JmbR3RUMWrH2j5OrSitczu+KskE-NJyhsWrHbJCH_ZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v13 00/12] Add ARMv8 RAS virtualization
 support in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, James Morse <james.morse@arm.com>, Laszlo Ersek <lersek@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linuxarm <linuxarm@huawei.com>, xuwei5@hisilicon.com

On 13 December 2017 at 03:59, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Hi Peter,
>
> On 2017/12/11 21:32, Igor Mammedov wrote:
>> On Mon, 11 Dec 2017 19:31:14 +0800
>> gengdongjiu <gengdongjiu@huawei.com> wrote:
>>
>>> Hi maintainer,
>>>
>>>   This patch set seems pending about one month, could you help review for them?  Thanks.
>> I'm going to look at ACPI side of it this week.
>
> Hi Peter/shannon,
>    Igor will review the ACPI part code,
>    could you review below five patches? which does not depend on OS kernel patch and have received the agreement with others about the solution.
>    Thanks very much.
>
> [v13,08/12] target-arm: kvm64: inject synchronous External Abort
> [v13,09/12] Move related hwpoison page function to accel/kvm/ folder
> [v13,10/12] ARM: ACPI: Add _E04 for hardware error device
> [v13,11/12] hw/arm/virt: Add RAS platform version for migration
> [v13,12/12] target-arm: kvm64: handle SIGBUS signal from kernel or KVM

Hi; unfortunately I only have one more working day this year, which
isn't really enough to get up to speed sufficiently with RAS to
review this patchset, so the earliest I'm likely to get to it is
the week beginning 9th Jan.

Hopefully somebody who understands RAS better than me will
be able to review it before then.

thanks
-- PMM
