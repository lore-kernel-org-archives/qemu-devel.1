Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72144C32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405F020709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kD8ZhaZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405F020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2I5-0008Td-CZ
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iv2Fw-0003gR-2N
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iv2Fv-000309-0R
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:28 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iv2Fu-0002z1-RB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:26 -0500
Received: by mail-pl1-x642.google.com with SMTP id p12so604897plr.7
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NCvSSBqxEUQx9J/P5MFSza4FDjSc3lDbb0fGxUZvm1A=;
 b=kD8ZhaZIC+fbufp9yJakIiLu3HvZVa9u6F1XPm3nLHu8GYr9kdaL97rUZi3by6ZWLr
 L2SMzF11dfZKtuoEPQm63dwyRBwYOAZ/3hTUWiM1MMtCnVhYY2KCoU9YqjLJ6KbgtuUq
 FWY1uSQ0jM5x+kCaAhkccAQ/wPuLGdtaumfctur/l376r5zfoIAJ2OH5UZe6ryTggz2F
 dwAC+3byPo/rW6BvNUKVRxtqE/0kVMPGfwivE2OS8FRdIhSxOdHFd8fZ7HG9T1+Xbq2l
 iU+FYL5YHCEamCyNJ4DJQBJmZreCKk9BIylYD4ibA1KsxhWfZriW9+JMwFEz86LK/9s6
 VaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NCvSSBqxEUQx9J/P5MFSza4FDjSc3lDbb0fGxUZvm1A=;
 b=SVp1D9rMLS6LK68a3j2jYOh0TvlrIHMC1BwGhfJGSI4sAAq5/dxIPLK47pN0hth7aS
 J1sK5hTdjqo1iMjnkNP4zpHLINEmb5dLzjeV3JYDLxs/XwUVz9p07dBfrdUQ6UBQH0Io
 JqN8JpHNq1bAntN50tGQCTfAZ2V+ijfLXg/V0KJQv9ZzFYNJF+9QjgbjMG+xuxH5t6rn
 /AxURQ234sY8VRsDNFcnaqaH8zo0PZADvF6i3n0IdjwxZhGvEpFfxLM7PKDd13lT/dnE
 fkmkDKG3SRINYQ6bYqL/rz3boPXdT2v0lvSYpzVRKg12spzaMavc+rE62tQlJB5WeWeb
 IuKg==
X-Gm-Message-State: APjAAAUKHFPCoscqfZ+NwFjXDyArB40BlAIvkBAkfMaCJkL7WS5xlbZi
 dW9S8n7So27Q1XqirwANDmV9S4kYxk0=
X-Google-Smtp-Source: APXvYqxTsj5SxM5QCENm+CjFYJx5wQ9hyCaSon3DugO50L5ZgsXsZT/0/gCcmQZQFPBxAy75Y8Z0yw==
X-Received: by 2002:a17:902:9003:: with SMTP id
 a3mr4298090plp.339.1579884985645; 
 Fri, 24 Jan 2020 08:56:25 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id l10sm6969953pjy.5.2020.01.24.08.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:56:25 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] tests/vm: change wait_ssh to optionally wait for root.
Date: Fri, 24 Jan 2020 11:53:30 -0500
Message-Id: <20200124165335.422-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124165335.422-1-robert.foley@linaro.org>
References: <20200124165335.422-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow wait_ssh to wait for root user to be ready.
This solves the issue where we perform a wait_ssh()
successfully, but the root user is not yet ready
to be logged in.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/basevm.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 86908f58ec..3b4403ddcb 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -310,12 +310,17 @@ class BaseVM(object):
     def print_step(self, text):
         sys.stderr.write("### %s ...\n" % text)
 
-    def wait_ssh(self, seconds=600):
+    def wait_ssh(self, wait_root=False, seconds=600):
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
         while datetime.datetime.now() < endtime:
-            if self.ssh("exit 0") == 0:
+            if wait_root:
+                if self.ssh("exit 0") == 0 and\
+                   self.ssh_root("exit 0") == 0:
+                    guest_up = True
+                    break
+            elif self.ssh("exit 0") == 0:
                 guest_up = True
                 break
             seconds = (endtime - datetime.datetime.now()).total_seconds()
-- 
2.17.1


