Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA00C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E6021D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ49ofOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E6021D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiQX-0002qU-NF
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuffA-0006P1-AC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuff9-0000Rw-2x
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:49:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuff8-0000Qr-Vp
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DxAJgeP+0hPstRiShwv7lrQwRfRqOxM1T7uh9S2eayU=;
 b=eQ49ofOSWb1pEdxWioeZbVPSCKuMD+ueWOZ2sZxI/6FoFKnZpwm9BOewqObvxUSIRojb/K
 O47RSJVRvSoCeGSLwgUFtfpF5KpdlXMslpZF/3zn7b2eawHGMM3oJ/J3qvGIEH4X8OA19Y
 bGRz5tH7qLDFrgJEfn7IUnqN2wRaRis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-ZTHoOo80PgmizpofP5Ptyw-1; Thu, 23 Jan 2020 11:48:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16FF41005513
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:56 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6603E28993;
 Thu, 23 Jan 2020 16:48:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 108/108] virtiofsd: add some options to the help message
Date: Thu, 23 Jan 2020 16:46:30 +0000
Message-Id: <20200123164630.91498-109-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ZTHoOo80PgmizpofP5Ptyw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Add following options to the help message:
- cache
- flock|no_flock
- norace
- posix_lock|no_posix_lock
- readdirplus|no_readdirplus
- timeout
- writeback|no_writeback
- xattr|no_xattr

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

dgilbert: Split cache, norace, posix_lock, readdirplus off
  into our own earlier patches that added the options

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index f98d8f2eb2..0801cf752c 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -148,6 +148,8 @@ void fuse_cmdline_help(void)
            "    -o cache=3D<mode>            cache mode. could be one of \=
"auto, "
            "always, none\"\n"
            "                               default: auto\n"
+           "    -o flock|no_flock          enable/disable flock\n"
+           "                               default: no_flock\n"
            "    -o log_level=3D<level>       log level, default to \"info\=
"\n"
            "                               level could be one of \"debug, =
"
            "info, warn, err\"\n"
@@ -163,7 +165,13 @@ void fuse_cmdline_help(void)
            "                               enable/disable readirplus\n"
            "                               default: readdirplus except wit=
h "
            "cache=3Dnone\n"
-          );
+           "    -o timeout=3D<number>        I/O timeout (second)\n"
+           "                               default: depends on cache=3D op=
tion.\n"
+           "    -o writeback|no_writeback  enable/disable writeback cache\=
n"
+           "                               default: no_writeback\n"
+           "    -o xattr|no_xattr          enable/disable xattr\n"
+           "                               default: no_xattr\n"
+           );
 }
=20
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
--=20
2.24.1


