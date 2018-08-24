Received: from eggs.gnu.org ([2001:4830:134:3::10]:45845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3sB-0002Pm-R9
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3s9-00021S-Pc
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:38:59 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ft3s7-0001zP-Op
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:38:55 -0400
Received: by mail-pl1-x643.google.com with SMTP id e11-v6so547568plb.3
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 21:38:54 -0700 (PDT)
References: <20180814144436.679-1-peter.maydell@linaro.org>
	<20180814144436.679-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <325d781d-784c-7dfc-efd7-38ef0f9b8f17@linaro.org>
Date: Thu, 23 Aug 2018 21:38:50 -0700
MIME-Version: 1.0
In-Reply-To: <20180814144436.679-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/8] hw/display/bcm2835_fb: Reset
 resolution, etc correctly
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

On 08/14/2018 07:44 AM, Peter Maydell wrote:
> The bcm2835_fb's initial resolution and other parameters are set
> via QOM properties. We should reset to those initial values on
> device reset, which means we need to save the QOM property
> values somewhere that they are not overwritten by guest
> changes to the framebuffer configuration.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/display/bcm2835_fb.h |  1 +
>  hw/display/bcm2835_fb.c         | 27 +++++++++++++++------------
>  2 files changed, 16 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
