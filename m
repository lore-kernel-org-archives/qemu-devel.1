Received: from eggs.gnu.org ([2001:4830:134:3::10]:55348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstZ4-0006Sc-MC
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstYz-0000kg-IO
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:38:34 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fstYz-0000jH-7W
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:38:29 -0400
Received: by mail-pf1-x444.google.com with SMTP id h69-v6so3144415pfd.4
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:38:29 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aabee0d4-4a28-98c9-515a-9033de948c5f@linaro.org>
Date: Thu, 23 Aug 2018 10:38:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/22] hw/ssi/pl022: Correct wrong DMACR
 and ICR handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, patches@linaro.org

On 08/20/2018 07:11 AM, Peter Maydell wrote:
> In the PL022, register offset 0x20 is the ICR, a write-only
> interrupt-clear register.  Register offset 0x24 is DMACR, the DMA
> control register.  We were incorrectly implementing (a stub version
> of) DMACR at 0x20, and not implementing anything at 0x24.  Fix this
> bug.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/ssi/pl022.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
