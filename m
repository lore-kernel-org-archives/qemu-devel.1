Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B6C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF9622CF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac8UkA0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF9622CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i08OU-000878-8L
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 13:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i08NW-0007g9-JN
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i08NV-0002vM-75
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:57:06 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:34892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i08NV-0002v9-2W
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:57:05 -0400
Received: by mail-ot1-x32b.google.com with SMTP id g17so5858918otl.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=v0H2vljjaYsdp/vaaLHREm40vISSemwDVVGQuOvzfck=;
 b=ac8UkA0lbNo8ZRwXF5tVtPRG9mOIP6/ZnkU1wkz8Z55k51WYBk1bEPpRR+PvR5vhJi
 7PmDL/lod2ecak4BIQybO7ZDKr/WDMDdbU8zg3exr+eL1PKXaTfkgvMgprwkTgNhEQh+
 8Qg9/eU/muzdX+U75pLkPB0xmi3y3Ne4d4yl4gF+QqPVueOsBCbEytUBG0mq5/gKUahl
 mNjOdL5pIwitHN4ZEcpq+xpdylUTJBOy1LWNlaze91pgwAlItbP9xTXT24X1UROrNmg6
 XQYJbbOztAHJSVwVoKed2EuzMmJym+WaQ5cbmU6MPrVpIQZKg/3IUUiBftUvI4PkyhOp
 Uzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=v0H2vljjaYsdp/vaaLHREm40vISSemwDVVGQuOvzfck=;
 b=f71BZluzL+pUe8hYXmr2y+OeG7a9lqim54+DoupA7U9/szs7sxp5hrqFjYmCw/Fhf8
 tnhr6Se0eDf7YiXEqrlW9vGFXZE6VtAOgYO5ReamuYQHwIsfKhZM1M72wGcqDT6jEvph
 DiiteBMbUOv152xR0e6osraZ7zGIKv1bs8hv/Ao7wM+Ny0SrGBg3CbliXImyg/SN8bGx
 7Quez9ac5NiCJyLsJlr2WgMIvR0qI0kJ/ibpcWv6ZZ/hn5pbgiqZjjALOuTFTMhCXJPf
 buJWhUeX/1JSTidCAQI9XRbzf5ocxQt7D3K2w+f1EfRn/ewzOR2WxL21GqOyiyWurdpv
 5BPg==
X-Gm-Message-State: APjAAAWXstZJ1Zqxj/67xiPLxMM44HG00csHlCpW2Y5cq2ShZn1x1Jx2
 s6XUcj+3vSMY9UDII1f0tmh3ZE5sK+vJFweaaRo=
X-Google-Smtp-Source: APXvYqx/gNe/VVScqFRnye0KXf8VunFKT9MddmIRRcTrndO1TZcSGnE1i+6EPyfVzzBaFTxSuP64IRorN6NGCLu7PxU=
X-Received: by 2002:a9d:1288:: with SMTP id g8mr20607020otg.306.1566323824388; 
 Tue, 20 Aug 2019 10:57:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Tue, 20 Aug 2019 10:57:03
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Tue, 20 Aug 2019 10:57:03
 -0700 (PDT)
In-Reply-To: <CAFEAcA_OyRA8rh57bFZRGWbv-rCNKGqGY1BEQ_FhkzgYQANr9g@mail.gmail.com>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
 <alpine.LMD.2.03.1908201811150.2980@eik.bme.hu>
 <BN6PR2201MB12512C4D20F05C8F21E5945DC6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <00b3cf35-d879-60d6-048a-fe757a461938@redhat.com>
 <CAFEAcA_OyRA8rh57bFZRGWbv-rCNKGqGY1BEQ_FhkzgYQANr9g@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 20 Aug 2019 19:57:03 +0200
Message-ID: <CAL1e-=hEjR-tDynT-qYxQmpUDBfGEZZDt-RVhTK-wdKQ6eXmOA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.08.2019. 18.49, "Peter Maydell" <peter.maydell@linaro.org> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Tue, 20 Aug 2019 at 17:44, David Hildenbrand <david@redhat.com> wrote:
> >
> > On 20.08.19 18:38, Aleksandar Markovic wrote:
> > >> From: BALATON Zoltan <balaton@eik.bme.hu>
> > >>
> > >> Sorry to comment on this without really knowing what is it about but
maybe
> > >> my view is not completely useless if this is to be understood by
people
> > >> who don't know anything about it. If it is not useful just ignore.
> > >
> > > No, Zoltan, to the contrary, you hit the nail - the good interface
scheme
> > > should look natural even for people not acquainted with the gory
details
> > > of the area.
> > >
> >
> > I just got familiar with the terminology and everything I read so far
> > confuses me even more (gather/pick/extend/extl/shrd). No, I don't like
that.
>
> FWIW the way I tend to approach these is to say "I want to do
> $WHATEVER, surely we must have a tcg op for that, it's probably
> got 'ext' in it, search through tcg/README to find something
> that seems like it matches what I want to do"...
>

I must admit this is the most practical, pragmatic view among us.

Aleksamdar

> thanks
> -- PMM
>
