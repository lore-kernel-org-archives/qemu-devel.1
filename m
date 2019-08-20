Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4732BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0042054F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C16J3sVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0042054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i07Ka-0007XV-7W
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i07IG-0004ax-Tq
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i07IF-00033p-Mn
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:47:36 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i07IF-000336-Gi
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:47:35 -0400
Received: by mail-oi1-x243.google.com with SMTP id g7so4617294oia.8
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V9c4U7VzXT35s53JXp/LnPMWud5tM2zcSSpNqFyzdL4=;
 b=C16J3sVJcJYXjBcr/KQZKxWcZbAUUmcsbA5B4WgmOHG6qeeQONY9fkZHFbokdnUfYB
 xPrxdSdRryRmjr8DfANu5+1xdpPI9+HMhL8M98O0QQjG08/Rc0aZmDoEJscLDyK3R32O
 JHJUFsqhuCNz53ThMWs/tsxdtHSJp+5tm/DjJo6bzkRtNzQ3+sxqBxGZjfgA13OkXDPg
 ZU4dX/kwDa92kfbQXPtmd/Kr/RyNhmFspMd9/pKEt/iK7NZTPoOjXgI9/Fq6jkx4yGgG
 v5AIMRtYbZYCgYQnO36GwFODwdNU4LEMw8Lp394bTb8Z+uRYkloy9VjApsdcVMcPZPX8
 Q+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V9c4U7VzXT35s53JXp/LnPMWud5tM2zcSSpNqFyzdL4=;
 b=DpnmJp6QRVGAtiUaWwVFbNAzhHKBuJ9AghzPSLl/cxJBvrkQYZCu94UxY9kkaB6fBi
 vJc7Y5yFAiihemnzovTu5IE1Mlp1KYwxFUWyv0cQNW0jRBeI54GV+1pUIzA0wphipXQ+
 0Xz/IHEFSxCYr9IW/Ge62B47T/bkjsTXu63BFjHCC0duj/xy8M01C0IJNxgpz13crUa5
 /erDGe8jECuIwKJ6gVzkYdxEATgcrmCdVBNPFfz70tHb4O7BtpPqsrqLToNB67CEaZNU
 399+C3e+u9XWm7meVepCf1PgrEjrVGAZrvqhC+OaEMrfI9D3aOSwf+LEZk9bhU1BCxut
 4DPg==
X-Gm-Message-State: APjAAAWOmmtzfXRNHvKcmPAdNp6yOvIH2vyyV3bc7wiCLWw64OYFahZI
 hikzo0F/EjcbkRj1NnyqvxlzRS1BWo0MinzzvtJuZw==
X-Google-Smtp-Source: APXvYqxpqGlI5+kTAmFtsQHue1nUL7PnBpSfiiR9uLTK/8Cxdy5MZ84tJEXXwTjoFO6rkUVPpZyOjTrx7M+5oNv5jZo=
X-Received: by 2002:aca:4a57:: with SMTP id x84mr752888oia.170.1566319654430; 
 Tue, 20 Aug 2019 09:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
 <alpine.LMD.2.03.1908201811150.2980@eik.bme.hu>
 <BN6PR2201MB12512C4D20F05C8F21E5945DC6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <00b3cf35-d879-60d6-048a-fe757a461938@redhat.com>
In-Reply-To: <00b3cf35-d879-60d6-048a-fe757a461938@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 17:47:23 +0100
Message-ID: <CAFEAcA_OyRA8rh57bFZRGWbv-rCNKGqGY1BEQ_FhkzgYQANr9g@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
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
Cc: Palmer Dabbelt <palmer@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 David Gibson <david@gibson.dropbear.id.au>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Aug 2019 at 17:44, David Hildenbrand <david@redhat.com> wrote:
>
> On 20.08.19 18:38, Aleksandar Markovic wrote:
> >> From: BALATON Zoltan <balaton@eik.bme.hu>
> >>
> >> Sorry to comment on this without really knowing what is it about but maybe
> >> my view is not completely useless if this is to be understood by people
> >> who don't know anything about it. If it is not useful just ignore.
> >
> > No, Zoltan, to the contrary, you hit the nail - the good interface scheme
> > should look natural even for people not acquainted with the gory details
> > of the area.
> >
>
> I just got familiar with the terminology and everything I read so far
> confuses me even more (gather/pick/extend/extl/shrd). No, I don't like that.

FWIW the way I tend to approach these is to say "I want to do
$WHATEVER, surely we must have a tcg op for that, it's probably
got 'ext' in it, search through tcg/README to find something
that seems like it matches what I want to do"...

thanks
-- PMM

