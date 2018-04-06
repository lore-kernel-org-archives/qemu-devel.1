Received: from eggs.gnu.org ([2001:4830:134:3::10]:33544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4Qju-0003An-5c
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4Qjq-0001C8-4e
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:45:10 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:55282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f4Qjp-0001As-Ky
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:45:06 -0400
References: <20180217203132.31780-1-richard.henderson@linaro.org>
	<20180217203132.31780-3-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <db140efc-6ba3-4609-1002-ab5e85424cb9@mail.uni-paderborn.de>
Date: Fri, 6 Apr 2018 14:45:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180217203132.31780-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/19] target/hppa: Begin using
 scripts/decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 02/17/2018 09:31 PM, Richard Henderson wrote:
> Convert the BREAK instruction to start.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c   | 14 +++++++++++---
>  target/hppa/Makefile.objs |  8 ++++++++
>  target/hppa/insns.decode  | 24 ++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 3 deletions(-)
>  create mode 100644 target/hppa/insns.decode
> 
[...]
> +#
> +
> +####
> +# System
> +####
> +
> +break		000000 ----- ----- --- 00000000 -----
> 

Why are the im13 and im5 fields don't care? Is nobody using them?

Other than that,
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
