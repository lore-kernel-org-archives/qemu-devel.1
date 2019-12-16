Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C274BC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479BD206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGsqL2xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479BD206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoqB-0007DS-34
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casantos@redhat.com>) id 1igoQ3-0004Az-HM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casantos@redhat.com>) id 1igoQ1-0005tB-5S
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:20:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casantos@redhat.com>) id 1igoQ1-0005s3-24
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576495204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SwVQyMNgT9brotGcPSbpIjdQx/mOH7JomHgYrqLzAgg=;
 b=fGsqL2xwBxULgsQy/TVS6Ja+IhpH0hEwt67OIYNVwApPjZ+pFxfY3b7LXuwrb0gSmbtiQQ
 GypB1j8nHm5KsMTXeKoxse74YKn79mNpW72H7cZKavHqhle+sfrG3oY5/WW6TD+CWzvSmU
 cag6iODtprXlWu9pjuWL8up0RnYZugA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-LD1Q8AEUMca65k-uYvMsqQ-1; Mon, 16 Dec 2019 06:18:54 -0500
Received: by mail-io1-f71.google.com with SMTP id 144so5565269iou.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ycBHJBI9wGDoE2EYN/FzIsq5URCJeuHo4YVPgCGnQvQ=;
 b=J7pvxgTgTbUTmZwRINyM1528z7HLM060O5Ib4Gl9EI82dZQ2ODEHqs5Z1LBci1l8Ui
 vFZYPIx/KdS8FxaMS4yCJvJ66i4bjKT+SpTMM0iAbpDlgTdVePZ28fZdK5QDbX0DaHib
 XKJRFf82u4sRGXZkw8m3vXMH9LJFxcGOnRYAoAzdZ2A5WgAEUQnWKvVhAbj72LVpujAv
 fKrx8Lp2UQ+MYITR3EBnb/QFlR5O9ZQeq3U308oiVSN6oR9QATkLyVb11Yv5As9ehk2e
 Z8mDkdevX81JS9vpRPiIYGUoaiAwI1xnF5Pq7FZnZfokAiCi9AbBQ5M/wLysuU/IkxyE
 TITw==
X-Gm-Message-State: APjAAAWFcuawTuOJSB2Jg+MFl4S1Aq96s1woUQx8RsYztug1DL2ay7xb
 ODGY6krswV5m6A9Oq4GYvjU9fkukxpk2P0EuxLbCDs1gB0mDq3IFDCSaUMGksv1gqJbr/nFvnCg
 FIn5ia4FYt/IO0XfBmDxjd88WJlP7xRA=
X-Received: by 2002:a92:980f:: with SMTP id l15mr11217772ili.152.1576495133534; 
 Mon, 16 Dec 2019 03:18:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUWpK0a42HZVgUbF/nhmm6vAwHyMgAjiKKor6OXFhtVMDREpJXMW8UPID2y4gguav/GXTWdhRTSSn8Tm3Tvf0=
X-Received: by 2002:a92:980f:: with SMTP id l15mr11217767ili.152.1576495133376; 
 Mon, 16 Dec 2019 03:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20191017123713.30192-1-casantos@redhat.com>
 <CAFEAcA9dMRBtDs6QSXGVv_bNhtu5wnGKLvMxr2YuoWM=yomGDg@mail.gmail.com>
 <CAC1VKkNr8jN_0qVLtX5-YVH1dgN0fGAvnVZJXUpa+UfG_34ooQ@mail.gmail.com>
In-Reply-To: <CAC1VKkNr8jN_0qVLtX5-YVH1dgN0fGAvnVZJXUpa+UfG_34ooQ@mail.gmail.com>
From: Carlos Santos <casantos@redhat.com>
Date: Mon, 16 Dec 2019 08:18:42 -0300
Message-ID: <CAC1VKkPfacdLkXfHVNm-josjtds3Xsj=9NhRfNaQTyRv4XxEfQ@mail.gmail.com>
Subject: Re: [PATCH] util/cacheinfo: fix crash when compiling with uClibc
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: LD1Q8AEUMca65k-uYvMsqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 8:06 PM Carlos Santos <casantos@redhat.com> wrote:
>
> On Thu, Oct 17, 2019 at 9:47 AM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > On Thu, 17 Oct 2019 at 13:39, <casantos@redhat.com> wrote:
> > >
> > > From: Carlos Santos <casantos@redhat.com>
> > >
> > > uClibc defines _SC_LEVEL1_ICACHE_LINESIZE and _SC_LEVEL1_DCACHE_LINES=
IZE
> > > but the corresponding sysconf calls returns -1, which is a valid resu=
lt,
> > > meaning that the limit is indeterminate.
> > >
> > > Handle this situation using the fallback values instead of crashing d=
ue
> > > to an assertion failure.
> > >
> > > Signed-off-by: Carlos Santos <casantos@redhat.com>
> > > ---
> > >  util/cacheinfo.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> > > index ea6f3e99bf..d94dc6adc8 100644
> > > --- a/util/cacheinfo.c
> > > +++ b/util/cacheinfo.c
> > > @@ -93,10 +93,16 @@ static void sys_cache_info(int *isize, int *dsize=
)
> > >  static void sys_cache_info(int *isize, int *dsize)
> > >  {
> > >  # ifdef _SC_LEVEL1_ICACHE_LINESIZE
> > > -    *isize =3D sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
> > > +    int tmp_isize =3D (int) sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
> >
> > Do we need the cast here ?
>
> It's there to remind the reader that a type coercion may occur, since
> sysconf() returns a long and isize is an int.
>
> > > +    if (tmp_isize > 0) {
> > > +        *isize =3D tmp_isize;
> > > +    }
> > >  # endif
> > >  # ifdef _SC_LEVEL1_DCACHE_LINESIZE
> > > -    *dsize =3D sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
> > > +    int tmp_dsize =3D (int) sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
> > > +    if (tmp_dsize > 0) {
> > > +        *dsize =3D tmp_dsize;
> > > +    }
> > >  # endif
> > >  }
> > >  #endif /* sys_cache_info */
> > > --
> >
> > thanks
> > -- PMM
>
> --
> Carlos Santos
> Senior Software Maintenance Engineer
> Red Hat
> casantos@redhat.com    T: +55-11-3534-6186

Hi,

Any chance to have this merged for Christmas? :-)

--=20
Carlos Santos
Senior Software Maintenance Engineer
Red Hat
casantos@redhat.com    T: +55-11-3534-6186


