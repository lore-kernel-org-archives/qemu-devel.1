Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC061C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2482240C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QN96Lcog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2482240C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUe7L-00007S-WB
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 18:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUe5r-00070R-18
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUe5o-0005cI-O3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603148247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oSx6Upto5qIIMQCj3DBLMSfuQPWH8PnPRsubRgvIkhs=;
 b=QN96LcogF5hdtmX6XDTV36JUQVm0OBBC/ztUSNWvxxfO9XUayjK1c62aB3gjMOqO46hn9B
 1DCC2SwNw27ssDRNTX7g79fbtzVwLSvs8UEgXowY+OGKsqVKCvA2ETZ33n2lCpEtcxQxqu
 C7RHQRMX5BEcl5jwXWsxYSJ+ROot1hg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-oJWI9kBPNeKblnDmKTnbTw-1; Mon, 19 Oct 2020 18:57:24 -0400
X-MC-Unique: oJWI9kBPNeKblnDmKTnbTw-1
Received: by mail-io1-f70.google.com with SMTP id w16so1356419ioa.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k0lKkODD5+DnqWYJtZy3D2vvB7uOBfNqhdiZo53S8As=;
 b=gFLG5NnleBsB8dmSJoCbebcLi7CBtCOswCs6EB3TQfP1Wb2Xm1VIXHx++gJ2s+vS7+
 lEFOUSakjLWJZALaQRiRgeB/UU0rpbj2YxU4ODx3XzKmzGWUkeTrqFuUxu995MpMwGSW
 z7QsUEDE7Ti3XNyRU9fakkUjZRkSaLhmFcklnLbe+fNXeik5GKN1/EAqZ4qn1Wtf9qef
 n+xWdixVWt6KzzmWHDc0f8WiTvQ2o6/dwBGMB/eLuJRzFheKjy8Vfiw8aPUJ+t7jnFy3
 9mAk1yloWDUuv9qw4/gvBHzrc5uwTffxdNePfvgDewBqy3vepW9jqQomq0pf5ly6U9St
 /MfA==
X-Gm-Message-State: AOAM532SDU4dyvA9Gi2/oZyhccIVDkP0VtUZxRN6N2gpKsqkhNFLeP3Q
 RhZvqP/H3m9mnhq4iEkmfSWA0PnRb2SPTuBW2ZOnipAPN+Hf5p4mcrJfaX0AbqVIC5yVZdqD6pX
 au+BJzVdKUMTx1zo=
X-Received: by 2002:a92:1303:: with SMTP id 3mr1915797ilt.117.1603148243212;
 Mon, 19 Oct 2020 15:57:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI8f/GElODbojrdRkxn9M6IdvtlUz1I5VpS3kMzGurSCHYbrG8v/vD16uBahK66YqMMDh+vA==
X-Received: by 2002:a92:1303:: with SMTP id 3mr1915791ilt.117.1603148242959;
 Mon, 19 Oct 2020 15:57:22 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id z89sm6017ilk.4.2020.10.19.15.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 15:57:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/6] migration/postcopy: Sync faulted addresses after
 network recovered
Date: Mon, 19 Oct 2020 18:57:14 -0400
Message-Id: <20201019225720.172743-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v5 of the series.  Probably my first series that got queued/unqueue=
d=0D
twice.=0D
=0D
I found a bug in v4 that was about page sizes, however that didn't match wi=
th=0D
PeterM's report on big endian hosts.  My manual reproduce on s390x also did=
n't=0D
reproduce.  However after I ran the tree (with the fix) on travis (thanks=
=0D
Thomas for suggesting this!) I noticed that s390x passed the test too:=0D
=0D
https://travis-ci.com/github/xzpeter/qemu/builds/191031111=0D
=0D
I still got two tests that got timed out, however I also noticed that the=
=0D
master branch got similarly two tests that timed out:=0D
=0D
https://travis-ci.com/github/xzpeter/qemu/builds/191012879=0D
=0D
There's one difference on the failed test, however I really suspect it's=0D
because the uncertainly of the travis host scheduling the tests, or the mas=
ter=0D
failures should really be a subset of my own branch (while it's not).=0D
=0D
So I decided to give it a 3rd shot... PeterM: would it be easy/possible to =
kick=0D
the CI again against this series for pulls?  I just don't want to break Dav=
e's=0D
pull the 3rd time. :)=0D
=0D
I also picked up the other patch [1] that should also fix some rare failure=
s on=0D
postcopy recovery.  However I bet we haven't yet encounter it, at least not=
 often.=0D
=0D
v5 changelog:=0D
- added one test patch for easier debugging for migration-test=0D
- added one fix patch [1] for another postcopy race=0D
- fixed a bug that could trigger when host/guest page size differs=0D
=0D
[1] https://lore.kernel.org/qemu-devel/20201007183324.288379-1-peterx@redha=
t.com/=0D
=0D
--------- v4 cover letter --------------=0D
=0D
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
Peter Xu (6):=0D
  migration: Pass incoming state into qemu_ufd_copy_ioctl()=0D
  migration: Introduce migrate_send_rp_message_req_pages()=0D
  migration: Maintain postcopy faulted addresses=0D
  migration: Sync requested pages after postcopy recovery=0D
  migration/postcopy: Release fd before going into 'postcopy-pause'=0D
  migration-test: Only hide error if !QTEST_LOG=0D
=0D
 migration/migration.c        | 55 ++++++++++++++++++++++++++++++----=0D
 migration/migration.h        | 21 ++++++++++++-=0D
 migration/postcopy-ram.c     | 25 ++++++++++++----=0D
 migration/savevm.c           | 57 ++++++++++++++++++++++++++++++++++++=0D
 migration/trace-events       |  3 ++=0D
 tests/qtest/migration-test.c |  6 +++-=0D
 6 files changed, 154 insertions(+), 13 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


