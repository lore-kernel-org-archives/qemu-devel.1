Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1FCC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3D120848
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3D120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j208X-0008T6-SW
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 17:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arei@altlinux.org>) id 1j207f-0007th-6d
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arei@altlinux.org>) id 1j207d-0007Pz-W6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:04:42 -0500
Received: from air.basealt.ru ([194.107.17.39]:53616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arei@altlinux.org>) id 1j207d-0007Ne-K7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:04:41 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
 id 2F88E58958F; Wed, 12 Feb 2020 21:59:08 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by air.basealt.ru (Postfix) with ESMTPSA id 1C299589541
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 21:59:04 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id a5so4050846wmb.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 13:59:04 -0800 (PST)
X-Gm-Message-State: APjAAAUQqC9oxBT6zwRQ8+4Jkxs891brHcGPZFM85odWKwyzPDALKo9e
 dmquEjgmwUOA71UUvFGV8nHyqHs/I/He4pj/G44=
X-Google-Smtp-Source: APXvYqwoCAwRDhhHyNdddx/fjtNzYwrnjFnEZvPVJtjV97Q/adOeW/5bHV6oNTirLBOu7BhI2y3SPt37H96awX0exM8=
X-Received: by 2002:a1c:7907:: with SMTP id l7mr1136387wme.37.1581544743593;
 Wed, 12 Feb 2020 13:59:03 -0800 (PST)
MIME-Version: 1.0
References: <CANA1cB+D-Uth0C-6qNE5HcAJkQeDsCbKqmYG7uHsLqbbofSsZQ@mail.gmail.com>
 <CANA1cBKtbYqnxnSacEK3sXOYM987J5+MacpKWHdKHwB5sk672w@mail.gmail.com>
 <CAEUhbmUsK7u9ubVH+4vidgQUDmO4oN5AdSUZPXiioMFgMHg-Jg@mail.gmail.com>
 <CAKmqyKMZipi-Fv0Y+1W32Cv5sj+CeeHFsusa5iNpLPJgoLa-1g@mail.gmail.com>
In-Reply-To: <CAKmqyKMZipi-Fv0Y+1W32Cv5sj+CeeHFsusa5iNpLPJgoLa-1g@mail.gmail.com>
From: Nikita Ermakov <arei@altlinux.org>
Date: Thu, 13 Feb 2020 00:58:25 +0300
X-Gmail-Original-Message-ID: <CANA1cB+2Qdrgrhhh5wpzYupibVodafGfsftScMXn+H6G5-DhFg@mail.gmail.com>
Message-ID: <CANA1cB+2Qdrgrhhh5wpzYupibVodafGfsftScMXn+H6G5-DhFg@mail.gmail.com>
Subject: Re: Question: SiFive U SPI and SD
To: Alistair Francis <alistair23@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a36c6d059e68147b"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 194.107.17.39
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
Cc: Bin Meng <bmeng.cn@gmail.com>, Nikita Ermakov <arei@altlinux.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a36c6d059e68147b
Content-Type: text/plain; charset="UTF-8"

Hello, Bin, Alistair,

Thank you for the answers!

On Thu, 13 Feb 2020 at 00:16, Alistair Francis <alistair23@gmail.com> wrote:

> I had a crack at this awhile ago and you can see the patches here (I
> just rebased them):
> https://github.com/alistair23/qemu/tree/mainline/alistair/sifive_spi.next
>
> Debugging failures was really hard in Linux, but now that U-Boot and
> Oreboot (https://github.com/oreboot/oreboot/pull/234) have SPI support
> it is probably easier to debug.
>
> If you wanted to help you could try to debug that branch and figure
> out why it isn't working.
>
Thanks! I will try that.

-- 
Thanks,
Nikita
B8 00 4C CD 21

--000000000000a36c6d059e68147b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hello, Bin, Alistair,</div><div><br>=
</div><div>Thank you for the answers!<br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 13 Feb 2020 at 00:16=
, Alistair Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@g=
mail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
I had a crack at this awhile ago and you can see the patches here (I<br>
just rebased them):<br>
<a href=3D"https://github.com/alistair23/qemu/tree/mainline/alistair/sifive=
_spi.next" rel=3D"noreferrer" target=3D"_blank">https://github.com/alistair=
23/qemu/tree/mainline/alistair/sifive_spi.next</a><br>
<br>
Debugging failures was really hard in Linux, but now that U-Boot and<br>
Oreboot (<a href=3D"https://github.com/oreboot/oreboot/pull/234" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/oreboot/oreboot/pull/234</a>)=
 have SPI support<br>
it is probably easier to debug.<br>
<br>
If you wanted to help you could try to debug that branch and figure<br>
out why it isn&#39;t working.<br>
</blockquote></div><div>Thanks! I will try that.<br></div><br>-- <br><div d=
ir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><di=
v dir=3D"ltr">Thanks,<br>Nikita<br>B8 00 4C CD 21<br></div></div></div>

--000000000000a36c6d059e68147b--

