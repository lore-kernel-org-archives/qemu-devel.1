Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD4CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A002080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3wBalM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A002080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBA7z-0004sp-Uj
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 01:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBA76-0003FT-CF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:06:16 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:55620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBA74-0005f6-Ou
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:06:16 -0400
Received: by mail-pj1-x1033.google.com with SMTP id 2so1994258pjx.5
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 22:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kZmgaDEBNjpxaFbsHI9krVOWSzauPOV79k08lIpZd10=;
 b=B3wBalM/yDYmUtfyBo1U/JZUa5rZT3EMGdbAd10MfTBZ+zwrKkWkllIQkl9/CO32RH
 TyOvL32luqe8bwdMqF0Ys8o9o6U3vyefVGx+r3dsR2yDs86fQ2efvqkKj4eTjtX+8nb6
 0/zJqemfVaIvAJfGeZsMRCDgdoaX4yIIBsBqMNMFr8O28ASxV6d7TFhbyxM7LqR4dqh4
 xO5AYA0/WLMpDbbn4Poy9YbdCvrRmUzMAkH53ypPrRWxV0HJEwxlKLqKrbqQg8Wqua5n
 hbJJKS7uVyThZ0xfBCUIgZYJsRJFcJxkCgmjj9NN9KEcZImueba+Q1utpgMk+lUUC4Qv
 HZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kZmgaDEBNjpxaFbsHI9krVOWSzauPOV79k08lIpZd10=;
 b=c4mOc6devKTY7yzlAo5pXig8M3QWKbdTf13hMP28TIhfT4iAvksjskrYhVQXRrLZED
 lFmOs26uVw88Mu5mDaJm6rT8igsDABNC+6eKFfoayr62G7Zi+KDX3fE9Ik78l6evXG2y
 wYqyYr/Fupi1/7nDfqn7iPT+mTd1ze8OFNNt2pyJsKkuYzwJ8uA3+RAlixO7UmvdgJkh
 4CnRkv8souL6VcuDJGJSexb03CqGH6wmBh9pZ2JI/TE2A772B3rpCyIVCRUAzxvYU/lY
 n0DFsSZuNU/hQfBXHq6A2gCDs9BECN9qNP5SjyK0Uv8Loo3I9OoB55qTLB8oL+mTriqy
 qnaw==
X-Gm-Message-State: AOAM532b9uS+iVoLhoHOq7gdVMmWpfdUQCvJP5YuoQTbCarFbURpTl33
 KUzwSv8Vahyotm0pGVFurPXRJWeBG76wIeMFdjo=
X-Google-Smtp-Source: ABdhPJzox6zVI7SZ2VdIibKNtUHjdRTTqySlXPSzOJnAvPE5ZVJyCGjkLQJJ9jVaO65ED9YzGc6N2w==
X-Received: by 2002:a17:90a:c505:: with SMTP id
 k5mr8718507pjt.188.1598504772817; 
 Wed, 26 Aug 2020 22:06:12 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u3sm724213pjn.29.2020.08.26.22.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 22:06:12 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] meson: Fixes ninjatool can not be recognized as script
 under Window/MSYS2
Date: Thu, 27 Aug 2020 13:05:42 +0800
Message-Id: <20200827050543.44-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200827050543.44-1-luoyonggang@gmail.com>
References: <20200827050543.44-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1033.google.com
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=E8=8C=85?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

use ninja instead ${build_path}/ninjatool

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 3b9e79923d..2ad0c58492 100755
--- a/configure
+++ b/configure
@@ -8222,7 +8222,7 @@ fi
 mv $cross config-meson.cross
 
 rm -rf meson-private meson-info meson-logs
-NINJA="${build_path}/ninjatool" $meson setup \
+NINJA="ninja" $meson setup \
         --prefix "${pre_prefix}$prefix" \
         --libdir "${pre_prefix}$libdir" \
         --libexecdir "${pre_prefix}$libexecdir" \
-- 
2.27.0.windows.1


