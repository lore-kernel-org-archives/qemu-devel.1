Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E02DC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C49320656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4C9+1sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C49320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98d4-0002zX-CC
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k98cK-00028g-Gj
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k98cH-0003PF-FP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598022364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qus6fiddFzAKKm0LdJubRUv/SENFgdRTO2lacblbVgc=;
 b=U4C9+1sw/+Y4yViYaARAKBBjWCitl30wI4G31vA0UV9S4cSQHHR2EFn3Cwwdy36PPSMbYL
 kg7D9YX2Qsb8IUk/R5PW/IX6FunJd4z+H0u1xlF2l8Q0Lz3/NJY1vrkabeM+7ojiZxlOoF
 0LjpZRp9/GGC036FrWuZZXG5KBeQNag=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-wixnuOKfMtK4yeVY54kBPg-1; Fri, 21 Aug 2020 11:06:00 -0400
X-MC-Unique: wixnuOKfMtK4yeVY54kBPg-1
Received: by mail-wr1-f70.google.com with SMTP id e12so628666wra.13
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 08:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qus6fiddFzAKKm0LdJubRUv/SENFgdRTO2lacblbVgc=;
 b=BaLbNprIIJrl2kIlfgqT+FKJjqslackfaMKKjatLP3h2ETfemk6jCnU9hj2zWYlRWw
 9fNQSbOBPUrbSUY097zVC55vkCB6GDiul6vi8QJiwDl+td6Mxf44wvtxQQIfnSIthJm0
 DGX9D3Ripy9xp4yYeqSTq6AVl2kn/ruq0yl6OTu0JWW61R6sTUKlyzbd2eF2UVI04F0h
 aIIHAafSZlm2XUqocKFCLcdLFZwqmIycsqfsprvOmOxZXBn5s28VMsYDwUw+8rjl12mt
 lH9mLAT8mu9JTYbHWQuwxxxcsIEkh9y20H4XK8DHKEEXAUOEZSqVpQVhBNFpTs465yb2
 0T7w==
X-Gm-Message-State: AOAM530zd+3mLDbBztwfonaX8UpHSTuPKqkKvCZkMWjNibh3q6LUuEqe
 5y3JSSQatS9Fi0RoGaoRjFCzPP3iWGeaYDDXpG9rhkRwqu7o646NeJoo2xQ7M6x5ksXjhHOXM81
 F7+jSqd23LR9CUMs=
X-Received: by 2002:a1c:23c4:: with SMTP id j187mr3708853wmj.58.1598022359331; 
 Fri, 21 Aug 2020 08:05:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtOrtIyy/ch39NtBFYQ11yTa5712V4QHzKIOANQmUltIP7zbq/a25ZK3Jie0IzTwPxQTIfIQ==
X-Received: by 2002:a1c:23c4:: with SMTP id j187mr3708832wmj.58.1598022359028; 
 Fri, 21 Aug 2020 08:05:59 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v8sm2728914wrm.53.2020.08.21.08.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 08:05:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: Fix --disable-tools --enable-system builds
Date: Fri, 21 Aug 2020 17:05:56 +0200
Message-Id: <20200821150556.1235625-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes:

 $ ../configure --disable-tools --disable-user
 ../tests/qemu-iotests/meson.build:7:0: ERROR: Unknown variable "qemu_block_tools".

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 808f50b07ef..e76f8f6d084 100644
--- a/meson.build
+++ b/meson.build
@@ -1062,12 +1062,13 @@ if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
 
+qemu_block_tools = []
 if have_tools
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
              dependencies: [block, qemuutil], install: true)
-  qemu_block_tools = [qemu_img, qemu_io]
+  qemu_block_tools += [qemu_img, qemu_io]
   if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
     qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                dependencies: [block, qemuutil], install: true)
-- 
2.26.2


