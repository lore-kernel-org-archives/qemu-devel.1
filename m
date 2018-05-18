Received: from eggs.gnu.org ([2001:4830:134:3::10]:44094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJWBA-0000mU-6b
	for qemu-devel@nongnu.org; Thu, 17 May 2018 23:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJWB6-0001r6-91
	for qemu-devel@nongnu.org; Thu, 17 May 2018 23:35:40 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJWB6-0001qm-2B
	for qemu-devel@nongnu.org; Thu, 17 May 2018 23:35:36 -0400
Received: by mail-pg0-x242.google.com with SMTP id v7-v6so2722343pgs.0
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 20:35:35 -0700 (PDT)
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-5-richard.henderson@linaro.org>
	<CAHNT7NuEQWdG8hxvGpJDCVk3RN=S=CVznM7xXyQm-S6D4FshfQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c3a91f2-516d-7ca8-bdb5-99bbc37a0c1e@linaro.org>
Date: Thu, 17 May 2018 20:35:31 -0700
MIME-Version: 1.0
In-Reply-To: <CAHNT7NuEQWdG8hxvGpJDCVk3RN=S=CVznM7xXyQm-S6D4FshfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/9] target/riscv: Introduce
 cpu_riscv_get_fcsr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 05/17/2018 07:46 PM, Michael Clark wrote:
> 
> 
> On Fri, May 11, 2018 at 3:52 PM, Richard Henderson
> <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> wrote:
> 
>     Cc: Michael Clark <mjc@sifive.com <mailto:mjc@sifive.com>>
>     Cc: Palmer Dabbelt <palmer@sifive.com <mailto:palmer@sifive.com>>
>     Cc: Sagar Karandikar <sagark@eecs.berkeley.edu
>     <mailto:sagark@eecs.berkeley.edu>>
>     Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de
>     <mailto:kbastian@mail.uni-paderborn.de>>
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
> 
> 
> I'm not against this change but it conflicts with changes in the riscv repo. I
> should post my patch queue to the list...

Ok, I'll drop this for now, and the dump of the FCSR in the next patch.
To be revisited once your csr reorg is upstream...


r~
