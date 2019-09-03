Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5EEC3A5A6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 03:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01199214AE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 03:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01199214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4zZZ-0005Ee-6u
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 23:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1i4zYd-0004oU-0Z
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 23:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1i4zYa-0007Ji-PD
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 23:32:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:41539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1i4zYa-0007Hn-Fo
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 23:32:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Sep 2019 20:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,461,1559545200"; d="scan'208";a="211847776"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2019 20:32:32 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 20:32:32 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 20:32:32 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.113]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.132]) with mapi id 14.03.0439.000;
 Tue, 3 Sep 2019 11:32:30 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Thread-Topic: [PATCH v2 2/3] net/filter.c: Add Options to insert filters
 anywhere in the filter list
Thread-Index: AQHVU5oiMguPMz5nEE2bcmsx0goHsqcIGSaw//+vhICAEJH/MP//9s2AgAEWQ1A=
Date: Tue, 3 Sep 2019 03:32:29 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78062526EA@shsmsx102.ccr.corp.intel.com>
References: <cover.1565894837.git.lukasstraub2@web.de>
 <6643a807a5f4c5ceb2f09e0718e97e5f968577f7.1565894837.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D780622D3DC@shsmsx102.ccr.corp.intel.com>
 <20190823082125.499095d7@luklap>
 <9CFF81C0F6B98A43A459C9EDAD400D78062507FD@shsmsx102.ccr.corp.intel.com>
 <20190902205111.7917db23@luklap>
