Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C78C4CECD
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 20:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484F6214AF
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 20:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484F6214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9b1A-0005BY-VM
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i9b0V-0004il-38
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 16:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i9b0T-0006zA-V8
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 16:20:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i9b0T-0006yY-R2
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 16:20:25 -0400
Received: by mail-io1-f65.google.com with SMTP id f12so73997057iog.12
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 13:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=WxWiyp31LofW/zUhX04OBojoczb4JZnvZx/pK+IuGCI=;
 b=RPNt0oEwvbZif5UOQyPI7VqfDYKlFQEmUxCy2qUXRxv9vdOcam1WG02OZMn4WkZudn
 JqPcgkF77Rm8KUx5hj1XMbDf3wew1nICBxetUsl4Te/dwSQ+MN2Kl5aiAiAeVAyKsgDC
 iZXTfVKtB24q1aZHTFv+aL5bSCjJx5xEAkt7f9JeApVnb/gYdeKf8yV4Qc8k+SZsH8NH
 JJmLh/kdXlZgatUBLfzBBVVxvNouNL2+yvotTNQJq7NOvwwZ/XnMreHNlmVa8Mw58PfZ
 TEY/GZvIbQTQaSsy3ko3HqQXIQaxn9WSABk++xKhhsgWi8+KP9QY5F7s9WpVi8NM2ArP
 u4qg==
X-Gm-Message-State: APjAAAXit2+hkWKeN9OXcjYV8y/oDFr3RGYzixlEyXOozBquSCUI7Ayf
 yonNs46xm9Y7qYiYrYTgDpTzc51DIjFCJw==
X-Google-Smtp-Source: APXvYqwt9N2nN8FRJ7l/JgWau2yEr6cx3NbPqOki/2V214KFxWslqqkIB3c8L2C+rWAb9895GfMNdw==
X-Received: by 2002:a02:ccba:: with SMTP id t26mr1693719jap.49.1568578824075; 
 Sun, 15 Sep 2019 13:20:24 -0700 (PDT)
Received: from localhost ([207.164.135.99])
 by smtp.gmail.com with ESMTPSA id j11sm28870985ioa.55.2019.09.15.13.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 13:20:23 -0700 (PDT)
Date: Sun, 15 Sep 2019 13:20:11 -0700
Message-Id: <20190915202011.30459-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: pbonzini@redhat.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.166.65
Subject: [Qemu-devel] [PATCH] vl.c: Report unknown machines correctly
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
Cc: Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I was recently typing in a QEMU command line, and ended up with
something like

    qemu-system-riscv64 -machine virt ... -M 8G

which is, in retrospect, obviously incorrect: there is no "8G" machine.
I should have typed something like

    qemu-system-riscv64 -machine virt ... -m 8G

but since QEMU was giving me the excessively unhelpful error message

    qemu-system-riscv64: -machine virt: unsupported machine type
    Use -machine help to list supported machines

I had to spend a few minutes scratching my head to figure out what was
going on.  For some reason I felt like I'd done that before, so I
figured I'd take a whack at fixing the problem this time.  It turns out
the error reporting for non-existant machines is just wrong: the invalid
machine is detected after we've lost the argument pointer, so it just
prints out the first instance of "-machine" instead of the one we're
actually looking for.

I've fixed this by just printing out "-machine $NAME" directly, but I
feel like there's a better way to do this.  Specifically, my issue is
that it always prints out "-machine" instead of "-M" -- that's actually
a regression for users just passing a single invalid machine via "-M",
which I assume is the more common case.

I'm not sure how to do this right, though, and my flight is boarding so
I figured I'd send this out as a way to ask the question.  I didn't have
time to run the test suite or figure out how to add a test for this, as
I'm assuming there's a better way to do it.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 630f5c5e9c..821a5d91c8 100644
--- a/vl.c
+++ b/vl.c
@@ -2487,7 +2487,7 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
 
     mc = find_machine(name, machines);
     if (!mc) {
-        error_report("unsupported machine type");
+        error_printf("-machine %s: unsupported machine type\n", name);
         error_printf("Use -machine help to list supported machines\n");
         exit(1);
     }
-- 
2.21.0


