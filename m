Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF5C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2903217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRV4kjj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2903217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iud6q-0008Ez-FS
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub8z-0002Fv-8S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub8y-000576-5B
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59253
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub8y-00056z-1p
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVudRuKOnS4iH84WmmUnFve+E2uPTzpGMY/K1LYLIJo=;
 b=QRV4kjj9SVxfGcIeRJXntORMAeUPbDekNVAUysJoVRt8HPTImEidvfEhU+yLuK5yKXTRHG
 vhfOus3cASV+6FRfJdow+KbldV6PZQGoyhbQpZnaqtslbG2bIU0/5s0prpxV1o/M+5gG8J
 lnpMGVHx4iag6scmTMSb2ORPM30eZ9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-oTHvidbcPsiIu93ptt3s7A-1; Thu, 23 Jan 2020 06:59:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54D3A8010E0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:25 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3C251CB;
 Thu, 23 Jan 2020 11:59:24 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 031/111] virtiofsd: add vhost-user.json file
Date: Thu, 23 Jan 2020 11:57:21 +0000
Message-Id: <20200123115841.138849-32-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: oTHvidbcPsiIu93ptt3s7A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Install a vhost-user.json file describing virtiofsd.  This allows
libvirt and other management tools to enumerate vhost-user backend
programs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 .gitignore                                | 1 +
 Makefile                                  | 1 +
 tools/virtiofsd/50-qemu-virtiofsd.json.in | 5 +++++
 3 files changed, 7 insertions(+)
 create mode 100644 tools/virtiofsd/50-qemu-virtiofsd.json.in

diff --git a/.gitignore b/.gitignore
index efad605e1a..bc0a035f9c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,6 +6,7 @@
 /config-target.*
 /config.status
 /config-temp
+/tools/virtiofsd/50-qemu-virtiofsd.json
 /elf2dmp
 /trace-events-all
 /trace/generated-events.h
diff --git a/Makefile b/Makefile
index ef1e2155a7..2f81271ee7 100644
--- a/Makefile
+++ b/Makefile
@@ -329,6 +329,7 @@ endif
=20
 ifdef CONFIG_LINUX
 HELPERS-y +=3D virtiofsd$(EXESUF)
+vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
 endif
=20
 # Sphinx does not allow building manuals into the same directory as
diff --git a/tools/virtiofsd/50-qemu-virtiofsd.json.in b/tools/virtiofsd/50=
-qemu-virtiofsd.json.in
new file mode 100644
index 0000000000..9bcd86f8dc
--- /dev/null
+++ b/tools/virtiofsd/50-qemu-virtiofsd.json.in
@@ -0,0 +1,5 @@
+{
+  "description": "QEMU virtiofsd vhost-user-fs",
+  "type": "fs",
+  "binary": "@libexecdir@/virtiofsd"
+}
--=20
2.24.1


