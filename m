Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42978C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F26822314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GD1ytxXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F26822314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itWs1-0008F6-SE
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itWr9-0007mv-QX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itWr8-00043r-VY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:12:39 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itWr8-00043A-NY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:12:38 -0500
Received: by mail-ot1-x344.google.com with SMTP id r27so28586519otc.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d2vkRP7AqMhYrYliZbG5TBAKhtgR9wzQ3HabWJL1E6U=;
 b=GD1ytxXIa7yhKdcy0bAPNs9I8d1F0kQTClnUgoiR0BPDyDknOTl+Ckcm0hR5cT2fGJ
 CfEHvCCcqtR4RHnGLMu3krr00D00ZYG+h7btCR16IRAMcZO6aPnkWvSf7CQfgtQCy1/g
 kRFfdrOUEEHd91xPt/6Ho6AUgNcJe0xf3U9rciEvrQeLOUEgj65DU9e/suXhrSMEDhTs
 PFhkmIZDHDWviwCQ2cPo2boDqi0fzaJ9pBk6aHNvTWcgqH+0I4KGIuCPCxIuABwEKS6J
 uYX+M/A3sfvLyCZRzNa2F9+xprB/z0Y6/FV+mI8GyAVem5STyWWShB785eODXKtskSja
 ttkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d2vkRP7AqMhYrYliZbG5TBAKhtgR9wzQ3HabWJL1E6U=;
 b=tWKeCcoiSLIExaAGQ3H1mm6SFtTxFoscaIpS6uV+rv+gp2Y/m4YJ66U/VX1Z+JL+o6
 hldg9UB74tRgAm7bNYQ7QEzPf3a9OZCrXxdxA8KElC89B2lVI6QPZjWavoPMMVvtOVCg
 pW8ypYV3ZgbIOrcMPAsakJsA4AFps7AMe3lS3ab+bmIZ++WSzcXLvwkxpU0Spz3I04v3
 1zYTk/s6b564PKUpS8o2gM0AcfqKZ0ZlhuoUtRz0663f/YetF9mfv7C53V98tnYS7q+b
 QVTVM5e+9WzLp5Ut8zrVHNxXC5Z3gB2VdLU1VFBNOmF2bKnlCXWUBIbL/PO+egrMov47
 5qSg==
X-Gm-Message-State: APjAAAWcLP4OBpH9Q5VDhbYMb18CK0Fs80nK299iSMNuqJcbgBTjSH5Q
 ZDmH6SEzzBxvjQ/b1OOxdmTXsDDo/asfoIigEZY0JWUzpuA=
X-Google-Smtp-Source: APXvYqzBf2JcVHxUF3WX4i7WGXmgpCLfk479tso8tEoROohFLuZeuh1uS0O5VUx84uRgeFtDFWSZtyrDcUVrv/KbaII=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr15036544otq.97.1579525957941; 
 Mon, 20 Jan 2020 05:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20200116230809.19078-1-richard.henderson@linaro.org>
In-Reply-To: <20200116230809.19078-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 13:12:26 +0000
Message-ID: <CAFEAcA_SBDJTmsAz3Y6OLEC=510hqao=f-6g+hh7QDXf4mAgXw@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/arm: Fix ComputePAC (LP 1859713)
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: vincent.dehors@smile.fr,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, adrien.grassein@smile.fr
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 at 23:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Thanks to Vincent and Adrien for both reporting the bug and
> providing the solution.  I've converted their manual testing
> into executable tests.



Applied to target-arm.next, thanks (with the commit message
for patch 2 tweaked, and the hard-coded tabs in patch 4
changed to spaces).

-- PMM

