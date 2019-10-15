Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBAEECE58E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 07:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5092089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 07:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5092089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKHj7-0005m2-Bi
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 03:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKHff-0001mJ-1n
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKHfc-0005iT-W8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:55:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKHfc-0005i7-Mf
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:55:04 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7C4AAD881
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 07:55:03 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id b14so4485910pgm.22
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 00:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4lnoz4PkLYCAulCk1xBitbDt3OgijwPGGC0TddpxLB4=;
 b=EUNGZZdGtsIYJ3TBolNFJONKKUmQ+3He6Cfne7SW8xGn6SLCUJTBOtmKt/52YsRRDK
 HHzdZ06AunvHvhcH4a54UJ/3cx0rGXVvGoPIKw5xujKVdO1f5rvLXE33hony3CwjTFPe
 pZGrnpBB0zDJtJki+C2nS++yKUC9riTGppia5oOIDknpWtRgVIbHU7HGNDew3iz9hQug
 Be2SpRrQ0oYGm5ruguRpB5v7776DCRxbFGgkKaZiCv8L8yv0topHpnfzHl8hkOEUBWl5
 2yBBAbfBN66RMifkgkd9wT4HHUPgcyySLoy4Yg3c45fug1/vrEXxyqAnuZzF06/DXPm9
 XLUw==
X-Gm-Message-State: APjAAAWIc5xInXQQ1K0RBVF9Kk+b/Ykp0LmmQL1VctGEWfKkc1K1c9iR
 hf2fiVNUjEZJ1VewU8gqHolbQZ7pO8rJsOBcuoh1iD46Tsk0BCUou6iTGOZD9lvxR3w2HnbkJXK
 UGESnyBTg0f7X80k=
X-Received: by 2002:a17:902:900c:: with SMTP id
 a12mr23391367plp.30.1571126102693; 
 Tue, 15 Oct 2019 00:55:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzE4SBCDfSEOhFhRENGfi5KEMlgYGPWZDEYGu9H+pOXotfrmwTIjfraTok8iQqa8umxNPTDkg==
X-Received: by 2002:a17:902:900c:: with SMTP id
 a12mr23391340plp.30.1571126102408; 
 Tue, 15 Oct 2019 00:55:02 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r30sm24599850pfl.42.2019.10.15.00.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 00:55:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] apic: Use 32bit APIC ID for migration instance ID
Date: Tue, 15 Oct 2019 15:54:44 +0800
Message-Id: <20191015075444.10955-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015075444.10955-1-peterx@redhat.com>
References: <20191015075444.10955-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Migration is silently broken now with x2apic config like this:

     -smp 200,maxcpus=3D288,sockets=3D2,cores=3D72,threads=3D2 \
     -device intel-iommu,intremap=3Don,eim=3Don

After migration, the guest kernel could hang at anything, due to
x2apic bit not migrated correctly in IA32_APIC_BASE on some vcpus, so
any operations related to x2apic could be broken then (e.g., RDMSR on
x2apic MSRs could fail because KVM would think that the vcpu hasn't
enabled x2apic at all).

The issue is that the x2apic bit was never applied correctly for vcpus
whose ID > 255 when migrate completes, and that's because when we
migrate APIC we use the APICCommonState.id as instance ID of the
migration stream, while that's too short for x2apic.

Let's use the newly introduced initial_apic_id for that.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/intc/apic_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index aafd8e0e33..6024a3e06a 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -315,7 +315,7 @@ static void apic_common_realize(DeviceState *dev, Err=
or **errp)
     APICCommonState *s =3D APIC_COMMON(dev);
     APICCommonClass *info;
     static DeviceState *vapic;
-    int instance_id =3D s->id;
+    int64_t instance_id =3D s->initial_apic_id;
=20
     info =3D APIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
--=20
2.21.0


