Received: from eggs.gnu.org ([2001:4830:134:3::10]:46772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5i1j-0003u3-3d
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 21:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5i1i-0005ye-3J
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 21:24:51 -0400
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:36687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5i1h-0005xJ-S9
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 21:24:50 -0400
Received: by mail-pl0-x233.google.com with SMTP id 91-v6so6330136pld.3
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 18:24:49 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-18-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <37e6c5c3-dc83-c557-658a-901485e20e19@linaro.org>
Date: Tue, 10 Apr 2018 11:24:37 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-18-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 04/07/2018 04:20 AM, Emilio G. Cota wrote:
> +        next_page = (ctx->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> +        if (ctx->base.pc_next >= next_page) {

This fails for the last page of the address space.
Better is

  page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
  if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE) {


r~
