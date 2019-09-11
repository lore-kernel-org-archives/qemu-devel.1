Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A7EC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1003E207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1003E207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84V2-0004dP-9C
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i84NL-0006S0-HK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i84NK-0003ZM-B1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:17:43 -0400
Received: from nsstlmta09p.bpe.bigpond.com ([203.38.21.9]:47414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i84NJ-0003VR-Mp
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:17:42 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep09p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190911151733.HBCD24695.nsstlfep09p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Thu, 12 Sep 2019 01:17:33 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepihhmrggtrdhlohgtrghlpdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoehmrghrkhdrtggrvhgvqdgrhihlrghnugesihhlrghnuggvrdgtohdruhhkqedprhgtphhtthhopeeophgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from imac.local (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D36929213D109F6; Thu, 12 Sep 2019 01:17:33 +1000
Date: Thu, 12 Sep 2019 01:17:25 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190911151725.GA15659@imac.local>
References: <20190911014353.5926-1-richard.henderson@linaro.org>
 <20190911014353.5926-3-richard.henderson@linaro.org>
 <20190911105509.GA42643@imac.local>
 <299a576c-0264-95d2-e2fe-4dee41d87039@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299a576c-0264-95d2-e2fe-4dee41d87039@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.9
Subject: Re: [Qemu-devel] [PATCH 2/3] cputlb: Replace switches in
 load/store_helper with callback
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 09:22:39AM -0400, Richard Henderson wrote:
> I would be hesitant to call this just "lduw_be"; I think that's confusing when
> it's calling lduw_be_p.  But perhaps "wrap_*" or "wide_*"?

Agree, some hamming distance is needed.

"wrap_*", "wide_*", or "direct_*" all works for me.

