Received: from eggs.gnu.org ([2001:4830:134:3::10]:55167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCAWQ-0006VE-KS
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 17:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCAWN-000190-Pw
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 17:35:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:39858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCAWN-0000y5-4u
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 17:35:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id e67-v6so932495plb.6
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 14:35:13 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-10-aclindsa@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4001b651-754e-de03-bfe3-f865bebaed48@linaro.org>
Date: Mon, 15 Oct 2018 14:35:09 -0700
MIME-Version: 1.0
In-Reply-To: <20181010203735.27918-10-aclindsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 09/14] target/arm: Add array for
 supported PMU events, generate PMCEID[01]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aclindsa@gmail.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> +        cpu->pmceid0 = pmceid & 0xffffffff;
> +        cpu->pmceid1 = (pmceid >> 32) & 0xffffffff;

extract64(pmceid, 0, 32) and extract64(pmceid, 32, 32).

> +static const pm_event pm_events[] = {
> +};
> +#define MAX_EVENT_ID 0x0

Is this going to be ARRAY_SIZE(pm_events) - 1 in the end?

> +static uint16_t supported_event_map[MAX_EVENT_ID + 1];

Better as ARRAY_SIZE(pm_events)?

> +    for (i = 0; i <= MAX_EVENT_ID; i++) {
> +        supported_event_map[i] = UNSUPPORTED_EVENT;
> +    }

I think maybe

  for (i = 0; i < ARRAY_SIZE(supported_map_event); ++i) {

would be better.


r~
