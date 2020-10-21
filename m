Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8A8C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF4F2224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a//QEz2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF4F2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVI27-00043K-Fp
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI0n-0002m9-SO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:34:57 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI0l-000610-M9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:34:57 -0400
Received: by mail-wr1-x42d.google.com with SMTP id b8so4110812wrn.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0BWxEOXGyP6Q94O+x2s/aAgBnBL31nlmHLfTAXCHwTs=;
 b=a//QEz2/mNhPdCnd5HBMyWbhhLr22Gm0MGNROBNT/r4Y+qTuRV19h+0gcVuajawP3A
 2DAoTBUt6LaTJVKOwl0BnafOp/3iDvwUp3tr615LbiGrL90MonzRaSdWzsjjc2EKLYbj
 zAbBOAeILuiLdIZOwlNbUybNeogolfftZUKKN+5nPlIHWLigLThzSLs/cOaof/7MPhsj
 Tq9oa84bxkaOiBWMj6nf/avXDcxtELtUUYgxybpJelWhYg4PHyJu/pTQi7at3I6/OLBt
 K8x7HC39kWypcdeMoexhOwHmMKCv6mh3YIaUmd3A/Q0zC6Oyoei5d3K2HHxOJllp/haT
 RCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=0BWxEOXGyP6Q94O+x2s/aAgBnBL31nlmHLfTAXCHwTs=;
 b=qg386UaX8GOEiMYk6R7zhMRLOGLkJawQ0H/lABHqKoO9imVHG8phVE1Acin0bdc5dE
 1ZlDHgg1OEKmug6ut3rl7h16qW2EsaVTOcHxoyWneY4Ze0hVmKfmMgCsJYQkbK6nCj0l
 Uh5fSuWrX7z55fhsjdOvUyjQhSZgJau8W13XWMDuKr++3eheN7g3o7lCRUeFS6rvTM9i
 FmxYNsakVYua1LtN2tueTjPyNPrKMmE0LpHJbOtVzDdwTp3TDaOkBKUJcFsi9nISTTjU
 m4mj3/eetULWG0uAz94/u8R7x6LiuIfhCAnon5QueYKTAo4JC37McjobKQpE1ToPqYBJ
 z9Vw==
X-Gm-Message-State: AOAM532wVWxEZ+Jks00j8MDDSjqk94HqgvJHA5mKyAd7ovPbXgnwUE3D
 3BUckrBzE08xan7zRjKTKYFWnMrBgeI=
X-Google-Smtp-Source: ABdhPJwD+bMC7FNstHC4bHv8ekaEL7dSlrSKC06JTk9VC9QTiO0YVv7OnzNGeeSxhGG5qO16qjmu5A==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr5795207wrv.286.1603301692731; 
 Wed, 21 Oct 2020 10:34:52 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id m1sm4314937wmm.34.2020.10.21.10.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:34:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] SD/MMC patches for 2020-10-21
Date: Wed, 21 Oct 2020 19:34:37 +0200
Message-Id: <20201021173450.2616910-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ac793156f650ae2d77834932d72224175ee69086=
:=0D
=0D
  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201=
02=3D=0D
0-1' into staging (2020-10-20 21:11:35 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/philmd/qemu.git tags/sd-next-20201021=0D
=0D
for you to fetch changes up to 84816fb63e5c57159b469a66052d1b2bc862ef77:=0D
=0D
  hw/sd/sdcard: Assert if accessing an illegal group (2020-10-21 13:34:27 +=
02=3D=0D
00)=0D
=0D
----------------------------------------------------------------=0D
SD/MMC patches=0D
=0D
Fix two heap-overflow reported by Alexander Bulekov while fuzzing:=0D
- https://bugs.launchpad.net/qemu/+bug/1892960=0D
- https://bugs.launchpad.net/qemu/+bug/1895310=0D
=0D
CI jobs results:=0D
. https://cirrus-ci.com/build/6399328187056128=0D
. https://gitlab.com/philmd/qemu/-/pipelines/205701966=0D
. https://travis-ci.org/github/philmd/qemu/builds/737708930=0D
----------------------------------------------------------------=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (13):=0D
  hw/sd/sdhci: Fix qemu_log_mask() format string=0D
  hw/sd/sdhci: Document the datasheet used=0D
  hw/sd/sdhci: Fix DMA Transfer Block Size field=0D
  hw/sd/sdhci: Stop multiple transfers when block count is cleared=0D
  hw/sd/sdhci: Resume pending DMA transfers on MMIO accesses=0D
  hw/sd/sdhci: Let sdhci_update_irq() return if IRQ was delivered=0D
  hw/sd/sdhci: Yield if interrupt delivered during multiple transfer=0D
  hw/sd/sdcard: Add trace event for ERASE command (CMD38)=0D
  hw/sd/sdcard: Introduce the INVALID_ADDRESS definition=0D
  hw/sd/sdcard: Do not use legal address '0' for INVALID_ADDRESS=0D
  hw/sd/sdcard: Reset both start/end addresses on error=0D
  hw/sd/sdcard: Do not attempt to erase out of range addresses=0D
  hw/sd/sdcard: Assert if accessing an illegal group=0D
=0D
 hw/sd/sd.c         | 30 ++++++++++++++++++++++--------=0D
 hw/sd/sdhci.c      | 41 +++++++++++++++++++++++++++++++++++------=0D
 hw/sd/trace-events |  2 +-=0D
 3 files changed, 58 insertions(+), 15 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

