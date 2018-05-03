Received: from eggs.gnu.org ([2001:4830:134:3::10]:47323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIdG-0004BX-Gj
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIdC-0001QT-J4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:07:06 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEIdC-0001QH-D1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:07:02 -0400
Received: by mail-pg0-x244.google.com with SMTP id e1-v6so2327550pga.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:07:02 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-8-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <52b5d71b-696f-62df-ef24-89c387ecb638@linaro.org>
Date: Thu, 3 May 2018 11:06:58 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-8-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/29] target-microblaze: Tighten up
 TCGv_i32 vs TCGv type usage
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

On 05/03/2018 02:19 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Tighten up TCGv_i32 vs TCGv type usage. Avoid using TCGv when
> TCGv_i32 should be used.
> 
> This is in preparation for adding 64bit addressing support.
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/helper.c    |   2 +-
>  target/microblaze/translate.c | 581 +++++++++++++++++++++---------------------
>  2 files changed, 295 insertions(+), 288 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
