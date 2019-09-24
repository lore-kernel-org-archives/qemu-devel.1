Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13324C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B7D20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvynnCc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B7D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClGK-0007UP-Ad
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCkGA-0006Qg-4p
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCkG8-0007Hr-Ag
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:49:37 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:44520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCkG8-0007HK-2P
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:49:36 -0400
Received: by mail-ot1-x32d.google.com with SMTP id 21so1315908otj.11
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TNAPcASQcCLhTSeDfO3Bas41DihhC55dVHbsv2n/6oo=;
 b=tvynnCc5QjZivgN7LF3kq668c6qRMYvLgKUbMph6WcTYkRU7gBl4AiCyEscQvkt60f
 ZoDe6aF0QC51f8DiM1438t6rFxzVoKxI3NrqCW147WL9Sa7cJxJkbFp9dBhBqnPT25e3
 sT2xhzEbYN1eLbXtW7ZQFm9Kd+0boE4ScaaN/FopfeVGwIR4Sc4AO/rTIFsw3fsfrnzT
 u29QNWGxrV15pzH+DBjSly7cIwIlfem+dI2tfD6hSIFQ3P+oVo5buptUtpNFhy+hdSnA
 UcBgGFS12WfKdPdKuB+asv2668CYZTE9Tx0A1kmeu08xYkv9UFnsrply8qaLLO1r7QrT
 xVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TNAPcASQcCLhTSeDfO3Bas41DihhC55dVHbsv2n/6oo=;
 b=K4DdAmgtCstZUPSwnWqWCCcSH+WCr7i1jEunwHRyWeka59BFiCB+6f3U8UM6w0gyJd
 elNSAVs5+ZQzlxR7kQDR5j6wjh/GuWp+NEM9ZccGTQpUNUeU8pEvKQRLu8caLcr1Dbzp
 Xm2xULKRPMnWcCDVRNpBcDnR1xO/8awGjMFuB0qqeEO/mWE48FFLxTdUP3p1w0yVZUtS
 z8HDKKaKa5RRqwqf9rMwWKivhwors6qkjYP3Pr5EbKm+oS5+mQYNCySSfLpPbtdHJuxP
 b9o/uRrWrOzhlZJlQurdPFw43MhLVbbHYq4M493m35DSt82pwBzwuyKeW5jta6Uy1CeD
 aCCQ==
X-Gm-Message-State: APjAAAWHnJySIcak0jpY9aGMnjft0R212imoI0jVCqs1LRNL+u3DIeXV
 Gtzw236b9nWs/zGpxQGD1t3L67yNWzcSEDGn5Zc+4g==
X-Google-Smtp-Source: APXvYqzGPMyLRN5oqgtH6Vxn9t0o2gW/NHv5EQkk1E16f3VMQN0NhQl05Fzzs1ebn0uphiTWtB3LDVOfQviv3d7WzzM=
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr1485043otp.221.1569329375015; 
 Tue, 24 Sep 2019 05:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190923134019.8548-1-crosa@redhat.com>
In-Reply-To: <20190923134019.8548-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Sep 2019 13:49:23 +0100
Message-ID: <CAFEAcA-MzF+ZUZOBZ5rEEmv1eo2ko2fdS85SfoYc5OKjMo9jmw@mail.gmail.com>
Subject: Re: [PULL 0/7] Python (acceptance tests) queue - 2019-09-23
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 14:40, Cleber Rosa <crosa@redhat.com> wrote:
>
> The following changes since commit 4300b7c2cd9f3f273804e8cca325842ccb93b1ad:
>
>   Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-09-20 17:28:43 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 2fe6f4d9babb957244676fdf23b9a7ca2323034b:
>
>   Acceptance tests: use avocado.utils.ssh for SSH interaction (2019-09-20 17:13:41 -0400)
>
> ----------------------------------------------------------------
> Improvements include:
>
>  * Relaxed error code pattern on machine_m68k_nextcube.py
>  * Better naming and separation of tests in x86_cpu_model_versions.py
>  * New checks on guest side on linux_ssh_mips_malta.py
>  * Use of avocado.utils.ssh, and thus "/usr/bin/ssh" for SSH
>    interaction
>
> A Travis-CI check for this branch can be seen at:
>
>  * https://travis-ci.org/clebergnu/qemu/builds/587665790
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

