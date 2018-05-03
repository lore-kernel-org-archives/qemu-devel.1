Received: from eggs.gnu.org ([2001:4830:134:3::10]:44463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIWt-0000VW-Rp
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIWp-0006f1-DE
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:00:31 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEIWp-0006dp-1h
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:00:27 -0400
Received: by mail-pg0-x244.google.com with SMTP id i194-v6so13668334pgd.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:00:26 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-3-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2f0c4c5a-e0e7-48b7-8fbe-0017e0678d55@linaro.org>
Date: Thu, 3 May 2018 11:00:23 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 02/29] target-microblaze: dec_store: Use
 bool instead of unsigned int
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

On 05/03/2018 02:18 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Use bool instead of unsigned int to represent flags.
> Also, use extract32 instead of open coding the bit extract.
> 
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
