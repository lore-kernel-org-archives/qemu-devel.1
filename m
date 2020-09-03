Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF79C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751192078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wF0awVtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751192078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnMq-0000hK-Js
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIs-0002X5-Ns
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:18 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIq-0007ZZ-Vy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id c15so2748623wrs.11
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UfLmeyinwTfx2td9nAoql0B4G0Y9Mq+vo4wZTVDMAU8=;
 b=wF0awVtBYPJArW7TWAsBK0ccboGjoqzO51X6s9PioA8XT0x5TU38ibBcQUNAYmYOxu
 GgwA74/wL4FSNIrLZSSeTNfCYPLExPlJN/+MdvMgeZAkk/+qlH3MMSTmSiheRSaiXtV+
 a+6vpjsMHlhcKpMtJVup9CjjVJtMluPt+NuncRGroynfPrAGVS48n267uEWa/VK8VFP3
 KvgC4MCfA/qLkljDvYujZ6MfKn7L2CA/G1X5A5O6YE/dO6Pjvo2rnpNeM0xI2aDcoyhz
 bGmLliAu6SNt84YjaUgKvAIr2HDbo4t7Soq+BZGdZSiGvg7DmW7z0VrE0U7Y12splMSJ
 oUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UfLmeyinwTfx2td9nAoql0B4G0Y9Mq+vo4wZTVDMAU8=;
 b=PYNfEqDHhi6gq/KUvvVpi9QGQTLtUd0PJoEdF/WuTtor7q0qZKxKTkR31jEewhyOaf
 /3MQoq/J/eAtaKAqE14qb5Rk4drXqMEy5skm+4BmaMyyqPddKTN8bNPtyb5eZdUK/Ot+
 feRUwGQ30o1scMrbJaIsGiC7IEG6k6bUhVGt3ziTrtG5zem1qzf0hPYbLv9R9PQ0Djty
 g9dqTA2AuzQV3KoasHOa050bQUpKXK2A/ZksO/gyZ1Q38FUXN+0UW1DxDcCM4HUZDjkL
 l9udFA+5LgjgcA1/Cs7slm4G0oxcUXiTqCdcI1XnXB4joBWbIUs21dioMu6R1X2tPyRl
 lXAQ==
X-Gm-Message-State: AOAM533m8Uk6wGYSyY2NyRcnltK5uixVtjqOjTZDzzeeiB1QqkQSgnO7
 eyLDKkKwQwneVfwVu9c+rXUlfQ==
X-Google-Smtp-Source: ABdhPJxTP0mCVvmktIHUa9RhZZzHTf3S3S2mSFSYCl8rPRvNyE/gNQEEaObOdnzBy9AeVgEx6FLuzQ==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr2091917wrp.340.1599132075605; 
 Thu, 03 Sep 2020 04:21:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 2sm3825191wrs.64.2020.09.03.04.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:21:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 217B51FF90;
 Thu,  3 Sep 2020 12:21:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 4/8] usb-host: restrict workaround to new libusb versions
Date: Thu,  3 Sep 2020 12:21:03 +0100
Message-Id: <20200903112107.27367-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903112107.27367-1-alex.bennee@linaro.org>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Fixes build failures with old kernels (USBDEVFS_GET_SPEED missing),
on the assumtion that distros with old kernels also have old libusb.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200902081445.3291-1-kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 08604f787fd..c5d38cb09c0 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -942,7 +942,7 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
     usb_host_ep_update(s);
 
     libusb_speed = libusb_get_device_speed(dev);
-#ifdef CONFIG_LINUX
+#if LIBUSB_API_VERSION >= 0x01000107 && defined(CONFIG_LINUX)
     if (hostfd && libusb_speed == 0) {
         /*
          * Workaround libusb bug: libusb_get_device_speed() does not
-- 
2.20.1


