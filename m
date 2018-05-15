Received: from eggs.gnu.org ([2001:4830:134:3::10]:40337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIYpo-0006kc-Sq
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIYpk-0007pb-0t
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:13:40 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:44996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIYpj-0007p5-S6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:13:35 -0400
Received: by mail-ot0-x230.google.com with SMTP id g7-v6so18154331otj.11
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 05:13:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
References: <20180513090613.27960-1-sw@weilnetz.de>
	<cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 13:13:14 +0100
Message-ID: <CAFEAcA9kcKb28uQJOnqCAC4Gf9b7Hnu0wJbG1nHQLF4U1T9sKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] disas/libvixl: Fix VIXL_FALLTHROUGH macro
 for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 13 May 2018 at 10:57, Stefan Weil <sw@weilnetz.de> wrote:
> Even with the above patch, disas/libvixl raises a compiler warning for a
> fall through case. The patch below fixes that warning, but I am not sure
> whether a fall through is correct there.
>
> Stefan
>
>
> diff --git a/disas/libvixl/vixl/a64/disasm-a64.cc
> b/disas/libvixl/vixl/a64/disasm-a64.cc
> index 7a58a5c087..5481d94209 100644
> --- a/disas/libvixl/vixl/a64/disasm-a64.cc
> +++ b/disas/libvixl/vixl/a64/disasm-a64.cc
> @@ -2986,6 +2986,7 @@ int Disassembler::SubstituteImmediateField(const
> Instruction* instr,
>            return 3;
>          }
>        }
> +      VIXL_FALLTHROUGH(); // ???
>      }
>      case 'C': {  // ICondB - Immediate Conditional Branch.
>        int64_t offset = instr->ImmCondBranch() << 2;

This is fixed in upstream vixl, in fact:

https://git.linaro.org/arm/vixl.git/commit/?id=de326f850f736c3a337fda52845ed3d2e620cc02

thanks
-- PMM
