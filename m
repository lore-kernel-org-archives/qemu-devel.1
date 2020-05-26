Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E6FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 22:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F86F2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 22:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anjqwDtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F86F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdiXV-0004ht-Gm
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 18:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdiWs-00048H-I3; Tue, 26 May 2020 18:58:38 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:39622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdiWr-0007va-FU; Tue, 26 May 2020 18:58:38 -0400
Received: by mail-il1-x141.google.com with SMTP id c20so22229100ilk.6;
 Tue, 26 May 2020 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eDfxy0++XROwpEsafEQ9yfqaJc8TkJ0xi+rc7yTuJLo=;
 b=anjqwDtDdlRz/KgDNa0Mmsh4sAu9vzA/STOEvb9wdNbnMTVdUDu1SMQAdlWXivobsK
 HlJS0yUaar7sjP7xdkUCBDJBrvOeW03+zfgmWDxV7g2GywsSiXzKwvk4sCo0p0PjrrIu
 lJgYTQpRzKXrOzn2meGnzo9wPrv/OUTG3sbSwoqdxjZZwQDnqC0R6bJWS9vg3w0uPqeU
 bhsxWIaxyEIZ+/QQaA1Y4rgjI1OprvOJS/Wx0e/wtYb9JFekQfX8VMmvmbp2Oa3nWJdr
 FUph9enlDE9Sm+EI3pqE9haPULvZpUcEiI/BIMmolip6LRSdHSvyaDi85otor0GSlAdy
 DoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eDfxy0++XROwpEsafEQ9yfqaJc8TkJ0xi+rc7yTuJLo=;
 b=EukHV0GWacozhQLLqABuKzgeSPZ1MbmtczQ4BCKC4BoDHb/hJINorKePaYnB6r5W2S
 fo43fCefGmyvMyHOM9S2zcmnknFws4tVwlSKqVfe3+V2QzXhVU7zUeAtn23qsj/mNwNy
 rmlKhXGB4db4H/NAuSvSbk4+yxtMlGhtgNMpbgNaQ5q2e6esb+GAKwnYXacLmL12oEWP
 caSoFsKV0fZyVuP7772N6dg1qHJMc7zv+uJxKc9pMY39Ttibdu+F2NbM7bEc4PwEePe/
 x48Uor2IjrBhjFOdyLyjT+46/gMa6ME7dScXz/scY6hgsk3HF4fNAj6zWUY1DVj6+I/5
 Q/WA==
X-Gm-Message-State: AOAM533elAWCuvCT1/A1lAG1UpU3Bf8l1HbMaApv54f77zn1biXBjLGZ
 cXPYF6yKeNJUk4m0o1/Cmc0bn5dti+HE/3w3/Zj3q5vK
X-Google-Smtp-Source: ABdhPJzxgmvwx1BLuwTblhJ4FIgiHU9yfrUXNOh62Q4nQH9uYbxeys1W4mGi6SXFmdA/hphCD/wNc1yRGt87amjNUXI=
X-Received: by 2002:a92:48d1:: with SMTP id j78mr3460637ilg.131.1590533915614; 
 Tue, 26 May 2020 15:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200510203457.10546-1-f4bug@amsat.org>
 <7bdb49c1-5396-0bf4-5f83-3849910e5d68@amsat.org>
In-Reply-To: <7bdb49c1-5396-0bf4-5f83-3849910e5d68@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 15:49:36 -0700
Message-ID: <CAKmqyKOXjNTgUtvwBnm-=fY-i8zX=k23TkoWSM=3WuWAHioXAQ@mail.gmail.com>
Subject: Re: [PATCH] hw/registerfields: Prefix local variables with underscore
 in macros
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 9:50 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> ping?

I'll send a PR with this.

Alistair

>
> On 5/10/20 10:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > One can name a local variable holding a value as 'v', but it
> > currently clashes with the registerfields macros. To save others
> > to debug the same mistake, prefix the macro's local variables
> > with an underscore.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  include/hw/registerfields.h | 40 ++++++++++++++++++-------------------
> >  1 file changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
> > index 0407edb7ec..93fa4a84c2 100644
> > --- a/include/hw/registerfields.h
> > +++ b/include/hw/registerfields.h
> > @@ -66,35 +66,35 @@
> >  #define FIELD_DP8(storage, reg, field, val) ({                        =
    \
> >      struct {                                                          =
    \
> >          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;            =
    \
> > -    } v =3D { .v =3D val };                                           =
        \
> > -    uint8_t d;                                                        =
    \
> > -    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,     =
      \
> > -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);           =
    \
> > -    d; })
> > +    } _v =3D { .v =3D val };                                          =
        \
> > +    uint8_t _d;                                                       =
    \
> > +    _d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,    =
      \
> > +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);          =
    \
> > +    _d; })
> >  #define FIELD_DP16(storage, reg, field, val) ({                       =
    \
> >      struct {                                                          =
    \
> >          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;            =
    \
> > -    } v =3D { .v =3D val };                                           =
        \
> > -    uint16_t d;                                                       =
    \
> > -    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,     =
      \
> > -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);           =
    \
> > -    d; })
> > +    } _v =3D { .v =3D val };                                          =
        \
> > +    uint16_t _d;                                                      =
    \
> > +    _d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,    =
      \
> > +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);          =
    \
> > +    _d; })
> >  #define FIELD_DP32(storage, reg, field, val) ({                       =
    \
> >      struct {                                                          =
    \
> >          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;            =
    \
> > -    } v =3D { .v =3D val };                                           =
        \
> > -    uint32_t d;                                                       =
    \
> > -    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,     =
      \
> > -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);           =
    \
> > -    d; })
> > +    } _v =3D { .v =3D val };                                          =
        \
> > +    uint32_t _d;                                                      =
    \
> > +    _d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,    =
      \
> > +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);          =
    \
> > +    _d; })
> >  #define FIELD_DP64(storage, reg, field, val) ({                       =
    \
> >      struct {                                                          =
    \
> >          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;            =
    \
> > -    } v =3D { .v =3D val };                                           =
        \
> > -    uint64_t d;                                                       =
    \
> > -    d =3D deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,     =
      \
> > -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);           =
    \
> > -    d; })
> > +    } _v =3D { .v =3D val };                                          =
        \
> > +    uint64_t _d;                                                      =
    \
> > +    _d =3D deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,    =
      \
> > +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);          =
    \
> > +    _d; })
> >
> >  /* Deposit a field to array of registers.  */
> >  #define ARRAY_FIELD_DP32(regs, reg, field, val)                       =
    \
> >
>

