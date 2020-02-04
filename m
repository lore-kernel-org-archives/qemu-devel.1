Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A8C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273202087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJRsniL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273202087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytJV-0003ti-Bb
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iytH4-0001L0-BT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iytH2-00085g-VG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:09:33 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:46466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iytH2-0007xg-QM
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:09:32 -0500
Received: by mail-oi1-x230.google.com with SMTP id a22so17522770oid.13
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 00:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y/hic+1/P7Wf9mIgio8dFV0elgsobIybXOU4vvDyYLU=;
 b=aJRsniL3K3INMPvbrBfSCv1RwYDmrtF9RQRA4wQ8Gw4O++4ugKzpo9E0cYeqr5eaBR
 +2JV7fhQ+DF5oqfqMsfM0lwLoW1eNRlSSf6y76OoKj5QTA5Hb0aZYBKjFKAJsKyasTOF
 G9JqDlnLj2eQPB6gsq8yTx/J+MTk+dfEihYtcmWtntc8cTlGBhfK8zmZWQRCFf0mmItQ
 /K6P1DzWkNMd6v1IC8Pz3kmWOYeI2EPR2UlD5PhV/H1Osv4lSOZjyPv+Iwz6vvWFSj37
 FK5YXafhCJZp2fm9smP2sebMFNwOoohs3HOIvMBxirprEtVJGGKQpSteHV9NyNigr9yi
 +HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y/hic+1/P7Wf9mIgio8dFV0elgsobIybXOU4vvDyYLU=;
 b=Kt6s6ABp0X9nmLvYNWECBdmkW+Q4xW4kvD4IZ1d0IgF8qrEsIdlW7fvsdOdIQsDF0d
 cm0XtHqb6D6jI7tH4ZTnZe26UoOkikAY0xMYy4D9hMA/xwIA8eVmr94nVko1ySqdj6ax
 to0brP+P6KjF+qL7hkl/kYSbAMO+AzuAPqayR4yV4pAdaH0lCgyzz8VJMwFqT36ItrVB
 qlrU16f1ece8FH66mrFXFz5Xc2zATuTg8X03x+2+C5uKIasS/HLXPzvTpy/o3H+4G4RE
 FirFFaIoQ9CMvAv2VzzBt3yHOsHdOX02UYf9zDm5XUzUTRmjXlYd1akMplTW4ebTUhdF
 xLcA==
X-Gm-Message-State: APjAAAXb0eIV1puY4WWgGa2Kuv9R32sZnAC9kFVBSf1AxEwObyhYhXMZ
 N6l8aVf6duqP2bkU6PnOkcLQt6r7ynyZ5v1X4Sk4yV0K
X-Google-Smtp-Source: APXvYqwwH1hO/fqb10D2ksUIvc7bNsesKKjY+xwC5A/I/uez9MQ+NJQK9HdfTCd+dpMD7sdKfpt/5zOQYnyx1pB+zSc=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr2500749oih.79.1580803771688; 
 Tue, 04 Feb 2020 00:09:31 -0800 (PST)
MIME-Version: 1.0
References: <1580798552-703-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1580798552-703-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 4 Feb 2020 09:09:20 +0100
Message-ID: <CAL1e-=g+_3MeZfA5Hj2exBB2SZfFDuuC9UAOATuL79Yaakpiig@mail.gmail.com>
Subject: Re: [PULL 0/3] MIPS queue for February 4th, 2020
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 4, 2020 at 7:43 AM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit f31160c7d1b89cfb4dd4001a23575b42141cb0ec:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200203' into staging (2020-02-03 11:14:24 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-feb-04-2020
>
> for you to fetch changes up to 78e91b612eb746c7916cce3ea91f709b916b007c:
>
>   target/mips: Separate FPU-related helpers into their own file (2020-02-03 23:55:53 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for February 4th, 2020

Peter, please discard this pull request.

I just sent PULL v2 that corrects a mistake in a comment and improves
a commit message.

Sorry about this.

Aleksandar

>
>   Content:
>
>     - fix for a recent regression in LL/SC
>     - mechanical reorganization of files containing helpers
>
>   Note:
>
>     - six checkpatch errors and two warnings are benign and should be
>       ignored
>
> ----------------------------------------------------------------
>
> Aleksandar Markovic (2):
>   target/mips: Separate CP0-related helpers into their own file
>   target/mips: Separate FPU-related helpers into their own file
>
> Alex Richardson (1):
>   target/mips: Fix ll/sc after 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f
>
>  target/mips/Makefile.objs |    5 +-
>  target/mips/cp0_helper.c  | 1678 +++++++++++++++++
>  target/mips/fpu_helper.c  | 1911 ++++++++++++++++++++
>  target/mips/op_helper.c   | 4422 +++++----------------------------------------
>  4 files changed, 4044 insertions(+), 3972 deletions(-)
>  create mode 100644 target/mips/cp0_helper.c
>  create mode 100644 target/mips/fpu_helper.c
>
> --
> 2.7.4
>
>

