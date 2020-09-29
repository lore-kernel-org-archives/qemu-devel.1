Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D310C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2138C207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIwg+kde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2138C207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN9qC-0000Rm-3Y
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9pC-00084V-Hd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9p9-0000Sl-A7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:13:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601363598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r4FURFfSuhXn3uKUcQfVyb1EvyOTqFhJnF783uYfxkU=;
 b=PIwg+kdewxphl3DE5N/VXP0MehOfcawT/Vh/1sCBTYz5rWhuDnlpThRLL98x+beU+YNPxW
 SV7bRuIDjHJVYG0aogt3egJeAL0fqGyjhCFbbNOBA2l+L4ztrwjeZLCT+kMz07T6IE7jwt
 9b39qOgSmR3NFlT1dzOAOA9Wucs7AQk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-529894t0NSe6-ML5zCO8bQ-1; Tue, 29 Sep 2020 03:13:14 -0400
X-MC-Unique: 529894t0NSe6-ML5zCO8bQ-1
Received: by mail-wr1-f69.google.com with SMTP id l9so1335365wrq.20
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r4FURFfSuhXn3uKUcQfVyb1EvyOTqFhJnF783uYfxkU=;
 b=G/WdJ94goMKNPznc856bOJouBmW+s9sy58evkyZTR1xTt7CXKLErq/139G/CyINOYU
 Hw/g3ZDSr+cBlO4te90Ln14Zn4uWpDrLEbmjbrzkwfqDt6NTDQVST35p25+zgYHkHsOJ
 XYX7sOIdsPUZwBuEECFtpe+0O+ZgmCeSAICsdGseZ8q2rRIolhNNRnqCo21W+YnTXa3v
 lLTLw6jYkwwNACtMJHVcP6IdoH3YEzObSCZg9lXFULolyRVnVFztJVF8eyq9+fv+9RQO
 7iACbBCDe+DN2LnHCpICmmYac7PbNCdIedLO87ufml3gL3ColIVnLUEWtPX6vuWqewpZ
 4kMw==
X-Gm-Message-State: AOAM530Kxri0gVyFcRmd2A5joyyR8nJ+SgkCYvHzud8f5aJzN68xVaBp
 gtoPEct2hXnWxSqRarw4Y81HnbU8R5xEAQpQrGM5FxxLJvKpUKv0AI6ZsN9UghO58tI7+DmvB/3
 aOQC82wAJJ47wUeU=
X-Received: by 2002:a1c:2e08:: with SMTP id u8mr3082616wmu.156.1601363593160; 
 Tue, 29 Sep 2020 00:13:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxE3oALinkWQUgchTFj11AiYC9mG3ppb5eNks7BODCo0p4G747+fGs54EeJaKoPFvOX5Na7A==
X-Received: by 2002:a1c:2e08:: with SMTP id u8mr3082579wmu.156.1601363592908; 
 Tue, 29 Sep 2020 00:13:12 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id n66sm4230097wmb.35.2020.09.29.00.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:13:12 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:13:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dima Stepanov <dimastep@yandex-team.ru>
Subject: Re: [PATCH v5 0/7] vhost-user-blk: fix the migration issue and
 enhance qtests
Message-ID: <20200929031212-mutt-send-email-mst@kernel.org>
References: <cover.1599813294.git.dimastep@yandex-team.ru>
 <20200924072506-mutt-send-email-mst@kernel.org>
 <20200927064822.GA3761@dimastep-nix>
MIME-Version: 1.0
In-Reply-To: <20200927064822.GA3761@dimastep-nix>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 thuth@redhat.com, qemu-block@nongnu.org, lvivier@redhat.com,
 stefanha@gmail.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, raphael.norwitz@nutanix.com, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 27, 2020 at 09:48:28AM +0300, Dima Stepanov wrote:
