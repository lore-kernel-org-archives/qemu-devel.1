Received: from eggs.gnu.org ([2001:4830:134:3::10]:48154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJMpO-0000wQ-0F
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJMpK-0004wc-2e
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:36:34 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:36930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJMpJ-0004wN-Gz
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:36:30 -0400
Received: by mail-pl0-x241.google.com with SMTP id w19-v6so2954757plq.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:36:29 -0700 (PDT)
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-37-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7439427-8eeb-68de-01e3-ae53f279cf12@linaro.org>
Date: Thu, 17 May 2018 10:36:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-37-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 36/38] target-microblaze: Use
 tcg_gen_movcond in eval_cond_jmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 05/16/2018 11:51 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Cleanup eval_cond_jmp to use tcg_gen_movcond_i64().
> No functional change.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
