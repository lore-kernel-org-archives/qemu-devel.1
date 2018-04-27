Received: from eggs.gnu.org ([2001:4830:134:3::10]:34767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fC7Yn-0003jF-LG
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fC7Ym-0006kE-Qu
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:53:29 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fC7Ym-0006iL-L7
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:53:28 -0400
Received: by mail-pf0-x244.google.com with SMTP id a14so2009073pfi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 10:53:28 -0700 (PDT)
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-6-richard.henderson@linaro.org>
	<CAHNT7NujtwKtCtsxG91DtgriDd2sjVZwyqKhAp03LR=eJjdMtQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45076b60-a2d2-281a-3c85-6c21d87a49ff@linaro.org>
Date: Fri, 27 Apr 2018 07:53:05 -1000
MIME-Version: 1.0
In-Reply-To: <CAHNT7NujtwKtCtsxG91DtgriDd2sjVZwyqKhAp03LR=eJjdMtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] target/riscv: Use new atomic min/max
 expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Emilio G. Cota" <cota@braap.org>

On 04/26/2018 09:24 PM, Michael Clark wrote:
> 
> 
> On Fri, Apr 27, 2018 at 12:26 PM, Richard Henderson
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
> Reviewed-by: Michael Clark <mjc@sifive.com <mailto:mjc@sifive.com>>
> 
> If you give me a remote I can pull into my local workspace and test. The change
> looks pretty straight-forward. There are tests for amos in riscv-tests but no
> parallel tests (i.e. contended case).

git://github.com/rth7680/qemu.git tgt-arm-atomic-2


r~
