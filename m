Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E01C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2088B2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GozzZqWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2088B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eCO-0000cj-9D
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e7f-0000Ro-3n
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e7e-0001Qz-2j
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e7d-0001QO-8R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oG2syAmxddzmH8pkr5M8RpghUELPZIGL0i8vM3fPgM8=;
 b=GozzZqWD+n0mUsTSR1ocj1s+WW4MTkdVF9hzwJb2PQA2iBINKkUEt1BWWG422QnU+MgGz/
 aE1VxINWKow3XGgkI0fEzCfesQgJ6aVoItk1gUD7UcwSRxZaZHkpu32WR2ELfNIMZ6aXF+
 rvmvJ7TYaCVR4BSEI2HMW9pTfdogKzs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-cDCv7LXzPtmT5UliULvHrQ-1; Fri, 28 Feb 2020 06:47:57 -0500
X-MC-Unique: cDCv7LXzPtmT5UliULvHrQ-1
Received: by mail-wr1-f72.google.com with SMTP id c6so1209433wrm.18
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CyFzDanqkMTdQtUsYemEsgIvaK/rIvnd/I4zWxBCovs=;
 b=h/nGsJwiPRxktX0ANS3xni/lm/aCZBpZNsbeiUHSCyjCzRn8RhMSAV5Gm6eGRuZn+k
 NObW0zztD9oAspIvkXZHv1YJuj4Vs9DbkwAunoLaWTonHRIc7bd2C50TY5phG8m5vgJG
 0EhflBcCkBZGRGlj+HdifYek38BPU7fkf5bRjSypsnu0nFoTGvsGJHKCqh+BLyMhMhpv
 Yo8VU4t6cKHVCUr/4fLA9Pa1KYpbNsslZmUIbJ/zqxb4FOYK0NNPyG79Jqa+cZrWah54
 ZjyB8E47l8TGh2ybHN8+iJbUc4qzJx+/RL1i9/G0LPBFz5DkiPNfaBFLAukB9CK7lzLw
 W5yA==
X-Gm-Message-State: APjAAAU1aq/ljn2rcWUCJhoW++Z3SaURObENFy1HPJqv3YUtkYM4rOM8
 KyspcPS1+3cU3SewGykbPnkpBIix9krKhNF8mg0bqqurjZC+8lCnc9LvRFhmxRop79tNVoHBg91
 VhauFMMPi7sCc80M=
X-Received: by 2002:a1c:e483:: with SMTP id b125mr4581417wmh.187.1582890476135; 
 Fri, 28 Feb 2020 03:47:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoc2NmSiQbBjwvkZ7JfDbfzavlQedgqjrfKmu67Pq/AxFihGtFt1BaY87Dd2WcjsWhpewNUw==
X-Received: by 2002:a1c:e483:: with SMTP id b125mr4581397wmh.187.1582890475900; 
 Fri, 28 Feb 2020 03:47:55 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id v8sm11901514wrw.2.2020.02.28.03.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:47:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/18] hw/hppa/machine: Include "net/net.h"
Date: Fri, 28 Feb 2020 12:46:40 +0100
Message-Id: <20200228114649.12818-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228114649.12818-1-philmd@redhat.com>
References: <20200228114649.12818-1-philmd@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/hppa/machine.c uses NICInfo variables which are declared in
"net/net.h". Include it.

This fixes (when modifying unrelated headers):

  hw/hppa/machine.c:126:21: error: use of undeclared identifier 'nb_nics'
      for (i =3D 0; i < nb_nics; i++) {
                      ^
  hw/hppa/machine.c:127:30: error: use of undeclared identifier 'nd_table'
          pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
                               ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/hppa/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 67181e75ba..d1e59a97f6 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "net/net.h"
 #include "qemu/log.h"
+#include "net/net.h"
=20
 #define MAX_IDE_BUS 2
=20
--=20
2.21.1


