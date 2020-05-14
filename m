Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A01C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD95520643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x2bd5mWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD95520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJTY-0003it-Ty
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZJPo-0006l3-Ko
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZJPn-0007KZ-Sd
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:08 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 61F4220643;
 Thu, 14 May 2020 19:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589484066;
 bh=bcl+HQLsQ3uSbKrpOFk/KGUy91oGnSfW+C4K65fi8ko=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=x2bd5mWEwKF2sE9ZO6Pven/XrGo/cZkgmeNjW7b9QpOB3m+AqSxjO5Fek09SwfOVZ
 tGXfaxxiv4zKnrOAQy4PoU/oGGbGSsV/+N0l0Fbha2bzSdGFhZJ3puBKpl+tNuYpbQ
 rmW1egeifZyctl7F4kTVCAkFGAFIsX90YrZxBU04=
Date: Thu, 14 May 2020 12:21:05 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: groug@kaod.org
Subject: Re: [PATCH 0/1] virtio-9pfs: don't truncate response
In-Reply-To: <cover.1589481482.git.qemu_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.21.2005141220040.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589481482.git.qemu_oss@crudebyte.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 15:19:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu_oss@crudebyte.com,
 qemu-devel@nongnu.org, Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020, Christian Schoenebeck wrote:
> The following patch reverts
> SHA-1 16724a173049ac29c7b5ade741da93a0f46edff for the virtio backend.
> 
> Greg, it is intended as a quick fix for
> https://bugs.launchpad.net/bugs/1877688 at least for virtio, for the
> case the appropriate fix on Xen side might still take a while. Because
> this bug is too serious to let it rest for too long.
> 
> In case Stefano comes up with a fix for Xen soon, you might just ignore
> this patch and just revert SHA-1 16724a173049ac29c7b5ade741da93a0f46edff
> entirely instead of course.

I am aiming at getting this fixed within a few days.  Up to you as you
want to proceed with the patches. I am happy either way.

