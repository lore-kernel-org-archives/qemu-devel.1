Received: from eggs.gnu.org ([2001:4830:134:3::10]:42192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWQj-0005PP-Kp
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWQg-0007jM-6P
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:15:21 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:40596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGWQf-0007j8-Vg
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:15:18 -0400
Received: by mail-pg0-x230.google.com with SMTP id l2-v6so23209744pgc.7
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 14:15:17 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-29-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a50ca9bb-377f-5736-5012-ddde6bfdc305@linaro.org>
Date: Wed, 9 May 2018 14:15:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-29-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 28/36] target-microblaze: Add support
 for extended access to TLBLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 05/08/2018 10:31 AM, Edgar E. Iglesias wrote:
> +        if (to) {
> +            gen_helper_mmu_write(cpu_env, tcg_const_i32(extended),
> +                                 tcg_const_i32(sr), cpu_R[dc->ra]);
> +        } else {
> +            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env,
> +                                tcg_const_i32(extended), tcg_const_i32(sr));
> +        }

These tcg_const_i32 results should be tcg_temp_free'd.


r~
