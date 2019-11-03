Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549C7CA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 09:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18EC020656
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 09:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRAe7kt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EC020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRCZo-0007FR-8s
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 04:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iRCZ8-0006ni-Oc
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 04:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iRCZ7-0000Q3-FV
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 04:52:58 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:32888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iRCZ7-0000Pt-A0
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 04:52:57 -0500
Received: by mail-oi1-x236.google.com with SMTP id m193so11698586oig.0
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2019 01:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qy8BVpmqncn42E3Pua7EZocdUEk56YX3o2AHUl038s4=;
 b=BRAe7kt5u8JSrQPF+Auc7drO5KtHo+w8M8u/7YKkQIg9GSZ9JP+Z2jTM1YIYOpmLkW
 +MXr7+TjU3pDxh/AALWXiuC268BtrY7sZ6/OEAZmN/Rkch/dTyYRa7/9UsYCsRMrn1lP
 EH5K3OFJZh5PDX+YprQkZ4h9+mx/TJWeX+5z/28lfn4/byHJ1lScY76r7N/R7Qxylj8e
 hglzGjE6XJ4bFhD9OiZgVAORf4JyAEL1Q9rFKgi5MVitpZ+NpPxpfrXAMDp/7AjfI9c5
 hns7+N1NDuXpRUpZ877ppqo7QMqunF9xGsm85NDL+x9jfwNCJCWZ5SvQfBecyBC+YU1G
 XhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qy8BVpmqncn42E3Pua7EZocdUEk56YX3o2AHUl038s4=;
 b=pmiEZNnp23OJBqyeRka0nkLCse7ysOP75g2H39Ynh5wfuWw/9bV2UI6zX25H2wqWBA
 DDaWPYURgHVDLbsUY5BQClq4BRfOAbucf7xLZnqVcmkYk/46XPR1XDpf3gUU1K3cc//h
 Y7PbclsaC8oi0c6Pj+LzY7Lqeo+I5UzX7payZFfyA6VUchiXkLILm5gwiCRuRSBFLNGq
 Ev3x9x8/w0nVk2H5bINWv0oeCqIgRHF5V6DdR2VDqn21ygHfC5SzhfYUCOadwUnieat2
 5cyHDPuTEfS2R3ehmtgKlNcgShAijRnixn+2Kess+XIPDaH/EVAX0W43hbYR9X0xfgKT
 8/Aw==
X-Gm-Message-State: APjAAAXSV660EM2mjtWTW6xeeSjFUQQrZLDqjQ4jisJrsrGz4efJa33T
 V5RXTKjIw2/assFdlPqzEQFp4/wDjpwe/C9zoY5x5Q==
X-Google-Smtp-Source: APXvYqylHPArshb4PpHCunBebEscdz3MeD3cVQ9o9ny6Ye5InD5EH9Ifpok1g2Uq67yHo4n4LKxkRMU7ObcJSDC1atA=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr9489790oia.146.1572774776128; 
 Sun, 03 Nov 2019 01:52:56 -0800 (PST)
MIME-Version: 1.0
References: <157275520880.19702.5640428141206739403.malonedeb@wampee.canonical.com>
In-Reply-To: <157275520880.19702.5640428141206739403.malonedeb@wampee.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Nov 2019 09:52:45 +0000
Message-ID: <CAFEAcA9R99t05Yr3hjUukJJK-L5SjTJqh0FD0xcjRCbLvnHpgg@mail.gmail.com>
Subject: Re: [Bug 1851095] [NEW] [feature request] awareness of instructions
 that are well emulated
To: Bug 1851095 <1851095@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 3 Nov 2019 at 04:41, Shawn Landden <1851095@bugs.launchpad.net> wrote:
> While qemu's scalar emulation tends to be excellent, qemu's SIMD
> emulation tends to be incorrect (except for arm64 from x86_64)--i have
> found this both for mipsel and arm32. Until these code paths are
> audited, which is probably a large job, it would be nice if qemu knew
> its emulation of this class of instructions was not very good, and thus
> it would give up on finding these instructions if a "careful" operation
> is passed.

I'm not sure how this could work. If QEMU reports (via ID regs
etc) to the guest that it supports instruction class X when it
does not, that's a bug and we should fix it. If QEMU implements
an instruction but gets it wrong, that's also a bug and we should
fix it. In both cases, we'd need to have specific bug reports,
ideally with reproduce-cases. But we don't really have "known
areas where the emulation is incorrect" that we could somehow
differentiate and disable (except at a very vague level, eg
"probably better not to rely on the x86 emulation").

You might be able by careful selection of the cpu type to avoid
CPUs which implement vector operations. Some architectures
also allow individual CPU features to be disabled with extra
'-foo' qualifiers on the -cpu argument.

For Arm in particular (32 or 64 bit) I believe our implementation
should be correct and am happy to look at bug reports for that.

thanks
-- PMM

