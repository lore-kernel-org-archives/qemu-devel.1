Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54501C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A328C21D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YQCvIo8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A328C21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvDx-0006EK-Le
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kFvCW-0004RK-BS; Wed, 09 Sep 2020 04:11:32 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:52744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kFvCS-00036H-La; Wed, 09 Sep 2020 04:11:31 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 473FD2E1657;
 Wed,  9 Sep 2020 11:11:24 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 oMwLrUWuht-BNwefssv; Wed, 09 Sep 2020 11:11:24 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1599639084; bh=/luolAJubxg6BfHYOnZDjUjwbRI3UWTr1j212zCdPFc=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=YQCvIo8yOfMVG5m6oWb0qb4mPlyol0L5RtKTMkFgOeYzcXsjyBYfk4hOL4rniyoEq
 joAxPYN3/SJzOewSRH8mC4dTPCaepja89EXqxHLsteKsHoemNkmaCxjQHsPM9FMgp4
 3qobT3bmr8dRNqJSWFcKA+Yo8cAg3ritTpnBHjys=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:6505::1:2])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 gMEsnFG6Bm-BMmGlLam; Wed, 09 Sep 2020 11:11:23 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Wed, 9 Sep 2020 11:11:21 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v4 5/7] tests/qtest/vhost-user-test: add support for the
 vhost-user-blk device
Message-ID: <20200909081115.GB23110@dimastep-nix>
References: <cover.1599211479.git.dimastep@yandex-team.ru>
 <7b407b5b233ec7739d85a9322f8a99a588e7f3aa.1599211479.git.dimastep@yandex-team.ru>
 <CAFubqFuzoxNScgOdR3+dMNFDd0jcjQ2OdKeRZuFuXLEJ2hkNrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFubqFuzoxNScgOdR3+dMNFDd0jcjQ2OdKeRZuFuXLEJ2hkNrQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 11:03:56PM -0400, Raphael Norwitz wrote:
> On Fri, Sep 4, 2020 at 5:35 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
> > Add vhost_user_ops structure for the vhost-user-blk device class. Add
> > the test_reconnect and test_migrate tests for this device.
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> 
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> 
> Just one small suggestion.
> 
> > ---
> >  tests/qtest/vhost-user-test.c | 139 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 137 insertions(+), 2 deletions(-)
> 
> > @@ -857,12 +911,21 @@ static void test_reconnect(void *obj, void *arg, QGuestAllocator *alloc)
> >  {
> >      TestServer *s = arg;
> >      GSource *src;
> > +    int nq;
> >
> > +    if (s->vu_ops->driver_init) {
> > +        s->vu_ops->driver_init(obj, alloc);
> > +    }
> >      if (!wait_for_fds(s)) {
> >          return;
> >      }
> >
> 
> Maybe we could break this logic out into a helper? I imagine there may
> be other cases where we might want to get a number of rings for a
> given device type.
Yes, i've also thought about it and my point is that it isn't clear
right now how it will be used. So i decided to use it in the pretty
straigtforward way. As soon as we add some more vhost-user devices for
testing we can update this code properly.

> 
> 
> > -    wait_for_rings_started(s, 2);
> > +    nq = 1;
> > +    if (s->vu_ops->type == VHOST_USER_NET) {
> > +        /* tx and rx queues */
> > +        nq = 2;
> > +    }
> > +    wait_for_rings_started(s, nq);
> >

