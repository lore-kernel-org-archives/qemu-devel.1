Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C90C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE42B2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzupCvug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE42B2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2riV-0001gv-2i
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 03:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2rhf-0000qI-MR
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:49:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58989
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2rhd-0003X1-3D
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596527379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E2jiGLglr9GMSiEGPHsA3lR63Xofi0iHowxjVG7mx/w=;
 b=TzupCvugqb4M/j4m+j0NbMdVFRxMb1WXP0xhmgdMqwPuGqvyNHsAgM62LlAI8tlEfattkv
 unZ2nxfqXVPeKKWTw7d5gXFocVXyULuDsewJzqUE3RZ7sj3BSw37KerBSY7C9B8F5TBDS8
 QmX7eKCqm9duXZimQIIWzgFGypuKBrg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-SBWQolBUOwmatMHtC59-qg-1; Tue, 04 Aug 2020 03:49:34 -0400
X-MC-Unique: SBWQolBUOwmatMHtC59-qg-1
Received: by mail-wr1-f69.google.com with SMTP id b18so9312119wrn.6
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 00:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E2jiGLglr9GMSiEGPHsA3lR63Xofi0iHowxjVG7mx/w=;
 b=S4xo3H40D5sZc6qz4b5l8hD+BZS0uYZbxjBAolemkxcRvJGaN+M75D1+AeHhv2KkRF
 tKthMDnVam5ZWj0sSgO/T8qmfQVjil5OsH318K1KuQQlcvuzy2M+odAc0ing4MpGf4nc
 Pn6BopuVfjDLX/+NOK0BGnF4QN3/sZEDysGIfMEIZj3fbJ85lKeAyHRcWPlgXA5LRl6p
 hX6Lv4JUQfSmdmH6eESILeg2gLhJCdYl9uwrI9LePrqCF8+x5A2L9g1lL/+rR9VIy2b0
 cnVYBaP1/rF1bBJU8MIF6gsgywuTuCzVjir+IQn4hKg1ezTT5/ax7F7Ft8mQSGfrzlwZ
 3eng==
X-Gm-Message-State: AOAM531s8dV6AjpIiJusrveD0e0vY/NzV3OnJBtsRDyLTVX/3vWjdsUt
 QNbN/U/vm9tmOzrKaFczvZr1+rWYB+9HZi8EZ376YL3p3Z2Fi977mNQtEdEyxXPkbDPqn2pqU1c
 eb+k64l0n+NRy7gM=
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr2996188wmi.10.1596527372852; 
 Tue, 04 Aug 2020 00:49:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVcaY1shpVa8jfBFMJx1xeZaNFrBZTRm99UYupi2noXnPadzDchI/0SLQAgLJaYlx8QkcURQ==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr2996163wmi.10.1596527372609; 
 Tue, 04 Aug 2020 00:49:32 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id f12sm3317241wmc.46.2020.08.04.00.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 00:49:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v2 0/1] accel/xen: Fix xen_enabled() behavior on
 target-agnostic objects
Date: Tue,  4 Aug 2020 09:49:29 +0200
Message-Id: <20200804074930.13104-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1: Fix build error reported by Peter:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg727251.html
Now following KVM implementation closely.

Philippe Mathieu-Daudé (1):
  accel/xen: Fix xen_enabled() behavior on target-agnostic objects

 include/sysemu/xen.h   | 18 ++++++++++++++----
 accel/stubs/xen-stub.c |  2 ++
 accel/xen/xen-all.c    |  7 +------
 3 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.21.3


