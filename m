Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4804C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E55123787
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdl1wE4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E55123787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprIQ-0001Fd-Of
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jprHS-0000Qu-6l
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:44:54 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jprHP-0003BU-70
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:44:53 -0400
Received: by mail-ot1-x341.google.com with SMTP id 5so13014624oty.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=H++5/gUeSQbzk2qIpP5YH4q4Yy3WRFaFB4PEMrTFYJk=;
 b=Pdl1wE4NbpRJTYtny+RI06jUpWndkN1x8mEUJelZOqZfInLInhnXR+el3X1/TKGwSZ
 VsmGJ8vwNN0oelRcvGgW6vcnj3MUx7tqy4wCSoV1LLyy2r0kJOJPRYkh/f35oeIeNM7z
 tkOFUpPuKGTPNtWn9tnIB5LfNJvkPDgmat9vw1pQ62y2ufLBfKKSxP/3CztY+bgiQgS4
 QhZUp9yxhInSw5KyhTpTvZUvA/iMz7Jc8aQZ43MwuuohhozFEIap+OZJaosPIthw0oQ9
 4jEketZ75eKAQ82y02y55RkuOVnl7/J44dHX7BbLcFQRouIScQ2OgqEFHNbEwrMw95FO
 7IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=H++5/gUeSQbzk2qIpP5YH4q4Yy3WRFaFB4PEMrTFYJk=;
 b=dz4lmeEFYZWC7Hg4SevX3bd/H0fMdjfZ87TxxAVPZgFk7hfsLAMiSItR8WpaElBbhV
 hUDOfvF9XAlxzMuJYtG27Ak58k5q4wv5EyoUutityBo6/7ote16hPNjz5JmcL0wBdMq+
 Mk9GPfwuu6TLbv3xfDbhyyG8iAPhJ1wPw5uROJytu0dFI/n8fV5d3mOZDHJvfEzWt49U
 J/NvHpuaLCtPO10YqZkgHo8mZZnBtqLk7q9pA3ZpZKGgCKgL14DD0Fq5gVQXJxiOWEl7
 hKp4uGcAiRC134ejj2UUyYCwCnSNGFkGoN25nl47j53nySnIooj2PffvnrmQak0kcZdb
 NsVQ==
X-Gm-Message-State: AOAM530voU6bvLTdm3WnuIJcyMSEaGIFVJ3Msr6QvrvOK7h82KSLsRW5
 4sm1cNUwZrPg0BOS27NIqysZ2mpG8H6a8XiTPLM=
X-Google-Smtp-Source: ABdhPJyw11jbhQGOt3GYvlunv6Ntz5tQcL8tKPhkdbZJJVwdp6ssON158qx5tI0YA+HDkCEUs6Gk802DSZZ0Y4YuQ10=
X-Received: by 2002:a05:6830:1ad5:: with SMTP id
 r21mr9177669otc.181.1593427490013; 
 Mon, 29 Jun 2020 03:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-8-ppandit@redhat.com>
 <7ffe6cd9-fc23-3fdf-6c57-7bb0af0dd030@redhat.com>
 <nycvar.YSQ.7.77.849.2006251427210.92950@xnncv>
 <CAFEAcA9yP=y9nzvqs_GZF=n9EXz7SPY4kiR6ZqHF+T+f7mnV5g@mail.gmail.com>
In-Reply-To: <CAFEAcA9yP=y9nzvqs_GZF=n9EXz7SPY4kiR6ZqHF+T+f7mnV5g@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Jun 2020 18:44:14 +0800
Message-ID: <CAKXe6S+E2gnqmSnPbDkj+Dh-KAHvPwSCw+jSb7QmgxWzTO=wyA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] tz-ppc: add dummy read/write methods
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2020=E5=B9=B46=E6=9C=8825=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:22=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, 25 Jun 2020 at 10:18, P J P <ppandit@redhat.com> wrote:
> >
> > +-- On Thu, 25 Jun 2020, Philippe Mathieu-Daud=C3=A9 wrote --+
> > | > @@ -196,7 +196,22 @@ static bool tz_ppc_dummy_accepts(void *opaque,=
 hwaddr addr,
> > | >      g_assert_not_reached();
> > |
> > | This is a shame we now have to fill the read/write handlers for
> > | unreachable code :(
> > |
> > | > +static uint64_t tz_ppc_dummy_read(void *opaque, hwaddr addr, unsig=
ned size)
> > |
> > | I'd instead use a clearer:
> > |        g_assert_not_reached();
> > |
> > | > +static void tz_ppc_dummy_write(void *opaque, hwaddr addr,
> > |
> > | Ditto:
> > |        g_assert_not_reached();
> >
> > This will likely be called in tz_ppc_dummy_accepts() above. Do we still=
 want
> > to revise this patch? considering read/write callbacks are unreachable.
>
> The point of g_assert_not_reached() is that it documents and
> asserts that the code is not reachable. If the read and write
> callbacks are unreachable (which they are) then having their
> bodies just be a call to g_assert_not_reached() is the best
> way to document that.

I agree with this.

Thanks,
Li Qiang

>
> thanks
> -- PMM

