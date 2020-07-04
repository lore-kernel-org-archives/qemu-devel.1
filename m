Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327ECC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44E320723
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZqJWyWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44E320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlDo-0001JD-4d
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrlCT-00085e-DJ
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:39:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27763
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrlCR-0005QG-N0
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593880775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m/8i0LkIgAAfDamFS/UoGLAcNvDFvKkvrvuq5rOxecw=;
 b=FZqJWyWyWLCSdugc1Cj8GsO9xqoXXtCzdtlRcni7v9fMAzOu6mt0TGAzQ7LdXOdXSRFHl3
 cOPPIyqrg8UBPTYpXigT+qjkqH2G33d+otqMfDo+p0axVDFztfpb/bpApp3qiPSmh1VqJN
 MxWA6g9FvykUOWmG465TBrgTQp9SmrI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-J_wXVpGyO1KuIRpsn9plug-1; Sat, 04 Jul 2020 12:39:31 -0400
X-MC-Unique: J_wXVpGyO1KuIRpsn9plug-1
Received: by mail-wm1-f72.google.com with SMTP id g187so39872975wme.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 09:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m/8i0LkIgAAfDamFS/UoGLAcNvDFvKkvrvuq5rOxecw=;
 b=J4AP25B+ylId+2KxACies2u054bLP4dxIDMSqpVFcuxSqO/EYQkoWQcBXD63uYhMCG
 E2ovjB1+Wbf22UamAianR6fJS8hhPfxPUansafFwBvmnNc3j00AU4YFIw3A16pUCUMbp
 0ZdZ3Eu52Jd1BScwC3GFtDcvkBkn8azMxdr0l5OvJoD44qKVceEDNLXMLaHrw2vmRivn
 sBY7WXgR/Po669UA2C3dMy9i9lCu4RQWU0tsUG9U7lfK7KarKkzTYZ+KE/v8cT8qGssO
 JWPK8eH425C7NyGPrKqC0APBYYXSThD8NV7BZWx7LDb9We5us+ON/0TfAgoXpUpoZuX5
 3gGQ==
X-Gm-Message-State: AOAM533ceE0/pGh/M6lNyQsr6+TCz89fTJm6/YA1Vqw4XVrwmp6SjoZX
 u4K8XxcbocxKJ+LbdaoFalfDP4WHxtYwWpLAKHFFUAO8ONYFLE7Ap1D6FKH1B9bi4z72689majJ
 dkmOC+lDB7xsfMl4=
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr40620122wre.369.1593880770468; 
 Sat, 04 Jul 2020 09:39:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwdSrWlbD0y8K7SIiOWIB9JDF+2vzfGIJ9rTYKHuJWyfjQTVxiWmXR7iMBDpRLWN9uV+bUAA==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr40620110wre.369.1593880770282; 
 Sat, 04 Jul 2020 09:39:30 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z1sm17576747wru.30.2020.07.04.09.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 09:39:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] fw_cfg/crypto patches for 5.1 soft freeze
Date: Sat,  4 Jul 2020 18:39:22 +0200
Message-Id: <20200704163927.28188-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4abf70a661a5df3886ac9d7c19c3617fa92b922a:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-06-24' =
into staging (2020-07-03 15:34:45 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/fw_cfg-20200704

for you to fetch changes up to 69699f3055a59e24f1153c329ae6eff4b9a343e0:

  crypto/tls-cipher-suites: Produce fw_cfg consumable blob (2020-07-03 18:16:=
01 +0200)

----------------------------------------------------------------
firmware (and crypto) patches

- add the tls-cipher-suites object,
- add the ability to QOM objects to produce data consumable
  by the fw_cfg device,
- let the tls-cipher-suites object implement the
  FW_CFG_DATA_GENERATOR interface.

This is required by EDK2 'HTTPS Boot' feature of OVMF to tell
the guest which TLS ciphers it can use.

CI jobs results:
  https://travis-ci.org/github/philmd/qemu/builds/704724619
  https://gitlab.com/philmd/qemu/-/pipelines/162938106
  https://cirrus-ci.com/build/4682977303068672

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (5):
  crypto: Add tls-cipher-suites object
  hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR interface
  softmmu/vl: Let -fw_cfg option take a 'gen_id' argument
  softmmu/vl: Allow -fw_cfg 'gen_id' option to use the 'etc/' namespace
  crypto/tls-cipher-suites: Produce fw_cfg consumable blob

 docs/specs/fw_cfg.txt              |  13 ++-
 include/crypto/tls-cipher-suites.h |  39 +++++++++
 include/hw/nvram/fw_cfg.h          |  43 ++++++++++
 crypto/tls-cipher-suites.c         | 126 +++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c                  |  35 ++++++++
 softmmu/vl.c                       |  37 ++++++---
 crypto/Makefile.objs               |   1 +
 crypto/trace-events                |   5 ++
 qemu-options.hx                    |  37 +++++++++
 9 files changed, 326 insertions(+), 10 deletions(-)
 create mode 100644 include/crypto/tls-cipher-suites.h
 create mode 100644 crypto/tls-cipher-suites.c

--=20
2.21.3


