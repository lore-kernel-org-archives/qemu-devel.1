Received: from eggs.gnu.org ([2001:4830:134:3::10]:60670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC8Wx-0002F7-95
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC8Wu-00067N-IB
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:27:55 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC8Wu-00065V-CF
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:27:52 -0400
Received: by mail-pg1-x541.google.com with SMTP id t70-v6so9619592pgd.12
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 12:27:48 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-3-aclindsa@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f98dc0e-99e9-af34-eadc-8aa3436a723f@linaro.org>
Date: Mon, 15 Oct 2018 12:27:44 -0700
MIME-Version: 1.0
In-Reply-To: <20181010203735.27918-3-aclindsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 02/14] target/arm: Mask PMOVSR writes
 based on supported counters
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
> This is an amendment to my earlier patch:
>     commit 7ece99b17e832065236c07a158dfac62619ef99b
>     Author: Aaron Lindsay <alindsay@codeaurora.org>
>     Date:   Thu Apr 26 11:04:39 2018 +0100
> 
> 	target/arm: Mask PMU register writes based on PMCR_EL0.N
> 
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
