Received: from eggs.gnu.org ([209.51.188.92]:41928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBBe-0008LJ-HF
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBBd-0007Gu-Ga
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:47:02 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBBb-00077y-5j
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:47:01 -0500
Received: by mail-pf1-x441.google.com with SMTP id b7so5435095pfi.8
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 15:46:44 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72897470-f9ca-aa8f-679f-ea5f11c54265@linaro.org>
Date: Fri, 25 Jan 2019 15:46:40 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/23] hw/arm/iotkit: Rename IoTKit to
 ARMSSE
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

On 1/21/19 10:50 AM, Peter Maydell wrote:
> The Arm IoTKit was effectively the forerunner of a series of
> subsystems for embedded SoCs, named the SSE-050, SSE-100 and SSE-200:
> https://developer.arm.com/products/system-design/subsystems
> These are generally quite similar, though later iterations have
> extra devices that earlier ones do not.
> 
> We want to add a model of the SSE-200, which means refactoring the
> IoTKit code into an abstract base class and subclasses (using the
> same design that the bcm283x SoC and Aspeed SoC family
> implementations do). As a first step, rename the IoTKit struct and
> QOM macros to ARMSSE, which is what we're going to name the base
> class. We temporarily retain TYPE_IOTKIT to avoid changing the
> code that instantiates a TYPE_IOTKIT device here and then changing
> it back again when it is re-introduced as a subclass.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/iotkit.h | 22 ++++++++++-----
>  hw/arm/iotkit.c         | 59 +++++++++++++++++++++--------------------
>  hw/arm/mps2-tz.c        |  2 +-
>  3 files changed, 47 insertions(+), 36 deletions(-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
