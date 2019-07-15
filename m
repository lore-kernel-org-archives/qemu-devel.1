Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44BAC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A292083D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR4T2wGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A292083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmxC8-0000st-K3
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50183)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kernellwp@gmail.com>) id 1hmxBx-0000Sx-Rn
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kernellwp@gmail.com>) id 1hmxBw-00060j-Qx
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:22:41 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1hmxBw-0005zG-IJ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:22:40 -0400
Received: by mail-oi1-x241.google.com with SMTP id w196so12089435oie.7
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HGv0/Y6Q5CSW+TZXfS+KyRIDJhAZnzyXylJ4U0lSago=;
 b=HR4T2wGmTxjwrjCuPorRbzw/ZPhpKnX/xnnZQC4pGlnpqhlFohBdpQ54QQJ1Fen2s4
 lztzFKUEA3FGyG6RwR178O5YUnVC9+aMIguQBV9wO1MWDEiVz1bOAd505niFavjGF3Fd
 9jBD4OEUZNKSHAL6kFBmkx1/2garlpWxH1Uv2oNqKyh+nNRR31f3gPOMb0D8blg4Rse5
 0xP1aKF5BTamURAVWQKyo9Fh/mIUHTjyYsXV85H8W6Pgc9vogtF3XDHNw/lWN6kJq09M
 F7BUv+e9Vyacg5LcMxVVX6rw+otdZyZYLGV5uCkeQ7hjC9XJ3bwkyf4ENGhj0yHOvrXz
 L69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HGv0/Y6Q5CSW+TZXfS+KyRIDJhAZnzyXylJ4U0lSago=;
 b=c2Q3DsyLTKJfhJEZVpIQWYarJRmeFeaETpSVabAWmqOuuHUeXtN/Z0u+14T25zRsJi
 fwZbYDXHhRRvFAGAmttwd692Ad3bNKkZr5Tm3Q9Q+46OG7LAid4NL5KzC5cDLrPIe46p
 G5/2fSIKI0nt0zdFQ3kLyM8X/s2h/F6iS1ArvnXq89Lf6c+3eMYVLH4YfwXw0NBQ/G8E
 pxWwcY+OeeXSQ/iw1uL9mN/1OBnOPYMed4o3KfPVkNFhrxMjp3HMiXB57w1kxriZfeh9
 /4MuXsPXrZ6qmR1VqxenlYnqbV+mRYQ9pkhXlLXA5aFTL/OwpmFNBC22RFp2JXbw/xqG
 VuZg==
X-Gm-Message-State: APjAAAUfIhUYa5i3GX9ix9MvuQoza81aYjlAYh4jDRZNcY6nsxTrsl27
 JG3+uEJFXdCoeNBhFCMhmi/SoYLmMhFeluTNGGE=
X-Google-Smtp-Source: APXvYqx1cIOihWaijqt2/tEXzIt846Zv+/y3YtZ34qXZd0yq6TQMvItvUP6Z/a8OlQtd2+l9pCPpvE/4zp3LqWpWGo4=
X-Received: by 2002:aca:544b:: with SMTP id i72mr13225758oib.174.1563182559186; 
 Mon, 15 Jul 2019 02:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <1563154124-18579-1-git-send-email-wanpengli@tencent.com>
 <ba3ae595-7f82-d17b-e8ed-6e86e9195ce5@redhat.com>
In-Reply-To: <ba3ae595-7f82-d17b-e8ed-6e86e9195ce5@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 15 Jul 2019 17:22:30 +0800
Message-ID: <CANRm+Cyo9A5VsRRhgjzO9wkRRbTfc1xdzd=74f_bxGcu8+5hww@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH RESEND] i386/kvm: support guest access CORE
 cstate
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 kvm <kvm@vger.kernel.org>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019 at 17:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 15/07/19 03:28, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Allow guest reads CORE cstate when exposing host CPU power management c=
apabilities
> > to the guest. PKG cstate is restricted to avoid a guest to get the whol=
e package
> > information in multi-tenant scenario.
> >
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>
> Hi,
>
> QEMU is in hard freeze now.  This will be applied after the release.

Thanks for the information. :)

Regards,
Wanpeng Li

