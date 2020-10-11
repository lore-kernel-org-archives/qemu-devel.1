Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D26C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 16:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EF621655
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 16:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyaFKONl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EF621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRe6H-0004q8-4u
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 12:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRe5Z-0004Oe-Bm
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 12:20:49 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:39099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRe5U-00022m-2n
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 12:20:48 -0400
Received: by mail-ed1-x529.google.com with SMTP id t21so14413311eds.6
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tIPYFz6cXBsjher7bv/C/htL882N8V0WM14qypboGHw=;
 b=OyaFKONlL73JsQe4pWhIOkCo2tuzsWbpWqXw/YXd5aDmM7zQTpRf735EJC690bVBk1
 0YQCLZtcCKQZwxFpw4CGkQj6bzNLY+Wxvyd/fjnZeX9WIXMWIpgnzuCCV2NuMpsA7YeB
 LMi0MVe1ULzmMB+90WdsozohRoS5DGTe6bkdgxyW494W5DBqLAUxJOnvhS2e+U3nwog9
 QE9p86S8tczg63x57t3bbf7C4YqKoz0a+bxUSuRiE6OWkWX56RFOVpJ8Ht8i10qnWEJv
 6e6MnuSx09irrBpRDAsWmb2orT3XwknAePcB3eZx7h+6UrD0oGatxx3T93cgoh04KynZ
 z8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tIPYFz6cXBsjher7bv/C/htL882N8V0WM14qypboGHw=;
 b=rSJmD7urACm1w07PTUxZ5eduQHvirKilxmhQQinJWcadVoc80b9awWRAC3czqIU0yW
 zs0wAmtkmTO2h+yRyJhPPH14pIpZpOrR10A0P6etm1A+/ZMzdmrW6/Hq8oYOHzdH4ssW
 lXcF7YYk47p3bfYCTVD0WknIKzJb/SvQqxPhEWTKsSHuR6++qOsijHJ0f6COu2JWPTaV
 rfYEZQ68d+z0Ba9Nh3N9SMz3RkMCMqW2NiOGJfs81ttWMKhfzq+YmLMQg7DiFr602ild
 3yeYOvvRLDpR6eJeoxLLk8bNj4bu0StEsxOxWtGUEBnar4xCvxefVKwNu2YDGAAKEi2C
 XU2A==
X-Gm-Message-State: AOAM532fNdzPsLjpcBDBqURsnrRbvpiM/Nsvkj0kWCLru7oIc1yP5Uiy
 6SJ6p1PVRbOZojZzq+XdCQZJn1z4bXpVbpshx9c0rw==
X-Google-Smtp-Source: ABdhPJxgVXb37A/xyJjedqL97kTDCSwQG5vbF/Ob4QP/sfgBhmGBigL4n/rQ+QNO/tfk9gePByDsjQa1blt+/koQW84=
X-Received: by 2002:aa7:c302:: with SMTP id l2mr9938653edq.204.1602433242290; 
 Sun, 11 Oct 2020 09:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201009163147.28512-1-alex.bennee@linaro.org>
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 Oct 2020 17:20:31 +0100
Message-ID: <CAFEAcA-WPUHjgKqUM6tayQWwv9a-AEFCwv-MCzK02uhz-_07-Q@mail.gmail.com>
Subject: Re: [PULL 00/22] acceptance regressions, testing, gitdm, plugins
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 9 Oct 2020 at 17:31, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 4a7c0bd9dcb08798c6f82e55b5a3423f7ee669=
f1:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20201009=
' into staging (2020-10-09 15:48:04 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-various-091020-1
>
> for you to fetch changes up to e5d402b28f1a325d46b7b0f08d04257f618e6d03:
>
>   tests/acceptance: disable machine_rx_gdbsim on GitLab (2020-10-09 17:27=
:55 +0100)
>
> ----------------------------------------------------------------
> Testing, gitdm and plugin fixes:
>
>   - fix acceptance regressions in MIPS and IDE
>   - speed up cirrus msys2/mingw builds
>   - add genisoimage to more docker images
>   - slew of gitdb updates
>   - fix some windows compile issues for plugins
>   - add V=3D1 to cirrus output
>   - disable rxsim in gitlab CI


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

