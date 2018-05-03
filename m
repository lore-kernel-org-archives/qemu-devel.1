Received: from eggs.gnu.org ([2001:4830:134:3::10]:50288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIjl-0006Aq-9R
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIji-0004al-3U
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:13:49 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEIjh-0004aZ-Rl
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:13:46 -0400
Received: by mail-pf0-x244.google.com with SMTP id f189so15352290pfa.7
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:13:45 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-12-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <436d18c9-0237-2e73-9312-5ae718ff259a@linaro.org>
Date: Thu, 3 May 2018 11:13:41 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-12-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 11/29] target-microblaze: Make
 compute_ldst_addr always use a temp
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
> -static inline TCGv_i32 *compute_ldst_addr(DisasContext *dc, TCGv_i32 *t)
> +static inline void compute_ldst_addr(DisasContext *dc, TCGv_i32 *t)

You probably also want to remove the indirection,
since you now never assign to *t.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
