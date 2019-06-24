Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41D8C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0B320674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ayarTMUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0B320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfIhQ-0002cQ-44
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 02:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@sifive.com>) id 1hfIgs-0002CE-AU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1hfIgr-0000Gc-7p
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:42:58 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:35188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hfIgr-0000Ag-0A
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:42:57 -0400
Received: by mail-qt1-x843.google.com with SMTP id d23so13390499qto.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CqJAb8NCY3pBtooXJ5LpA6nwJFMUSpk5b91OzY36qU8=;
 b=ayarTMUk92G34GB1A3PKZAOBYEz7RwWkeLGZ3z/ebPIsyPG8a0GXpf5MfBKCHf8ZPa
 VH4vP1smDYY0tdpWK4Qjt2Neh2fSO0+X4mRPEhMxN+DfVEtlBNevEhINMC3DjZavMX4H
 c4p0Fus/bsiaLfYQrQspKnQ2GgZLD6M/6jn7UlgX8PTqrwkLwRpWz8xXSm7uLe7hC0ks
 sCiZHafrO3Y58dXgqmKdqp6sbOBwRnINN40UbXNkzh58RQvjc/YpRV18Q2x44dxOYNYB
 LK5KGYYK8mg75x/GleYyv32WKIdUdaWB74CSdfi7TbvKgjX3lk+AMEgQnzXhDV2LlEG/
 mqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CqJAb8NCY3pBtooXJ5LpA6nwJFMUSpk5b91OzY36qU8=;
 b=VEfBNgfcL2ObUOAT+68iGLYhtGKKJ4TxgXsVHDpi1KvVyxskQGN0pjJ5/9TbZVL9Z5
 xvb/KuFBd3AOpMYiHgE5Hx1hNBNC3NytLix9QpAHiThAh6JyhvSWzO9IeqC0aob8VdL5
 rZPpSF13R5Im07xJmUYjgquM8mKIKDKb+WtuOETfVJERqMUbHfZaWxe/s2r8ZwqAQR+K
 4wP8/jHhikrrTfRiD43mkQRSimgJfHmjuCDr5dOXcD0rGIOGgpxBQ8zKt9x/2M+XKRYW
 NCNPkHBEDL8maOhfKhDiGN6ItLCHsyCKSTzFAP3t1b+wYwTTXSds2ioQRV3YNhVIgxTB
 vTxg==
X-Gm-Message-State: APjAAAWk9UuclFUHjIicUcSKXSavtSL/014OrQKz5hoRmr7pMQf9tL0B
 355LQuGsFXp0SG4H8rkdNJCc+vy+WTE=
X-Google-Smtp-Source: APXvYqxrldruH0vrZYpEYd/9waqZMHJy9Dv3OhhIvKOl4LN5WAA6L85Z0+zX01t42d3f0qBFQFsMig==
X-Received: by 2002:ac8:e05:: with SMTP id a5mr93607946qti.53.1561358575130;
 Sun, 23 Jun 2019 23:42:55 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com.
 [209.85.222.169])
 by smtp.gmail.com with ESMTPSA id t29sm6890498qtt.42.2019.06.23.23.42.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Jun 2019 23:42:54 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id x18so8898449qkn.13
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 23:42:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1106:: with SMTP id
 o6mr101869223qkk.272.1561358573519; 
 Sun, 23 Jun 2019 23:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190616191900.GH61734@hippo.sing.id.au>
 <41ef5fbf-f438-e60a-2fba-a72e3ad422f9@linaro.org>
In-Reply-To: <41ef5fbf-f438-e60a-2fba-a72e3ad422f9@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Date: Sun, 23 Jun 2019 23:42:42 -0700
X-Gmail-Original-Message-ID: <CANs6eM=ir68d9KEn1_uOGVAxFp61OT2bCCJNFa+JrWnHWeMJFA@mail.gmail.com>
Message-ID: <CANs6eM=ir68d9KEn1_uOGVAxFp61OT2bCCJNFa+JrWnHWeMJFA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: Carlos Eduardo de Paula <me@carlosedp.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, Joel Sing <joel@sing.id.au>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Marco Peereboom <marco@decred.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 4:53 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/16/19 12:19 PM, Joel Sing wrote:
> > +    /*
> > +     * Clear the load reservation, since an SC must fail if there is
> > +     * an SC to any address, in between an LR and SC pair.
> > +     */
> > +    tcg_gen_movi_tl(load_res, 0);
> > +
> >      gen_set_label(l2);
>
> This clear needs to be moved down below label l2.
> Otherwise, with lr / sc / sc, the second sc could succeed in error.
>
> FWIW, other targets have used -1 as the "invalid" load reservation, since
> the
> architecture does not require address 0 to be unmapped.  This should be
> quite
> visible in M-mode with paging disabled and ram at offset 0.  Often, other
> targets require alignment for the lr/sc address, though I don't see that
> for riscv.
>
>
> r~
>

Joel: can you submit this with a "Signed-off-by" line?  There's only a week
until the soft freeze, and I'd really like this in if possible.  It'd be
great if you could fix up the other issues, but I can't even do that myself
without a SOB.
