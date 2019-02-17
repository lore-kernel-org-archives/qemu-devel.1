Received: from eggs.gnu.org ([209.51.188.92]:49885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQZL-0002iT-Eh
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQZK-0002R5-KO
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:49:35 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:41314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQZK-0002Gv-6A
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:49:34 -0500
Received: by mail-pf1-x42f.google.com with SMTP id b7so7340190pfi.8
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 09:49:23 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <65025d72-2213-bd18-f5e6-99d97547354e@linaro.org>
Date: Sun, 17 Feb 2019 09:49:18 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/14] hw/arm/armsse: Fix miswiring of
 expansion IRQs
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

On 2/14/19 4:50 AM, Peter Maydell wrote:
> In commit 91c1e9fcbd7548db368 where we added dual-CPU support to
> the ARMSSE, we set up the wiring of the expansion IRQs via nested
> loops: the outer loop on 'i' loops for each CPU, and the inner loop
> on 'j' loops for each interrupt. Fix a typo which meant we were
> wiring every expansion IRQ line to external IRQ 0 on CPU 0 and
> to external IRQ 1 on CPU 1.
> 
> Fixes: 91c1e9fcbd7548db368 ("hw/arm/armsse: Support dual-CPU configuration")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/armsse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
