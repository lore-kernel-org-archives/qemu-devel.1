Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910CEC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB5020673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/VXofHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB5020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDGAH-0000W8-GO
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDG9R-0008Uo-40
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDG9Q-00013H-0p
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:52:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDG9L-0000v2-1k; Wed, 25 Sep 2019 18:52:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so201041lff.4;
 Wed, 25 Sep 2019 15:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=frQu29Nj8ZdlahMtLQpA647Txr2OvkpzXynOlToVIZE=;
 b=E/VXofHl2j18Dm9Lw8dU/gu/ITvSxNPbcCv8pknxQSr5MND4BOUSeEW2V0xWzc+lNN
 2q0RsS69UGXVCbgwu0cME0lEkK3HCQyx1JFOLBSQ/bKQcyWTZ4GhkypdpYTt0DxaS4P/
 t9E3QPQxMkSkboP1RkyVXzb45R58fWbGqOQn59AIvNAhifcbdhrRgamsc5Chq7dsgCMp
 gfWo/DqmXspfkz80t5dgyuSobrYezKBRe3PGd37WpYHXCvWGJmqo+BnsQtE4NJ3nq1nP
 gfRfNxsCdNMUGI3iyMRyOi7xQrCdEkllRGpnqi5isfDs5YXS6OWWVUGSDzfyjv0KkCxG
 yGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=frQu29Nj8ZdlahMtLQpA647Txr2OvkpzXynOlToVIZE=;
 b=bxFy2TdP71puQZEKGzzaRHOe5lpkyaIMcjMvHe1dLyi7HQziQ1KZ1hcCR1PVax6hV+
 acMrCASqff5BfYjba7eOQuUQQlONt41FoRGie8KKPWhPqGrnQh5Qi/YI/dTv8vulJpFX
 P+PvyXbMVksjMtYYTgYNcfMK1jIpWkXnU+bYliQZu8nRN7v+BUdwg/W+EOCMOvjK3w9Q
 hY9gflVZeOJTEJdw/0BNDTQpQtwJEZRdO5AxHBtXYldCDpoqV0royrOmSt1veHf11LbC
 tcKNJAsE/x6pYdzfh3L9lAoGlT+Tzg4hbGmk1lHij1m6DtT3KH4gV60UhAKMZ17WxKBr
 h2Rw==
X-Gm-Message-State: APjAAAWR3sKp81C8S2FrRJCT9o0VASM/Sp/6vhts5QN1QLKhjJQRlHTw
 y0Z/KEc9VP5N/LWcLb2xAjxG1c3+4oktFWMI3sw=
X-Google-Smtp-Source: APXvYqz+8xtFnly0lmpF1kaJTt4IWUyHQvG/PrTOWiw2wvOjx/0JAazsk91+6onFEhWhCp9OWxrXSSrT2EWMWngzrRU=
X-Received: by 2002:ac2:5e9e:: with SMTP id b30mr209761lfq.5.1569451899079;
 Wed, 25 Sep 2019 15:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <1569386895-8726-1-git-send-email-guoren@kernel.org>
 <CAKmqyKMraotFmqMg7MrJC5C4SogGqSaVtHkVYTEgGWK9UnWb5g@mail.gmail.com>
 <CAJF2gTR0o0s_p0H669BRZ86phLtpATwWczczWV8HWw1nc+doFA@mail.gmail.com>
 <CANnJOVFkviip0g1tBHdL6n2B8pMAQxVBC83RTaF4PAE1t+aPew@mail.gmail.com>
 <CAJF2gTS=1uaQi7=CXg7f0eh2xb-HcG_sriMtU208VHXnJ4GTvA@mail.gmail.com>
 <CANnJOVFkUAS3mP4y0mu+jCajy9m4hDK389xpZz4wza1t0Bvo_g@mail.gmail.com>
 <CAJF2gTQR7cZ+HNAfKwdQ9P3rJTStmmjVGZ7UsaA9dbMYh9PqYw@mail.gmail.com>
In-Reply-To: <CAJF2gTQR7cZ+HNAfKwdQ9P3rJTStmmjVGZ7UsaA9dbMYh9PqYw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Sep 2019 15:46:55 -0700
Message-ID: <CAKmqyKM5rNDGCmNTBqk4F7zETeMiwLjGgq4m3Wx2rAKUsJxeag@mail.gmail.com>
Subject: Re: [PATCH V3] target/riscv: Bugfix reserved bits in PTE for RV64
To: Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.66
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>, Jonathan Behrens <fintelia@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 9:16 AM Guo Ren <guoren@kernel.org> wrote:
>
> "Bits 63=E2=80=9354 are reserved for future use and must be
> zeroed by software for forward compatibility."
>
> That doesn't mean 63-54 are belong to ppn, it's reserved for future
> and nobody know 63-54 will be part of ppn.
> Current riscv qemu ppn implementation is obviously wrong. It shouldn't
> care the software's behavior, please follow the spec.

You have convinced me, I think this is an acceptable change.

Alistair

>
> On Wed, Sep 25, 2019 at 11:58 PM Jonathan Behrens <fintelia@gmail.com> wr=
ote:
> >
> > > The specification is very clear: these bits are not part of ppn, not
> > > part of the translation target address. The current code is against
> > > the riscv-privilege specification.
> >
> > If all of the reserved bits are zero then the patch changes nothing.
> > Further the only normative mention of the reserved bits in the spec
> > says they must be: "Bits 63=E2=80=9354 are reserved for future use and =
must be
> > zeroed by software for forward compatibility." Provided that software
> > follows the spec current QEMU will behave properly. For software that
> > ignores that directive an sets some of those bits, the spec says
> > nothing  about what hardware should do, so both the old an the new
> > behavior are fine.
> >
> > Jonathan
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/

