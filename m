Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2D9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C418122CED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C418122CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Bzm-0004k1-IV
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i5Bxl-0002d8-HN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i5Bxk-0008PQ-1C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:47:24 -0400
Received: from nsstlmta03p.bpe.bigpond.com ([203.38.21.3]:35742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i5Bxj-0008Hi-CJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:47:23 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep03p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190903164716.YPTR11604.nsstlfep03p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Wed, 4 Sep 2019 02:47:16 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudejfedgjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftpgfvgffnuffvtfetpdfqfgfvnecuuegrihhlohhuthemucegtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopehimhgrtgdrlhhotggrlhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeophgsohhniihinhhisehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeorhhthhesthifihguughlvgdrnhgvtheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from imac.local (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D35814410F9DB06; Wed, 4 Sep 2019 02:47:16 +1000
Date: Wed, 4 Sep 2019 02:47:12 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190903164712.GA85777@imac.local>
References: <20190902012647.1761-1-tony.nguyen@bt.com>
 <CAFEAcA-4Tpa4qTCBXMTX+1n3fDK48d3ZFYn5CckOD7weqAWrcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-4Tpa4qTCBXMTX+1n3fDK48d3ZFYn5CckOD7weqAWrcA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.3
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

On Tue, Sep 03, 2019 at 11:25:28AM +0100, Peter Maydell wrote:
> On Mon, 2 Sep 2019 at 02:36, Tony Nguyen <tony.nguyen@bt.com> wrote:
> >
> > Existing read rejecting validator was mistakenly cleared.
> >
> > Reads dispatched to io_mem_notdirty then segfaults as there is no read
> > handler.
> 
> Do you have the commit hash for where we introduced the
> bug that this is fixing?
> 
> thanks
> -- PMM
> 

ad52878f97610757390148fe5d5b4cc5ad15c585.

Please feel free to amend my commit message.

I do not understand why sun4u booting Solaris 10 triggers the bug.

