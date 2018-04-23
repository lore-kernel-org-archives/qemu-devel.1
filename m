Received: from eggs.gnu.org ([2001:4830:134:3::10]:59699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAh9Z-0001cy-37
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAh9U-00077s-CP
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:29:33 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:43567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fAh9U-00077F-5k
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:29:28 -0400
Received: by mail-pg0-x241.google.com with SMTP id f132so9049298pgc.10
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 12:29:27 -0700 (PDT)
References: <20180423123225.30503-1-edgar.iglesias@gmail.com>
	<20180423123225.30503-2-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <28c944cc-49a3-c713-eff9-b51d42b49d26@linaro.org>
Date: Mon, 23 Apr 2018 09:29:22 -1000
MIME-Version: 1.0
In-Reply-To: <20180423123225.30503-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] target-microblaze: Respect MSR.PVR
 as read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

On 04/23/2018 02:32 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Respect MSR.PVR as read-only. We were wrongly overwriting the PVR bit.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
