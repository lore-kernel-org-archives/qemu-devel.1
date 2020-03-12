Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F78C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012562067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2GlV9qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012562067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRVR-00012m-61
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jCR8o-0005L4-OZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jCR8n-0004WM-OW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:57:02 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jCR8l-0004Rg-CY; Thu, 12 Mar 2020 12:56:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id t3so3358207pgn.1;
 Thu, 12 Mar 2020 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=R1Klp5VmAGtpJcR4uZfnLflfD0zf1gm8bN8uDrXOuqw=;
 b=n2GlV9qaxcgxAWMqLiIAArXZ7T8pEEua/Q1vbXXt3GGW03JhWe2miqdzBtUKzZ0IvT
 e9Ca2xCAuq+Zclf2zA5gaFjm4Sq3Tun54zSVGei94jDUPoULUCW3JLyOhCi67Pjr+JTz
 VPY8C8G03QyboWBtG7fkmolFmycRTbXKQowD8WtzWrkmuaUZFnottGfo2HVqiidygAJh
 fNN0cyWUaHDbQHzlnOppNy4elBEdH1t4dnH9EvCLDkBfAKR3IjVi9glZe+J5feZRh130
 sZ6DFRLLE2+NiCGVAt9DZFZQo/5x793638F/vBQ4AoiYoC6BhvjufSxhaKzdwOBl5ktx
 zSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=R1Klp5VmAGtpJcR4uZfnLflfD0zf1gm8bN8uDrXOuqw=;
 b=kh+eaIdMRL3xw9AgEQKqiO+YQ8VePlw+37UJDDqQr+vYZnS8zxd6B6McRND3pKOt6H
 K1c82dEFVP5U+KS6rG73vDODbA5hIhat9OpOvmPXri/ivxZL7lal5E0o9W5t/OlXih8i
 YUwSSitgHKlondwSw2OOBv0nIXvBUSnZ1ALLU1GteOJ7DdGjg486YjtvxkEBbkUxCgEO
 80BxVDX2lm03udC9uTjTgX8mXxsI9xCQ/fHInTPM1NVRQrfEzADyfMNfq0CLK8WXK74a
 pQ5OzS8mtvL3LkbCeYMi8twGc/LaW8g1xRNsmbm+s2d2nm7VJBFA4Rk0EQC0SuDENYyC
 S+TQ==
X-Gm-Message-State: ANhLgQ11s+F5gH3hzalsoR6MuqEfKOdzMPGSrDPmzZyxMYaDgedsBDwZ
 ytfSpAAVcrSan8U9vqLx6cHVN6OC
X-Google-Smtp-Source: ADFU+vv02tgl7/1sLd3pv5R9SrZixC4bN6WNWciNKx+a90kIKIManiEmnIE9lUJDC4cQ3WUmsIbrOg==
X-Received: by 2002:a63:e00c:: with SMTP id e12mr8766856pgh.354.1584032217640; 
 Thu, 12 Mar 2020 09:56:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id h132sm51332238pfe.118.2020.03.12.09.56.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 09:56:57 -0700 (PDT)
Date: Thu, 12 Mar 2020 09:56:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 3/3] hw/arm/fsl-imx6: Wire up USB controllers
Message-ID: <20200312165656.GB16719@roeck-us.net>
References: <20200310210434.31544-1-linux@roeck-us.net>
 <20200310210434.31544-4-linux@roeck-us.net>
 <CAFEAcA9itKNV6c07wm_4dJiGtHMLXCFt+A-W5xC5DX1Wxfu30w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9itKNV6c07wm_4dJiGtHMLXCFt+A-W5xC5DX1Wxfu30w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 01:29:34PM +0000, Peter Maydell wrote:
> On Tue, 10 Mar 2020 at 21:04, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > With this patch, the USB controllers on 'sabrelite' are detected
> > and can be used to boot the system.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> > +    for (i = 0; i < FSL_IMX6_NUM_USBS; i++) {
> > +        static const int FSL_IMX6_USBn_IRQ[] = {
> > +            FSL_IMX6_USB_OTG_IRQ,
> > +            FSL_IMX6_USB_HOST1_IRQ,
> > +            FSL_IMX6_USB_HOST2_IRQ,
> > +            FSL_IMX6_USB_HOST3_IRQ,
> > +        };
> > +
> > +        object_property_set_bool(OBJECT(&s->usbphy[i]), true, "realized",
> > +                                 &error_abort);
> > +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usbphy[i]), 0,
> > +                        FSL_IMX6_USBPHY1_ADDR + i * 0x1000);
> 
> Are you sure these addresses are right? Four of these starting
> at USBPHY1_ADDR means the last one clashes with what we define
> as "FSL_IMX6_SNVSHP_ADDR 0x020CC000".
> 
> I only have the i.MX 6Dual/6Quad reference manual to hand,
> so maybe this imx6 variant is different, but that document
> says there are 4 USB controllers but only 2 PHY blocks.
> 
Oops, I think you are correct. Good catch. I'll re-check the datsheet
and send an updated patch.

Thanks,
Guenter

