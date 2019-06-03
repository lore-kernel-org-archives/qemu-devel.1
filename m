Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D726C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29A22735E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKm338fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29A22735E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38275 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqXA-0000rC-4i
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:14:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqU5-0006vP-9e
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqTz-0003oi-FW
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqTz-0003mv-7s
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id t5so11903960wmh.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=OfXaHwLocSqyB2wiPEkoKB+aQeRQgtUC2AE1X7T3HBk=;
	b=fKm338fet40W/xfxKr72q0CCg9ETJ8d4e6bxxSmZA6aNJBQiu8YxNp9V969PYEGk5k
	bm89YU4HXxw1zpecO3lMLAdBiFPEAwoz5P+dQIQGfp2x80umlSkF+XlnUwmg1TljHs1H
	qMapF3wqqEud6K/7KNrvAKfbIehSfeUtP9KV3tK0+cE97dlV89/YPyln2A6Sv6/6kBgR
	U7vtxSKo0UPVM9n7uXdq+FR43P2HwZaZlAp3FG3IbTwx8bINQaJlthsqDdBonHGOFfrb
	O9AXyRdoqT5VAdUHhTwABQMQw43SsGTm7+mWAsHM279EmT+c2nERLz/WDhXOzldVEhLb
	iHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=OfXaHwLocSqyB2wiPEkoKB+aQeRQgtUC2AE1X7T3HBk=;
	b=NwHVfbBNuY668iaEfNEeyl8MjJ0aeHLe4qZQSNCsY2FA2kckYZ48ll1Exip0Kh0Hde
	SEri6pwUoOj0ngL34WNAHipeVQrxep8MQFE1HGkf2Z2xxKrqtdUjgbrMtKuYWcK97RYx
	nXz+pMr5d7DjRQ1ps1YFgbjHtQbY5s543oo4oNWrvh6AIlOnZv61KiwHy6bXOx4gmnUQ
	oTF5v55KMPTVg3mWaHOb1OIsrGgBAO3MoDvowqj1/j2eNMzHazc/MhtM5iLjrByCAk1U
	WGmBqgeb3zOb7xMsueeTT7P4oEP4V1sYcCmxZqpY+XH+ygsFU5u7B5v5PuD4o1Irpxsc
	HVkg==
X-Gm-Message-State: APjAAAVCw001hxVJW2s9jIpJfRr4Slkk6y65csZoHWoIbjZiJjXbvi62
	LbffrQfF+ODNedg04mCeHO8JdMHX
X-Google-Smtp-Source: APXvYqxoOSQInDP/CI6FJ6ae8HqNifmRDDxninXbrhHBs/78g0BZkIt7OwaLGUN/FwgsEObEIbkzlA==
X-Received: by 2002:a1c:8017:: with SMTP id b23mr15023714wmd.117.1559581849689;
	Mon, 03 Jun 2019 10:10:49 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:22 +0200
Message-Id: <1559581843-3968-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 03/24] checkpatch: allow SPDX-License-Identifier
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

According to: https://spdx.org/ids-how, let's still allow QEMU to use
the SPDX license identifier:

// SPDX-License-Identifier: ***

CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190426062705.4651-1-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88682cb..c2aaf42 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1949,7 +1949,8 @@ sub process {
 		}
 
 # no C99 // comments
-		if ($line =~ m{//}) {
+		if ($line =~ m{//} &&
+		    $rawline !~ m{// SPDX-License-Identifier: }) {
 			ERROR("do not use C99 // comments\n" . $herecurr);
 		}
 		# Remove C99 comments.
-- 
1.8.3.1



