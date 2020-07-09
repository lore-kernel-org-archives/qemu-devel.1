Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE2DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC67020672
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ditS1cDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC67020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtS82-0002uP-2I
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 04:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtS7G-0002UU-53
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:41:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtS7D-0001Bm-Og
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594284070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=0LsZqQtz+v9vC025eJs5Ua7IVMlBKO68EYarq3BBs90=;
 b=ditS1cDUP8n8Do3geyb2hp1XEiTBRoDoz7k4CWnZtrwYDwuQPPCwsbctLOUhcRfajq5ZdK
 1RSkYsik+RcV06rvEdwBOXPQnXEaI3cHFEo7Ejynvc9gv8caS+fMWiX8DAlx48VKF//MET
 JjGXhKZ+TBPMlib4mAkhWZ1vZm1a7hA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-Sat96L3ZOPiFBnIIk_Cb5Q-1; Thu, 09 Jul 2020 04:41:08 -0400
X-MC-Unique: Sat96L3ZOPiFBnIIk_Cb5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9112186A8D0;
 Thu,  9 Jul 2020 08:41:07 +0000 (UTC)
Received: from thuth.com (ovpn-112-106.ams2.redhat.com [10.36.112.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B9FA60E1C;
 Thu,  9 Jul 2020 08:41:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>,
	qemu-devel@nongnu.org
Subject: [PATCH] docs/devel/fuzzing: Fix bugs in documentation
Date: Thu,  9 Jul 2020 10:40:59 +0200
Message-Id: <20200709084059.22539-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix typo - the option is called "--fuzz-target" and not "--fuzz_taget".
Also use a different fuzzer in the example, since "virtio-net-fork-fuzz"
does not seem to be a valid fuzzer target (anymore?).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/fuzzing.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 324d2cd92b..db5641de74 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -33,11 +33,11 @@ Fuzz targets are built similarly to system/softmmu:
 
 This builds ./i386-softmmu/qemu-fuzz-i386
 
-The first option to this command is: --fuzz_taget=FUZZ_NAME
+The first option to this command is: --fuzz-target=FUZZ_NAME
 To list all of the available fuzzers run qemu-fuzz-i386 with no arguments.
 
-eg:
-    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=virtio-net-fork-fuzz
+For example:
+    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=virtio-scsi-fuzz
 
 Internally, libfuzzer parses all arguments that do not begin with "--".
 Information about these is available by passing -help=1
-- 
2.18.1


