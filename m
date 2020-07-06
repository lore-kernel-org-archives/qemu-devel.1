Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4BEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85A3206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZ/3jYLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85A3206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUOR-0005a7-3k
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCQ-0003oo-Mk
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38036
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCM-00039E-JC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VI38xdcKMs4a0lmMer25zVKAbiddD34f5rQr7Z4gMY=;
 b=SZ/3jYLD1O5G8dPOTOpcG400LbNThx0hNzeN0nPJZUkpi6HexRsQ3w0H4gqaAgSLtYicOo
 QZ0pV4aR7/Xu35MKvL1RH5zdEtt7+yul4Ftpu0O8BekZ5SjwNJ0sBIkwA5N5lZjsrNHi6d
 sl7o2Qxe693tvP5TtYL0Iy6PRv59K/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-bTCIZ9UVNsOFTU4BW7v9OQ-1; Mon, 06 Jul 2020 12:42:27 -0400
X-MC-Unique: bTCIZ9UVNsOFTU4BW7v9OQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DEE6107ACCD;
 Mon,  6 Jul 2020 16:42:26 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BA7E7B40D;
 Mon,  6 Jul 2020 16:42:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/53] checkpatch: Change occurences of 'kernel' to 'qemu' in
 user messages
Date: Mon,  6 Jul 2020 12:41:39 -0400
Message-Id: <20200706164155.24696-38-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

It is odd that we inform user that, for example, his current working
directory is not kernel root, when, in face, we mean qemu root.

Replace that and few other similar odd user messages.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200620133207.26849-3-aleksandar.qemu.devel@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2d2e922d89..bd3faa154c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -49,7 +49,7 @@ Version: $V
 
 Options:
   -q, --quiet                quiet
-  --no-tree                  run without a kernel tree
+  --no-tree                  run without a qemu tree
   --no-signoff               do not check for 'Signed-off-by' line
   --patch                    treat FILE as patchfile
   --branch                   treat args as GIT revision list
@@ -57,7 +57,7 @@ Options:
   --terse                    one line per report
   -f, --file                 treat FILE as regular source file
   --strict                   fail if only warnings are found
-  --root=PATH                PATH to the kernel tree root
+  --root=PATH                PATH to the qemu tree root
   --no-summary               suppress the per-file summary
   --mailback                 only produce a report in case of warnings/errors
   --summary-file             include the filename in summary
@@ -203,7 +203,7 @@ if ($tree) {
 	}
 
 	if (!defined $root) {
-		print "Must be run from the top-level dir. of a kernel tree\n";
+		print "Must be run from the top-level dir. of a qemu tree\n";
 		exit(2);
 	}
 }
-- 
2.26.2



