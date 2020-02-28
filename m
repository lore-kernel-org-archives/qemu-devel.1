Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33415C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A3F2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6w2swx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A3F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eDq-00040L-6m
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e7g-0000Ud-4I
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e7f-0001S4-2f
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20072
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e7e-0001RW-Up
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZikWdiIjGHwkJ5s5xsyOGuFMUcLn0/m4b9roi2lzt0=;
 b=P6w2swx1ntky0vhExHpbrQ3FrNowzCFipoqxjdW47cOeEFiV1PDxBCjcx2FuY6EYlilA2V
 ulByqMJztbA/7/Kj178/PGk7s9hoGNRDqY97VD431vNx0SxSp2iEm7LWuiMjxrfgRpJgYJ
 TZug8qi+MK5WX4AeluOmylgFPsGxWls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-tBQeJ797M0u4o4U0eLeybw-1; Fri, 28 Feb 2020 06:48:00 -0500
X-MC-Unique: tBQeJ797M0u4o4U0eLeybw-1
Received: by mail-wm1-f72.google.com with SMTP id y18so1545285wmi.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7/Nc+BormBNRjwYo07kcxhw053jMRgcHlLvuvF2I3Yg=;
 b=B8wDl7UYifgBRWBB4pmy1r+J68oEgsgLaA/WMTzk4mX5W9ZsIGc2AL6xovn8TPVmPF
 sNayEnnAXpM4L9IJrJTd7jlNQstKKS6xeRfaNxkDce/2xA1sBmGoYaPL6bpGA0EtK5z5
 EbQoTvanFs3CM5TlkRPVdZ7weh9XpVHnUl5SaA5FGbhIbW70daNzCd/5adYWeep8ZO5S
 QO307tAICbDnqNVPpKRbawYoveKmt29yh4Vhh4oaiO81o7O8IdQQH1BC4PQu12eKLXYp
 RAOAMaTRUFS0Of/lQn7dEyOGfNIGlOiNDgf10UTqmMMmeUQl4JQOBpwMm3uIenjQd4R6
 Ri3A==
X-Gm-Message-State: APjAAAURYpkZeYjbc76/2rZFf2BJO3yyDUEVpHEM3a4G4uGAl4mMoR9S
 HC1eJ/76lC24J4Vdk5eDyzdQJI4wfVO0ypa9bRFM84v2tWi8F7Yalexz7LOCceTmUgXTqdu8h6Z
 42yvLAugii3j6RqU=
X-Received: by 2002:adf:fc10:: with SMTP id i16mr1242381wrr.331.1582890479512; 
 Fri, 28 Feb 2020 03:47:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwX1PlFUd70akunglxnfTPEuLh7bKZtTlkbg22tnwWQsflCw+cuFlsy7JGHo5YlLqdJeeG/ug==
X-Received: by 2002:adf:fc10:: with SMTP id i16mr1242372wrr.331.1582890479343; 
 Fri, 28 Feb 2020 03:47:59 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id v8sm11901514wrw.2.2020.02.28.03.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:47:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/18] hw/timer/hpet: Include "exec/address-spaces.h"
Date: Fri, 28 Feb 2020 12:46:42 +0100
Message-Id: <20200228114649.12818-12-philmd@redhat.com>
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/timer/hpet.c calls address_space_stl_le() declared in
"exec/address-spaces.h". Include it.

This fixes (when modifying unrelated headers):

  hw/timer/hpet.c:210:31: error: use of undeclared identifier 'address_spac=
e_memory'
          address_space_stl_le(&address_space_memory, timer->fsb >> 32,
                               ^~~~~~~~~~~~~~~~~~~~

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/timer/hpet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 4f30dd50a4..380acfa7c8 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -36,6 +36,7 @@
 #include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
 #include "hw/timer/i8254.h"
+#include "exec/address-spaces.h"
=20
 //#define HPET_DEBUG
 #ifdef HPET_DEBUG
--=20
2.21.1


