Received: from eggs.gnu.org ([209.51.188.92]:36558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJiEr-0001Cg-PI
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJiEq-00085G-5e
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:32:49 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:37493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJiEp-00082w-R4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:32:48 -0400
Received: by mail-pg1-x532.google.com with SMTP id e6so192138pgc.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:32:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20190425172636.11128-1-richard.henderson@linaro.org>
	<20190425172636.11128-3-richard.henderson@linaro.org>
Message-ID: <03ac8b9b-20ae-e6ec-5647-f679471f4d3b@linaro.org>
Date: Thu, 25 Apr 2019 10:32:43 -0700
MIME-Version: 1.0
In-Reply-To: <20190425172636.11128-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/riscv: Add checks for several
 RVC reserved operands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: palmer@sifive.com

On 4/25/19 10:26 AM, Richard Henderson wrote:
>  {
> +  illegal         011 0  -----  00000 01 # c.addi16sp, RES nzimm=0
>    addi            011 .  00010  ..... 01 @c_addi16sp
>    lui             011 .  .....  ..... 01 @c_lui
>  }

Bah.  I just realized the comment should be more like

  # c.addi16sp and c.lui, RES nzimm=0

Otherwise one is led to believe that rd=2 is missing
from the illegal pattern.


r~
