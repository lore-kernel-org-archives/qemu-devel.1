Received: from eggs.gnu.org ([2001:4830:134:3::10]:57140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gG9Tq-0006d2-Fv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 17:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gG9Tl-0004Q2-Hd
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 17:17:18 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:33964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gG9Tl-0004O5-8m
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 17:17:13 -0400
Date: Fri, 26 Oct 2018 23:17:08 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181026211708.GA22187@sx9>
References: <1540586148-11285-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1540586148-11285-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] target/mips: Rename MMI-related code
 elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, juergenurban@gmx.de, "Maciej W. Rozycki" <macro@linux-mips.org>

Hi Aleksandar,

> This series renames MMI-related code elements so that they do not
> contain TX79 substring. Tx79 is one of CPUs that support MMI ASE.
> Opcodes and other code elements should be as generic as possible,
> and should not contain CPU name if they are supported by multiple
> CPUs. In cases when there is a single-CPU-specific opcode, an
> anoter special convention should apply, like, for example,
> MMI_OPC__TX79_XXX or MMI_OPC__R5900_YYY. So far these cases were
> not identified, but there will be some in the future. But overall,
> the great MMI opcodes are shared (stay the same) between different
> CPUs that support MMI.
> 
> Aleksandar Markovic (3):
>   target/mips: Rename MMI-related masks
>   target/mips: Rename MMI-related opcodes
>   target/mips: Rename MMI-related functions
> 
>  target/mips/translate.c | 518 ++++++++++++++++++++++++------------------------
>  1 file changed, 259 insertions(+), 259 deletions(-)

This is interesting. Could you name a few other ISAs, beside the R5900
and the TX79, that have 128-bit GPRs and equivalent MMIs?

Fredrik
