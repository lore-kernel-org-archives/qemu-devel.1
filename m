Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A355C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246B924695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxjEki9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246B924695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eHB-0000c2-VZ
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e8C-0001b6-Oq
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e88-0001Yp-JZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39214
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e88-0001Y0-1G
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEF3Qmm6bE7IZabHdbGWU2GA8rYBohVngOoUCB4NjXg=;
 b=ZxjEki9NILGxicYSVqdKrkAdZr8RnB1JOAOlo7H5PhKEJDa8pEbMOXL5jB/tv3YaBpEoUG
 cV9Zj1SXrkqYZF8lR/ViHW4MLMwVPvhybAgXKBoNyysFJaKToF89GCUu9QyRoTSwAa6ITZ
 fmTvKpSRph6vFY9vU/dDDs0v3E7RqX8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Q77IFNMoOo2szqezyUf37w-1; Fri, 28 Feb 2020 06:48:29 -0500
X-MC-Unique: Q77IFNMoOo2szqezyUf37w-1
Received: by mail-wr1-f71.google.com with SMTP id d9so1211915wrv.21
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6DEmu3UhSlAtdyxITMuOrN+F2EwIEtEtHDhOq1i9rRk=;
 b=Jtb/6iAjQwftPMFbe6SenTXierSiSak3CsoJbMY7za1NTkXO/03t0E5IhzriBXnuLS
 BiOQfMO6J2VgB6e72BDsLEel8o4KAGtDp/gSMVNXrMTaM7eWCUCQgJWs0yA2SOF64+0c
 6ZfGYa4ojeK7ephGtmNdigdJ+5OZAhLcg2g9cfLpS6kdMpwhh2IsGMs2jr4EH7/9t4fw
 jO40pcLj5u5lhr3EDi+2YMnuVpxMYd83igWyfJk1i2vRtg8+EhGNIZlcz1jWW4xr3Srf
 Osx9aiknYGNW01HC3/U4d1EgpyZa0RPxFTikRmV+gO0TUQJxe4EpOariPjRPMXPzXhqJ
 OHPQ==
X-Gm-Message-State: APjAAAXKI4nz0BZUrQ4+kBy0Lm4BVsBZkAMpAFmf8+qIiFjbIXtU4lB8
 APQOWGHfLx2vlmI7qDCwPAw661AiOChQioe9We2DAZcX6A810Q2XYXVStpnpYxz5YAl9R5UG6ln
 C3HWCcXl5AWYOT6c=
X-Received: by 2002:a5d:4807:: with SMTP id l7mr4517283wrq.250.1582890507730; 
 Fri, 28 Feb 2020 03:48:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNYVNMWTQjegzutGFS+8XkogW6S5ZGVDfIKgqyfXf0BvGfRQWXe6SPhJap5Z/7qIyfYFZGOA==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr4517268wrq.250.1582890507564; 
 Fri, 28 Feb 2020 03:48:27 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id a7sm1736226wmj.12.2020.02.28.03.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:48:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/18] hw/pci-host/piix: Include "qemu/range.h"
Date: Fri, 28 Feb 2020 12:46:45 +0100
Message-Id: <20200228114649.12818-15-philmd@redhat.com>
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
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/pci-host/piix.c calls various functions from the Range API.
Include "qemu/range.h" which declares them.

This fixes (when modifying unrelated headers):

  hw/pci-host/i440fx.c:54:11: error: field has incomplete type 'Range' (aka=
 'struct Range')
      Range pci_hole;
           ^
  include/qemu/typedefs.h:116:16: note: forward declaration of 'struct Rang=
e'
  typedef struct Range Range;
                 ^
  hw/pci-host/i440fx.c:126:9: error: implicit declaration of function 'rang=
es_overlap' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
      if (ranges_overlap(address, len, I440FX_PAM, I440FX_PAM_SIZE) ||
          ^
  hw/pci-host/i440fx.c:126:9: error: this function declaration is not a pro=
totype [-Werror,-Wstrict-prototypes]
  hw/pci-host/i440fx.c:127:9: error: implicit declaration of function 'rang=
e_covers_byte' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
          range_covers_byte(address, len, I440FX_SMRAM)) {
          ^
  hw/pci-host/i440fx.c:127:9: error: this function declaration is not a pro=
totype [-Werror,-Wstrict-prototypes]
  hw/pci-host/i440fx.c:189:13: error: implicit declaration of function 'ran=
ge_is_empty' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
      val64 =3D range_is_empty(&s->pci_hole) ? 0 : range_lob(&s->pci_hole);
              ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci-host/i440fx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 11050a0f8b..d980c97049 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/range.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
--=20
2.21.1


