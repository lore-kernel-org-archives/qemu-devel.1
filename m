Received: from eggs.gnu.org ([2001:4830:134:3::10]:34262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqkzV-0003WR-5z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqkzS-0004Yy-3d
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:32:45 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:40570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqkzR-0004YP-SC
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:32:42 -0500
Received: by mail-pl0-x243.google.com with SMTP id i6so11994532plt.7
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 11:32:41 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8410b0d4-5167-d51e-d508-df3000642806@linaro.org>
Date: Tue, 27 Feb 2018 11:32:37 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/19] target/arm: Define an IDAU interface
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

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> In v8M, the Implementation Defined Attribution Unit (IDAU) is
> a small piece of hardware typically implemented in the SoC
> which provides board or SoC specific security attribution
> information for each address that the CPU performs MPU/SAU
> checks on. For QEMU, we model this with a QOM interface which
> is implemented by the board or SoC object and connected to
> the CPU using a link property.
> 
> This commit defines the new interface class, adds the link
> property to the CPU object, and makes the SAU checking
> code call the IDAU interface if one is present.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> An example of an object that implements the IDAU can be
> found in the later patch "hw/arm/iotkit: Model Arm IOT Kit".
> ---
>  target/arm/cpu.h    |  3 +++
>  target/arm/idau.h   | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu.c    | 15 +++++++++++++
>  target/arm/helper.c | 28 +++++++++++++++++++++---
>  4 files changed, 104 insertions(+), 3 deletions(-)
>  create mode 100644 target/arm/idau.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
