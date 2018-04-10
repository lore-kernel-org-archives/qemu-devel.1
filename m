Received: from eggs.gnu.org ([2001:4830:134:3::10]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5src-0004Yr-I0
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5sra-0005qp-1G
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:59:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5srZ-0005qj-QN
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:59:05 -0400
Date: Tue, 10 Apr 2018 08:59:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180410125904.GA22304@flamenco>
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-18-git-send-email-cota@braap.org>
	<37e6c5c3-dc83-c557-658a-901485e20e19@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37e6c5c3-dc83-c557-658a-901485e20e19@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 17/17] target/riscv: convert to
 TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Tue, Apr 10, 2018 at 11:24:37 +1000, Richard Henderson wrote:
> On 04/07/2018 04:20 AM, Emilio G. Cota wrote:
> > +        next_page = (ctx->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> > +        if (ctx->base.pc_next >= next_page) {
> 
> This fails for the last page of the address space.
> Better is
> 
>   page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
>   if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE) {

Apart from the variable name change, I fail to see how this (A - B >= C)
is not equivalent to the above (A => B + C). What am I missing?

Thanks,

		Emilio
