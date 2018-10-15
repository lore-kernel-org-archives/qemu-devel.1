Received: from eggs.gnu.org ([2001:4830:134:3::10]:45724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC4xV-0006Zn-KI
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC4xQ-0007z1-N1
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:39:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC4xQ-0007yP-FD
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:39:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id r9-v6so9864893pff.11
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 08:39:00 -0700 (PDT)
References: <20181012144235.19646-1-peter.maydell@linaro.org>
	<20181012144235.19646-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <11aa2e64-2a40-b0a1-1e1b-a0af0be5eb70@linaro.org>
Date: Mon, 15 Oct 2018 08:38:56 -0700
MIME-Version: 1.0
In-Reply-To: <20181012144235.19646-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/10] target/arm: New utility function to
 extract EC from syndrome
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
> Create and use a utility function to extract the EC field
> from a syndrome, rather than open-coding the shift.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 5 +++++
>  target/arm/helper.c    | 4 ++--
>  target/arm/kvm64.c     | 2 +-
>  target/arm/op_helper.c | 2 +-
>  4 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
