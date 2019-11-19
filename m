Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06128C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08F92186D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08F92186D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2dY-0006v1-V2
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iX2cj-0006Pr-2F
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iX2ch-0006Vs-NJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:28:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:24140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iX2ce-0006Pu-9V; Tue, 19 Nov 2019 07:28:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 04:28:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; d="scan'208";a="289590192"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga001.jf.intel.com with ESMTP; 19 Nov 2019 04:28:35 -0800
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 Nov 2019 04:28:35 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.108]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.215]) with mapi id 14.03.0439.000;
 Tue, 19 Nov 2019 20:28:33 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v7 0/4] colo: Add support for continuous replication
Thread-Topic: [PATCH v7 0/4] colo: Add support for continuous replication
Thread-Index: AQHVinb+3QVJTWIS6EWH6Lp9PLoWz6eI5dGAgAmrJEA=
Date: Tue, 19 Nov 2019 12:28:32 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D7806309C8C@shsmsx102.ccr.corp.intel.com>
References: <cover.1571925699.git.lukasstraub2@web.de>
 <20191113173559.0713c27d@luklap>
In-Reply-To: <20191113173559.0713c27d@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzgwOTJmNzAtZjY5Yy00NDA2LWI4YjQtZTkyOWI0MWU3YWQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVndzS1BUTHZtdnhnRXFxSmRBYkVBYmtzMjZuTXo2OUlYU3czc1JuU0lUSXRDaDVkV0hJZHVCZVZJYnE5MmlZeSJ9
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Thursday, November 14, 2019 12:36 AM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> Xie Changlong <xiechanglong.d@gmail.com>; Kevin Wolf
> <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; qemu-block
> <qemu-block@nongnu.org>
> Subject: Re: [PATCH v7 0/4] colo: Add support for continuous replication
>=20
> On Fri, 25 Oct 2019 19:06:31 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
>=20
> > Hello Everyone,
> > These Patches add support for continuous replication to colo. This
> > means that after the Primary fails and the Secondary did a failover,
> > the Secondary can then become Primary and resume replication to a new
> Secondary.
> >
> > Regards,
> > Lukas Straub
> >
> > v7:
> >  - clarify meaning of ip's in documentation and note that active and hi=
dden
> >    images just need to be created once
> >  - reverted removal of bdrv_is_root_node(top_bs) in replication and
> adjusted
> >    the top-id=3D parameter in documentation acordingly
> >
> > v6:
> >  - documented the position=3D and insert=3D options
> >  - renamed replication test
> >  - clarified documentation by using different ip's for primary and
> > secondary
> >  - added Reviewed-by tags
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
> >   tests/test-replication.c: Add test for for secondary node continuing
> >     replication
> >   net/filter.c: Add Options to insert filters anywhere in the filter
> >     list
> >   colo: Update Documentation for continuous replication
> >
> >  block/replication.c        |  35 +++++-
> >  docs/COLO-FT.txt           | 224 +++++++++++++++++++++++++++----------
> >  docs/block-replication.txt |  28 +++--
> >  include/net/filter.h       |   2 +
> >  net/filter.c               |  92 ++++++++++++++-
> >  qemu-options.hx            |  31 ++++-
> >  tests/test-replication.c   |  52 +++++++++
> >  7 files changed, 389 insertions(+), 75 deletions(-)
> >
>=20
> Hello Everyone,
> So I guess this is ready for merging or will that have to wait until the =
4.2
> release is done?

Due to Qemu 4.2 release schedule, after soft feature freeze(Oct29) the mast=
er branch does not accept feature changes.
But I don't know if sub-maintainer(block or net) can queue this series firs=
t then merge it after 4.2 release?=20

Thanks
Zhang Chen

>=20
> Regards,
> Lukas Straub

