Received: from eggs.gnu.org ([2001:4830:134:3::10]:58167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1ubK-0006Yp-Uh
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1ubG-0007m1-Dt
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:29:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2622
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1ubG-0007kv-2p
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:29:34 -0400
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
	<20171006152751.GR4015@localhost.localdomain>
	<CAFEAcA94pKm22fX1kCr72-SsM06Z2AMUZ65a7zJ_UPrarkBg1w@mail.gmail.com>
	<4479e30f-801d-0d8e-712d-06f2dd987528@cn.fujitsu.com>
	<CAFEAcA-oRksKrKXsPSNe9VqzHFgFwU0F8_R+S0Db+dydChR_Ew@mail.gmail.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <ae6cc795-c2b0-96bf-0807-ac99a5e57eb3@cn.fujitsu.com>
Date: Tue, 10 Oct 2017 21:29:29 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-oRksKrKXsPSNe9VqzHFgFwU0F8_R+S0Db+dydChR_Ew@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

At 10/10/2017 05:40 PM, Peter Maydell wrote:
> On 10 October 2017 at 08:41, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>> If we want do the "bios-tables-test", we need iasl support.
>>
>> otherwise, when I run "make V=1 check" without iasl, the test
>> will report error:
>
> This works in master at the moment, I think (whether by skipping
> the test or by using pre-compiled tables I don't know). We need to
> keep 'make check' working with and without iasl.

Yes, you are right, QEMU uses the macro named CONFIG_IASL to skip
the test if there is no ACPICA-tools in our system.

The QEMU has already kept 'make check' working with and without iasl.

The way I tested was wrong.

Thanks,
	dou.
>
> thanks
> -- PMM
>
>
>
