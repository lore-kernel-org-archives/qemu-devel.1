Received: from eggs.gnu.org ([2001:4830:134:3::10]:60315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAhBf-00031X-Ve
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAhBf-0000B4-CT
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:31:43 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fAhBf-0000Ac-6K
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:31:43 -0400
Received: by mail-pf0-x242.google.com with SMTP id g14so10136468pfh.3
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 12:31:43 -0700 (PDT)
References: <20180423123225.30503-1-edgar.iglesias@gmail.com>
	<20180423123225.30503-4-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03befefe-a110-ba84-1865-d41bc32e8f3a@linaro.org>
Date: Mon, 23 Apr 2018 09:31:38 -1000
MIME-Version: 1.0
In-Reply-To: <20180423123225.30503-4-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target-microblaze: Don't clobber
 the IMM reg for ld/st reversed
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
> Do not clobber the IMM register on reversed load/stores.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
