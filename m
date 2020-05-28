Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D1CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249B62073B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5kTUQDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249B62073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMQ3-0005Y2-BD
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMNn-0001jm-SP
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:31:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37763
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMNi-0006Yv-IJ
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590687109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tdo8m2WVUovw0X6HlawNwv4oagN2kdyg6ba2ebJLWtg=;
 b=Q5kTUQDxERezn6qLqy419770YQqZCbon6ddT/1BNCvidUWRq4fGfwNsy14zMBfhXDV+qhY
 l0yIr2sjoDpHBdqyTfMEmrkOOJufoZKJ6CBDMwN/5eHf5YL8gfhvWScb/UWs1pu23j7XvE
 LiWnu6QIPLBXcLONREadsfGaxQjuwBA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-SvtaVyRKPH2b-u_uIGGm1A-1; Thu, 28 May 2020 13:31:45 -0400
X-MC-Unique: SvtaVyRKPH2b-u_uIGGm1A-1
Received: by mail-wr1-f69.google.com with SMTP id e1so10389735wrm.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 10:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Tdo8m2WVUovw0X6HlawNwv4oagN2kdyg6ba2ebJLWtg=;
 b=tTL+QZ1hRJto66g7/99t2gGjTieI9pGG4SJHZsoIurPLucBUdO2Fco+7OH0S8SUmSt
 4Hst/I5nSqEVszqFOgCX3FqzPwbBDshiQmOTRGbiH9pysAoUs48wELLksHLU0KS4WnIP
 DX/xxc7BaSuFOgqG2+vT128ztnqm+/KUVTWbjK+PydXpiv04evHRlrfubi+iuthZsFxM
 zLvNY/jcfwrTr3eYn3v1Gohc18E8rN6Shvhz2G28IVglK+Jq0osh4A7GwVvgltXew2s2
 kNl2LCr6El7pmMv/ag1wiV6b42+6d6zo0r8eCHbEiNvq+Lyz6hhq/VaGOrSjlgdniV9r
 Agbw==
X-Gm-Message-State: AOAM5300J7SDypQz/rD+65Axba2cjLbZbSMle+nAH2FDPNMMbS08EJe6
 tZ1GsuPIZVtVo9V9+W2wyxL1CGzM3cHHMOzPPWbQotaHx3X0svnYGzJSLYiTd2XI30UNdZWSa1/
 i4ZdFpfweAU98Bz0=
X-Received: by 2002:adf:8b0c:: with SMTP id n12mr4942816wra.340.1590687103655; 
 Thu, 28 May 2020 10:31:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS3kxO3VCljbrnD1iU0wiWI1lY+Bsg1wGWRO7w77oNCingJggaOBXkVr6bU+5TpP06nor6Tw==
X-Received: by 2002:adf:8b0c:: with SMTP id n12mr4942796wra.340.1590687103454; 
 Thu, 28 May 2020 10:31:43 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id g82sm7781827wmf.1.2020.05.28.10.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 10:31:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 0/5] fw_cfg: Add FW_CFG_DATA_GENERATOR;
 crypto: Add tls-cipher-suites
Date: Thu, 28 May 2020 19:31:36 +0200
Message-Id: <20200528173141.17495-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series has two parts:

- First we add the ability to QOM objects to produce data
  consumable by the fw_cfg device,

- Then we add the tls-cipher-suites object, and let it
  implement the FW_CFG_DATA_GENERATOR interface.

This is required by EDK2 'HTTPS Boot' feature [*] to tell
the guest which TLS ciphers it can use.

[*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README

Since v6:
- addressed Laszlo & Daniel review comments
  (changes describe in each patch).
Since v5:
- Complete rewrite after chatting with Daniel Berrangé
Since v4:
- Addressed Laszlo comments (see patch#1 description)
Since v3:
- Addressed Markus' comments (do not care about heap)
Since v2:
- Split of
Since v1:
- Addressed Michael and Laszlo comments.

Please review,

Phil.

v6: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05448.html
v5: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04525.html
v4: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04300.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02965.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02522.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.html

Philippe Mathieu-Daudé (5):
  hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR interface
  softmmu/vl: Let -fw_cfg option take a 'gen_id' argument
  softmmu/vl: Allow -fw_cfg 'gen_id' option to use the 'etc/' namespace
  crypto: Add tls-cipher-suites object
  crypto/tls-cipher-suites: Produce fw_cfg consumable blob

 docs/specs/fw_cfg.txt              |   9 +-
 include/crypto/tls-cipher-suites.h |  38 ++++++++
 include/hw/nvram/fw_cfg.h          |  52 ++++++++++
 crypto/tls-cipher-suites.c         | 146 +++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c                  |  31 ++++++
 softmmu/vl.c                       |  30 ++++--
 crypto/Makefile.objs               |   1 +
 crypto/trace-events                |   5 +
 8 files changed, 302 insertions(+), 10 deletions(-)
 create mode 100644 include/crypto/tls-cipher-suites.h
 create mode 100644 crypto/tls-cipher-suites.c

-- 
2.21.3


