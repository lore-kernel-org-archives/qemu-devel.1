Received: from eggs.gnu.org ([2001:4830:134:3::10]:57905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmg9l-0004gX-BE
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmg9h-0006l3-Cz
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:06:45 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fmg9h-0006kj-62
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:06:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id n7-v6so6286905pgq.4
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:06:40 -0700 (PDT)
References: <20180806123445.1459-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f9f955a3-001e-aa12-97ef-97a085b8dc6d@linaro.org>
Date: Mon, 6 Aug 2018 07:06:36 -0700
MIME-Version: 1.0
In-Reply-To: <20180806123445.1459-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 0/5] Arm migration fixes for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, patches@linaro.org

On 08/06/2018 05:34 AM, Peter Maydell wrote:
> Peter Maydell (5):
>   hw/intc/arm_gicv3_common: Give no-migration-shift-bug subsection a
>     needed function
>   hw/intc/arm_gicv3_common: Combine duplicate .subsections in
>     vmstate_gicv3_cpu
>   target/arm: Add dummy needed functions to M profile vmstate
>     subsections
>   hw/intc/arm_gicv3_common: Move post_load hooks to top-level VMSD
>   hw/intc/arm_gicv3_common: Move gicd shift bug handling to
>     gicv3_post_load

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
