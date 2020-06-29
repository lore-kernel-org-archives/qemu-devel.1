Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A36C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5734A20724
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm5C9+V9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5734A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq1Ag-0007cE-Gf
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 17:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jq19K-0006bf-N0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 17:17:10 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:41192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jq19I-0003B9-N6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 17:17:10 -0400
Received: by mail-lj1-x232.google.com with SMTP id 9so19934957ljc.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Cor3noOZv309F5AD2DQpc2DUTU6UE2LakDF6OM9CAcU=;
 b=dm5C9+V9pa3Ta0Ciy+fOmhsMu7wPsWqBWpOWOTcSkLrmc2o6S/01kIBq57P6LJ1PKN
 YPdRLx3HCC0ePNhAH5rnV7sUVJEUUfDMdAwL3lPSjjwwod1AkWiCW8iTYXbRe7s8uTqE
 nAjjrg2v54iJQf+2CohczqkS/Ixdv//HK4WCAyuWaUwbSypH0xPcSDP4rcz0D2uxhEoS
 v2zYE2U39OX17QZrk8Zk7ZPH7eY6UAABmBTuIhJqKXQHn3hxhBq0v/bZouRVUcGiVA9j
 Wl//6UgHROh/5bRoRTYjpyeP96YkQ95CEVMahrf5AvaOzIWWNjhrS5k0WN9y30dsBCKu
 AODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Cor3noOZv309F5AD2DQpc2DUTU6UE2LakDF6OM9CAcU=;
 b=dm2T1ycoFJJS9K6R4l/baTDadvM4M5PTp2dtxx9d7326LAY1en9BQJKRG4OcnzNIiz
 M5vPltWLxShKId2XOUAsWRO+ZuW8T6xXSH/NQ9y+R7WFUPtu9qOJPC4VPtrKocwZXciw
 MQWfWrm2khCYR12MBvVmVytiBz5QIU3q3iYRvzrL7EGHcxtyScYDFaj3tbbEwCU3hHkx
 cv+tkRHwmpR4L60mMrw8xxDW0VU+cJqHaICdWI3jaZ6Jo6oo9uJ9rs9Lxzk7aOESz7Kj
 1C2c/Nv1AhOEHFeLKpzaPHmvhqTZB+GMdT1w2+nw+QQ+0I+yeYXbchPNUGLnJ0qvbcJg
 uwHw==
X-Gm-Message-State: AOAM53001FO+Ku4QaPnFR/R0LzBOnEqedDIKvy/EwlwhXPVyESEPgBeV
 f9pi8fsGvY/iCNZib1pOMnEz2yjZzFYxQrB0rQY=
X-Google-Smtp-Source: ABdhPJxaoVN3e0FviRClfajJueiGW4gjI6fig+6GGTi4p3ezIk3iDcEh++4RTSyR9Wqbh3xhJIUupHnZGdVLrC2WISU=
X-Received: by 2002:a2e:9b87:: with SMTP id z7mr4741227lji.80.1593465426218;
 Mon, 29 Jun 2020 14:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <878sg5svu5.fsf@linaro.org>
In-Reply-To: <878sg5svu5.fsf@linaro.org>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 29 Jun 2020 23:16:27 +0200
Message-ID: <CALTWKrWkaN3LX5aHwz2-dO04_puh7RqQa3_NfEG4KH5xBeV3Rw@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x232.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 6:03 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
>
> > Hi,
> >
> > The second report of the TCG Continuous Benchmarking series builds
> > upon the QEMU performance metrics calculated in the previous report.
> > This report presents a method to dissect the number of instructions
> > executed by a QEMU invocation into three main phases:
> > - Code Generation
> > - JIT Execution
> > - Helpers Execution
> > It devises a Python script that automates this process.
> >
> > After that, the report presents an experiment for comparing the
> > output of running the script on 17 different targets. Many conclusions
> > can be drawn from the results and two of them are discussed in the
> > analysis section.
>
> A couple of comments. One think I think is missing from your analysis is
> the total number of guest instructions being emulated. As you point out
> each guest will have different code efficiency in terms of it's
> generated code.
>
> Assuming your test case is constant execution (i.e. runs the same each
> time)
Yes indeed, the report utilizes Callgrind in the measurements so the
results are very stable.
>you could run in through a plugins build to extract the number of
> guest instructions, e.g.:
>
>   ./aarch64-linux-user/qemu-aarch64 -plugin tests/plugin/libinsn.so -d pl=
ugin ./tests/tcg/aarch64-linux-user/sha1
>   SHA1=3D15dd99a1991e0b3826fede3deffc1feba42278e6
>   insns: 158603512
>
That's a very nice suggestion. Maybe this will be the idea of a whole
new report. I'll try to execute the provided command and will let you
know if I have any questions.
> I should have also pointed out in your last report that running FP heavy
> code will always be biased towards helper/softfloat code to the
> detriment of everything else. I think you need more of a mix of
> benchmarks to get a better view.
>
> When Emilio did the last set of analysis he used a suite he built out of
> nbench and a perl benchmark:
>
>   https://github.com/cota/dbt-bench
>
> As he quoted in his README:
>
>   NBench programs are small, with execution time dominated by small code
>   loops. Thus, when run under a DBT engine, the resulting performance
>   depends almost entirely on the quality of the output code.
>
>   The Perl benchmarks compile Perl code. As is common for compilation
>   workloads, they execute large amounts of code and show no particular
>   code execution hotspots. Thus, the resulting DBT performance depends
>   largely on code translation speed.
>
> by only having one benchmark you are going to miss out on the envelope
> of use cases.
>
Future reports will introduce a variety of benchmarks. This report -
and the previous one - are introductory reports. The benchmark used
was to only demonstrate the report ideas. It was not used as a strict
benchmarking program.
> >
> > Report link:
> >https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-=
Into-Three-Main-Parts/
> >
> > Previous reports:
> > Report 1 - Measuring Basic Performance Metrics of QEMU:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
> >
> > Best regards,
> > Ahmed Karaman
>
>
> --
> Alex Benn=C3=A9e

