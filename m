Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA0BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D034924679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K68Vn8WF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D034924679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHAX-0007yq-RV
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iiH00-0003pe-EN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iiGzz-00022B-4I
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:03:16 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iiGzy-0001yC-QT; Fri, 20 Dec 2019 07:03:14 -0500
Received: by mail-ot1-x344.google.com with SMTP id k16so7057474otb.2;
 Fri, 20 Dec 2019 04:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8C7TuX1X1U9ocuMoYVdHEe4iBdnQlGcycyiXt2bsoMs=;
 b=K68Vn8WFOv2wBjZtN/poDXieWbC3Jlb9bOYo1Q6yZh3mTS+qhJ2k+t46OM6XtfxAkc
 48dXYRHjN2UtY+KOR+FTwYnh/aBlfcXaZC+HktwscAC+M+dtddI0QnbdMRnIv+G0wm5r
 cDrkXW/cSAp78xVdU8BG33T3CM06G/7QUyT2DKeqluFT7z0+ecX5PhT2gNLR33UaKUs2
 kaCw+He2Nid0kPYjfhNKKGrKfUBGOKNvN576T3PySGg2ryR4rmvQ7DLgpYiNyMAsrIvD
 vaCzxT0pzIs/+Q7PdhumyrFunJJA3rf6fSERWU+EXHi3Ua4x/hAz3vF6Ax0e5+VpWcoN
 Atlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8C7TuX1X1U9ocuMoYVdHEe4iBdnQlGcycyiXt2bsoMs=;
 b=hUYuE6Gb0QxyTw4SnsOGQ0p+5LTRrs/47XzT9ClaXQf2XGcFTdnA+WtmpUFXbcy7ZV
 +Sg+bJwvq/MLSsjg0sHe9JFu0b/0AvzjwaVluRkc5G7mN6u24lXi4AS1f5YWyWsIW8FK
 2MKwXJOUhBxNHxIpJaFPWM/ozP9Vi1IzwtiESJ8GBTyzEnw8yL/JtXgOYqp44h+aXlla
 dxG3za0sBsFwizCtJyVTLhejOHyOFge8feJWULUne2OO01xwwf5/oPOKOWnQjlzrcrLb
 jTKbr0QKDAzx/n4x2EimeldX2dPquGjskfMZzDAnS7T2vbccvSG0XXOLhOtjn+FLE9MS
 8acg==
X-Gm-Message-State: APjAAAVnUqNQWFUaRev+8CJGU76rIAC1jfYiSEbrJYar7V4mVxHfeteh
 0lD2Z7cqZ2nXYhcSVKiWoIvFAES5eZehwIHN5vA=
X-Google-Smtp-Source: APXvYqzsLrDlft+ir8y6+sld7djDMUGFV5iCIIIZgjx2ypKQO4wInQsGoQpU2TxMQHYU524lzhKZt1GRiu/XVK+fTnc=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr14582032otp.306.1576843393733; 
 Fri, 20 Dec 2019 04:03:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=jN-8zEnCvxq4actoBcrjBviqfxBjGCTT7mBxmSPhiF3w@mail.gmail.com>
In-Reply-To: <CAL1e-=jN-8zEnCvxq4actoBcrjBviqfxBjGCTT7mBxmSPhiF3w@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 20 Dec 2019 13:03:02 +0100
Message-ID: <CAL1e-=ggoQg5WTWvTHcdyrfLvFpVP9k1-30Hb6jcOP4W67PeoA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, Herve Poussineau <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 12:38 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Sat, Dec 14, 2019 at 2:29 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> >
> > Hi All,
> >
> > There is a bug in the DP8393X emulation that can stop packet reception.
> >
> > Whilst debugging that issue I found that the receiver algorithm differs
> > from the one described in the National Semiconductor datasheet.
> >
>
> Finn, could you please provide the link to the exact datasheet that

or, several datasheets...

> you used for reference, so that we are on the same page while looking
> at your code?
>
> Best regards,
> Aleksandar
>
> > These issues and others are addressed by this patch series.
> >
> > This series has only been tested with Linux/m68k guests. It needs further
> > testing with MIPS Jazz guests such as NetBSD or Windows NT.
> >
> > Thanks.
> >
> >
> > Finn Thain (10):
> >   dp8393x: Mask EOL bit from descriptor addresses
> >   dp8393x: Clean up endianness hacks
> >   dp8393x: Have dp8393x_receive() return the packet size
> >   dp8393x: Don't advance RX descriptor twice
> >   dp8393x: Update LLFA register
> >   dp8393x: Clear RRRA command register bit only when appropriate
> >   dp8393x: Implement TBWC0 and TBWC1 registers to restore buffer state
> >   dp8393x: Implement packet size limit and RBAE interrupt
> >   dp8393x: Don't stop reception upon RBE interrupt assertion
> >   dp8393x: Don't clobber packet checksum
> >
> >  hw/net/dp8393x.c | 80 +++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 52 insertions(+), 28 deletions(-)
> >
> > --
> > 2.23.0
> >
> >

