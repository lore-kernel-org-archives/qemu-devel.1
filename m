Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2259DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 05:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E3A22CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 05:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E3A22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0J6X-0004Re-0A
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 01:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1i0J5k-000424-2d
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 01:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1i0J5h-0005lq-TG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 01:23:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:12516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1i0J5h-0005fd-Kc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 01:23:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Aug 2019 22:23:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,411,1559545200"; d="scan'208";a="186130776"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2019 22:23:17 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 20 Aug 2019 22:23:17 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.19]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.112]) with mapi id 14.03.0439.000;
 Wed, 21 Aug 2019 13:23:15 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Thread-Topic: [Qemu-devel] [PATCH v2 0/3] colo: Add support for continious
 replication
Thread-Index: AQHVU5R7TpP312DWoEaTVPlBuIos5Kb8CVaAgAAOGQCAAONlQIAAll2AgAeHHkA=
Date: Wed, 21 Aug 2019 05:23:14 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D7806227F91@shsmsx102.ccr.corp.intel.com>
References: <20190815200815.2cffc21b@luklap>	<20190815185737.GC2883@work-vm>
 <20190815214804.69e4334f@luklap>
 <9CFF81C0F6B98A43A459C9EDAD400D780621F1B6@shsmsx102.ccr.corp.intel.com>
 <20190816202007.5577756b@luklap>
In-Reply-To: <20190816202007.5577756b@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGJhZTJjMTItYmY3Ny00NDk3LTk1ZTgtYWVjZDE2YzkwMWZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9qMHNNVzdLMW1cLytHdVhZdFhwQVUzSDA3SU9PeDJwNHpTSW5SbEdBOCt6SjF0SjRwRjhGZXRWN21IZHhDdGg0In0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH v2 0/3] colo: Add support for continious
 replication
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
Cc: Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub [mailto:lukasstraub2@web.de]
> Sent: Saturday, August 17, 2019 2:20 AM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>; qemu-devel <qemu-
> devel@nongnu.org>; Jason Wang <jasowang@redhat.com>; Xie Changlong
> <xiechanglong.d@gmail.com>; Wen Congyang <wencongyang2@huawei.com>
> Subject: Re: [Qemu-devel] [PATCH v2 0/3] colo: Add support for continious
> replication
>=20
> On Fri, 16 Aug 2019 01:51:20 +0000
> "Zhang, Chen" <chen.zhang@intel.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Lukas Straub [mailto:lukasstraub2@web.de]
> > > Sent: Friday, August 16, 2019 3:48 AM
> > > To: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Cc: qemu-devel <qemu-devel@nongnu.org>; Zhang, Chen
> > > <chen.zhang@intel.com>; Jason Wang <jasowang@redhat.com>; Xie
> > > Changlong <xiechanglong.d@gmail.com>; Wen Congyang
> > > <wencongyang2@huawei.com>
> > > Subject: Re: [Qemu-devel] [PATCH v2 0/3] colo: Add support for
> > > continious replication
> > >
> > > On Thu, 15 Aug 2019 19:57:37 +0100
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >
> > > > * Lukas Straub (lukasstraub2@web.de) wrote:
> > > > > Hello Everyone,
> > > > > These Patches add support for continious replication to colo.
> > > > > Please review.
> > > >
> > > >
> > > > OK, for those who haven't followed COLO for so long; 'continuous
> > > > replication' is when after the first primary fails, you can
> > > > promote the original secondary to a new primary and start
> > > > replicating again;
> > > >
> > > > i.e. current COLO gives you
> > > >
> > > > p<->s
> > > >     <primary fails>
> > > >     s
> > > >
> > > > with your patches you can do
> > > >
> > > >     s becomes p2
> > > >     p2<->s2
> > > >
> > > > and you're back to being resilient again.
> > > >
> > > > Which is great; because that was always an important missing piece.
> > > >
> > > > Do you have some test scripts/setup for this - it would be great
> > > > to automate some testing.
> > >
> > > My Plan is to write a Pacemaker Resource Agent[1] for qemu-colo and
> > > then do some long-term testing in my small cluster here. Writing
> > > standalone tests using that Resource Agent should be easy, it just
> > > needs to be provided with the right arguments and environment Variabl=
es.
> >
> > Thanks Dave's explanation.
> > It looks good for me and I will test this series in my side.
> >
> > Another question: Is "Pacemaker Resource Agent[1] "  like a heartbeat
> module?
>=20
> It's a bit more than that. Pacemaker itself is an Cluster Resource Manage=
r, you
> can think of it like sysvinit but for clusters. It controls where in the =
cluster
> Resources run, what state (master/slave) and what to do in case of a Node=
 or
> Resource failure. Now Resources can be anything like SQL-Server, Webserve=
r,
> VM, etc. and Pacemaker itself doesn't directly control them, that's the J=
ob of
> the Resource Agents. So a Resource Agent is like an init-script, but clus=
ter-
> aware with more actions like start, stop, monitor, promote (to master) or
> migrate-to.
>=20
> > I have wrote an internal heartbeat module running on Qemu, it make COLO
> can detect fail and trigger failover automatically, no need external APP =
to call
> the QMP command "x-colo-lost-heartbeat". If you need it, I can send a RFC
> version recently.
>=20
> Cool, this should be faster to failover than with Pacemaker.
> What is the plan with cases like Primary-failover, which need to issue mu=
ltiple
> commands?

Yes, currently we need input some net filter delete command after primary-f=
ailover.
We need make a way to remove related net-filter and chardev automatically.
But for Pacemaker it isn't a problem, you can send related qmp command afte=
r the "x-lost-heart-beat".=20

Thanks
Zhang Chen

>=20
> > Thanks
> > Zhang Chen
> > >
> > > Regards,
> > > Lukas Straub
> > >
> > > [1]
> > > https://github.com/ClusterLabs/resource-agents/blob/master/doc/dev-g
> > > uides/ra-dev-guide.asc#what-is-a-resource-agent


