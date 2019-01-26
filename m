Received: from eggs.gnu.org ([209.51.188.92]:58840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBPu-0004xG-24
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBPt-0001o2-8f
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:01:45 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBPr-0001fj-SS
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:01:45 -0500
Received: by mail-pf1-x441.google.com with SMTP id c123so5478259pfb.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:01:37 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a16fa8de-cf25-54c0-f394-1624017d18df@linaro.org>
Date: Fri, 25 Jan 2019 16:01:33 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/23] hw/arm/iotkit: Rename files to
 hw/arm/armsse.[ch]
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

On 1/21/19 10:51 AM, Peter Maydell wrote:
> Rename the files that used to be iotkit.[ch] to
> armsse.[ch] to reflect the fact they new cover
> multiple Arm subsystems for embedded.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/Makefile.objs                  | 2 +-
>  include/hw/arm/{iotkit.h => armsse.h} | 4 ++--
>  hw/arm/{iotkit.c => armsse.c}         | 2 +-
>  hw/arm/mps2-tz.c                      | 2 +-
>  MAINTAINERS                           | 4 ++--
>  default-configs/arm-softmmu.mak       | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
>  rename include/hw/arm/{iotkit.h => armsse.h} (99%)
>  rename hw/arm/{iotkit.c => armsse.c} (99%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
