Received: from eggs.gnu.org ([2001:4830:134:3::10]:53990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ5o-0000gT-FS
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ5l-0002T2-Kt
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:00:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:33255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBQ5l-0002ST-EE
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:00:53 -0400
Received: by mail-pg1-x52e.google.com with SMTP id y18-v6so7361049pge.0
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 13:00:52 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-27-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <523d3679-2361-cf8d-d854-18cee6018d92@linaro.org>
Date: Sat, 13 Oct 2018 13:00:48 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-27-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 26/28] target/riscv: Remove gen_system()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
> with all 16 bit insns moved to decodetree no path is falling back to
> gen_system(), so we can remove it.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
>  target/riscv/translate.c | 32 --------------------------------
>  1 file changed, 32 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
