Received: from eggs.gnu.org ([2001:4830:134:3::10]:40184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e08iK-0006H4-QN
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e08iF-0004x0-6L
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:09:32 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:54350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e08iF-0004wW-1V
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:09:27 -0400
Received: by mail-qt0-x22f.google.com with SMTP id i13so26317948qtc.11
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:09:27 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-4-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f272860f-2822-34d7-2440-3aceb62f3149@linaro.org>
Date: Thu, 5 Oct 2017 12:09:23 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/20] target/arm: Prepare for
 CONTROL.SPSEL being nonzero in Handler mode
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
> In the v7M architecture, there is an invariant that if the CPU is
> in Handler mode then the CONTROL.SPSEL bit cannot be nonzero.
> This in turn means that the current stack pointer is always
> indicated by CONTROL.SPSEL, even though Handler mode always uses
> the Main stack pointer.
> 
> In v8M, this invariant is removed, and CONTROL.SPSEL may now
> be nonzero in Handler mode (though Handler mode still always
> uses the Main stack pointer). In preparation for this change,
> change how we handle this bit: rename switch_v7m_sp() to
> the now more accurate write_v7m_control_spsel(), and make it
> check both the handler mode state and the SPSEL bit.
> 
> Note that this implicitly changes the point at which we switch
> active SP on exception exit from before we pop the exception
> frame to after it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      |  8 ++++++-
>  hw/intc/armv7m_nvic.c |  2 +-
>  target/arm/helper.c   | 65 ++++++++++++++++++++++++++++++++++-----------------
>  3 files changed, 51 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
