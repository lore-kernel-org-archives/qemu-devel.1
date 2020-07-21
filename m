Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DC2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D6F20717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UF66N88V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D6F20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxwTD-0005WJ-4u
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 13:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxwSP-0004TJ-0n
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 13:53:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46828
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxwSM-0002TA-BG
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 13:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595354012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FecxiD2ngj8r8IEXNhAdljr/ccYW5EgTQzGCoazru/o=;
 b=UF66N88VK7M79ISn/bxmxyanTktXHIlLh+UvpIqNmjdx8x8JWwm6W2jMqMDi781MwMsCeZ
 D5KGkgDUuxRA/H341+dVbWFbv2XQqU+su+JMGU0zTBVUhxlA1xIqjnNFdGCnFAshHX5TI6
 I/Coznj8jxb0YPL0Z4cFOCy5WKHIzXk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-rJVjgkUsNuyganKMy2x6ig-1; Tue, 21 Jul 2020 13:53:30 -0400
X-MC-Unique: rJVjgkUsNuyganKMy2x6ig-1
Received: by mail-wr1-f69.google.com with SMTP id v4so6161041wrb.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 10:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FecxiD2ngj8r8IEXNhAdljr/ccYW5EgTQzGCoazru/o=;
 b=GKsWSs5bq3V63Zg8xWOfRTZ6NoSjp0jWtdAYkWfWHUZ7aNyqcj/bcVYtIqZedabyt3
 Uu0G+3UzU1iHsDvbKqStwglFxd9KmrH5gD1/37EtiiXetE+Uw/Zns1Wr6QVE1zC6GRn9
 kcosciCUZb0/oDXQZ3ohypcOecxRpCGxg5A+GJa5w15LfoXojPRL8kUbpM/DaBYAO0m7
 sNxpwYljiOS+f3nFaHnH6PlcWrkypAq48hBPnp6vtIK7Lbb+69yI5pYL0VohrbIVwmBB
 Gb2PYNTnYaWMaVBSP8L6ek6GuPK0l75M0y6lDSAZkBMiPtz2YA6ne1ZGx/vCZ1KjaFII
 uyGg==
X-Gm-Message-State: AOAM531h/JYFX0t+8fPnfaDF7BluFGn6kF5Wt43TJCdG0KTzkOuwXtlj
 yDDe4DsB5D7OlxyMTzaQ/fGNwMuPHgMSikcs8SxMaezzGgWl7b6kaOVKA2VNoJJQhx51hpitxVz
 FM2/c98eoMLrelrk=
X-Received: by 2002:a1c:6887:: with SMTP id d129mr4925233wmc.179.1595354009057; 
 Tue, 21 Jul 2020 10:53:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2EZrE+Wu+JmGfkyFwEjUGDkaUS1NbnoDL4TKKz5QtlCjkEuRktJZty06vpoyNvSJR9n9brQ==
X-Received: by 2002:a1c:6887:: with SMTP id d129mr4925212wmc.179.1595354008791; 
 Tue, 21 Jul 2020 10:53:28 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c194sm4573886wme.8.2020.07.21.10.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 10:53:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] fw_cfg patches for 2020-07-21
Date: Tue, 21 Jul 2020 19:53:24 +0200
Message-Id: <20200721175326.8004-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:20:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 90218a9a393c7925f330e7dcc08658e2a01d3bd4:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07=
-21' into staging (2020-07-21 10:24:38 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/fw_cfg-20200721

for you to fetch changes up to 077195187b47d83418e5fb521c89d7881fab3049:

  hw/nvram/fw_cfg: Let fw_cfg_add_from_generator() return boolean value (2020=
-07-21 16:47:54 +0200)

----------------------------------------------------------------
fw_cfg patches

Fixes the DEADCODE issue reported by Coverity (CID 1430396).

CI jobs result:
. https://gitlab.com/philmd/qemu/-/pipelines/169086301

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (2):
  hw/nvram/fw_cfg: Simplify fw_cfg_add_from_generator() error
    propagation
  hw/nvram/fw_cfg: Let fw_cfg_add_from_generator() return boolean value

 include/hw/nvram/fw_cfg.h |  8 ++++++--
 hw/nvram/fw_cfg.c         | 13 +++++++------
 softmmu/vl.c              |  6 +-----
 3 files changed, 14 insertions(+), 13 deletions(-)

--=20
2.21.3


