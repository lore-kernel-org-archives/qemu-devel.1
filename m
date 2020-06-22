Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3A6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECF320738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrS7Sxfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECF320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOxu-0000VK-R4
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 12:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnOt4-000359-Qe
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:01:34 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnOt2-0007hV-OY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:01:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id k15so13463634otp.8
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3yxEaJfq33dbM+4fuoMdYo0Ncw/y1toKo8qGjNlYQ18=;
 b=qrS7Sxfof5oBG3ID66PWWddA1/mNOi4zt5/NoVaXTLh/91uuMsU79Xf5fqHtlCDP38
 jO11EXk+Asto4nlEjd7EO7bZAdUoPukERSJqBvIl/dEzPQmuj65L/oFmAmCBgLWQfCwq
 dW/e+oDV83LsvBixfGnLXd58weLRENf2kELu7tneZR/8chn/t2BU6ZZCeFSQZn7u9lVY
 VEQXCsni7lTKx5vmHZOg26n75DWMmLpYzJ9T2DD69QeATj9g+6zfJ1JL5Ly5ptux2CjJ
 BvpjZQjCvNZPGOVnuSQ3LEKj1DCX6JHZWk5QqmdOPPnTiNf7056zPbaUTgVO+7oB7YMg
 gnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3yxEaJfq33dbM+4fuoMdYo0Ncw/y1toKo8qGjNlYQ18=;
 b=GWnizVGp6OeLvMHXhEalerUCc/SW/HdaiwfEP2cqt05BCVR29umIAYQE1TuoZG3Bqz
 X1Qmp9qDEv0EjVD5j2LEIx+K2TR/qRAdhq+L8Jzxk3OcdmygkiQFLXx3vUZ7mGBGurCk
 YRJWBl0liQKT0/MnNjZgS6KTS2AegucFaJnpZWmkqveKcgEWlGozox18kouRgzPqDt+w
 rjXgUiO1iXXAq18t6fSEN6Zbnl2ECtZ5vM6IwoC0Pp2VetAGo8CtU2bZ7yeG6rbltADm
 VLBretUbe6MzxdXsfYpoPxgY0DWbv8lIXRb9fQcHiwVC7SvVRNU1LfMjHsy/TwPIkl6a
 SWAg==
X-Gm-Message-State: AOAM530aEFtlD91xogJ8odbgtXNWDEj4iH70tzFlBTP4SDjHzpxKwFCL
 PHKqrPhF/UTy33ZR5tMy9Gxd738K9AQEPS/Qg9NypQ==
X-Google-Smtp-Source: ABdhPJxAzP/ySdfvsnPp7Z5ngY0tA91uE6z3vUpHqTTbRrk+uSJLCBEkk+qRyeThnXcUvYzMMhRdhbtUQ4M6MkJ3Icw=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr14403930oto.91.1592841691497; 
 Mon, 22 Jun 2020 09:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200621124807.17226-1-f4bug@amsat.org>
In-Reply-To: <20200621124807.17226-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2020 17:01:19 +0100
Message-ID: <CAFEAcA_5663fFNVqcr1maATB6v8R297LmJEtD+8V4LvhaSkjPA@mail.gmail.com>
Subject: Re: [PULL 00/15] Renesas hardware patches for 2020-06-21
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 21 Jun 2020 at 13:50, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit 06c4cc3660b366278bdc7bc8b6677032d7b111=
8c:
>
>   qht: Fix threshold rate calculation (2020-06-19 18:29:11 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/renesas-hw-20200621
>
> for you to fetch changes up to 730101266e4026fc19808c740ee4b8118eeaaafe:
>
>   docs: Document the RX target (2020-06-21 01:21:47 +0200)
>
> ----------------------------------------------------------------
> Renesas hardware patches
>
> - Add a common entry for Renesas hardware in MAINTAINERS
> - Trivial SH4 cleanups
> - Add RX GDB simulator from Yoshinori Sato
>
> The Renesas RX target emulation was added in commit c8c35e5f51,
> these patches complete the target by adding the hardware emulation.
>
> Thank you Yoshinori for adding this code to QEMU, and your patience
> during the review process. Now your port is fully integrated.
>
> Travis-CI:
> https://travis-ci.org/github/philmd/qemu/builds/700461815

Hi; I'm afraid there's a format-string issue here (manifests
on OSX, openbsd, and 32-bit platforms):

/home/peter.maydell/qemu/hw/rx/rx-gdbsim.c: In function 'rx_gdbsim_init':
/home/peter.maydell/qemu/hw/rx/rx-gdbsim.c:93:22: error: format '%lli'
expects argument of type 'long long int', but argument 2 has type
'ram_addr_t {aka unsigned int}' [-Werror=3Dformat=3D]
         error_report("Invalid RAM size, should be more than %" PRIi64 " By=
tes",
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                      mc->default_ram_size);
                      ~~~~~~~~~~~~~~~~~~~~

thanks
-- PMM

