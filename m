Received: from eggs.gnu.org ([2001:4830:134:3::10]:33228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNSr-0004x0-Tu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNSl-0007Pf-Rb
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:41:43 -0400
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:49295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duNSl-0007LP-MD
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:41:39 -0400
Received: by mail-io0-x235.google.com with SMTP id 21so1291994iof.6
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:41:37 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-10-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d391768f-e01f-ef35-c2b1-3b6030988a0a@linaro.org>
Date: Tue, 19 Sep 2017 13:41:32 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-10-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/19] nvic: Make set_pending and
 clear_pending take a secure parameter
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
> Make the armv7m_nvic_set_pending() and armv7m_nvic_clear_pending()
> functions take a bool indicating whether to pend the secure
> or non-secure version of a banked interrupt, and update the
> callsites accordingly.
> 
> In most callsites we can simply pass the correct security
> state in; in a couple of cases we use TODO comments to indicate
> that we will return the code in a subsequent commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 14 ++++++++++-
>  hw/intc/armv7m_nvic.c | 64 ++++++++++++++++++++++++++++++++++++++-------------
>  target/arm/helper.c   | 24 +++++++++++--------
>  hw/intc/trace-events  |  4 ++--
>  4 files changed, 77 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
