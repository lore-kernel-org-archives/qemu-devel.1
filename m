Received: from eggs.gnu.org ([2001:4830:134:3::10]:52127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqo4b-0006tK-8r
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqo4W-0004E6-9u
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:50:13 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqo4W-0004Dc-36
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:50:08 -0500
Received: by mail-pl0-x244.google.com with SMTP id u13-v6so301654plq.1
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:50:07 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-20-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50272633-16d0-7e63-4ca2-1402f0449989@linaro.org>
Date: Tue, 27 Feb 2018 14:50:04 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/19] mps2-an505: New board model: MPS2
 with AN505 Cortex-M33 FPGA image
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
> Define a new board model for the MPS2 with an AN505 FPGA image
> containing a Cortex-M33. Since the FPGA images for TrustZone
> cores (AN505, and the similar AN519 for Cortex-M23) have a
> significantly different layout of devices to the non-TrustZone
> images, we use a new source file rather than shoehorning them
> into the existing mps2.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/Makefile.objs |   1 +
>  hw/arm/mps2-tz.c     | 504 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 505 insertions(+)
>  create mode 100644 hw/arm/mps2-tz.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
