Received: from eggs.gnu.org ([2001:4830:134:3::10]:49808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstQG-0002XO-Gj
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstQB-0002Dz-DU
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:29:28 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fstQB-0002DM-2f
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:29:23 -0400
Received: by mail-pg1-x544.google.com with SMTP id m4-v6so2433631pgv.12
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:29:23 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca0a29db-4915-f7b3-4019-b338bec6308c@linaro.org>
Date: Thu, 23 Aug 2018 10:29:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/22] hw/ssi/pl022: Allow use as
 embedded-struct device
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
> Create a new include file for the pl022's device struct,
> type macros, etc, so that it can be instantiated using
> the "embedded struct" coding style.
> 
> While we're adding the new file to MAINTAINERS, add
> also the .c file, which was missing an entry.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/ssi/pl022.h | 51 ++++++++++++++++++++++++++++++++++++++++++
>  hw/ssi/pl022.c         | 26 +--------------------
>  MAINTAINERS            |  2 ++
>  3 files changed, 54 insertions(+), 25 deletions(-)
>  create mode 100644 include/hw/ssi/pl022.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
