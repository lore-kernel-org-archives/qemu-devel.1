Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C956C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A5420724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEVNq40P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A5420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiN3-0006s1-4S
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiLq-0004Wg-EO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiLp-0003NY-Qv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42270
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiLp-0003MA-DG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWM/RJA0i40F5Z53mX1T7pyIQA7QZZS8Zjo3NsXhoDY=;
 b=iEVNq40P6wP9QoCAQQY4jjNZ1FozCfgbvN8duz8YH6uDLegBhpfIevGnlhk34dmV79/E0R
 4KtopLs8QXJo0KHw6HqRZ8qD2Upl0ts5sTNYI02dyvN4bjJokwXsKbZCrgY7idMd3yZHjj
 X6LXZ369cJzwBNpIpZdLgp+ViKAzZvw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-fzLF-ChiMy60w7RlaDbyMQ-1; Thu, 23 Apr 2020 16:21:30 -0400
X-MC-Unique: fzLF-ChiMy60w7RlaDbyMQ-1
Received: by mail-wm1-f69.google.com with SMTP id l21so2678273wmh.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zlQoC138vjAdmXDl+ROR3VD/b5fkegrhyYTGSi8r/AQ=;
 b=gB4PDBK4pHSPWgvxVDRh+cUpvgFEe8T9uRB7zfB3GBYlr9ctKW0in7WA8dZGbuqC0+
 KlyKOrNoRB1i1m6nBy4n6gyMdmpjj1wEa9eT2I15bmETHnNs3y0/6XkxA2KdEUZr5V21
 OeFMUlQVbn9Mllui8WqGN4CIJx3EZ0n39yajsrvuRR8PpItGL/6JWe+js1O4LDcelHNo
 DRmsjIhbhQnbTDfioq4sfbQSd8PxdYEFJzGWGCtXvNng3LYzzzM9SrwQWOGY5s1m+WMl
 LKxqQzfAiNLHx3cWojn3iq7YUMog0Es09EJ1WKClB0L32Ujs7JsyfuSRrusdLhK98DsR
 0RXw==
X-Gm-Message-State: AGi0PuaEQRgWbrfQWH9FwIoM0liRnv1gQhsUTgwaaBy5pYtEHfDYvDnT
 1IqyMSJbIjHakpHJDX3q8uFVSVQ4Z8PL3Emx2dmUAzCP1UURGiAAwNse0O4GdpbuATS59k75HIM
 Bly50GY902UFKJhY=
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr6624662wrs.32.1587673288973; 
 Thu, 23 Apr 2020 13:21:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJN1qnQfPBFb0dFeE83NkorCQvfG9XAh3cXULj8Jgig3pv5hagQ7MeOQCT1YqdPrEDkditbqw==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr6624640wrs.32.1587673288700; 
 Thu, 23 Apr 2020 13:21:28 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id c190sm5335974wme.10.2020.04.23.13.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 13:21:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] tests/test-char: Remove unused "chardev/char-mux.h"
 include
Date: Thu, 23 Apr 2020 22:21:07 +0200
Message-Id: <20200423202112.644-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200423202112.644-1-philmd@redhat.com>
References: <20200423202112.644-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test never required "chardev/char-mux.h", remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/test-char.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 3afc9b1b8d..f08a39790e 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -6,7 +6,6 @@
 #include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "chardev/char-fe.h"
-#include "chardev/char-mux.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
--=20
2.21.1


