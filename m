Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E14C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 12:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B13217D4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 12:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEA1W2A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B13217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpXVp-0005e1-KK
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 08:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hpXVd-0005FV-TW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hpXVc-0000im-L3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:33:41 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a]:33415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hpXVc-0000iB-EM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:33:40 -0400
Received: by mail-qt1-x82a.google.com with SMTP id r6so34067448qtt.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rjDkA+n0gbzJRqfTyvEs6tqRlmGfCRHnXeNGm6Jf30k=;
 b=EEA1W2A1MlVrkSnq80HHHSxkrT23aK5D6zmqpVn854vxbwd3DVgAdbH35829EM2YTt
 joDYj2NEbYXWQQlbha8JHDiGBi18vRNarm9KClN65Fio3BcE7yj1lumGew3QBuR7Gk4U
 NhKMD36BWlSnc6rExrLTwVHCfzRD4+oDxsWB/CZYKzWec2zwzXSj37iPmRr+NmspxcXQ
 i1E2hrJKXe0/Wv7GddG60Uc26dVVCHzIUmRHIDTQYKirQVHLlR0xZuG4haeoBG3GDslZ
 5lmh7AH3M9osjzpV32GxZQJsqWkUV+eyJfHzX6cxVgmJI+KBRmDJDEHox9yeqBIaG8u4
 TLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rjDkA+n0gbzJRqfTyvEs6tqRlmGfCRHnXeNGm6Jf30k=;
 b=W0j0eHM13eJCBWA6kqNLGZTnaQKNFA+9S/8A5VIaI2NLh0XsLtR2lUZNo4gnZU3PZu
 ajUzL3gwOlS46mp35sZ4mLEl27i51UGiBdfiu/AqSlrm+uvADxQgNcmj6inTnVPdsNlT
 pjbqiTCEVS4wCrq+nQbzVLprXAKbo2FnluVZ7rRykLgeTr1xm6F9tfniO4Jlk3nlW7Um
 /tML20LoVxip5GZY7Qrsy+NMbUPYNdxYBI6bfeneg1nqNF8TXlV6FsvByvzUNRTHPrQG
 lMSQz6uGoFfYjpNaX5buOQnBJgYaQ3s2wVpw/0qmAnIUU48Dzwcq0zMZ4Y7803jq6rqu
 BnMg==
X-Gm-Message-State: APjAAAWHad/C8rCSX1AUQox9w41xQQLsN79Gb13r5xm47ueGT8DZRhxl
 zZS5wmbB8FsUu5q/2ApVwljx798rsHIaMPdRCV8=
X-Google-Smtp-Source: APXvYqwgxOOn+Qg2m1Mb6JXiIjS1wLVt91bCkURvQwbwgtckrK9+UTazS6qc9bRxUHEDLB+LkbCmO21+aMP/dgPzOJY=
X-Received: by 2002:a05:6214:13a1:: with SMTP id
 h1mr48311281qvz.190.1563798819585; 
 Mon, 22 Jul 2019 05:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-9-mrolnik@gmail.com>
 <da64fd46-c0f0-b6b6-3b8f-d3da9041605d@redhat.com>
 <aa9f5be1-3451-7f58-a868-bd31bf2af236@redhat.com>
 <CAK4993ggAtRYDHUe3KpdC8UfSmofNuoeT346inD7_AG45xFMDw@mail.gmail.com>
 <0a74e963-8465-e45e-b5af-6c543c2c7454@redhat.com>
In-Reply-To: <0a74e963-8465-e45e-b5af-6c543c2c7454@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 22 Jul 2019 15:33:03 +0300
Message-ID: <CAK4993i6uGJahzxRFGHyBqSzNrfb3Q=kUbQkjcLmTQSVem63dA@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v27 8/8] target/avr: Add tests
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I changed it to info_report.
raw binaries are totally fine, however if a user supplies a damaged elf he
will never know if no warning/info is reported.

On Mon, Jul 22, 2019 at 12:41 PM Thomas Huth <thuth@redhat.com> wrote:

>  Hi Michael,
>
> On 22/07/2019 11.16, Michael Rolnik wrote:
> > Hi Thomas.
> > where should I specify this command?
>
> In patch 6/8, you introduced the error message:
>
>         if (bytes_loaded < 0) {
>             error_report(
>                 "Unable to load %s as ELF, trying again as raw binary",
>                 firmware);
>             bytes_loaded =3D load_image_targphys(
>                 filename, OFFSET_CODE, SIZE_FLASH);
>         }
>
> You should fence it there like this:
>
>         if (bytes_loaded < 0) {
>             if (!qtest_enabled()) {
>                 error_report(
>                     "Unable to load %s as ELF, trying again as raw binary=
",
>                     firmware);
>             }
>             bytes_loaded =3D load_image_targphys(
>                 filename, OFFSET_CODE, SIZE_FLASH);
>         }
>
> Also, is this really an error, or should this rather be a warn_report()
> instead? Or maybe you don't even need this message at all, in case raw
> binaries are a valid alternative?
>
>   Thomas
>
>
> > On Sun, Jul 21, 2019 at 10:13 AM Thomas Huth <thuth@redhat.com
> > <mailto:thuth@redhat.com>> wrote:
> >
> >     On 19/07/2019 15.26, Philippe Mathieu-Daud=C3=A9 wrote:
> >     > On 7/19/19 10:26 AM, Michael Rolnik wrote:
> [...]
> >     > Testing shows:
> >     >
> >     >   TEST    check-qtest-avr: tests/boot-serial-test
> >     > qemu-system-avr: Unable to load /tmp/qtest-boot-serial-cOndewD as
> ELF,
> >     > trying again as raw binary
> >     >
> >     > I wonder if this might fail Peter's testing, so Cc'ing Thomas.
> >
> >     Such messages are quite a bit anoying during "make check", indeed.
> Could
> >     you please fence the message with qtest_enabled() ?
> >
> >      Thanks,
> >        Thomas
> >
> >
> >
> > --
> > Best Regards,
> > Michael Rolnik
>
>

--=20
Best Regards,
Michael Rolnik
