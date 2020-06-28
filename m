Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4075DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 17:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BA3206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 17:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poCOz/A6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BA3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpb0D-0007JE-Gc
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 13:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpaz6-0006aZ-SR
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 13:20:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpaz5-0006Qs-4r
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 13:20:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f18so13970316wml.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t9hJrbLE5JBq+WGVMzdO0Vb+G78uOkcAQUzPYX9WTL4=;
 b=poCOz/A6Gfxi3RQ3wfszXL4eYKkc1SFEynLD55NoK4zoxzV4DTDaxcIeeGLPzWPg3L
 1UAGNFDElbNpliHkvy9NnHoewtI7JMEE/7vU+ZdkXxTS5dwez616T0dvtyQ3DvmySjUx
 t1oet5/0SKnPOcVtfiTu4wb8uBohQHGTFkxa7o5hcHWFBQ2ZjoyODPkMouPrmgRR0Rba
 HEh1IqUvPSURZuvzg/adkhFiucTNFBssPXxGx31auoQI3FCWOeiNrq1ZW2EyuY/QZuWQ
 GX6f6pmBysLI/foOnUFen6ArfQLd9wKJjaBE/od5grRm9rzi152eMlp5LytDUVfpKE0c
 nhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t9hJrbLE5JBq+WGVMzdO0Vb+G78uOkcAQUzPYX9WTL4=;
 b=RhU2R+GB/0UMzkg8yUjHyNRWZ2MW3WVrio6JzL2gdiMnEHKvXR383FxRd8NtJcbSty
 MkXMmBe6PDSetiBLdKLL0Xx5IvM4PWRrHnZ70yxiXe27oREzzoGUUp8xvGPd0HYB9PgK
 0h1RcNQpvzTsowdhjPsMYNwT5rf65g4zUW8gzjrM3lyHwVytrJt8sTJKZgEUBAANbzCa
 tk00VRpChx9NfdCWRaKtj6EaiZhxgDOYe6yrKpGGWK0uwgm08czxPvgkvHJhk2PV4OJU
 nClkUlWIlBhCDdrgIfhYhxmyD8byTyen/x1/pKGRBKB0fuNt5w/TbX4B50xJ9ELlvJ6z
 MITA==
X-Gm-Message-State: AOAM531BDrU+qOPbxivlpoU1b6fEH12tArcni3U9H8gIHHA/CDqkscoy
 FFEGufDdBThsZdyCmGSfjsjg7L76hFLyEaKxZBM=
X-Google-Smtp-Source: ABdhPJxZCK6Q5wBAWywaPldODrQj7UUANpKK3pQH8gdhd8pxnVSM1a568JWcqw1Oy5ueyPtaKCxBAxY1cZC2vyyVxzI=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr14336861wmb.168.1593364849168; 
 Sun, 28 Jun 2020 10:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVWSvWOQVorXuC4HQbjSN=Tu+TDsc=mr1CUCL1cvJQS9Q@mail.gmail.com>
In-Reply-To: <CALTWKrVWSvWOQVorXuC4HQbjSN=Tu+TDsc=mr1CUCL1cvJQS9Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 28 Jun 2020 19:20:37 +0200
Message-ID: <CAHiYmc4Zbeo6A144PhXA_EmfPv6k4wpDr+=By3pUOp9-yeaFMA@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#1] Measuring
 Basic Performance Metrics of QEMU
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32b.google.com
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 22. =D1=98=D1=83=D0=BD 2020. =D1=83 12:31 Ahmed Karaman
<ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Greetings,
>
> Welcome to the TCG Continuous Benchmarking GSoC project!
> This is the first report in a series that will be posted here on the
> mailing list as part of the project.
>
> During the project, multiple Linux profiling tools will be used.
> These tools will help you profile your different QEMU execution
> scenarios, and locate performance bottlenecks as well as performance
> regression problems.
>
> To provide you with a better understanding of these tools, this report
> presents two of them - Perf and Callgrind.
> It starts with measuring the basic performance metrics when running
> a program using both tools, then it proceeds to calculating the top 25
> most executed functions in QEMU

Now, thinking longer about topN scripts, I think one really missing
thing is number of invocations (or calls, whatever term you prefer)
for any function in the list. This data must be possible to obtain
using callgrind_annotate (most likely by using --tree option). With
perf, i don't think this is possible, given that perf works based on
sampling.

You don't need to start working on it right now, or work on it at all
- this is more like a brainstorming suggestion from me. You can make
improvements and correction all the way towards the end of the
project, on Aug 31st.

At the end of the project, perhaps you can publish a "Master Project
Report" - a pdf that is basically a sum of all your reports produced
during the project. That would be a nice reading!

Regards,
Aleksandar

> To dissect the output of each of the two tools, a separate section
> for comparing the output results is presented which focuses on how
> these results apply to QEMU.
> Finally, a stability test is devised that compares how the output
> of the two tools differ with each subsequent invocation of QEMU.
>
> For easier accessibility, all reports will be hosted on a dedicated
> website:
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/
>
> Link to the first report:
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Measuring-Basic-P=
erformance-Metrics-of-QEMU/
>
> Best regards,
> Ahmed Karaman

