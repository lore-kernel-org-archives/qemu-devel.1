Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F132C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3458F2339D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3458F2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5OcY-0002U8-99
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 02:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i5ObV-0001qa-UN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i5ObU-0007S6-9D
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:17:17 -0400
Received: from nsstlmta14p.bpe.bigpond.com ([203.38.21.14]:43983)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i5ObT-0007Pf-LV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:17:16 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep14p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190904061706.BQYB1555.nsstlfep14p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Wed, 4 Sep 2019 16:17:06 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudejgedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopehimhgrtgdrlhhotggrlhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeophgsohhniihinhhisehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeorhhthhesthifihguughlvgdrnhgvtheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from imac.local (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D35814411396316; Wed, 4 Sep 2019 16:17:06 +1000
Date: Wed, 4 Sep 2019 16:17:01 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190904061701.GA95308@imac.local>
References: <20190902012647.1761-1-tony.nguyen@bt.com>
 <CAFEAcA-4Tpa4qTCBXMTX+1n3fDK48d3ZFYn5CckOD7weqAWrcA@mail.gmail.com>
 <20190903164712.GA85777@imac.local>
 <CAFEAcA-FAJV1XEAZ7bcrstOWPv6wpAuZ4WjVo8bf+ewiWQYopA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-FAJV1XEAZ7bcrstOWPv6wpAuZ4WjVo8bf+ewiWQYopA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.14
Subject: Re: [Qemu-devel] [PATCH] memory: Set notdirty_mem_ops validator
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 05:50:56PM +0100, Peter Maydell wrote:
> Do you have a backtrace of QEMU from the segfault? I'm having trouble
> thinking of what the situation is when we'd try to invoke the
> read handler on io_mem_notdirty...

Using tcg-next https://github.com/rth7680/qemu/commit/c25c283df0f08582df29f1d5d7be1516b851532d.

#0  0x0000000000000000 in  ()
#1  0x000055a694329099 in memory_region_read_with_attrs_accessor (mr=0x55a69503c6c0 <io_mem_notdirty>, addr=3874654208, value=0x7fdac32c40e8, size=4, shift=0, mask=4294967295, attrs=...)
    at /home/tony/dev/qemu/memory.c:461
#2  0x000055a6943293fd in access_with_adjusted_size (addr=3874654208, value=0x7fdac32c40e8, size=4, access_size_min=1, access_size_max=8, access_fn=
    0x55a69432903d <memory_region_read_with_attrs_accessor>, mr=0x55a69503c6c0 <io_mem_notdirty>, attrs=...) at /home/tony/dev/qemu/memory.c:559
#3  0x000055a69432c239 in memory_region_dispatch_read1 (mr=0x55a69503c6c0 <io_mem_notdirty>, addr=3874654208, pval=0x7fdac32c40e8, size=4, attrs=...) at /home/tony/dev/qemu/memory.c:1429
#4  0x000055a69432c2c9 in memory_region_dispatch_read (mr=0x55a69503c6c0 <io_mem_notdirty>, addr=3874654208, pval=0x7fdac32c40e8, op=MO_32, attrs=...) at /home/tony/dev/qemu/memory.c:1451
#5  0x000055a694341e4f in io_readx (env=0x55a695942da0, iotl=0x7fdabcdee440, mmu_idx=2, addr=3298570569728, retaddr=140577648555520, access_type=MMU_DATA_LOAD, op=MO_32)
    at /home/tony/dev/qemu/accel/tcg/cputlb.c:923
#6  0x000055a69434493e in full_be_ldul_mmu (full_load=0x55a69434458a <full_be_ldul_mmu>, code_read=false, op=MO_BEUL, retaddr=140577648555520, oi=162, addr=3298570569728, env=0x55a695942da0)
    at /home/tony/dev/qemu/accel/tcg/cputlb.c:1346
#7  0x000055a69434493e in full_be_ldul_mmu (env=0x55a695942da0, addr=3298570569728, oi=162, retaddr=140577648555520) at /home/tony/dev/qemu/accel/tcg/cputlb.c:1469
#8  0x000055a694344bd5 in helper_be_ldul_mmu (env=0x55a695942da0, addr=3298570569728, oi=162, retaddr=140577648555520) at /home/tony/dev/qemu/accel/tcg/cputlb.c:1476
#9  0x00007fdac8ce3639 in  ()
#10 0x0000000004000000 in  ()
#11 0x00007fdabc000a10 in  ()
#12 0x00007fdac32c42a0 in  ()
#13 0x000055a6942d8795 in tcg_temp_free_internal (ts=0x7fdabc0652e0)
    at /home/tony/dev/qemu/tcg/tcg.c:1330

In frame 5 iotlbentry->addr is 18446740779013636097. Perhaps not a sane value?

Defines in target/sparc/cpu-params.h and include/exec/cpu-all.h:
TARGET_PAGE_BITS 13
TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)

iotlb_to_section resolves (iotlbentry->addr & ~TARGET_PAGE_MASK) to 1,
which is io_mem_notdirty.

(gdb) frame 5
#5  0x000055a694341e4f inv=0x55a695942da0, iotlbentry=0x7fdabcdee440, mmu_idx=2, 
    addr=3298570569728, retaddr=140577648555520, access_type=MMU_DATA_LOAD, op=MO_32)
    at /home/tony/dev/qemu/accel/tcg/cputlb.c:923
(gdb) print iotlbentry->addr
$1 = 18446740779013636097
(gdb) print iotlbentry->attrs
$2 = {unspecified = 0, secure = 0, user = 0, requester_id = 0, byte_swap = 1, 
  target_tlb_bit0 = 0, target_tlb_bit1 = 0, target_tlb_bit2 = 0}
(gdb) print cpu->cpu_ases[0]->memory_dispatch->map.sections[1]
$3 = {mr = 0x55a69503c6c0 <io_mem_notdirty>, fv = 0x7fdabc86ca00, offset_within_region = 0, 
  size = 0x00000000000000010000000000000000, offset_within_address_space = 0, 
  readonly = false, nonvolatile = false}

Watching sun4u Solaris 10 boot messages, it occurs when sunhme PCI device is
configured.

