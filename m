Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513C1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1588E2240E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Sdz4ZhnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1588E2240E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX8ew-0006Xa-0J
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 13:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iX8bh-0005us-7J
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iX8bf-00038X-5H
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:52:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:44891)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iX8be-000385-I0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574189518;
 bh=BHFquMdjSd4FMLus0Fyasc9g6bUubQ8gES8nfhfXDGs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=Sdz4ZhnTMvmSTsZItOU1XEZN/rsQqycRV1B0BV890W+ReGjaIa7hTf9cFyAYEJEkz
 3PiDoX4QU+/WIUR88NQDVuZ9HKDdYZr81Taq4cj71KZ+AI4wTYdYQA/82ca/QFPG/7
 sZ7andqOp45JgA1hpMymqxgk94VgvjhI/FB1zAao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.148.64]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3HU-1idg3h3Xqq-00FUKV; Tue, 19
 Nov 2019 19:51:57 +0100
Date: Tue, 19 Nov 2019 19:51:53 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user/strace: Add missing signal strings
Message-ID: <20191119185153.GA23003@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:Pe+5srPDD8R3aERvQLGzUMGej4c9uBzMOFoRWdRa8FB7ToI/5+H
 q13nCFxjGeruVx2NkmHPfAYCgtaZvk8jqxiGEipyBhFQaND7OSDZEwW/Liiy5rtaPKXu55N
 ODeGSg930YjFIoIINp4SaGWZo+zRUu/NIZHLOdpGmJ1dhvOn4izSVAA7KQHZI740F4lv5oF
 QXtoL1phDeForSnsKqjKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7UtbSB7gtK4=:d6xPTn8C4OtdiEwVV4gIC3
 LFJ2QCO2P3k0Ip2ZDjjjspMMZ738TfvRIxt0wzH4vL0GB9axFgjfeTzckQVCaG1o2ud/W0ruy
 G/EG32LzBSlHTZYijLeoEvVkN2F2ksmk3sO42/pYgAWlLxHGHzoxMe1PbpR0leW2eTT3sU6hf
 xmdm0L/alTiUFWaN4/lOkRcHWnWx9eIz3Xrx7QZPVWYvercsfa5qp9Zfofq1tWb5FtNTC6+GH
 hKhQLaaH9foFVaGqltbJ9IqxsvfUcZkwIT6bKPmhjDYjWN5YkDIiSh475wxQrgwxbVdILubqm
 ooxi7YulCoip43G/CySO1AiqG9FSwDcFc1nlHfupxLBat3CPT0QaNC8jrVCO4xE/Wf1mtS+CN
 31hBQJf0smxSn1madit9rtPZLFIrIqIFDN05OLttKNsUYwQ9ly+vT4IH+gEPbnzGN42UJUxvB
 /1JtbeYyCK0/UMbaKfCb8H4mAwDNeF+/m9AiZBwKwTf1p3S0sGeEJcx2Rgi1aISA4fH8d9Dxz
 hRqR250JhMLS4N9hikGHHLdj451E2O52rjj66BFJelA6Dl5/u8qGyPK/JqeSt+WhVqCYsHD43
 Sjmc5KNPfcnv+OugfdPyHv9PNfJIzzxz5nyihdo1vFd3OmDi4n99jhJGM8YJk1F3MbnhhQ9ov
 tnC72yQiaUFekiPxcMD5LKxDKOUmRcO1EOCrgR0EIyHCEZE8M1jvbg+LABB+oB+Sfl9qZqsUB
 f35e8W/crAznu7aANBS22AUO+KB739OcK5TSTZqtMJyvKnCMwPNjcz1G4vQeNs45z6RgfVHdK
 fqhYTLhkUjM0KpSxGoqS9HCRG4A92ZymdnKU6K8tlcohlUyk51tHCwa8UNcsoHAqDX+ebUR9P
 KTCt+olVsQaTUKkZNCoM95LFd74BiGOfDXFUvtp1DHvG9HGS0zAP8t+vN6k7MLGwZU49jvJBj
 gqJSb5r6P9bZCaAxaqlbDHVH9WFYhsIkmy1Yu2ri0JnJNwIi33EzRhN7b7qU8V1NvSL2070GS
 3IoFtBb2j3R53plx5XrZbr3yPDOLCltqipZHEVXcrT8NPj4+sdmNg6ja2eoWB37B9jTJ7xogx
 9YqVkaGZ2ga6727sWiqDmXPdEAG+WflVcNlg4b1lpqGS9qin8AxXXtHh1FVUu/wh3CZHiId6L
 d38YjQSsYzaXeM3gYMbUPizAJMangWuJQCD/NwZmj18Jgos7Rv1dDxFUDQxVvGkVvX2ipcNHG
 tizng5Wh6RoMFGnuUW2efZJX1F4hcv0xkY/soGg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.22
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
Cc: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the textual representations of some missing target signals.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3d4d684450..18b57a9ef9 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -146,6 +146,22 @@ print_signal(abi_ulong arg, int last)
     case TARGET_SIGSTOP: signal_name = "SIGSTOP"; break;
     case TARGET_SIGTTIN: signal_name = "SIGTTIN"; break;
     case TARGET_SIGTTOU: signal_name = "SIGTTOU"; break;
+    case TARGET_SIGIO: signal_name = "SIGIO"; break;
+    case TARGET_SIGTRAP: signal_name = "SIGTRAP"; break;
+    /* case TARGET_SIGIOT: signal_name = "SIGIOT"; break; */
+#ifdef SIGSTKFLT
+    case TARGET_SIGSTKFLT: signal_name = "SIGSTKFLT"; break;
+#endif
+    case TARGET_SIGBUS: signal_name = "SIGBUS"; break;
+    case TARGET_SIGPWR: signal_name = "SIGPWR"; break;
+    case TARGET_SIGURG: signal_name = "SIGURG"; break;
+    case TARGET_SIGSYS: signal_name = "SIGSYS"; break;
+    case TARGET_SIGXCPU: signal_name = "SIGXCPU"; break;
+    case TARGET_SIGPROF: signal_name = "SIGPROF"; break;
+    case TARGET_SIGTSTP: signal_name = "SIGTSTP"; break;
+    case TARGET_SIGXFSZ: signal_name = "SIGXFSZ"; break;
+    case TARGET_SIGWINCH: signal_name = "SIGWINCH"; break;
+    case TARGET_SIGVTALRM: signal_name = "SIGVTALRM"; break;
     }
     if (signal_name == NULL) {
         print_raw_param("%ld", arg, last);

