Received: from eggs.gnu.org ([209.51.188.92]:40752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBtF-000505-PY
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBtF-0007VO-55
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:32:05 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBtE-0007Us-Us
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:32:05 -0500
Received: by mail-pl1-x644.google.com with SMTP id gn14so5271514plb.10
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:32:04 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <99e500e6-d839-6870-7737-65487887b474@linaro.org>
Date: Fri, 25 Jan 2019 16:32:01 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/23] iotkit-sysinfo: Make SYS_VERSION and
 SYS_CONFIG configurable
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
> The SYS_VERSION and SYS_CONFIG register values differ between the
> IoTKit and SSE-200. Make them configurable via QOM properties rather
> than hard-coded, and set them appropriately in the ARMSSE code that
> instantiates the IOTKIT_SYSINFO device.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/misc/iotkit-sysinfo.h |  6 ++++
>  hw/arm/armsse.c                  | 51 ++++++++++++++++++++++++++++++++
>  hw/misc/iotkit-sysinfo.c         | 15 ++++++++--
>  3 files changed, 70 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
