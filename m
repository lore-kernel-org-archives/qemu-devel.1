Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98CFC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881B52075B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="td9VsUCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881B52075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsCoT-0003NP-Ox
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 18:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCnT-00024C-FN; Sun, 05 Jul 2020 18:07:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCnS-0005gM-0n; Sun, 05 Jul 2020 18:07:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id o11so38913621wrv.9;
 Sun, 05 Jul 2020 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lzfhTjPDSMsAmEthVOvWh0C1YJaD8c8jBr9CnQhIF2k=;
 b=td9VsUCxfs0QQZ+fsjrQnvm9g30GUS96767J0Tss+A0yUz3Tk/Z3ngcfcHidUj8mw2
 wm7gzC/18jqputzwFOYAkl4nDSk453gqPNl6EwulZ6jRLkaAFSxPznxSzUssq2VmrlN7
 vme+ewOjEPkNy5Jc73jgOQsaiCxknYo1b5PBJRhTv5HxL5ITIaRtuZH8Az/4krVarbCg
 p0nBpi/UAMisIDzLy2TsyhI271IduYGkukq9PwGmijHaEQfmjhswr2p4Q2T2z7E6lBEy
 JUHn/D6OVvImYG6T/K6Q9YiXhkD3q278PYgqdbh/ZLKenCvvRumGqNo7DnOooEOd9PSv
 wcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lzfhTjPDSMsAmEthVOvWh0C1YJaD8c8jBr9CnQhIF2k=;
 b=Kh8+WQmCLcxSAErtQMnca3RQv2BZGue7QjvD2Df89SXYAGFnxFGdtDyb/ccamVznRa
 +r0fw562L4ydUMdG9ThNx4c+o/8UxgbBKkQh+sB6qrNMcuo2nIK54alssMDrN9SFcahA
 ce0ZaSB4spnWed7zBepZX5NrXAlWLPrKVlLza33OG8IIxNCus2WAiR8fFA3qCuhLYSu7
 YpqexL4m4y3SJbbC9hHnjNdKXZfw1QXe3zE06a9kdt7ABNtZFZvkDVwaxL3puA6Y055k
 +82xT9SdFWC4d5tolI5oTjX00YHC3zz6VOYN3ZcaXdHzgfaWIm1SbaULRYZR564F52eT
 OmBA==
X-Gm-Message-State: AOAM530h5kOSqR8aapSq+tVBoK4dqZXSNau6W3TSVZpjk9q7HDwsftoa
 Tl1d/Gd0rfNDS0ee5SU2j7c6Jy57GGg=
X-Google-Smtp-Source: ABdhPJyPz//O3P/vfw/tzlcHlDraBvd8eZKALxCHzh3cykv6lN8FJB97AQC80Vwzx1JHZ0pHZVFl5w==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr43453903wru.22.1593986856243; 
 Sun, 05 Jul 2020 15:07:36 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j16sm21538214wrt.7.2020.07.05.15.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 15:07:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/2] hw/sd/sdcard: Deprecate the SPI mode
Date: Mon,  6 Jul 2020 00:07:31 +0200
Message-Id: <20200705220731.28101-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705220731.28101-1-f4bug@amsat.org>
References: <20200705220731.28101-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <huth@tuxfamily.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 libvir-list@redhat.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SD cards be used with SPI, SD or MMC protocol.

Unfortunately, maintaining the SPI protocol make improving the
MMC mode very difficult. As of 2020 users are more interested
in using cards with the MMC protocol.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/system/deprecated.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 5e67d7f3e0..01dca3d038 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -384,6 +384,11 @@ full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
 Note this also applies to ``-device virtio-blk-pci,scsi=on|off``, which is an
 alias.
 
+``-device sd-card,spi=on`` (since 5.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The SPI mode of the 'sd-card' device is deprecated.
+
 Block device options
 ''''''''''''''''''''
 
-- 
2.21.3


