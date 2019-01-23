Received: from eggs.gnu.org ([209.51.188.92]:51190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmS9q-0005zc-5l
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmS9p-0008AN-Cm
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:42:10 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmS9p-00089v-6E
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:42:09 -0500
Received: by mail-pg1-x544.google.com with SMTP id z11so1812274pgu.0
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 15:42:09 -0800 (PST)
References: <20190123195814.29253-1-aaron@os.amperecomputing.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36c71f66-f86f-ecb1-576a-151a6a902c2e@linaro.org>
Date: Wed, 23 Jan 2019 15:42:05 -0800
MIME-Version: 1.0
In-Reply-To: <20190123195814.29253-1-aaron@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Don't clear supported PMU
 events when initializing PMCEID1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 1/23/19 11:59 AM, Aaron Lindsay OS wrote:
> A bug was introduced during a respin of:
> 
> 	commit 57a4a11b2b281bb548b419ca81bfafb214e4c77a
> 	target/arm: Add array for supported PMU events, generate PMCEID[01]_EL0
> 
> This patch introduced two calls to get_pmceid() during CPU
> initialization - one each for PMCEID0 and PMCEID1. In addition to
> building the register values, get_pmceid() clears an internal array
> mapping event numbers to their implementations (supported_event_map)
> before rebuilding it. This is an optimization since much of the logic is
> shared. However, since it was called twice, the contents of
> supported_event_map reflect only the events in PMCEID1 (the second call
> to get_pmceid()).
> 
> Fix this bug by moving the initialization of PMCEID0 and PMCEID1 back
> into a single function call, and name it more appropriately since it is
> doing more than simply generating the contents of the PMCEID[01]
> registers.
> 
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/cpu.c    |  3 +--
>  target/arm/cpu.h    | 11 +++++------
>  target/arm/helper.c | 27 ++++++++++++++++-----------
>  3 files changed, 22 insertions(+), 19 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
