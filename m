Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47B9C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7502082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2oINoPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7502082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8OG-0005mg-Mo
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ix8NG-0004O8-0k
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ix8N8-0004IA-RR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:52:38 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:37372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ix8N8-0004G8-2w
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:52:34 -0500
Received: by mail-oi1-x234.google.com with SMTP id q84so3222435oic.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OlVoJeLQtqT+0tkd1QEC9zZkcrl/hztqXIVsSUzxZE0=;
 b=I2oINoPuiAAbx1Zj9yRNZSts9n5iQUa/iZPF4fjgPbTkAPuLgTCNrQ+rU7De1zDcVi
 XycGf4+Nh2YJT9e+WdTX0F+7HhKWWZfh17Wm4WIKRB376oDO5L9ecsnr5vlf6Rp2WS03
 ZoEyorWbmU3pn9mkgrDsyqPKgFXbOQJrFslBcnJkaZNtIN816z3a72YJy929DDkixPuA
 r4G0a/uIb0OaDzXgR6zmSoXZw5c5YGJxVb3v+xuixFyLkdvq+bB5TGYBiB1vC0rlOC/1
 Px2GkSO4DhPAmExkBxtKTSwMjWbWText9UbyzSa3w+AZ+X6qQdNCIIyq0ta/boBbBhEN
 JKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OlVoJeLQtqT+0tkd1QEC9zZkcrl/hztqXIVsSUzxZE0=;
 b=Stm29HSdRUtfFwhqRJhzFuF81ME6dyEdf82/q692VLb4XefV8OYPAyulT2EbdrcDwQ
 11vsa72KpL79oT+jvAQ/Tp41HQmKeg33JjNPPAym0uuCpyIFEtjka9AP5JNv4epudNqt
 ZgP96saWbx3vhZ6Lk4hdu96Sk+dVKWyP6hck+cB1P/9+GWpY5gDldYpcGAxcVWxOHYeS
 Sl2Cpkn7gaTMM/hSxGBioIBZQ4laNpF5u4YXRUZEgiUdL2Mev7z5ZLd9uZqTlLId7N02
 0PnSH/+DaDfsfZ7pVH14ufbBXOeGW/h4OK9zWjrlVTe/fliByX0TH4IRl/XMXybJSk/Z
 Vs+Q==
X-Gm-Message-State: APjAAAWZ9Lo4Ax6DpSFGBgyi3s3gJGSv1PKcP9rL+5dcqV50NLBkfDjN
 XYAnVd020C/bJvY6dbKUloLsrEZSHOb0hS0Q9yjE7w==
X-Google-Smtp-Source: APXvYqxmpqcMmjJwoqQ/onpfh3IRhKrTd7ebJlyBOYXxX5YA/MiMaRSy6UHoW197BEQa1DQEJV/dGIJuJGQ7FPOV9m0=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2570898oif.163.1580385150395; 
 Thu, 30 Jan 2020 03:52:30 -0800 (PST)
MIME-Version: 1.0
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <CAL1e-=ghxDLcU3iqkZ8q_sbk_DyR70t2a-jFtoNDVa7iTkMXsQ@mail.gmail.com>
 <3d768689-b69f-02d9-b3b1-0c5a9a68df89@vivier.eu>
In-Reply-To: <3d768689-b69f-02d9-b3b1-0c5a9a68df89@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 11:52:19 +0000
Message-ID: <CAFEAcA8ph4Bt1S7k6NfySYM9O1YARxE54r-izDpDWoWX41z98w@mail.gmail.com>
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 at 11:20, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 30/01/2020 =C3=A0 12:09, Aleksandar Markovic a =C3=A9crit :
> > Laurent, all this seems to be dependant on whether you are ready to
> > mentor the project. Are you?
>
> Yes, of course.
>
> > The deadline for submitting GSoC/Outreachy projects (within QEMU) is
> > just around the corner (Feb 1). I leave to Laurent or Peter (should the=
y
> > give "go" to this proposal) to officially submit the project on our wik=
i
> > page created for that purpose, in the form they deem the best.
>
> Peter, is it ok for you?

I don't really have the time to do GSoC mentoring projects;
if you are willing to do the mentoring then that's great.

thanks
-- PMM

