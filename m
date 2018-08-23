Received: from eggs.gnu.org ([2001:4830:134:3::10]:50076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstQv-0003Ce-0x
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstQp-0002jd-1l
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:30:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:39943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fstQl-0002ex-4s
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:30:01 -0400
Received: by mail-pf1-x433.google.com with SMTP id s13-v6so2977385pfi.7
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:29:58 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ec156cc2-61ad-00f2-8227-373ebb08243e@linaro.org>
Date: Thu, 23 Aug 2018 10:29:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/22] hw/ssi/pl022: Set up reset function
 in class init
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
> Currently the PL022 calls pl022_reset() from its class init
> function. Make it register a DeviceState reset method instead,
> so that we reset the device on system reset.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/ssi/pl022.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
