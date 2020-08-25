Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB844C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5012075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC3oo2nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5012075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaKg-0005sS-2l
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAaIr-00028Y-Tp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:52:01 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:38790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAaIq-0000ZY-7a
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:52:01 -0400
Received: by mail-pj1-x1031.google.com with SMTP id ep8so1357515pjb.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ahNl6xGv3lvDsVsmUoTS6dtgGoj1wQWvaseozR7dTqs=;
 b=VC3oo2nm6kHuWgur5na5NzNdVPxbq4uAbOgPohSlBaiJ96DmZObxO32rbAltY977xX
 OkJlJckRnOm4UN9E/aoIOjvMPiNHjJMytwhmvwZJco1EgxEjg09bnnWhW4vbyYmU/SXS
 ghT4GDgr94b4spD0SuNgStVDMNMb9RmUU8XvlsiD3NriNmzfYzrd6RsQt0JpqBmZ5Pki
 FvflRlWnQzNr7iMdxED94sGrcS4k7ulfi9zHwH4XFYqi8SEAqtxmHv/rVSgwWPXYQMEE
 gNpZ+so1c1WCZVBTkEn6mFdAMdRxvWS5qHWnPfzWnrauYzX9rONh3nYCNFbZC8p2LYVl
 ZdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ahNl6xGv3lvDsVsmUoTS6dtgGoj1wQWvaseozR7dTqs=;
 b=iQoqHj3/Wu0H4+LA/JkTkO4ZrOwP2vS7XG/na8RKN+2w+Tp63Lzy4Ud1RCTkDFWVJR
 P/HLxWLp02iUtZ1SHVWLygsU8cSFDBytyA4Esp1GQmWwjsduUKKBqx0iitIDR3ocuMAT
 icPkHXlqEdtDeerAYY8fvxwW+I0gsQvgBO1wQsDxlwvWieuMKvBoLnoXt0O6swPlfbFF
 bgbfWGwiny8Ul64Qe1BPvbxrW+r8I1RVo9cHeqqkEArX4OugaCez7NM5YLRwO28N0qlA
 RqMxxdj1xgX0CWmSCn70FlwAb3J31ABqih1am/rdXXhZPHfYOocp6xZ/BJcjR0dQCfB/
 IPYA==
X-Gm-Message-State: AOAM530Jp2ghYCvMglXeLd4IVQ0uP6rNJcUJHIrQrap26+tj3uEqyNWZ
 fwOCneqUCq5bb+hDLEekwD8DPLrMLkLV8hie
X-Google-Smtp-Source: ABdhPJz4eH0YDlM9Np3lgVR28cyBjFvCQWGDakFBgqBfzFtDxpcNLdnX8m4PJ3ucoA2Q9Jzl7X5xIA==
X-Received: by 2002:a17:90b:3750:: with SMTP id
 ne16mr1922599pjb.6.1598367118413; 
 Tue, 25 Aug 2020 07:51:58 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id m22sm3104383pja.36.2020.08.25.07.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 07:51:57 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] meson: Mingw64 gcc doesn't recognize system include_type
 for sdl2
Date: Tue, 25 Aug 2020 22:51:32 +0800
Message-Id: <20200825145133.178-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200825145133.178-1-luoyonggang@gmail.com>
References: <20200825145133.178-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1031.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Fixes this for msys2/mingw64 by remove the include_type for sdl2 discovery in meson
---
 meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index df5bf728b5..a3585881e1 100644
--- a/meson.build
+++ b/meson.build
@@ -224,8 +224,7 @@ if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
 endif
 
-sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static,
-                 include_type: 'system')
+sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static)
 sdl_image = not_found
 if sdl.found()
   # work around 2.0.8 bug
-- 
2.27.0.windows.1


