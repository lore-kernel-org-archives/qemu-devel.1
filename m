Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4A3C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF53206E6
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlWt5VFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF53206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHY65-0006ZZ-7I
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 15:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4d-0004ED-9d
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:54:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56108
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4b-0002FO-Ds
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600026844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DOKnWX2iitjDbaYV++fqOhPdaz2ukNmCIoazESmp5Ss=;
 b=PlWt5VFzMTImHkOnCsukQIajrmwAKFWaWFA+wif7vqH2pndMI9x/QHkCX5MJIIDDn5SIlv
 eA84u9WsT/8uJM+VqqqCiIrQVYqJdRm4uqFm39k8y23BVNMt8RyDzN7a+pBn7jscc79X1C
 pHklZ4Wf6OO6lTGTttNdtZUpxLIYmWs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-jAnD0MAAMEaUUAuiisRvRQ-1; Sun, 13 Sep 2020 15:54:02 -0400
X-MC-Unique: jAnD0MAAMEaUUAuiisRvRQ-1
Received: by mail-wr1-f72.google.com with SMTP id v12so5918518wrm.9
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 12:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DOKnWX2iitjDbaYV++fqOhPdaz2ukNmCIoazESmp5Ss=;
 b=Mo5X1Bw9+blh9lHpxo6ENT+LeyZAXxnLAXzoOa2iZugN60K5/U1lJcEx+ZamdfQr1S
 4P1g2Wa0/NA4SbTKSr3OFP73hm/kC7LNQet0JewcLgUkIUiezcaW2dwwWOHz7H9WOw8W
 rOHg4AnikR3BxkW+iy1x0IZNFNGplKrckbI7Ztpvp/lS+KqOKMNl2umHfKRh0uIw53qA
 DAitlooOc5Ky5fxMG9uBb/BSFdL0AkLW5ZGBP8TyymwaNHb+hBMm97IK505OxdRsNf5X
 3L87uQWsNo3039KtU3YhVWp8g8JlQBFCmzIhndJRNIaQtOVaB3HJt3GtKa3bzGws3Aap
 uriQ==
X-Gm-Message-State: AOAM533thpCalNhdA9z6LyM78Pqr7ey/9a9B5KjfH7BBJTRmxYNHSyBO
 epx5JHMscgmsvORJCbMlWzejHQLaCZqoStGWs8dq6VLvwqaZUMW1xNa9431fveRLJGZLOUG6S01
 DrwPWQo4t73u60fI=
X-Received: by 2002:adf:e84a:: with SMTP id d10mr13117167wrn.66.1600026841617; 
 Sun, 13 Sep 2020 12:54:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwydVMNI8O82MHC3Yh09m15o42bkAztsq9W/dTzfnny7bIiJEB+QUX7yZgSJskz2nx1S48kcQ==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr13117161wrn.66.1600026841452; 
 Sun, 13 Sep 2020 12:54:01 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 185sm16936093wma.18.2020.09.13.12.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 12:54:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 2/8] qapi: Correct balloon documentation
Date: Sun, 13 Sep 2020 21:53:42 +0200
Message-Id: <20200913195348.1064154-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200913195348.1064154-1-philmd@redhat.com>
References: <20200913195348.1064154-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 14:58:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentation incorrectly uses the "size of the balloon"
description when it should be "logical size of the VM". Fix it.

The relation between both values is:

  logical_vm_size = vm_ram_size - balloon_size

Reported-by: David Hildenbrand <david@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/misc.json | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index b21963a176d..a667fdf03e5 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -192,7 +192,8 @@
 #
 # Information about the guest balloon device.
 #
-# @actual: the number of bytes the balloon currently contains
+# @actual: the logical size of the VM in bytes
+#          Formula used: logical_vm_size = vm_ram_size - balloon_size
 #
 # Since: 0.14.0
 #
@@ -228,7 +229,8 @@
 # Emitted when the guest changes the actual BALLOON level. This value is
 # equivalent to the @actual field return by the 'query-balloon' command
 #
-# @actual: actual level of the guest memory balloon in bytes
+# @actual: the logical size of the VM in bytes
+#          Formula used: logical_vm_size = vm_ram_size - balloon_size
 #
 # Note: this event is rate-limited.
 #
@@ -759,7 +761,10 @@
 #
 # Request the balloon driver to change its balloon size.
 #
-# @value: the target size of the balloon in bytes
+# @value: the target logical size of the VM in bytes
+#         We can deduce the size of the balloon using this formula:
+#            logical_vm_size = vm_ram_size - balloon_size
+#         From it we have: balloon_size = vm_ram_size - @value
 #
 # Returns: - Nothing on success
 #          - If the balloon driver is enabled but not functional because the KVM
@@ -777,6 +782,8 @@
 # -> { "execute": "balloon", "arguments": { "value": 536870912 } }
 # <- { "return": {} }
 #
+# With a 2.5GiB guest this command inflated the balloon to 3GiB.
+#
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
 
-- 
2.26.2


