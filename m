Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E311C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3E72070C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOh8i0Cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3E72070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittqJ-00013B-5Z
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itt8P-0000Ep-P1
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itt8O-0003V8-7J
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:59:57 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itt8N-0003UZ-VV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:59:56 -0500
Received: by mail-ot1-x342.google.com with SMTP id b18so2838222otp.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 04:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8LNvrZuo+j2W+nRtUVI62IXEJewAIvxTmhTAWfc3HLo=;
 b=wOh8i0CjU0QQOma6koBelMSu4J8ijwcwi7WOjTPhSi0Vd6IjLeXi/wdjJAGSqjATL2
 C7xaxh0mAGeoa+sKcfNLDfvOUWAmdMRuJMVcHREwta3jrIF1sFe3Bv2FdsY+M0AMhaCh
 zOhGVWwOVHoZSv+BgYYX4wl31RaOOmewjfFN5/VA0ZHt9HWof+YpHQPNsiefRtJ6Nv5V
 kBTDfw1PrJrQua+RRjuq5iRAH/M/8q6zG0x1UzsLu22Fk1tFDVcOYVOVkL9PJE48hZNp
 xKcXJFQCNpf3/9kk5kGMbudD17ADh6iGU9NeQ2MYVuzpMEHK7gZFNuiTaslYhtjHPbjv
 eE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8LNvrZuo+j2W+nRtUVI62IXEJewAIvxTmhTAWfc3HLo=;
 b=bN5LulYeKOwrY+ZX4li2msLr19XkpC1yLRqQk10+8McW7LjdLruhnAxKieI93gB9Cm
 dHTmgo7tdSfwu71eogSvcBq5RGDDzarjzENtYTDhbUCPyC7QRGGZd5GuH6y/R61123nW
 Y+hOMmF8EXMuYx1bn2IWbdvp00mK0ay8g3h2lVZIDjRniE2YlydHSviAJNGeEiibu0VB
 NmftSRlYXUcHEIQ6qFOj0tqr+kW+vi2aoZq6aRX4jGRtjYAJFjWBQoIeSu48UVIC0lt+
 vFxgpTfTRx9UapTvmlfWlkqfkOhHRly2UfaACgTDVd4m6J3t4i2zPMiCk1LZUvP2Wmbf
 VjgA==
X-Gm-Message-State: APjAAAWKwItQ+WUOfa4ngMXTv6tO3lU9iObvrijhniDf9Ohvt/ZZMOIZ
 PqITdAucoT/OBXnVzzr8e9GUKgSpx45IPl5Ynhwe2rXC+as=
X-Google-Smtp-Source: APXvYqyDbM4wdR0u67AdICVKmM4PY0gT3y1Mw7nzeKJ0coVYYnbNpFg/bW7F0pMNVrJz2eheFktUYzb1NTG4QYw9EPI=
X-Received: by 2002:a05:6830:1586:: with SMTP id
 i6mr3306209otr.221.1579611594879; 
 Tue, 21 Jan 2020 04:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20200121122138.1708193-1-laurent@vivier.eu>
In-Reply-To: <20200121122138.1708193-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jan 2020 12:59:43 +0000
Message-ID: <CAFEAcA92RXwihkxmG6-E8=6AV==s1nGZgmCm3FwmUoH+fu2uLA@mail.gmail.com>
Subject: Re: [PULL 0/1] M68k for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Tue, 21 Jan 2020 at 12:22, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit d83bbedab5a2758fbb7866c06472feb3f3bf079b:
>
>   Makefile: add missing mkdir MANUAL_BUILDDIR (2020-01-21 11:56:17 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-5.0-pull-request
>
> for you to fetch changes up to 322f244aaa80a5208090d41481c1c09c6face66b:
>
>   m68k: Fix regression causing Single-Step via GDB/RSP to not single step (2020-01-21 13:05:45 +0100)
>
> ----------------------------------------------------------------
> Fix m68k single-stepping with remote gdb
>
> ----------------------------------------------------------------
>
> Laurent Vivier (1):
>   m68k: Fix regression causing Single-Step via GDB/RSP to not single
>     step
>
>  target/m68k/translate.c | 42 ++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

