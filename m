Received: from eggs.gnu.org ([2001:4830:134:3::10]:37215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNZW-0007RB-1P
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNZS-0005X1-54
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:48:38 -0400
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:53588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duNZR-0005Vm-WA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:48:34 -0400
Received: by mail-io0-x22b.google.com with SMTP id q11so1298418ioe.10
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:48:33 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-12-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1e3a6dd4-9b8b-b2c6-723a-5867167b1272@linaro.org>
Date: Tue, 19 Sep 2017 13:48:30 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-12-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/19] nvic: Compare group priority for
 escalation to HF
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

On 09/12/2017 01:13 PM, Peter Maydell wrote:
> In armv7m_nvic_set_pending() we have to compare the
> priority of an exception against the execution priority
> to decide whether it needs to be escalated to HardFault.
> In the specification this is a comparison against the
> exception's group priority; for v7M we implemented it
> as a comparison against the raw exception priority
> because the two comparisons will always give the
> same answer. For v8M the existence of AIRCR.PRIS and
> the possibility of different PRIGROUP values for secure
> and nonsecure exceptions means we need to explicitly
> calculate the vector's group priority for this check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
