Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A8AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 01:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A7B21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 01:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUqDMCkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A7B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOBL-0005po-GK
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 20:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihOAM-0004zs-LV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihOAK-00052j-Ja
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:30:18 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihOAJ-00050H-Un
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:30:16 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so473576wrw.8
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 17:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=yx4+N0YqtdkyV6PrveYjZLcjfbc3XqUAJOQk41V1MmY=;
 b=tUqDMCkFqHTvzehdY1+tpTJcwrJGMc+y9MTdkLm1jmnF/kxbMCZPKW59MapK8jx46i
 AGqlGgMQ/OHerikBTI2+P7sLiO7DGvOUZE/x7i+xWC7tvZ5LAAr75jWbb7nC61VwdZU5
 BLaXgGnd4H2PZJnZaJf89VKPvJQcBppXcoRrr2IGHrjCg5CPgRqUpAz/ydqE3qWiNJUG
 ym2i+idq8mu1srSODCjmTDUpaXnK0fPa3O1o/ThT33t8QoujlN11odJ47+VO5IBaBjZ+
 Y3HdfmqBxwosGFC6wivKFnebPjvuMuDx5Y4Ob02G+XbkoCz/k4LLv7QqHn3fLAmhuvi8
 BEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=yx4+N0YqtdkyV6PrveYjZLcjfbc3XqUAJOQk41V1MmY=;
 b=Zso7soMBzsmmBb8iV/p/WUE157xutARH7gm+Qi5qI6wcFy/j7IWrrHcnUSiSemOHLC
 vjArnhv5S+Gj77S7aLQurbByjynJ5UzaTuCMSDThUWFr2d+Q5U0PEUBofBPtimWhlGYh
 1sqJnKgW/y0dmBoa1JMi7fu3qbTw28VgyjJClJgx5uCmpRYPiB2mFD/XzxO5DeEGi+na
 l1oQJh6Yt0IWFfAB0xbB7PZhFUiZZp5u3kXDoXMKyKpc86kKu81IEh3W18gIBeltNRri
 aoozZEDpR7aMZUzMrZwzeaDc8EcFCtGEbnfGev+9FZn/3tT+VLhm0jXUe4nN0brDLCQR
 /vEQ==
X-Gm-Message-State: APjAAAX5cg3X60IwXraPr96/8NeGFBdHAniJgT6qxT3EmcStumzfCQPw
 vECA5ox4mxHkljSVBeyHqRsC24w1
X-Google-Smtp-Source: APXvYqzqHqyA+2m212V9HDljU5G2U6q1HK7TphbeOgi6os8Ub8TxccduM+/BIzb7hZqPloM33HCJ1A==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr811535wrn.280.1576632613415;
 Tue, 17 Dec 2019 17:30:13 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id f12sm651283wmf.28.2019.12.17.17.30.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2019 17:30:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docker: gtester is no longer used
Date: Wed, 18 Dec 2019 02:30:11 +0100
Message-Id: <1576632611-55032-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are using tap-driver.pl, do not require anymore gtester to be installed
to run the testsuite in docker-based tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/common.rc | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 512202b..02cd67a 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -53,12 +53,7 @@ check_qemu()
         INVOCATION="$@"
     fi
 
-    if command -v gtester > /dev/null 2>&1 && \
-           gtester --version > /dev/null 2>&1; then
-        make $MAKEFLAGS $INVOCATION
-    else
-        echo "No working gtester, skipping make $INVOCATION"
-    fi
+    make $MAKEFLAGS $INVOCATION
 }
 
 test_fail()
-- 
1.8.3.1


