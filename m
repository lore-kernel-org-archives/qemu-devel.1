Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01811C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDCE205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQj1Jb8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDCE205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gZC-0007Z2-TR
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH0-0004Gs-QF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:07 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGz-00068a-Ah
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:06 -0400
Received: by mail-wr1-x429.google.com with SMTP id r15so5341860wrp.13
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RxTPKve4UPMsuDPCMcd7u6d232jLsll/CSW6mGhHCo4=;
 b=pQj1Jb8yqzSgjL6xMy2tKKojwBC118RWk9l13GX/dz79252Jd8uOIT1KguHp4QKPyT
 FTQ+R7W2k+mQP7jmgz7ZVukGguIVSpI5t+6UhgPNKTwGlNsZBzx/n36TDg0+Au7b/JLg
 kRaXHL6qpW6hHTjfDnjcxIxZKke8c9zVsY/+1eKlmKZDhBfh8hCWDrA2utOolY7VoYGy
 49D9d1pvAyB05Ilzsb16q7INi0PCD9vYXIwckso/pY2pXqwKPki/9TwYAmA5B9WKuHBT
 N0pcBkxNHD38GgiEU4jQJBpdAkDAiatFXoJvfPwXBxt7qTOeDkkz3dTwUKcdJNNYDnWe
 uH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RxTPKve4UPMsuDPCMcd7u6d232jLsll/CSW6mGhHCo4=;
 b=dAmDf3sCnMBJsPY1qHDobxhPOQTg1H0VfGw7bEtOmNx73j8yAqcRYhEl8jdI0t0oIT
 YamvWRWB+ht17rdaldRD0KJMLHJGuRO5RtmfEK5Fvgu5IhBYV3u+cGEbBRep/5/J2oX1
 /VcI39srFsebBKj4ukJfFvmfmalqycynuHZSZE8pQnOET/79uIQrBS+h/DvV34/Odeo0
 ini3CzMV2BM3pCuqJuy+qZoIGZNYexw1+oh4cKcsm2j4lSzk8lgRhuE86o5SuWPxqwDF
 dI8fYp62mzmk+gOYt7NuzPQr9OZRfc87c8YfOyOSd4t0+1rJijnnee80WyMDIQVtDU2I
 nTkg==
X-Gm-Message-State: AOAM532rmL8AiKyA7UcDHcEo8AgW86WV8N5tl01vwG2Qc1WDZZCRxlLX
 F7Y/ZsoZgNNjUdA7EhXT1Q+Xf0U9z04=
X-Google-Smtp-Source: ABdhPJxtkA7tdQ1s5fOUb5kcqLH4b8W6IaDcstBXHFQc7Lq+NxawupdISt7dD7QloWr2gr/l2NmWZw==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr15559661wrs.273.1597675083080; 
 Mon, 17 Aug 2020 07:38:03 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 037/150] meson: add macos dependencies
Date: Mon, 17 Aug 2020 16:35:30 +0200
Message-Id: <20200817143723.343284-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

There is no probing in configure, so no need to pass them as
variables to meson. Do a regular meson dependency() instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/meson.build b/meson.build
index 661f1bb4f5..34e2a7a3f5 100644
--- a/meson.build
+++ b/meson.build
@@ -46,6 +46,10 @@ m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
 socket = []
 version_res = []
+coref = []
+iokit = []
+cocoa = []
+hvf = []
 if host_machine.system() == 'windows'
   socket = cc.find_library('ws2_32')
 
@@ -53,6 +57,11 @@ if host_machine.system() == 'windows'
   version_res = win.compile_resources('version.rc',
                                       depend_files: files('pc-bios/qemu-nsis.ico'),
                                       include_directories: include_directories('.'))
+elif host_machine.system() == 'darwin'
+  coref = dependency('appleframeworks', modules: 'CoreFoundation')
+  iokit = dependency('appleframeworks', modules: 'IOKit')
+  cocoa = dependency('appleframeworks', modules: 'Cocoa')
+  hvf = dependency('appleframeworks', modules: 'Hypervisor')
 endif
 glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
                           link_args: config_host['GLIB_LIBS'].split())
-- 
2.26.2



