Received: from eggs.gnu.org ([209.51.188.92]:58801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBmG-000250-LS
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBmF-00020A-S7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:24:52 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBmF-0001yl-M6
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:24:51 -0500
Received: by mail-pf1-x444.google.com with SMTP id 64so5463544pfr.9
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:24:51 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <330788d1-5947-407d-fa78-897e0f00f149@linaro.org>
Date: Fri, 25 Jan 2019 16:24:47 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/23] hw/arm/armsse: Give each CPU its own
 view of memory
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
> Give each CPU its own container memory region. This is necessary
> for two reasons:
>  * some devices are instantiated one per CPU and the CPU sees only
>    its own device
>  * since a memory region can only be put into one container, we must
>    give each armv7m object a different MemoryRegion as its 'memory'
>    property, or a dual-CPU configuration will assert on realize when
>    the second armv7m object tries to put the MR into a container when
>    it is already in the first armv7m object's container
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h | 10 ++++++++++
>  hw/arm/armsse.c         | 22 ++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
