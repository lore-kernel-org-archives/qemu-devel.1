Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C73C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 03:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A6822261
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 03:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A6822261
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmUNB-0002jo-Ko
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 23:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fthain@telegraphics.com.au>)
 id 1jmUMO-0001Uz-HS; Fri, 19 Jun 2020 23:40:04 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40580)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1jmUMM-00070k-N8; Fri, 19 Jun 2020 23:40:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 89E9A27783;
 Fri, 19 Jun 2020 23:39:48 -0400 (EDT)
Date: Sat, 20 Jun 2020 13:39:41 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/78] Patch Round-up for stable 4.2.1, freeze on
 2020-06-22
In-Reply-To: <alpine.LNX.2.22.394.2006201012590.23@nippy.intranet>
Message-ID: <alpine.LNX.2.22.394.2006201332390.9@nippy.intranet>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
 <alpine.LNX.2.22.394.2006201012590.23@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: none client-ip=98.124.60.144;
 envelope-from=fthain@telegraphics.com.au; helo=kvm5.telegraphics.com.au
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 23:39:53
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 20 Jun 2020, Finn Thain wrote:

> 
> Thanks for picking these fixes. When the maintainer originally merged this 
> series of patches, the first patch got slightly damaged. This was remedied 
> in a subsequent patch[1]. That is, mainline commit a0cf4297d6 ("dp8393x: 
> Mask EOL bit from descriptor addresses, take 2"). Would you also pick that 
> commit for v4.2.1 please?
> 
> [1]
> https://lore.kernel.org/qemu-devel/23179263-a8fb-57cc-e98a-bfe9a2ee9037@vivier.eu/
> 

While we're on the subject of cherry-picking fixes for fixes, you may also 
want to consider c264e5d2f9f5d73977eac8e5d084f727b3d07ea9. I didn't find 
any fixes for fixes for fixes. That search probably needs to be 
automated...

