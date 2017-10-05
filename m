Received: from eggs.gnu.org ([2001:4830:134:3::10]:43686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e09yf-0002UZ-9D
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e09ye-0001cj-GQ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:30:29 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:49075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e09ye-0001cA-At
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:30:28 -0400
Received: by mail-qt0-x231.google.com with SMTP id d13so26116013qta.5
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 10:30:28 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-12-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c626067-0c52-1c2a-eabc-d6c1dbfbe4a9@linaro.org>
Date: Thu, 5 Oct 2017 13:30:23 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-12-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/20] target/arm: Add support for
 restoring v8M additional state context
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

On 09/22/2017 10:59 AM, Peter Maydell wrote:
> For v8M, exceptions from Secure to Non-Secure state will save
> callee-saved registers to the exception frame as well as the
> caller-saved registers. Add support for unstacking these
> registers in exception exit when necessary.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
