Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF62C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3895D246AC
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mg8/aqnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3895D246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eDW-000397-Df
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e7e-0000Qn-Ee
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e7d-0001Qk-84
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49962
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e7b-0001QI-Ey
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clfu+t0nynKAESV4ABRDyRXkvPXe/x1JrxJoUGidyU8=;
 b=Mg8/aqnG5wg+38GlAPBS9AUzdAkQ7ou90jVBP6UTcwqHE/dAmR+TYrJ7dv2qsfW42F0ZgC
 6oAzPYhP3sCqhEzIvm65DosjFLWPJEoA4BTCCyqqZswSTfbw3pxQuXKLZq22JasCsgfUtN
 baRlrHcoZq2B8ZkhN+V6zCqMmxcb80U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-Hs-GRtRMMWusOVFh-QMZ3Q-1; Fri, 28 Feb 2020 06:47:55 -0500
X-MC-Unique: Hs-GRtRMMWusOVFh-QMZ3Q-1
Received: by mail-wm1-f72.google.com with SMTP id m4so1051859wmi.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U8Eqv2g+dIkDMylSsAtJ9DdMEi7WvLS94birm3uZOd0=;
 b=P2+Egw7qHPWuWr57VDByXhmblVesimgi7lH4NuKKTMVbEwmdJDLjxDpR4xNMToPIqt
 oRq5L7IKxivsgdWTD+YxG0jYC238tKTggT1WlBhr6mj012BxD5ibE6MEm0yNms5UnYjD
 zel+jajGoYXYVV2i8tnaPcBmUiZoUraNWjG9Il/RuQK0jnFDdEC8kNBSq9K87dN/1VYX
 BdpBvsKTIzaJaZa9PMgVewXWy5DeAhAEhv1Rep14YMJDoe8u24lvHRx4dYKZlOfyWXzv
 BNCPznp0MbslkfAawhwCvSFmzHH9qZj85T5XJY/joYI3xnvrMHTzyiRm0MroDWWdjpel
 VaNA==
X-Gm-Message-State: APjAAAUWTpGMqQxyHO9cAiTdZ1FSWBfCZx9XdAMpC2jqYkmJ/lCWiW63
 RKyixKvy6wzmjaXEwgEHb2IhY1IFifPIEjD83j7q68ERpv1HAfqkJcCxaDeDzpYm8WiXZOy4/Ud
 W7ihJXumrxJQjW+4=
X-Received: by 2002:adf:e542:: with SMTP id z2mr4756443wrm.150.1582890473976; 
 Fri, 28 Feb 2020 03:47:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2iWI36tGdl0VSywd6QUA69oq7tyrDCvfw5F6lrV8yE8S+cSaCD2mEtcb5YzQahCaHekJkMw==
X-Received: by 2002:adf:e542:: with SMTP id z2mr4756429wrm.150.1582890473738; 
 Fri, 28 Feb 2020 03:47:53 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id v8sm11901514wrw.2.2020.02.28.03.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:47:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/18] hw/alpha/dp264: Include "net/net.h"
Date: Fri, 28 Feb 2020 12:46:39 +0100
Message-Id: <20200228114649.12818-9-philmd@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/alpha/dp264.c uses NICInfo variables which are declared in
"net/net.h". Include it.

This fixes (when modifying unrelated headers):

  hw/alpha/dp264.c:89:21: error: use of undeclared identifier 'nb_nics'
      for (i =3D 0; i < nb_nics; i++) {
                      ^
  hw/alpha/dp264.c:90:30: error: use of undeclared identifier 'nd_table'
          pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
                               ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/alpha/dp264.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 8d71a30617..e264c783c1 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -21,6 +21,7 @@
 #include "hw/dma/i8257.h"
 #include "net/net.h"
 #include "qemu/cutils.h"
+#include "net/net.h"
=20
 #define MAX_IDE_BUS 2
=20
--=20
2.21.1


