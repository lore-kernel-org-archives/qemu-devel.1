Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43973C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA0925584
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8/NupSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA0925584
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwKX-0000CR-A4
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jpwFu-00046n-K1
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:03:38 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:36889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jpwFs-0000Fc-3R
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:03:38 -0400
Received: by mail-wr1-x432.google.com with SMTP id a6so17092905wrm.4
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HwyPxTQQ5I1ijdgU0FZDIXSsnP4Nm69LJMsIKdswmE8=;
 b=t8/NupSLtY8WIgF1OVzrmQJwMkyEkPaFuOib6K4JC7mQnPhODsiIe1bN1y5OsXKhiY
 4DBZdCZBieydKDS0eRys6ZR0p7Xc4ahv0+WYeQfQD4RKsWltLRC8gXEQhtloLZV0egZr
 P29Fw/o251kBzYdo6LrhZE0fQMzC06YSZqlpeJRMh/vU8FF03aks0IBbH0IiWKATe5/E
 qmwjPtT1ji8Uv0eDCYW3JOmhiAwgd3gy7hYtJjaUhcc2XyPdgpp8WHETLKJmQ0jaUOjt
 r2Eq1naunTxnCxP6iGUQSVS7kJUSWU2Uz7FLzSXEKSQbTpx4L1eFGHF1HLLDF1NoIrzN
 i4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HwyPxTQQ5I1ijdgU0FZDIXSsnP4Nm69LJMsIKdswmE8=;
 b=qByHKxydm6krVg3wYS9ENXS4G+44s4qab9qFcEA1NkJQkUgTGycPVkG60tQTTVf/0I
 Aq/my8yhxBLY4ACoApBm6PGk3EM7IQZvOQUI+VtLSDfx9Y5aRZZ9ZjghMHrD3VFqAM5K
 Sz618jjZ50CMgA4mwYkpxRHZLs4zQspEmLLfeb5FxgcwQydDak4p0M9aSGe+2raQQnu8
 pqdkAyFO/fGiIzyl8Bh0fCEJzho8p0GS8N1/u9+L09QLWqNexXqL8mHb6+r88HaqjAqx
 3dczVolzAgNaLmU/sJoRM6boLHqeyQbMWgvV/rBpMDSe0xExFrXsURzFCdlJlI3886rQ
 h27Q==
X-Gm-Message-State: AOAM532zB8ssC3r6LegFGZ9WXLJitDnKKGnOXYbb40VfW54Bp9RINr6R
 aFIjYUIhs4gdKeMU1HcA3P09Fg==
X-Google-Smtp-Source: ABdhPJyUtZbvESiR1zaqWHHxNpWw2vIdV5tto8sryiv64KpwHJ+tla6vpSZdPkfWse0AjIXDK0qk4Q==
X-Received: by 2002:a5d:424f:: with SMTP id s15mr7539530wrr.342.1593446612530; 
 Mon, 29 Jun 2020 09:03:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k126sm321210wmf.3.2020.06.29.09.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 09:03:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 47CAF1FF7E;
 Mon, 29 Jun 2020 17:03:30 +0100 (BST)
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
In-reply-to: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
Date: Mon, 29 Jun 2020 17:03:30 +0100
Message-ID: <878sg5svu5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:

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

A couple of comments. One think I think is missing from your analysis is
the total number of guest instructions being emulated. As you point out
each guest will have different code efficiency in terms of it's
generated code.

Assuming your test case is constant execution (i.e. runs the same each
time) you could run in through a plugins build to extract the number of
guest instructions, e.g.:

  ./aarch64-linux-user/qemu-aarch64 -plugin tests/plugin/libinsn.so -d plug=
in ./tests/tcg/aarch64-linux-user/sha1
  SHA1=3D15dd99a1991e0b3826fede3deffc1feba42278e6
  insns: 158603512

I should have also pointed out in your last report that running FP heavy
code will always be biased towards helper/softfloat code to the
detriment of everything else. I think you need more of a mix of
benchmarks to get a better view.

When Emilio did the last set of analysis he used a suite he built out of
nbench and a perl benchmark:

  https://github.com/cota/dbt-bench

As he quoted in his README:

  NBench programs are small, with execution time dominated by small code
  loops. Thus, when run under a DBT engine, the resulting performance
  depends almost entirely on the quality of the output code.

  The Perl benchmarks compile Perl code. As is common for compilation
  workloads, they execute large amounts of code and show no particular
  code execution hotspots. Thus, the resulting DBT performance depends
  largely on code translation speed.
=20=20
by only having one benchmark you are going to miss out on the envelope
of use cases.

>
> Report link:
>https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-In=
to-Three-Main-Parts/
>
> Previous reports:
> Report 1 - Measuring Basic Performance Metrics of QEMU:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
>
> Best regards,
> Ahmed Karaman


--=20
Alex Benn=C3=A9e

