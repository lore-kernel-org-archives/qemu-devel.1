Received: from eggs.gnu.org ([209.51.188.92]:47604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBGg-0001oj-GT
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBGf-0003PH-JI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:52:14 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBGf-0003DI-CV
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:52:13 -0500
Received: by mail-pf1-x441.google.com with SMTP id q1so5444643pfi.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 15:52:03 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6450b05-e2ed-2918-79b4-73492e8f2a72@linaro.org>
Date: Fri, 25 Jan 2019 15:52:00 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/23] hw/arm/iotkit: Refactor into
 abstract base class and subclass
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
> The Arm SSE-200 Subsystem for Embedded is a revised and
> extended version of the older IoTKit SoC. Prepare for
> adding a model of it by refactoring the IoTKit code into
> an abstract base class which contains the functionality,
> driven by a class data block specific to each subclass.
> (This is the same approach used by the existing bcm283x
> SoC family implementation.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/iotkit.h | 22 +++++++++++++++++-----
>  hw/arm/iotkit.c         | 34 +++++++++++++++++++++++++++++-----
>  2 files changed, 46 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
