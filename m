Received: from eggs.gnu.org ([2001:4830:134:3::10]:49564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiaJ-0007hK-Aq
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiaE-00079b-E9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:37:47 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:37130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmiaE-00079D-7Z
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:37:42 -0400
Received: by mail-pg0-x232.google.com with SMTP id 83so11780778pgb.4
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:37:42 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-7-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a488f464-200c-8bfa-79e0-8c4e3547309f@linaro.org>
Date: Tue, 29 Aug 2017 08:37:38 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-7-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/20] target/arm: Make BASEPRI register
 banked for v8M
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

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> Make the BASEPRI register banked if v8M security extensions are enabled.
> 
> Note that we do not yet implement the functionality of the new
> AIRCR.PRIS bit (which allows the effect of the NS copy of BASEPRI to
> be restricted).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 14 +++++++++++++-
>  hw/intc/armv7m_nvic.c |  4 ++--
>  target/arm/helper.c   | 10 ++++++----
>  target/arm/machine.c  |  3 ++-
>  4 files changed, 23 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
