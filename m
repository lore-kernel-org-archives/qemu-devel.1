Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8B2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696D920872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhYpJeAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696D920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7baT-0002v0-Iy
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7bYu-0001og-4w
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7bYs-0000As-Vm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:31:43 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7bYs-0000Ag-Og
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:31:42 -0400
Received: by mail-ot1-x341.google.com with SMTP id g16so2040465otp.8
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qiS4go4R1PtpmCG2lnWXe9TtqUP1obiOdClF2g/4+98=;
 b=RhYpJeACgil05WaFXQNoxOeX9lp523/AdtD6/tRLaH1FBIMIpHhYlLAUPpE4UL412B
 99yBiUxQvOPYtLrD02z3ncnNSJsmfrImwco+VTG8l81JCg0wnL0F5bfwa3rrh5IzeRWC
 0RoPXkne35mvC7h+WsCIlfLLwdEhc13Ny0LIX5dDXUy67SF7qDN84wxyJxf1G/fOet/8
 ZA+EfboXqnTpUkmJGted+zS/cJArZMkCKdSqjCTKNq1dSIRKwpO9pwY/4bYw42WxZ2dR
 jecqBGsShBC1pT8iqO8XsRuNA1OFfoBmZh+N4LQaVtUNSqlRO0BX1a1DS7ZTUZgVanZ3
 J0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qiS4go4R1PtpmCG2lnWXe9TtqUP1obiOdClF2g/4+98=;
 b=Fom4oD1YLEvpvNkH6diM70kQO20c1RihlckJWF+7dzugJDobRG9freQnnGqzkisxT+
 BAgfXU/q8hXJn/pXNYh3rDS5uWPG9ftcM8GTg91y513L4bu3b7fqZEreHcvyxZXv0s+y
 XSqqev6UksYpQRA8HLNFKUAV7zM9HV9cHVuQbJicc9L3s8t+p2qMcZtC3MV4DVjmJuBI
 VLIPEmqHSs6N0JSYsbNlAXxIfuKNSpGlcG7bbN+dchT60HLbTBD8Z57U4YEMTk/HpUMh
 FoECLrPTVWZMVQUIlLOMjVBOX5mui/yHXvd8YE6Em6J3zXuhiHxK8gCQy4v9FRRjqGxF
 lEig==
X-Gm-Message-State: APjAAAXX8fTkBs06y33wGfYmyQCZS4bp4gVYtVAoZhSPESDizKDV6Lwl
 V+vHJZVeXlb+heMxug95XG59TxMyBi2ofspic2uS9g==
X-Google-Smtp-Source: APXvYqyVVQSNoSgfhN9AYgAFwWqNq3wUObZ1F/i9BdDUnmap78AJnoB7fW+C1N41UeyvNCht4w9Yiwo8uv42MEBjDas=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr1474738oti.135.1568104301873; 
 Tue, 10 Sep 2019 01:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190904005218.12536-1-crosa@redhat.com>
In-Reply-To: <20190904005218.12536-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 09:31:30 +0100
Message-ID: <CAFEAcA_TB4c6T2ZGu8xCx_H2Uzs8j2Jcs9ZbASTgXfv87KdSwg@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 01:52, Cleber Rosa <crosa@redhat.com> wrote:
>
> The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
> from tests/acceptance/linux_initrd.py, is currently failing to fetch
> the "vmlinuz" file.  The reason for the failure is that the Fedora
> project retires older versions from the "dl.fedoraproject.org" URL,
> and keeps them in "archives.fedoraproject.org".  As an added note,
> that test uses a Fedora 28 image, because of the specific Linux kernel
> version requirements of the test.
>
> For the sake of stability, let's use URLs from the archived and
> supposedely ever stable URLs.  The good news is that the currently
> supported versions are also hosted on the later.  This change limits
> itself to change the URLs, while keeping the fetched files the same
> (as can be evidenced by the unchanged hashes).
>
> Documentation and the "vm tests" fedora definition were also updated.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---

I was planning to apply this to master to fix the Travis builds,
but it doesn't apply -- conflicts in qemu-doc.texi. Could you respin?

thanks
-- PMM

