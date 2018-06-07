Received: from eggs.gnu.org ([2001:4830:134:3::10]:43637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fR1Tk-0008L7-L4
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fR1Th-0005iP-GK
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:25:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46291)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fR1Th-0005ak-59
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:25:49 -0400
References: <20180512050250.12774-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d60e896c-472e-f2e4-e02f-cbb3bc185156@vivier.eu>
Date: Thu, 7 Jun 2018 22:25:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180512050250.12774-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1.1 0/9] target/m68k: Convert to
 TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 12/05/2018 à 07:02, Richard Henderson a écrit :
> [ Ho, hum.  I didn't clear out my scratch directory before sending v1.0. ]
> 
> FYI, I've only tested this with linux-user-test-0.3 and
> our qemu coldfire testing kernel.
> 
> 
> r~
> 
> 
> Richard Henderson (9):
>   target/m68k: Use DISAS_NORETURN for exceptions
>   target/m68k: Replace DISAS_TB_JUMP with DISAS_NORETURN
>   target/m68k: Remove DISAS_JUMP_NEXT as unused
>   target/m68k: Use lookup_and_goto_tb for DISAS_JUMP
>   target/m68k: Rename DISAS_UPDATE and gen_lookup_tb
>   target/m68k: Convert to DisasContextBase
>   target/m68k: Convert to TranslatorOps
>   target/m68k: Improve ending TB at page boundaries
>   target/m68k: Merge disas_m68k_insn into m68k_tr_translate_insn
> 
>  target/m68k/translate.c | 354 ++++++++++++++++++++--------------------
>  1 file changed, 179 insertions(+), 175 deletions(-)
> 

Richard,

do you want I take this through my m68k tree or do you take this in a
TCG pull requests?

Thanks,
Laurent
