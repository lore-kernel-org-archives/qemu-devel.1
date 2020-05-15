Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4CCC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1175206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="He+C0G7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1175206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWXR-00016M-0r
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWVA-00058I-Gp
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:19:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWV7-0005VY-QH
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589534369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tip+VUiEmGbZgPR0PRl2/ts9k/XY7TW1haH7XVAasp8=;
 b=He+C0G7jbALxdXTNr+CNhANMPcnNf+CSj+5LYvAOb1pIq8tZr583Y8et226zF76F/VT4wH
 u1zjfLMGVVMv3XPfBWGtK4gR/xU9df/Bwy4rpWmsNwQntyLz5IT5Ii/g2pD5sijCXc73hl
 7Wetgr29qVW1baGkb/isUOrhiiy42bg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-oYIAzamBPtSu9fgXSArnYg-1; Fri, 15 May 2020 05:19:27 -0400
X-MC-Unique: oYIAzamBPtSu9fgXSArnYg-1
Received: by mail-wr1-f72.google.com with SMTP id l12so879915wrw.9
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Tip+VUiEmGbZgPR0PRl2/ts9k/XY7TW1haH7XVAasp8=;
 b=V+24SQyq8Ko8MU9eZ1P79W+q3Uui7SOwXLPc8KNnlGRBf0Sh9QR8PQgb/L8q2DTiW0
 +MI7sEOPPZp3oZ4WPCA/GKzzScukGVCxNObIJ3J/6IB4dSz74ODcjxdDzFiS1Rexg/1M
 eGXQmClIrqmzqqO3WlE6DKOsCZ1KS1FAbEOmLO+znvJLEq5hsYGqn1ANgGic/k83S2le
 6kZ8COmH4z+Er9Px5oAmO0D0Jobiefnf6PScLirKXoYpqPEssNNwHhtfK3WGShwvML5k
 vFmPJ3A4ChzbpakCm62MLusCucQI2/bQRsDCvRX095Ho2fPqpGaknuLQgQ+dOfS6dRpP
 DeJA==
X-Gm-Message-State: AOAM5318x24IgCVNqe+SHLg3VGhB7K29XFfny4qJL9ijBjxYYTlNyZfl
 YYr21D2JZSIGE1CJaYZRAaGTXvDoCfoSJD07C48LNIjevyLH9L9VX+zeSJwkPz4CPKRyKhhCTHk
 Oi8ZopFMp2V5RZNk=
X-Received: by 2002:a1c:7914:: with SMTP id l20mr2924609wme.120.1589534366005; 
 Fri, 15 May 2020 02:19:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqHMuVy5nPhF09Ru+ZPqaInBig04JlQ8fR64hYJyubwsnJDWU0ZFuGEbsGqCNpsr2up0NcdQ==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr2924590wme.120.1589534365827; 
 Fri, 15 May 2020 02:19:25 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h188sm2886665wme.8.2020.05.15.02.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 02:19:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] block: Documentation improvment
Date: Fri, 15 May 2020 11:19:19 +0200
Message-Id: <20200515091924.14380-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These patches contain documentation I wrote down while
looking at the code.

Supersedes: <20200504094641.4963-1-philmd@redhat.com>

Philippe Mathieu-Daudé (5):
  qemu/osdep: Document qemu_memalign() and friends
  qemu/bitmap: Document bitmap_new() returned pointer
  block/block: Document BlockSizes fields
  sysemu/block-backend: Document blk_read()/blk_pwrite()
  sysemu/block-backend: Document blk_get_max_iov() returned value

 include/block/block.h          |  8 ++++++--
 include/qemu/bitmap.h          |  2 ++
 include/qemu/osdep.h           |  3 +++
 include/sysemu/block-backend.h | 27 +++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.21.3


