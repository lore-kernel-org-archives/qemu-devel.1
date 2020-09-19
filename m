Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87326C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEA320874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEA320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJhuG-0000b2-4h
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrI-00067I-Vg; Sat, 19 Sep 2020 14:45:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrH-0001LO-85; Sat, 19 Sep 2020 14:45:16 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRk8w-1juw063jWE-00T9wI; Sat, 19 Sep 2020 20:45:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/17] meson: remove empty else and duplicated gio deps
Date: Sat, 19 Sep 2020 20:44:39 +0200
Message-Id: <20200919184451.2129349-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4FM30aVi1Iy2LpVXvJqhXl9Xzp+1An/icoKVmYxtnEIPDbtAQgm
 G7ZqMhVoVZVIgAdCiQ857ceA5ivEJhe96T6XTu/4fJo44lLBwIzRjMoLTLT8ahpP8JNP/jS
 KpRJEfOcJ3n04zKeuDr6ECD4MQeXEv70agsaD5DfSujAefxnpsTdEwLfl+MEZezuysSeFPQ
 VyLQLl0jWL9P4FctmYZ/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9+3S2RkYR7o=:mSWJHHRbpFGOR69LldglEa
 jmY2KRjFWjhCUxM7AKN7tmxI3lvk5Fuir6c5TH5+TNf4vI1+atDodBBSE/0zPbb0QvUbYVwql
 r4yaVU1XPR3zGoUaPuefp89eyJexNO5HOjVKXU7emFnH0fcHERe+whg1e7tXGD2Lpsd6JdNsi
 w0NccCgYKeWdt8F91z0uDjCp89+6YTZ6PzHao11RmZw8obGlXBif/BuK9BBy22/7t8p6qdA3E
 OtJk6aGB+8STefPntGQatjZMUgjX+4CIYYJkJiWAkADOExRvJMiH7RBtGkX14dAkYhqVVk2sW
 qSbRzikGhL6ktr7b2auDmNS+LoW4PM4YQQPWDX89JskthFkN04i6fs8WJIV3KawJhjJ7IeXyF
 W3viQ20YaSY9Qpqvk5BxY2TYcPYFWRhRGpbUxA7VySzKopJGoLfi6GmeXwuiV/4st2w6VBe0R
 HxTtinVlvbCTMez2+gCPGpV69CJqxdoBI8J6Qd3LLDVA5uBoW/m27odQ0Z0n+26H6c7scbEZm
 v0t0zI01NaFLga/bUnSDkF0O4LTQq5EdeZ1D2IZhgVhi78PgJLT1KbzWOp6WqY5ZogovgLPRT
 T/kgcaQr12b+Hh3urxmTAIUfF5aMIJxnvobNeISknTrfLSbyPe1mp1NNeFbbHeIvlNmrA5lFM
 TYzEOrF6VfBEwlfc/ZL48aTKo/A6fxRKqzzbQoFRS+CRe/qWoEL+pOpuGKH2hXTCeWf8X12Zl
 gNcCGmDGyNfH+lUwwM3b6jH+mTqJRy8q1izyL9updRSckt8OqXW3XDzJ4d1H3e9YIE5UCfztB
 8ReoEXltEU57YN9xcpF5/Z9x+d9K+07DKLvf8TSIC/NTMHHYuPA7bzXwtZAMyiMFa5tkzFN
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200915171234.236-14-luoyonggang@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/meson.build b/meson.build
index bba766b4bc66..f4d1ab109680 100644
--- a/meson.build
+++ b/meson.build
@@ -317,7 +317,6 @@ opengl = not_found
 if 'CONFIG_OPENGL' in config_host
   opengl = declare_dependency(compile_args: config_host['OPENGL_CFLAGS'].split(),
                               link_args: config_host['OPENGL_LIBS'].split())
-else
 endif
 gtk = not_found
 if 'CONFIG_GTK' in config_host
@@ -344,11 +343,6 @@ if 'CONFIG_ICONV' in config_host
   iconv = declare_dependency(compile_args: config_host['ICONV_CFLAGS'].split(),
                              link_args: config_host['ICONV_LIBS'].split())
 endif
-gio = not_found
-if 'CONFIG_GIO' in config_host
-  gio = declare_dependency(compile_args: config_host['GIO_CFLAGS'].split(),
-                           link_args: config_host['GIO_LIBS'].split())
-endif
 vnc = not_found
 png = not_found
 jpeg = not_found
-- 
2.26.2


