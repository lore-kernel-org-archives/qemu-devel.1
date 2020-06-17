Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAD_ENC_HEADER,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F4CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0F2207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDhpkufA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0F2207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlXd4-0005DP-Qn
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 08:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walters@verbum.org>)
 id 1jlXbr-0004KH-B4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:56:07 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walters@verbum.org>)
 id 1jlXbp-0006q3-5H
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:56:06 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id B4BD849A;
 Wed, 17 Jun 2020 08:55:57 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
 by compute1.internal (MEProxy); Wed, 17 Jun 2020 08:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mznKTb
 CZreUSjgX5s9/vWJMEdSMlAqHtC+pyn5mmeZU=; b=YDhpkufAvSeScIaiqMRP0l
 VhY+MmyLoerKUwAUGqPsAzI/66RLZJW51i+GH6INacXtfvJiqAWsBf2p/HRTlU47
 mlCF4W3D5DdorNUwUwYLOKTaLRqT1xWu8M4IAuHi27BqspCdl6aTbfHLElOn846A
 iEOKJU+4t3PdFVR/OstvCEMoDqXDXPou2EjZDUrqOLyi3mfRJq13EaFZxQC+9ud4
 SAuoq0sG9TkmMW4+S27+64TnmRayvOwcg6uOo0BzDWkZAAW2q5wZTYouS5Y7x/eh
 l87yGxGkIO6AerXlIDPfxtg7Zeii4wri7HD2dBtnqfofCnlBFV/S277cZdPxKjDg
 ==
X-ME-Sender: <xms:3RLqXn2LbEo5DtU1nMQ1yYV75vqbtf8adCYMkYeoF-6Tyg2dHOQreQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejvddgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdevohhl
 ihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecugg
 ftrfgrthhtvghrnhepgfeugfehfeefudfhteffudeukeetueekudetjeegieekffelgfef
 vdetfeettdelnecuffhomhgrihhnpehlfihnrdhnvghtnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdho
 rhhg
X-ME-Proxy: <xmx:3RLqXmHOu3puJNnkMvhQEr5vAEHTfkEFgXvFd4VML0KtVflYT1VceQ>
 <xmx:3RLqXn5dLlQQPel7Hv0eAaJL15ieVMU4ZUTLGZmURtr-6aHR4N_PHQ>
 <xmx:3RLqXs1uyDh31g5A9dS2nFeRy-1-lA-Zzuxl9SQwZO1fkokT-hvuuA>
 <xmx:3RLqXmEZ1ocNp6PSABHFv15cv4iDH2AM2b9KzXJ06cQTPEmDJwLU6w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1FF7A2035A; Wed, 17 Jun 2020 08:55:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-529-g3ee424a-fm-20200611.001-g3ee424a1
Mime-Version: 1.0
Message-Id: <add0c8d8-7214-4976-83f1-b06071682837@www.fastmail.com>
In-Reply-To: <20200617125014.GC1728005@stefanha-x1.localdomain>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
 <20200602095547.GD9852@stefanha-x1.localdomain>
 <7b355ffb-2b96-4984-a198-ac40a07c422e@www.fastmail.com>
 <20200617125014.GC1728005@stefanha-x1.localdomain>
Date: Wed, 17 Jun 2020 08:55:36 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Stefan Hajnoczi" <stefanha@gmail.com>
Subject: =?UTF-8?Q?Re:_[PATCH]_virtiofsd:_Use_clone()_and_not_unshare(),
 __support?= =?UTF-8?Q?_non-root?=
Content-Type: text/plain
Received-SPF: none client-ip=64.147.123.25; envelope-from=walters@verbum.org;
 helo=wout2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 08:55:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Wed, Jun 17, 2020, at 8:50 AM, Stefan Hajnoczi wrote:

> Something along these lines should work. Hopefully seccomp can be
> retained. It would also be necessary to check how not having the shared
> directory as / in the mount namespace affects functionality. For one,
> I'm pretty sure symlink escapes and similar path traversals outside the
> shared directory will be possible since virtiofsd normally relies on /
> as protection.

Yes, though two points:

- As I said, I don't care about that for my use case; the operating system we're testing is going to e.g. run on bare metal hosting workloads itself, so if it's malicious we have already lost (reliability against *accidental* damage is always nice though, like a stray rm -rf in some test script walking into the host)
- Probably the best long term fix would be to use https://lwn.net/Articles/796868/ anyways

