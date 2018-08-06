Received: from eggs.gnu.org ([2001:4830:134:3::10]:48030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmiii-0005qa-DJ
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmiih-000739-EK
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:51:00 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmiih-00072t-93
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:50:59 -0400
Received: by mail-oi0-x244.google.com with SMTP id m11-v6so23447558oic.2
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 09:50:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f9f955a3-001e-aa12-97ef-97a085b8dc6d@linaro.org>
References: <20180806123445.1459-1-peter.maydell@linaro.org>
	<f9f955a3-001e-aa12-97ef-97a085b8dc6d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 17:50:38 +0100
Message-ID: <CAFEAcA9O3v5RQYfwui0c6ZGvkGZ7GbNHqbyqNbONsDRTrBFxUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 0/5] Arm migration fixes for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 6 August 2018 at 15:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 08/06/2018 05:34 AM, Peter Maydell wrote:
>> Peter Maydell (5):
>>   hw/intc/arm_gicv3_common: Give no-migration-shift-bug subsection a
>>     needed function
>>   hw/intc/arm_gicv3_common: Combine duplicate .subsections in
>>     vmstate_gicv3_cpu
>>   target/arm: Add dummy needed functions to M profile vmstate
>>     subsections
>>   hw/intc/arm_gicv3_common: Move post_load hooks to top-level VMSD
>>   hw/intc/arm_gicv3_common: Move gicd shift bug handling to
>>     gicv3_post_load
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; series applied to master for rc4.

-- PMM