In-Reply-To: <20190902205111.7917db23@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzVjNDUyODktYWUxNi00ZmUwLWEyNDQtMmVmMDJkMTM2NTM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWVVvS2dsN0JtdzVKXC9RRDhVVTJyZVFKSERWWkZ3V2ZqUWNrVHJEYW9veTZWMlZXMHRXXC9DYW04Nk80VXhRd1F1In0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH v2 2/3] net/filter.c: Add Options to insert
 filters anywhere in the filter list
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
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Tuesday, September 3, 2019 2:51 AM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: qemu-devel <qemu-devel@nongnu.org>; Jason Wang
> <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> Xie Changlong <xiechanglong.d@gmail.com>
> Subject: Re: [PATCH v2 2/3] net/filter.c: Add Options to insert filters
> anywhere in the filter list
>=20
> On Mon, 2 Sep 2019 11:43:57 +0000
> "Zhang, Chen" <chen.zhang@intel.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Lukas Straub <lukasstraub2@web.de>
> > > Sent: Friday, August 23, 2019 2:21 PM
> > > To: Zhang, Chen <chen.zhang@intel.com>
> > > Cc: qemu-devel <qemu-devel@nongnu.org>; Jason Wang
> > > <jasowang@redhat.com>; Wen Congyang
> <wencongyang2@huawei.com>; Xie
> > > Changlong <xiechanglong.d@gmail.com>
> > > Subject: Re: [PATCH v2 2/3] net/filter.c: Add Options to insert
> > > filters anywhere in the filter list
> > >
> > > On Fri, 23 Aug 2019 03:24:02 +0000
> > > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Lukas Straub [mailto:lukasstraub2@web.de]
> > > > > Sent: Friday, August 16, 2019 2:49 AM
> > > > > To: qemu-devel <qemu-devel@nongnu.org>
> > > > > Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> > > > > <jasowang@redhat.com>; Wen Congyang
> > > <wencongyang2@huawei.com>; Xie
> > > > > Changlong <xiechanglong.d@gmail.com>
> > > > > Subject: [PATCH v2 2/3] net/filter.c: Add Options to insert
> > > > > filters anywhere in the filter list
> > > > >
> > > > > To switch the Secondary to Primary, we need to insert new
> > > > > filters before the filter-rewriter.
> > > > >
> > > > > Add the options insert=3D and position=3D to be able to insert
> > > > > filters anywhere in the filter list.
> > > > >
> > > > > position should be either "head", "tail" or the id of another fil=
ter.
> > > > > insert should be either "before" or "after" to specify where to
> > > > > insert the new filter relative to the one specified with position=
.
> > > > >
> > > >
> > > > Hi Lukas,
> > > >
> > > > It looks no need to add the "insert =3D xxx" for this operation.
> > > > For example:
> > > >
> > > > We have 3 net-filters, the running order like that:
> > > >
> > > > Fiter1   ---------->   Filter2 ------------> Filter3
> > > >
> > > > If we want to add another filter between filter1 and filter2.
> > > > The "Position =3D head, insert =3D after" always seam with "positio=
n =3D
> > > > filter2 id,
> > > insert =3D before".
> > >
> > > Hi Zhang,
> > > The insert=3D parameter is ignored if position=3Dhead or tail. It alw=
ays
> > > Inserts at the head (before Filter1) or the tail (after Filter3) of t=
he List in
> these cases.
> > >
> > > > It seems the "insert" is a redundant args.
> > > > So I think it is enough with the "position", we can make the
> > > > "insert" always
> > > equal "after" except the "head".
> > >
> > > Yes, we still could do it without it, but its more convenient with
> > > the insert=3D parameter. For example our Case with inserting before t=
he
> rewriter:
> > >
> > > 'filter-mirror', 'id': 'm0', 'props': { 'insert': 'before', 'position=
': 'rew0',
> 'netdev':
> > > 'hn0', 'queue': 'tx', 'outdev': 'mirror0' } 'filter-redirector', 'id'=
: 'redire0',
> 'props':
> > > { 'insert': 'before', 'position': 'rew0', 'netdev': 'hn0', 'queue': '=
rx', 'indev':
> > > 'compare_out' } 'filter-redirector', 'id': 'redire1', 'props': {
> > > 'insert': 'before',
> > > 'position': 'rew0', 'netdev': 'hn0', 'queue': 'rx', 'outdev':
> > > 'compare0' }
> > >
> > > You see directly that here 3 Filters are inserted before the rewriter=
.
> > >
> > > would have to become:
> > >
> > > 'filter-mirror', 'id': 'm0', 'props': { 'position': 'head',
> > > 'netdev': 'hn0', 'queue': 'tx',
> > > 'outdev': 'mirror0' } 'filter-redirector', 'id': 'redire0', 'props':
> > > { 'position': 'm0',
> > > 'netdev': 'hn0', 'queue': 'rx', 'indev': 'compare_out' } 'filter-redi=
rector', 'id':
> > > 'redire1', 'props': { 'position': 'redire0', 'netdev': 'hn0', 'queue'=
: 'rx',
> 'outdev':
> > > 'compare0' }
> > >
> > > Which is less obvious.
> >
> > OK, It is fine for me.
> > But in the code have some other issues like that:
> >
> > +
> > +static void netfilter_set_insert(Object *obj, const char *str, Error
> > +**errp) {
> > +    NetFilterState *nf =3D NETFILTER(obj);
> > +
> > +    if (strcmp(str, "before") && strcmp(str, "after")) {
> > +        error_setg(errp, "Invalid value for netfilter insert, "
> > +                         "should be 'head' or 'tail'");               =
                   ----------------------
> ---------->>> I think you should change the "head/tail"  to "before/after=
".
>=20
> Oops, that was a typo.
>=20
> > +        return;
> > +    }
> > +
> > +    nf->insert_before =3D !strcmp(str, "before"); }
> >
> >
> > And I think the "front/behind" is better than "before/after" in this st=
atus.
> > At the same time the name of the "insert_before" change to "front_flag"=
 is
> better.
>=20
> What I like about the "before" is that it sounds more like an English sen=
tence.
> insert: before, position: rew0
> vs.
> insert: front, position: rew0
>=20
> But I agree, "behind" is more clear than "after".
>=20
> What do you think about "first/last" instead of "head/tail"?

I'm not a English native speaker, but I think head/tail is enough same as t=
he QTAILQ.

Thanks
Zhang Chen

>=20
> Regards,
> Lukas Straub
>=20
> >
> > Thanks
> > Zhang Chen
> >
> > >
> > > Regards,
> > > Lukas Straub
> > >
> > > >
> > > > Thanks
> > > > Zhang Chen
> > > >
> > > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > > ---
> > > > >  include/net/filter.h |  2 ++
> > > > >  net/filter.c         | 71
> > > +++++++++++++++++++++++++++++++++++++++++++-
> > > > >  qemu-options.hx      | 10 +++----
> > > > >  3 files changed, 77 insertions(+), 6 deletions(-)
> >


