Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFA2C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26512076A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ER0KvZ1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26512076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTW8O-0006FI-3N
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTW7Z-0005dt-Dd
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTW7Y-0006sW-9J
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:42:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTW7X-0006oY-RQ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588102938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pEwy2RqZcGwIDdKgKGI0BMeuFHJFfIWFLhL8bE9PpP0=;
 b=ER0KvZ1RZAnWFlhXcZT0Nt/eeNQHp5ZZ9o+KIH9gTndNCpa56X6FtqwV0S3x5Eu/Fnj3uP
 gchMLJLBvlQUz3lm3ltNJJvgczZMc/JmnqfaW7i9CgoUTgVox95AOdlFyEsqMc2R/EVP+/
 489lL8RlqCuV3q/CHuyhJZ0LqUQ8zv0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-AkZ_lkA9OAqtIH9hKFco-A-1; Tue, 28 Apr 2020 15:42:14 -0400
X-MC-Unique: AkZ_lkA9OAqtIH9hKFco-A-1
Received: by mail-qv1-f71.google.com with SMTP id 65so23740727qva.17
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 12:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3gzPXVz5MMtNfwRM5Trs1Fa+WxXulBKOVVI0i1i7KBU=;
 b=GKd9K+fRr9/bDe8Uk4vzsVxP8PhkG3zAs+j6cXHCHiTp9rHe3EabkggXH5K5mNO/nH
 Wns61kddnG6PygIfU9u/jaSYkcxDniRiLzKyeTKsTiRF9GQm2UUwXeHC1iLIhxaOChlz
 Uj6W+I5W348ipO+wT0nh2MuFPep93Tk7iBQPPA1L6vI6twBXoLBs32Eee+XyT/4pw0dI
 VH+tMo/2hBDAsb7npdZ/ROBWTHtd/SejOPlBwCk/fcukum4SgdzDdvKypt880vmN9w0W
 Q/6YFdAfwolMwnaVUAmlWs2ENDK/q3aj2Ot+CQkhrAugWRdjH+41jEf67KoCu+TUDfGW
 K/sw==
X-Gm-Message-State: AGi0PuZA7JmezVcfP8bPq/yiMGiLsKr4KmCS6ffzqV3Dk734VbTY2GIq
 7+ewrsmTJPeKuajW/qBw+Kck43p/v1Zfli3MbkqBwdA4aES7WoNPkJDJUXJz4s7eNkyzhLSlcgC
 L6oagMDa7/vxNpeE=
X-Received: by 2002:a05:6214:1702:: with SMTP id
 db2mr30058947qvb.201.1588102934040; 
 Tue, 28 Apr 2020 12:42:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbEYlqP0g12/J41T2dGOpdyaGYQFMBNEK3mI63o+9lTvxGRkP8nF6Al1qM9MiazrUq9AjTfg==
X-Received: by 2002:a05:6214:1702:: with SMTP id
 db2mr30058899qvb.201.1588102933671; 
 Tue, 28 Apr 2020 12:42:13 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id o13sm14147648qke.77.2020.04.28.12.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 12:42:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 0/4] vl: Sync dirty bitmap when system resets
Date: Tue, 28 Apr 2020 15:42:15 -0400
Message-Id: <20200428194219.10963-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
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

This RFC series starts from the fact that we will sync dirty bitmap when
removing a memslot for KVM.  IIUC that was majorly to maintain the dirty bi=
tmap
even across a system reboot.

This series wants to move that sync from kvm memslot removal to system rese=
t.

(I still don't know why the reset system will still need to keep the RAM st=
atus
 before the reset.  I thought things like kdump might use this to retrieve =
info
 from previous kernel panic, however IIUC that's not what kdump is doing no=
w.
 Anyway, I'd be more than glad if anyone knows the real scenario behind
 this...)

The current solution (sync at kvm memslot removal) works in most cases, but=
:

  - it will be merely impossible to work for dirty ring, and,

  - it has an existing flaw on race condition. [1]

So if system reset is the only thing we care here, I'm thinking whether we =
can
move this sync explicitly to system reset so we do a global sync there inst=
ead
of sync every time when memory layout changed and caused memory removals.  =
I
think it can be more explict to sync during system reset, and also with tha=
t
context it will be far easier for kvm dirty ring to provide the same logic.

This is totally RFC because I'm still trying to find whether there will be
other cases besides system reset that we want to keep the dirty bits for a
to-be-removed memslot (real memory removals like unplugging memory shouldn'=
t
matter, because we won't care about the dirty bits if it's never going to b=
e
there anymore, not to mention we won't allow such things during a migration=
).
So far I don't see any.

I've run some tests either using the old dirty log or dirty ring, with eith=
er
some memory load or reboots on the source, and I see no issues so far.

Comments greatly welcomed.  Thanks.

[1] https://lore.kernel.org/qemu-devel/20200327150425.GJ422390@xz-x1/

Peter Xu (4):
  migration: Export migration_bitmap_sync_precopy()
  migration: Introduce migrate_is_precopy()
  vl: Sync dirty bits for system resets during precopy
  kvm: No need to sync dirty bitmap before memslot removal any more

 accel/kvm/kvm-all.c      |  3 ---
 include/migration/misc.h |  2 ++
 migration/migration.c    |  7 +++++++
 migration/ram.c          | 10 +++++-----
 softmmu/vl.c             | 16 ++++++++++++++++
 5 files changed, 30 insertions(+), 8 deletions(-)

--=20
2.24.1


