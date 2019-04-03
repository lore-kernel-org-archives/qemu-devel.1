Received: from eggs.gnu.org ([209.51.188.92]:45156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBZBI-0006wZ-L3
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 02:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBZBH-00088G-27
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 02:15:28 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBZBE-0007zg-NT
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 02:15:26 -0400
Received: by mail-pl1-x641.google.com with SMTP id m10so7490167plt.10
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 23:15:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-20-richard.henderson@linaro.org>
Message-ID: <5430914f-aacc-8904-ec27-7d5be2018258@linaro.org>
Date: Wed, 3 Apr 2019 11:36:45 +0700
MIME-Version: 1.0
In-Reply-To: <20190403034358.21999-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/26] target/sparc: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 4/3/19 10:43 AM, Richard Henderson wrote:
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/sparc/cpu.h         |   5 +-
>  target/sparc/cpu.c         |   5 +-
>  target/sparc/ldst_helper.c |  15 ----
>  target/sparc/mmu_helper.c  | 175 +++++++++++++++++++------------------
>  4 files changed, 93 insertions(+), 107 deletions(-)

Bah, failed to test this one, and it hangs.
For v2 I'll not try to combine SPARC64 and SPARC32 paths.


r~
