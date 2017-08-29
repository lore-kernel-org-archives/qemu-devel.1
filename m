Received: from eggs.gnu.org ([2001:4830:134:3::10]:49961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmibV-0008V1-K7
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmibU-0007cr-UJ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:39:01 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:33629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmibU-0007cR-Ob
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:39:00 -0400
Received: by mail-pf0-x232.google.com with SMTP id r62so11307262pfj.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:39:00 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-8-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <918b7d17-8a0a-1ff5-d31a-5ee09479ee2f@linaro.org>
Date: Tue, 29 Aug 2017 08:38:57 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/20] target/arm: Make PRIMASK register
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
> Make the PRIMASK register banked if v8M security extensions are enabled.
> 
> Note that we do not yet implement the functionality of the new
> AIRCR.PRIS bit (which allows the effect of the NS copy of PRIMASK to
> be restricted).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 2 +-
>  hw/intc/armv7m_nvic.c | 2 +-
>  target/arm/helper.c   | 4 ++--
>  target/arm/machine.c  | 9 +++++++--
>  4 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
