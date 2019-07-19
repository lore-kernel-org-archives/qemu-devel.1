Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22675C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E479821849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUhzQKLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E479821849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoQnV-0001eI-4o
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 07:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34417)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoQnL-0001EA-89
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoQnK-0004io-8D
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:11:23 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:44476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoQnK-0004i6-2D
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:11:22 -0400
Received: by mail-ot1-x32e.google.com with SMTP id b7so32272815otl.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tY9kweh1a3zqDq9ZuVKK8f0DLTDET8dYAzpexDaploQ=;
 b=GUhzQKLz1njaPHgothghIoDK6B5peCqFIgiKiRdBxVe8a4LuIJcbbA/ruP//VotN+q
 7N/ts7EZs+ei+/GIWulinIPIFV0AiELpInQQdIFHS11q19pj7qDWGpOFpG6MkauBMxGD
 VIgxCdDa2hfkrFzM5KP9jVmJnEVGx2Lp0i3iM1Nv+rOw2jB0OXsJ/U2cbnV5wkZBp5RM
 R4OAtYaKdSErnTamD7P+quzSqZes40AN0+8LmdAG7S4EnQntrRyI6LtR22a+OFTH3R1g
 /Zz3DmSgXhAgnFco99XmpBmyTts3vbYcruT5Q3yJa62sukwooVMuUbs+tbi6o0aVmUzT
 Y1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tY9kweh1a3zqDq9ZuVKK8f0DLTDET8dYAzpexDaploQ=;
 b=Jsf1sLvlDruxn0WJxRCybLunQKnX57wbPrvH8Ot+JS8btkC9d6SLFJfFhdQ2EsQRyA
 Vm4hGCK8UOCPrbdKbTt2+RL4UXmoqBbxibWRkMq5H6HHr5bqbWmQCxa5Fu0tymbjhvbQ
 IhoUDeMJxIzSsIhptOT57upqJJhdGU0U39Q9amnUU3pVqcJUDVWTvyRXVpcTkUtlnnGQ
 PiXzF3LJaFL4rKFmfVZqPzJIBBkjkPc+1fmROsXMgLG7NvXi7qP//Qja95vcZaeJnItB
 aPB3Rm13vHP9/fSYonxwmAxBkHCWHPMvgv/1ckYzlOZCAevjz68UmcC06RZKo4GegO3O
 kOYA==
X-Gm-Message-State: APjAAAXRPV7p/xPfhwT9RULX9rEdvxNrLKm36fLHuO7ZtYQlEQEqd0r1
 2HANv1TPGbbLCvEFKEOYNRfJkjn4F1Z4dCF41LnT2g==
X-Google-Smtp-Source: APXvYqyb1O4mXr76hgmuuobu8OgUflrOYqSmuD8pQIlG0FScmE6IrEaxNhoC7HvylEbLdtQcip4hkCkvvFPy+l6EW6A=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr36435938otj.97.1563534681206; 
 Fri, 19 Jul 2019 04:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190719015811.14776-1-palmer@sifive.com>
 <CAFEAcA_MGz=EvH67twNoM-SMXZ8_pE6FhO+JuLN=0Z1H6sfRnw@mail.gmail.com>
In-Reply-To: <CAFEAcA_MGz=EvH67twNoM-SMXZ8_pE6FhO+JuLN=0Z1H6sfRnw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 12:11:10 +0100
Message-ID: <CAFEAcA9mR5XxV9ghSzt4PbANKZJW1xKMGF1a9+ak+m6OyZ-YZQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for 4.2-rc2
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 12:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> This passes the 'make check' tests but it prints out a lot
> of warnings as it does so:
>
> qemu-system-riscv64: warning: No -bios option specified. Not loading a firmware.
> qemu-system-riscv64: warning: This default will change in QEMU 4.3.
> Please use the -bios option to aviod breakages when this happens.
> qemu-system-riscv64: warning: See QEMU's deprecation documentation for details
>
> (repeated 7 or 8 times during the course of a test run)
>
> Can we make the tests not trigger warnings, please?
> (I have a filter where I search through for strings like
> "warning" because warnings that shouldn't happen often don't
> actually cause the tests to fail.)

Forgot to mention, but a common way to do this is to say
"don't print the warnings about bios image loading if
qtest_enabled(), because with qtest we never execute any
guest code anyway". That will probably fix the warnings here.

> Also, I notice that you have a typo: "aviod" should be "avoid".

Also also, the warning message mentions "QEMU 4.3", but our
versioning system bumps the major version every year, so
the pending release is 4.1, the next one will be 4.2, and
then the release after that will be 5.0 because it will be the
first release in 2020.

(Plus, your merge commit message says this pullreq is
for 4.2-rc2, which is a typo for 4.1-rc2 I assume.)

Since this pullreq does pass the tests, and rc2 is not far off
now (Tuesday), I think my suggestion is that I'll apply this
as-is, and we should fix up the issues with the warning messages
as a followup patch. I think that's better than holding this
out of master and making it risk missing rc2.

thanks
-- PMM

