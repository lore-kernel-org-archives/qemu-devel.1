Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75422C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E2820672
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5mYyoy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E2820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joS5c-0007Dx-Ga
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joS4z-0006ir-CL
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:38:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:55777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joS4x-0008It-AU
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:38:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id g75so5581060wme.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qXZVqJvStszBG1q0l8VoWvlMdnD53+E5i+87SFfsX4A=;
 b=J5mYyoy7hnmmWNndPVnRmr4taDuDCYy6t/AH1RJyZ007dz8ndq9kdmMnDRmyahTF5Y
 F7BBwJQwbQr79URHlZpszQOaPWaN5uRz9lMUND6dwsr4xWfvlU42lDKI2rKsMFLhcABQ
 tm9ITIQWXkb3PPgd7Sx7TBpmFFazAbvZ7Sm4iOJkvBk+kuDcCbYo04HzYLrQiuvqSlDo
 LrYCa9NMbFPfV8HB0apwfyPjSMZ+lSK97uj7YPr0HmFyPUOE0Lo8doGBojtPnQnbc9ac
 +Mo6npgfS6+oBBPRBJ1iJNdbXZTKa0of/AjEHjDvw+x3e7OmvZVdE7R18Zd6DRiIQqth
 P52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qXZVqJvStszBG1q0l8VoWvlMdnD53+E5i+87SFfsX4A=;
 b=lQqtsWvTm2/DvbZ9iOAsc/ABuCFJS8OkpaRFawz0zNUGbeRjBnUxkY3uQWWl9YV9X1
 eiebKyb50EZxRo9gY2WGwpYLuuiimcZWF2+gDSlalxkCH5h8DtlcMPLPpklZudWpUNn/
 Iza9mw1hlcgM303Y3tMfvAjF6a8/MMeOJmTVRR8BOstVaGnAq7KK86waydTREo3dPezc
 nkeTxRiZmUaWGzbHkV074Zdsp8lhbJL9/OHZdFZ/wop21eKiOgoFZu7jRG9ggTzorPVz
 npSzI8TnKHRC3S/4Dvf0eQggDMEfAyOFUCPNz9vlHAZcly0of0WAi+s8ktkynUKdhMAg
 t2Fg==
X-Gm-Message-State: AOAM532TJXs0q955TniFvQhlDfDLSNywWdqw4QTOIW7zu06oRRk53O+Q
 F6zCOv5rdRcwCjarv9FZFNuuCIV4P7yhtGS4VQs=
X-Google-Smtp-Source: ABdhPJyslf8uxI0l0w75yOkXcNfLcbFKxmZJg1AmIVssNChlPKMHPttp6wQv+ex6NPDpzXwp1H9fy+i0skAH52jDs1E=
X-Received: by 2002:a1c:4444:: with SMTP id r65mr3277993wma.129.1593092289440; 
 Thu, 25 Jun 2020 06:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVWSvWOQVorXuC4HQbjSN=Tu+TDsc=mr1CUCL1cvJQS9Q@mail.gmail.com>
In-Reply-To: <CALTWKrVWSvWOQVorXuC4HQbjSN=Tu+TDsc=mr1CUCL1cvJQS9Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 25 Jun 2020 15:37:54 +0200
Message-ID: <CAHiYmc7TSJZ326892Q9H-MVXZDrpf9ZCL3Y0pUhEiaeOgK1xCQ@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#1] Measuring
 Basic Performance Metrics of QEMU
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32a.google.com
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
> most executed functions in QEMU.
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

In introductory section on Callgrind, maybe you could add the general
form of command line that performs profiling using Callgrind,
something like this:

valgrind --tool=3Dcallgrind [callgrind options] prog [prog options]

Not a big deal, you can do some fine adjustments throughout the project.

Thanks,
Aleksandar

> Best regards,
> Ahmed Karaman

