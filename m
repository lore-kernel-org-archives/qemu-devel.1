Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B6BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 20:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C7A2065D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 20:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeO3Wr0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C7A2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOS3E-0000fc-8l
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 16:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonatan.p@gmail.com>)
 id 1kOS2O-00007K-Qc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 16:52:20 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonatan.p@gmail.com>)
 id 1kOS2N-0000Rx-8B
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 16:52:20 -0400
Received: by mail-lj1-x242.google.com with SMTP id a22so2249948ljp.13
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rlpa2fAonUYA2QC7PMKNnQ6+weVKfFYcEw9YEaFjfwM=;
 b=PeO3Wr0GmyOn9d265BVHMWvRwoUwdtDWmEdyGE/UC2LSpxws8VYfIdYfUGHz6dK4To
 6K+rWJW1KvIRq5osC5mDZop+uvQ3fnOogazW442q8GE652XDp8cNiQdhRQhGuR4mkKbH
 eBeGbKmeMyXgDpZ7kWGQd3IYtjL47e/edk4jcSVc1/t3a/klYeytgHy3nYbvhzeu3dTX
 VJxDiR1ANIuFQ+gkM4blD3txNn8GSnRaRmoUSrkl+CFXr7WPWAEl0xUS4sGv8rywZvFe
 KvIP4XWd1gooF4dsc2rjXW5SrKsA/cYY/g3JdJOEnXn7oKmA5l/kh52AqHfYA3NxVEiA
 a7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rlpa2fAonUYA2QC7PMKNnQ6+weVKfFYcEw9YEaFjfwM=;
 b=W2/rfdRGmV9NW9uVg/G27MpNSvzwbfEHyzPT1peulOTIeHyKZvXOJOF8G60MZrNEpD
 tJ2RYDu/yRyaH6VFU8GwI6OwsyXV7nvC7DW/t2unJMSDpiL7eGE+SeKIcj7u05APZiPK
 HLXONB7cvy+Y7qk7S2A1cwdeWalyNkKROYRagjHbIp2Y6rPYJInXtROj+UCmnVTC8eSn
 CMAVKgfUu7ZS6NqspW10Z61rG0WrWwPgCaZTkwV0bKJffEjDmqZgU5pWN/5FsO6Cb4uJ
 8wmqKAoHMJ5CtQHbN5oRygCCpv8OIijES6wTzcbj7ekpddnQnkL+NGRiTd4SSmjgEHop
 znlg==
X-Gm-Message-State: AOAM531sDoERFTUbWhW5oalhpce2uQPcoXA8275ZSbeLM5Ygms0T8far
 BWVzHiNSkW4CtDebAe8baTjyacJwgxwfyg==
X-Google-Smtp-Source: ABdhPJyo49r3gKcaXcIm5bJ9C1wpF1MCdKxd5+4Q7USraVl03Z3SCRhZhlMZAFeeic5oL9gsEyeKNQ==
X-Received: by 2002:a2e:6c08:: with SMTP id h8mr1140785ljc.66.1601671937280;
 Fri, 02 Oct 2020 13:52:17 -0700 (PDT)
Received: from X1.lan (h-170-217-237.A357.priv.bahnhof.se. [81.170.217.237])
 by smtp.gmail.com with ESMTPSA id j28sm598259lfk.97.2020.10.02.13.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 13:52:16 -0700 (PDT)
From: =?UTF-8?q?Jonatan=20P=C3=A5lsson?= <jonatan.p@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] scripts/qmp/qom-set: Allow setting integer value
Date: Fri,  2 Oct 2020 22:52:00 +0200
Message-Id: <20201002205200.276477-1-jonatan.p@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=jonatan.p@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Jonatan=20P=C3=A5lsson?= <jonatan.p@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the value appears to be an integer, parse it as such.

This allows the following:

    qmp/qom-set -s ~/qmp.sock sensor.temperature 20000

.. where sensor is a tmp105 device, and temperature is an integer
property.

Signed-off-by: Jonatan Pålsson <jonatan.p@gmail.com>
---
 scripts/qmp/qom-set | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 240a78187f..49eebe4924 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -56,7 +56,10 @@ if len(args) > 1:
         path, prop = args[0].rsplit('.', 1)
     except:
         usage_error("invalid format for path/property/value")
-    value = args[1]
+    try:
+        value = int(args[1])
+    except ValueError:
+        value = args[1]
 else:
     usage_error("not enough arguments")
 
-- 
2.26.1


