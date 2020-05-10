Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB3C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B25206F5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnUq7SQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B25206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXt6b-00016k-KX
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4r-00073R-59
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:37 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:45333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4q-00015R-C1
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:36 -0400
Received: by mail-ej1-x642.google.com with SMTP id yc10so4296672ejb.12
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4xpV43cJtjJhTGNuwU3vJ0xowPTiH8xsSOamwFx2umU=;
 b=bnUq7SQBGH34mmIjPwfHTqyfQJgChk3LmtgX5yjF65dLb9TtSZTGYvvq7uE/hBrUNQ
 wTPW77ZkABLX2VaCFgv3JFTzERV/NT6hiR12lYYQCL/xkpwWSriKWVmrazuCNaCZToOn
 x7Ra7cfCSUBq26b1P3dMXxTs8NSGJL1pr6XPkUfHnjdN3gmUBOVOyYBMlFBbz10tckc1
 gLqK8X/CYtF296Or792cXLHmnzPTnhCE+M1KY/IuiOdiwwyIAsVoTHzQgsU70CdZ5h64
 bDauYsN4fNmZwc8fObJiKsdzRRapZ94uadf8B439AsWFRu/0bHvuOXe2zr5/MNJie04x
 Or6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4xpV43cJtjJhTGNuwU3vJ0xowPTiH8xsSOamwFx2umU=;
 b=OOapKkevyfUjxQFnStpCfTtmm7/q6SumUGghw2Oea6xHdGeSzMNxHinI6C/38U9/LT
 HSh5k85rzUixoxENsqULIVJyjidNnfMxLQZ0tlD+4vSYBy5dkXq5aC+m8JOHJkCjcdDt
 kdbuOig9mIF9MN6XahLoKbnKvMprqymZROu2795TeWyC7gHGGgJlO+/3QnDN8TRth4sM
 i0wNzm+h/OCjs1WTHwBivIe74ZA9/bxpctVJscsm5rdytTUJVFVGec45+x9M4MHtBLPR
 EkUr96QEVO/ZrSTXM5jeIayMG9NMC8qfyq5mOG6bPlSykbA8A8H/vquF2T0rLllH6A2/
 wqzA==
X-Gm-Message-State: AGi0PuYjN3GIgETDTVDQNhPp7AEkwQkz91FC9Lffm4ZJwsZa0wf2CIXb
 x3QsXkrBhRXBkH/wRzB5U7VW1z/SHC8=
X-Google-Smtp-Source: APiQypL169Auu2EzRXblkbgLNKZEeT9/XxpJvoDVptfurJvOEQAO166ziZU+o+hapoT/jHfz7eJ2hg==
X-Received: by 2002:a17:906:ca14:: with SMTP id
 jt20mr10164192ejb.233.1589144494588; 
 Sun, 10 May 2020 14:01:34 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/12] MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer
Date: Sun, 10 May 2020 23:01:17 +0200
Message-Id: <20200510210128.18343-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <chenhc@lemote.com>

I submitted the MIPS/fuloong2e support about ten years ago, and
after that I became a MIPS kernel developer. Last year, Philippe
Mathieu- Daudé asked me that whether I can be a reviewer of
MIPS/fuloong2e, and I promised that I will do some QEMU work in
the next year (i.e., 2020 and later). I think now (and also in
future) I can have some spare time, so I can finally do some real
work on QEMU/MIPS. And if possible, I hope I can be a co-maintainer
of MIPS/fuloong2e.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Message-Id: <1586337380-25217-3-git-send-email-chenhc@lemote.com>
[PMD: Added Jiaxun Yang as reviewer]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f84e3ae2c..aa5c54c75a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1075,8 +1075,10 @@ S: Obsolete
 F: hw/mips/mips_r4k.c
 
 Fulong 2E
+M: Huacai Chen <chenhc@lemote.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
-- 
2.21.3


