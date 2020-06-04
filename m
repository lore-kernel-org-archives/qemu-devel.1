Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77918C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ACB2206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACB2206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjUT-0000jd-ET
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jgjTB-0007wF-Vw
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:35:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:26402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jgjT9-0007Ut-AA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:35:17 -0400
IronPort-SDR: U+Il4MOM7+59TG1Qq1p0wgfdhnpGoesS+tis2Q24TGZoKbfK4iogmTPyEDBaoEN7sPSYnTsauU
 PvaTEzgrD/RA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 23:35:10 -0700
IronPort-SDR: gYb//LW/eRpxkgjXeabvZlG8k5ZFcT2N1T+7BSzNGDCMk4c7Abbaegq+hScy07sVvovCng5LnF
 JzZ04FFXlzsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; d="scan'208";a="471430473"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2020 23:35:10 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jun 2020 23:35:10 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 4 Jun 2020 14:35:08 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Thu, 4 Jun 2020 14:35:08 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/3] migration/colo: Merge multi checkpoint request into
 one.
Thread-Topic: [PATCH 3/3] migration/colo: Merge multi checkpoint request into
 one.
Thread-Index: AQHWKnK9gI6NuJvUXEqXViIblWhBYajEe6YAgAI8B/D//4LMAIAB5LjQ
Date: Thu, 4 Jun 2020 06:35:07 +0000
Message-ID: <38c6ce6681a04bd28a81a21fd6489f98@intel.com>
References: <20200515042818.17908-1-chen.zhang@intel.com>
 <20200515042818.17908-4-chen.zhang@intel.com>
 <359be3274bdf4f0e87c6c45cdc05ae90@huawei.com>
 <ec06e82a5cf34545a332fe80fef0a94e@intel.com>
 <2d33c10d444e4067b798413731dd231e@huawei.com>
