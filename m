Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B22C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 03:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B30A20848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 03:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koyvnDqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B30A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBV4M-0007mI-Kz
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 23:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kBV3p-0007He-Fc; Thu, 27 Aug 2020 23:28:17 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:35769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kBV3n-0004ZK-Fm; Thu, 27 Aug 2020 23:28:17 -0400
Received: by mail-oo1-xc42.google.com with SMTP id j19so1743358oor.2;
 Thu, 27 Aug 2020 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=llaIb6rl59xW94j4o6h1/y42rYaarCMWr+k0GeVoi7A=;
 b=koyvnDqZbr3KoYAF8xD982/WPI1Q+hCucX0NPN2MYx44wxz/ZDiGWnK2zgHELlcr7F
 G6xbxgiZIExbmrdRcro1YYnZ6JRhb2Uj/4x1VhPLW0Yum1e+FrZKigO5KqwrUNTsiXS4
 v2WalTm5nad6GxVCBOa663KgVcnhCEal3q2elMmt4pDhydiLlrAAn+r4yqP+PazLDk9m
 NgcMdpv9h+9n+gj7zTZ6NgTV5slADv9q46Wgq+LnszPaAFziVawHiUbQ7zsiEFp/BImK
 bKQ8kppXbLLsYlum7EfowvduPgDvLyOVxeB4JTaXEvHzVyZaed1kvuUWdVEjDAsMJ4l5
 oI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=llaIb6rl59xW94j4o6h1/y42rYaarCMWr+k0GeVoi7A=;
 b=bxMlMfRwuXqBhaL5QoEXrU0yIj16mGLmAcUwYneb1QYitvl53ZeNxF4nV1Zb6S5TPY
 jxsWRN+5AOx8au+xjwhxTexYV6jGFwtHmCX/LevN79AduMv7yTlmYEMVjvWnh8FrY2ZC
 OFmRxT9UyD4Sno+8Pg8UUk3d1ZiyMNxdU7wGBTbwlI2pIYRhTVWlDZzDIJ1iHuYD4oSn
 ROSzu6BX+h5caxAbtyNWluD7yF1CcwxVR10ESqumx02TcjEY9pIeFyJLnSY11wSIuNe/
 b1od0KjJ9o/HhoMKHI36Wj0o1x50lU2TAIFTng0iL0cmVbe+7U9ICFHjMnCloPL8Lfgw
 CwVQ==
X-Gm-Message-State: AOAM530op8F4PHeDF3/k0gtks9OPD5YEYxOis85KOOD9N5eylg1YOGV0
 F2eg/00FYYYD3fN/fyQm4EvLoKXgkXvoDMAW+9I=
X-Google-Smtp-Source: ABdhPJxV2a6ZyE4QK14B7cq0kGnqMrj5yxg0nHaWzVYq9+62Gj7NGTpYw0RBX1xn8H0VArgn8ofhBHm7CcYgkJ1EMxk=
X-Received: by 2002:a4a:b791:: with SMTP id a17mr16473273oop.90.1598585293705; 
 Thu, 27 Aug 2020 20:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596536559.git.dimastep@yandex-team.ru>
 <20200827081556-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200827081556-mutt-send-email-mst@kernel.org>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 27 Aug 2020 23:28:02 -0400
Message-ID: <CAFubqFttDNhkK3sXEv_jVDxw5VNviqfe6AH7TBfHAw=yxk6p8g@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] vhost-user-blk: fix the migration issue and
 enhance qtests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Dima Stepanov <dimastep@yandex-team.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 8:17 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Aug 04, 2020 at 01:36:45PM +0300, Dima Stepanov wrote:
> > Reference e-mail threads:
> >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
> >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html
> >
> > If vhost-user daemon is used as a backend for the vhost device, then we
> > should consider a possibility of disconnect at any moment. There was a general
> > question here: should we consider it as an error or okay state for the vhost-user
> > devices during migration process?
> > I think the disconnect event for the vhost-user devices should not break the
> > migration process, because:
> >   - the device will be in the stopped state, so it will not be changed
> >     during migration
> >   - if reconnect will be made the migration log will be reinitialized as
> >     part of reconnect/init process:
> >     #0  vhost_log_global_start (listener=0x563989cf7be0)
> >     at hw/virtio/vhost.c:920
> >     #1  0x000056398603d8bc in listener_add_address_space (listener=0x563989cf7be0,
> >         as=0x563986ea4340 <address_space_memory>)
> >     at softmmu/memory.c:2664
> >     #2  0x000056398603dd30 in memory_listener_register (listener=0x563989cf7be0,
> >         as=0x563986ea4340 <address_space_memory>)
> >     at softmmu/memory.c:2740
> >     #3  0x0000563985fd6956 in vhost_dev_init (hdev=0x563989cf7bd8,
> >         opaque=0x563989cf7e30, backend_type=VHOST_BACKEND_TYPE_USER,
> >         busyloop_timeout=0)
> >     at hw/virtio/vhost.c:1385
> >     #4  0x0000563985f7d0b8 in vhost_user_blk_connect (dev=0x563989cf7990)
> >     at hw/block/vhost-user-blk.c:315
> >     #5  0x0000563985f7d3f6 in vhost_user_blk_event (opaque=0x563989cf7990,
> >         event=CHR_EVENT_OPENED)
> >     at hw/block/vhost-user-blk.c:379
> > The first patch in the patchset fixes this issue by setting vhost device to the
> > stopped state in the disconnect handler and check it the vhost_migration_log()
> > routine before returning from the function.
> > qtest framework was updated to test vhost-user-blk functionality. The
> > vhost-user-blk/vhost-user-blk-tests/migrate_reconnect test was added to reproduce
> > the original issue found.
>
>
> Raphael any input on this?

Just posted comments on the vhost/vhost-user-blk side. Will look at
the test code next.

>
> > Dima Stepanov (7):
> >   vhost: recheck dev state in the vhost_migration_log routine
> >   vhost: check queue state in the vhost_dev_set_log routine
> >   tests/qtest/vhost-user-test: prepare the tests for adding new dev
> >     class
> >   tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
> >   tests/qtest/vhost-user-test: add support for the vhost-user-blk device
> >   tests/qtest/vhost-user-test: add migrate_reconnect test
> >   tests/qtest/vhost-user-test: enable the reconnect tests
> >
> >  hw/block/vhost-user-blk.c          |  13 +-
> >  hw/virtio/vhost.c                  |  39 ++++-
> >  include/hw/virtio/vhost-user-blk.h |   1 +
> >  tests/qtest/libqos/virtio-blk.c    |  14 ++
> >  tests/qtest/vhost-user-test.c      | 291 +++++++++++++++++++++++++++++++------
> >  5 files changed, 311 insertions(+), 47 deletions(-)
> >
> > --
> > 2.7.4
>
>

