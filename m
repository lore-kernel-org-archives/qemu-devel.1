Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF33FC004EF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1E02064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlRRdEzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1E02064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl93M-0008RS-NI
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51078)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hl8yl-0005tg-Mw
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hl8yh-0003z9-Vk
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:33:34 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hl8yh-0003vB-Oo; Wed, 10 Jul 2019 05:33:31 -0400
Received: by mail-oi1-x243.google.com with SMTP id 65so1078565oid.13;
 Wed, 10 Jul 2019 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=0C7Vne2I0LXUUInU2T8v7zArx3LpW7irxRMIAehEJ8A=;
 b=XlRRdEzuHpqjIiD+uIqjQODSnM5OG7Cacr5G4bD3lizfBZX5Pl3qkYW9oD9V5e7RDQ
 aVQ9WLUI1Og7b/gkH+pGfoYH1hSIjevJBE03fsBC4GHpl4ewvY3B2RvTXrccb7ThqeTy
 8jAsZ1g0kwhKwnF2mSEKexOkf75mtEpnNVLoAcmsbdiUNYgEZeeJie7lYp7yEEGWP3VW
 YK/CT8g23sIdib6Ldz8vwr2hTGaiFNujtEHOKjt/Cg2O2bV1hqLZJmmzj5X0Q8nQQ+mp
 eJyi16/wZ/bZS7hMgO+v0TZUSjY7Z9rkz0EwHYY4uSy+8SWRdCqhemZ42xuFePelT8wX
 RxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=0C7Vne2I0LXUUInU2T8v7zArx3LpW7irxRMIAehEJ8A=;
 b=kaguX+3pI1LxygRd29Mqp0ouMmMgUrN8/8ftnud7q/m02luEo84r3/e+RR3yU0X1JV
 2gxyp39byBm12JCP3XOdK/oeckfRfV/vVxv2eRBD0gi+lw+pbHOSQomalf0xNuydRXt7
 YdCJ75RfVqPG05qRVedFuIJytHIv8Jo8OQt9HXSyP5HiXjG1PUq0Exac3MVC/r4xR4bm
 u7XAr5IHK7970VPCQvK8fIqcV522GAeWNGhBzY4k/haS7PGfUTMhaHVbOOMY+6pGz91x
 ndfYBwa2kiEaXpG/ak5sDpHk0e/rAU1NlK+4uvZUZY0KMEI4RiQ57s2NQ9yESmS9G6+s
 RYzg==
X-Gm-Message-State: APjAAAUYMu019kzX+asko6syyhyBZE0Jir6iMc1tA2+w8xzb5ilKxriU
 BK+cr+nFF2ztuiz653adWXN3dGInuQq0XiWKwGg=
X-Google-Smtp-Source: APXvYqzT/QPqS/ECpIoEIgyxDrxg2b8MaIWSU/bKp5D3RJA7jPLxto17ETfDojeI2ae8QS4RqfIKRm/EH5MSeJ7zbPM=
X-Received: by 2002:aca:abd8:: with SMTP id u207mr2714622oie.136.1562751206470; 
 Wed, 10 Jul 2019 02:33:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Wed, 10 Jul 2019 02:33:25
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Wed, 10 Jul 2019 02:33:25
 -0700 (PDT)
In-Reply-To: <87o922dyog.fsf@zen.linaroharston>
References: <20190705160421.19015-1-alex.bennee@linaro.org>
 <20190705160421.19015-6-alex.bennee@linaro.org>
 <CAL1e-=i08h1j0V7d97p7a-OQqdNXzG1s5QATmLDxfGCDtwE-4Q@mail.gmail.com>
 <87o922dyog.fsf@zen.linaroharston>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 10 Jul 2019 11:33:25 +0200
Message-ID: <CAL1e-=jTA+kcq-Z25nXH4gy-cd99L4u3DsWo2qN5u8xN49uQ7g@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v1 5/5] gdbstub: revert to previous set_reg
 behaviour
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 10, 2019 11:30 AM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote=
:
>
>
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
>
> > On Jul 5, 2019 6:08 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wro=
te:
> >>
> >> The refactoring of handle_set_reg missed the fact we previously had
> >> responded with an empty packet when we were not using XML based
> >> protocols. This broke the fallback behaviour for architectures that
> >> don't have registers defined in QEMU's gdb-xml directory.
> >>
> >> Revert to the previous behaviour and clean up the commentary for what
> >> is going on.
> >>
> >> Fixes: 62b3320bddd
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> Cc: Jon Doron <arilou@gmail.com>
> >> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> ---
> >
> > Do you plan to integrate this patch in 4.1?
> >
> > Thanks, Aleksandar
>
> Yes - I'm putting together a PR today.
>

That's great, thanks!!

Aleksandar

> >
> >>  gdbstub.c | 18 ++++++++++++------
> >>  1 file changed, 12 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/gdbstub.c b/gdbstub.c
> >> index ea3349d1aa..b6df7ee25a 100644
> >> --- a/gdbstub.c
> >> +++ b/gdbstub.c
> >> @@ -1669,12 +1669,23 @@ static void handle_remove_bp(GdbCmdContext
> > *gdb_ctx, void *user_ctx)
> >>      put_packet(gdb_ctx->s, "E22");
> >>  }
> >>
> >> +/*
> >> + * handle_set/get_reg
> >> + *
> >> + * Older gdb are really dumb, and don't use 'G/g' if 'P/p' is
available.
> >> + * This works, but can be very slow. Anything new enough to understan=
d
> >> + * XML also knows how to use this properly. However to use this we
> >> + * need to define a local XML file as well as be talking to a
> >> + * reasonably modern gdb. Responding with an empty packet will cause
> >> + * the remote gdb to fallback to older methods.
> >> + */
> >> +
> >>  static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
> >>  {
> >>      int reg_size;
> >>
> >>      if (!gdb_has_xml) {
> >> -        put_packet(gdb_ctx->s, "E00");
> >> +        put_packet(gdb_ctx->s, "");
> >>          return;
> >>      }
> >>
> >> @@ -1694,11 +1705,6 @@ static void handle_get_reg(GdbCmdContext
*gdb_ctx,
> > void *user_ctx)
> >>  {
> >>      int reg_size;
> >>
> >> -    /*
> >> -     * Older gdb are really dumb, and don't use 'g' if 'p' is
avaialable.
> >> -     * This works, but can be very slow.  Anything new enough to
> >> -     * understand XML also knows how to use this properly.
> >> -     */
> >>      if (!gdb_has_xml) {
> >>          put_packet(gdb_ctx->s, "");
> >>          return;
> >> --
> >> 2.20.1
> >>
> >>
>
>
> --
> Alex Benn=C3=A9e
