Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1E4C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C2720673
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPLYOztD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C2720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdglx-0006sW-Kl
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 16:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55966)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgYo-0003v4-4w
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgYk-00065D-BO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:47:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgYi-0005bC-C7
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:47:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id m3so534237wrv.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=onoeKhH8i7/jHDfnhI6V24OKwHYPamArShy5EWC2B6w=;
 b=bPLYOztDZhjrRxVwKgFe5togLrKirPuJkAAU9VtDd3RNium9uKaD3Exmu1IZXJZgd8
 AXqvng71GAQh1hD6LLMEJgNL2dLMY3NrKkwmzyflPzsE33FM8tyrhRX/L4qi82+YI9UN
 TkPCuzftqXfoCLPXler9X0GGLGWADYeWGiHN5Lr4DD8JxSXC64v0iCXI3ILgUgqLbpcB
 LfBUhKX+P70E3eTASlWga+g1KVnpT8jXbh+E86GSDfO24SgrZh7gG59VXTyqQi0grKc+
 Cami+ocTN32GmC/8r908V/5LB7+kF1hNR9MlCMzDvUhORdHJOj5I9d9XZSuRLOV+HyUD
 qVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=onoeKhH8i7/jHDfnhI6V24OKwHYPamArShy5EWC2B6w=;
 b=jUzx4MpOIgDwG00NYiYbLY4EYxd02nEVQROOwmfOwsFYW66/LDPJ+7IMaHMhbWQQXa
 Al9kCuxdYeicgoQgeiq2/F0Mpp15eP+597gtLHgmfqTdcpxfxcOCFyTjevzbjgIsRgf8
 D/xdeAYJx7cemqm/QkJYM26/H7QuQvLUlFP1HQ9Dlh6GdpVFR7/530uCzuDm9Xm/204o
 231qD9WJGmPMWY4/VhO9U6N59i95N2PeHV9TTXWPDEtzyhe/bkOM2V2L8am0ujMi9FPf
 UfeAw3L81pdqz5cIbiwMrQVY2fEm9IkzPrPyPuNVdeGfD5bd8SDf1fiR/o1lF+ALFDUJ
 tCUQ==
X-Gm-Message-State: APjAAAU8OdY/dSJlEVGRY+4xdf6fqXtsVfzcoQAn5Jt9d1a/8f4t1nqB
 sr/8vNDLtTJuD681gO5gSkea4A==
X-Google-Smtp-Source: APXvYqy1KrB5hQO+mR9wPB/Ic6QtSsz9KNRxaP966bWFOWM/JhvJfogsvb/8adkmG4xDmwcge3Hqng==
X-Received: by 2002:adf:da47:: with SMTP id r7mr44177wrl.56.1560973639809;
 Wed, 19 Jun 2019 12:47:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n14sm16674768wra.75.2019.06.19.12.47.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:47:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AEB0A1FF9E;
 Wed, 19 Jun 2019 20:40:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:19 +0100
Message-Id: <20190619194021.8240-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PATCH v1 15/17] tests/vm: ubuntu.i386: apt proxy setup
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Configure apt proxy so package downloads
can be cached and can pass firewalls.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190617043858.8290-12-kraxel@redhat.com>
---
 tests/vm/ubuntu.i386 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 3ea459ee20..38f740eabf 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -51,6 +51,10 @@ class UbuntuX86VM(basevm.BaseVM):
                           "    ssh-authorized-keys:\n",
                           "    - %s\n" % basevm.SSH_PUB_KEY,
                           "locale: en_US.UTF-8\n"])
+        proxy = os.environ.get("http_proxy")
+        if not proxy is None:
+            udata.writelines(["apt:\n",
+                              "  proxy: %s" % proxy])
         udata.close()
         subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
                                "-volid", "cidata", "-joliet", "-rock",
-- 
2.20.1


