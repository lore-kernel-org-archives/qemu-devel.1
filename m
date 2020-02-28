Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBBDC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 23:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E39246B6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 23:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFzBc6Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E39246B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7osu-0002F4-4l
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 18:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j7osB-0001iP-Qo
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 18:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j7os9-000787-Vb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 18:16:47 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j7os4-000742-4M; Fri, 28 Feb 2020 18:16:40 -0500
Received: by mail-pf1-x442.google.com with SMTP id i6so2479458pfc.1;
 Fri, 28 Feb 2020 15:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yPhsdxmC3P85Uu1od0m2OjFA80DoP33yC53pLjt19dE=;
 b=jFzBc6Kp3JmT6ItRsoBTr3TfN0cqoAeg2VmGP8JAfAlhCsiqZYswieYPgs8//hh2BE
 mUAostq2UGWcb+C4aUe5A6VpwxTBZ5fbgfGcBEdVnpeYhZF32P0aHc2D31CwhhAOuA7Q
 evZ1tzycAyjDAmbpozrt8zAk018JG5HEpxlO4Fx6AGdpnxTqdiLsPqbQOwfhf/oNtqMX
 saXbl/ON3Pg8eAylaTyStPdqMk+HREHn7ZbvULRJQ18L/Ov0NXjag8CjxzCjWk1ydi55
 7jwprKYLBIgrqRYHXJbybOZ1qOygBmHhLyXpuU4K3ejxvRxLBSgOP2yrwV3ZMHnL0BS/
 yHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=yPhsdxmC3P85Uu1od0m2OjFA80DoP33yC53pLjt19dE=;
 b=nKA8NPO0y6jWMkjAGS1cGzdEx8X8w2hMX3fI7xk/FYTesbTKIJV6ZFI6knVujPFAYM
 +bOo/+l1GB8ENC54ZaKbRCZdZjB6rmdtOh8wXp7gV45vpIq1zd471PNMo/JrRfWfXMlB
 TcHTrCz3qjL7chbkXUOlZToje+eyMawO0WqeH3zkrsxotP9AbYLTJm6tA1E8ESmU63i7
 bDJbw8B0lO46zpKkJVS6NVssS7ooszqKEh/WAHptlys7MVyKup38fPa2BRfpDfoBPeZI
 O+POPCGk67tmifdl9AWJH6Ty1kuG4NtIs/lEmWaI2xdcwRmUfNGxEwKjyOTPGJmQGDnP
 dYiw==
X-Gm-Message-State: APjAAAXxiTyrBpN3D99VApmD9Ot1UGN8R6T7Ul6uwsqpLUhx/Ec4YftL
 +tir/uxTQuUT8zxHfSKmGcA=
X-Google-Smtp-Source: APXvYqwGlSC6CWYrS2loT1X9jucypmqglMY4S5NRxMtvWKfRFl5XczwkFK8fgIRIAncMyiF62qKCEw==
X-Received: by 2002:a63:b22:: with SMTP id 34mr6698586pgl.78.1582931798845;
 Fri, 28 Feb 2020 15:16:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id t20sm133819pfl.114.2020.02.28.15.16.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Feb 2020 15:16:37 -0800 (PST)
Date: Fri, 28 Feb 2020 15:16:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 0/2] hw/arm/xilinx_zynq: Fix USB port instantiation
Message-ID: <20200228231636.GA11737@roeck-us.net>
References: <20200215122354.13706-1-linux@roeck-us.net>
 <CAFEAcA-u=j3MYu-Ck0UbMzXXEoB41dx6UbGw15QBEnqBBX988g@mail.gmail.com>
 <CAFEAcA-_V-7VDZvVg4WE99A4b1UimQ0RrLG910qmsxCgRVvq5A@mail.gmail.com>
 <CAJy5ezoP7qNCymOpVXgMcwOuYvXBPVnf718gN_qfsfW_D9MVFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJy5ezoP7qNCymOpVXgMcwOuYvXBPVnf718gN_qfsfW_D9MVFQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 28, 2020 at 12:44:19PM -0600, Edgar E. Iglesias wrote:
> Sorry Peter, I missed the email.
> 
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> 

Thanks a lot everyone!

Guenter

> Best regards,
> Edgar
> 
> 
> On Fri, 28 Feb. 2020, 10:00 Peter Maydell, <peter.maydell@linaro.org> wrote:
> 
> > On Thu, 20 Feb 2020 at 15:05, Peter Maydell <peter.maydell@linaro.org>
> > wrote:
> > >
> > > On Sat, 15 Feb 2020 at 12:23, Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > USB ports on Xilinx Zync must be instantiated as TYPE_CHIPIDEA to work.
> > > > Linux expects and checks various chipidea registers, which do not exist
> > > > with the basic ehci emulation. This patch series fixes the problem.
> > > >
> > > > The first patch in the series fixes the actual problem.
> > > >
> > > > The second patch removes the now obsolete explicit Xilinx
> > > > support from the EHCI code.
> > > >
> > > > v2: Introduced summary
> > > >
> > > > ----------------------------------------------------------------
> > > > Guenter Roeck (2):
> > > >       hw/arm/xilinx_zynq: Fix USB port instantiation
> > > >       hw/usb/hcd-ehci-sysbus: Remove obsolete xlnx,ps7-usb class
> > >
> > > Xilinx folks -- could you provide a reviewed-by or acked-by
> > > for this series, please?
> >
> > No? Oh, well, applied to target-arm.next anyway.
> >
> > thanks
> > -- PMM
> >

