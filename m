Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ED7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EFF20723
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8S2uXZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EFF20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbNl-0006ej-6u
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdbMk-0005la-F3
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:19:42 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdbMj-0004Al-Mz
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:19:42 -0400
Received: by mail-lj1-x243.google.com with SMTP id z13so15319380ljn.7
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=otfnyISNPVrwLxJb4PLb1QKOTVBeqghLSbEcmk0rTDE=;
 b=r8S2uXZXFEKhO/OiAm1IKPwzgW9DNvg3z18uAz9PJnKBmI4W5pDOZCfg0yP1iUjf+R
 1c8fHI4dnAab37ovwXol+vr3LmUwQVr0495373A7nEhnv/mvku+WkPH6gV6kDNuhG5eU
 9EivQxCRfzNR55okKgMWgC5M+2T4MS6zmIOBVXjd+8kZZYEYADcMMmqocJyG+V90hXOM
 xdmpFVQQizhBKo4hGEiSXjGdXHPbyjkS8WkO1v481/2VR9kof8K5i2WCFW1B4F1bYMhk
 kgEf7HYq6DAFnYwXqRCzkP+wdySV0UPIa5wd1y+F/CgGdyz4dviH/Pr5ZwJstBtTPkmq
 6x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=otfnyISNPVrwLxJb4PLb1QKOTVBeqghLSbEcmk0rTDE=;
 b=ODHSKUvL+2Se/lXjpyc2QGNXWiMmlU0MtxeRXD3S3Ikquqo8kvw+52fGhb/YnB88bB
 tyqOgHPK2UsBG4PewzuUkyuUn8saAZnNaQCqUD2OTNDwEfnsH5ASlmXY3dNk1uzc5YdK
 dU4G3GZDagdh3AU/N6PhblH7dH2mP+fjyxebQIyTd0hbS0LWMliR8lukrlH6U0lGYZLS
 0e7hJSK/6f61WP30MQ0yr+CO4O9N24Xpzi1DlSclF2jSLqVOrNjMFpyWx0KjdvoAYZJc
 HW1Yy/O7EWH27sLtOACJ0KErNuM9lc9wniEYqetelpoi4+OQLCzhPeKsA13cMi7hKgwd
 6/Hg==
X-Gm-Message-State: AOAM532V4AD3N/lJ3YdZnjY1CtXMMkTe7DuYfnLMdWlU8HY5P6C/nvHY
 EkrGHXuRnYjlRF2LXIdMQ1GdXLjnkHMZyHTu+Gz+0Q==
X-Google-Smtp-Source: ABdhPJwBT9oz+3s6ltruiJlDfKKs5iS1ECTpMIvPbiV5aOhWFgldZTK8VhBIZTa4zeOtvkzY1T/CjFraqrgEB0b8/sI=
X-Received: by 2002:a2e:3c0b:: with SMTP id j11mr892509lja.424.1590506379944; 
 Tue, 26 May 2020 08:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-15-robert.foley@linaro.org>
 <20200523201246.GF382220@sff>
In-Reply-To: <20200523201246.GF382220@sff>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 26 May 2020 11:19:35 -0400
Message-ID: <CAEyhzFt5Yxt6DVDJrhfnV+WjJuuoS9=t_tETM58KbkaUashqyw@mail.gmail.com>
Subject: Re: [PATCH 14/19] util/async: Fixed tsan warnings
To: "Emilio G. Cota" <cota@braap.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 23 May 2020 at 16:12, Emilio G. Cota <cota@braap.org> wrote:
>
> On Fri, May 22, 2020 at 12:07:50 -0400, Robert Foley wrote:
<snip>
>
> >      QSIMPLEQ_INSERT_TAIL(&ctx->bh_slice_list, &slice, next);
> >
> >      while ((s = QSIMPLEQ_FIRST(&ctx->bh_slice_list))) {
> > @@ -280,14 +285,16 @@ aio_ctx_check(GSource *source)
> >      aio_notify_accept(ctx);
> >
> >      QSLIST_FOREACH_RCU(bh, &ctx->bh_list, next) {
> > -        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
> > +        if ((atomic_read(&bh->flags) & (BH_SCHEDULED | BH_DELETED))
> > +             == BH_SCHEDULED) {
> >              return true;
> >          }
> >      }
> >
> >      QSIMPLEQ_FOREACH(s, &ctx->bh_slice_list, next) {
> >          QSLIST_FOREACH_RCU(bh, &s->bh_list, next) {
> > -            if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
> > +            if ((atomic_read(&bh->flags) & (BH_SCHEDULED | BH_DELETED))
> > +                 == BH_SCHEDULED) {
>
> This hunk like the real fix. Also, I'd put "fix race" in the commit
> title as opposed to "fix warning" since fixing races is the goal, not
> fixing warnings.

Good point, will update the commit.

Thanks & Regards,
-Rob
>
> Thanks,
>
>                 Emilio

