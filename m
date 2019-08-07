Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A4AC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4068522297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+21YdEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4068522297
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOUk-0000es-Gu
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38717)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvOUL-0000A5-VA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvOUL-0006xn-19
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:08:33 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvOUK-0006wY-SS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:08:32 -0400
Received: by mail-ot1-x342.google.com with SMTP id q20so106318905otl.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2ZCkxkytWinsMyVRfWhsDZx6isZVn4x+oSVRiGbRPWA=;
 b=D+21YdEiHGd2h9Ug53f9imY1D4X4S6n+M8+ufv/b/ir7SDBqpZ3FqIpSXwKRhQ1/Ud
 6qJRJr2YWFE2L7v7P0CUShMVzBJHOZ3Ja9EY97W7ElDmgdPODZGosQw3cJRx2Mza4uKY
 vmwPIDF7AMyx9uKPQnDycj7uZ9fFRJHTaBO2Z/H04EMSsemBonquEVY1jAG9uClpTqvY
 eKCVCR74N3Zc+c0Rnfji88qLqPE1aMDnFSj4NJF9qjmATj2FkAJ3pTgtuuE37yiMsQMh
 LMnmLv0hVVVbpuWGZuzpjsxgdhTbXF5VEKl+JyIlwY2yEPw/FDqs/OLF5315DSWE/698
 LS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2ZCkxkytWinsMyVRfWhsDZx6isZVn4x+oSVRiGbRPWA=;
 b=A5I0Deu3fBbL+Bne3tdhUIJtPwai/DS66zJU2y5LociO59r/NAWccloo/1YL1S9rVv
 qz4WzKdzTSTem+3g8PiTiYp750kJgpcZfPYP2fXKxaR5zBh8U7Hd/NWtjFmSni0EWFjk
 y5RPeFWQhtuz6dJuOsxCt7MqrGMFnGSoa9V7LnBAQcgBw+Tncvu7CjJ65ivgxjWBGmoD
 MVPJL/9pmzEDRD4kugb7Y52I83pSltggJxovBIAydjuPHXAIfOJ/aG/xMLMRWDR3Nbzr
 5N+5MI5Z6K2kMYmQn7Fg/NqZ4dwQNLkAsn/+Kvt0kGgIcU9igpdeO5xlZ1bl/YqC6ugG
 TSYA==
X-Gm-Message-State: APjAAAVjlHbEN5/pxUM2th98VbQyl1YuDD7TnfRHqjceXlE7tsr3e+ze
 50wpqCIh35aRVvdUlXVpoztZH7MzARtsEdhhNjKlTQ==
X-Google-Smtp-Source: APXvYqwQ7Xyytx7/4Owovq4vlqgWiKbbgxvu7x6KJ/3waZhjst4dJKX+t6FUbAHvp/UMJ+scCF9cJwn07tmokQK8R/w=
X-Received: by 2002:a05:6808:8c2:: with SMTP id k2mr494521oij.98.1565194111851; 
 Wed, 07 Aug 2019 09:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190807145939.1281-1-palmer@sifive.com>
In-Reply-To: <20190807145939.1281-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 17:08:20 +0100
Message-ID: <CAFEAcA8q-NSx51TkcbLSgVTyHNYjDe5pK5+u9HXABxANQEhT1w@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH for 4.1] RISC-V: Ignore the S and U
 extensions when formatting ISA strings
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Atish Patra <Atish.Patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Aug 2019 at 16:02, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The ISA strings we're providing from QEMU aren't actually legal RISC-V
> ISA strings, as both the S and U extensions cannot exist as
> single-letter extensions and must instead be multi-letter strings.
> We're still using the ISA strings inside QEMU to track the availiable
> extensions, so this patch just strips out the S and U extensions when
> formatting ISA strings.
>
> This boots Linux on top of 4.1-rc3, which no longer has the U extension
> in /proc/cpuinfo.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
> This is another late one, but I'd like to target it for 4.1 as we're
> providing illegal ISA strings and I don't want to bake that into a bunch
> of other code.

Sorry, you've missed the 4.1 train by about 24 hours. There
will be no further changes to 4.1 unless they are absolute
showstoppers (security bugs, bad data loss, etc), and this doesn't
count, judging by the description.

thanks
-- PMM

