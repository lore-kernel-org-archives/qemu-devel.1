Received: from eggs.gnu.org ([2001:4830:134:3::10]:38669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqch-0007oO-Nw
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqcd-000397-Ex
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:30:07 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsqcd-000384-0y
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:30:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id j26-v6so2790133pfi.10
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 07:30:02 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4157d5bd-d0de-2059-2d29-8b1a8e3c010f@linaro.org>
Date: Thu, 23 Aug 2018 07:29:59 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/22] hw/misc/iotkit: Wire up the sysctl
 and sysinfo register blocks
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
> Wire up the system control element's register banks
> (sysctl and sysinfo).
> 
> This is the last of the previously completely unimplemented
> components in the IoTKit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/iotkit.h |  6 +++++-
>  hw/arm/iotkit.c         | 26 ++++++++++++++++++--------
>  2 files changed, 23 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
