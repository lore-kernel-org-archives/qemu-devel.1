Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8D9C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24084206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj/v2Uku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24084206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONgK-0007ak-8u
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kONWr-0004rZ-8v
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:03:29 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:46404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kONWp-0007Y5-4n
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:03:28 -0400
Received: by mail-il1-x142.google.com with SMTP id l16so1685321ilt.13
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5oKIWj/qbyq9bdnwTdh3j0nVEG4Zi3tOm4DJ7FEQ3F0=;
 b=Vj/v2Uku1I0kR6y4gN4BS//LPqbb8djqSrlL1LoUSItCFgvkIUtS/2e1pP++1uionS
 /RURXROaaLamNOm6/3sj9t7ggt4UeM4suN8DXWzIdQyUl4xeK6ZQjCR2nYJK0MLX3Ev4
 lpF/6h281v0vd7nx794zpOIyBGhBijP2iQQj4mWge/vNzTOrtEX73GEMNXg9HqoJBJ6v
 LUoSRC9j17enur9TJlqbykaM+2J8WUtkgujl9mn7nmK1d3D71s1Jdxm4vnQhOT+0jSD9
 /0rQu2owdYNrODsuByKBiCmF37OSnetnY+xRS+60CEUz7NYaU0El9kqXMJ/qrt7rIJzV
 z5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5oKIWj/qbyq9bdnwTdh3j0nVEG4Zi3tOm4DJ7FEQ3F0=;
 b=EWcUSVdVpSxSLMyZjqs870WLxhPb5ZyfHWg12vTl2jzqhqmMvdSG6Qu3/RPfE+e6MU
 LCAEhr6xzwSkHqGyHm4NWLLI+93vRHZ8rSYeIxXCfm6cuCaOefNaA0WnU7zRU7gc7z7U
 NHHsfeA4driPqmyjCU/Fsu9o9NTUctrvCJ5lio6zeVIHjNqLbTjZBe1ytF0VulLtaeYi
 AMYJknq+gmWHefUMr9SVhG11vJLXa+0XT+zBDNetp61a8MfmNe/bEzZcSAcL5JGe2Gcn
 YbSabw+fsGc0uRQtQD/YaFCJC3L/tyLfGG2WSuWE2WYml8up8iZEX/zQuEmEbea2XBDD
 WUww==
X-Gm-Message-State: AOAM530MXxYFNX/B5ID2p0Ea00awAjcSsp3pnRmahRTlKBxleXt+ojCF
 qS7GfTNEbtxyjSR6QMwi8PJVxCdyfocujUr2nxg=
X-Google-Smtp-Source: ABdhPJzb6uxWrJzC3lM4kAevNrqCQOu/KODTFbJXQ99sTmKnRYLB3Lcj42EsO0GQunzYMdUVX+bKzGq0MXQRw8LHxgk=
X-Received: by 2002:a92:5a47:: with SMTP id o68mr1801068ilb.267.1601654605626; 
 Fri, 02 Oct 2020 09:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <00b3ad01ce01027870a036bc4f6adc873bc3f7d7.1601652718.git.alistair.francis@wdc.com>
 <20201002155553.GA7303@habkost.net>
In-Reply-To: <20201002155553.GA7303@habkost.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 2 Oct 2020 08:51:59 -0700
Message-ID: <CAKmqyKNUzAnXFpktK601-L=FURWZ5wFnuoPLL=S8rfa=sbvc-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] register: Remove unnecessary NULL check
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 2, 2020 at 8:55 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Fri, Oct 02, 2020 at 08:33:40AM -0700, Alistair Francis wrote:
> > This patch fixes CID 1432800 by removing an unnecessary check.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/core/register.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/core/register.c b/hw/core/register.c
> > index 31038bd7cc..9ac9bc6bfe 100644
> > --- a/hw/core/register.c
> > +++ b/hw/core/register.c
> > @@ -258,7 +258,7 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
> >          int index = rae[i].addr / data_size;
> >          RegisterInfo *r = &ri[index];
> >
> > -        if (data + data_size * index == 0 || !&rae[i]) {
> > +        if (!&rae[i]) {
>
> I thought you were going to remove both checks.

Argh, I didn't realise that. I'll send a v2.

>
> rae can't be NULL, so &rae[i] will never be NULL.

Yep, good point.

Alistair

>
> >              continue;
> >          }
> >
> > --
> > 2.28.0
> >
>
> --
> Eduardo
>

