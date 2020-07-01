Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A345C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4437B207BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgrqhXpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4437B207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqe2w-0003Nk-DF
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqe23-0002sD-Bk
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:48:15 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e]:41211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqe21-0006HB-I7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:48:15 -0400
Received: by mail-lf1-x12e.google.com with SMTP id c11so13778479lfh.8
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mtiRJqq4EGHSNPsUHhnosJvJZSy8d05CETSgjulDo1E=;
 b=NgrqhXpvJvgXxXJFYFHI6mOMxjx88YcA7T0ejFyGXKGAwDrcT0KqbpWFtcRoobZ9y0
 L6jjv71BZD1VB4mWvCmPsFeoiIA/kjpLSSNdrk38r6a3Ui3A87DFQV+3FH2KKXPsh5Wv
 iC61VCFV27yizYn6hh4EN1nKGiwAoplK2OZAo3JKP794Ms8Gkue6HOH2Vi23kR9m5UKO
 2cnTQa99no6pWO1aDmRcmJv1618y5fLrV86x7b3gAsOLkhtyFdMacxVGI9L6Plmtw2xK
 l5gbtZYBeNhaIR3RhkWB7w2vrI8/CpefGIxvEpttqBU/QD66dovrYIgtFTQDlT9WKPqo
 GRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mtiRJqq4EGHSNPsUHhnosJvJZSy8d05CETSgjulDo1E=;
 b=LfDOYwHNz1an7BjtLqpCHUN3yXPb676pD4XSMCzVAewctHifJ9b1RtRVzm6kMhA91E
 iBbWVVESK/+FS9O5SsDV/6CAVG+gbzTTewafS9SXC+5Iapktpjo91Jv2rc+Gz7lA+gS7
 cRmcMnOgxKhWmnxk1YBdMFB/atkgsZBa0r+gHP3OlObzH8dFW9heDKJnt7XqzuJYIQVH
 SQP6vKLf5atdacw0CDvDbM8gb8X4Rca+C6TS+KvMY3L1MZnMIIkivssqImUEBRhSmM+E
 QSeN3GP9zNqwgpQlF6SX9Wwv1pSa41J7vh0rhK3OtzW3YGmi9krAPMiv8NPSn6Y66X8X
 KSnw==
X-Gm-Message-State: AOAM532hPcepxIu/KVJszaarWsvAoH9f1qlWVUfFXU04flib8t/mt2Aw
 G3xcmVZ7nD3Q5WOMPxh+HTbjXReyLhUZMDRyH6Q=
X-Google-Smtp-Source: ABdhPJwnILnu/+GLysyedJLj70dfC+4X8ZcAK68kAeaxf+zxTJmQmdypSHacewpEWeaUp5e1zXKliccj7jCWdlc5dtA=
X-Received: by 2002:a05:6512:49d:: with SMTP id
 v29mr15539216lfq.134.1593614891755; 
 Wed, 01 Jul 2020 07:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
In-Reply-To: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Wed, 1 Jul 2020 16:47:35 +0200
Message-ID: <CALTWKrXVzvL9v92oNwYB3CpjdniERqV0XRtgg8DTsxUD3W2gwg@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 luoyonggang@gmail.com, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x12e.google.com
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 12:25 PM Ahmed Karaman
<ahmedkhaledkaraman@gmail.com> wrote:
>
> Hi,
>
> The second report of the TCG Continuous Benchmarking series builds
> upon the QEMU performance metrics calculated in the previous report.
> This report presents a method to dissect the number of instructions
> executed by a QEMU invocation into three main phases:
> - Code Generation
> - JIT Execution
> - Helpers Execution
> It devises a Python script that automates this process.
>
> After that, the report presents an experiment for comparing the
> output of running the script on 17 different targets. Many conclusions
> can be drawn from the results and two of them are discussed in the
> analysis section.
>
> Report link:
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-I=
nto-Three-Main-Parts/
>
> Previous reports:
> Report 1 - Measuring Basic Performance Metrics of QEMU:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
>
> Best regards,
> Ahmed Karaman

Hi Mr. Luk=C3=A1=C5=A1 and Yonggang,

I've created a separate "setup" page on the reports website.
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/setup/

It contains the hardware and OS information of the used system.
It also contains all dependencies and setup instructions required to
set up a machine identical to the one used in the reports.

If you have any further questions or you're using a different Linux
distribution, please let me know.

Best regards,
Ahmed Karaman

