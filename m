Received: from eggs.gnu.org ([2001:4830:134:3::10]:43616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fEq4C-0004A3-CF
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fEq49-0001mP-91
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:49:08 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fEq49-0001la-2u
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:49:05 -0400
Received: by mail-pg0-x243.google.com with SMTP id z129-v6so12613748pgz.3
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 22:49:04 -0700 (PDT)
Date: Sat, 5 May 2018 14:49:01 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180505054901.GO4501@lianli.shorne-pla.net>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504054030.24527-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/13] target/openrisc: Convert to
 decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Thu, May 03, 2018 at 10:40:17PM -0700, Richard Henderson wrote:
> While the openrisc decode isn't particularly complicated,
> the result, I think, is still cleaner.

Hi Richard,

I agree this does look clean, thanks for doing this.

I reviewed all and everything seems good, do you plan to send the PR during the
merge window?

-Stafford

> 
> r~
> 
> 
> Richard Henderson (13):
>   target-openrisc: Write back result before FPE exception
>   target/openrisc: Start conversion to decodetree.py
>   target/openrisc: Convert branch insns
>   target/openrisc: Convert memory insns
>   target/openrisc: Convert remainder of dec_misc insns
>   target/openrisc: Convert dec_calc
>   target/openrisc: Convert dec_mac
>   target/openrisc: Convert dec_logic
>   target/openrisc: Convert dec_M
>   target/openrisc: Convert dec_comp
>   target/openrisc: Convert dec_compi
>   target/openrisc: Convert dec_float
>   target/openrisc: Merge disas_openrisc_insn
> 
>  target/openrisc/helper.h      |   25 +-
>  target/openrisc/fpu_helper.c  |  250 ++----
>  target/openrisc/translate.c   | 1847 +++++++++++++++++++----------------------
>  target/openrisc/Makefile.objs |    9 +
>  target/openrisc/insns.decode  |  189 +++++
>  5 files changed, 1110 insertions(+), 1210 deletions(-)
>  create mode 100644 target/openrisc/insns.decode
> 
> -- 
> 2.14.3
> 
