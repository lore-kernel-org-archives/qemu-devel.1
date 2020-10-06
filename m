Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8925EC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E092D20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbd0v8D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E092D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPl69-00006e-V7
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPl01-0002JZ-Dl
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPkzz-00068D-Ub
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601983155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tn3SyGbiBJh1RvhMeqn32YyrqrxK0XO5YhJsv3YI+v4=;
 b=hbd0v8D1KhC/2xZqgpwNGrEbrWeR6rM03AIEqUNtEiMvmDyJZ5vHIhNY7XSR0+cIZCq1vi
 KBlX4JGD5Lo15TIVBQQAJZMWl1w290/eDO4EnS443k/EC1+MoD24kqVtC2+w9nUQhYNeuz
 3Y0SIaEYZJS5SWOJ9E4kymPs2RnVg/E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-2NXHHmIyPwiI_GeavFnDsg-1; Tue, 06 Oct 2020 07:19:12 -0400
X-MC-Unique: 2NXHHmIyPwiI_GeavFnDsg-1
Received: by mail-wr1-f72.google.com with SMTP id g7so418164wrm.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Tn3SyGbiBJh1RvhMeqn32YyrqrxK0XO5YhJsv3YI+v4=;
 b=pbkhd6coND/aoMWYTUGgzAcSwgaQF4n+wY3udZaCDuMpgZSBBreH1QsLWRhKJqBLik
 Dfng/NOZ1bxls4sr6NEfM5rQ4iwzrvCYOFfe0sFJFUNoYFuTMwRq3UxhW/CVXW000+7I
 bjlxDHC76iWuBaJdX7OYExYehmlSjqQc7uMUCFQexIzHSrQRDrmDJvbkmieSuvRzDZjv
 8LtQxEAz51SvCApGVY/XiTKrMocEWvZszZE544ISOlgFkMvZTMv2vEipMlmzi1KFYEb/
 Dbtq2rJ0XDbXEsjSMiOv9IzCJqsIQ2Sy21dQrHnKB4HGraQOdjCQD8XOnlNNaOtpZnvb
 Pihg==
X-Gm-Message-State: AOAM531Z/5fSDByiuBk1W37YPNPhNCkbIVtsTZuy7M+ObdLoihsD61K+
 wsex3TILrSNXK3hY+NB5BA9xxXfMxx3zQIVD6dG0/28n2jKn5h9d8GaxLs3k8M8yfPktO9n3elX
 QPZz2Q2P5Wkw7XM4=
X-Received: by 2002:a1c:417:: with SMTP id 23mr4207166wme.1.1601983151549;
 Tue, 06 Oct 2020 04:19:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb1xb0Pk+3J3kcEXecjPMT7kUBIVo/TYzUA4fb5G7+IvYcWUUGrpZdtIDgXPgKijm355/kvQ==
X-Received: by 2002:a1c:417:: with SMTP id 23mr4207147wme.1.1601983151316;
 Tue, 06 Oct 2020 04:19:11 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p4sm4010322wru.39.2020.10.06.04.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:19:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Daniel P . Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] qom: Fix missing interface in qemu-storage-daemon
Date: Tue,  6 Oct 2020 13:19:08 +0200
Message-Id: <20201006111909.2302081-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Attempt to fix the issue reported by Kevin.

Since RFC:
- Keep it local to hw/nvram (danpb)
- Based on Meson cleanup

Based-on: <20201006111219.2300921-1-philmd@redhat.com>
Supersedes: <20201005105442.2093105-1-philmd@redhat.com>

Philippe Mathieu-Daudé (1):
  hw/nvram: Always register FW_CFG_DATA_GENERATOR_INTERFACE

 hw/nvram/fw_cfg-interface.c | 15 +++++++++++++++
 hw/nvram/fw_cfg.c           |  7 -------
 MAINTAINERS                 |  2 +-
 hw/nvram/meson.build        |  3 +++
 4 files changed, 19 insertions(+), 8 deletions(-)
 create mode 100644 hw/nvram/fw_cfg-interface.c

-- 
2.26.2


