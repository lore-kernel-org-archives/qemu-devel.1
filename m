Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18EEC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBE721973
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2iPg9/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBE721973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWAx-0002cy-GU
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTW7h-0005iI-Qo
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTW7f-0006uj-EJ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:42:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20295
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTW7d-0006tS-UZ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588102944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zuy1iMRmPIFo+AO2BN7flgYL2QbOrH67o5VmfdIqjvI=;
 b=J2iPg9/GUxavurcDRu0bV2BjJyG7MsC4/QM+H2xZUhdX/vTkaoJCRgX+SbgRXlPR5lUcpF
 5FX+aCKZmJRS5ICq3rJIZ6Vowzy7fIb0c2Ebx8KunKKvPd74kKRcf/nRIXaQlgdQ5hODY2
 YGZhzwQyW7uH7JF81jd99diz98pMkw0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-sBZsa508OdOebFTOawZ95A-1; Tue, 28 Apr 2020 15:42:20 -0400
X-MC-Unique: sBZsa508OdOebFTOawZ95A-1
Received: by mail-qk1-f199.google.com with SMTP id 11so19519638qkh.7
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 12:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xuRNcZqOedqLdZtDlBrMErqG8jwgO5FGr6fT7gMV6U0=;
 b=YHuVoaLTCMGqG2MCbTxQGdxbA2QWRaRWeM5cdoKZgej1N/3DRYmK/J6PRNjDOb2UBs
 KMh/d/dRq5+vWjL6NZnKbR6cn57ubs9DUCDNrVMhwBToRABNTIqzkKYCLDgUuK5ZdjmB
 Q+wnIVsMsLpc7ill6Ykuagnuz6/hhpb4kUm9Jir46DzbqXLHsrANFQSmMYu8x5ZnU+oL
 C3ph208y1wsCgwXLGKFS0+kiw+1jKEDzRVzeTSyIR8rtmiQzPGDgZtfZQur5M/Ecu7MN
 /CziczpI+zb+4pLAdttXdcKiF1NSm39zzMGRjnoknzDxGkaZxLAbONYjFL9ha1512LNQ
 9biw==
X-Gm-Message-State: AGi0PubN7ORVDKc+xM6CORx6mhZ4fEy38zw4zVz8FhWcn3SFcrMNJr2Z
 B/bzxDf4mWpA35xWPNOeMHewWESM5TjToRP+VJvu+3rpi0uIcTkUd63dA5Aju0Af8xHAdaf5ZCl
 l/VRLVCJk5XizdYs=
X-Received: by 2002:a37:5744:: with SMTP id l65mr30286835qkb.470.1588102940202; 
 Tue, 28 Apr 2020 12:42:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypIVpkZMo/e+bCoONrLDgj6/d0/g5VJRBmytw7HmuYUyErWUzOP1kxPmZccdIYlgsoQ4CHxigA==
X-Received: by 2002:a37:5744:: with SMTP id l65mr30286816qkb.470.1588102939983; 
 Tue, 28 Apr 2020 12:42:19 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id n92sm14133460qtd.68.2020.04.28.12.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 12:42:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 2/4] migration: Introduce migrate_is_precopy()
Date: Tue, 28 Apr 2020 15:42:17 -0400
Message-Id: <20200428194219.10963-3-peterx@redhat.com>
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

Export a helper globally to check whether we're during a precopy.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 +
 migration/migration.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e338be8c30..b4f6bf7842 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -61,6 +61,7 @@ void migration_shutdown(void);
 void qemu_start_incoming_migration(const char *uri, Error **errp);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
+bool migration_is_precopy(void);
 void add_migration_state_change_notifier(Notifier *notify);
 void remove_migration_state_change_notifier(Notifier *notify);
 bool migration_in_setup(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 187ac0410c..0082880279 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1795,6 +1795,13 @@ bool migration_is_active(MigrationState *s)
             s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
=20
+bool migration_is_precopy(void)
+{
+    MigrationState *s =3D migrate_get_current();
+
+    return s && s->state =3D=3D MIGRATION_STATUS_ACTIVE;
+}
+
 void migrate_init(MigrationState *s)
 {
     /*
--=20
2.24.1


