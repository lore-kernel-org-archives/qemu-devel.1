Received: from eggs.gnu.org ([209.51.188.92]:33450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBSk-0005yG-06
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBSU-0003TI-IJ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:04:28 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:35281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBST-0003QS-La
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:04:25 -0500
Received: by mail-pf1-x436.google.com with SMTP id z9so5461704pfi.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:04:24 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4d332284-1598-8d8e-d95a-16eb14e3bd6f@linaro.org>
Date: Fri, 25 Jan 2019 16:04:21 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/23] hw/misc/iotkit-secctl: Support 4
 internal MPCs
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
> The SSE-200 has 4 banks of SRAM, each with its own internal
> Memory Protection Controller. The interrupt status for these
> extra MPCs appears in the same security controller SECMPCINTSTATUS
> register as the MPC for the IoTKit's single SRAM bank. Enhance the
> iotkit-secctl device to allow 4 MPCs. (If the particular IoTKit/SSE
> variant in use does not have all 4 MPCs then the unused inputs will
> simply result in the SECMPCINTSTATUS bits being zero as required.)
> 
> The hardcoded constant "1"s in armsse.c indicate the actual number
> of SRAM MPCs the IoTKit has, and will be replaced in the following
> commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/misc/iotkit-secctl.h | 6 +++---
>  hw/arm/armsse.c                 | 6 +++---
>  hw/misc/iotkit-secctl.c         | 5 +++--
>  3 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
