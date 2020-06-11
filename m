Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55C1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CBC20760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLRnfIE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CBC20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKKc-0006Xz-Ok
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjKJx-00067A-Hw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:20:29 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:44773)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjKJw-0000Ko-Es
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:20:29 -0400
Received: by mail-ot1-x32b.google.com with SMTP id e5so4118268ote.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 03:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=p1g2IxUcrlyv0I8ZeaDS/V3SD+4fxpLiUP4mTlm+uB8=;
 b=hLRnfIE1luBWW4zXkDVpYF7NuIP3YyzBlxV0uz6+mzPh2CjOwjNnthQ7X5SKvRhhoG
 yfhZavbUuAoe1Hai47Czp84rYrk6HAbgncwRLZ5pD1FoJ5Gz1Es8LclKlJTmhl0Au3OX
 klEhpcYiP3hBp3FpEUEjo1k3q+jCJSevbARYGYgK8UtiRKykxE3nfyElSEobKUSIUB5N
 USV7YCKJn0efKRthb/ZdCX0UEZzBQCIdgGbiT4cIRqWUAdX+pzBY3D6dw0iwtG7SmrhL
 1RmqcAmVS8p1AR2rxUA1WS8N/n0qDVDAYrbEM8UT3OlokOqubpdYIYdbEkP8IgOvRAtK
 af8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p1g2IxUcrlyv0I8ZeaDS/V3SD+4fxpLiUP4mTlm+uB8=;
 b=lcjB0XcHYCcMWn2UeryxubTEc983nClpLLgbbszgWnz21SDD9YmMziezRjp9ue79Hf
 KvRSMSZkCXiKr1kaqhvsmeD8VUFPQ13N1NU/qTafuXwrOy5+DaLbdGhqkGr5GZvd7SjX
 xnYM1YOSiRwUQW9I3/TYNnkE6eqgajqQJOFbzJmTLr79Q8QrIVUNRZssG9NAQBlCGc+i
 rirLtD2gm7HlW45AqIWYij31uyr708uIIWMTKtY4lXLMOLvWud3TYmvGx6TpMrVMg331
 MhEAxWeH8BEPoqAzsXiZkHxxHWvED+Cp7O6RIqmB6MZccF+vufVeU1uzquak2Z5WOF2p
 hh0Q==
X-Gm-Message-State: AOAM530w5eezTFaBqzlG4DxUWpHMWwVO02BAIOggC93Gw62W5YetZ4FZ
 em3JcBIbAeV48BDcHz41grr7HB6vd/TzuRKKiuMcGw==
X-Google-Smtp-Source: ABdhPJxLB5OavpnH7RlFwnlySkKC9jn4AXuQ2BVU6+okZQ+KHJnaudQzDkkOmSzQk700/cpMe1bFRZ4TOguZ8VcCx2M=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr5816917otn.221.1591870821658; 
 Thu, 11 Jun 2020 03:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200609103809.23443-1-alex.bennee@linaro.org>
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2020 11:20:10 +0100
Message-ID: <CAFEAcA8sBLtpCMW11mqitU-zD46CUJRp4sBp5gX0Nz_Ui4Nbyg@mail.gmail.com>
Subject: Re: [PULL 00/17] testing and misc fixes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jun 2020 at 11:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 49ee11555262a256afec592dfed7c5902d5eef=
d2:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-p=
ull-request' into staging (2020-06-08 11:04:57 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-080620-1
>
> for you to fetch changes up to a5b04ccd742f6c58a1d305530d9e07ad9731b8e6:
>
>   scripts/coverity-scan: Remove flex/bison packages (2020-06-08 17:04:19 =
+0100)
>
> ----------------------------------------------------------------
> Various testing and misc fixes:
>
>   - header cleanups for plugins
>   - support wider watchpoints
>   - tweaks for unreliable and broken CI
>   - docker image fixes and verion bumps
>   - linux-user guest_base fixes
>   - remove flex/bison from various test images


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

