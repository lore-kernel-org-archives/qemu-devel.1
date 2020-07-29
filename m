Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629F5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE1E20658
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="JRj1GWhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE1E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0sGi-0007qy-Gf
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 16:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0sG6-0007N9-7N; Wed, 29 Jul 2020 16:01:02 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0sG3-0000DB-Fh; Wed, 29 Jul 2020 16:01:01 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 7F613BF616;
 Wed, 29 Jul 2020 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596052857;
 bh=/dYI78WbHUtLK1hTVWc8ObNFjmtg/v5y+FkJHYI7S24=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JRj1GWhjSCEOKG8x3PXEyjfNzfzhIkTut5J4D5C2eUlbVcL37odiH0SUNKupdDlnQ
 WEpGEZBPp8XfBDZIrFjezj54zUtBO6nJrXLl2gW7TwDYYjApETKg00da0wuHguKTiv
 9pAANFux2/YMPABP2DpdkfEKKh0nMC+KtTI8KdvMaMgw/CimwnBSJNPFhoTkwNIO4C
 kxnecFSfiI6kJy2aleJ330wGu6kkEhMYDWOoQXwK+SOtLoQdIdweBU+5HATUrbZ8Y3
 nH2oVp8yQHYG/hQodJLkbD6OHOqBlVxfaZk3idl2fwWaiYizGtyZY83nQfdWGSszBd
 MEhQiVC+75hzQ==
Date: Wed, 29 Jul 2020 22:00:56 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 15/16] hw/block/nvme: remove NvmeCmd parameter
Message-ID: <20200729200056.GE293496@apples.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-16-its@irrelevant.dk>
 <64fae709b5869e3201d4016c2b17e984e3aa4605.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64fae709b5869e3201d4016c2b17e984e3aa4605.camel@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 14:23:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 29 21:25, Maxim Levitsky wrote:
> On Mon, 2020-07-20 at 13:37 +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Keep a copy of the raw nvme command in the NvmeRequest and remove the
> > now redundant NvmeCmd parameter.
> 
> Shouldn't you clear the req->cmd in nvme_req_clear too for consistency?

It always gets unconditionally overwritten with a memcpy in
nvme_process_sq, so we are not leaving anything dangling (like we would
do with the namespace reference because it's usually not initialized for
Admin commands)

