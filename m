Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C31C3B187
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64ACB20842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/G4pFPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ACB20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1TEH-0008R1-Kl
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 05:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1TDe-0007b6-EU
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1TDd-0004Is-95
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:56:42 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1TDd-0004Gy-2O
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:56:41 -0500
Received: by mail-ot1-x343.google.com with SMTP id 66so9603463otd.9
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 02:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=G+XEOGOOfB0mQPosFwswKb1XrazjLuBmq9VZcLpMzxA=;
 b=g/G4pFPY7yIvKb386fQU+eLr1jLQ3Ys8B6gTEnT8OTzD2VMUxtrBDXmYhBoXR5kbWU
 8J8f0r9SgEE6ipdP+eWdH7p5MiUPG9WeEFP2o1xULynX/0JF1qVB8ce1x1j8ZZhiLmTs
 KXQL8VHpX0XD2ge9GfyXBv9v2rLgJBTPUjDwEp84Xv8d6l1iP9MxLa+171Nx0THqb7rh
 tzmUypP3x0qLAJgpYIz8MEPTRVzj8wz/AeQMfe1jS8SZmA5k4Nsf6s4dxN+NbbxmNOGS
 CBZOVdQuDOGiDk9hGc8KmT8CYiHjrh3MND1g8W0dDjxthKkbsRrylWh/+eTzr9mBeyNK
 yiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G+XEOGOOfB0mQPosFwswKb1XrazjLuBmq9VZcLpMzxA=;
 b=P8NFoAdDpdx6xB9+goc1StGpwaGlYadpyNunPujhvrfimkQWDfZ0CljcWRpNIdvQYd
 7FJQCXTgm+XUFd16ekcDaMN2GgEmJLFs839yXErPvij0aINLXmDI/EOKH/JhOomQxm8k
 Apicl5uySYn86dQo7cUz2PJR/w9qK4e2Poy7MR9PszD+o3G1snN3IMROgmExSQ2YlWhA
 HOp989do2KURrr03caNKVZVC0LhySiHD3yjvtIeW8mtanluk9DKl4DkRkevHsVdLeUgb
 0hody8EzqFyF7h3y4AoXm3loD6tKii1m8wtJLYYToa/T6KztgpdhTXmpkdBMaBcfUa8i
 PWFA==
X-Gm-Message-State: APjAAAWWULZbr229/wip7RgLdqxdjbDBfJnBEijw8p2SiUBH6MCYrZHO
 boO6rcUQmziu0Vjo5ANtxIUGe3osYjwtnAz/8OQIpA==
X-Google-Smtp-Source: APXvYqwcQuf8FOnuPX4jZwefrnQDMCpvw8XDispIgmHGsKB8oJnDqybiqV3+reSDcoaWvjyxHVP/zuazIXGsHpTXjSQ=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr4807806ota.232.1581418599540; 
 Tue, 11 Feb 2020 02:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20200210131523.27540-1-eric.auger@redhat.com>
 <20200210131523.27540-2-eric.auger@redhat.com>
 <5cbd1960-6138-f4d0-948f-1983cb0f93b0@redhat.com>
 <e69f69c5-40f5-1fe5-f298-129324cc7055@redhat.com>
In-Reply-To: <e69f69c5-40f5-1fe5-f298-129324cc7055@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 10:56:28 +0000
Message-ID: <CAFEAcA_TJ5gDMRNK=O-iaqksYL_aQFu7repo7wKi7pGb-A9cYQ@mail.gmail.com>
Subject: Re: [RFC 1/2] tpm: Let the TPM TIS device be usable on ARM
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger.pro@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, ardb@kernel.org,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Feb 2020 at 08:35, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Philippe,
>
> On 2/11/20 9:25 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > You don't need much to remove the RFC tag:
> >
> > - rename TYPE_TPM_TIS as TYPE_TPM_TIS_ISA
> > - rename TPMState as TPMCommonState, add an abstract TYPE_TPM_TIS
> > parent, let TYPE_TPM_TIS_ISA be a child
> > - add TYPE_TPM_TIS_SYSBUS also child.
> Yes I tried my luck without too much hopes ;-)

There should be a few existing examples in the tree
of devices that we provide in a sysbus and also
an isa or pci flavour, that you can use as templates
for how to structure the device.

-- PMM

