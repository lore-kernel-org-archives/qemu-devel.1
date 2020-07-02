Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C95C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B1E20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajA0khJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B1E20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3MP-00013V-NP
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3Ad-000447-GV; Thu, 02 Jul 2020 13:38:47 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:38581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3Aa-0007QB-3a; Thu, 02 Jul 2020 13:38:46 -0400
Received: by mail-ed1-x542.google.com with SMTP id n2so15810660edr.5;
 Thu, 02 Jul 2020 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xGMBUKmbOHM91wM5NSBe4GbwryQGSgV9I5NHAM4u6j4=;
 b=ajA0khJlrtKyh/ciXYcO/A+HBSIxkuK4fVilr/2oozC8Bqwom7lXukl9/hcfrCi2n2
 3tmW3XdRfTN1vqb8Pl/1nwNFe/aIDYGehm3F+WyJeh9pxziqXSn8SxTNwKAgYFttk7cg
 5ZQsV1ITy+LrUjVWM/gat9ZygMOVBps3573MXx4tpMPegRc7y3iLvco81iKdA15uM0V9
 IIBFCbFDSNkTyvzEGXQttSiSGLb8+u7JOqotPR27surKl19QW0KV8BU9ZuOM84J3N/bN
 8Idx//S6+ADiyL9Ji0F5cjS5bRJONeacnJZz5gntZxn3yX9HEkE6hV5QDu8mglB1/g5B
 V7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xGMBUKmbOHM91wM5NSBe4GbwryQGSgV9I5NHAM4u6j4=;
 b=udK0foiSF+Si5zre5n3fhWzqPPjt3+7dkXmUZJQNlpFxgOzBZ+Wyr0sVifC0wcz0QF
 cA184aqErtCUM8G1KjOpbERDgG6WhZ4bAZWDmrTZN1RupdKTYhfizAmGnI7iFtnhW8k7
 ldj4U12wzsba8TeQfbUocJXCDAKk+CQ10ebmNDUvb56Gae0iO3u2W7Wi76mcziGYMr7r
 hhC1GFQUboCcwvBiXlx5lex6Qw0FODVHnEpJ25aHOr9wYGm8LZtQ0PQbnOZkl6r/sRg+
 hW3woEAps9U2PxARuHgyZeNDeN4kdQs14WX6eLoqBm8D012CL+O4CDgDoTYOwYOGanXp
 wQSg==
X-Gm-Message-State: AOAM5319M1waki5tjoTSJiIyMf4j5NMMKwXv+1gUFhLE10DXLEZAfips
 i8tIY/WPkZIyrEw1mRNO8AEQ1XoiYks=
X-Google-Smtp-Source: ABdhPJyt4R5MFRveV5qHEJpsce49Qczmkcw15XOMhCiDC9L3MuBAzG8q1z2SCwFopE+FReVNoIuppg==
X-Received: by 2002:a05:6402:203a:: with SMTP id
 ay26mr24737685edb.276.1593711521381; 
 Thu, 02 Jul 2020 10:38:41 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/19] .mailmap: Display correct email address for Stefan
 Weil
Date: Thu,  2 Jul 2020 19:38:17 +0200
Message-Id: <20200702173818.14651-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Stefan Weil email address in the following commit:

  $ git log --author='stefan@kiwi.(none)' --oneline
  f880defbb0 block/vpc: Fix size calculation

Also unify his email in the following commits:

  $ git log --author='weil@mail.berlios.de' --oneline | head
  9e4dd565b4 vnc: Limit r/w access to size of allocated memory
  657c166f8e qemu-iotests: README: Fix spelling
  3b5fe6e60c qemu-iotests: add support for vdi format "static" option
  c83f64d498 qemu-iotests: fix pattern for write test
  7ef6d3dc39 block/vvfat: Remove unused code
  ce137829e7 block/vvfat: Fix potential memory leaks and other memory errors
  5354d08312 Fix mismatching allocation and deallocation
  7f6f0ae5b9 tcg: Add some assertions
  c0ad3001bf tcg: Add forward declarations for local functions
  840f58617b tcg: Don't declare TCG_TARGET_REG_BITS in tcg-target.h
  ...

Cc: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 67f7d5caf2..f5ca5aa37e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -156,6 +156,9 @@ Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
 Sochin Jiang <sochin.jiang@huawei.com>
 Stefan Berger <stefanb@linux.ibm.com> <Stefan Berger stefanb@linux.vnet.ibm.com>
+Stefan Weil <sw@weilnetz.de> <stefan@kiwi.(none)>
+Stefan Weil <sw@weilnetz.de> <stefan@weilnetz.de>
+Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
 Takashi Yoshii <takasi-y@ops.dti.ne.jp>
 Thomas Huth <thuth@redhat.com>
 Thomas Knych <thomaswk@google.com>
-- 
2.21.3


