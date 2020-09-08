Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1F0C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED162068D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbFXJYuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED162068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFin6-0006QC-S5
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigp-0002Ea-UA; Tue, 08 Sep 2020 14:49:59 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:52597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFign-0002co-AL; Tue, 08 Sep 2020 14:49:59 -0400
Received: by mail-pj1-x1035.google.com with SMTP id o16so65069pjr.2;
 Tue, 08 Sep 2020 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qfatTX2Pahw3MLtTsQ90jsfuDFxj9dg6nxrJN7ZCMQY=;
 b=KbFXJYuRAA+f837G0frJWvS34bk8UZyzhdhhDtWp8ut0A7LFOQBtxvYdcptmwcOU+y
 mNL7VfQTC/ZC4WmZgEmvLSI3rxG7pgNt0JFYgdsqMIDuFfIZd3Q9kRD4S4m3ebtaKcKw
 DbZqSCOfn4ccm4xi9qDdE41UmWU6N88j85dp4QU6CnEtGZKDHOoi/xso9sebT5hnN/tW
 FNppbtrfHMY0Ww94N2Vpnaoe0UNP6M0hPmG4qfO0Zrl4v/ZX5MNpICcVQRtt/VoQCQhD
 ZUic5seHdPK/CSRDBd+3dVotA8JnEpEISEMmbpStEDbvch1Jc9NhxgOGY55g3x8iHKuQ
 8jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qfatTX2Pahw3MLtTsQ90jsfuDFxj9dg6nxrJN7ZCMQY=;
 b=nSjrxDj0dK/HznkQ4Ld/GtBlvgS6m9mSDY/BtO4ni3vjJvremlp/10HF6R5W7dBKR7
 Rq17oSXP40aKRqMFcORHbm9+ooTw+pSPA+He6W8M13X9w2SP0qxL2sZdWYAMazH/AZqz
 W2B6BNlwFbY+f+/CHKeYwJiXezDPxBdKfdk1cXAoveIX3iv+bC8VDD1CMsnDnfdvIbBi
 tCTz5vR1P+drbeEv907d9B/vLPRssvw3gmD+cNT16oW4ywXKAanOaw9NOJsr4vyzHQqj
 iFH34551LToFSyb7C1pBIjaRG9uX3yF2lnHfsqP3IeKkDLGk1rFjnfD5N0Gn4ykaKkRV
 i30A==
X-Gm-Message-State: AOAM532bE3FbITdlTIGwJuSnos7jeGHPPyHXLrlOw3shcpjJ19WPATt2
 11WF950PeJV27QcO22DSoi6yGZu/1htdHuXU
X-Google-Smtp-Source: ABdhPJxiW/8jqyKMg5vO61TjgtpewNwX6JMbTBLNRPL7LD+h0OhvM3mS14a4+Rb7ItafJJfWazmVAQ==
X-Received: by 2002:a17:90a:4803:: with SMTP id
 a3mr209486pjh.192.1599590990701; 
 Tue, 08 Sep 2020 11:49:50 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:49:49 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] curses: Fixes curses compiling errors.
Date: Wed,  9 Sep 2020 02:49:06 +0800
Message-Id: <20200908184918.1085-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1035.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the compiling error:
../ui/curses.c: In function 'curses_refresh':
../ui/curses.c:256:5: error: 'next_maybe_keycode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
      |     ^~~~~~~~~~
../ui/curses.c:302:32: note: 'next_maybe_keycode' was declared here
  302 |             enum maybe_keycode next_maybe_keycode;
      |                                ^~~~~~~~~~~~~~~~~~
../ui/curses.c:256:5: error: 'maybe_keycode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
      |     ^~~~~~~~~~
../ui/curses.c:265:24: note: 'maybe_keycode' was declared here
  265 |     enum maybe_keycode maybe_keycode;
      |                        ^~~~~~~~~~~~~
cc1.exe: all warnings being treated as errors

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 ui/curses.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 12bc682cf9..e4f9588c3e 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -262,7 +262,7 @@ static int curses2foo(const int _curses2foo[], const int _curseskey2foo[],
 static void curses_refresh(DisplayChangeListener *dcl)
 {
     int chr, keysym, keycode, keycode_alt;
-    enum maybe_keycode maybe_keycode;
+    enum maybe_keycode maybe_keycode = CURSES_KEYCODE;
 
     curses_winch_check();
 
@@ -299,7 +299,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
 
         /* alt or esc key */
         if (keycode == 1) {
-            enum maybe_keycode next_maybe_keycode;
+            enum maybe_keycode next_maybe_keycode = CURSES_KEYCODE;
             int nextchr = console_getch(&next_maybe_keycode);
 
             if (nextchr != -1) {
-- 
2.28.0.windows.1


