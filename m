Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6015C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 18:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9328D2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtHuO11T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9328D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipydO-0000uT-OJ
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 13:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1ipyca-0008UC-VK
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 13:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1ipycZ-0008Tt-SX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 13:02:56 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:50752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1ipycZ-0008Ox-L8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 13:02:55 -0500
Received: by mail-pj1-x1036.google.com with SMTP id r67so1274952pjb.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ddNpVpIh534JySANnc05mdME2KsUv3D17Ou3oRSyvss=;
 b=WtHuO11TBpzSkjkgYye1kIhnMvCZOCoVwAPGmWHuLVZEhtxwS1NbkKzp0XPhBNO5Pb
 /bLDdZHHgUOR0OxHuPWZ2AjytIOWowYVj5Mnrp5fnLYblu/8gUk2g5Jd0z+E+3s/EO4x
 TijCrUKkj+D/ZeJu2dJ8I0BTbIgSJEYTU3YwvKvC9P2niokGH7dXflATNui8GWy6R4r5
 CaK2VxBG2cEga6Em9O0B9M7ODY7HhaxjPPD/F5IOMkzoqz0kULJzX65YcXOnKYjS0lzP
 L27kL1x2aI/hWAfn/m2zlpJAb6EhRrVVvoj/MXU1qiw+JveVJOFHar/8kp/ZqVZBg+63
 GJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=ddNpVpIh534JySANnc05mdME2KsUv3D17Ou3oRSyvss=;
 b=YeslUIvFL8RUrk7zf52c4eEPUrt3T2DxqdENnXRlcn4KykyFZo4xbwwkpCu7DIEPtX
 7kiHsmAml2+TCUbrs6fGrixwpv0Tx92YwRxo/035hhOXMynSFq+486P35z3VQ/hmf3pT
 CjHi5t8qzzP18A/pUg4cJ+gdpn27ip+govWjplbw0053gkjNdCMXCOa3lpyBwJiYxMUl
 fnnx6PTOc0LxUTM0TVAuHkjf3Q7LmtI2/gst9itxoYvlI81zD8yA4EZadzmwXox3/Qdk
 s/CMNgl+bSD4tF20fGvqlPoxdMEwOQqtrTT58PkG463aO8V/ZsTDGfHvckXpIcxptCRy
 0uTg==
X-Gm-Message-State: APjAAAVkJDvNYHQefZ5EYYYoz3eQjrfogP5RDVhh5/D7zz2rSe6A65SK
 PDvcS8xJ8ckhZzbsn9eBXyY=
X-Google-Smtp-Source: APXvYqzLpaOQIPhT5Zym5wZtv4u+eo31rQ5uj23LO4kGKYorirwxIq8bj6OBqdRVLVLbA51KcmPe7g==
X-Received: by 2002:a17:902:8a89:: with SMTP id
 p9mr5656012plo.126.1578679374365; 
 Fri, 10 Jan 2020 10:02:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id y128sm3608140pfg.17.2020.01.10.10.02.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 10 Jan 2020 10:02:53 -0800 (PST)
Date: Fri, 10 Jan 2020 10:02:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: How to tell DMA controller in qemu to terminate transfer ?
Message-ID: <20200110180251.GA16140@roeck-us.net>
References: <20200108183553.GA5608@roeck-us.net>
 <CAFEAcA9t4X5Xnk0aS4C-vhKX2c3GA9XQ3zZRGYVGLEQsG=EgeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9t4X5Xnk0aS4C-vhKX2c3GA9XQ3zZRGYVGLEQsG=EgeQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1036
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

On Fri, Jan 10, 2020 at 10:36:20AM +0000, Peter Maydell wrote:
> On Wed, 8 Jan 2020 at 18:36, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Hi,
> >
> > I am trying to fix DMA support with Exynos4210. The original commit
> > 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210") doesn't
> > really work, primarily because it assigns wrong interrupt lines (no idea
> > how I thought I tested that).
> >
> > Problem I have right now is that the pl330 peripheral DMA in Exynos4210
> > depends on a signal from the peripheral device (here: serial ports)
> > to end a DMA transfer. To make this work, I need a signal from
> > exynos4210_uart.c to pl330.c to terminate the DMA after the receive
> > buffer is empty.
> >
> > How can I implement this in qemu ?
> 
> That depends. How does the UART signal the DMA controller
> in real hardware? If there's a signal line of some kind,
> then you can model that with a qemu_irq line which the UART
> exposes and raises/lowers at the right time, that's then
> plumbed through by the SoC to the DMA controller.
> 
Never mind my previous e-mail; the above was enough to get it working.

Thanks!
Guenter

