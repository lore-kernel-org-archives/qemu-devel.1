Received: from eggs.gnu.org ([2001:4830:134:3::10]:40979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsBUd-0001RY-RQ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsBUY-0008GV-CT
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:35:03 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsBUW-0008AY-VN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:34:58 -0400
Received: by mail-pg1-x544.google.com with SMTP id s15-v6so6078907pgv.8
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 11:34:52 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc3e965c-5068-d185-11a2-83b692abeead@linaro.org>
Date: Tue, 21 Aug 2018 11:34:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/22] hw/misc/mps2-fpgaio: Implement 1Hz
 and 100Hz counters
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

On 08/20/2018 07:10 AM, Peter Maydell wrote:
> The MPS2 FPGAIO block includes some simple free-running counters.
> Implement these.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/misc/mps2-fpgaio.h |  4 +++
>  hw/misc/mps2-fpgaio.c         | 53 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 56 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
