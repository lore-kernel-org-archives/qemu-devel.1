Received: from eggs.gnu.org ([2001:4830:134:3::10]:37139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEJNS-0001qh-Js
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEJNP-0001Qp-IE
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:54:50 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:40618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEJNP-0001QY-B5
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:54:47 -0400
Received: by mail-pg0-x229.google.com with SMTP id l2-v6so13746982pgc.7
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:54:47 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-19-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <18e5289e-5dea-5dfa-4570-879b6d3d711e@linaro.org>
Date: Thu, 3 May 2018 11:54:43 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-19-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 18/29] target-microblaze: dec_msr: Reuse
 more code when reg-decoding
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
> Reuse more code when decoding register numbers.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