> On Thu, Sep 24, 2020 at 07:26:14AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 11, 2020 at 11:39:42AM +0300, Dima Stepanov wrote:
> > > v4 -> v5:
> > >   - vhost: check queue state in the vhost_dev_set_log routine
> > >     tests/qtest/vhost-user-test: prepare the tests for adding new
> > >     dev class
> > >     tests/qtest/vhost-user-test: add support for the
> > >     vhost-user-blk device
> > >     tests/qtest/vhost-user-test: add migrate_reconnect test
> > >     Reviewed-by: Raphael Norwitz
> > >   - Update qtest, by merging vhost-user-blk "if" case with the
> > >     virtio-blk case.
> > 
> > I dropped patches 3-7 since they were stalling on some systems.
> > Pls work with Peter Maydell (cc'd) to figure it out.
> Thanks!
> 
> Peter, can you share any details for the stalling errors with me?

I can say for sure that even on x86/linux the affected tests take
much longer to run with these applied.
I'd suggest making sure there are no timeouts involved in the good case ....

> > 
> > 
> > > v3 -> v4:
> > >   - vhost: recheck dev state in the vhost_migration_log routine
> > >     Reviewed-by: Raphael Norwitz
> > >   - vhost: check queue state in the vhost_dev_set_log routine
> > >     Use "continue" instead of "break" to handle non-initialized
> > >     virtqueue case.
> > > 
> > > v2 -> v3:
> > >   - update commit message for the 
> > >     "vhost: recheck dev state in the vhost_migration_log routine" commit
> > >   - rename "started" field of the VhostUserBlk structure to
> > >     "started_vu", so there will be no confustion with the VHOST started
> > >     field
> > >   - update vhost-user-test.c to always initialize nq local variable
> > >     (spotted by patchew)
> > > 
> > > v1 -> v2:
> > >   - add comments to connected/started fields in the header file
> > >   - move the "s->started" logic from the vhost_user_blk_disconnect
> > >     routine to the vhost_user_blk_stop routine
> > > 
> > > Reference e-mail threads:
> > >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
> > >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html
> > > 
> > > If vhost-user daemon is used as a backend for the vhost device, then we
> > > should consider a possibility of disconnect at any moment. There was a general
> > > question here: should we consider it as an error or okay state for the vhost-user
> > > devices during migration process?
> > > I think the disconnect event for the vhost-user devices should not break the
> > > migration process, because:
> > >   - the device will be in the stopped state, so it will not be changed
> > >     during migration
> > >   - if reconnect will be made the migration log will be reinitialized as
> > >     part of reconnect/init process:
> > >     #0  vhost_log_global_start (listener=0x563989cf7be0)
> > >     at hw/virtio/vhost.c:920
> > >     #1  0x000056398603d8bc in listener_add_address_space (listener=0x563989cf7be0,
> > >         as=0x563986ea4340 <address_space_memory>)
> > >     at softmmu/memory.c:2664
> > >     #2  0x000056398603dd30 in memory_listener_register (listener=0x563989cf7be0,
> > >         as=0x563986ea4340 <address_space_memory>)
> > >     at softmmu/memory.c:2740
> > >     #3  0x0000563985fd6956 in vhost_dev_init (hdev=0x563989cf7bd8,
> > >         opaque=0x563989cf7e30, backend_type=VHOST_BACKEND_TYPE_USER,
> > >         busyloop_timeout=0)
> > >     at hw/virtio/vhost.c:1385
> > >     #4  0x0000563985f7d0b8 in vhost_user_blk_connect (dev=0x563989cf7990)
> > >     at hw/block/vhost-user-blk.c:315
> > >     #5  0x0000563985f7d3f6 in vhost_user_blk_event (opaque=0x563989cf7990,
> > >         event=CHR_EVENT_OPENED)
> > >     at hw/block/vhost-user-blk.c:379
> > > The first patch in the patchset fixes this issue by setting vhost device to the
> > > stopped state in the disconnect handler and check it the vhost_migration_log()
> > > routine before returning from the function.
> > > qtest framework was updated to test vhost-user-blk functionality. The
> > > vhost-user-blk/vhost-user-blk-tests/migrate_reconnect test was added to reproduce
> > > the original issue found.
> > > 
> > > Dima Stepanov (7):
> > >   vhost: recheck dev state in the vhost_migration_log routine
> > >   vhost: check queue state in the vhost_dev_set_log routine
> > >   tests/qtest/vhost-user-test: prepare the tests for adding new dev
> > >     class
> > >   tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
> > >   tests/qtest/vhost-user-test: add support for the vhost-user-blk device
> > >   tests/qtest/vhost-user-test: add migrate_reconnect test
> > >   tests/qtest/vhost-user-test: enable the reconnect tests
> > > 
> > >  hw/block/vhost-user-blk.c          |  19 ++-
> > >  hw/virtio/vhost.c                  |  39 ++++-
> > >  include/hw/virtio/vhost-user-blk.h |  10 ++
> > >  tests/qtest/libqos/virtio-blk.c    |  14 +-
> > >  tests/qtest/vhost-user-test.c      | 290 +++++++++++++++++++++++++++++++------
> > >  5 files changed, 322 insertions(+), 50 deletions(-)
> > > 
> > > -- 
> > > 2.7.4
> > 


