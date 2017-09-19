Received: from eggs.gnu.org ([2001:4830:134:3::10]:36563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNYW-0006vn-KS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNYR-0004hl-5z
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:47:36 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:55641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duNYR-0004hN-1f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:47:31 -0400
Received: by mail-io0-x231.google.com with SMTP id z187so1286924ioz.12
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:47:30 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-11-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2d44105-3130-299a-217f-f142fdc72568@linaro.org>
Date: Tue, 19 Sep 2017 13:47:26 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-11-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/19] nvic: Make SHPR registers banked
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
> Make the set_prio() function take a bool indicating
> whether to pend the secure or non-secure version of a banked
> interrupt, and use this to implement the correct banking
> semantics for the SHPR registers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  hw/intc/trace-events  |  2 +-
>  2 files changed, 88 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
