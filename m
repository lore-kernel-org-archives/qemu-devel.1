Received: from eggs.gnu.org ([2001:4830:134:3::10]:55752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNJn-0007Nb-QQ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNJi-0003FC-U6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:32:23 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:49179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duNJi-0003E2-PY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:32:18 -0400
Received: by mail-io0-x230.google.com with SMTP id 21so1231637iof.6
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:32:18 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-9-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de7f9ca1-0faa-1676-2429-6775296afa7c@linaro.org>
Date: Tue, 19 Sep 2017 13:32:14 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-9-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/19] nvic: Handle banked exceptions in
 nvic_recompute_state()
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
> Update the nvic_recompute_state() code to handle the security
> extension and its associated banked registers.
> 
> Code that uses the resulting cached state (ie the irq
> acknowledge and complete code) will be updated in a later
> commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  hw/intc/trace-events  |   1 +
>  2 files changed, 147 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
