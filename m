Received: from eggs.gnu.org ([2001:4830:134:3::10]:51831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC5Im-0004tA-8Q
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC5Ij-0002Nf-0V
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:01:04 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC5Ii-0002N6-G9
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:01:00 -0400
Received: by mail-pg1-x541.google.com with SMTP id g2-v6so9358640pgu.11
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 09:01:00 -0700 (PDT)
References: <20181012144235.19646-1-peter.maydell@linaro.org>
	<20181012144235.19646-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91b5543d-9692-e7f2-5ff3-e912c61b4d64@linaro.org>
Date: Mon, 15 Oct 2018 09:00:55 -0700
MIME-Version: 1.0
In-Reply-To: <20181012144235.19646-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] target/arm: Report correct syndrome
 for FP/SIMD traps to Hyp mode
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

On 10/12/18 7:42 AM, Peter Maydell wrote:
> For traps of FP/SIMD instructions to AArch32 Hyp mode, the syndrome
> provided in HSR has more information than is reported to AArch64.
> Specifically, there are extra fields TA and coproc which indicate
> whether the trapped instruction was FP or SIMD. Add this extra
> information to the syndromes we construct, and mask it out when
> taking the exception to AArch64.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 14 +++++++++++++-
>  target/arm/helper.c    |  9 +++++++++
>  target/arm/translate.c |  8 ++++----
>  3 files changed, 26 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
