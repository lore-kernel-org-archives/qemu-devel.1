Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC21C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C7E20753
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2rrHY9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C7E20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGpYF-0001lt-1f
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 15:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGpXY-00015k-GY
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGpXX-0004Pt-DN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:48:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGpXX-0004Pf-Am
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585079323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fQpQWlGEevylLVzzOus2xrHbH7b95lvZ5rhLQuOzdWA=;
 b=Y2rrHY9PW6PGW8yG/chW+Y5EMthI2Q4bAAKHzyvT5GDzrUKyIyNdUqpEzEEjcD7Qvcb0HX
 xBNKNiSYABuSLYiqQtWF4H1+bd8dDLXxEIp/bBWuMMC7Ap0SkzLexFwQYFLt0ShD3jJNlM
 ZuvBJjqMJ/fXCAxCPv1YIaJkNazFwfY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-5SOgzeM-MwqwH7znt7qNyw-1; Tue, 24 Mar 2020 15:48:41 -0400
X-MC-Unique: 5SOgzeM-MwqwH7znt7qNyw-1
Received: by mail-wr1-f69.google.com with SMTP id d17so9736693wrw.19
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 12:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HUCsr8+QDfcKRBXcL3ItOGncj3i21qbJvqFsGhi9mwo=;
 b=AHzpQ+s6I19WxocODb0CFdv649Zw1yw/V20CU1gAjgrwDb2lep0o/9n7HmUYct2tyk
 5VMkrrRR3qp0gDXtp26fe2aBe+FJN4McgsFnt134K2wUZ6T5oZyWowdMQ+6xz+6Uw53W
 z6YuYZn9Kqwko0A0DOz8kWgVA/ZDL6zW3fE2rENJ8mmN/ilztqEfphoVIXBU5DhLOX+B
 m/8aueCWHH89avvtmt8bUHn28qkgLi3cEScRI8pcEAQvO024fQOWhnVmP4XriD8u1kRc
 8xO2LMSAP4D+O9Z7BczIT9jxLMzZSUYvUS5sJpqqT6l4Rz+96PrpNW2TvvyXCMJPT6pD
 RUIg==
X-Gm-Message-State: ANhLgQ2xi53nsmxNGwB0Rpm9ZV/ykquNSZct7WEDtVRqlICOecXUMPqm
 E/DvXO3h8f03zle3on6jZ+xvrm83ORUHIFI+vueCV3IZLElrgTxE68Ler5gomju1vzc6FyybsJK
 YUmMUaOfax2uer94=
X-Received: by 2002:adf:f544:: with SMTP id j4mr37050315wrp.183.1585079319861; 
 Tue, 24 Mar 2020 12:48:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsZtk/7FxKipYvMh4Rs8YWEI2e7o6IucE6NnNl3FURQUAR2IkDVtxN+uEPJOQm3yr64/t/l0w==
X-Received: by 2002:adf:f544:: with SMTP id j4mr37050288wrp.183.1585079319518; 
 Tue, 24 Mar 2020 12:48:39 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id h5sm4998811wro.83.2020.03.24.12.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 12:48:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] qga-posix: Avoid crashing process when failing to
 allocate memory
Date: Tue, 24 Mar 2020 20:48:36 +0100
Message-Id: <20200324194836.21539-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-trivial@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, qemu-stable@nongnu.org,
 Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit 807e2b6fce0 for Windows, kindly return a
QMP error message instead of crashing the whole process.

Cc: qemu-stable@nongnu.org
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qga/commands-posix.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 93474ff770..8f127788e6 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -493,7 +493,13 @@ struct GuestFileRead *qmp_guest_file_read(int64_t hand=
le, bool has_count,
         gfh->state =3D RW_STATE_NEW;
     }
=20
-    buf =3D g_malloc0(count+1);
+    buf =3D g_try_malloc0(count + 1);
+    if (!buf) {
+        error_setg(errp,
+                   "failed to allocate sufficient memory "
+                   "to complete the requested service");
+        return NULL;
+    }
     read_count =3D fread(buf, 1, count, fh);
     if (ferror(fh)) {
         error_setg_errno(errp, errno, "failed to read file");
--=20
2.21.1


