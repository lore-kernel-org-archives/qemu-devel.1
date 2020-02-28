Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A103BC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68826246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUTtDYQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68826246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ca4-0002FY-IV
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7cYd-00087y-Ez
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7cYc-0002uM-Gq
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24923
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7cYc-0002tH-Db
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582884465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1sXycKIkWp3uFFy1E/L4Gl4aKbgtNtM+sQ4x6MFe2I=;
 b=MUTtDYQHdl6cvb0LV3/+VBIiqqdqHoGk80rWnw/XZwI10//E6ze1Kz+sZ1ARfOYOfqWWKn
 qdQY47VOHz74xFCw2UY6/1fekntLmAqR78ZomcTzO8F9DAwQEfzvO4pK1Ul9pWADm+MHgM
 9tI39Oh4Qml8/kwowTZCA+p8hDC4yI8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-TIYQ0ZlsPaW_XWxpRe0cqg-1; Fri, 28 Feb 2020 05:07:43 -0500
X-MC-Unique: TIYQ0ZlsPaW_XWxpRe0cqg-1
Received: by mail-wm1-f69.google.com with SMTP id t17so503431wmi.7
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NSBWokNagTRqOLujr0F42DwTB/RF25rKRtdXhADrMHU=;
 b=fxHJgL1OtleBki5W0k2VLbCxJ/117wRdIuD7IpGVJiBao5YN/VitcdS8sPyrXgFOlP
 eUOlEnZixOJmTIDR7C3CipecuisaKOGumdnu4DavyHt8p5jeMTPcqqXTsMTG1YIXouHf
 jWj6X3MyLnqMM7De9KzIcPH68zq/heR4W7SE0LQhaf3lqWZEj6Q2x5yyyRY2UKlDQhkn
 i68vzX701BZ28bq1KXliA7RDA23kxicz+8PTBH5sDSK+stLXUaoMVf9R0VhRaxE3LXpw
 QvFGibKetl38nLr88vDuqG9ymRtAIDW3P7ALqFmfEigL4uw8LthDNE3g2JKJw5wkVNcd
 ShBQ==
X-Gm-Message-State: APjAAAUAWpVKAot8G2cEf8HKJ/H7Ms0hc+EWOshVo26IUomHPgrcP46+
 Ggaqgd6clxt6rziHCnnRKaHGYWFxAgumxh07mQsiqX3gGyflY9DUyxHcJj1hXbHVM4dPqxNrj21
 Y0AaEnXtLf6s8Fuk=
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr4216147wmb.155.1582884462641; 
 Fri, 28 Feb 2020 02:07:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqznwXOijaM3XWDUE08+GdGPxG2UU4KGsStw8IoSm82XwfRKLg3py6OLJStLtwckN8iCikNHIg==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr4216130wmb.155.1582884462482; 
 Fri, 28 Feb 2020 02:07:42 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id q12sm12534994wrg.71.2020.02.28.02.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 02:07:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] qga: Fix a memory leak
Date: Fri, 28 Feb 2020 11:07:26 +0100
Message-Id: <20200228100726.8414-5-philmd@redhat.com>
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

The string returned by g_win32_error_message() has to be
deallocated with g_free().

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qga/channel-win32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 99648c95b6..4f04868a76 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -302,8 +302,8 @@ static gboolean ga_channel_open(GAChannel *c, GAChannel=
Method method,
                            OPEN_EXISTING,
                            FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED, =
NULL);
     if (c->handle =3D=3D INVALID_HANDLE_VALUE) {
-        g_critical("error opening path %s: %s", newpath,
-                   g_win32_error_message(GetLastError()));
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        g_critical("error opening path %s: %s", newpath, emsg);
         return false;
     }
=20
--=20
2.21.1