In-Reply-To: <2d33c10d444e4067b798413731dd231e@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:35:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
> Sent: Wednesday, June 3, 2020 5:39 PM
> To: Zhang, Chen <chen.zhang@intel.com>; Dr . David Alan Gilbert
> <dgilbert@redhat.com>; Juan Quintela <quintela@redhat.com>; qemu-dev
> <qemu-devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Jason Wang
> <jasowang@redhat.com>
> Subject: RE: [PATCH 3/3] migration/colo: Merge multi checkpoint request
> into one.
>=20
> > -----Original Message-----
> > From: Zhang, Chen [mailto:chen.zhang@intel.com]
> > Sent: Wednesday, June 3, 2020 5:11 PM
> > To: Zhanghailiang <zhang.zhanghailiang@huawei.com>; Dr . David Alan
> > Gilbert <dgilbert@redhat.com>; Juan Quintela <quintela@redhat.com>;
> > qemu-dev <qemu-devel@nongnu.org>
> > Cc: Zhang Chen <zhangckid@gmail.com>; Jason Wang
> <jasowang@redhat.com>
> > Subject: RE: [PATCH 3/3] migration/colo: Merge multi checkpoint
> > request into one.
> >
> >
> >
> > > -----Original Message-----
> > > From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
> > > Sent: Tuesday, June 2, 2020 2:59 PM
> > > To: Zhang, Chen <chen.zhang@intel.com>; Dr . David Alan Gilbert
> > > <dgilbert@redhat.com>; Juan Quintela <quintela@redhat.com>; qemu-
> dev
> > > <qemu-devel@nongnu.org>
> > > Cc: Zhang Chen <zhangckid@gmail.com>; Jason Wang
> > <jasowang@redhat.com>
> > > Subject: RE: [PATCH 3/3] migration/colo: Merge multi checkpoint
> > > request into one.
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Zhang Chen [mailto:chen.zhang@intel.com]
> > > > Sent: Friday, May 15, 2020 12:28 PM
> > > > To: Dr . David Alan Gilbert <dgilbert@redhat.com>; Juan Quintela
> > > > <quintela@redhat.com>; Zhanghailiang
> > > <zhang.zhanghailiang@huawei.com>;
> > > > qemu-dev <qemu-devel@nongnu.org>
> > > > Cc: Zhang Chen <zhangckid@gmail.com>; Jason Wang
> > > > <jasowang@redhat.com>; Zhang Chen <chen.zhang@intel.com>
> > > > Subject: [PATCH 3/3] migration/colo: Merge multi checkpoint
> > > > request into one.
> > > >
> > > > From: Zhang Chen <chen.zhang@intel.com>
> > > >
> > > > When COLO guest occur issues, COLO-compare will catch lots of
> > > > different network packet and trigger notification multi times,
> > > > force periodic may happen at the same time. So this can be
> > > > efficient merge checkpoint request within
> COLO_CHECKPOINT_INTERVAL.
> > > >
> > > > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> > > > ---
> > > >  migration/colo.c | 22 ++++++++++++++++------
> > > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/migration/colo.c b/migration/colo.c index
> > > > d5bced22cb..e6a7d8c6e2 100644
> > > > --- a/migration/colo.c
> > > > +++ b/migration/colo.c
> > > > @@ -47,6 +47,9 @@ static COLOMode last_colo_mode;
> > > >
> > > >  #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
> > > >
> > > > +/* Default COLO_CHECKPOINT_INTERVAL is 1000 ms */ #define
> > > > +COLO_CHECKPOINT_INTERVAL 1000
> > > > +
> > > >  bool migration_in_colo_state(void)  {
> > > >      MigrationState *s =3D migrate_get_current(); @@ -651,13 +654,2=
0
> > > > @@
> > > > out:
> > > >  void colo_checkpoint_notify(void *opaque)  {
> > > >      MigrationState *s =3D opaque;
> > > > -    int64_t next_notify_time;
> > > > +    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> > > >
> > > > -    qemu_sem_post(&s->colo_checkpoint_sem);
> > > > -    s->colo_checkpoint_time =3D
> > qemu_clock_get_ms(QEMU_CLOCK_HOST);
> > > > -    next_notify_time =3D s->colo_checkpoint_time +
> > > > -                    s->parameters.x_checkpoint_delay;
> > > > -    timer_mod(s->colo_delay_timer, next_notify_time);
> > > > +    /*
> > > > +     * When COLO guest occur issues, COLO-compare will catch lots =
of
> > > > +     * different network packet and trigger notification multi tim=
es,
> > > > +     * force periodic may happen at the same time. So this can be
> > > > +     * efficient merge checkpoint request within
> > > > COLO_CHECKPOINT_INTERVAL.
> > > > +     */
> > > > +    if (now > s->colo_checkpoint_time + COLO_CHECKPOINT_INTERVAL)
> > {
> > > > +        qemu_sem_post(&s->colo_checkpoint_sem);
> > >
> > > It is not right here, this notification should not be controlled by
> > > the interval time, I got what happened here, when multiple
> > > checkpoint requires come, this Colo_delay_time will be added every
> > > time and it will be a big value which is not what we want.
> >
> > Not just this, multi checkpoint will spend lots of resource to sync
> > memory from PVM to SVM, It will make VM stop/start multi times, but
> > for the results are same with one checkpoint.
> > So in short time just need one checkpoint, because do checkpoint still
> > need some time...
> >
>=20
> Yes, this because we use semaphore here, it will be increased multiple ti=
mes,
> And I think Lukas's patch 'migration/colo.c: Use event instead of semapho=
re'
> has fixed this problem.
> Did you try the qemu upstream which has merged this patch ?

Oh, Thanks reminder, I will drop this patch and rebase on upstream for V2.

Thank
Zhang Chen

>=20
> > Thanks
> > Zhang Chen
> >
> > >
> > > Besides, please update this patch based on [PATCH 0/6] colo:
> > > migration related bugfixes series which Has modified the same place.
> > >
> > >
> > >
> > > > +        timer_mod(s->colo_delay_timer, now +
> > > > +                  s->parameters.x_checkpoint_delay);
> > > > +        s->colo_checkpoint_time =3D now;
> > > > +    }
> > > >  }
> > > >
> > > >  void migrate_start_colo_process(MigrationState *s)
> > > > --
> > > > 2.17.1


