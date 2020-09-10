Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24EAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817F9207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqaQz8ME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817F9207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMRV-0005vC-EM
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMPx-00040M-19
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:13 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMPv-00066x-BA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id s12so6632211wrw.11
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2cx8jHS3LDXcAjC1Gi1p55lLhOOKCtECYIqvv44WK10=;
 b=hqaQz8MEie1GF6oYswJDmywE8n12EtaZ4paup5LTS7qqWM++rSPPcSXwJvcG3Ub3q2
 Ze2LoN+xyT+FA5ITATgl9MrCxjg6cmbL6PsYKwKvMFoHoguDZkQsM7sRXcQ2qWE9VeHT
 MuL/CQoDO10jZX8hJN98uFnfv0Tvc4Oafcir6J9RU0NDloXo9iiwkivJZ0dETjJ09lbC
 MEDaZtXrpxCVB0hNCCEJ0d8o/hwoDRlWsOeWbExa52fgPSYh+gEz85xDz9wu3UnnsKlV
 250AREmaUjcynCdAlhNGIl33wKYV0OJgq0r29ZKudcbs0MYjJlQHM++FZ0dwcLfiXwkb
 q9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2cx8jHS3LDXcAjC1Gi1p55lLhOOKCtECYIqvv44WK10=;
 b=E+NAZV5pEUjUXwL27Q8LqkpU8lFlPLkVvPbqJoAfdXe+jAjg6Ou5gKdIMHZPlWr1t6
 +evVPd/sm1E0VMW2mPVAc+jADt1vd9jAx/uLynRWiAp/lXIy2kRkxaDH4+RNfjI4MwTd
 Tl3aatXPFe4uePVYImNnrEbLmlK4ljZCS3CpyKjV8x05y2z7mnzUBjY1O4UHhmY+isBK
 sEmrINpinsVywibhi7Mje/XYM5And8K2aP69U1dbkNlmSbdZR3lhBCTdDIiMQQuYGxxH
 sYAC7d+lF15+IXTi4NCSO3GU7JA3rNZyhyO1uirXeQdm89VYim7mpsbS6rluxkvqKq08
 R/qg==
X-Gm-Message-State: AOAM530fI9+mGQ7X3GGlr6p+0dZVb4CZfat35ubDjjlFDDnavTeEbEGa
 AUtxM4oUJEU/yQKU9Pb9pppbew==
X-Google-Smtp-Source: ABdhPJwKvxg4pb/T0NM2vcuAnrhbJ29Uf/o/3XpFNVmxwr2pPIcS8WlkrTehU6ecUo4O0wIrjqg+9w==
X-Received: by 2002:a5d:458e:: with SMTP id p14mr9053965wrq.61.1599743709923; 
 Thu, 10 Sep 2020 06:15:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i1sm11364022wrc.49.2020.09.10.06.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:15:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8F60A1FF8C;
 Thu, 10 Sep 2020 14:15:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/10] usb-host: restrict workaround to new libusb versions
Date: Thu, 10 Sep 2020 14:14:56 +0100
Message-Id: <20200910131504.11341-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910131504.11341-1-alex.bennee@linaro.org>
References: <20200910131504.11341-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Fixes build failures with old kernels (USBDEVFS_GET_SPEED missing),
on the assumtion that distros with old kernels also have old libusb.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200902081445.3291-1-kraxel@redhat.com>
Message-Id: <20200909112742.25730-3-alex.bennee@linaro.org>

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


