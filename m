Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735C7C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07AE2145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDHBlZPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07AE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNPZ-0007we-Ol
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNNs-0004v7-RK
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:05:00 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNNr-0008N9-Ab
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:05:00 -0400
Received: by mail-pj1-x1044.google.com with SMTP id u3so3645645pjr.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VGO4+PaElKcWPhGSq+Z0Hv66foMvUWF38Vy+iNilzKo=;
 b=hDHBlZPbRxJIX+b61bXHzDsHhsCmTmmWusfYaFDsYzRZ0zbiBbHZISSIC/C3HxWrQg
 sR6I3PAzewDkn5VJh1yvLnTmpKi4tR9kMSy/WfEqmGIbFmdQ4NZBqqucbTrX8tC7kfYX
 /IZst0F5nDRb/64H7TuZaKgFtx/7Bpj1nCYV2i4NcZ/WC46NETczNpWrZjVVW+lw2Wh6
 oUfSNZt4Df7IQX1pwoGH7CwrJeyAB2D9k2gTBVKncnd2OhuAUHFmANSfxvzF5xWkox7O
 LJSL3afugfDHdhIYzfhgFzHnkUZ6E0cLdXdBXbv0W3+h2lsDQcOvwpGpIHjcEL4CHyho
 GgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VGO4+PaElKcWPhGSq+Z0Hv66foMvUWF38Vy+iNilzKo=;
 b=luq3+y6LnjZOVac76LfoXma5awz2Acnp8VuYPR7IgDFf+MiITI/aVIAIDONh6clXTw
 0hOI9sQ5XZs2nag6gHhwJEz4AZYSNt72pmpR08MKjmnL1QO9WPHPT4RGdizWqwfhKKXm
 +1Qg/vWjmgiEHFmozCEd5ufs/SEhas+gih4ZnEf0CcWd5tfqB+JBc0jP/HZuv5UZsP2x
 JMohXOWbBHEg+Buee3/UFPVt7cAUeoEdC3tGFQrYC7o9ZE35Tal0EHQuT2BcOlQEbLrB
 twMnkz8O9914hNCFg4lkGgg9Wk+HLpR3T4DJysGG8NqW3NARXOtqumOh43BSM2zP400z
 ao8g==
X-Gm-Message-State: AOAM532dwJHDhq1a5Xyju2tDAfAnpCq+xbJWepbMNL23b60Mm/A7ghXF
 cGATfGus/R+FIJJ7niU8/5YYmPA2+CvsM+3L
X-Google-Smtp-Source: ABdhPJxHFB2eEiYMTWsYgej9S8779EH5mOFjSNV/7QBaynkysGensSo+A+fezuMS05hheoq20WFqPw==
X-Received: by 2002:a17:90a:384c:: with SMTP id
 l12mr755243pjf.27.1599509097549; 
 Mon, 07 Sep 2020 13:04:57 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 204sm8713098pfc.200.2020.09.07.13.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 13:04:56 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] vmstate: Enable test-vmstate on msys2/win32
Date: Tue,  8 Sep 2020 04:04:32 +0800
Message-Id: <20200907200432.2418-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200907200432.2418-1-luoyonggang@gmail.com>
References: <20200907200432.2418-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=E8=8C=85?= <philmd@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vmstate currently disabled because compiling error, but now its fixed

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/meson.build | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/meson.build b/tests/meson.build
index cf816a33cc..09b9b4462a 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -185,11 +185,9 @@ if have_system
     'test-timed-average': [],
     'test-util-sockets': ['socket-helpers.c'],
     'test-base64': [],
+    'test-vmstate': [migration, io],
     'test-bufferiszero': [],
   }
-  if 'CONFIG_POSIX' in config_host
-    tests += {'test-vmstate': [migration, io]}
-  endif
   if 'CONFIG_INOTIFY1' in config_host
     tests += {'test-util-filemonitor': []}
   endif
-- 
2.28.0.windows.1


