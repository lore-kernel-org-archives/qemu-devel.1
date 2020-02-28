Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B2AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB181246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW1gWX2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB181246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7cb6-0004eX-PW
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7cYc-00087i-23
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7cYa-0002r0-LR
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7cYa-0002pV-Dh
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582884463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+Y/QfuCfGOT8OFWnwdeMDHf5mbsAA0KxAt6Vz43+uE=;
 b=EW1gWX2ub89eoX6uAEjFOSLrDgclQKQz/cX2PiDC42oBPGeJsJgC+IkGYi6yEQoO+lKmnn
 U1FPGi3i3o7qiHRqUJXWOUFBhcaZweBS+zpPGxVYeOO986z3zfjIYgVpklvmxiuITT0GO+
 2wJUTTGrzR+ILZF4ThUXJrgVdz5sOuM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-aCVb7y8DO7ac-5LHXNpqbQ-1; Fri, 28 Feb 2020 05:07:41 -0500
X-MC-Unique: aCVb7y8DO7ac-5LHXNpqbQ-1
Received: by mail-wm1-f71.google.com with SMTP id y7so956407wmd.4
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8ivB6NFsawkEJ23lsit2ccjwYbZtdL4c8SRQrAt/UNI=;
 b=O/jZE2D23lXjkk/5NADT0itpMqRqDZJr6+NFtRaNpBQI5MRBav6RotRzVnDS2hCwee
 Yp/YR23HszcFfRGSiCgT3z4lyHVZl71qBPfFEPX6+CnyUadTrIat8TPHJvKQSsV62Q79
 O9UxO/b7qQq92dp6TY0yREqILyTfGU/mTP3sJWDJfBlV0kG6s4CvwqC+x1K+oICGeOYj
 2aUuTiD61n8BTuJV8c4WtEEaZRf+IocNg2q7lfqq/i4BZ4uTdfCjqGdAtri6CBfrZRas
 XGQufNWntbQH2QoWB6T8/pIPuj2QrKzxvLLlrvIowU+nMbKI2UIlIZYVMA0rBmTjmdBC
 9yqA==
X-Gm-Message-State: APjAAAUZmg8yihrARIvTMy0DYoChP85llQSUS5MQLM8+QnjWGsdTt8Im
 G+vDMUo4nV2p/3xUf0Zsg+03l45Ue3VGMJ1ImtnMBwGbnMdDADgg+R2Db1ZcKMXNTf4L4Z2ihjJ
 xXOICV/IJMU451F4=
X-Received: by 2002:a1c:5419:: with SMTP id i25mr4186710wmb.150.1582884460219; 
 Fri, 28 Feb 2020 02:07:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuPS3SD+QrMDDw+u6lBZzjcYZq/o6Tql+HW9lgXkiGVs8LMZCCgZUzKPrUkkLyuBqzkx7cow==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr4186690wmb.150.1582884460005; 
 Fri, 28 Feb 2020 02:07:40 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id q12sm12534994wrg.71.2020.02.28.02.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 02:07:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] qga: Improve error report by calling error_setg_win32()
Date: Fri, 28 Feb 2020 11:07:25 +0100
Message-Id: <20200228100726.8414-4-philmd@redhat.com>
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: Keep slog() in qmp_guest_shutdown() (Marc-Andr=C3=A9)
---
 qga/channel-win32.c  | 3 ++-
 qga/commands-win32.c | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index c86f4388db..99648c95b6 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -308,7 +308,8 @@ static gboolean ga_channel_open(GAChannel *c, GAChannel=
Method method,
     }
=20
     if (method =3D=3D GA_CHANNEL_ISA_SERIAL && !SetCommTimeouts(c->handle,=
&comTimeOut)) {
-        g_critical("error setting timeout for com port: %lu",GetLastError(=
));
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        g_critical("error setting timeout for com port: %s", emsg);
         CloseHandle(c->handle);
         return false;
     }
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2461fd19bf..9c744d6405 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -315,8 +315,9 @@ void qmp_guest_shutdown(bool has_mode, const char *mode=
, Error **errp)
     }
=20
     if (!ExitWindowsEx(shutdown_flag, SHTDN_REASON_FLAG_PLANNED)) {
-        slog("guest-shutdown failed: %lu", GetLastError());
-        error_setg(errp, QERR_UNDEFINED_ERROR);
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        slog("guest-shutdown failed: %s", emsg);
+        error_setg_win32(errp, GetLastError(), "guest-shutdown failed");
     }
 }
=20
@@ -1319,7 +1320,8 @@ static DWORD WINAPI do_suspend(LPVOID opaque)
     DWORD ret =3D 0;
=20
     if (!SetSuspendState(*mode =3D=3D GUEST_SUSPEND_MODE_DISK, TRUE, TRUE)=
) {
-        slog("failed to suspend guest, %lu", GetLastError());
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        slog("failed to suspend guest: %s", emsg);
         ret =3D -1;
     }
     g_free(mode);
--=20
2.21.1


