Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6D2C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA48A2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGiPRQuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA48A2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieipT-0008A2-Oq
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <daniel.thompson@linaro.org>) id 1ieilm-0003wM-VJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <daniel.thompson@linaro.org>) id 1ieill-0007dK-QJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:53:54 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <daniel.thompson@linaro.org>)
 id 1ieill-0007cP-JP
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:53:53 -0500
Received: by mail-wm1-x344.google.com with SMTP id d139so1626599wmd.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UxvJ/YVTJuP+hzpz1BJMpuf68KLAsLUo57u2sksODLU=;
 b=BGiPRQuwSInGNHSJAJJyjw7IdSn2N/5ded78AZFJiUsXWL2FJn25Ro9Kdak/CS/Wlb
 RDw21qnr3CwaeOALl/A0is/GVeXyG2FwjftKiBjFdzylfZ3YkLhwt00ZN7h5XDBUkxVl
 5ki1+DZNwPsqJTJMr6Yqr8rrpr1Ng3Nf8gYauYG9PUJWf2dgs4B3Fv+lipGlTHY12kTg
 E0pKtq/Kpr5Wu2SzOCbvCgGaZOYrYIrdKtwQpYuUrfqllnpKfzitGy/HXk+zOY8zaKdG
 5W9mCF2aLisOKJnqwI3t7QFqLJtIzSHq/Vz57fQPwoSFVJHZLmgDGLv/Dr9zbyclJ0fj
 A0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UxvJ/YVTJuP+hzpz1BJMpuf68KLAsLUo57u2sksODLU=;
 b=iMx3knhuCaPaU5BJYPMmE5LdOUJagYgLfJ+gMc8Z0d8nQIyH3itlg6TJBUziFUqiuL
 26hxJ2qQCTH4hgTtwNoNLP/OR9YY/PcW6hBAGyrOzJ2jyOSrTvt4yE2fAALIjDLSosud
 F5nxXskrqVLzjPDJPNlLpWx+OUgri0ma8Yi+PQD+vMgD8fLJUAooQR30CM1www3r3WYP
 PPQe7oBUz+EiGuMfYeHteyPrghql4E2O7fyFcuatWhmQjVqZQq8bPM2iy2BOf8k1x74Y
 A50ovOlBRqrjDmvGxaC7iZLflYOFytlK8WCyUGOUtkikw7GqBYLntVmdEZBi4clfVNT0
 3TCg==
X-Gm-Message-State: APjAAAWba+MjR4Zr3xnRMlwDp3WiG5CPrAg5+CnkjQq01yHQlyHYg+or
 pJHZ43we6BpnbSaTMNqvzCLNCQ==
X-Google-Smtp-Source: APXvYqwad2Wvw1plasNOQ27dhBz3MdQF4fdcqMICgUC5o9UQARbbU/XuWPAgnzI2IYafpsKxr9Fc5Q==
X-Received: by 2002:a1c:731a:: with SMTP id d26mr5975246wmb.130.1575996832049; 
 Tue, 10 Dec 2019 08:53:52 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id z18sm3637640wmf.21.2019.12.10.08.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:53:51 -0800 (PST)
Date: Tue, 10 Dec 2019 16:53:49 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/arm/virt: Second uart for normal-world
Message-ID: <20191210165349.5sfyqwkbpfl7nlk2@holly.lan>
References: <20191209152456.977399-1-daniel.thompson@linaro.org>
 <CAFEAcA-sgFKev2MiOjRAzuE0trNYQoNe6LOFLeghGm73N1h=SA@mail.gmail.com>
 <20191209170827.yojyts6qdvpxbkp4@holly.lan>
 <CAFEAcA_3_EwjAZ_Av4a9BkT_3KmbEEFFFukyV7gsDuWPrYKmVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_3_EwjAZ_Av4a9BkT_3KmbEEFFFukyV7gsDuWPrYKmVQ@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "patches@linaro.org" <patches@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 09, 2019 at 05:10:30PM +0000, Peter Maydell wrote:
> On Mon, 9 Dec 2019 at 17:08, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > I don't object to making it command line dependant (it is certainly
> > lower risk) but, out of interest, has using /aliases to force the
> > kernel to enumerate the serial nodes in the existing order been ruled
> > out for any reason.
> 
> No, I don't think anybody's investigated that (I wasn't aware
> that you could do something like that). Bear in mind that the
> kernel is not the only consumer of the DT, though -- you need
> to use a mechanism that all DT consumers will handle correctly.

The syntax for /aliases is standardized (in the DT documentation) but
AFAIK the exact semantic meaning of an alias relies somewhat on idiom.
It is true that the DT binding documentation for some serial drivers
does include details of /aliases but sadly PL011 is not amoung them.

I took a fairly detailed look at FreeBSD. I don't think /aliases is
used to control enumeration order but that appears to be because
aliases are handled in a different way to Linux. For example 
FreeBSD allows a custom console to be selected using FDT syntax
(hw.fdt.console=serial0 or hw.fdt.console=/path/to/fdt-uart ) which
means the Linux-like approach (such as console=ttyAMA0) need not be
used.

In summary I think that support for /aliases can and should be added
since it the best way to help DT systems figure out how to match qemu
uart numbering to its own naming.

However I agree we still need a way to create systems with only a
single UART even if I have not yet been able to come up with a test
case that proves /aliases is insufficient ;-)


Daniel.

