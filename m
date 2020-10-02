Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0539C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F389206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A31UNL4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F389206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPIx-0005Pn-5S
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kOPFZ-0001IB-FS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kOPFX-00056x-Qc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601661223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6JJ9qRRT3/TYZs+BX/2A7fS7Xf/HvJiG4ZxM7HMpuu8=;
 b=A31UNL4rU2WTlZMunwIOPACj3RoeEiVGP4a1U0/NiVtcTmBs7zf6hQ3jQ+aYnzujvt83wl
 LcCRUsDWfx7kfOjTFHBnZEAlKks9LLzoyMxrHSEl2ZZyO34lVtyfb1pIp9PP0i35Fw+5HD
 PSNtRIHrXyq1WNVTITriswe/k6ptASU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-WLWMELq4PZKo9BBE_k0B1w-1; Fri, 02 Oct 2020 13:53:39 -0400
X-MC-Unique: WLWMELq4PZKo9BBE_k0B1w-1
Received: by mail-qv1-f71.google.com with SMTP id f4so1303301qvw.15
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LlSrykGTutpdVfMiuFa2xpi0yHn9aR7PWHwEMRfG+Qg=;
 b=QFb7VSzYH0w8gNH9QPmywlHVo8cVY4zX4EwIi0rlKcAcGrwWAKI8fOHnDQsBfGnVAG
 yBhqZK8xQ4G7rz6XjYIF6kQ9ExPg8hWsX0fW3UaQN+kOZ04Cx9Qm7azZwJK3kHUR0FCh
 NSqe/oa2idMZHdpgEZ/5KQDCLnO7GA6sc74/6jpiXJuEBRgrzeQ8XPewwedDEoNRsKjI
 SC21YDxlwvrNzXMTms3PVsHAjowzGqSz1F1y+STnWl5WVBQBHCM+k64ra9Ir6Ws8tbbc
 DYXfpw/0UAmLtzalM++lpoYfh6CWnvR0nboWqIzgPyqhaychRc1bki5YaIltcPuD8ep8
 t3qg==
X-Gm-Message-State: AOAM5303kU+50N4eEikw9TCofl0G095T6UDBtnAoEdFjk8qwTpjSh7JI
 a0N514BXUmXm+w7/qF7GwcSJMFHzSBumQ/o3UTJeEESK7pACTcsR33wCkO+xfJRgobXTm6K4Ppu
 HUAI2u4Sq9hFtdPA=
X-Received: by 2002:a05:6214:14e8:: with SMTP id
 k8mr3274996qvw.19.1601661218759; 
 Fri, 02 Oct 2020 10:53:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZKUyzJzPlnioe+zwrh55WiBf03OJRSEpiQnt1YZADqaC1FTEwiGIAGGtZ9xksVYPTtcnPvA==
X-Received: by 2002:a05:6214:14e8:: with SMTP id
 k8mr3274976qvw.19.1601661218484; 
 Fri, 02 Oct 2020 10:53:38 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
 by smtp.gmail.com with ESMTPSA id a3sm1562229qtp.63.2020.10.02.10.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:53:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] migration/postcopy: Sync faulted addresses after
 network recovered
Date: Fri,  2 Oct 2020 13:53:32 -0400
Message-Id: <20201002175336.30858-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4:=0D
- use "void */ulong" instead of "uint64_t" where proper in patch 3/4 [Dave]=
=0D
=0D
v3:=0D
- fix build on 32bit hosts & rebase=0D
- remove r-bs for the last 2 patches for Dave due to the changes=0D
=0D
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
Peter Xu (4):=0D
  migration: Pass incoming state into qemu_ufd_copy_ioctl()=0D
  migration: Introduce migrate_send_rp_message_req_pages()=0D
  migration: Maintain postcopy faulted addresses=0D
  migration: Sync requested pages after postcopy recovery=0D
=0D
 migration/migration.c    | 49 ++++++++++++++++++++++++++++++++--=0D
 migration/migration.h    | 21 ++++++++++++++-=0D
 migration/postcopy-ram.c | 25 +++++++++++++-----=0D
 migration/savevm.c       | 57 ++++++++++++++++++++++++++++++++++++++++=0D
 migration/trace-events   |  3 +++=0D
 5 files changed, 146 insertions(+), 9 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


