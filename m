Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57435C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274FA21D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274FA21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWZs-0008DY-Tm
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iDWPO-0004Z2-Du
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iDWPK-00043L-GQ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:14:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:57787)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iDWPK-0003t4-9X
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:14:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 09:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; d="scan'208";a="219454024"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2019 09:13:49 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 09:13:48 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 09:13:48 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.113]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.235]) with mapi id 14.03.0439.000;
 Fri, 27 Sep 2019 00:13:46 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v5 0/4] colo: Add support for continuous replication
Thread-Topic: [PATCH v5 0/4] colo: Add support for continuous replication
Thread-Index: AQHVa/qgNl0a22l5hkOomUt8zU/K3ac9q5sAgACGoAA=
Date: Thu, 26 Sep 2019 16:13:46 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780627E4F5@shsmsx102.ccr.corp.intel.com>
References: <cover.1568574478.git.lukasstraub2@web.de>
 <20190926180956.731f3c6f@luklap>
In-Reply-To: <20190926180956.731f3c6f@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGIwMzQ3NDktMmU2Yi00ZjY3LTg4NmItY2RhNWYyOWY1NGJmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiajZaV0oyRUFMWFwvS3pHOFpLSUQxc0k5WjBIa1BhQTYxUDRWNmxsUFNua2RmOUc5TEhSSkoxNGlWdWp2bFlzeWEifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
 Xie Changlong <xiechanglong.d@gmail.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Friday, September 27, 2019 12:10 AM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> Xie Changlong <xiechanglong.d@gmail.com>; kwolf@redhat.com;
> mreitz@redhat.com
> Subject: Re: [PATCH v5 0/4] colo: Add support for continuous replication
>=20
> On Sun, 15 Sep 2019 21:19:50 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
>=20
> > Hello Everyone,
> > These Patches add support for continuous replication to colo. This
> > means that after the Primary fails and the Secondary did a failover,
> > the Secondary can then become Primary and resume replication to a new
> Secondary.
> >
> > On a side note, I wrote a Pacemaker Resource Agent for colo which I
> > will post when its ready.
> > I have to say it's quite fun to randomly kill a Node, wait for resync
> > and repeat and see how the VM stays alive all the time. :)
> >
> > Regards,
> > Lukas Straub
> >
> > v5:
> >  - change syntax for the position=3D parameter
> >  - fix spelling mistake
> >
> > v4:
> >  - fix checkpatch.pl warnings
> >
> > v3:
> >  - add test for replication changes
> >  - check if the filter to be inserted before/behind belongs to the
> > same interface
> >  - fix the error message for the position=3D parameter
> >  - rename term "after" -> "behind" and variable "insert_before" ->
> "insert_before_flag"
> >  - document the quorum node on the secondary side
> >  - simplify quorum parameters in documentation
> >  - remove trailing spaces in documentation
> >  - clarify the testing procedure in documentation
> >
> > v2:
> >  - fix email formating
> >  - fix checkpatch.pl warnings
> >  - fix patchew error
> >  - clearer commit messages
> >
> >
> > Lukas Straub (4):
> >   block/replication.c: Ignore requests after failover
> >   tests/test-replication.c: Add test for ignoring requests after
> >     failover
> >   net/filter.c: Add Options to insert filters anywhere in the filter
> >     list
> >   colo: Update Documentation for continuous replication
> >
> >  block/replication.c        |  38 ++++++-
> >  docs/COLO-FT.txt           | 212 +++++++++++++++++++++++++++----------
> >  docs/block-replication.txt |  28 +++--
> >  include/net/filter.h       |   2 +
> >  net/filter.c               |  92 +++++++++++++++-
> >  qemu-options.hx            |  10 +-
> >  tests/test-replication.c   |  52 +++++++++
> >  7 files changed, 358 insertions(+), 76 deletions(-)
> >
>=20
> Hello Everyone,
> Ping.

Sorry for slow reply, I'm reviewing~

Thanks
Zhang Chen

>=20
> Regards,
> Lukas Straub

