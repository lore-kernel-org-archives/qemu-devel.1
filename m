Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B350C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5162064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5162064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCdIe-0003dw-CN
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 01:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iCdHv-00030F-7E
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iCdHu-0005eJ-4J
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:22:59 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:35723)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iCdHt-0005cE-Ug
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:22:58 -0400
Received: from player687.ha.ovh.net (unknown [10.109.146.211])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id D89D969FEB
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 07:22:55 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 9E132A1B1964;
 Tue, 24 Sep 2019 05:22:51 +0000 (UTC)
Subject: Re: [PATCH 0/4] xics: Eliminate unnecessary class
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cb87c744-a618-0627-5c2f-8f8e18616f6d@kaod.org>
Date: Tue, 24 Sep 2019 07:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924045952.11412-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12118905122849524488
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdelgdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.73.241
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
Cc: gkurz@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/2019 06:59, David Gibson wrote:
> The XICS interrupt controller device used to have separate subtypes
> for the KVM and non-KVM variant of the device.  That was a bad idea,
> because it leaked information that should be entirely host-side
> implementation specific to the kinda-sorta guest visible QOM class
> names.
> 
> We eliminated the KVM specific class some time ago, but it's left
> behind a distinction between the TYPE_ICS_BASE abstract class and
> TYPE_ICS_SIMPLE subtype which no longer serves any purpose.
> 
> This series collapses the two types back into one.

OK. Is it migration compatible ? because this is why we have kept
this subclass. I am glad we can remove it finally. 

Thanks,

C.

    
> 
> David Gibson (4):
>   xics: Eliminate 'reject', 'resend' and 'eoi' class hooks
>   xics: Merge reset and realize hooks
>   xics: Rename misleading ics_simple_*() functions
>   xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes
> 
>  hw/intc/trace-events  |  10 +-
>  hw/intc/xics.c        | 211 ++++++++++++++----------------------------
>  hw/intc/xics_spapr.c  |  12 +--
>  hw/ppc/pnv_psi.c      |   6 +-
>  hw/ppc/spapr_irq.c    |   6 +-
>  include/hw/ppc/xics.h |  30 +-----
>  6 files changed, 92 insertions(+), 183 deletions(-)
> 


