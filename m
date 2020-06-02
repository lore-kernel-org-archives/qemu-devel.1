Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE39C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 05:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98C3206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 05:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yb/wV7ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98C3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfzbf-0004yM-55
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 01:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfzb6-0004YA-KL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 01:36:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41203
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfzb5-0000it-HL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 01:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591076182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=vZsHIp8dTKyGCVvTQ9NL9sXY1St3u6EowSdfwVH6fC0=;
 b=Yb/wV7ty2518jTyb43vTepRcGQOQvdxHaZ5isjy8uLiHS+lbqNyz3PXxZzGZdk1e56uCBx
 VjgVYhWgxPtDZO9BEmUUKHz4pLDKV0y/yIZF06B5I1TIhVRPVPDskO45kzXiZ+kqLgUxhk
 3v7EMPoufyoMOcDMOQPKz2WJOQzubUc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-sgY3KDRsNJ6aifoX2CDSOw-1; Tue, 02 Jun 2020 01:36:20 -0400
X-MC-Unique: sgY3KDRsNJ6aifoX2CDSOw-1
Received: by mail-wr1-f70.google.com with SMTP id s17so903578wrt.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 22:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=vZsHIp8dTKyGCVvTQ9NL9sXY1St3u6EowSdfwVH6fC0=;
 b=bg19scRswyf83WUI/5CARqw6nkgeVnFBU31b31X3FU93Rjalb6dmPSj56cBWL5wn7S
 4cgxdsyMtz5VDqQYF1tT5xHh5J6/SX3PVHLvytFc2gCoRfSuDv4q1IU3EI4nRjKS1mjK
 q/6HERfszZXjtleoOldbNhF39BkB7pptDIKVhbn9K3GUHktcqJtDTinfBp3f153kS9dj
 DxhLKOsCJSJSywMV8H1A/cVQExS5AprwSse9Qxy3W5dizJKDzSWIHM0lpGWYHVoHpm8O
 KZRopIXncQKeVsHjMpR1N0oRr0RQtOZB5G4bb+XbvDBXxOyyMkbL6Ghl2t/iqI1nVCo8
 BlKQ==
X-Gm-Message-State: AOAM531EXWi2aZmrZ1tcl3bkllYEEfKMaivqhvZtVdGgvkScyv6efpoN
 OVwMxaOvYMrTkBNbS7a25PGfgtSrLzuuzuxR6b1n3Z5yYQwYJgasjWmMjpMK4h9BEwP8OrH70Qz
 us5qF1DNTw7hBxFc=
X-Received: by 2002:adf:8041:: with SMTP id 59mr23607436wrk.278.1591076179411; 
 Mon, 01 Jun 2020 22:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJwC3HlwkiNZZ01zlybp7kzx6wgP1QLG4pyZM+FuFm2I9dPPej1vkwSCYctdoGyZX6NfJ85Q==
X-Received: by 2002:adf:8041:: with SMTP id 59mr23607414wrk.278.1591076179216; 
 Mon, 01 Jun 2020 22:36:19 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 23sm1839717wmg.10.2020.06.01.22.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 22:36:18 -0700 (PDT)
Date: Tue, 2 Jun 2020 01:36:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] checkpatch: reversed logic with acpi test checks
Message-ID: <20200602053614.54745-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 23:49:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Logic reversed: allowed list should just be ignored. Instead we
only take that into account :(

Fixes: e11b06a880ca ("checkpatch: ignore allowed diff list")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0ba213e9f2..55aa45dc16 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1267,7 +1267,7 @@ sub checkfilename {
         # files and when changing tests.
 	if ($name =~ m#^tests/data/acpi/# and not $name =~ m#^\.sh$#) {
 		$$acpi_testexpected = $name;
-	} elsif ($name =~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
+	} elsif (not $name =~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
 		$$acpi_nontestexpected = $name;
 	}
 	if (defined $$acpi_testexpected and defined $$acpi_nontestexpected) {
-- 
MST


