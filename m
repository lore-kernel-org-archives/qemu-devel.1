Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67AEC433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 10:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3C02076D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 10:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3C02076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kByJt-0002Zc-Ot
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 06:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kByJD-0001tB-5C
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 06:42:07 -0400
Received: from mailout08.t-online.de ([194.25.134.20]:58618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kByJA-0007yn-U5
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 06:42:06 -0400
Received: from fwd04.aul.t-online.de (fwd04.aul.t-online.de [172.20.26.149])
 by mailout08.t-online.de (Postfix) with SMTP id 8104F411C908;
 Sat, 29 Aug 2020 12:42:01 +0200 (CEST)
Received: from linpower.localnet
 (bNl1qiZ6QhY7rPjYlpJP7J565md+5zNtzzdyqaaH7C8EaEnh0TejTDht94QylqmQeG@[93.236.153.131])
 by fwd04.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kByJ4-20FM5g0; Sat, 29 Aug 2020 12:41:58 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 443BD200637; Sat, 29 Aug 2020 12:41:58 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] meson: fix SDL2_image detection
Date: Sat, 29 Aug 2020 12:41:58 +0200
Message-Id: <20200829104158.7461-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: bNl1qiZ6QhY7rPjYlpJP7J565md+5zNtzzdyqaaH7C8EaEnh0TejTDht94QylqmQeG
X-TOI-EXPURGATEID: 150726::1598697718-00004F6D-F4CB8C37/0/0 CLEAN NORMAL
X-TOI-MSGID: 2ea7af8c-6bbd-4832-88aa-cf000e6e2361
Received-SPF: none client-ip=194.25.134.20;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout08.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/29 06:42:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 SPOOFED_FREEMAIL=1.26 autolearn=no autolearn_force=no
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Configure used to probe for SDL2_image in sdl_image_probe (). Meson
should do the same.

This fixes the following error on my system:

Run-time dependency sdl2 found: YES 2.0.8
Found CMake: /usr/bin/cmake (3.17.0)
Run-time dependency sdl-image found: NO (tried pkgconfig and cmake)

../qemu-master/meson.build:256:2: ERROR: Dependency "sdl-image" not
found, tried pkgconfig and cmake

A full log can be found at /home/ruemelin/rpmbuild/BUILD
/qemu-5.1.50-build/meson-logs/meson-log.txt

ERROR: meson setup failed

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 74f8ea0c2e..8204878860 100644
--- a/meson.build
+++ b/meson.build
@@ -248,7 +248,7 @@ if sdl.found()
   # work around 2.0.8 bug
   sdl = declare_dependency(compile_args: '-Wno-undef',
                            dependencies: sdl)
-  sdl_image = dependency('sdl-image', required: get_option('sdl_image'),
+  sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
                          static: enable_static)
 else
   if get_option('sdl_image').enabled()
-- 
2.26.2


