Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BC6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465D521501
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NepT2euk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465D521501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDrp-0002EY-Pg
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlDqZ-0001bK-0O
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:49:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39777
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlDqW-0001Ob-Af
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592322595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NWQWPSRpwCirZzltXM9c6QjcXO+Crco4oflFwPd1lPg=;
 b=NepT2eukc9jhyC5xYE9WnuTCUBN28KAaz6ebFJ48XggzaKaJdzpfRvgWRiCagLlL4SfNA2
 9Mmo1/lcMxo8v1D+wZfGsIW2mn8h82onH5Yz2/nGP6V1jUa0/VygCQD1Ed8Kb4KII4Zmba
 VcIv1Me3q1g2MfnNi5ZTAKAHiI4Twm4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-yDwCl6S2Ooi84hMZwEjhwQ-1; Tue, 16 Jun 2020 11:49:53 -0400
X-MC-Unique: yDwCl6S2Ooi84hMZwEjhwQ-1
Received: by mail-wr1-f71.google.com with SMTP id r5so8448154wrt.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 08:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NWQWPSRpwCirZzltXM9c6QjcXO+Crco4oflFwPd1lPg=;
 b=WQA5zgEuPBsQgFCFE6XPbTznqpcMhdpnv7jZ6CqC1zV2VODI4yAuExSQs2lYKpaZ6F
 PgqQsOBBSWwqgvNpQPms/WckfOaKjSt9p//NvTSlyzrXaO5jZ2XeRHPj0zuRBn4jqN9A
 c0HLvLlz/xsKvPL8RXGd9b23UJTG9gW9o6FIf63Gaars0g24U55AM7GtKB7Q1EEQGgD/
 ZEcZbq838ZXVOtb8Is4mpL5DawypXmOjnlOjuGNpJE32Vz9xDVmKcqZ0aXzDjYz43xim
 1XHuwT5Pnj4/84z2YZUxmsOVptmhRK3zh1wgTwkEiygPczD/5NneYFXNcpW3UPLkxwU3
 Iz0Q==
X-Gm-Message-State: AOAM531Yx7O6zL2tPSp4J7wBUnVfDFgjiNE6skeW2j7c8v9L8cyDMT8b
 FZ6w++pYIpaU3n7cqhLAkHKhGL14bXP7nYf5mmB9cK+GF78gl2Bq3FmkeZQ94e5CEjtSyuDIDAB
 3ssg2ifRp0p/TNHM=
X-Received: by 2002:a1c:4105:: with SMTP id o5mr3810332wma.168.1592322592023; 
 Tue, 16 Jun 2020 08:49:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdpolLOdt34QktUwsGqUn3d+Nw+QGJN8TYXvWdUCyEFmDtXbFit0bg2YPqNywMWv6UrqrSeA==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr3810303wma.168.1592322591829; 
 Tue, 16 Jun 2020 08:49:51 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j18sm31456834wrn.59.2020.06.16.08.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 08:49:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] iotests: Fix 051 output after qdev_init_nofail() removal
Date: Tue, 16 Jun 2020 17:49:49 +0200
Message-Id: <20200616154949.6586-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 96927c744 replaced qdev_init_nofail() call by
isa_realize_and_unref() which has a different error
message. Update the test output accordingly.

Gitlab CI error after merging b77b5b3dc7:
https://gitlab.com/qemu-project/qemu/-/jobs/597414772#L4375

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qemu-iotests/051.pc.out | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 0ea80d35f0..da8ad87187 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -142,7 +142,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive if=ide
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device ide-hd failed: Device needs media, but drive is empty
+(qemu) QEMU_PROG: Device needs media, but drive is empty
 
 Testing: -drive if=virtio
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -214,7 +214,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device ide-hd failed: Block node is read-only
+(qemu) QEMU_PROG: Block node is read-only
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
2.21.3


