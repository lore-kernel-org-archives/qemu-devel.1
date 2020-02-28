Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBABC3F2D3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4DB246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcCEypLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4DB246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7cZe-0001Gn-Dm
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7cYZ-00082u-7O
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7cYW-0002nr-TB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7cYV-0002n8-BU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582884458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yT/3v5xc8MjkoVGOOK8X+qbWZgR0VaRsSfKEBOzcIOk=;
 b=OcCEypLabApr9YDj1fvtNnrprcLSHa/Ka/E3AH0V2qjGQr4MbwUEs6K06SN0DznLEHyHk+
 dJkhJPRtu8vmDoOkYCiDilspcO+PencJFYRm1qkp6UevkAQR5SduYh83VDuwLqTAQFY6lY
 Y6vEUP3I9z8RTmYQ2tavMhF7sFdgQ/k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-XeInchFfMPO_Zanjp80BIQ-1; Fri, 28 Feb 2020 05:07:36 -0500
X-MC-Unique: XeInchFfMPO_Zanjp80BIQ-1
Received: by mail-wr1-f70.google.com with SMTP id l1so1139706wrt.4
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mNKMO5ywnwZ72jtmICWss1IwQtrRtnxkxKMLAjdrhEg=;
 b=TfiI5s3vZvbMLeGNlAq7FalhhmxGvwMpkiCmexDdi5/8URBFAKg1l6UESCDL0BJUHA
 lT7jpbHX9HkBOZqVMk/jIcKkqaZU1vu6W3uNbGaU61O93WZc7f23ccZZ55PYTXmXVKsq
 J+wdRFfUGdlRcH+ySkIzqivvWTvVJNfB9IgCYmmqSrgLTHm4BkKql9ruLLGnvD81QIfV
 D7ZNi8JT2dSwifG8pcEA/aeScHrLQFU6HvOtOteuUHZXLMeX4VOmKxusE49Lq7UBSDZL
 /kZYttWhfet2Kx8TuZP0QMjbMVPBej8aVILj8XAiz5T/ez7kVKxywR/eFXtuzJqMEijP
 CqcQ==
X-Gm-Message-State: APjAAAUVpJnz3PMKDVpfyf+905QQ2YJdUW/xE+hS6mY0We3hVTqDK3Dn
 zbTPc3Atl3hlqwQ0Zqz/eTBO+3IoO9nohEp4mCrX2IAm3xgsUz/8dno+lvSQFnIIWT+Z1y5G/Qc
 X6OqYVpgIS8R7nE8=
X-Received: by 2002:a05:600c:2c48:: with SMTP id
 r8mr3913746wmg.183.1582884455025; 
 Fri, 28 Feb 2020 02:07:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxaTbwxBB3CiiIc8cGwQ1E0+Uwe5ZsliLS91QylzRWejPwfXJT61xnXmEs1xgnStcAuAK74zQ==
X-Received: by 2002:a05:600c:2c48:: with SMTP id
 r8mr3913733wmg.183.1582884454831; 
 Fri, 28 Feb 2020 02:07:34 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id q12sm12534994wrg.71.2020.02.28.02.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 02:07:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] chardev: Improve error report by calling
 error_setg_win32()
Date: Fri, 28 Feb 2020 11:07:23 +0100
Message-Id: <20200228100726.8414-2-philmd@redhat.com>
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use error_setg_win32() which adds a hint similar to strerror(errno)).

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char-pipe.c | 2 +-
 chardev/char-win.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 94d714ffcd..fd12c9e63b 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -70,7 +70,7 @@ static int win_chr_pipe_init(Chardev *chr, const char *fi=
lename,
                               MAXCONNECT, NSENDBUF, NRECVBUF, NTIMEOUT, NU=
LL);
     g_free(openname);
     if (s->file =3D=3D INVALID_HANDLE_VALUE) {
-        error_setg(errp, "Failed CreateNamedPipe (%lu)", GetLastError());
+        error_setg_win32(errp, GetLastError(), "Failed CreateNamedPipe");
         s->file =3D NULL;
         goto fail;
     }
diff --git a/chardev/char-win.c b/chardev/char-win.c
index 34825f683d..d4fb44c4dc 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -96,7 +96,7 @@ int win_chr_serial_init(Chardev *chr, const char *filenam=
e, Error **errp)
     s->file =3D CreateFile(filename, GENERIC_READ | GENERIC_WRITE, 0, NULL=
,
                       OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
     if (s->file =3D=3D INVALID_HANDLE_VALUE) {
-        error_setg(errp, "Failed CreateFile (%lu)", GetLastError());
+        error_setg_win32(errp, GetLastError(), "Failed CreateFile");
         s->file =3D NULL;
         goto fail;
     }
--=20
2.21.1


