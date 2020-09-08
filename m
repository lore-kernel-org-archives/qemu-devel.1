Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA48C2BC11
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A87B20759
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1GwmbG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A87B20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkHK-00061b-F1
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFkG8-0004Cc-Lf
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:30:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFkG6-0007sj-E9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599597027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HAFn4bEDDQPG1QI41gKB6fbg8k3YtBJc3lZUjVwq2po=;
 b=E1GwmbG5k9pKW+brv+ouK+kPstJLiiNytD3bB6u27nRLa3Xe8HluRdCECWKQOQ6Q1W2+qS
 3RQjvyqJ3WoJT1B1wOoXkyCDam7qH47jijHbytrdoYYDqg3FrD+IuIDmWwdjULnmfLXsfD
 oXztMR/IoXwvju2Xti9fgY140WReecU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-BDduWfp3Ma2GbhLgJwLXvg-1; Tue, 08 Sep 2020 16:30:26 -0400
X-MC-Unique: BDduWfp3Ma2GbhLgJwLXvg-1
Received: by mail-qv1-f69.google.com with SMTP id y32so93181qve.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GaaBuy+0RprmBynjpJdh/WHO1+Eefq1XMNSFWtzof3s=;
 b=KMDrdlRKDNtIx1REV853sKgLBYNtdeFfpM5NYoU+ONfH20xr+/cQfWGA0fGpz+4oWX
 U51WuLYcFhj6cUlUob4Kmp5CywZ9aR/pJ5w+OOahawv2/04gHKDAgAv3HLMdsIm0IIxO
 yYbVEPSTcIRffmqWPExVpS3HDFsm0XyB6N5l57f9a1fQqzgTt0JEVccjjDsoa+u4jtGC
 mfTf4BNA915CNpHH//OTiEh2VTqNlkAPnM9MHHWZoFfIvYRWKvL1GJtquKGsrSYlp/ux
 qQU2IIw/Qo5euhJ+N22CmM8nNSHZmmCHnXEcq6RHqxOkwQvfdNB5yoZncdIBFoh93O3r
 S+Sw==
X-Gm-Message-State: AOAM5326hHLJrGO6vQ1fqNz6/vWqAFFadLTxvUiLKHy9UpIjoJxm4YDN
 2lv5TmHJM3QqPsMk9Cby1VVd5JgRphnX96zZi4ZGSsXI9lUL0UnoIq1r/SYfFs4nQRLAzIDi6d3
 bAY+p94fdF2c+n+c=
X-Received: by 2002:aed:2be2:: with SMTP id e89mr210751qtd.298.1599597025353; 
 Tue, 08 Sep 2020 13:30:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuq5fP+BNZs4kfiDOCM7D9RuToPnPuBfKh/EAxatsF7axtR4SId0uUcujxNDHQNce/Y5X4aA==
X-Received: by 2002:aed:2be2:: with SMTP id e89mr210724qtd.298.1599597025091; 
 Tue, 08 Sep 2020 13:30:25 -0700 (PDT)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id o28sm595397qtl.62.2020.09.08.13.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 13:30:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] migration/postcopy: Sync faulted addresses after
 network recovered
Date: Tue,  8 Sep 2020 16:30:16 -0400
Message-Id: <20200908203022.341615-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Xiaohui Li <xiaohli@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:=0D
- add r-bs for Dave=0D
- add patch "migration: Properly destroy variables on incoming side" as pat=
ch 1=0D
- destroy page_request_mutex in migration_incoming_state_destroy() too [Dav=
e]=0D
- use WITH_QEMU_LOCK_GUARD in two places where we can [Dave]=0D
=0D
We've seen conditional guest hangs on destination VM after postcopy recover=
ed.=0D
However the hang will resolve itself after a few minutes.=0D
=0D
The problem is: after a postcopy recovery, the prioritized postcopy queue o=
n=0D
the source VM is actually missing.  So all the faulted threads before the=
=0D
postcopy recovery happened will keep halted until (accidentally) the page g=
ot=0D
copied by the background precopy migration stream.=0D
=0D
The solution is to also refresh this information after postcopy recovery.  =
To=0D
achieve this, we need to maintain a list of faulted addresses on the=0D
destination node, so that we can resend the list when necessary.  This work=
 is=0D
done via patch 2-5.=0D
=0D
With that, the last thing we need to do is to send this extra information t=
o=0D
source VM after recovered.  Very luckily, this synchronization can be=0D
"emulated" by sending a bunch of page requests (although these pages have b=
een=0D
sent previously!) to source VM just like when we've got a page fault.  Even=
 in=0D
the 1st version of the postcopy code we'll handle duplicated pages well.  S=
o=0D
this fix does not even need a new capability bit and it'll work smoothly on=
 old=0D
QEMUs when we migrate from them to the new QEMUs.=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (6):=0D
  migration: Properly destroy variables on incoming side=0D
  migration: Rework migrate_send_rp_req_pages() function=0D
  migration: Pass incoming state into qemu_ufd_copy_ioctl()=0D
  migration: Introduce migrate_send_rp_message_req_pages()=0D
  migration: Maintain postcopy faulted addresses=0D
  migration: Sync requested pages after postcopy recovery=0D
=0D
 migration/migration.c    | 79 +++++++++++++++++++++++++++++++++++-----=0D
 migration/migration.h    | 23 +++++++++++-=0D
 migration/postcopy-ram.c | 46 ++++++++++-------------=0D
 migration/savevm.c       | 57 +++++++++++++++++++++++++++++=0D
 migration/trace-events   |  3 ++=0D
 5 files changed, 171 insertions(+), 37 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


