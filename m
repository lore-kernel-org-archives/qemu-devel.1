Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA300C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BA220B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxcaXyTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BA220B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi65t-0001JA-8B
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 19:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44095)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tcminyard@gmail.com>) id 1hi3qr-0004Ym-A2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hi3qp-00084g-K1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:28:41 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:34244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hi3qp-00083b-Dh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:28:39 -0400
Received: by mail-oi1-f182.google.com with SMTP id l12so11224654oil.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id;
 bh=FV64nwXc9NGzpBuhaiLXQfbhwQhPoL1VGRxkgyAgrjI=;
 b=oxcaXyTuhBiZBLr4f3VAIiYvMZA4MOLBmFEmzat1WQscVbemgdMSz7gL+o225QS1ma
 7vYyKoluAW0MPVcxGgf61Iple63hiLq455jPR6nfG4SYlHYN3Qpt/482V0lced7WmlGf
 O51O2QUByn1UXcGiHFpQZOGpQq4uSPcn8qv+w+8tEOpNLI+WROWyqVgnAr1wSphP4y0r
 bTATiT1KBfC9P+8R57MloQbPAfomOa/4Sja6UEDEJ9EHXeBH/wHwbHfD05kHb31Bp5jc
 V6EXzPpKbx8B77F3TPlZ3NWNdzrKY6AQqR/42m3rvTDHbRgBJpFiQ5zE3pbMiasnsBjN
 ojdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id;
 bh=FV64nwXc9NGzpBuhaiLXQfbhwQhPoL1VGRxkgyAgrjI=;
 b=GiyMjenzlk5C7qWyQSv0edNIghXLoNYNBigL0dxzOXn6DhErT5v4SE60h/ZYCODgtm
 4+dqRJX/C5qhBgyU8uhJ/zXZ/nBA9B9jGAzfImwp38LfSsZjdkrNBFr5Gn6OltSMvMIS
 tWHtLtuH2rwEFzggPkrrmVR/tVMA6iW6GhKhaxHexUeJArAAdxVENQXMbPR1pqWO/Smo
 TOl8scaqE9CUtKGEyJv/B9gecGU4PMGuy189p7r62spg7uHaO/0V1RA0HfDFZBOz/U9D
 LgZ3vDLdp6G4IVZ13xrSAYfBTIUO53aPuZg9WWU4/G6ESCPMeU52OpO8T+XS/PlhRNLm
 vrFQ==
X-Gm-Message-State: APjAAAUzlHJ2KCE/j5kMRMER7GjqokQpyhbted9qCpVNHmIGz2dGPxAf
 f6jVm0r6YYt+Q2cx6rew3JHas4s=
X-Google-Smtp-Source: APXvYqzHCDPXXxu1I7ib/b2ACWZfGXYd1vN14BFT3ZrNibjSmjQk6TqtyabFUvG8MuEjqNLmg6yMTA==
X-Received: by 2002:aca:4083:: with SMTP id n125mr425137oia.106.1562005869373; 
 Mon, 01 Jul 2019 11:31:09 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id t9sm4369535otm.35.2019.07.01.11.31.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 11:31:08 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id 92A021800D1
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 18:31:07 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 08B84302330; Mon,  1 Jul 2019 13:31:06 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon,  1 Jul 2019 13:30:58 -0500
Message-Id: <20190701183100.7849-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.182
Subject: [Qemu-devel] [PATCH v2 0/2] Add a UUID device property to IPMI
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

I sent this out a while ago and didn't really receive any comments then
kind of forgot about it.  These changes are not critical, but are really
necessary for certain situations and testing to make things behave like
they really should:

* It allows a BMC to be created with no UUID, returning an error, which
  is the behavior of many BMCs in the world.
* It lets the user set the UUID to a fixed value.

Some software using IPMI will get confused if it gets different UUIDs
from what should be the same device, which is what happens now if qemu
quits and restarts.

So sending out for review again.

Thanks,

-corey



