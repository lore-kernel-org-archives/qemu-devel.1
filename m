Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85555C33CB8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5AC20684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jxdq4JuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5AC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iud31-0003nl-2y
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9e-0003AN-9N
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9Z-0005aD-9b
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39187
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9Z-0005a7-6F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTHm9Jt/ZwkRilrjifGOycxUrgPWy6KWn81baKXTvRA=;
 b=Jxdq4JuYYoymANkfUSb5i3hsMY7yzBRhrU0CYN+4xygdjQK2js5NoqY3+X8rxZ+Fzf/MbQ
 gnTx9QDRMN6OJKnjdRqdHeNtWnv7/naspYQQctiZaCbVXkz5uTStd0BRcRUg++oxxWkzaL
 WjjeL9wn7ihRFJKL01jhD6pgADFrJIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-4I3zU2K4NsaqJMbSkcLeRQ-1; Thu, 23 Jan 2020 07:00:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1C878017CC
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:00:01 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF66F1CB;
 Thu, 23 Jan 2020 12:00:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 062/111] virtiofsd: Add ID to the log with FUSE_LOG_DEBUG level
Date: Thu, 23 Jan 2020 11:57:52 +0000
Message-Id: <20200123115841.138849-63-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4I3zU2K4NsaqJMbSkcLeRQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

virtiofsd has some threads, so we see a lot of logs with debug option.
It would be useful for debugging if we can identify the specific thread
from the log.

Add ID, which is got by gettid(), to the log with FUSE_LOG_DEBUG level
so that we can grep the specific thread.

The log is like as:

  ]# ./virtiofsd -d -o vhost_user_socket=3D/tmp/vhostqemu0 -o source=3D/tmp=
/share0 -o cache=3Dauto
  ...
  [ID: 00000097]    unique: 12696, success, outsize: 120
  [ID: 00000097] virtio_send_msg: elem 18: with 2 in desc of length 120
  [ID: 00000003] fv_queue_thread: Got queue event on Queue 1
  [ID: 00000003] fv_queue_thread: Queue 1 gave evalue: 1 available: in: 655=
52 out: 80
  [ID: 00000003] fv_queue_thread: Waiting for Queue 1 event
  [ID: 00000071] fv_queue_worker: elem 33: with 2 out desc of length 80 bad=
_in_num=3D0 bad_out_num=3D0
  [ID: 00000071] unique: 12694, opcode: READ (15), nodeid: 2, insize: 80, p=
id: 2014
  [ID: 00000071] lo_read(ino=3D2, size=3D65536, off=3D131072)

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  added rework as suggested by Daniel P. Berrang=C3=A9 during review
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index ff6910fd73..f08324f000 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -43,6 +43,7 @@
 #include <cap-ng.h>
 #include <dirent.h>
 #include <errno.h>
+#include <glib.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <pthread.h>
@@ -2268,10 +2269,17 @@ static void setup_nofile_rlimit(void)
=20
 static void log_func(enum fuse_log_level level, const char *fmt, va_list a=
p)
 {
+    g_autofree char *localfmt =3D NULL;
+
     if (current_log_level < level) {
         return;
     }
=20
+    if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
+        localfmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_gettid=
), fmt);
+        fmt =3D localfmt;
+    }
+
     if (use_syslog) {
         int priority =3D LOG_ERR;
         switch (level) {
--=20
2.24.1


