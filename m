Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4046C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D585246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZjqIDyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D585246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7cZi-0001RV-Kz
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7cYa-00086L-Ef
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7cYY-0002p3-RO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57341
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7cYY-0002ny-NT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582884461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U596dy96rfJ3roF0dAsD+G3kCp1P/QwUVt7AH1P41lY=;
 b=KZjqIDyrEJXlTUvoX9+atX7Yrf6tMpJFvYUEUHdMDpBIWGGvTOc5wPl4sMV0ARdxoiM5UR
 64SZIqmlHaoL6WiyopJKIBKaG0fY5RHLt2Gsf6ZFtY9nR/rDmqt9r230rfXw8REeVfdUpn
 YZcB64HJJ2yIvF9i624/aQ9ykgxMCGg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-fSezLjP2ML6-hzFuqQ3OUA-1; Fri, 28 Feb 2020 05:07:39 -0500
X-MC-Unique: fSezLjP2ML6-hzFuqQ3OUA-1
Received: by mail-wm1-f69.google.com with SMTP id o24so515809wmh.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DWgR+ky/bIZD4jaLET2vS/CCvPR/BzPRfuBiP4EJRxQ=;
 b=nh+o+ttbgAHco0xUXeKk4SbubGYiqXxB/vaIcJl0xkEA4JjZcled0eRM/itWp0lD88
 6WGPzCz+x0IkDsfLL+tp+GKaijCCA2YuFXzHGUldRKBL8DFig6zUQkY07XkmCa0eObmk
 1dRQdOZIjsrh2kD6BlC3tbmxzkbjJMGziH5upJF+Eq502MKdBQV7ZIJ/CdYYJk936K3K
 QeqA8JWQmMrr2Dg3Gr8f64ofTwfODbFdlYZ6APv7EZaD5QL/ilYbOux+VbcAwSCJL0cv
 8KwB4WLwVYBMjvJ1ZsRuLhYxr3FmgQBx5MoznNxoEBYY6wqWVZjH6ix3P8nCPstD+Vf1
 n3vA==
X-Gm-Message-State: APjAAAVkTebjeg7XsZY8XXM339e3qo7t/4jT7DBHojw6Fd5YnsOGWs+8
 yWFkYnRTUnORKS7dfa2SnDDb2AKk5qVXQrxmqMT/NGrsOGVnDRlFBVKcuUQBJTK7TKCCLVtecDp
 o1Dlu6NeeYIz5M/g=
X-Received: by 2002:adf:e542:: with SMTP id z2mr4350644wrm.150.1582884457739; 
 Fri, 28 Feb 2020 02:07:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwULmwotSEjywX/qiez5ZDXHUGhw5pTBYSJWK7rCZfDpnXJBy56nZN7tyRJWtHOm2tMT20ysw==
X-Received: by 2002:adf:e542:: with SMTP id z2mr4350627wrm.150.1582884457555; 
 Fri, 28 Feb 2020 02:07:37 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id q12sm12534994wrg.71.2020.02.28.02.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 02:07:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] util/osdep: Improve error report by calling
 error_setg_win32()
Date: Fri, 28 Feb 2020 11:07:24 +0100
Message-Id: <20200228100726.8414-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228100726.8414-1-philmd@redhat.com>
References: <20200228100726.8414-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use error_setg_win32() which adds a hint similar to strerror(errno)).

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: Remove change in socket_init() which uses fprintf()
---
 util/osdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index f7d06050f7..4829c07ff6 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -82,8 +82,8 @@ static int qemu_mprotect__osdep(void *addr, size_t size, =
int prot)
     DWORD old_protect;
=20
     if (!VirtualProtect(addr, size, prot, &old_protect)) {
-        error_report("%s: VirtualProtect failed with error code %ld",
-                     __func__, GetLastError());
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        error_report("%s: VirtualProtect failed: %s", __func__, emsg);
         return -1;
     }
     return 0;
--=20
2.21.1


