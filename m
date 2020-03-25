Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC83FC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 04:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D76820714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 04:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9bu42ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D76820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGxU6-0003bC-Kq
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 00:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jwsu1986@gmail.com>) id 1jGxTQ-0002tM-AT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 00:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jwsu1986@gmail.com>) id 1jGxTO-0007sV-P4
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 00:17:00 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jwsu1986@gmail.com>) id 1jGxTO-0007qM-I3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 00:16:58 -0400
Received: by mail-oi1-x244.google.com with SMTP id v134so885775oie.11
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 21:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=P9peLJg3RJ8JrN3DxdGT7YG3Eyj/9rNwnEN7wEwLd+k=;
 b=g9bu42iccoq40NyxlP/NhBdBpdnjFqo+o21x7rv3wbJIYj3pDZuKgSQqDaDuwxmBDs
 g8jjYh7ve1w6t9JVpdrJbjNm74fBUCijjiDs2Lc7Vp5+RU8ENtSHH4WA7sZbSsmj8Hu4
 Ell3W2IK0YAl4N8AyO6UzBwyIcMX60jiJkAJfnKdwOrDxhBs64aDZpWfbml70vtZRbxa
 jD5JA0YBRTds/MUqRNNMb85b+KFNOjH34jghaNR84lAo/nHIDf//wZp109zvH2pO9Jnj
 YnJCni27I2OxrWxFfKpZ2mbsIFjxWOxUjHeOGpTQ57GFhH7EO0F0LsuHAdpt5MXolCao
 GncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P9peLJg3RJ8JrN3DxdGT7YG3Eyj/9rNwnEN7wEwLd+k=;
 b=ancwur1koJ37YiK1NYW2BCax4h5p01M7CKu65ZIQqNBXJPC1+Z0Rr/rwWMx3HngrC5
 jQP+e6DTfO6MyIMNKHWqOa87yc4QBNCQuq1hELok+XcnTrvuti1JQfDApqDhv57KjjzM
 uoPonzrtmfsH7c1Y0MQcNndA4pp3Z1SDWW20REpatjnyLUVFegOyE1K6s9dNj3E04fh4
 U1MR+XtUyAI7gQFM3zV3lkHqt2VasCIZIY/FNw8sppdD4oZMdm3KWie+8gJ79fNQEqa/
 emLrRfiue6zHOjzNKUzz5JH8AfDJSufbIiAaQl4JcDxXB9k+1UdGbfdxfe5yyeP1pfJb
 GHqA==
X-Gm-Message-State: ANhLgQ0rt0hW9ocbl4s4CdfaL+zKtqfXApq/+XzjYjfs8RZ9zNpbcGRC
 bkvKLJO65nrQzJJKMuKwYwpFBRdwofCzLloZGTs=
X-Google-Smtp-Source: ADFU+vsOz1nOI+HkjW74Lx5Ysy/wtg0Klv53Z9CnJEmYnALvJMM/MHoSaD7iiuW6gePe0UoedbYtTMKF6onjSuVFc9w=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr1184706oig.39.1585109817050; 
 Tue, 24 Mar 2020 21:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200322174751.12559-1-dereksu@qnap.com>
 <20200322174751.12559-2-dereksu@qnap.com>
 <883bf4e2916f43baa6700f98bbb85523@intel.com>
 <CAFKS8hUJ34Qh7gsggtbVM6GU4hLEn_xBLFM7X5mQrsmQg-Yc7w@mail.gmail.com>
 <2046ed570c754e25ae2b8d5c6c48de2f@intel.com>
 <CAFKS8hXUTYxsHsTgh5cntHL3hMyp-9q9B53d110VipF2BR8_Hg@mail.gmail.com>
In-Reply-To: <CAFKS8hXUTYxsHsTgh5cntHL3hMyp-9q9B53d110VipF2BR8_Hg@mail.gmail.com>
From: Derek Su <jwsu1986@gmail.com>
Date: Wed, 25 Mar 2020 12:16:46 +0800
Message-ID: <CAFKS8hVA45jTVGTGtGrHKJJcXJsT2uaJ4yxs_60fRtqvG_xzyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "dereksu@qnap.com" <dereksu@qnap.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jing-Wei Su <jwsu1986@gmail.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=8825=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:37=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> >
> >
> > > -----Original Message-----
> > > From: Jing-Wei Su <jwsu1986@gmail.com>
> > > Sent: Tuesday, March 24, 2020 10:47 AM
> > > To: Zhang, Chen <chen.zhang@intel.com>
> > > Cc: qemu-devel@nongnu.org; lizhijian@cn.fujitsu.com;
> > > jasowang@redhat.com; dereksu@qnap.com
> > > Subject: Re: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
> > > packet_enqueue()
> > >
> > > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=882=
4=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:24
> > > =E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Derek Su <jwsu1986@gmail.com>
> > > > > Sent: Monday, March 23, 2020 1:48 AM
> > > > > To: qemu-devel@nongnu.org
> > > > > Cc: Zhang, Chen <chen.zhang@intel.com>; lizhijian@cn.fujitsu.com;
> > > > > jasowang@redhat.com; dereksu@qnap.com
> > > > > Subject: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
> > > > > packet_enqueue()
> > > > >
> > > > > The patch is to fix the "pkt" memory leak in packet_enqueue().
> > > > > The allocated "pkt" needs to be freed if the colo compare primary=
 or
