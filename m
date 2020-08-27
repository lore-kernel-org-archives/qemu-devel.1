Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DA7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDA322B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ai36N3xP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDA322B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGqi-0003Gx-9q
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBGpN-0002iz-Ox
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:16:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBGpL-0002yL-6m
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598530582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BVk2ecLagciDU8Pu+xB36uqOG51QrOckLqDGJfi2/6s=;
 b=Ai36N3xPEpiHZMu9lDi3RYPGV2HpceOyVCty502/zuizyOjF8NLw3JtNyfUs09lcA6qAp6
 r5E0XWiRlvhMywK82Okz2sD7UtQeeaFz8uyV8UQHFKMh6ZecH01wm409SY1UQFuugAQm3E
 uOgh2oPQPv3DP5w9aFW4369IH/bZWEw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-ov6GbHhJObiYX3lDYpaDmQ-1; Thu, 27 Aug 2020 08:16:19 -0400
X-MC-Unique: ov6GbHhJObiYX3lDYpaDmQ-1
Received: by mail-wm1-f70.google.com with SMTP id c186so2043482wmd.9
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BVk2ecLagciDU8Pu+xB36uqOG51QrOckLqDGJfi2/6s=;
 b=bc3h+Z28qUpI8uzswWjRmsMi8TlU+ui9pNqZmQmU0SVVuTxWPUox+oaE0k6HGYSr+E
 VADKW6GITJhi7TCr8RyPDVfYIRT6rOeLnQ18SaBCx8jQG5peAgUfFQzBFJ/pczZeTRjW
 zMFLv/Rv0U5VyswAYgqfQLDitRxCdW+OuzjSD3kPr91Z/+Ef+KqXKszaTUA1Z9/p00o4
 1fVgXtqLacbgRiOnlcFqCbU8ic0UhVGFmrUwKAaY3FY/9OGYn1wZWvyH4kq1NUClSt/v
 /BhGqMbzuwzXk2XGd5M/MiqSxB3z/PT4JkGzeG0zJCB7/3vr4s1mfAbVSWyPT2HMTrZB
 Zh5w==
X-Gm-Message-State: AOAM5318qta9l1z1qYTH212xtNqSeBHY7PA5h7VhNs5211Nt/ymKKN9s
 iE5MDdMYlbsUsYmkLMEJGrNLZOzR91mM0yafYXV8kY0VZ0TFlIroGHcLzyvXelFPE4lZYSlpRDl
 rTOm9Hj7Oy/SxxCc=
X-Received: by 2002:adf:d849:: with SMTP id k9mr21220786wrl.115.1598530576561; 
 Thu, 27 Aug 2020 05:16:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+O6tiB+alPyvc2zohpSl+6qGdmf8/tGJsNmAHVvFZbCHu0SAA7Mu8ljitRMEsl2mNZItEDw==
X-Received: by 2002:adf:d849:: with SMTP id k9mr21220759wrl.115.1598530576311; 
 Thu, 27 Aug 2020 05:16:16 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
 by smtp.gmail.com with ESMTPSA id p14sm6240002wrg.96.2020.08.27.05.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 05:16:15 -0700 (PDT)
Date: Thu, 27 Aug 2020 08:16:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dima Stepanov <dimastep@yandex-team.ru>
Subject: Re: [PATCH v1 0/7] vhost-user-blk: fix the migration issue and
 enhance qtests
Message-ID: <20200827081556-mutt-send-email-mst@kernel.org>
References: <cover.1596536559.git.dimastep@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <cover.1596536559.git.dimastep@yandex-team.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> qtest framework was updated to test vhost-user-blk functionality. The
> vhost-user-blk/vhost-user-blk-tests/migrate_reconnect test was added to reproduce
> the original issue found.


Raphael any input on this?

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


