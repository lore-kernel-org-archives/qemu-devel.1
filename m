Received: from eggs.gnu.org ([2001:4830:134:3::10]:57008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duju6-0000Z5-KU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duju3-0005vS-I6
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:39:22 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:54572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duju3-0005u8-Cc
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:39:19 -0400
Received: by mail-io0-x22a.google.com with SMTP id h66so5634556ioh.11
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 11:39:19 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-20-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa76cece-46be-61ef-c806-ac4d632da5bc@linaro.org>
Date: Wed, 20 Sep 2017 13:39:15 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-20-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/19] nvic: Support banked exceptions in
 acknowledge and complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 09/12/2017 01:14 PM, Peter Maydell wrote:
> Update armv7m_nvic_acknowledge_irq() and armv7m_nvic_complete_irq()
> to handle banked exceptions:
>  * acknowledge needs to use the correct vector, which may be
>    in sec_vectors[]
>  * acknowledge needs to return to its caller whether the
>    exception should be taken to secure or non-secure state
>  * complete needs its caller to tell it whether the exception
>    being completed is a secure one or not
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 15 +++++++++++++--
>  hw/intc/armv7m_nvic.c | 26 ++++++++++++++++++++------
>  target/arm/helper.c   |  8 +++++---
>  hw/intc/trace-events  |  4 ++--
>  4 files changed, 40 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
