Received: from eggs.gnu.org ([2001:4830:134:3::10]:37580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC8oS-00080E-Qs
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC8oN-0000AT-TC
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:46:00 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC8oN-0008UZ-A6
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:45:55 -0400
Received: by mail-pf1-x441.google.com with SMTP id r9-v6so10192417pff.11
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 12:45:55 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-5-aclindsa@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0e30ca6d-57f1-e67a-b9c3-dc5e4b703260@linaro.org>
Date: Mon, 15 Oct 2018 12:45:51 -0700
MIME-Version: 1.0
In-Reply-To: <20181010203735.27918-5-aclindsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 04/14] target/arm: Swap PMU values
 before/after migrations
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
> +static void cpu_post_save(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +    pmccntr_sync(&cpu->env);
> +}

I'm confused about the need for this.
Can you explain the sequence of events that requires it?


r~
