Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DE3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A0920691
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g57675sQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A0920691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLlb-00069F-7C
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjLel-0005jn-K6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:46:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37264)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjLej-0002yZ-DD
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:46:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id y20so4736583wmi.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xE8c8FfaektvQjlOylfBkEhJyY8TcI4rRTQe26NaWhQ=;
 b=g57675sQhFq3sQGj/bpEw2i9NxLQvq3wu6X2dFys2YwnHqis3Bdf/jLhd0SFzY66db
 eRau+AjAPSHj8CyW05esfOcJCPtPtir9gYUH4tVB6yGfjj2RGalb1ZuKpr3QmCS8G7WV
 DGT/4cKgjqxkn+UoZOOxAJONxJdTGRFaOhxIiDA9vLOpkLM4suJoTAvSi0NKPvQIX0+V
 iUN2bkbWEN2WWLueL12NIZRs8V/MROWoeBx7eRudr41saXssCyeJbIhLhUEjZ4+Deucq
 Ant787S+qjGmhLDR97d1WjaTdUKr8+BPvB4BCUZqPL18zHqehBHDU8LdKebpIYKXXSU6
 I57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xE8c8FfaektvQjlOylfBkEhJyY8TcI4rRTQe26NaWhQ=;
 b=qU/jf0wpXnJ6nzUVVMhpDqk6CoddeVMWZsN+xEQyKkoJxwk5UDC3tij0RAmFaXZqAa
 ICyDcjzN0I7QdIoFv5meWMOlZVulmxB4/7P7ihHFoAWjtsJ1SPODMzjMCe5HgeL43FQN
 IaVyKFo64J13O7fNz1Je6k76ywDZFdKBpjJPlDcw7eosQWXMo+akTh0/NDR9hyQnpOq8
 90uKkbWlrn5MxNT2vuF1Q0FaCaxWVAvPufnKzWRowhz7TF9DB8BqirXKzlJL8E9+rfwG
 L7I3NrAaMsPBTr2Ih4ifWXjdIsFoZo5FnNgosxxYbHwXkaiL0ORTPPYmiV2O+cjwwDoJ
 zuSA==
X-Gm-Message-State: AOAM533l2CFT9a/MDieKeURdG2pKKgMmLNTflcwf9qexV8zm05SW18rA
 71am2wIaySz/ZNqvxedTSPm92xr0ffc=
X-Google-Smtp-Source: ABdhPJyih606UCVQ3TZJfFzb35vLL7yTh5iVBOTm9ximtBfzHj0w1lsKUrz3wHFVkR9Ko1rGdxR7Xw==
X-Received: by 2002:a1c:a74d:: with SMTP id q74mr7793678wme.177.1591875954076; 
 Thu, 11 Jun 2020 04:45:54 -0700 (PDT)
Received: from localhost.localdomain (net53-38-245-109.mbb.telenor.rs.
 [109.245.38.53])
 by smtp.gmail.com with ESMTPSA id g3sm5089107wrb.46.2020.06.11.04.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 04:45:53 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] translations: Add Swedish language
Date: Thu, 11 Jun 2020 13:45:23 +0200
Message-Id: <20200611114523.15584-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200611114523.15584-1-aleksandar.qemu.devel@gmail.com>
References: <20200611114523.15584-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Sebastian Rasmussen <sebras@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sebastian Rasmussen <sebras@gmail.com>

This patch adds translation of QEMU to Swedish.

Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 po/sv.po | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 po/sv.po

diff --git a/po/sv.po b/po/sv.po
new file mode 100644
index 0000000000..1e430edd65
--- /dev/null
+++ b/po/sv.po
@@ -0,0 +1,75 @@
+# Swedish translation of qemu po-file.
+# This file is put in the public domain.
+# Sebastian Rasmussen <sebras@gmail.com>, 2019.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: QEMU 2.12.91\n"
+"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
+"POT-Creation-Date: 2018-07-18 07:56+0200\n"
+"PO-Revision-Date: 2019-08-16 21:19+0200\n"
+"Last-Translator: Sebastian Rasmussen <sebras@gmail.com>\n"
+"Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
+"Language: sv\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=2; plural=(n != 1);\n"
+"X-Generator: Poedit 2.2.3\n"
+
+msgid " - Press Ctrl+Alt+G to release grab"
+msgstr " - Tryck Ctrl+Alt+G för att sluta fånga"
+
+msgid " [Paused]"
+msgstr " [Pausad]"
+
+msgid "_Pause"
+msgstr "_Paus"
+
+msgid "_Reset"
+msgstr "_Starta om"
+
+msgid "Power _Down"
+msgstr "Stäng _ner"
+
+msgid "_Quit"
+msgstr "_Avsluta"
+
+msgid "_Fullscreen"
+msgstr "_Helskärm"
+
+msgid "_Copy"
+msgstr "_Kopiera"
+
+msgid "Zoom _In"
+msgstr "Zooma _in"
+
+msgid "Zoom _Out"
+msgstr "Zooma _ut"
+
+msgid "Best _Fit"
+msgstr "Anpassad _storlek"
+
+msgid "Zoom To _Fit"
+msgstr "Zooma ti_ll anpassad storlek"
+
+msgid "Grab On _Hover"
+msgstr "Fånga vi_d hovring"
+
+msgid "_Grab Input"
+msgstr "Fån_ga inmatning"
+
+msgid "Show _Tabs"
+msgstr "Visa _flika"
+
+msgid "Detach Tab"
+msgstr "Frigör flik"
+
+msgid "Show Menubar"
+msgstr "Visa menyrad"
+
+msgid "_Machine"
+msgstr "_Maskin"
+
+msgid "_View"
+msgstr "_Visa"
-- 
2.20.1


