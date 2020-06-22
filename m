Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C206C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7181A25431
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7181A25431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnGKb-0004f9-PZ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 02:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnGK3-0004Fo-AM
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 02:52:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:60634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnGK0-0002tw-MC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 02:52:51 -0400
IronPort-SDR: 0nbeW0z563HQIjawGqkrza5Yc4qc896ibAXO75X1S/T2ILOZP/F3BbPjbpNUrowPZHZrU+hpFD
 LdNYGXXNyBTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="208886117"
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; d="scan'208";a="208886117"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2020 23:52:43 -0700
IronPort-SDR: /G8uJOYrLUSZBqzcak/vmkz8DTLnDtHh+3bZmKtWqRaiZZbnxHQdSdmLC2Gd60lt9a6Bp06sLX
 n9jN5iL2BJCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; d="scan'208";a="300740537"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga004.fm.intel.com with ESMTP; 21 Jun 2020 23:52:43 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 21 Jun 2020 23:52:42 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 22 Jun 2020 14:52:40 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Mon, 22 Jun 2020 14:52:40 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: RE: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
Thread-Topic: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
Thread-Index: AQHWPQXUSKAMWxVp4EWHfvIjGmZAKajRXpJwgArmGoCAAXaSIA==
Date: Mon, 22 Jun 2020 06:52:40 +0000
Message-ID: <f02f06aa12cd406db9f681d11a2b3b47@intel.com>
References: <20200607194611.24763-1-chen.zhang@intel.com>
 <d1b031b8c9f241d4af843392d8091a18@intel.com> <20200617122541.GD2776@work-vm>
In-Reply-To: <20200617122541.GD2776@work-vm>
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
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=chen.zhang@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:52:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Sent: Wednesday, June 17, 2020 8:26 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: qemu-dev <qemu-devel@nongnu.org>; Zhang Chen
> <zhangckid@gmail.com>; Zhanghailiang <zhang.zhanghailiang@huawei.com>
> Subject: Re: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
>=20
> * Zhang, Chen (chen.zhang@intel.com) wrote:
> > Hi Dave,
> >
>=20
> I think it's OK; I guess Zhanghailiang is going to do a pull for it?
> One thought about the change of use of MIGRATION_STATUS_ACTIVE; I
> think it's OK at the moment - but the migration states and the way they
> change becomes part of the API - changing which states we use can confuse
> management applications; since there's no libvirt support, I'll leave it =
to
> Zhanghailiang to know if that's OK.

Hi Hailiang/Dave,

Current upstream libvirt can't support COLO, it looks no new issue for norm=
al migration process.
For the future, new COLO migration status is good for COLO enable work on l=
ibvirt and upper layer.

Thanks
Zhang Chen

>=20
> Dave
>=20
>=20
> >
> > Thanks
> > Zhang Chen
> >
> > > -----Original Message-----
> > > From: Zhang, Chen <chen.zhang@intel.com>
> > > Sent: Monday, June 8, 2020 3:46 AM
> > > To: Dr . David Alan Gilbert <dgilbert@redhat.com>; qemu-dev <qemu-
> > > devel@nongnu.org>
> > > Cc: Zhang Chen <zhangckid@gmail.com>; Zhanghailiang
> > > <zhang.zhanghailiang@huawei.com>; Zhang, Chen
> <chen.zhang@intel.com>
> > > Subject: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
> > >
> > > From: Zhang Chen <chen.zhang@intel.com>
> > >
> > > This series optimize some code of COLO, please review.
> > >
> > > Zhang Chen (3):
> > >   migration/colo: Optimize COLO boot code path
> > >   migration/colo: Update checkpoint time lately
> > >   migration/migration.c: Remove MIGRATION_STATUS_ACTIVE in
> > >     migration_iteration_finish
> > >
> > >  migration/colo.c      |  7 ++-----
> > >  migration/migration.c | 12 +++++-------
> > >  2 files changed, 7 insertions(+), 12 deletions(-)
> > >
> > > --
> > > 2.17.1
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


