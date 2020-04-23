Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20315C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AA320724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdJnSv+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AA320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiOf-0002YZ-S5
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiLh-0004Dr-Eg
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiLh-00039L-15
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39235
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiLg-00037x-JP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2Q0WaBSBkpjANrVvA4jiA2ezW8UXrcA1fVgJIOFZvQ=;
 b=XdJnSv+iPPXSST8+wokTdOG5VZCot4aQBlF6aB8WZkbxS/VjlS91xGYNpJD/JRgWf4OgEF
 0F8y01B6s/kTQquxcalPuzcPUD/d0V8pQX9fdPGlkKRiODhzoolC+qf67Lge3+kO3DvN9e
 F0okTGUUycWpFlrP2tpNMm4xfmeEOTM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-C7nkpQpRPCWsD3CgZsnJDQ-1; Thu, 23 Apr 2020 16:21:24 -0400
X-MC-Unique: C7nkpQpRPCWsD3CgZsnJDQ-1
Received: by mail-wr1-f72.google.com with SMTP id 11so3408818wrc.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HbSxa+gqPU1dU/akvu1eihUlexpvtYzyR1urxcHvdYY=;
 b=FM/HiyfQWs/RzIu6CKzSjM1bFOsU55aPaL5qUCztEGa+OTXC+vB056Ygvdu8B3UF4B
 44ZFWVG3aJul/2lhHr1LKYkRKZxkDer6LB4KpJLmQB4D0kxdPUfwqrExelWTTcZr7Hrk
 s5jXo8OPUJ3F5wnb71VjOEpJ8pq+KBG8fyeCkpK582vkHDV0MhvqMu9s5H33ecY4GUpg
 vd4FfCCxawiE7nHhV5kYg6wJ5osHhA7L++thK1f2Q5kJWXuO+D0O/8NtusHeVJLwA3IA
 zVifu+qMlQctLvfLwnjk8vOQcZ5aPzG/5dXmcdv7nGJGHw7430wtlQhMRBLWLd4hTicL
 P9dA==
X-Gm-Message-State: AGi0Pua2FtuKLx9b9otSobFwbTceDYKan2QoezAOl0GZpfqQU6GPaWzv
 jHC+ix3lSDyy+dQlWedAgtQzTGNqggvjiwXfQnW+ai97UD82jEM3N1Y3n9XXFJBmipKagB5covi
 HhQcDypNxytzcbGw=
X-Received: by 2002:adf:9168:: with SMTP id j95mr6544230wrj.145.1587673283459; 
 Thu, 23 Apr 2020 13:21:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypKZVmUrEqf34guRgk0dkUhfGUUHDiH7C7fb4PPRk7aNxChVOqxRsfieuSPmthntO4XDgosofQ==
X-Received: by 2002:adf:9168:: with SMTP id j95mr6544119wrj.145.1587673281803; 
 Thu, 23 Apr 2020 13:21:21 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b2sm5961345wrn.6.2020.04.23.13.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 13:21:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] monitor/misc: Remove unused "chardev/char-mux.h" include
Date: Thu, 23 Apr 2020 22:21:06 +0200
Message-Id: <20200423202112.644-2-philmd@redhat.com>
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

monitor/misc.c never required "chardev/char-mux.h", remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 monitor/misc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/monitor/misc.c b/monitor/misc.c
index 6c45fa490f..5d68026a7f 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -33,7 +33,6 @@
 #include "exec/gdbstub.h"
 #include "net/net.h"
 #include "net/slirp.h"
-#include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
--=20
2.21.1


