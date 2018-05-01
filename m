Received: from eggs.gnu.org ([2001:4830:134:3::10]:46674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDamC-0000ke-Eb
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDam7-0001l5-KA
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:17:24 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:46744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDam7-0001kr-E1
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:17:19 -0400
Received: by mail-pg0-x241.google.com with SMTP id z4-v6so8875906pgu.13
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 12:17:19 -0700 (PDT)
References: <20180427173611.10281-1-peter.maydell@linaro.org>
	<20180427173611.10281-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd534a43-88e4-2795-3c74-eefc3a6a7fe2@linaro.org>
Date: Tue, 1 May 2018 12:17:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180427173611.10281-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/net/smc91c111: Convert away from
 old_mmio
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

On 04/27/2018 10:36 AM, Peter Maydell wrote:
> Convert the smc91c111 device away from using the old_mmio field of
> MemoryRegionOps. This device is used by several Arm board models.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/net/smc91c111.c | 54 +++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
