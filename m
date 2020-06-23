Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01161C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1898206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwRUgexH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1898206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jncU7-0007gd-Ue
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 02:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jncSw-0005zJ-EY; Tue, 23 Jun 2020 02:31:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jncSu-0008Hn-9b; Tue, 23 Jun 2020 02:31:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id l10so19221701wrr.10;
 Mon, 22 Jun 2020 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VZzu6gTiCGeGLP6kjEvrLMyDSy9vcUBN//ownPF+RUg=;
 b=NwRUgexHq4bWutfYcKddwaGQdHva08KmayZpldk3ETrQ5bFzQW07PZvC+awA9oxx2G
 YUGMqSGcCUL9myHvrk+hmoU8mrIOsp7udPIuecu0Qbu71YAcYH+qYOx20Sux3XY3d1wv
 DmzSCX9QqKRsHMUHSEx0VMifJvAfBUqYU7ypp9hMeijGxuCPMPpBq6Lq4ncyi1CQ70g4
 F4xY0DwunJWYUcxlOxCQCIMLgnbmTjwAaWnwFoJ/Y4D28tyL+MMwFWjAw2XABQD6Bqus
 ltXB81cC9MKjbOACN6coBz9492N1zcD7LRZNyV7GKsj+LfNn8J3lEHtWOnFPKQ2eMRAe
 4HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=VZzu6gTiCGeGLP6kjEvrLMyDSy9vcUBN//ownPF+RUg=;
 b=bqTaQ8Bw8HZSvMjDcozJNkD2fYv+PtzuvSL9dWGHb8mS1SlsyjT8SRR8mDKqRT30i2
 zAZLB2Sg2KbsBR3V1S3Q/d3pdXW7V2rJwbdZwe4DwkJSLUkiP63ULbygbsQBkog4GsxA
 8K6vXNGj0+KPEb+IwBPp8r6bWOh/yAweSEoyy2hf4o2uYJJimczJRCS0FDLnLu0CNcOI
 L/9M6DjhGq5Z90o3vYo3JFrVni10KQfBMQOqg1up2Cf4JqiedkpdlkleZOX7Tj4hzYWU
 oGrXYNuRm7uilqJXqBtTncSpSLyLyO4dRVqm+Ih8xSn8iGRsU+7t0AcoFrhP0h7J8F0U
 If3w==
X-Gm-Message-State: AOAM532x+Co7IaxXuCYJX55IKPAXadYEn8ZUgD7LoK2Ra8LvvTlVcWAJ
 i25Xr9WyJ/H5toKr88xMut1fCQJy
X-Google-Smtp-Source: ABdhPJyBCyAjAgievOk414PvrM/qlruEt/7f7MFd9d7KP3/HTUz9kBZoK6R4dd6rfC8DRkIWNpMJNg==
X-Received: by 2002:a05:6000:90:: with SMTP id
 m16mr24139695wrx.191.1592893885862; 
 Mon, 22 Jun 2020 23:31:25 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x205sm2407188wmx.21.2020.06.22.23.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 23:31:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 0/3] i2c: Match parameters of i2c_start_transfer and
 i2c_send_recv
Date: Tue, 23 Jun 2020 08:31:20 +0200
Message-Id: <20200623063123.20776-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v2 of Zoltan's patch:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg714711.html

- rebased
- added docstring
- include hw/misc/auxbus.c fix

Supersedes: <20200621145235.9E241745712@zero.eik.bme.hu>

BALATON Zoltan (2):
  i2c: Match parameters of i2c_start_transfer and i2c_send_recv
  i2c: Make i2c_start_transfer() direction argument a boolean

Philippe Mathieu-Daudé (1):
  hw/misc/auxbus: Fix MOT/classic I2C mode

 include/hw/i2c/i2c.h | 22 ++++++++++++++++++++--
 hw/display/sm501.c   |  4 ++--
 hw/i2c/core.c        | 36 ++++++++++++++++++------------------
 hw/i2c/ppc4xx_i2c.c  |  2 +-
 hw/misc/auxbus.c     | 10 +++++-----
 5 files changed, 46 insertions(+), 28 deletions(-)

-- 
2.21.3


