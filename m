Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132BAC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4EB4206CC
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPUS89p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EB4206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuRL-0001bG-0u
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVuQZ-0000cd-09
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:03:51 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVuQX-00008x-Ly
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:03:50 -0400
Received: by mail-lf1-x143.google.com with SMTP id w14so874532lfk.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dDsgPM8vgPS+dKPQqk8bK0tt1kCNWmDxVmzmU6UrxmA=;
 b=SPUS89p67+eDVW1t+HjEMPpTCJTBCfPLhm4YFB0sq6PLq8WwwjBdR8+KNh1eQeqZuR
 oxC7lheISkTWTIr8jxeOnPppWgt4KamCQ0fLWDnM3B07zi5nEcHMvNfQckDOTM31h1nv
 c9oPUBZICXi11MeD/0x15SOYfyizwi4Cbw/stLF+upmCV70ltzEI+hG4cSrdWTXYwvY+
 y6PM+dP/GR3+waAVXCOtEovFiWrXMR5WMFpQskm2Io6/3De5Z8ya50kij5my1wQLtZij
 BRQaHZdKG4e1oe6EqVj619KttYkWQ3wV385mgHRTzjxr7D8iUIbdHqatVRXdFavyS4wr
 /awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dDsgPM8vgPS+dKPQqk8bK0tt1kCNWmDxVmzmU6UrxmA=;
 b=Bl/c19sP4dJJxMTQdVm1hPCoH9vJqulZHASzkcYQpkzXI8UdZfPpQAnxDbThwJBxrH
 sGLvImrZ+p7Frj0yYldyr4Kc9QbQV47rUXKL24+NBh1Peh98VZhiJ+4PJmZExevh9ej/
 K9zlpfBFNL3gZEDJHwxeTCrkGK7u32HavaMkES8PJvA4sDPUrp6GoMTwiHO8zqh3Lt5O
 WJLaOXhD+NK3HCBPuPuBS/C0OoLbNPP9z8dAXATPZCf6iEAWOZ5lTuEIZAv139FZ+Erx
 DX2BtL1XBlMEkgnnoHfRKQkWFVB2hF9Iu2v0ZzqmvAikrlBscGUpKtxo2DAdV9ZGQqJM
 WcNQ==
X-Gm-Message-State: AGi0PuY7gW/5bKJ65ZMKVRHwqAUed2zhnZ/REqN94oNN3YWK8e0t+Gem
 e+s1Z8d+chgxOsI8Z44ukw/XxBt3jPS/PPO6Noo=
X-Google-Smtp-Source: APiQypIHwW+Tg1tO1awe4q1fpmSScF+g774ZP6FjOCfTwasibxqemF7XH+Aus1oGcUjDP0eyfoV4lWayaUuNnGOYhxU=
X-Received: by 2002:a19:4a05:: with SMTP id x5mr1184202lfa.17.1588673027258;
 Tue, 05 May 2020 03:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <1588663771-5534-1-git-send-email-chenhc@lemote.com>
 <2cff4b96-bb14-8a24-1bcd-71308b6dc070@amsat.org>
In-Reply-To: <2cff4b96-bb14-8a24-1bcd-71308b6dc070@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Tue, 5 May 2020 18:11:23 +0800
Message-ID: <CABDp7Vr3E8jKSxhXPVd-+qQpFk1v8aEmz2ZZvwDhMxJoHrMoiA@mail.gmail.com>
Subject: Re: [PATCH] tests/Makefile: Fix description of "make check"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Huacai Chen <chenhuacai@gmail.com>,
 qemu-level <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Tue, May 5, 2020 at 5:33 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 5/5/20 9:29 AM, Huacai Chen wrote:
> > The description of "make check" is out-of-date, so fix it by adding
> > block and softfloat.
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >   tests/Makefile.include | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 03a74b6..5d32239 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -4,7 +4,7 @@
> >   check-help:
> >       @echo "Regression testing targets:"
> >       @echo
> > -     @echo " $(MAKE) check                Run unit, qapi-schema, qtest=
 and decodetree"
> > +     @echo " $(MAKE) check                Run block, qapi-schema, unit=
, softfloat, qtest and decodetree"
>
> Maybe end with " tests"?
Thank you, let me add "tests" in V2
>
> >       @echo
> >       @echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given ta=
rget"
> >       @echo " $(MAKE) check-qtest          Run qtest tests"
> >



--=20
Huacai Chen

