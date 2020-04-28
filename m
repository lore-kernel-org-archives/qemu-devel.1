Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C26C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7FC217D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVX1LhUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7FC217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTW9c-00083e-V4
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTW8n-0006to-U2
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTW8m-0007Do-H1
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:43:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29549
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTW8m-0007BJ-36
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588103015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Lnbg1QoqysmcI1QpHi4Ugfwik3iNp8wG0u4WHFvFYc=;
 b=NVX1LhUcqPOlq3T5g9w68K2eu8pav1V0jMy/ROS9aGHR7W2FhgYheG/N5Gp7HMLt2VyC72
 5lloSIo+z2zV3D+BjaBLznxPecl2m+mKmDGc+V+8ksPDyNsTo85U0g8Rdy7RRC62UWMicv
 Bbbbjhooad62oleIvaGEdJlmbLiFLHs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-mBaXvpenPy-Dquclno1caQ-1; Tue, 28 Apr 2020 15:43:33 -0400
X-MC-Unique: mBaXvpenPy-Dquclno1caQ-1
Received: by mail-qv1-f72.google.com with SMTP id 65so23744198qva.17
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 12:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IbXTrIQrGmJBwtzshAWiRUJozp+LdTeq7bHKm90eFnE=;
 b=NPF6RTAA+QQMOndGttS08SojAbC92WkwN1H5gtiB5eBa7AcI0j1WaLpz1NVdF+qoS6
 sdbj33DJhWa15IFrdcrqT/WR3aIgSNrZ7HTmMBB4t01sbiwly6DwTdLhQ1jFX3hSkF4b
 qE7Now3j7eO1Pj+4WN+Ft4gzubM8jiB22kdPa5YDtVdNmMSQxu547TbaDTIyOxBqMdY3
 eQopIrRe/dX8d1BBhCQFfXYNE/JVKf+ozKc8NcVkgIPKPPCjSsB90ZJu6zeOPoD8qQ3G
 r/M/jayqdcwNQ+TidzyfMENNHXf3UJIJeNxU7gZJ6X9gedX4ozauRHqTkhgfweDhyT1u
 ns9w==
X-Gm-Message-State: AGi0Puabe6ezmjm4ayP7mfs5OD/7oJqqvW1ejMR5rSHCJ88T6ZaW34V7
 rSxDQngjZfmb5Pr9kNhM3uq9wPuN7VavX83Gz8xhzHliAuFDhsYVAh4uE7cJLNvyYoLQ+3wEzZc
 gA63kGyHaTg9v6gM=
X-Received: by 2002:ac8:f23:: with SMTP id e32mr30727050qtk.368.1588103012182; 
 Tue, 28 Apr 2020 12:43:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypKJICGBvNYz1WYnmC8J1Reoa6vGgFHzA2cmnkiX4vno/3BqnrCHcZ2g9Iwr/u81OvrzkA63sQ==
X-Received: by 2002:ac8:f23:: with SMTP id e32mr30726982qtk.368.1588103011459; 
 Tue, 28 Apr 2020 12:43:31 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id l24sm14239691qtp.8.2020.04.28.12.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 12:43:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 4/4] kvm: No need to sync dirty bitmap before memslot
 removal any more
Date: Tue, 28 Apr 2020 15:42:19 -0400
Message-Id: <20200428194219.10963-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428194219.10963-1-peterx@redhat.com>
References: <20200428194219.10963-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the system reset dirty sync in qemu_system_reset(), we should be able =
to
drop this operation now.  After all it doesn't really fix the problem clean=
ly
because logically we could still have a race [1].

[1] https://lore.kernel.org/qemu-devel/20200327150425.GJ422390@xz-x1/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 439a4efe52..e1c87fa4e1 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1061,9 +1061,6 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             if (!mem) {
                 goto out;
             }
-            if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
-                kvm_physical_sync_dirty_bitmap(kml, section);
-            }
=20
             /* unregister the slot */
             g_free(mem->dirty_bmap);
--=20
2.24.1


