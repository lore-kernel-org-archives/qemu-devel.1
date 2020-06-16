Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B72C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 01:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C1E2063A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 01:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C1E2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl0dd-0006vG-NR
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 21:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jl0cu-0006WE-2s
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 21:43:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:30356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jl0cr-0006Ti-2x
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 21:42:59 -0400
IronPort-SDR: YT1R2E1bYnekiyBBBErBCdI5NSFIGXIaL69utpUqfOF1e92cjM2YAhTPW2SHUrFnIOoaZx84lZ
 j4+ttP+L833Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 18:42:50 -0700
IronPort-SDR: idoUB/vdR1jj9F729eRSJg/USVtdqrF5CHJMdT7MCUKiKASN+7kkJC3G70Ute2PFttQqpYUoBH
 w3IeMSuzt+pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,517,1583222400"; d="scan'208";a="317073600"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2020 18:42:49 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 18:42:48 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 16 Jun 2020 09:42:46 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 16 Jun 2020 09:42:46 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH 0/5] colo: Introduce resource agent and test suite/CI
Thread-Topic: [PATCH 0/5] colo: Introduce resource agent and test suite/CI
Thread-Index: AQHWJ4+JC/byrpQAOkeK5CfNvLkl+6io5uXwgCKtGQCADxfj4A==
Date: Tue, 16 Jun 2020 01:42:45 +0000
Message-ID: <8f8990d3a2f540bdaa44eb48eeafbc67@intel.com>
References: <cover.1589199922.git.lukasstraub2@web.de>
 <a1d3390036cd4007b53786cf6cb7b5a9@intel.com> <20200606205932.30099b9f@luklap>
In-Reply-To: <20200606205932.30099b9f@luklap>
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
Received-SPF: pass client-ip=134.134.136.65; envelope-from=chen.zhang@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 21:42:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Jason Wang <jasowang@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Sunday, June 7, 2020 3:00 AM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: qemu-devel <qemu-devel@nongnu.org>; Alberto Garcia
> <berto@igalia.com>; Dr. David Alan Gilbert <dgilbert@redhat.com>; Jason
> Wang <jasowang@redhat.com>
> Subject: Re: [PATCH 0/5] colo: Introduce resource agent and test suite/CI
>=20
> On Mon, 18 May 2020 09:38:24 +0000
> "Zhang, Chen" <chen.zhang@intel.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Lukas Straub <lukasstraub2@web.de>
> > > Sent: Monday, May 11, 2020 8:27 PM
> > > To: qemu-devel <qemu-devel@nongnu.org>
> > > Cc: Alberto Garcia <berto@igalia.com>; Dr. David Alan Gilbert
> > > <dgilbert@redhat.com>; Zhang, Chen <chen.zhang@intel.com>
> > > Subject: [PATCH 0/5] colo: Introduce resource agent and test
> > > suite/CI
> > >
> > > Hello Everyone,
> > > These patches introduce a resource agent for fully automatic
> > > management of colo and a test suite building upon the resource agent =
to
> extensively test colo.
> > >
> > > Test suite features:
> > > -Tests failover with peer crashing and hanging and failover during
> > > checkpoint -Tests network using ssh and iperf3 -Quick test requires
> > > no special configuration -Network test for testing colo-compare
> > > -Stress test: failover all the time with network load
> > >
> > > Resource agent features:
> > > -Fully automatic management of colo
> > > -Handles many failures: hanging/crashing qemu, replication error,
> > > disk error, ...
> > > -Recovers from hanging qemu by using the "yank" oob command -Tracks
> > > which node has up-to-date data -Works well in clusters with more
> > > than 2 nodes
> > >
> > > Run times on my laptop:
> > > Quick test: 200s
> > > Network test: 800s (tagged as slow)
> > > Stress test: 1300s (tagged as slow)
> > >
> > > The test suite needs access to a network bridge to properly test the
> > > network, so some parameters need to be given to the test run. See
> > > tests/acceptance/colo.py for more information.
> > >
> > > I wonder how this integrates in existing CI infrastructure. Is there
> > > a common CI for qemu where this can run or does every subsystem have
> > > to run their own CI?
> >
> > Wow~ Very happy to see this series.
> > I have checked the "how to" in tests/acceptance/colo.py, But it looks
> > not enough for users, can you write an independent document for this
> series?
> > Include test Infrastructure ASC II diagram,  test cases design ,
> > detailed how to and more information for pacemaker cluster and resource
> agent..etc ?
>=20
> Hi,
> I quickly created a more complete howto for configuring a pacemaker clust=
er
> and using the resource agent, I hope it helps:
> https://wiki.qemu.org/Features/COLO/Managed_HOWTO

Hi Lukas,

I noticed you contribute some content in Qemu COLO WIKI.
For the Features/COLO/Manual HOWTO
https://wiki.qemu.org/Features/COLO/Manual_HOWTO

Why not keep the Secondary side start command same with the qemu/docs/COLO-=
FT.txt?
If I understand correctly, add the quorum related command in secondary will=
 support resume replication.
Then, we can add primary/secondary resume step here.

Thanks
Zhang Chen

>=20
> Regards,
> Lukas Straub
>=20
> > Thanks
> > Zhang Chen
> >
> >
> > >
> > > Regards,
> > > Lukas Straub
> > >
> > >
> > > Lukas Straub (5):
> > >   block/quorum.c: stable children names
> > >   colo: Introduce resource agent
> > >   colo: Introduce high-level test suite
> > >   configure,Makefile: Install colo resource-agent
> > >   MAINTAINERS: Add myself as maintainer for COLO resource agent
> > >
> > >  MAINTAINERS                              |    6 +
> > >  Makefile                                 |    5 +
> > >  block/quorum.c                           |   20 +-
> > >  configure                                |   10 +
> > >  scripts/colo-resource-agent/colo         | 1429 ++++++++++++++++++++=
++
> > >  scripts/colo-resource-agent/crm_master   |   44 +
> > >  scripts/colo-resource-agent/crm_resource |   12 +
> > >  tests/acceptance/colo.py                 |  689 +++++++++++
> > >  8 files changed, 2209 insertions(+), 6 deletions(-)  create mode
> > > 100755 scripts/colo-resource-agent/colo  create mode 100755
> > > scripts/colo-resource- agent/crm_master  create mode 100755
> > > scripts/colo-resource-agent/crm_resource
> > >  create mode 100644 tests/acceptance/colo.py
> > >
> > > --
> > > 2.20.1


