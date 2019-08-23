Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D80C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 08:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36917233A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 08:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36917233A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i14gX-0004Br-Cd
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 04:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <klaus@birkelund.eu>) id 1i14eX-00028T-G6
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 04:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1i14eW-0001ue-5c
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 04:10:33 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1i14eT-0001rb-8e; Fri, 23 Aug 2019 04:10:29 -0400
Received: from apples.localdomain (unknown [194.62.217.4])
 by charlie.dont.surf (Postfix) with ESMTPSA id 37CD2BF422;
 Fri, 23 Aug 2019 08:10:26 +0000 (UTC)
Date: Fri, 23 Aug 2019 10:10:22 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <20190823081022.GA30440@apples.localdomain>
References: <20190705072333.17171-1-klaus@birkelund.eu>
 <20190705072333.17171-17-klaus@birkelund.eu>
 <79fb195f-91dc-869d-f290-40fdcb96eea3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79fb195f-91dc-869d-f290-40fdcb96eea3@citrix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: Re: [Qemu-devel] [PATCH 16/16] nvme: support multiple namespaces
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, matt.fitzpatrick@oakgatetech.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, keith.busch@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 02:18:05PM +0100, Ross Lagerwall wrote:
> On 7/5/19 8:23 AM, Klaus Birkelund Jensen wrote:
> 
> I tried this patch series by installing Windows with a single NVME
> controller having two namespaces. QEMU crashed in get_feature /
> NVME_VOLATILE_WRITE_CACHE because req->ns was NULL.
> 

Hi Ross,

Good catch!

> nvme_get_feature / nvme_set_feature look wrong to me since I can't see how
> req->ns would have been set. Should they have similar code to nvme_io_cmd to
> set req->ns from cmd->nsid?

Definitely. I will fix that for v2.

> 
> After working around this issue everything else seemed to be working well.
> Thanks for your work on this patch series.
> 

And thank you for trying out my patches!


Cheers,
Klaus

