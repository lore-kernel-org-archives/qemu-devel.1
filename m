Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1128C54FD5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C9C20740
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C9C20740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH97g-0004D3-09
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 12:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jH977-0003bW-2E
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jH975-0001D3-Vw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:42:44 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:37073)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jH975-0001C0-Pb
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:42:43 -0400
Received: from player786.ha.ovh.net (unknown [10.108.42.202])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id E5DFA27471C
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 17:42:41 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id F268E10F18A70;
 Wed, 25 Mar 2020 16:42:33 +0000 (UTC)
Subject: Re: [PATCH 0/5] ppc: sreset and machine check injection
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <eceb0a5e-6aba-2b39-898e-d55a2cc5914a@kaod.org>
Date: Wed, 25 Mar 2020 17:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325144147.221875-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9944229455951727524
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehgedgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.124.100
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 3:41 PM, Nicholas Piggin wrote:
> This adds nmi injection for pnv, and similar mce injection for
> spapr and pnv. The mce injection has already uncovered quite a
> few bugs in Linux papr guest and one in pnv host code, so it
> has been already very useful. 

Nice ! 

> The mambo simulator can do similar
> injection but it's a bit more clunky and needs to run KVM and
> QEMU in the sim to test papr guests, which is quite slow.

You can run a KVM guest under the QEMU powernv machine. You will 
need a patch from Suraj adding radix support for guests, which is 
still in my powernv-5.0 branch.

> HMIs like timebase corruption would be another good candidate
> for error injection.
 
XSCOM errors also. 

Thanks,

C. 


> Thanks,
> Nick
> 
> Nicholas Piggin (5):
>   ppc/spapr: tweak change system reset helper
>   ppc/pnv: Add support for NMI interface
>   nmi: add MCE class for implementing machine check injection commands
>   ppc/spapr: Implement mce injection
>   ppc/pnv: Implement mce injection
> 
>  hmp-commands.hx              | 20 ++++++++-
>  hw/core/nmi.c                | 61 ++++++++++++++++++++++++++
>  hw/ppc/pnv.c                 | 85 +++++++++++++++++++++++++++++++++++-
>  hw/ppc/spapr.c               | 63 ++++++++++++++++++++++++--
>  include/hw/nmi.h             | 20 +++++++++
>  include/hw/ppc/spapr.h       |  3 ++
>  include/monitor/hmp-target.h |  1 -
>  include/monitor/hmp.h        |  1 +
>  monitor/hmp-cmds.c           |  1 +
>  target/ppc/cpu.h             |  3 +-
>  target/ppc/excp_helper.c     | 17 ++++++--
>  target/ppc/monitor.c         | 11 +++++
>  12 files changed, 275 insertions(+), 11 deletions(-)
> 


