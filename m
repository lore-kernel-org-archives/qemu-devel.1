Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF6AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DAF206D4
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=poolhem.se header.i=@poolhem.se header.b="rwYrO3aE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DAF206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=poolhem.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2fLH-0007aW-Ee
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 14:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1k2fKD-00076b-Sv
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:36:42 -0400
Received: from mailout12.inleed.net ([2a0b:dc80:cafe:112::1]:48238
 helo=ns12.inleed.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1k2fKA-0004wA-US
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KHNR1HJh3vwDqHjT1ZPZUUbNwkoOnE+cz1/Sb0hH6QU=; b=rwYrO3aEBGfov9zbmbBkDJRTKy
 o4KOcW/8XCYxD+z4/xiUUl0UYe3Ci1JhQmA5TB+I3TNTocWCTY/DNRPx2P3E7hhhJK2cblZ2xxl5c
 IazrVdONkaGzeevT3+KCxICM59zD0s/B94TVReX7p8Fz9csdtBzP+7RU3ouPI4gCiFAixHxwrgpnS
 KtA1GbVZJ4JBGxQWINMqqSwwFWbYSD/U2ZeXn1x6ruoK/OkM1ZCRb2ZpwT3Krm1uo6e51+a0fdy3t
 EMMUdYGSQ6Liyv56QAAcNZVUeSCZAAcUiqe3nwo/34qN/yNJCT7Y08UDsUYgigJHhm0K/c2w/x0qf
 NwF/cMJA==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.93.0.4)
 (envelope-from <hc981@poolhem.se>)
 id 1k2fK6-004N94-5u; Mon, 03 Aug 2020 20:36:34 +0200
Date: Mon, 3 Aug 2020 20:36:32 +0200
From: Henrik Carlqvist <hc981@poolhem.se>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: Ping: [PATCH] Emulate dip switch language layout settings on
 SUN keyboard
Message-Id: <20200803203632.76222bb1.hc981@poolhem.se>
In-Reply-To: <CACXAS8CkSX1knsStsL1azYQQFrbYV5ZXXOWm9bp_F-CU7ph=7w@mail.gmail.com>
References: <20200710201911.3a3e336c.hc981@poolhem.se>
 <20200803192645.48513f57.hc981@poolhem.se>
 <43e05cbb-14aa-80ed-d39a-1456f2a0e480@redhat.com>
 <CACXAS8CkSX1knsStsL1azYQQFrbYV5ZXXOWm9bp_F-CU7ph=7w@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: henrik@poolhem.se
Received-SPF: none client-ip=2a0b:dc80:cafe:112::1;
 envelope-from=hc981@poolhem.se; helo=ns12.inleed.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_SOFTFAIL=0.732, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for finding my typos!

On Mon, 3 Aug 2020 20:16:43 +0200
Artyom Tarasenko <atar4qemu@gmail.com> wrote:

> > > On Fri, 10 Jul 2020 20:19:11 +0200
> > > Henrik Carlqvist <hc981@poolhem.se> wrote:
> > >> hardcoded to allways use an US keyboard layout.

> Can you please move this description to the commit message? (Fixing
> typo in "always" ;-) )

I don't think I have access to push commits to the git repo, or did you mean
that Paolo should make the commit?

> >> Subject: [PATCH] Emulating sun keyboard languate layout dip switches,

> typo: language

> Looks good otherwise. For the v2:
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

Do you want me to post the same patch again to the mailing list with corrected
typos in subject and description?

Best regards Henrik

