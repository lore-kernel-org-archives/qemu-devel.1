Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E0AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BBE20747
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4Qon2oB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BBE20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLowA-0005PG-GW
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLovR-0004Va-U0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLovQ-0002MG-Oo
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:10:01 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:43841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLovQ-0002L8-9o
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:10:00 -0400
Received: by mail-ot1-x333.google.com with SMTP id n25so585138otr.10
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dJAi7lK9nEf0bQnoH1ktu4tFUJnTKcRQtmoEO1bNvjQ=;
 b=w4Qon2oBjr/0Ee5i8TtZ85HxbRmpHsSCdiwfY1BcLIVrCVcdhJtmWzVuC3z98bQq5v
 kd/dhMaUpO2zoUp5T9wh19dM5lNOQXh6MeuTiwJhM6imnkG6UL0cxAUhC7Ba2U/Berdb
 N6B16uCRqtS/zDu68dBp3TJRrorcLhPFdbQKO7j9VJvjlMwqQqiLGn2K8L0mB2kPXzG3
 D+47j1KZ+jWkFkE2GwbkFkT+JPxbD5i4JQFeuGtY4SJUItRPHqf+D9a685xHT+lZmz3D
 2CPxvfoLUOaxCaRuxS/w/9aoqD3KIxv7GRQV78R+gplgnZp2NyhCwha8/FeI/qim4Rg4
 Vhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dJAi7lK9nEf0bQnoH1ktu4tFUJnTKcRQtmoEO1bNvjQ=;
 b=Rx6Jvlm0cqndY6yEt1wwT3V2b/EMvSivHJmxFGYd2Rer30ODkgg+v2f0ocPlqmbKcT
 fUOL8KNWOnKNrZPxEKXDbGpA0aZOI2HWqHb5++IXV6LqSvAJUzaFol0rFo8P175S0cY+
 7cg+cZcfx9aOdFJDK/iAo42XGcbNW/905O2FJg2by58HUQmQ93vRY5/rZwRxqzLD9o7P
 1Hz1v54lQxyMa33Fgf58RF9qaun1TZ9TxL2+YKMzJwH29hCNpXz+fVsU4uv2prh1Q8J5
 TkWas847wRorRRSO1hHSev/DDfxv1goALai454QWaBNh12seKjlx5cKKiTifUDraGVz4
 PHvg==
X-Gm-Message-State: AGi0PuafghV5PDCIXC3jeM8dpWVRv6+0yh0Kw8iC0lnoPnXFZLUdGkh6
 AidIevdHv2GDgasmmUTyAKzai3oSdo5SZRMtDdnbPQ==
X-Google-Smtp-Source: APiQypLukOKjP8tTGwgnvD/RnJX5VvI84vh3AxqPqgOVHg8dVJhRtknDAsP5AluTpSDmXAkUW13FNVD/cs1hHuNkIHY=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr1637718ota.221.1586268598620; 
 Tue, 07 Apr 2020 07:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200407092207.6079-1-kraxel@redhat.com>
In-Reply-To: <20200407092207.6079-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 15:09:46 +0100
Message-ID: <CAFEAcA8h_N=krhE_GTCstmA7PF=TJVXWAo8kVfWnpf3pKKuL3Q@mail.gmail.com>
Subject: Re: [PULL 0/4] Fixes 20200407 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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

On Tue, 7 Apr 2020 at 10:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 146aa0f104bb3bf88e43c4082a0bfc4bbda4fbd8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-04-03 15:30:11 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-20200407-pull-request
>
> for you to fetch changes up to ac2071c3791b67fc7af78b8ceb320c01ca1b5df7:
>
>   ati-vga: Fix checks in ati_2d_blt() to avoid crash (2020-04-07 09:25:23 +0200)
>
> ----------------------------------------------------------------
> fixes for 5.0:
> - audio: windows (dsound) fixes.
> - vga: ati blitter sanity check fixes.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

