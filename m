Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F89C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128C22084D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpSmCC7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128C22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxqiT-0001Qe-7h
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 06:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <catherine.hecx@gmail.com>) id 1hxqhp-0000yZ-W3
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <catherine.hecx@gmail.com>) id 1hxqho-00071H-Cn
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:40:37 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
 id 1hxqho-00070s-7k
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:40:36 -0400
Received: by mail-ot1-x344.google.com with SMTP id q20so28299739otl.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EDwbWLkvkPwEK7niUFJ/Gl6bBZs8PWgUmvO0NAD3PjA=;
 b=MpSmCC7bTouLiEFVBvd59mkONeIWSwuZPCz9oh1CHyRDugTOCp2q2Ce+9Fabe5DmNa
 CvW5LgPlujpHo76luszWSXwQv5Kugr5UUZVFN2WoMmi6V4RidLSfrq2vUqWS05beDOX4
 bvzI1BRHZM/5/H2oIxRUDwm4OUHuTMle3OtQuWig9gMZu2tuEZGicdoYVk1KZMwy6lDH
 4sQU6REIt+SjRA/Uk2gZ9t0655gew5/TShyWHEql3z2PmlifiYHGmkGuPBDi9+CwQXnH
 jbZgA8PnA3TCp+dzOAr1djNCQq/XSakhvx1cUKuDIrsZ4rnNIKYwceWNlngC+E2vfYQw
 TA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EDwbWLkvkPwEK7niUFJ/Gl6bBZs8PWgUmvO0NAD3PjA=;
 b=h1YGn6OnYY1txZhEf+JZqNJEtC5WiO6sMUN5X06kb9y1OgQFlwuPkGaDRGgP/dSc7b
 H1kPZMl1ma79o35H10dpJvvvkevjB7Gs+GQD5jwR9a7A+tXLZy/eGy0hD+NmDLic/zuA
 uvQhlz6SoSsYiGx2OGJxAej/05HwMf1l9+XP4f6XJFDKxqkV8XfAXg67SnQzFPHh4t0T
 NuO+IUtncWgp9Q7sjubV7VB1ijbtNMlNqCC/rl8dy8FJ8rLAh4dek0pSMkmOTMFtWCMg
 pbZVJSJHdVsEw71F+7UDKXAgK6TDjzrxU+7vtYHuNC0DII91z3+U994zcdahnYP2E+is
 Cv3g==
X-Gm-Message-State: APjAAAX0Ssk3X8e7KFlLEy+i11Yve9i40/jdKrd1oH0M2ByTqPJ8+B06
 Lu4n/pDjg0rZPsWafVrdAEIvNBCpqOQytuFCokw=
X-Google-Smtp-Source: APXvYqxykypuyJVdDloZfr5Rx56IXqZR57WxXUVtPE5xmAzPRJJ/mvtlg/a9OI4f+0wIzynqLTXkkvKD0gigCGgBSEI=
X-Received: by 2002:a05:6830:140b:: with SMTP id
 v11mr7177080otp.117.1565779235128; 
 Wed, 14 Aug 2019 03:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
 <1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
 <20190605183122.GJ2669@work-vm>
In-Reply-To: <20190605183122.GJ2669@work-vm>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Wed, 14 Aug 2019 18:40:23 +0800
Message-ID: <CAEn6zmE2UHuioWS-s89cBA+DMzphV5gzN+85FNsPD2WRDDzJjw@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v4] migration: do not rom_reset() during
 incoming migration
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
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo
Ping, is any other comment I hadn't addressed?

Cheers
Catherine

On Thu, 6 Jun 2019 at 02:31, Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> Paolo, can you take this one please.
>
> * Catherine Ho (catherine.hecx@gmail.com) wrote:
> > Commit 18269069c310 ("migration: Introduce ignore-shared capability")
> > addes ignore-shared capability to bypass the shared ramblock (e,g,
> > membackend + numa node). It does good to live migration.
> >
> > As told by Yury,this commit expectes that QEMU doesn't write to guest RAM
> > until VM starts, but it does on aarch64 qemu:
> > Backtrace:
> > 1  0x000055f4a296dd84 in address_space_write_rom_internal () at
> > exec.c:3458
> > 2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
> > 3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
> > 4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
> > 5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
> > 6  0x000055f4a2c9851d in main () at vl.c:4552
> >
> > Actually, on arm64 virt marchine, ramblock "dtb" will be filled into ram
> > druing rom_reset. In ignore-shared incoming case, this rom filling
> > is not required since all the data has been stored in memory backend
> > file.
> >
> > Further more, as suggested by Peter Xu, if we do rom_reset() now with
> > these ROMs then the RAM data should be re-filled again too with the
> > migration stream coming in.
> >
> > Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
> > capability")
> > Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
> > Suggested-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> > ---
> >  hw/core/loader.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index fe5cb24122..040109464b 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -1087,6 +1087,15 @@ static void rom_reset(void *unused)
> >  {
> >      Rom *rom;
> >
> > +    /*
> > +     * We don't need to fill in the RAM with ROM data because we'll fill
> > +     * the data in during the next incoming migration in all cases.
> Note
> > +     * that some of those RAMs can actually be modified by the guest on
> ARM
> > +     * so this is probably the only right thing to do here.
> > +     */
> > +    if (runstate_check(RUN_STATE_INMIGRATE))
> > +        return;
> > +
> >      QTAILQ_FOREACH(rom, &roms, next) {
> >          if (rom->fw_file) {
> >              continue;
> > --
> > 2.17.1
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
