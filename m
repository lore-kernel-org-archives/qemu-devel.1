Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A0CC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA0920665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMjrey/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA0920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmzed-0002vB-Ba
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 08:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57776)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hmzeN-0002Ej-CN
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hmzeM-0001nx-9L
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:00:11 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hmzeM-0001lk-1F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:00:10 -0400
Received: by mail-oi1-x243.google.com with SMTP id u15so12440435oiv.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VpxcwQfT6oonbjtfL7efqwNP5w52cC1PYO/hslDRy9Y=;
 b=oMjrey/uDVA9URYRAsD4TQgi9BJck6rkBoQCEUIWUfu0QAC1ANKGwfVauBXbRrxRwr
 p1r2IvgNsEybbfKnS1ijjWmd70YZ7+AuDfeb/7PYInwD0Aa1ou330w/fedXT2lrvkyqF
 hHHrtxhVlI/TSfL1Y/SLScywFswb6eXxlu+W4YwDoaFMlfT+sRMKtGdKuAqXqVTHqo/o
 slld/5WM0AekV8R79f+4lzmTXe1dNXmqwqgEkrwTx1MTs8KySX5r647APn26nbKlnbss
 dxoCoD9OZ/S1Oume+974/jBtFluskrvpOBKleRR2OhRdol4mosyebMDcWA6ItkIzHZVu
 TTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VpxcwQfT6oonbjtfL7efqwNP5w52cC1PYO/hslDRy9Y=;
 b=uJN2TkAQaDDXqBNVQ+ogAz9KqO8uI09a1O2hXWpM+U072qCI7pUI4Ez0HCRoBl2hWx
 NmaDdJJY3fyj5pFXX/aMiEXhbT8W31O7quWbPAKF+eYewoo+6I+1kcKwdLQUu/GDh3mb
 uSYuAceMzrEMpaulN+y4zkzfRbp2V/l8Qkg8YZXfLn6p8NeOnX4TUkd9Dq91612HCrZu
 08fgqhQ4VehE/2HL2JFdOy0IEfM1A25C9Zq9oj7tv4mrA+3VAxU6m/sV5KJOr76L/Hal
 nAY+5lSPU30LqunobDdqYAMxFWMmzJ38+vDqbEKrS/Sd7Fj65XmJy9sVhdMsu4v9a5vl
 SK7Q==
X-Gm-Message-State: APjAAAVPB3qwn+p6AY+ZxscSzZfMRyenRH55CoMOFnljw0KFJThfFY/1
 jzYciRsYNe4vh29QtT5cj/rb8tmKCtXn4Zh91iDqZA==
X-Google-Smtp-Source: APXvYqw4tu/0con8kdCslr58/ls7WFg600Lm886pSc8QYF3iPSdqDaiNE5PxsXvfe6tOpJhOqzyiyQoYzgHAB7C8v2c=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr13421086oib.163.1563192008781; 
 Mon, 15 Jul 2019 05:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559944445.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 12:59:57 +0100
Message-ID: <CAFEAcA95grVBoiCbMAeZYTXYxc6nhjx1EM6=05G_3Qqpp8obNQ@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v1 00/27] Add RISC-V Hypervisor Extension
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 at 23:03, Alistair Francis <alistair.francis@wdc.com> wrote:
> At the moment this spec is in a draft state and is subject to change. As
> QEMU is extreamly useful in early bring up I think it makes sense for
> QEMU to support non-frozen extensions. I would like to decide with this
> series how QEMU will handle all future non-frozen extensions. That is a
> standard way that QEMU users can test future RISC-V extensions while
> still understanding things will change. One idea is just to disable it by
> default, another option is to maybe use the Kconfig to make it a compile
> time option which developers can use. Should we also display a warning
> when running non-frozen extensions?

We had an instance of this for Arm (though in fact the
relevant patches to QEMU didn't end up getting into master
before the spec was finalized in the end). My suggestion
would be at minimum:
 * by default non-frozen extensions should not be provided
 * they should be enabled via a command line option (cpu
   property) whose name starts with "x-", which is our standard
   way of flagging properties that are experimental and subject
   to change or removal in future QEMU versions

That way end-users know they're doing something non-standard
that won't necessarily be supported in future by newer versions
of QEMU, and if people copy recipes/commandlines/random guest
images off old blog posts there'll be a hint that there's a
reason why they don't work on newer QEMU that adheres to the
final spec.

thanks
-- PMM

