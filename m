Received: from eggs.gnu.org ([2001:4830:134:3::10]:39146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqnCq-0005HP-MA
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqnCn-0003ZD-MP
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:54:40 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:45837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqnCn-0003Yj-GH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:54:37 -0500
Received: by mail-pg0-x244.google.com with SMTP id i133so125692pgc.12
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 13:54:37 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8b67df9c-c88f-8e72-8a67-a74f7b518975@linaro.org>
Date: Tue, 27 Feb 2018 13:54:33 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/19] hw/misc/iotkit-secctl: Add handling
 for PPCs
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
> The IoTKit Security Controller includes various registers
> that expose to software the controls for the Peripheral
> Protection Controllers in the system. Implement these.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/misc/iotkit-secctl.h |  64 +++++++++-
>  hw/misc/iotkit-secctl.c         | 270 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 315 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
