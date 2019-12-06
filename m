Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6405BC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E3020706
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gB31Ta5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E3020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idH97-00029N-Pr
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFHi-0005t2-K3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFHf-0006CD-N4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:12:44 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:43283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFHf-0006Af-Db
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:12:43 -0500
Received: by mail-oi1-x236.google.com with SMTP id x14so14974oic.10
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fIBaNeFOZ37BGpa+Pr3035ahuSXMmGbC1qGhADzI+gI=;
 b=gB31Ta5pICnU8zfpO+0k7SLBFNEgO3Ab6EpYi0fg1MN07w2BCofqsJ+zFLQgFe9BPJ
 0IgligFJHriHNc5ePfySog7fwUEcLWE4uuxNVMJJ9NpGmwhlcom+I6Fm5XpWVzm7Dqg8
 RWMTHDMF73IE29S9ufFAbG90wBbEniHA38vL5OZH9zHxfSHvFKbQCIvCwjXJnTYSSWpS
 /ziW6p9bfG3j5FOJGNBqq5jQd85oU158aoOIecWm3ZWgFROmKyal0GUbZSWrMYwZoivo
 g/2BMiatpAvNXpqN39QL/zNnia7T4OhbQkit6GJAzKrwztjVzaD6wazKbwjrYqIf5vwo
 eCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fIBaNeFOZ37BGpa+Pr3035ahuSXMmGbC1qGhADzI+gI=;
 b=fBVrb5ZZ+wOvnV9ohHypJ3LCKaSpFwTd6usSHx0Kd9sIb5ny8z09p0BlGVhBWFO721
 xh+Veh0+36By9/i5AxHvLr5vsVlbHEtiRbzmMJH2UDa5cs3rN4xrz4UPhfC/q9D3/aT2
 PYMpBMjgen5ADLbpwjaLBwMobYYwcoF+C34JbpJ6aAKJtw0UbGlu005oDFyZSJnGrTNu
 +Ft/wDWx1Z4ylTRtMJ/0sbS9lPXGmS/6ybTIdxRNk44L9yi+CKRIKl1nN2KBXvdHCWvS
 gfc1Lio8a4AAqqIcoDZ5AsX1eI/damHi9trzYkcbEZjyyXds/YznZFsItAFDqylI/NDL
 +Srg==
X-Gm-Message-State: APjAAAXN6Wd8PspMLOiqh5SkZ7XvopjmnjE9n+xj2K8zTNYc9eGprvFf
 G6r2wMoGDckGlBPXQ4U7nfUymi8xBi0o+e7/rxAtHQ==
X-Google-Smtp-Source: APXvYqwi+ETXGrn5Ju2rH9gezIchib/aRlnHg3SsqgDQTX7+BQ7FXGTu5yfXENANdtBDNxvSjj9OZjrxainv7JIu4lo=
X-Received: by 2002:aca:f5cc:: with SMTP id
 t195mr12770833oih.163.1575645162493; 
 Fri, 06 Dec 2019 07:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20191206150844.20124-1-crosa@redhat.com>
In-Reply-To: <20191206150844.20124-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 15:12:31 +0000
Message-ID: <CAFEAcA8ekevaZnwOg5bwJmkFkDFaC_qkrLLESLbSJs=L80viHA@mail.gmail.com>
Subject: Re: [PULL 0/1] Fix for m68k/q800 acceptance test for QEMU 4.2-rc
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
Cc: Beraldo Leal <bleal@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 15:09, Cleber Rosa <crosa@redhat.com> wrote:
>
> The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13666fd927=
8e:
>
>   Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 820649aa00ee343a0d473ad1002c59c70ba8c158:
>
>   tests/boot_linux_console: Fetch assets from Debian snapshot archives (2=
019-12-06 09:48:35 -0500)
>
> ----------------------------------------------------------------
> Fix for m68k/q800 acceptance test (Philippe Mathieu-Daud=C3=A9)

Any pullreq after about rc2 needs to clearly say
what it's fixing and why it's justifiable for it to
go in rather than waiting for the next release.
Otherwise you get the default response:
  nope, not at this point in the release cycle.

thanks
-- PMM

