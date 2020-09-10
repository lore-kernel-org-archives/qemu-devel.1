Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE311C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DD620BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2rmHPho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DD620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK0A-0006iP-En
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJso-0000Zn-W3; Thu, 10 Sep 2020 06:32:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:39101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJsn-0003Dx-8B; Thu, 10 Sep 2020 06:32:50 -0400
Received: by mail-pf1-x434.google.com with SMTP id n14so4381851pff.6;
 Thu, 10 Sep 2020 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FMAHDxTONXsMLLCC/F2W4g5NRWoYLphvGLs4LjcpQd8=;
 b=f2rmHPhoxJaC5ujeeW5wQZjvXcrzJKzH9nH86dw+YKnSkO7Exo06FQ88QqHrHFaF9y
 bD7+wgj9c8uoI097yD3ZK2iyOS1iNlV1xn343LLbzDld7o5i/gB67TcFpk51cs+rxZ8C
 2HfJ6I1+Sa73y8iDrXu7JPUN8thBPAfoEJAHN4vdJIEQzxXLG2tbBpFZnsA8MzpVlt/p
 OXrDKDj9pWN5yqytI2aUvU978gTAMoVy25px5QMIOlaYAJIiHNqh4oBlfiYQc+/LjLu7
 sa7KqxQ7iu1kz0K7N3FvFjT4aK0Ki6lrPx6GUMg6wXQPlA6cgLx1fmO9CfQD9RLqhYqe
 cs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FMAHDxTONXsMLLCC/F2W4g5NRWoYLphvGLs4LjcpQd8=;
 b=YFXHKDeE3EBQWOyQGRS1NUxL/uPpzGzr0vQVJNDyoMwAb6ieLp9qb24ebRvq4Z1Aaj
 aY+jfkSIrLD0Cx6nVEG+y/aKNeOcAUalKd0DQ153pzaTYILSUoevnknAMubyOYOAdLQv
 mg9wL83wACenITnGdQoVpQPL4LMJ7YKQqf4+fUwjpxbprWi/0Wq89AXhHTlw8B1pOjVr
 W+W0deNVTd4CinmWmX2KnhAccDwQ0OZOeQPDGlTarpRiVwny+2XZphoaBiF1GXT2Rg7A
 Xymwyd+L8R7b+0HOAguHLxd3xg3UngQrO0AHhNR0yowpR7mo4WxxHAzoiPagtT86kBQi
 kNHg==
X-Gm-Message-State: AOAM532CTJB3fDzcN1KVWaROqCUWzedUHD5oyuPZbtnGq4nxMk91N0iF
 IsYJd+B0L2h9fPwvP7EWH5BnqTYVWfBhtM3EFTQ=
X-Google-Smtp-Source: ABdhPJz/SCTSdZWFXkt78xd0tpANoCwP9N4/aWaMXAM6+H0D6moygB0T2xd5qocxvy1N4NqNtdGIPQ==
X-Received: by 2002:a63:475d:: with SMTP id w29mr3787268pgk.287.1599733967167; 
 Thu, 10 Sep 2020 03:32:47 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id g21sm2000203pfh.30.2020.09.10.03.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:32:46 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 15/25] meson: remove empty else and duplicated gio deps
Date: Thu, 10 Sep 2020 18:30:49 +0800
Message-Id: <20200910103059.987-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103059.987-1-luoyonggang@gmail.com>
References: <20200910103059.987-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x434.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/meson.build b/meson.build
index 5421eca66a..0b1741557d 100644
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
2.28.0.windows.1


