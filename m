Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8533C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFC420657
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEEfFzk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFC420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHBn-0002nL-BI
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41031)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZGGq-0005b5-RB
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZGGk-0006VM-Av
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:55:04 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZGGi-0006Md-Am
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:55:02 -0400
Received: by mail-oi1-x241.google.com with SMTP id b21so1619954oic.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JYZ0pb0GFR0fXsu31m6MjaTVk4mYanpm8Dh4Y5L68s4=;
 b=SEEfFzk7e6AUIhpCihTyJxz3Gn2YTQh+oRp8HaFI47VXnD9xFqlS8KGIBtvr/3jTSx
 F5qqcFC6fEDqcbtY3r+Ud/L6qnmTAnC5hZYzEUNWMk8VrLqGDHy/xUCvOnFHKwnD7NWo
 vV8DaAQCct/UrJG95PKH1OMeZUoQvT94GUwwkJ2sF66w7CyweHmHTjPTG69v7bVTtJpV
 415Pszx4pIK84A0RrQJJJTHHkz13lAMgDWluQnpW+Q05c8dH7JlKGUAvZkcUZh2CZFWD
 OO4J+LUY8kHX4xSbf8PcN+IbYm+Vd2nLvoMar30ZtQhx65tiRHhbbmkW8j/+hxfmJ9DW
 ecqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JYZ0pb0GFR0fXsu31m6MjaTVk4mYanpm8Dh4Y5L68s4=;
 b=p8Ygfm2FmfXyhjtkC69zQP6+LLFOPThVCBYkUXA2TmvyDMjLIti7tvB4D6N8BM2QcJ
 BuXFCqS8o24/AgDp9Z7EVhcRIX9gym7XhDOjvpjTxgIeb+aiXuchrtHNjywu5r5YaHCH
 tQoaA5xEdhxDeaGDNHEf2tEWEVOTlMwY+0Pxr+y9CS00mtrTEYx3PXnpWXHAj8diWoYK
 37T5VNEzmq20uL7tsTyX3rjlqmd03k5p0a3J3bLXzz7iHmiJBiaHjDx0/pZiq2wSvcJK
 /WBTjBdaRbTVnAOwfAjcEigrP7ySoFL2sVwrZjkqLmeYu3HojIASy22hH7Se3V8VETPh
 UCAA==
X-Gm-Message-State: APjAAAVeei+DBO+D2aeK940F3PvtFpuP3Agj3FtMVYyB0Ni9+Hi2g+dT
 NWIIxZno5arPVogi3Wr6ncMGREnbG/c3sFP+9Rm78li3PjA=
X-Google-Smtp-Source: APXvYqxvulc5MiC93Xdx1SJUDtoSb38ns5r9du8k2c68VpSexUVpJYtqBdYLHIMGriC7q1W34BbNsG/BWND1MH0YgwE=
X-Received: by 2002:aca:845:: with SMTP id 66mr1975969oii.163.1559919298028;
 Fri, 07 Jun 2019 07:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190603232209.20704-1-richard.henderson@linaro.org>
In-Reply-To: <20190603232209.20704-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 15:54:47 +0100
Message-ID: <CAFEAcA-KZM8tzD6XLhbtxB=OrnvgmtjcknvxrYoVmooBb7grMw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Vectorize USHL and SSHL
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

On Tue, 4 Jun 2019 at 00:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These instructions shift left or right depending on the sign
> of the input, and 7 bits are significant to the shift.  This
> requires several masks and selects in addition to the actual
> shifts to form the complete answer.
>
> That said, the operation is still a small improvement even for
> two 64-bit elements -- 13 vector operations instead of 2 * 7
> integer operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Applied to target-arm.next, thanks.

NB: in v1 this series had a second patch. I'm assuming you
dropped it deliberately -- if not, let me know.

thanks
-- PMM

