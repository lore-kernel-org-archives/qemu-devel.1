Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62C2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94B6208A9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfA7KUqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94B6208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xrv-0008C0-1I
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2xms-0003v9-L4
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:19:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26710
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2xmq-0005Ka-P5
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596550768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a9SbY9auShf4q9Q15pGhvpVRHE1I1RNPvox++Y+hYFk=;
 b=CfA7KUqUOMgyPZQJdWhcXxc+hFtOQld9c5Yp3M2zJ53aRqOsTyUwZpgk2toAdbVSk547Bf
 P2bZxL1wxxva+PFpg2+tadUHRb3iOKQ6jJhb4Pt/qPVPwMAvoTFmRkOSzL6Fca5W0AZ+Ns
 OH/7pcexx/nvgJHuH5l6xJcK2kv/t84=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-6Tii61BFMaaO_7Fzbgf6WQ-1; Tue, 04 Aug 2020 10:19:24 -0400
X-MC-Unique: 6Tii61BFMaaO_7Fzbgf6WQ-1
Received: by mail-qv1-f69.google.com with SMTP id j8so26082821qvu.3
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 07:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a9SbY9auShf4q9Q15pGhvpVRHE1I1RNPvox++Y+hYFk=;
 b=uEMHLNHIJERt4bfGFbes/6T/3rgW+4XmfTf7kiCE3br8SbBynziw98+OfWKC4v4+qk
 59w9aautHtJUxPPd+TF5Kw5LjQeM7na8iaAilc7wvk96q852p8KZSCshoBAaPSAgczjD
 pzhWlYlf222Ig3HT67e38MHrN+LO0DpP4sbs9jZVxVE7qEO2YBRgokLR01pQnk3Jo1tJ
 /ZVf8I8MwtZ5ob78JTJ9IIP0CPhUkssYiE+7XNBa4UMdxXVNjAxDL5kNCrjgq7IZQHbS
 2FXryQRti2fB3E63WaonJ67rccnpQiZ0CUzNFmIBt/dq4ELDotiAgprIgnt8CiQUwApy
 vbHA==
X-Gm-Message-State: AOAM533oDn5QG7xYbTemySZnuR+eIf3fAIjvimjrkjQ9u/Cv8WGOKNg3
 FH+I4Z4NTLmqjLBk9lgOUnacFp9PAwtD0scCOz390QjjQ6cxwpUkN6d5KHXkSqKWC+CnEtLgG3u
 ZAahgdUC9YfsNOM8=
X-Received: by 2002:aed:2a82:: with SMTP id t2mr21857060qtd.280.1596550763902; 
 Tue, 04 Aug 2020 07:19:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzfs2ZCLc1G5Of9Qe9WkPrzjDFBgibDKyI9NAc/CqSC6o+JZLVRZRtGchagSauDwNmHeQ/7Q==
X-Received: by 2002:aed:2a82:: with SMTP id t2mr21857026qtd.280.1596550763611; 
 Tue, 04 Aug 2020 07:19:23 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id g4sm21567898qka.25.2020.08.04.07.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 07:19:23 -0700 (PDT)
Date: Tue, 4 Aug 2020 10:19:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dima Stepanov <dimastep@yandex-team.ru>
Subject: Re: [PATCH v1 0/7] vhost-user-blk: fix the migration issue and
 enhance qtests
Message-ID: <20200804101820-mutt-send-email-mst@kernel.org>
References: <cover.1596536559.git.dimastep@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <cover.1596536559.git.dimastep@yandex-team.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, fengli@smartx.com, yc-core@yandex-team.ru,
 pbonzini@redhat.com, raphael.norwitz@nutanix.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 01:36:45PM +0300, Dima Stepanov wrote:
> Reference e-mail threads:
>   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
>   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html
> 
> If vhost-user daemon is used as a backend for the vhost device, then we
> should consider a possibility of disconnect at any moment. There was a general
> question here: should we consider it as an error or okay state for the vhost-user
> devices during migration process?
> I think the disconnect event for the vhost-user devices should not break the
> migration process, because:
>   - the device will be in the stopped state, so it will not be changed
>     during migration
>   - if reconnect will be made the migration log will be reinitialized as
>     part of reconnect/init process:
>     #0  vhost_log_global_start (listener=0x563989cf7be0)
>     at hw/virtio/vhost.c:920
>     #1  0x000056398603d8bc in listener_add_address_space (listener=0x563989cf7be0,
>         as=0x563986ea4340 <address_space_memory>)
>     at softmmu/memory.c:2664
>     #2  0x000056398603dd30 in memory_listener_register (listener=0x563989cf7be0,
>         as=0x563986ea4340 <address_space_memory>)
>     at softmmu/memory.c:2740
>     #3  0x0000563985fd6956 in vhost_dev_init (hdev=0x563989cf7bd8,
>         opaque=0x563989cf7e30, backend_type=VHOST_BACKEND_TYPE_USER,
>         busyloop_timeout=0)
>     at hw/virtio/vhost.c:1385
>     #4  0x0000563985f7d0b8 in vhost_user_blk_connect (dev=0x563989cf7990)
>     at hw/block/vhost-user-blk.c:315
>     #5  0x0000563985f7d3f6 in vhost_user_blk_event (opaque=0x563989cf7990,
>         event=CHR_EVENT_OPENED)
>     at hw/block/vhost-user-blk.c:379
> The first patch in the patchset fixes this issue by setting vhost device to the
> stopped state in the disconnect handler and check it the vhost_migration_log()
> routine before returning from the function.

So I'm a bit confused. Isn't the connected state sufficient for this?
If not, adding some code comments explaining when is each flag
set would be helpful.
Thanks!

> qtest framework was updated to test vhost-user-blk functionality. The
> vhost-user-blk/vhost-user-blk-tests/migrate_reconnect test was added to reproduce
> the original issue found.
> 
> Dima Stepanov (7):
>   vhost: recheck dev state in the vhost_migration_log routine
>   vhost: check queue state in the vhost_dev_set_log routine
>   tests/qtest/vhost-user-test: prepare the tests for adding new dev
>     class
>   tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
>   tests/qtest/vhost-user-test: add support for the vhost-user-blk device
>   tests/qtest/vhost-user-test: add migrate_reconnect test
>   tests/qtest/vhost-user-test: enable the reconnect tests
> 
>  hw/block/vhost-user-blk.c          |  13 +-
>  hw/virtio/vhost.c                  |  39 ++++-
>  include/hw/virtio/vhost-user-blk.h |   1 +
>  tests/qtest/libqos/virtio-blk.c    |  14 ++
>  tests/qtest/vhost-user-test.c      | 291 +++++++++++++++++++++++++++++++------
>  5 files changed, 311 insertions(+), 47 deletions(-)
> 
> -- 
> 2.7.4


