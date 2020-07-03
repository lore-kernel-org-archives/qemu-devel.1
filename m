Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF04C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FA420771
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUUsb1n0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FA420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrT2v-0001Bw-Om
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 17:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrT2H-0000fN-U0
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:15:53 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:34639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrT2E-0005FS-FT
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:15:53 -0400
Received: by mail-ua1-x943.google.com with SMTP id l18so3141907uad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QVYdKW8LXPkxZL2KE6aWM7nk/9iW09YPv1n3yc1coT4=;
 b=vUUsb1n0lSWcmNOf5Sk8UNiBFR7zj+Tq3t/aivM9P/JCaywIHf6M/Wt3aBMh3J/4Od
 rjmi7Iy2+8ZvK+M0SGrw02QWfToeMS5/vy4NY0kSvl6pxIOZ8JkCQ8OKiArdZsaIj7gs
 RAaMXFouUeLktaz1SNz7nDkECWvUyi9rGBcSYOuZi/xa+rh/zDKJ0LGvpkgMCOFgg9yN
 nKVPEtbI9v21jH0CB2Ksg6+iQWoYDboWpviRTqcBzzVcfF7bivsUOr1mvwWYB9SwCUmC
 YOAtMIwObUqZ13JH70/roTVb82/3VQK9nS46T+ZrqC+XpH+42pZWsajOslhMDjZWeNIw
 DvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QVYdKW8LXPkxZL2KE6aWM7nk/9iW09YPv1n3yc1coT4=;
 b=IqM5+t8dVxcMZ3QIYMtm7NOB+f4ETRRNXaNFEOkSBW11CXaLz5Im0ruKKKYpAT4rrW
 HFXbc/o672b67YjbORSKwXzrNn0x2J+s+UUoAo/jfsnFSNYy+E8GoFEHKQi1TDSCt9Fy
 snpj3k2rYc9+pg2E10NumzJjVnLXHmKm/ANsb5s5/aoSLgEPYUPu9vuez7UPkjRZBXHT
 HhFMJeY66vfMAQgtrGMwaWmPyI6mHgqts4szS9VJQa1qiFQIgsh4RMteM5Q14iY25FXu
 he8aFy6ej26/eHsR07fadeqoUEoaWADqLXDgZBD8ko9zi9RqRu2xRmCUPoKe2C6+7evq
 Wwbw==
X-Gm-Message-State: AOAM531BL+yV43w3JnccYm/ZJY8b0rZ7uz2h+S4US6YJhfs0tLJ5ryNc
 CdpbLSs+zNOyvA2IjwR0fDb8uvZdttfhpMyLxHOzXg==
X-Google-Smtp-Source: ABdhPJy2cXRLaGvyoabsHni00kpuLEI49d0YhSZFmNDeZ87f6M3nUzrLt4MWX2AP/VQ084cQZevipT8dM99FmCBV8AU=
X-Received: by 2002:ab0:2b08:: with SMTP id e8mr17248847uar.119.1593810949038; 
 Fri, 03 Jul 2020 14:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <CAFEAcA_3y3XoF6BsYUt19f2CvyseahSEZWfY0iQxByJKaMA29w@mail.gmail.com>
 <296f281f-e045-e794-1a1b-4e311b6408b2@redhat.com>
In-Reply-To: <296f281f-e045-e794-1a1b-4e311b6408b2@redhat.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 3 Jul 2020 14:15:37 -0700
Message-ID: <CAFQmdRbOKFxxxgR0hqcnABxn+jSBr349159m45TJLawVmnhR3Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::943;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x943.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 3, 2020 at 6:35 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 7/3/20 2:27 PM, Peter Maydell wrote:
> > On Sat, 27 Jun 2020 at 00:55, Havard Skinnemoen <hskinnemoen@google.com=
> wrote:
> >>
> >> Time for another refresh of this patchset. Sorry it took so long -- I'=
ve been
> >> trying to figure out why the Winbond flash model isn't working with
> >> npcm750-evb, and I'm fairly convinced the number of dummy cycles in DI=
O mode
> >> should be 4, not 1. Unfortunately, I don't see any other machines usin=
g Winbond
> >> flash in DIO mode, so it's hard to prove that it's correct. I'm planni=
ng to
> >> post a libqos-based test suite separately.
> >>
> >> I'm also planning to add the vbootrom to qemu as a submodule, similar =
to the
> >> other roms, but not in this pathset (let me know if you do want me to =
include
> >> this in the series).
> >
> > Hi; it looks like codewise this patchset is ready to go in
> > and it's all been reviewed. I see however that all the
> > new files are GPL-v2-only. We usually prefer GPL-v2-or-later
> > for new code: is it possible to use that license instead ?
>
> This series has been posted before Markus qdev & error cleanups.
> Maybe some newer error patterns should be used now instead?

I'm not sure if I understand exactly what you're referring to, but
I'll do 'git log origin/master --author=3Darmbru@redhat.com' to see if I
can apply any similar fixes or cleanups to this series.

Havard

