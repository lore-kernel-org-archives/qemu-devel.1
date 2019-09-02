Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2BDC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 18:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EDE21883
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 18:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="KEZjNGNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EDE21883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4rUx-0003ZP-MK
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 14:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i4rQP-0002Rh-OF
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 14:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i4rQO-0007Mx-FH
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 14:51:37 -0400
Received: from mout.web.de ([212.227.15.4]:59127)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i4rQO-0007JQ-1u
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 14:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1567450275;
 bh=k5gVFPMbDR8yNC8B0/6ktnPk5lBiko7KOvJzqFH9BFs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=KEZjNGNZDPJSpZLaH6YzblitaYOA6GUM/HuDBp4ArBxrw2xpfkon/4UM+Gzw2fz57
 KtWZg6XpB0RSvSbiFxXcZ4a5NXyDp4rc1r+v2mfJLdzMlSTlbgY8KaxcrzyLiDzYJM
 iMjjpYMwrD7mWcLDWWt4qbgYYQIa+tBXxAL5DrRk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.43]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK2JZ-1i3TyY0WAP-001NJJ; Mon, 02
 Sep 2019 20:51:15 +0200
Date: Mon, 2 Sep 2019 20:51:11 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <20190902205111.7917db23@luklap>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D78062507FD@shsmsx102.ccr.corp.intel.com>
References: <cover.1565894837.git.lukasstraub2@web.de>
 <6643a807a5f4c5ceb2f09e0718e97e5f968577f7.1565894837.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D780622D3DC@shsmsx102.ccr.corp.intel.com>
 <20190823082125.499095d7@luklap>
 <9CFF81C0F6B98A43A459C9EDAD400D78062507FD@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wP4q/HjCk38VyHmGnhNDLR8AIXEvYBU27J87hBwsIsMEGcf4+Eh
 m92Dx7pyXPcJzBkI27h0vck3g+hMyCyrpvVDoeyPUxdWxxCyJGsGr45M3Tt9/w5ubZcMEpI
 phWHWOIFWJ0iOMMYttl5zCFGHv3au7WwZLItDi6Rl0yx6E8hDvlMlTKNpfCUsCRAybylxVg
 3DM3efj5boIuI+2w8EDIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CwUcLTApZG0=:6dAxHy2JFoh3KJ1y/IzG56
 d3WC5qlPpO72bg9hsLGGsjNYeuRFvqKDgYF2jgHPx5YrNxRE4gdLF13ymmenTcVct6DqYcHpk
 1KC539mQcbSKkqnceir+BPNObumlxasFKKEmmLwR+ehNcr4CPVdSaDcO6aYHmTLRgC7wNnMVj
 8OVkdfzdf+4eB10CT84muBj1iq+e7jDA+MG7A8BV8mNn8cA4rftBfKZuuuuiw8LT2En7VKSrM
 WWZlgK1k/Rfe9pPymU+W55fq31OdXTYenAd8VBIILxGTYUw4yZbpicMg8Cv22dY7dsjQ7HWye
 85DJ+ydNZS/TnM1HV+MtKnMQyIjaFjp4qM8eSxeiFsWc0ljBhXP4v3uE8/2o8IGbGHSzzPt60
 7aDGHM+7+W1fXv7/a9lovMmXvXlNBxMKYVotSljzCXi+YNdC+yoK/dqPPTHIVcPbM7eLZiipX
 3sGbGJCoJIxEUlgb5xr19G9GRO2vGy6Uv9maNT3ZwBDbwGNP2fuZKgSuanviaD3xOViF2tVE7
 gYdTzImfTrOBMZpu2ExH0Rbib7MlS8+pvR2hjklzENu6h95aBOsEd9SOruOqyd7oyJtGNPmtn
 NZKHeuqRrExxUy0vxfNgCgHIzCi4UcEsSUdkE6fwRCyyHqiycBPs1D/DYSZs1H98DFg+5egPM
 gOtcH1Uhf3Uzm8ougzbRYv1xh7yOv32iCwxOHGiHeqa5XjysdbCSY4GhkatNK56zfBsgYHlMr
 jh90PUyZcXcCKqanmgOm/4M+/aMwvBsM+aB4VIYXIrN4iER1Do2U1sjRklaCc4zXjuYdMEAWJ
 iJDzT1cqm1iPTjLDxuCaElpdmA0esIMlRcnrmbWwnysMtAYVNpLxn5xsYs7GkY4GG08qNd6zV
 +ZD8x/l5DwIbytFRdy8P0OZnhZxeaOb/Ykdg4RQLLIlTybTW+EG/xjGY4hXXcoQSAh0YyB9OD
 ZPKZeBK9oD6C5XDwpRNAStfsbbjH94DOOz+6gOrU8y2Fm4e8NSzFKAAksN116LePmLNdRExKe
 I5veri3sDu80aHWlcn3jV5o3D1uop/lXzPZk49SRdTX/1gW8yAhjroLKbUtaWzJC5cDJdidpr
 iTLfBb7Xj+EZx09i7i/WMN6ZC+K4AQKoKf7DR4Zo4MSoPSxJx58z1KfY1w/vTGMKAiKrrr6Dg
 R8ywL+N3vxVH1MvbIcLimhtto0yyerFop9ShiJKHNoLIi7pg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
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

