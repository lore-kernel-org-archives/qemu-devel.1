Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F122BC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8B02245A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8B02245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF25Q-00036s-RX
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iF23G-0001W6-B7
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iF23E-0001qI-6h
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:13:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:51718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iF23D-0001pc-FQ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:13:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Sep 2019 13:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; d="scan'208";a="194303899"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga003.jf.intel.com with ESMTP; 30 Sep 2019 13:13:41 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 13:13:40 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 13:13:40 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.119]) with mapi id 14.03.0439.000;
 Tue, 1 Oct 2019 04:13:38 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH v5 3/4] net/filter.c: Add Options to insert filters
 anywhere in the filter list
Thread-Topic: [PATCH v5 3/4] net/filter.c: Add Options to insert filters
 anywhere in the filter list
Thread-Index: AQHVa/qhID4wVq1ufUOgz01/uZUmDKc+PZ9ggAI3wgCAAX5EQA==
Date: Mon, 30 Sep 2019 20:13:38 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780629560A@shsmsx102.ccr.corp.intel.com>
References: <cover.1568574478.git.lukasstraub2@web.de>
 <b4241e918682c83163857da3aaab5c14ec1c81f8.1568574478.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D780627E646@shsmsx102.ccr.corp.intel.com>
 <20190928124438.260668cf@luklap>
In-Reply-To: <20190928124438.260668cf@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzU4MWM3OTAtOTQyOC00NGNhLTg0OTUtZjRmODRhOWM4Yzc0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ1pjc0RZV0R2eHJGQThBbnpLTTQ3bTZTWmNUYjBUVFphVTJ6UVdvaDFWbzVMXC9ONTJLVWw1Q25cL2I4XC8xd1pKWiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
> Sent: Saturday, September 28, 2019 6:45 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: qemu-devel <qemu-devel@nongnu.org>; Jason Wang
> <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> Xie Changlong <xiechanglong.d@gmail.com>; kwolf@redhat.com;
> mreitz@redhat.com
> Subject: Re: [PATCH v5 3/4] net/filter.c: Add Options to insert filters
> anywhere in the filter list
>=20
> On Thu, 26 Sep 2019 17:02:58 +0000
> "Zhang, Chen" <chen.zhang@intel.com> wrote:
> > > diff --git a/qemu-options.hx b/qemu-options.hx index
> > > 08749a3391..23fa5a344e 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -4368,7 +4368,7 @@ applications, they can do this through this
> > > parameter. Its format is  a gnutls priority string as described at
> > > @url{https://gnutls.org/manual/html_node/Priority-Strings.html}.
> > >
> > > -@item -object filter-
> > >
> buffer,id=3D@var{id},netdev=3D@var{netdevid},interval=3D@var{t}[,queue=3D=
@va
> > > r{
> > > all|rx|tx}][,status=3D@var{on|off}]
> > > +@item -object
> > > +filter-buffer,id=3D@var{id},netdev=3D@var{netdevid},interval=3D@var{=
t}[,q
> > > +ueue
> > > +=3D@var{all|rx|tx}][,status=3D@var{on|off}][,position=3D@var{head|ta=
il|id
> > > +=3D<id
> > > +>}][,insert=3D@var{behind|before}]
> > >
> > >  Interval @var{t} can't be 0, this filter batches the packet
> > > delivery: all  packets arriving in a given interval on netdev
> > > @var{netdevid} are delayed @@ -
> > > 4387,11 +4387,11 @@ queue @var{all|rx|tx} is an option that can be
> > > applied to any netfilter.
> > >  @option{tx}: the filter is attached to the transmit queue of the net=
dev,
> > >               where it will receive packets sent by the netdev.
> > >
> > > -@item -object filter-
> > >
> mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=3D@var{chardevid},que=
u
> > > e
> > > =3D@var{all|rx|tx}[,vnet_hdr_support]
> > > +@item -object
> > > +filter-
> mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=3D@var{chardev
> > > +id},
> > > +queue=3D@var{all|rx|tx}[,vnet_hdr_support][,position=3D@var{head|tai=
l|i
> > > +d=3D<
> > > i
> > > +d>}][,insert=3D@var{behind|before}]
> > >
> > >  filter-mirror on netdev @var{netdevid},mirror net packet to
> > > chardev@var{chardevid}, if it has the vnet_hdr_support flag,
> > > filter-mirror will mirror packet with vnet_hdr_len.
> > >
> >
> > Please add description for the newly added parameter in each filter.
> > After that:
> > Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> >
> > Thanks
> > Zhang Chen
>=20
> Hi,
> I will add a single description like its currently done with the "queue" =
option,
> noting that it applies to any netfilter. Is that Ok?

It is enough for me.

Thanks
Zhang Chen

>=20
> Regards,
> Lukas Straub
>=20
> >
> > > -@item -object filter-
> > >
> redirector,id=3D@var{id},netdev=3D@var{netdevid},indev=3D@var{chardevid},=
o
> > > ut dev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support]
> > > +@item -object
> > > +filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},indev=3D@var=
{char
> > > +devi
> > >
> +d},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support][
> > > +,p
> > > os
> > > +ition=3D@var{head|tail|id=3D<id>}][,insert=3D@var{behind|before}]
> > >
> > >  filter-redirector on netdev @var{netdevid},redirect filter's net
> > > packet to chardev  @var{chardevid},and redirect indev's packet to
> > > filter.if it has the vnet_hdr_support flag, @@ -4400,7 +4400,7 @@
> > > Create a filter-redirector we need to differ outdev id from indev
> > > id, id can not  be the same. we can just use indev or outdev, but at
> > > least one of indev or outdev  need to be specified.
> > >
> > > -@item -object filter-
> > > rewriter,id=3D@var{id},netdev=3D@var{netdevid},queue=3D@var{all|rx|tx=
},[vn
> > > et_
> > > hdr_support]
> > > +@item -object
> > > +filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},queue=3D@var{a=
ll|rx
> > > +|tx}
> > > +,[vnet_hdr_support][,position=3D@var{head|tail|id=3D<id>}][,insert=
=3D@var
> > > +{beh
> > > +ind|before}]
> > >
> > >  Filter-rewriter is a part of COLO project.It will rewrite tcp
> > > packet to secondary from primary to keep secondary tcp
> > > connection,and rewrite @@ -
> > > 4413,7 +4413,7 @@ colo secondary:
> > >  -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dr=
ed1
> > >  -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall
> > >
> > > -@item -object filter-
> > >
> dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{filename}][,maxlen=3D@=
var
> > > {
> > > len}]
> > > +@item -object
> > > +filter-
> > > dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{filename}][,maxlen=
=3D
> > > +@var{len}][,position=3D@var{head|tail|id=3D<id>}][,insert=3D@var{beh=
ind|b
> > > +efor
> > > +e}]
> > >
> > >  Dump the network traffic on netdev @var{dev} to the file specified
> > > by @var{filename}. At most @var{len} bytes (64k by default) per
> > > packet are stored.
> > > --
> > > 2.20.1
> >


