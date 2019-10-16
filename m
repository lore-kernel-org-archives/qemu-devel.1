Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEC0ECE59D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EC62086A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EC62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKZ8d-0004WN-QQ
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 22:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKZ4b-0000tg-Qu
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKZ4a-0004iC-QA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:30:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKZ4a-0004hz-IR
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:30:00 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B73DE2C9700
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 02:29:59 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id p15so13282660plq.4
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 19:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/iRm9HUr6JYJw4fy1c/Q5gUGngMsEsoru2kz/1lERVE=;
 b=Dbs/gEHWzHKZd1r8WEJ6DwzJxxfTB5VqRlS0YeTTQZLdr6P4kdt71m+P/S32R8+vva
 vsaulv8rziKJqqlUYHcsRlbnPswLHqJwF4SgEiRziYnImdmPZuHNUI2T66d4VbZXSUl6
 3QtmaE8oCVImabvcqNSqMJwQoxb0A6st0uZgLBcUiVcJ1669WbaXAvJu2adLsDtX6FaO
 BtcyzOkjenCM6UYd8m+q4F2yuIqGkC9p9p1dh9E00d8ik+8OoRo9mZOzPJho1L57dxnC
 JICILnaDXQU6FeFMabrxUMzglT9PBpJkSPPA6J022ua+DZxLcIbItvZaapqq6KznXF9a
 +YEw==
X-Gm-Message-State: APjAAAXJ0FNuXMeRRHHuJOXSeDSHVaqg8b3QnQprNC+8OPa7ztaNvTYh
 1Qnww1N5bgprc0GdkA/zfSdbP12c/zCUR1+wyVseDTTYiuQSKAuElmwvJzi4hupEbza+ogY7fdO
 syhu4qyE6p8qd2hs=
X-Received: by 2002:a63:709:: with SMTP id 9mr42039213pgh.445.1571192998330;
 Tue, 15 Oct 2019 19:29:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYCK/aIuxM4vkBbYw/XDl8N67HeBje9kTQLAGWe6y8mdMpudqkDrupZ0HeUETXWWeBEbWjTg==
X-Received: by 2002:a63:709:: with SMTP id 9mr42039179pgh.445.1571192998031;
 Tue, 15 Oct 2019 19:29:58 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b5sm26175722pfp.38.2019.10.15.19.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 19:29:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] apic: Use 32bit APIC ID for migration instance ID
Date: Wed, 16 Oct 2019 10:29:32 +0800
Message-Id: <20191016022933.7276-4-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016022933.7276-1-peterx@redhat.com>
References: <20191016022933.7276-1-peterx@redhat.com>
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
 hw/intc/apic_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index fabfa7320b..f0d88a1b14 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -315,7 +315,10 @@ static void apic_common_realize(DeviceState *dev, Er=
ror **errp)
     APICCommonState *s =3D APIC_COMMON(dev);
     APICCommonClass *info;
     static DeviceState *vapic;
-    uint32_t instance_id =3D s->id;
+    uint32_t instance_id =3D s->initial_apic_id;
+
+    /* Normally initial APIC ID should be no more than hundreds */
+    assert(instance_id !=3D VMSTATE_INSTANCE_ID_ANY);
=20
     info =3D APIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
--=20
2.21.0


