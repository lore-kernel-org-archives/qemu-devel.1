Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF9CC43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 15:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19A920665
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 15:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19A920665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heiJw-0002CW-Hs
	for qemu-devel@archiver.kernel.org; Sat, 22 Jun 2019 11:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42174)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1heiJB-0001YX-Ik
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1heiJA-0001uq-D6
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:52:05 -0400
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:47063)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1heiJA-0001eX-5x
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:52:04 -0400
Received: from player793.ha.ovh.net (unknown [10.108.35.223])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id E9CBB1F6C14
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2019 17:51:50 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id ABB78734F4C0;
 Sat, 22 Jun 2019 15:51:41 +0000 (UTC)
Date: Sat, 22 Jun 2019 17:51:40 +0200
From: Greg Kurz <groug@kaod.org>
To: Yongji Xie <elohimes@gmail.com>
Message-ID: <20190622175140.5de328e2@bahia.lan>
In-Reply-To: <CAONzpcaPxf2aBrBhNYyFg11TFNLzjEE0qf1Hc_6ePPjb0CVYrA@mail.gmail.com>
References: <20190614093121.5580-1-xieyongji@baidu.com>
 <20190614093121.5580-2-xieyongji@baidu.com>
 <20190614134452.7924f135@bahia.lan>
 <CAONzpcYMmw+4q-VmBOnrBBNbfrG4XeSggk3R2tAKmF5u6b1VcA@mail.gmail.com>
 <20190617072044.3e95124f@bahia.lan>
 <CAONzpcaPxf2aBrBhNYyFg11TFNLzjEE0qf1Hc_6ePPjb0CVYrA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5662713584376387885
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtdekgdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.44.50
Subject: Re: [Qemu-devel] [PATCH v3 1/5] virtio: add "use-started" property
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, pbonzini@redhat.com,
 Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 14:04:10 +0800
Yongji Xie <elohimes@gmail.com> wrote:

> On Mon, 17 Jun 2019 at 13:24, Greg Kurz <groug@kaod.org> wrote:
> >
> > On Mon, 17 Jun 2019 10:14:30 +0800
> > Yongji Xie <elohimes@gmail.com> wrote:
> >  
> > > On Fri, 14 Jun 2019 at 19:45, Greg Kurz <groug@kaod.org> wrote:  
> > > >
> > > > On Fri, 14 Jun 2019 17:31:17 +0800
> > > > elohimes@gmail.com wrote:
> > > >  
> > > > > From: Xie Yongji <xieyongji@baidu.com>
> > > > >
> > > > > In order to avoid migration issues, we introduce a "use-started"
> > > > > property to the base virtio device to indicate whether use
> > > > > "started" flag or not. This property will be true by default and
> > > > > set to false when machine type <= 4.0.1.
> > > > >
> > > > > Suggested-by: Greg Kurz <groug@kaod.org>
> > > > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > > > ---
> > > > >  hw/block/vhost-user-blk.c  |  4 ++--
> > > > >  hw/core/machine.c          |  8 ++++++--  
> > > >
> > > > This patch conflicts with latest upstream changes to hw_compat_4_0_1[].
> > > >
> > > > It seems you need to rebase. Also, I'm still not sure how we're supposed
> > > > to handle hw_compat_4_0_1[] versus hw_compat_4_0[]... nobody commented
> > > > on:
> > > >
> > > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00637.html
> > > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00641.html
> > > >
> > > > Maybe worth to sort that out before re-posting.
> > > >  
> > >
> > > If hw_compat_4_0_1[] is introduced only for q35, I think this patch
> > > should be OK. If not, maybe we should handle hw_compat_4_0_1[] in
> > > other machine types (i440fx, arm, ppc, s390)?
> > >  
> >
> > It turns out that hw_compat_4_0_1[] isn't needed at all. Please see:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03054.html
> >  
> 
> Oh, great! I will rebase my patch after this commit is merged.
> 
> Thanks,
> Yongji

You can proceed.

https://git.qemu.org/?p=qemu.git;a=commit;h=8e8cbed09ad9d577955691b4c061b61b602406d1

Cheers,

--
Greg

