Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222A9C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2C820897
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AavEmyYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2C820897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO20T-0006Kn-GS
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kO1wA-0002Pf-BN
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:00:10 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:38388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kO1w8-0000Iu-8Y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:00:09 -0400
Received: by mail-il1-x141.google.com with SMTP id z5so6838776ilq.5
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iXUB1knWY6UZDRU9PTiKURym4LvzGQxrJZHS6IAXK0Y=;
 b=AavEmyYVg6i89B99IzNUbpdLbeVMJf6FKRJ8afpy7jfrn0Gt1Tds57szDwiVpBDH9B
 yWvlXRkGn5zDpUneWt0E0Qhnnul1y94dFeQ1hXC98aAfDtDj+zI68lOU6VxgeSxYA7lY
 LZs/0nUte1UyJrDNZEMuNwvvWphwl5wgVtXSZRjC6foDP9p2raSp2g/5tmzTzNooOEws
 x2K956jQ2RDzYKreFTIgYAmeyrHZgBocRZsxmr9wEvhD9mXp+AEOCSsubIuVCX2g77fq
 7h4/fzgmQZgxiZV6idS81cGAyddCrOZ0MpPcZDA6l5dF/uKAEf/zhYXRg33gJrRUGxat
 GHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iXUB1knWY6UZDRU9PTiKURym4LvzGQxrJZHS6IAXK0Y=;
 b=dU5Ndus3aB5o95HJ5MA8kv00sE1i57GK+KmXUjKxfHart0jrg5H4EfvTLyG3ARZyDt
 ILCsaU9t8qpu3iHpUNjRz3guZ0MPIBQwnWbc9kXeF6RknxYkWOWSCewtZoLLGZQLWUop
 9vAmudSEJtjwis8HnU3qtfjpBBji1vF08QmQBLPZCfKT3NTZ0hW9hXPc6OwLkPMLKako
 mKCS2Cb6799k30q0oEKacI26eAn8uhr/N9uunyFVNxKXt41vFAFoxMbK01NxcOvnattJ
 4QGWN2IsgfNlNvZrT6iaZLVGq3IotiRW226fBCAH2dz0lRhBpL+lFg/uPsO7VziYaz1r
 hMBg==
X-Gm-Message-State: AOAM533Bxmm71A/D+p0u4XFjHZi5HQOv1GaiRWpXhIejMdQoUWUKFeey
 KfOiEUb4YX1HPnCttUnMMqWh99Md6hEurPsPIiI=
X-Google-Smtp-Source: ABdhPJxEsGUww3SyR+2BSIDgy/YagmfxSXpkfRYal/oW78AHVFgR19xjUJ+6jnhhpHdyCeGNWO28cgctOpiX0fO+7/A=
X-Received: by 2002:a92:cd49:: with SMTP id v9mr3355386ilq.177.1601571607016; 
 Thu, 01 Oct 2020 10:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200927134609.2358960-1-alistair.francis@wdc.com>
 <20200927134609.2358960-3-alistair.francis@wdc.com>
 <CAFEAcA9Rduz5RB4oUD_wR41_oEfdRSbB8O=99pb+AjXM8gLG6A@mail.gmail.com>
 <20200929132216.GI3717385@habkost.net>
 <CAKmqyKMemWmj2we2uN0bYCFOyo3_dFhoBgeC4qRv7LFxj20ExA@mail.gmail.com>
 <20201001160452.GF3717385@habkost.net>
In-Reply-To: <20201001160452.GF3717385@habkost.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Oct 2020 09:48:42 -0700
Message-ID: <CAKmqyKM=RPSEZRBN0UbxvS0YOvLaJZqh=Q63+1eq9FRNsNmD2Q@mail.gmail.com>
Subject: Re: [PULL 2/2] core/register: Specify instance_size in the TypeInfo
To: Eduardo Habkost <ehabkost@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 1, 2020 at 9:05 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Thu, Oct 01, 2020 at 08:37:31AM -0700, Alistair Francis wrote:
> > On Tue, Sep 29, 2020 at 6:22 AM Eduardo Habkost <ehabkost@redhat.com> w=
rote:
> > >
> > > On Tue, Sep 29, 2020 at 01:55:35PM +0100, Peter Maydell wrote:
> > > > On Sun, 27 Sep 2020 at 15:00, Alistair Francis <alistair.francis@wd=
c.com> wrote:
> > > > >
> > > > > Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > > > Message-Id: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.=
git.alistair.francis@wdc.com>
> > > > > ---
> > > > > @@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_blo=
ck(DeviceState *owner,
> > > > >          int index =3D rae[i].addr / data_size;
> > > > >          RegisterInfo *r =3D &ri[index];
> > > > >
> > > > > -        *r =3D (RegisterInfo) {
> > > > > -            .data =3D data + data_size * index,
> > > > > -            .data_size =3D data_size,
> > > > > -            .access =3D &rae[i],
> > > > > -            .opaque =3D owner,
> > > > > -        };
> > > > > -        register_init(r);
> > > > > +        if (data + data_size * index =3D=3D 0 || !&rae[i]) {
> > > > > +            continue;
> > > >
> > > > Coverity thinks (CID 1432800) that this is dead code, because
> > > > "data + data_size * index" can never be NULL[*]. What was this
> > > > intending to test for ? (maybe data =3D=3D NULL? Missing dereferenc=
e
> > > > operator ?)
> > >
> > > I believe the original check in the old register_init() function
> > > were just to make the function more flexible by allowing NULL
> > > arguments, but it was always unnecessary.  We have 4 callers of
> > > register_init_block*() and neither rae or data are NULL on those
> > > calls.
> >
> > In this case *data is an array, I guess the idea was to try and catch
> > if somehow a point in the array was NULL?
>
> I don't understand what you mean.  The area pointed by data
> doesn't contain any pointers, just the register values.

Yeah, I don't think this was ever right.

The idea I guess was to make sure that r.data was not NULL, but unless
data was NULL it couldn't be.

Alistair

>
> >
> > I'll send a patch to remove the check.
>
> Thanks!
>
> --
> Eduardo
>

