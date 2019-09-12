Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87645C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EAE2081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TiKBQihG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EAE2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Q33-0005Cd-7o
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8PsI-0000pz-MJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8PsH-0006Dw-A1
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:15:06 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8PsH-0006Da-4o
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:15:05 -0400
Received: by mail-oi1-x241.google.com with SMTP id k20so17218591oih.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eWiThfQUVVKF5vb3iqCUkvvImOPNJ8x3scWidJApFZ0=;
 b=TiKBQihGhUsFBK1yciSH7b91LsKnWTS/UQRSh3k1PVygmzmfeTFDYetAx2CwahduLj
 Tpsk51zNG/V/aGI1tjFjWu7EPTitw/+coHd22GvZHh9g6vmoB6xy1pqPX76mW0mbxPC4
 NVsu18s784ounlsxEtjWDmT8KCHe2F4mRJRn2blaPUqdpUjWM3pUA1F9xU48BX30Uu5p
 wov3KxIJ6I1dWGaWbMtb3i73hTV/zFcxXIuX5Q8wnldkXJHx7kvn/nHMKt/iiRqWjfVV
 Khzd8xUSU1Ni+nm++61BC2wqeRVFZHV/SJD+SLfdbDI67qR+NvCp+TCoxk+XMU4od+6X
 zZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eWiThfQUVVKF5vb3iqCUkvvImOPNJ8x3scWidJApFZ0=;
 b=Gv12MGcOdbCGt1uMfMOC31lTOmqPKr7vRP0qRBo4Ma6i2+2w1VHR0IHNh0mN14UopK
 fH2UkvQ5LkBcwO84idV6Arurotdvadaqib+61/csganyj3d9nzmikdiA9t6HdbeiGQat
 SCONlv5nlftkWIWPbL5rVJVRdkSGl5gNjaAu7OyM3+CXv8pHpBe0ZCSF4/iQtp+lO5hd
 vdmc4Oye7GwgUkmextnMr7pZt1H6U0STvE+xQOPlr3uF5vZKOPWFyVr13O8HBX+zW/jp
 JXQN+Zrz0S1t3NN61Hga+7//4UsKzv20BlzKBJSWi1nk1XO+HVfL4w6wJPkX/UxKdGLf
 Ns6w==
X-Gm-Message-State: APjAAAX53IKHKivnx85BgdDzM8HH9FXe6YD0p4fRu0yDA9BX45FzMCVo
 gePvNYOOqEUDK5Qvp2JqIhgjc9UnTbYj+gv++RdAPw==
X-Google-Smtp-Source: APXvYqxwqbTe6ZM5DUXt4/h95Cs71mY6QcWl8TLKOVl44PLk+dxQfXX4huTQ/aBQt+MZApvRsvD36RHdSpaxOfptfR8=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr245035oif.98.1568297703890; 
 Thu, 12 Sep 2019 07:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR08MB439957EF8E072A9A2A96B58DE5B10@VI1PR08MB4399.eurprd08.prod.outlook.com>
 <20190912000719.GF13785@umbus.fritz.box>
 <VI1PR08MB4399E7ADF4DA20EA65CCA74DE5B00@VI1PR08MB4399.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR08MB4399E7ADF4DA20EA65CCA74DE5B00@VI1PR08MB4399.eurprd08.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 15:14:52 +0100
Message-ID: <CAFEAcA_HHLzCJmxVpJZgqzdNp8ujSPrO3JOjgXpsEAkTUzFKSw@mail.gmail.com>
To: "Muolo Vincenzo (S.I.)" <vincenzo.muolo@angelcompany.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] R: issue related to boot aix 7.1 when I try to use
 qemu ppc64
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 15:09, Muolo Vincenzo (S.I.)
<vincenzo.muolo@angelcompany.com> wrote:
>
> Hi David Thanks also for for answer
>
> Now I try to install the qemu (4.1) into DEB Server  ( qemu_4.1-1+b1_ppc64.deb   )  however I had the following error :
>
> apt install /home/vmuolo/qemu_4.1-1+b1_ppc64.deb
> dpkg: error in processing the archive /home/vmuolo/qemu_4.1-1+b1_ppc64.deb (--unpack):
>
>   the package architecture (ppc64) does not match that of the system (amd64)
>
> Now this means that the "old" package qemu  ppc is valid only for 32 bits or no (?)

This means you're trying to install a package intended for
PPC64 *hosts* on your x86-64 box. You want the package for amd64
hosts, which should include the 'qemu-system-ppc64' executable that
supports PPC64 guests (as well as the executables for all
the other guest architectures QEMU supports).

thanks
-- PMM

