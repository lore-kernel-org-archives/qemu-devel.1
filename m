Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA211C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958002073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeoDHXx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958002073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rvd-0004gc-EC
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1rtq-0002sB-9H
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1rtp-0001Cp-8V
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:17:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1rtp-0001CU-5V
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581513472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deY8EPNmcz+ZVD+I6hCztZjLcaEb7MFzeRRk2PQvUbA=;
 b=WeoDHXx6Atr5SXK1/2XKyMtknSFaPv46fBlVyrXCja8BRD1YDbm4TfV8NVLl2TTZn6WS36
 Xyaz35+aDMS008YvaGkzcZsvTU8Yl+sCyj753m4z5oLHwQBufbjU2OpBLr8qdn4Pv1sX5K
 IxAHgS9wPHsu4SuUehnMB1qxEtvhFDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-_hxAmFM0PLGBMWdcZBzKaQ-1; Wed, 12 Feb 2020 08:17:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EFA88017CC;
 Wed, 12 Feb 2020 13:17:47 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D424360BF4;
 Wed, 12 Feb 2020 13:17:44 +0000 (UTC)
Message-ID: <106b20e0cd6eff05f1031e34373721c3b9494fcc.camel@redhat.com>
Subject: Re: [PATCH v5 01/26] nvme: rename trace events to nvme_dev
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <k.jensen@samsung.com>
Date: Wed, 12 Feb 2020 15:17:33 +0200
In-Reply-To: <20200212130838.2zgz6iuysi4ef2ne@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095216eucas1p2cb2b4772c04b92c97b0690c8e565234c@eucas1p2.samsung.com>
 <20200204095208.269131-2-k.jensen@samsung.com>
 <0106bf338e09bbf01e35bbcabed344ba71a2ad0d.camel@redhat.com>
 <20200212130838.2zgz6iuysi4ef2ne@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _hxAmFM0PLGBMWdcZBzKaQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-02-12 at 14:08 +0100, Klaus Birkelund Jensen wrote:
> On Feb 12 11:08, Maxim Levitsky wrote:
> > On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> > > Change the prefix of all nvme device related trace events to 'nvme_dev'
> > > to not clash with trace events from the nvme block driver.
> > > 
> 
> Hi Maxim,
> 
> Thank you very much for your thorough reviews! Utterly appreciated!

Thanks to you for the patch series!

> 
> I'll start going through your suggested changes. There is a bit of work
> to do on splitting patches into refactoring and bugfixes, but I can
> definitely see the reason for this, so I'll get to work.
> 
> You mention the alignment with split lines alot. I actually thought I
> was following CODING_STYLE.rst (which allows a single 4 space indent for
> functions, but not statements such as if/else and while/for). But since
> hw/block/nvme.c is originally written in the style of aligning with the
> opening paranthesis I'm in the wrong here, so I will of course amend
> it. Should have done that from the beginning, it's just my personal
> taste shining through ;)

TO be honest this is my personal taste as well, but after *many* review
complains about this I consider that aligning on opening paranthesis 
is kind of an official style.

If others are OK with this though, I am personally 100% fine with leaving the
split lines as is.


Best regards,
	Maxim Levitsky


