Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C955C388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 21:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB58206E9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="CKDWgTdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB58206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYyF2-0005rp-TG
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 17:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYyDk-0004y9-Li
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 17:15:32 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:56411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYyDh-0005JB-93
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 17:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=jMSP9Zjo22nvVPG9I/E6WdL4C5aheK6wEEO14yBEJN8=; b=CKDWgTdH4X5qsnWgruJBUBqHJi
 txCrW0v6Wx0RJYtdtuve8etYSBKe+2tcbI/UMLmSF080juOMdvIKrzVlTbUXapGATqHdKP2R1EukQ
 +/Iw2cxuYirh/tuKRKEtzPKd8VrKzocGiCINz70DNs8NJqo7m9L8AUn/cGGagB43UElfjJzsIZVKr
 JSHnoRrbZxbgr6Zul2iN8MA1YEFTSgIt8Rsf8FIaTfM+J+g06hdWqPQfkznw73WNPSAG6ytNi4Wvz
 Qr+G7NsJxQdYqAz8a54YaqsYzyhGya124K/kR5zVgptiIypxp/WIN8V8DBFEKRn/S+ZTdQ+f4iaOZ
 9JCD/Aqg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PULL v2 01/16] tests/9pfs: fix test dir for parallel tests
Date: Sat, 31 Oct 2020 22:15:23 +0100
Message-ID: <15426191.KhQovltxXE@silver>
In-Reply-To: <CAFEAcA-pQP0DZP003cKnj8k0DXjH0KR+K_joWdtdNhV1eGkfkA@mail.gmail.com>
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
 <5877759.JlKFulrene@silver>
 <CAFEAcA-pQP0DZP003cKnj8k0DXjH0KR+K_joWdtdNhV1eGkfkA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 15:17:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Samstag, 31. Oktober 2020 21:34:31 CET Peter Maydell wrote:
> On Sat, 31 Oct 2020 at 13:20, Christian Schoenebeck
> 
> <qemu_oss@crudebyte.com> wrote:
> > On Freitag, 30. Oktober 2020 13:07:03 CET Christian Schoenebeck wrote:
> > > Use mkdtemp() to generate a unique directory for the 9p 'local' tests.
> > > 
> > > This fixes occasional 9p test failures when running 'make check -jN' if
> > > QEMU was compiled for multiple target architectures, because the
> > > individual
> > > architecture's test suites would run in parallel and interfere with each
> > > other's data as the test directory was previously hard coded and hence
> > > the
> > > same directory was used by all of them simultaniously.
> > > 
> > > This also requires a change how the test directory is created and
> > > deleted:
> > > As the test path is now randomized and virtio_9p_register_nodes() being
> > > called in a somewhat undeterministic way, that's no longer an
> > > appropriate
> > > place to create and remove the test directory. Use a constructor and
> > > destructor function for creating and removing the test directory
> > > instead.
> > > Unfortunately libqos currently does not support setup/teardown callbacks
> > > to handle this more cleanly.
> > 
> > Peter, please ignore this PR. This patch needs rework:
> OK. As a general rule you need to make "please drop this PR"
> requests as replies to the top level cover letter, though --
> otherwise it's pot luck whether I happen to notice them or not.
> 
> thanks
> -- PMM

Okay, got it.

Best regards,
Christian Schoenebeck



