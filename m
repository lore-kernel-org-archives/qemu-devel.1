Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD1CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599A72250E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599A72250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3NkR-0000EC-LT
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1k3NjO-0008Ac-CF
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:01:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:32280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1k3NjL-0004gL-1q
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:01:37 -0400
IronPort-SDR: PJaDASP94wvRF5n2v2cVdemYAfuXJ2sNw4Qf5WSFn5EGhh8PQAAvOsePh9IzVpyUAxKS8mp0HH
 jr70Swp+RnVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="151839878"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; d="scan'208";a="151839878"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2020 11:01:29 -0700
IronPort-SDR: gBml5akettvcNDgEwnXiIo5TRXt802OzlAKXx/P7MGgDuNNsThtRsRahY+/BkmR9OnAe7GJ14P
 mhvP3frA4Tcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; d="scan'208";a="437251038"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga004.jf.intel.com with ESMTP; 05 Aug 2020 11:01:29 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 11:01:28 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Aug 2020 02:01:26 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Thu, 6 Aug 2020 02:01:26 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: RE: [PATCH v2 4/4] net/colo: Match is-enabled probe to tracepoint
Thread-Topic: [PATCH v2 4/4] net/colo: Match is-enabled probe to tracepoint
Thread-Index: AQHWXB2dIBdPKBMk4U6LAJjNITtQFakNoNlQgAPxM4CADHiBAIAAAGsAgArj3YCAAP1N4A==
Date: Wed, 5 Aug 2020 18:01:26 +0000
Message-ID: <be7ff670d9a04199b1159abf16c6bf8c@intel.com>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
 <20200717093517.73397-5-r.bolshakov@yadro.com>
 <3f6bcf74d3c348f9b7744305a6343a79@intel.com>
 <20200721140657.GI843362@redhat.com>
 <20200729123322.GB34804@SPB-NB-133.local>
 <20200729123452.GD3451141@redhat.com>
 <20200805105301.GE361702@stefanha-x1.localdomain>
In-Reply-To: <20200805105301.GE361702@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.115; envelope-from=chen.zhang@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 14:01:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel Berrange <berrange@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: Wednesday, August 5, 2020 6:53 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>; Li Zhijian
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; qemu-
> devel@nongnu.org; Cameron Esfahani <dirty@apple.com>; Philippe
> Mathieu-Daud=E9 <philmd@redhat.com>; Daniel Berrange
> <berrange@redhat.com>
> Subject: Re: [PATCH v2 4/4] net/colo: Match is-enabled probe to tracepoin=
t
>=20
> On Wed, Jul 29, 2020 at 01:34:52PM +0100, Daniel P. Berrang=E9 wrote:
> > On Wed, Jul 29, 2020 at 03:33:22PM +0300, Roman Bolshakov wrote:
> > > On Tue, Jul 21, 2020 at 03:06:57PM +0100, Daniel P. Berrang=E9 wrote:
> > > > On Sat, Jul 18, 2020 at 05:58:56PM +0000, Zhang, Chen wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Roman Bolshakov <r.bolshakov@yadro.com>
> > > > > > Sent: Friday, July 17, 2020 5:35 PM
> > > > > > To: qemu-devel@nongnu.org
> > > > > > Cc: Daniel P. Berrang=E9 <berrange@redhat.com>; Stefan Hajnoczi
> > > > > > <stefanha@redhat.com>; Cameron Esfahani <dirty@apple.com>;
> > > > > > Roman Bolshakov <r.bolshakov@yadro.com>; Philippe
> > > > > > Mathieu-Daud=E9 <philmd@redhat.com>; Zhang, Chen
> > > > > > <chen.zhang@intel.com>; Li Zhijian <lizhijian@cn.fujitsu.com>;
> > > > > > Jason Wang <jasowang@redhat.com>
> > > > > > Subject: [PATCH v2 4/4] net/colo: Match is-enabled probe to
> > > > > > tracepoint
> > > > > >
> > > > > > Build of QEMU with dtrace fails on macOS:
> > > > > >
> > > > > >   LINK    x86_64-softmmu/qemu-system-x86_64
> > > > > > error: probe colo_compare_miscompare doesn't exist
> > > > > > error: Could not register probes
> > > > > > ld: error creating dtrace DOF section for architecture x86_64
> > > > > >
> > > > > > The reason of the error is explained by Adam Leventhal [1]:
> > > > > >
> > > > > >   Note that is-enabled probes don't have the stability magic so=
 I'm
