Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B530FC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAF021707
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENWQ1YNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAF021707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWCR-0005F0-J8
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTW8j-0006oQ-Ru
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTW8j-0007Az-B5
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:43:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60502
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTW8i-0007As-U6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588103012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWiKFx7T2RcB/8ceBskFUXxef1SdqAE1qyzvy2ePBgA=;
 b=ENWQ1YNj7MKl5cZEgDr/nWcvcNvYC2Irz/cJo/cnGh48/dzvz/6PNRpkFX2fq3l36fsKCd
 gR+ASMUxPgGGtE9sITGmgBP4Ea0zWAVJ+Ilv0iaDB+3O1XJFnLwVZ0wejFAydhcvaaoKMJ
 0HiN087C7n+7H/yhxI+LGSqbvrlhZkk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-JJO1Meg_PVamgTTddoM4Jw-1; Tue, 28 Apr 2020 15:43:30 -0400
X-MC-Unique: JJO1Meg_PVamgTTddoM4Jw-1
Received: by mail-qk1-f199.google.com with SMTP id x7so24473666qkb.17
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 12:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l9EJm6lx5UW6V7ifVpZVbM1fIyRcFIsgTY1TmlPa2ZA=;
 b=ctzr3aAYnaHspEN9egXmCb0OnnMEDNulfetynhWa2+qwuAj0MlJBoqZfZKrRSULDtc
 7fr3CPBA/73aMqMhuvTlxWygPxASTHW+vqS/tZ3qi5mD8evZi9G/U91+v4pBiLBhwr8y
 qEpoYN5iG4WUCDjhw3V/mHQp70+jAZkWn4OZHJSs70MGOSRY4+hV8aFpLOAhCO4Z9gI0
 rBFIA2UNqEMTkVwvvz7U6cWi51w3ti9WLhCHfQBqfafpWRnnhI8i3pZCPIE0egFvyjo5
 4qddADPy7ACTHyWa2B0YqN/T34RadRTpH3xn8iML+1fMcenTQ/cYYhFg+CL4dyxEYFee
 tG/w==
X-Gm-Message-State: AGi0PuYpn1ceUozznh/yItp4clEGVY2N6Dbds8xkRQfA2fGyuRShLYiB
 bzci/eeOvSyYHaqwA9N2EocJg1lxjruL1euG824e1XE/GHJu+uXMz6DaauRI//+egzGy//xeTYp
 UJspzN8FpLHNNYvk=
X-Received: by 2002:a37:a090:: with SMTP id
 j138mr29953692qke.168.1588103009498; 
 Tue, 28 Apr 2020 12:43:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypLpD/bS2J5EyCoFE9zrsM73H3G52b3w5H7U4t7mnMuvlwvlpzdkMhqq9+flZsofYaZSH6H5qQ==
X-Received: by 2002:a37:a090:: with SMTP id
 j138mr29953508qke.168.1588103006960; 
 Tue, 28 Apr 2020 12:43:26 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id j92sm14277695qtd.58.2020.04.28.12.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 12:43:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 3/4] vl: Sync dirty bits for system resets during precopy
Date: Tue, 28 Apr 2020 15:42:18 -0400
Message-Id: <20200428194219.10963-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428194219.10963-1-peterx@redhat.com>
References: <20200428194219.10963-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

System resets will also reset system memory layout.  Although the memory la=
yout
after the reset should probably the same as before the reset, we still need=
 to
do frequent memory section removals and additions during the reset process.
Those operations could accidentally lose per-mem-section information like K=
VM
memslot dirty bitmaps.

Previously we keep those dirty bitmaps by sync it during memory removal.
However that's hard to make it right after all [1].  Instead, we sync dirty
pages before system reset if we know we're during a precopy migration.  Thi=
s
should solve the same problem explicitly.

[1] https://lore.kernel.org/qemu-devel/20200327150425.GJ422390@xz-x1/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 softmmu/vl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 32c0047889..8f864fee43 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1387,6 +1387,22 @@ void qemu_system_reset(ShutdownCause reason)
=20
     cpu_synchronize_all_states();
=20
+    /*
+     * System reboot could reset memory layout.  Although the final status=
 of
+     * the memory layout should be the same as before the reset, the memor=
y
+     * sections can still be removed and added back frequently due to the =
reset
+     * process.  This could potentially drop dirty bits in track for those
+     * memory sections before the reset.
+     *
+     * Do a global dirty sync before the reset happens if we are during a
+     * precopy, so we don't lose the dirty bits during the memory shuffles=
.
+     */
+    if (migration_is_precopy()) {
+        WITH_RCU_READ_LOCK_GUARD() {
+            migration_bitmap_sync_precopy();
+        }
+    }
+
     if (mc && mc->reset) {
         mc->reset(current_machine);
     } else {
--=20
2.24.1