On Mon, 2 Sep 2019 11:43:57 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Friday, August 23, 2019 2:21 PM
> > To: Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-devel <qemu-devel@nongnu.org>; Jason Wang
> > <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> > Xie Changlong <xiechanglong.d@gmail.com>
> > Subject: Re: [PATCH v2 2/3] net/filter.c: Add Options to insert filter=
s
> > anywhere in the filter list
> >
> > On Fri, 23 Aug 2019 03:24:02 +0000
> > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> >
> > > > -----Original Message-----
> > > > From: Lukas Straub [mailto:lukasstraub2@web.de]
> > > > Sent: Friday, August 16, 2019 2:49 AM
> > > > To: qemu-devel <qemu-devel@nongnu.org>
> > > > Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> > > > <jasowang@redhat.com>; Wen Congyang
> > <wencongyang2@huawei.com>; Xie
> > > > Changlong <xiechanglong.d@gmail.com>
> > > > Subject: [PATCH v2 2/3] net/filter.c: Add Options to insert filter=
s
> > > > anywhere in the filter list
> > > >
> > > > To switch the Secondary to Primary, we need to insert new filters
> > > > before the filter-rewriter.
> > > >
> > > > Add the options insert=3D and position=3D to be able to insert fil=
ters
> > > > anywhere in the filter list.
> > > >
> > > > position should be either "head", "tail" or the id of another filt=
er.
> > > > insert should be either "before" or "after" to specify where to
> > > > insert the new filter relative to the one specified with position.
> > > >
> > >
> > > Hi Lukas,
> > >
> > > It looks no need to add the "insert =3D xxx" for this operation.
> > > For example:
> > >
> > > We have 3 net-filters, the running order like that:
> > >
> > > Fiter1   ---------->   Filter2 ------------> Filter3
> > >
> > > If we want to add another filter between filter1 and filter2.
> > > The "Position =3D head, insert =3D after" always seam with "position=
 =3D filter2 id,
> > insert =3D before".
> >
> > Hi Zhang,
> > The insert=3D parameter is ignored if position=3Dhead or tail. It alwa=
ys Inserts at
> > the head (before Filter1) or the tail (after Filter3) of the List in t=
hese cases.
> >
> > > It seems the "insert" is a redundant args.
> > > So I think it is enough with the "position", we can make the "insert=
" always
> > equal "after" except the "head".
> >
> > Yes, we still could do it without it, but its more convenient with the=
 insert=3D
> > parameter. For example our Case with inserting before the rewriter:
> >
> > 'filter-mirror', 'id': 'm0', 'props': { 'insert': 'before', 'position'=
: 'rew0', 'netdev':
> > 'hn0', 'queue': 'tx', 'outdev': 'mirror0' } 'filter-redirector', 'id':=
 'redire0', 'props':
> > { 'insert': 'before', 'position': 'rew0', 'netdev': 'hn0', 'queue': 'r=
x', 'indev':
> > 'compare_out' } 'filter-redirector', 'id': 'redire1', 'props': { 'inse=
rt': 'before',
> > 'position': 'rew0', 'netdev': 'hn0', 'queue': 'rx', 'outdev': 'compare=
0' }
> >
> > You see directly that here 3 Filters are inserted before the rewriter.
> >
> > would have to become:
> >
> > 'filter-mirror', 'id': 'm0', 'props': { 'position': 'head', 'netdev': =
'hn0', 'queue': 'tx',
> > 'outdev': 'mirror0' } 'filter-redirector', 'id': 'redire0', 'props': {=
 'position': 'm0',
> > 'netdev': 'hn0', 'queue': 'rx', 'indev': 'compare_out' } 'filter-redir=
ector', 'id':
> > 'redire1', 'props': { 'position': 'redire0', 'netdev': 'hn0', 'queue':=
 'rx', 'outdev':
> > 'compare0' }
> >
> > Which is less obvious.
>
> OK, It is fine for me.
> But in the code have some other issues like that:
>
> +
> +static void netfilter_set_insert(Object *obj, const char *str, Error **=
errp)
> +{
> +    NetFilterState *nf =3D NETFILTER(obj);
> +
> +    if (strcmp(str, "before") && strcmp(str, "after")) {
> +        error_setg(errp, "Invalid value for netfilter insert, "
> +                         "should be 'head' or 'tail'");                =
                  -------------------------------->>> I think you should c=
hange the "head/tail"  to "before/after".

Oops, that was a typo.

> +        return;
> +    }
> +
> +    nf->insert_before =3D !strcmp(str, "before");
> +}
>
>
> And I think the "front/behind" is better than "before/after" in this sta=
tus.
> At the same time the name of the "insert_before" change to "front_flag" =
is better.

What I like about the "before" is that it sounds more like an English sent=
ence.
insert: before, position: rew0
vs.
insert: front, position: rew0

But I agree, "behind" is more clear than "after".

What do you think about "first/last" instead of "head/tail"?

Regards,
Lukas Straub

>
> Thanks
> Zhang Chen
>
> >
> > Regards,
> > Lukas Straub
> >
> > >
> > > Thanks
> > > Zhang Chen
> > >
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > ---
> > > >  include/net/filter.h |  2 ++
> > > >  net/filter.c         | 71
> > +++++++++++++++++++++++++++++++++++++++++++-
> > > >  qemu-options.hx      | 10 +++----
> > > >  3 files changed, 77 insertions(+), 6 deletions(-)
>