> not
> > > > > >   sure how things would work if only is-enabled probes were use=
d.
> > > > > >
> > > > > > net/colo code uses is-enabled probes to determine if other
> > > > > > probes should be used but colo_compare_miscompare itself is not
> used explicitly.
> > > > > > Linker doesn't include the symbol and build fails.
> > > > > >
> > > > > > The issue can be resolved if is-enabled probe matches the
> > > > > > actual trace point that is used inside the test. Packet dump
> > > > > > toggle is replaced with a compile- time conditional definition.
> > > > > >
> > > > > > 1. http://markmail.org/message/6grq2ygr5nwdwsnb
> > > > > >
> > > > > > Fixes: f4b618360e ("colo-compare: add TCP, UDP, ICMP packet
> > > > > > comparison")
> > > > > > Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > > > > Cc: Cameron Esfahani <dirty@apple.com>
> > > > > > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > > > > > ---
> > > > > >  net/colo-compare.c    | 42 ++++++++++++++++++++++-------------=
--
> -----
> > > > > >  net/filter-rewriter.c | 10 ++++++++--
> > > > > >  net/trace-events      |  2 --
> > > > > >  3 files changed, 30 insertions(+), 24 deletions(-)
> > > >
> > > >
> > > > > >
> (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)
> > > > > > )
> > > > > > {
> > > > > > +    if
> > > > > > +
> (trace_event_get_state_backends(TRACE_COLO_COMPARE_IP_INFO))
> > > > > > {
> > > > > >          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20],
> > > > > > sec_ip_dst[20];
> > > > > >
> > > > > >          strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src)); @@
> > > > > > -492,12 +494,12 @@ sec:
> > > > > >          g_queue_push_head(&conn->primary_list, ppkt);
> > > > > >          g_queue_push_head(&conn->secondary_list, spkt);
> > > > > >
> > > > > > -        if
> > > > > >
> (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)
> > > > > > )
> > > > > > {
> > > > > > -            qemu_hexdump((char *)ppkt->data, stderr,
> > > > > > -                        "colo-compare ppkt", ppkt->size);
> > > > > > -            qemu_hexdump((char *)spkt->data, stderr,
> > > > > > -                        "colo-compare spkt", spkt->size);
> > > > > > -        }
> > > > > > +#ifdef DEBUG_COLO_PACKETS
> > > > > > +        qemu_hexdump((char *)ppkt->data, stderr,
> > > > > > +                     "colo-compare ppkt", ppkt->size);
> > > > > > +        qemu_hexdump((char *)spkt->data, stderr,
> > > > > > +                     "colo-compare spkt", spkt->size); #endif
> > > > > >
> > > > > >          colo_compare_inconsistency_notify(s);
> > > > > >      }
> > > > > > @@ -533,12 +535,12 @@ static int
> > > > > > colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
> > > > > >                                      ppkt->size - offset)) {
> > > > > >          trace_colo_compare_udp_miscompare("primary pkt size",
> ppkt->size);
> > > > > >          trace_colo_compare_udp_miscompare("Secondary pkt
> > > > > > size", spkt-
> > > > > > >size);
> > > > > > -        if
> > > > > >
> (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)
> > > > > > )
> > > > > > {
> > > > > > -            qemu_hexdump((char *)ppkt->data, stderr, "colo-com=
pare
> pri pkt",
> > > > > > -                         ppkt->size);
> > > > > > -            qemu_hexdump((char *)spkt->data, stderr, "colo-com=
pare
> sec pkt",
> > > > > > -                         spkt->size);
> > > > > > -        }
> > > > > > +#ifdef DEBUG_COLO_PACKETS
> > > > > > +        qemu_hexdump((char *)ppkt->data, stderr, "colo-compare=
 pri
> pkt",
> > > > > > +                     ppkt->size);
> > > > > > +        qemu_hexdump((char *)spkt->data, stderr, "colo-compare
> sec pkt",
> > > > > > +                     spkt->size); #endif
> > > > >
> > > > > Hi Roman,
> > > > >
> > > > > I think change the " trace_event_get_state_backends()" to
> > > > > "trace_colo_compare_main("Dump packet hex: ")" is a better choice
> here.
> > > > > It will keep the original code logic and avoid the problem here.
> > > >
> > > > That may workaround the immediate bug, but this is still a misuse
> > > > of the tracing code. Use of any trace point should only trigger
> > > > actions in the trace infrastructure.
> > > >
> > > > If I'm using dtrace backend to monitor events I don't want to see
> > > > QEMU dumping stuff to stderr. Anything written to stderr is going
> > > > to trigger disk I/O writing to the VM's logfile, and is also
> > > > liable to trigger rate limiting which can impact the guest performa=
nce.
> > > >
> > >
> > > Hi Daniel, Chen, Stefan,
> > >
> > > So, what do we want to do about the series? Do we have an agreement?
> > > Is the patch okay or I should make a change?
> >
> > I think your current patch here should be merged as is, as it is
> > removing the mis-use of the trace infrastructure.
>=20
> Hi Zhang Chen,
> Do you agree?

It's OK for me.

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

>=20
> Thanks,
> Stefan

