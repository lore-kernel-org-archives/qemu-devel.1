Received: from eggs.gnu.org ([2001:4830:134:3::10]:44538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCZI6-0007yF-BK
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 20:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCZHy-0003Rg-Bk
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 20:02:18 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCZHy-0003PW-3f
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 20:02:14 -0400
Received: by mail-pf1-x441.google.com with SMTP id f29-v6so12249452pff.5
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:02:13 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-11-aclindsa@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <248e57f7-89f2-0e71-1da0-b358d10b62c5@linaro.org>
Date: Tue, 16 Oct 2018 17:02:08 -0700
MIME-Version: 1.0
In-Reply-To: <20181010203735.27918-11-aclindsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 10/14] target/arm: Finish implementation
 of PM[X]EVCNTR and PM[X]EVTYPER
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
> Add arrays to hold the registers, the definitions themselves, access
> functions, and logic to reset counters when PMCR.P is set. Update
> filtering code to support counters other than PMCCNTR. Support migration
> with raw read/write functions.
> 
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
> ---
>  target/arm/cpu.h    |   3 +
>  target/arm/helper.c | 296 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 282 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
