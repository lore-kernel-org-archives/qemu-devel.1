Received: from eggs.gnu.org ([209.51.188.92]:53576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1xiG-0007dE-3I
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1xiE-0005GG-RW
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:25:47 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1xiE-0005FU-I4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:25:46 -0500
Received: by mail-pf1-x442.google.com with SMTP id q17so12066698pfh.10
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:25:46 -0800 (PST)
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
	<20190307180520.13868-5-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f415c038-6a0f-c44b-e2f5-ad2483ae81f5@linaro.org>
Date: Thu, 7 Mar 2019 10:25:42 -0800
MIME-Version: 1.0
In-Reply-To: <20190307180520.13868-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] target/ppc: introduce
 avr_full_offset() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/7/19 10:05 AM, Mark Cave-Ayland wrote:
> All TCG vector operations require pointers to the base address of the vector
> rather than separate access to the top and bottom 64-bits. Convert the VMX TCG
> instructions to use a new avr_full_offset() function instead of avr64_offset()
> which can then itself be written as a simple wrapper onto vsr_full_offset().
> 
> This same function can also reused in cpu_avr_ptr() to avoid having more than
> one copy of the offset calculation logic.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h                    | 12 +++++++++++-
>  target/ppc/translate/vmx-impl.inc.c | 22 +++++++++++-----------
>  target/ppc/translate/vsx-impl.inc.c |  5 -----
>  3 files changed, 22 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
