Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0C2C47426
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA60921D95
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA60921D95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpNf-0003WQ-0R
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGi-0003se-F9; Mon, 28 Sep 2020 05:16:24 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGc-0002YH-TG; Mon, 28 Sep 2020 05:16:22 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MW9zm-1jup3n02pO-00XaX8; Mon, 28 Sep 2020 11:16:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] docs/system/deprecated: Move lm32 and unicore32 to the
 right section
Date: Mon, 28 Sep 2020 11:16:02 +0200
Message-Id: <20200928091602.383870-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928091602.383870-1-laurent@vivier.eu>
References: <20200928091602.383870-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+3XyjQWo7hbvEPBru/BIEmw8goeduKyoLSR4CTlx92oDFQVw2ml
 NR1gX7hzergWncNMRveL2CACFimtJUX6fzYWn2U0dGw/nJHOqVL4AtvvruHLqPxvJekReOu
 GxihtdHsM9+cC/B367MLBa4HZaH8cxeVv7rRiuBrI4J3GAIIhM4uSCqRM16GcyRiRnVUF0D
 0Dqxj6d2fzXDuggDNad5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RWQxJRov2v8=:5s51v1Dha6ArO2nVmmD7RU
 86pX49GSKqthT26sVblwYHfLXW1c0WfvT/8tYm2MseBvWJzcn019LjUeX2/a3oX6eRU+ENcaG
 8WUPvx3UmDcgf4zZKoHBJQOLuMLTGzfKbgSf78nj3ViJneAWMA2LsNJT1dBy/kL8kd1g6K+2p
 cYH6rCLCRB+2MK+KAKUIu8Y1seagQnsnADm6Pyb+8mwEctaAddRlaHYBs0kfmQoAV6w/CNM79
 ddretTxNNkbEUa4v8LGTG+lI/jZMMK1/p9P0kHj+x0Q+icTlh97RTIUbTYvEl4InmZR0wo0g0
 /8HmYn33tbuIyw7pcHALeSClcquW9d1Bj86f/qF/SBo0GDf+AV4ZiumuviFsbBMRIjMfdyShC
 z9y6IkHTYhQVljCKyBK8pcV55B8mxUzW8t5rfSgJFGpC7Gnr8cgDBonbF7Z9D1WmN6qI02HCv
 UVf7varNDdbkuVBIP/55tOVCF1NU29LqO9qzGcbCYxpHe1RAnkYpH8iRod4QjF7Uq+s9L8SB/
 qip2nispfkg0DPrwvvY2GXqWnXV54o4h4gGJ9WJKFsJcUEtk5qYOTZ+/7laj6g/9WzmD+W1fj
 4RbS51g/BE4Mt8iCyIR2wMu9cGd8VwvDvR0zFhjOoWG/41jm15SJiYJzhmJkcjnU0r/Fkp/qP
 KnmJ62clwMBpnarhBhBDfDVt6YmjncvwWco453uBy6gQjKU5wmif3Gkee5TFrwsy+BeFjsbwj
 M+l2SUtTPnKJNdH3mzJE2xzc/GFRZwZ67J7JQ9IoiN2q+qAW7OqT15sfKbHT3w1yvC/HP1WxI
 TLstW3SMjDQB9DDlMA9JBOp/zzHUBC7sF2myZzixzOiOsrHnXMTk4dQitOX3I8SvtFcIU45
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 05:16:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.462, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

lm32 and unicore32 are softmmut targets, and not linux-user targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200923080015.77373-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/system/deprecated.rst | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 808c334fe74d..b2f383ce52e4 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -329,6 +329,22 @@ The ``compat`` property used to set backwards compatibility modes for
 the processor has been deprecated. The ``max-cpu-compat`` property of
 the ``pseries`` machine type should be used instead.
 
+``lm32`` CPUs (since 5.2.0)
+'''''''''''''''''''''''''''
+
+The ``lm32`` guest CPU support is deprecated and will be removed in
+a future version of QEMU. The only public user of this architecture
+was the milkymist project, which has been dead for years; there was
+never an upstream Linux port.
+
+``unicore32`` CPUs (since 5.2.0)
+''''''''''''''''''''''''''''''''
+
+The ``unicore32`` guest CPU support is deprecated and will be removed in
+a future version of QEMU. Support for this CPU was removed from the
+upstream Linux kernel, and there is no available upstream toolchain
+to build binaries for it.
+
 System emulator devices
 -----------------------
 
@@ -408,22 +424,6 @@ The above, converted to the current supported format::
 linux-user mode CPUs
 --------------------
 
-``lm32`` CPUs (since 5.2.0)
-'''''''''''''''''''''''''''
-
-The ``lm32`` guest CPU support is deprecated and will be removed in
-a future version of QEMU. The only public user of this architecture
-was the milkymist project, which has been dead for years; there was
-never an upstream Linux port.
-
-``unicore32`` CPUs (since 5.2.0)
-''''''''''''''''''''''''''''''''
-
-The ``unicore32`` guest CPU support is deprecated and will be removed in
-a future version of QEMU. Support for this CPU was removed from the
-upstream Linux kernel, and there is no available upstream toolchain
-to build binaries for it.
-
 ``tilegx`` CPUs (since 5.1.0)
 '''''''''''''''''''''''''''''
 
-- 
2.26.2


