Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F024C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E854D2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K493QvoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E854D2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lxV-000651-Nb
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lwO-0005Cf-Dr
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lwN-0001NE-7U
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:48:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8lwN-0001Mg-1J
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:48:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id z26so20265793oto.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6iHTQSc+IpmrUdQ6C+Hj5cjmyPorY7fb5j5//5nIq1U=;
 b=K493QvoRvbQwcrlIEShj2FmR99yLBj80vAT03MGhQkJIDrbEbnqRyp+g0Or7Zrsxvb
 Q/0rNsI/Kz34mcqV/LrpVOTL5MxtiUGf2umIKO1rwDQjFTj7DvaCLK6iUIOI9Pd6rZB4
 7N+FRgWusuPjTJTClhQgX3H0GCUk63PRKsLwy6AFlZjr3HlPEbAF7ETAEddOYR78ddKg
 w+FQPUntTdPdh9wPnCLRVbewngmk8eXjGT6RkCz1ncT3EmgvO0nqak0zW0GLV6k5445Z
 W88DVKoaYb2gMVQBoa+z7HFLWjynPtPcvsU6xZGDkrWodH9fxNjuuZdm/cV4UhR0uEU1
 L3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6iHTQSc+IpmrUdQ6C+Hj5cjmyPorY7fb5j5//5nIq1U=;
 b=Fdsc+VpDTZKpbZVpGOFF1yi4Xp1jNn726ZOKeVIr1uEeBMNI2oJ8lCRB57dYXbB2be
 vF7MqMxvXKdqhTP5agX4ZtTpSkybS4dPPLlKYe6XvRjiIipjqvcPxKwCgUJsLx+uZtb0
 pBhJ6hlISDphlciarX0hwpBiiMuWtaU6fUiIlGyYO/iczOXKbAOYD68xRbaj/ExQ7dQB
 nCMd2NSXHxfOO7iOHpVgeQOIwdXao3IjAuc2Coxr6tzgIe3ea1MjqyJxE6jKbXEhIs5v
 pMD2s5pBDSYYhYXfEzYLMmcHmsDzdhnussc92QZS6z9pOCR54yHlYAHD3lZ4+tmY1Bxl
 DWFA==
X-Gm-Message-State: APjAAAUQlUATc1t9q0mxcbRk4ELzsC7dN5X0NvhBgsixe8o3bT3xicRi
 l1X1ym9oe8IM9Ir24mlTfUl+ql5b9JqnJn86N6oRYg==
X-Google-Smtp-Source: APXvYqzbfFPcSzDrm2UHoxQ/ujld+qQTgCiO5OwP/+Ns6/lRTcnI1kGwReaSmaO96OV6Kk1c9mkNpY/Z6FKrrn6moZ0=
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr32258894oto.232.1568382526156; 
 Fri, 13 Sep 2019 06:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190911164959.11003-1-alex.bennee@linaro.org>
 <20190911164959.11003-3-alex.bennee@linaro.org>
 <CAFEAcA8NsdpEMOH1MFDta0LUswyqSDHCgtOh6g5k3+EU0FVuHA@mail.gmail.com>
 <875zlwz5o1.fsf@linaro.org>
 <CAFEAcA-6BmxkFND4nZBFs70nVPEFzSFrE6RMQ1O3ftqozYYoBA@mail.gmail.com>
In-Reply-To: <CAFEAcA-6BmxkFND4nZBFs70nVPEFzSFrE6RMQ1O3ftqozYYoBA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 14:48:34 +0100
Message-ID: <CAFEAcA_21a5mCk8Oh11pyY=0wtqbzTargSjrob21k5TkoXgL1w@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v5 2/5] target/arm: handle M-profile
 semihosting at translate time
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Sep 2019 at 14:31, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Fri, 13 Sep 2019 at 14:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> > > This is still disabling semihosting for the linux-user-mode
> > > build for M-profile, isn't it ?
> >
> > Sure - as rth suggested. But m-profile doesn't run Linux so why would w=
e
> > support it in linux-user?
>
> (a) Linux does support Cortex-M, since it has no-mmu uCLinux style
> support these days
> (b) gcc test case binaries, which tend to get run on linux-user
> even though in theory they're not actually Linux binaries

also I think (c) general principle -- don't change behaviour in what
looks like it's just a refactoring patchset.

thanks
-- PMM

