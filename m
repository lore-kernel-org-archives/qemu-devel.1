Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B6DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6F7205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6F7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Z2j-0004VF-Rq
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 06:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i2Z0J-000358-EM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i2Z0G-0002N0-Lg
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:47:10 -0400
Received: from nsstlmta27p.bpe.bigpond.com ([203.38.21.27]:41403)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i2Z0F-0002F4-Ko; Tue, 27 Aug 2019 06:47:08 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep27p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190827104659.YENC27545.nsstlfep27p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Tue, 27 Aug 2019 20:46:59 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepihhmrggtrdhlohgtrghlpdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoegrrhhmsghruhesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeosggvrhhrrghnghgvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehfrghmsegvuhhphhhonhdrnhgvtheqpdhrtghpthhtohepoehkfiholhhfsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehmlhgvvhhithhskhesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeomhhrvghithiisehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehsthgvfhgrnhhhrgesrhgv
 ughhrghtrdgtohhmqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from imac.local (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3581440E3A0E39; Tue, 27 Aug 2019 20:46:59 +1000
Date: Tue, 27 Aug 2019 20:46:53 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190827104653.GA73303@imac.local>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-2-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826135103.22410-2-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.27
Subject: Re: [Qemu-devel] [PATCH v2 01/13] introduce g_autowipe
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Maxim,

On Mon, Aug 26, 2019 at 04:50:51PM +0300, Maxim Levitsky wrote:
> 2. is it portable enought for us to use malloc_usable_size
> to get the size of malloced pointer in the autofree callback?
> This function is aviable in glibc (but no wrapper in glib).

We will also need to consider host portability: malloc_usable_size
for Linux, malloc_size for MacOS, _msize for Windows, etc.

[...]

> +#include <stddef.h>
> +#include <malloc.h>

Again host portability, <malloc.h> is not present on MacOS.

Regards,
Tony

