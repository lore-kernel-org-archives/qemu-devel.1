Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EF9C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3287B2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiWyH2rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3287B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0Mr-00084a-C6
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iB07S-0008UJ-18
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAzvN-0003pJ-Nx
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:08:58 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:42659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAzvN-0003ow-GF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:08:57 -0400
Received: by mail-oi1-x22d.google.com with SMTP id i185so3338005oif.9
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aTRi6tT55RAkYx7Li11LL7xBS9tOOOaLa888zMSma7E=;
 b=eiWyH2rfvPL1hfDMJTJftugwJ6VKg4MAuOiAd7uncY3Ch9mHI6nO3OuywZPCwGhppX
 Vf/m/D7L/3vDy3PyCeZBTO2x0sqGlrTwrFqFpTP2KG3LuIspx3v4AnicVlYfpkIWx+Zi
 luxA6ExRi1pzu/419JGpzH1p0EybTEm4BeYf35Q0o3kMsz7mL2R8re0Z5/mJKeo/3rC5
 tFp81SHm+sVCi61kWmmX+xTx4fKPWN1lE8wFsc5jLEuH8TEqHHvJITzftFaFROvTnduS
 ZgOv4NL3YLNf8THQQ7tkgqanfoCjiEWeCu/5+3TJmHMHO7o61qx48Nzi41mrLDTRM35E
 jTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aTRi6tT55RAkYx7Li11LL7xBS9tOOOaLa888zMSma7E=;
 b=CtNoxwfnuLh1do8ni/mRz6cCj5vTZVH+Np5Y1upwZRxZJDmpLE9IgwhC3YKEpw7DT5
 uVIJJ5lg8XgJfjX3mgWon4cHCNtbtb/1j+oxfeQzDDfrMupOtoq6GPr9i1n2N/+yZHN0
 1ExxYnoZSMp7rD+et2e5cXDXzFU1MT+rbZDmvAxircNEfvb7pIfRRyMELbkAnMrZl7Oc
 DXFznSA9aJSpUpkK+n1ZAqaXTekXQwj6hpzCh4ldlWqQg+w9UNdIhjxMW+SGQKmE/qhO
 54ZVS95luenUeXohgqsXu7r2GdtIuO67Up+5QzIpac8CAWX6K+Q/H7k1K2XGz5+z/V/+
 tQsQ==
X-Gm-Message-State: APjAAAUWYGy5DZSd8Ifm/OJhxLMYgMUku5ktArXL+tZoDtmteAE+Mfev
 r/y7WJ4Zl6a3CNI2MbNuKPcOZw6ujFCa22tZ69Kii2wNhXU=
X-Google-Smtp-Source: APXvYqx2kaJxDOXY/rkLtND6vROE3hSq9/ZGuX3y7hKZ+t3+Ujsv63AJk0DrG+zwkkX5ke7r0704oiFRpm/vNk1vf1g=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr3023103oib.48.1568912936471; 
 Thu, 19 Sep 2019 10:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <9c6bf92a-0869-cf5d-222b-305e55393ebb@schrodt.org>
In-Reply-To: <9c6bf92a-0869-cf5d-222b-305e55393ebb@schrodt.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 18:08:45 +0100
Message-ID: <CAFEAcA-GdcL+4yOnn1-SbD-8F8THA1TN5japT6Sk27GwtwBNnA@mail.gmail.com>
Subject: Re: Will the qemu-devel prefix in the mails come back?
To: Martin Schrodt <martin@schrodt.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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

On Thu, 19 Sep 2019 at 18:06, Martin Schrodt <martin@schrodt.org> wrote:
>
> Does anybody know?
>
> My mail filter would appreciate :)

Sorry, no. See the announcement sent out last week:
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01645.html

We recommend you filter using the List-Id: header instead.

thanks
-- PMM

