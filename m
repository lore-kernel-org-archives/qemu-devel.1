Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335B9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AA320739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARb60FeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AA320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw39P-0001rT-4s
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw38R-0000F7-I1; Thu, 16 Jul 2020 08:37:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw38Q-0002th-14; Thu, 16 Jul 2020 08:37:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id o11so6883561wrv.9;
 Thu, 16 Jul 2020 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mB1xxUu5zqmOlJyeJOkLUsa5p10TlJZt5oeYf/aQyPQ=;
 b=ARb60FeHPT4lfmhfWj5c3Dc/GDZ7UeDtLAXLlobXruj8nFLuFB8D7NGC+HwAJ4+Pl5
 ftFweWixOb1ptNP3cP2cdVoqSGHphD6ybCp/hLm/0UaMIV/T3fRr2FUHNPfVRrF0fAJt
 Vzby7G4rs6h1XU7Iu2oLv8VCIaFKAiAlB5T28WiZrAe3z0KgBjSVDvRW5ivN8RJgKfw+
 oR4nWU1wPrBBVSopd6Ii3lgiTLcc/TgEH5xypsyd/1UVRTY+xV9x7g+fLlK8k54MTeov
 IZ332Gh1fr2+UV+VAY0oXfYxOdBWWXdQsnGZ3M0ABYdsmImf7s7Ur2WyZ4dQ9vypJTnP
 pSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=mB1xxUu5zqmOlJyeJOkLUsa5p10TlJZt5oeYf/aQyPQ=;
 b=aS0nk/5bm0YunTbqwZfNB5nz+y4LQzH9gbjiANd0gp0BfR/ugnsi1VV2jx3PWSpdnG
 /0AmsnWmZUAtcX9kO9F8Wxb25AA537fJ2S/Db3DW+cLs4zytMVwzBoEQETY6DvdjxWq5
 pH6a54Fs/95EysEL6KZ0nBn7ZPkXOzNu1VSSGxH8FLEP53e+iP2NAFm/fEW0onUMSGKj
 nplf1DwgegwaUqFyK/Ry146meBLCitwXlsng7Y61SzsHm2RgCOWt9rB2okhtKTmh5R+t
 AJL3U3XFP+MBPPBDGFfNNC0v/f7DRTH4fXuii811Bz1rjg4zUNx5m0zuagYC8zCjZRtk
 ndxw==
X-Gm-Message-State: AOAM530tB4Wed9p/xfqKteOEWduPy6sqywxzb+7d9brnuPjaXRIqc5Nw
 aOLcu5uHfq1wPzymh4ffy/w=
X-Google-Smtp-Source: ABdhPJz9g/vGJP2RKVZgF9h6f20OFk4NNucEE3jZ+fi3QR4RP7R2yi143VXJ45AZJ8lOK4q+3nyDgQ==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr4796592wrs.353.1594903027555; 
 Thu, 16 Jul 2020 05:37:07 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c194sm8336673wme.8.2020.07.16.05.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 05:37:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 0/2] block/block-backend: Let blk_attach_dev()
 provide helpful error
Date: Thu, 16 Jul 2020 14:37:02 +0200
Message-Id: <20200716123704.6557-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A pair of patches which helps me debug an issue with block
drive already attached.

Suggestions to correctly/better use the Error API welcome, in
particular in qdev-properties-system::set_drive_helper().

Since v1:
- Rebased after 668f62ec62 ("error: Eliminate error_propagate()")

Philippe Mathieu-Daudé (2):
  block/block-backend: Trace blk_attach_dev()
  block/block-backend: Let blk_attach_dev() provide helpful error

 include/sysemu/block-backend.h   |  2 +-
 block/block-backend.c            | 12 +++++++++++-
 hw/block/fdc.c                   |  4 +---
 hw/block/swim.c                  |  4 +---
 hw/block/xen-block.c             |  5 +++--
 hw/core/qdev-properties-system.c | 16 +++++++++-------
 hw/ide/qdev.c                    |  4 +---
 hw/scsi/scsi-disk.c              |  4 +---
 block/trace-events               |  1 +
 9 files changed, 29 insertions(+), 23 deletions(-)

-- 
2.21.3


