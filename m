Received: from eggs.gnu.org ([209.51.188.92]:50474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQbl-00045k-Uk
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQbl-0005j8-8W
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:52:05 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQbl-0005ht-0K
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:52:05 -0500
Received: by mail-pg1-x543.google.com with SMTP id u9so3733953pgo.7
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 09:52:04 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <778d340e-7b6f-8cb1-0ab8-37e19d1ff158@linaro.org>
Date: Sun, 17 Feb 2019 09:51:59 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/14] hw/misc/tz-ppc: Support having
 unused ports in the middle of the range
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
> The Peripheral Protection Controller's handling of unused ports
> is that if there is nothing connected to the port's downstream
> then it does not create the sysbus MMIO region for the upstream
> end of the port. This results in odd behaviour when there is
> an unused port in the middle of the range: since sysbus MMIO
> regions are implicitly consecutively allocated, any used ports
> above the unused ones end up with sysbus MMIO region numbers
> that don't match the port number.
> 
> Avoid this numbering mismatch by creating dummy MMIO regions
> for the unused ports. This doesn't change anything for our
> existing boards, which don't have any gaps in the middle of
> the port ranges they use; but it will be needed for the Musca
> board.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/misc/tz-ppc.h |  8 +++++++-
>  hw/misc/tz-ppc.c         | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
