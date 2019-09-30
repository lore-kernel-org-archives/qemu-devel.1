Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0D8C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8956A205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8956A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF255-0002mu-Bu
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iF232-0001NK-3M
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iF230-0001ms-SJ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:13:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:43526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iF230-0001me-J3
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:13:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Sep 2019 13:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; d="scan'208";a="204913742"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2019 13:13:29 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 13:13:29 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Sep 2019 13:13:26 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 30 Sep 2019 13:13:25 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.33]) with mapi id 14.03.0439.000;
 Tue, 1 Oct 2019 04:13:24 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH v5 2/4] tests/test-replication.c: Add test for ignoring
 requests after failover
Thread-Topic: [PATCH v5 2/4] tests/test-replication.c: Add test for ignoring
 requests after failover
Thread-Index: AQHVa/qhYqqFivT2Tkmj/wvfs4Rj+6c+SXUAgAIySoCABEIfAA==
Date: Mon, 30 Sep 2019 20:13:23 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78062955FD@shsmsx102.ccr.corp.intel.com>
References: <cover.1568574478.git.lukasstraub2@web.de>
 <e3f1e1ec5b2bd2ce2c9a6c7669284a3fc2fdbaaa.1568574478.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D780627E731@shsmsx102.ccr.corp.intel.com>
 <20190928130628.38407661@luklap>
In-Reply-To: <20190928130628.38407661@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjdhYmRiYzYtODk4YS00MTgwLTllNGQtMzdjZWM0ODc0NTRhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ1FWMWFuQjdcL1BQczQ1eUZyT0hKWlN1V2NMbFBGbFJ4TFRpbmtZZlF0OGFzc3RBc3dwSnVLVnZhdGlCbW9NYngifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Saturday, September 28, 2019 7:07 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: qemu-devel <qemu-devel@nongnu.org>; Jason Wang
> <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> Xie Changlong <xiechanglong.d@gmail.com>; kwolf@redhat.com;
> mreitz@redhat.com
> Subject: Re: [PATCH v5 2/4] tests/test-replication.c: Add test for ignori=
ng
> requests after failover
>=20
> On Thu, 26 Sep 2019 17:40:03 +0000
> "Zhang, Chen" <chen.zhang@intel.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Lukas Straub <lukasstraub2@web.de>
> > > Sent: Monday, September 16, 2019 3:20 AM
> > > To: qemu-devel <qemu-devel@nongnu.org>
> > > Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> > > <jasowang@redhat.com>; Wen Congyang
> <wencongyang2@huawei.com>; Xie
> > > Changlong <xiechanglong.d@gmail.com>; kwolf@redhat.com;
> > > mreitz@redhat.com
> > > Subject: [PATCH v5 2/4] tests/test-replication.c: Add test for
> > > ignoring requests after failover
> > >
> > > This simulates the case that happens when we resume COLO after
> failover.
> > >
> >
> > It looks change the title to "Add test for secondary node continuous
> backup" is better.
>=20
> Did you mean "continuous replication"? Would "Add test for secondary node
> continuing replication" be Ok?

OK for me.

Thanks
Zhang Chen

>=20
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > ---
> > >  tests/test-replication.c | 52
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > >
> > > diff --git a/tests/test-replication.c b/tests/test-replication.c
> > > index
> > > f085d1993a..5addfc2227 100644
> > > --- a/tests/test-replication.c
> > > +++ b/tests/test-replication.c
> > > @@ -489,6 +489,56 @@ static void test_secondary_stop(void)
> > >      teardown_secondary();
> > >  }
> > >
> > > +static void test_secondary_failover_then_ignore_requests(void)
> >
> > Same as title, I think change to "test_secondary_continuous_backup" is
> more clear.
> >
> > Thanks
> > Zhang Chen
> >
> > > +{
> > > +    BlockBackend *top_blk, *local_blk;
> > > +    Error *local_err =3D NULL;
> > > +
> > > +    top_blk =3D start_secondary();
> > > +    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
> > > +    g_assert(!local_err);
> > > +
> > > +    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
> > > +    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);
> > > +    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2,
> > > + false);
> > > +
> > > +    /* replication will backup s_local_disk to s_hidden_disk */
> > > +    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,
> > > +                  IMG_SIZE / 2, 0, IMG_SIZE, false);
> > > +
> > > +    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */
> > > +    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);
> > > +
> > > +    /* do failover (active commit) */
> > > +    replication_stop_all(true, &local_err);
> > > +    g_assert(!local_err);
> > > +
> > > +    /* it should ignore all requests from now on */
> > > +
> > > +    /* start after failover */
> > > +    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
> > > +    g_assert(!local_err);
> > > +
> > > +    /* checkpoint */
> > > +    replication_do_checkpoint_all(&local_err);
> > > +    g_assert(!local_err);
> > > +
> > > +    /* stop */
> > > +    replication_stop_all(true, &local_err);
> > > +    g_assert(!local_err);
> > > +
> > > +    /* read from s_local_disk (0, IMG_SIZE / 2) */
> > > +    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,
> > > +                  0, IMG_SIZE / 2, false);
> > > +
> > > +
> > > +    /* read from s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
> > > +    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,
> > > +                  IMG_SIZE / 2, 0, IMG_SIZE, false);
> > > +
> > > +    teardown_secondary();
> > > +}
> > > +
> > >  static void test_secondary_do_checkpoint(void)
> > >  {
> > >      BlockBackend *top_blk, *local_blk; @@ -584,6 +634,8 @@ int
> > > main(int argc, char **argv)
> > >      g_test_add_func("/replication/secondary/write",
> test_secondary_write);
> > >      g_test_add_func("/replication/secondary/start",
> test_secondary_start);
> > >      g_test_add_func("/replication/secondary/stop",
> > > test_secondary_stop);
> > > +
> > > g_test_add_func("/replication/secondary/failover_then_ignore_request
> > > s",
> > > +                    test_secondary_failover_then_ignore_requests);
> > >      g_test_add_func("/replication/secondary/do_checkpoint",
> > >                      test_secondary_do_checkpoint);
> > >      g_test_add_func("/replication/secondary/get_error_all",
> > > --
> > > 2.20.1
> >


