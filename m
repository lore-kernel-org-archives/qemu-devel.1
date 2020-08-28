Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D761C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6721C20872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST4C5spt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6721C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBdog-0003px-Fx
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 08:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdl9-0007DX-Mf
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41539
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdl7-0006Ir-Hb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598618732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wDHVOXji40uhXVKVZByLt7evFTt8EGsuhSMJiqq8NJI=;
 b=ST4C5sptIhxIYHRJYdW10WY7RlF8nuPUM1/A0oZVvq+usUJNu3HVuqp9GDnApQozSkiLVQ
 WihUvrpIlLzsOWJLxDVkd+f6LxNkASS5l0CZPz1eyNzOUF/sW/wOncEo4trTOMwurvzt7F
 CndB7jqlvZdhwKNQxedPNkRsNb/ekKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-x-IyHaG8MN-iygN_iaZ0kw-1; Fri, 28 Aug 2020 08:45:30 -0400
X-MC-Unique: x-IyHaG8MN-iygN_iaZ0kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 181EC189E61C;
 Fri, 28 Aug 2020 12:45:29 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-100.ams2.redhat.com
 [10.36.114.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99C6274E12;
 Fri, 28 Aug 2020 12:45:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 slp@redhat.com, yezhenyu2@huawei.com, longpeng2@huawei.com,
 berrange@redhat.com
Subject: [PULL 6/8] virtiofsd: Remove "norace" from cmdline help and docs
Date: Fri, 28 Aug 2020 13:45:07 +0100
Message-Id: <20200828124509.311210-7-dgilbert@redhat.com>
In-Reply-To: <20200828124509.311210-1-dgilbert@redhat.com>
References: <20200828124509.311210-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Commit 93bb3d8d4cda ("virtiofsd: remove symlink fallbacks") removed
the implementation of the "norace" option, so remove it from the
cmdline help and the documentation too.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200717121110.50580-1-slp@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/tools/virtiofsd.rst | 3 ---
 tools/virtiofsd/helper.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 2cfdfd9ba2..e33c81ed41 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -63,9 +63,6 @@ Options
     Print only log messages matching LEVEL or more severe.  LEVEL is one of
     ``err``, ``warn``, ``info``, or ``debug``.  The default is ``info``.
 
-  * norace -
-    Disable racy fallback.  The default is false.
-
   * posix_lock|no_posix_lock -
     Enable/disable remote POSIX locks.  The default is ``no_posix_lock``.
 
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


