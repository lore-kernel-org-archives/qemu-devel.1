Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E24C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D60120714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua581NpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D60120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuvT-0002Lp-Ca
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkunH-0003pG-MZ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:29:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:55864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkunF-0004lm-M4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:29:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id c71so674470wmd.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TRfjs1hFOy491CKhnS7ZjwNiAbqWZlAj2pF2jE/WL4E=;
 b=Ua581NpWKuiJU+1X0Eo9CaLRoKocASoUZPnD2Ln0kadGRvuzjgLsW/XoaOK/yDhKP2
 saNSafkf6jTsVuO7Bs5kJW5kVgY40/sY0AnIVjo+FyffsM8fbbhNvTvRLnR1sYnf+Sgh
 ZV5IA1kkM529kDb+lwidhN3J+Guw1SDQrWiunazyBy9iUH1EvQE9bgAeHodJ5F4nyRW4
 YCeJuJk+pQUxka31Na6PiZwlKM5fiw2DYRRgcmFjA6pmzAkRNNZKnGWBQaDJj9rVE4OR
 q+6wTaVBU94gmUxrHFUNmnEVGANoFpZ09tx8uwFp3T2foKlZxwuuMW6movoUmRWYTfIK
 YlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TRfjs1hFOy491CKhnS7ZjwNiAbqWZlAj2pF2jE/WL4E=;
 b=UQhhhUlvzW87pnk+C/svMEQfu4pe3QZgn25PWILZ7eoZoWqssoKMFiP5FRPBWdeGmy
 51lmZr5xhNRoxdmOqSUgh/0FwXEkyqp2yhfOcbXuifvhVYEI3X7t3Y3WgMOqpwRNDVEH
 Q9D5W2Jos2pZvEWTh1mfuMrtS/SGBl+ZqNy54oordW09PYTxx4dGAAOMD6IzUuXbrVC+
 I82hZ8GumxwVlkbP4efXqDWaB7IPrGQGhJNHfikKPh0GdGwizU1e4EIzY113yutmlF2X
 zc7an5XaGjQGvRbdC7JvhPM9w6Wo0Qqx2V8T9sWExq0bXpwDTsoYwpzvdN1G4Z1l9Odo
 +zWA==
X-Gm-Message-State: AOAM532fQVCg0HiIVkX2fXYXSAKhcIOjJ4jeua+Zpw/tA2NbbuIVF6X3
 kZB1TVveuJYnyy373rzL++TrSoHQ
X-Google-Smtp-Source: ABdhPJw7ShLxyEI2deoy1az77xRv4f0+4MCgl9gZbAbl8dKPhy7EkbexMgzsZdk0dAGHPip/C17YYA==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr869840wmi.185.1592249356178; 
 Mon, 15 Jun 2020 12:29:16 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 138sm713098wma.23.2020.06.15.12.29.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:29:15 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 18/18] translations: Add Swedish language
Date: Mon, 15 Jun 2020 21:29:00 +0200
Message-Id: <1592249340-8365-19-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
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
Cc: aleksandar.qemu.devel@gmail.com, Sebastian Rasmussen <sebras@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sebastian Rasmussen <sebras@gmail.com>

This patch adds translation of QEMU to Swedish.

Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200611114523.15584-2-aleksandar.qemu.devel@gmail.com>
---
 po/sv.po | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 po/sv.po

diff --git a/po/sv.po b/po/sv.po
new file mode 100644
index 0000000..1e430ed
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
2.7.4