> > > > > secondary queue is too big.
> > > >
> > > > Hi Derek,
> > > >
> > > > Thank you for the patch.
> > > > I re-think this issue in a big view, looks just free the pkg is not=
 enough in
> > > this situation.
> > > > The root cause is network is too busy to compare, So, better choice=
 is
> > > > notify COLO frame to do a checkpoint and clean up all the network
> > > > queue. This work maybe decrease COLO network performance but seams
> > > better than drop lots of pkg.
> > > >
> > > > Thanks
> > > > Zhang Chen
> > > >
> > >
> > > Hello, Zhang
> > >
> > > Got it.
> > > What is the concern of the massive "drop packets"?
> > > Does the behavior make the COLO do checkpoint periodically (~20 secon=
ds)
> > > instead of doing immediate checkpoint when encountering different
> > > response packets?
> >
> > The concern of the "drop packets" is guest will lose network connection=
 with
> > most of real clients until next periodic force checkpoint. COLO designe=
d for dynamic
> > control checkpoint, so I think do a checkpoint here will help guest sup=
ply service faster.
> >
>
> I see.
> I'll update the patch with your suggestion later.
>

Hi, Zhang
Here is the idea and pseudo code to handle the "drop packet".

```
ret =3D packet_enqueue
(1) ret =3D=3D 0
      compare connection
(2) ret =3D=3D -1
      send packet
(3) ret =3D=3D queue insertion fail
      do checkpoint
      send all queued primary packets
      remove all queued secondary packets
```

Do you have any comment for the handling?

Thanks
Derek

> > >
> > > It seems that frequent checkpoints caused by the full queue (busy
> > > network) instead of different
> > > response packets may harm the high speed network (10 Gbps or higher)
> > > performance dramatically.
> >
> > Yes, maybe I can send a patch to make user adjust queue size depend on =
it's own environment.
> > But with larger queue size, colo-compare will spend much time to do com=
pare packet when network
> > Is real busy status.
>
> Thank you. The user-configurable queue size will be very helpful.
>
> Thanks.
> Derek Su
>
> >
> > Thanks
> > Zhang Chen
> >
> > >
> > > Thanks
> > > Derek
> > >
> > > > >
> > > > > Signed-off-by: Derek Su <dereksu@qnap.com>
> > > > > ---
> > > > >  net/colo-compare.c | 23 +++++++++++++++--------
> > > > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > > > > 7ee17f2cf8..cdd87b2aa8 100644
> > > > > --- a/net/colo-compare.c
> > > > > +++ b/net/colo-compare.c
> > > > > @@ -120,6 +120,10 @@ enum {
> > > > >      SECONDARY_IN,
> > > > >  };
> > > > >
> > > > > +static const char *colo_mode[] =3D {
> > > > > +    [PRIMARY_IN] =3D "primary",
> > > > > +    [SECONDARY_IN] =3D "secondary",
> > > > > +};
> > > > >
> > > > >  static int compare_chr_send(CompareState *s,
> > > > >                              const uint8_t *buf, @@ -215,6 +219,7=
 @@
> > > > > static int packet_enqueue(CompareState *s, int mode, Connection
> > > **con)
> > > > >      ConnectionKey key;
> > > > >      Packet *pkt =3D NULL;
> > > > >      Connection *conn;
> > > > > +    int ret;
> > > > >
> > > > >      if (mode =3D=3D PRIMARY_IN) {
> > > > >          pkt =3D packet_new(s->pri_rs.buf, @@ -243,16 +248,18 @@
> > > > > static int packet_enqueue(CompareState *s, int mode, Connection
> > > **con)
> > > > >      }
> > > > >
> > > > >      if (mode =3D=3D PRIMARY_IN) {
> > > > > -        if (!colo_insert_packet(&conn->primary_list, pkt, &conn-=
>pack)) {
> > > > > -            error_report("colo compare primary queue size too bi=
g,"
> > > > > -                         "drop packet");
> > > > > -        }
> > > > > +        ret =3D colo_insert_packet(&conn->primary_list, pkt,
> > > > > + &conn->pack);
> > > > >      } else {
> > > > > -        if (!colo_insert_packet(&conn->secondary_list, pkt, &con=
n->sack)) {
> > > > > -            error_report("colo compare secondary queue size too =
big,"
> > > > > -                         "drop packet");
> > > > > -        }
> > > > > +        ret =3D colo_insert_packet(&conn->secondary_list, pkt,
> > > > > + &conn->sack);
> > > > >      }
> > > > > +
> > > > > +    if (!ret) {
> > > > > +        error_report("colo compare %s queue size too big,"
> > > > > +                     "drop packet", colo_mode[mode]);
> > > > > +        packet_destroy(pkt, NULL);
> > > > > +        pkt =3D NULL;
> > > > > +    }
> > > > > +
> > > > >      *con =3D conn;
> > > > >
> > > > >      return 0;
> > > > > --
> > > > > 2.17.1
> > > >

