Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777BDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 19:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4291C20809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 19:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="NAyP7Z+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4291C20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0s0O-0008G7-Ei
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 15:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0rzp-0007lo-1i; Wed, 29 Jul 2020 15:44:14 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0rzl-0006j2-Jc; Wed, 29 Jul 2020 15:44:12 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 416A8BF616;
 Wed, 29 Jul 2020 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596051845;
 bh=63zx0WaWom5fNygxz+KxfTSLcYZaxFxEObJd6im+JGo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NAyP7Z+Etbz/PUbuq6U0bbe6f/k1/Iu1IaSZx76BmRzOIQzn+wmuIiTZOKi9bhLbB
 Xz5VwIkX991MEHm/HgtFIHTvoDTHNkkItB241GxFjWP5vqriPIgd8hrrJsdT0MWB5/
 SO1VTl6ZaIkrJca1cLsjLCkapmIhjE6YQOIQj+GBmDsO8q0lBIfg4gVlS80frSuSSF
 zhnlblaUAGJHnkS8lQQIcsz9OyZdO+7+qRMzY2GXWCH3Kthbwr0zjRdUuIyntdvIKv
 /p15hduNHC5/IrMbXDp0Qb25OTVzP7X4l3en+CMBRCJdNcEPP0oNXCLLw/38jVXCvT
 lhL2kA1CRP7ow==
Date: Wed, 29 Jul 2020 21:44:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 15/16] hw/block/nvme: remove NvmeCmd parameter
Message-ID: <20200729194401.GA293496@apples.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-16-its@irrelevant.dk>
 <20200729161051.GN14876@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729161051.GN14876@localhost.localdomain>
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

On Jul 30 01:10, Minwoo Im wrote:
> On 20-07-20 13:37:47, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Keep a copy of the raw nvme command in the NvmeRequest and remove the
> > now redundant NvmeCmd parameter.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> 
> I would really have suggested this change from 13th patch!
> 
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
> 

I squashed the two patches. If don't think it makes the match much
harder to review since the added namespace reference is a pretty small
change.

