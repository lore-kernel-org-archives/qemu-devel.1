Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52DCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA2920717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMy08T0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA2920717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPE0-0003PM-OO
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jwPD3-0002xP-93
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:11:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36784
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jwPD1-0007AC-3b
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594987881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H3H8YjmpoyKxtLK06epui9u6h9h9Mli4SIBjn+mzGuk=;
 b=cMy08T0H/xn1dZ0kQaTNDUx+QdF5GJ9tWWE9d5bK/a1cteq9U7U9HpjVZNsvYsSS5vNTpf
 GLvPDsByxnprA7tHug/cybENLctLKbZEKL8SiQghiw0raDcmYjbNsyYMVJyh4DWgIrUWlr
 WoLdckTxQ5AUOj7fj/VyVY/par31kj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-Y6FEcIQrME21Jn64wnqRFA-1; Fri, 17 Jul 2020 08:11:19 -0400
X-MC-Unique: Y6FEcIQrME21Jn64wnqRFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EAC51009616
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 12:11:18 +0000 (UTC)
Received: from toolbox.redhat.com (ovpn-112-29.rdu2.redhat.com [10.10.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78E1D5C1D3;
 Fri, 17 Jul 2020 12:11:11 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] virtiofsd: Remove "norace" from cmdline help and docs
Date: Fri, 17 Jul 2020 14:11:10 +0200
Message-Id: <20200717121110.50580-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
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
Cc: Miklos Szeredi <mszeredi@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 93bb3d8d4cda ("virtiofsd: remove symlink fallbacks") removed
the implementation of the "norace" option, so remove it from the
cmdline help and the documentation too.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
 * Drop "norace" from the documentation too (Stefano Garzarella)
---
 docs/tools/virtiofsd.rst | 3 ---
 tools/virtiofsd/helper.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 824e713491..58666a4495 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -63,9 +63,6 @@ Options
     Print only log messages matching LEVEL or more severe.  LEVEL is one of
     ``err``, ``warn``, ``info``, or ``debug``.  The default is ``info``.
 
-  * norace -
-    Disable racy fallback.  The default is false.
-
   * posix_lock|no_posix_lock -
     Enable/disable remote POSIX locks.  The default is ``posix_lock``.
 
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 3105b6c23a..7bc5d7dc5a 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -159,8 +159,6 @@ void fuse_cmdline_help(void)
            "    -o max_idle_threads        the maximum number of idle worker "
            "threads\n"
            "                               allowed (default: 10)\n"
-           "    -o norace                  disable racy fallback\n"
-           "                               default: false\n"
            "    -o posix_lock|no_posix_lock\n"
            "                               enable/disable remote posix lock\n"
            "                               default: posix_lock\n"
-- 
2.26.2


