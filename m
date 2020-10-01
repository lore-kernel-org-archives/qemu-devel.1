Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D875DC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C38D20872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaLQLsLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C38D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0t2-0007H4-8W
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kO0pG-0003Ce-Nj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:48:58 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kO0pE-000588-PL
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:48:58 -0400
Received: by mail-io1-xd43.google.com with SMTP id u6so7166247iow.9
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JqQAVUCi7XdpNp2minhVyLs3XiU/HhORo/OS1yRpvKg=;
 b=HaLQLsLOBJLkyWioGBiNE9sZgM94zKuhpiMGKuiLGbgDjAOEaBXiX+EO84TxtsWd9j
 4ZIQC8IVZXFI3nwpmJwUIo34qy0bJCj4/rgwSCLkf/hF7fNpR5i2fY2QYAoULb/6Tc0u
 5pQiEoC9aYn9+AKLQioXa+sSzk09O7rEH52CYVefT3MUVkHAw4cv7OHNjPwhhU8GPBCI
 EjaOfZp6VkCGOUK/eEcfM4hMAtHtPvMg0Cj9/Rc7ixEGqGBVc/a63kwTyHn/BKJo4//k
 SsEBT9/nXDrYPXhvi3t+2CEadrEWGpE7qMArzUXmHG3LYU1YGyyDJf1m6omjhbrQcvTr
 70wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JqQAVUCi7XdpNp2minhVyLs3XiU/HhORo/OS1yRpvKg=;
 b=LmtLrwnJMHWeeUjoDyMUkskeKTCZ5uFj3ePJbXu2pFLdRZYzjG+7zLCh0gbZnjJKhN
 5mB/hNIvmZiB9SIpZDwqehrmarSsy3r3z5RdN1HWN8Qk0Pw4MTZ4+fcUCLXO5syuyJak
 whnNtfbs8MdcPpqm7SZ0gWaa5TKVLJnVcLzinjZsiathoK5fGsuyxppgCcqDA43TE7KG
 54K4uqYtMU7E9+9Ko8nqugrNpOrHApooI0bSALu91m8iXzmlrmhkCT5aNp9oaUVgzt/J
 rsIvfZvZXCXIHE1sHWvCznsrSaGPB6lILPmcBVfymgZ68IfgOv3l16seldT3xgPAoWPw
 2qDA==
X-Gm-Message-State: AOAM531snbTCCgwYTjqjfwFuzQi+36cPjtUIBTiH57GBo7zadhRSKloq
 9Taj9rvhKEu/eLLXzr7ifaus/1ov93SU/CKueTM=
X-Google-Smtp-Source: ABdhPJziTMqM7gsRnUB2+8kldYYRPKkQzXiYyUgiQGvk1VzOx9O1hzR1NiFCMboPbQWFgcdHOm7h02Z6HSxmJtJbHr4=
X-Received: by 2002:a05:6602:2245:: with SMTP id
 o5mr5950876ioo.105.1601567335746; 
 Thu, 01 Oct 2020 08:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200927134609.2358960-1-alistair.francis@wdc.com>
 <20200927134609.2358960-3-alistair.francis@wdc.com>
 <CAFEAcA9Rduz5RB4oUD_wR41_oEfdRSbB8O=99pb+AjXM8gLG6A@mail.gmail.com>
 <20200929132216.GI3717385@habkost.net>
In-Reply-To: <20200929132216.GI3717385@habkost.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Oct 2020 08:37:31 -0700
Message-ID: <CAKmqyKMemWmj2we2uN0bYCFOyo3_dFhoBgeC4qRv7LFxj20ExA@mail.gmail.com>
Subject: Re: [PULL 2/2] core/register: Specify instance_size in the TypeInfo
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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

On Tue, Sep 29, 2020 at 6:22 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> On Tue, Sep 29, 2020 at 01:55:35PM +0100, Peter Maydell wrote:
> > On Sun, 27 Sep 2020 at 15:00, Alistair Francis <alistair.francis@wdc.co=
m> wrote:
> > >
> > > Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > Message-Id: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.=
alistair.francis@wdc.com>
> > > ---
> > > @@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_block(D=
eviceState *owner,
> > >          int index =3D rae[i].addr / data_size;
> > >          RegisterInfo *r =3D &ri[index];
> > >
> > > -        *r =3D (RegisterInfo) {
> > > -            .data =3D data + data_size * index,
> > > -            .data_size =3D data_size,
> > > -            .access =3D &rae[i],
> > > -            .opaque =3D owner,
> > > -        };
> > > -        register_init(r);
> > > +        if (data + data_size * index =3D=3D 0 || !&rae[i]) {
> > > +            continue;
> >
> > Coverity thinks (CID 1432800) that this is dead code, because
> > "data + data_size * index" can never be NULL[*]. What was this
> > intending to test for ? (maybe data =3D=3D NULL? Missing dereference
> > operator ?)
>
> I believe the original check in the old register_init() function
> were just to make the function more flexible by allowing NULL
> arguments, but it was always unnecessary.  We have 4 callers of
> register_init_block*() and neither rae or data are NULL on those
> calls.

In this case *data is an array, I guess the idea was to try and catch
if somehow a point in the array was NULL?

I'll send a patch to remove the check.

Alistair

>
> >
> > [*] The C spec is quite strict about what valid pointer arithmetic
> > is; in particular adding to a NULL pointer is undefined behaviour,
> > and pointer arithmetic that overflows and wraps around is
> > undefined behaviour, so there's no way to get a 0 result from
> > "ptr + offset" without the expression being UB.
> >
> > thanks
> > -- PMM
> >
>
> --
> Eduardo
>

