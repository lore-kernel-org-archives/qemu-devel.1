Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B2C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A614223C7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcbXGmp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A614223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLwX-0005zN-PF
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVLe2-0003Ez-AZ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVLdn-00025D-Up
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603315646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dAgss6lAzTS2hnv0dDV/6uj0ACePhFyIsLanUzbvvmc=;
 b=PcbXGmp8+hbbOwTAKJXKz64FLVb5yCxw2wPzB1BNRXW1sCNQTb7WgKX/YCDINOAOlj4jTJ
 gE49jDEVZ0A9Q3T2woifkCdF3nNrThGUTA2s2dSCra8J4tXYYIsHZI7DuY1ASrVNFvK8VO
 uN5ePEs3ae9qVcWDGWi+PxC4Y+je9I0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-XYeapsY1OWeQk8k-lr_mEA-1; Wed, 21 Oct 2020 17:27:24 -0400
X-MC-Unique: XYeapsY1OWeQk8k-lr_mEA-1
Received: by mail-qv1-f70.google.com with SMTP id s9so2089237qvd.17
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 14:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=siXQLwuVDuBIMJ0xkoUPwhvxkWm4zKh4ayGSU0+A89s=;
 b=b31uAg2DeZxrswgX/OgNBIheFNgBeN9npyBJZ8YtKc/Db61vLkxZcSulwPPTzFqaNM
 pKsv4Pz8K04193LqrsvJVd8eCEkErPZq/URu+P3XQsOFVlGzUtJX2IOFRLXblzU0WwAh
 3JWXdhGQVzIM69loIGs80lNl5c9iYwBeRxnuE1d9SRNbe6q+7QcGrqbd2ADi1qg0J2bo
 3AUi77qIlj5Kq9g+GZm/T723cKcePZ4pPbsWq6NjeBWYyexD8k88Sz1QZD3eICGvvklo
 eK2n+711wURRvIWrjIeNyowDPCtKPBCMd2TZYPtjDBZspnKugbz8+hSOrF72QZjYjDdV
 mAIA==
X-Gm-Message-State: AOAM531oGA1b+AjF9UbIqptYlg4xOWJGCSrSyifzgooV3Fdw8IpIpizm
 KeEB6s9B6+tU+mVm4Qc0vNLWrN8uuj8sZ41rJc1E9PMcrJN9Xuu8zM5ihtpAb256BacO8MLtr+3
 TdjTkYoIKs5u4h5E=
X-Received: by 2002:ac8:59c2:: with SMTP id f2mr4905038qtf.317.1603315643885; 
 Wed, 21 Oct 2020 14:27:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWK7m7YW0+4KU9syqRgHX9z/++VOA6gfE8+CN4atBsTxha0Y2naxDQelhMdw0sJWiweSOMcQ==
X-Received: by 2002:ac8:59c2:: with SMTP id f2mr4905020qtf.317.1603315643579; 
 Wed, 21 Oct 2020 14:27:23 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id p187sm2089145qkf.70.2020.10.21.14.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 14:27:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/6] migration/postcopy: Sync faulted addresses after
 network recovered
Date: Wed, 21 Oct 2020 17:27:15 -0400
Message-Id: <20201021212721.440373-1-peterx@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v6:=0D
- fix page mask to use ramblock psize [Dave]=0D
=0D
v5:=0D
- added one test patch for easier debugging for migration-test=0D
- added one fix patch [1] for another postcopy race=0D
- fixed a bug that could trigger when host/guest page size differs=0D
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


