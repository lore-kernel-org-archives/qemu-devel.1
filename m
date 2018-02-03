Received: from eggs.gnu.org ([2001:4830:134:3::10]:50502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4wU-0000lX-Hk
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4wP-0007Hi-OL
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:01:46 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei4wP-0007HT-HV
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:01:41 -0500
Received: by mail-pf0-x244.google.com with SMTP id w83so764386pfi.12
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 13:01:41 -0800 (PST)
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3b46f5ca-e789-ac0b-04f2-1df7fc0b7633@linaro.org>
Date: Sat, 3 Feb 2018 13:01:37 -0800
MIME-Version: 1.0
In-Reply-To: <1517324542-6607-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] target/arm: Add
 armv7m_nvic_set_pending_derived()
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

On 01/30/2018 07:02 AM, Peter Maydell wrote:
> In order to support derived exceptions (exceptions generated in
> the course of trying to take an exception), we need to be able
> to handle prioritizing whether to take the original exception
> or the derived exception.
> 
> We do this by introducing a new function
> armv7m_nvic_set_pending_derived() which the exception-taking code in
> helper.c will call when a derived exception occurs.  Derived
> exceptions are dealt with mostly like normal pending exceptions, so
> we share the implementation with the armv7m_nvic_set_pending()
> function.
> 
> Note that the way we structure this is significantly different
> from the v8M Arm ARM pseudocode: that does all the prioritization
> logic in the DerivedLateArrival() function, whereas we choose to
> let the existing "identify highest priority exception" logic
> do the prioritization for us. The effect is the same, though.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 13 ++++++++++
>  hw/intc/armv7m_nvic.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  hw/intc/trace-events  |  2 +-
>  3 files changed, 80 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
