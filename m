Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71A2C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A159120866
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKS2M+gW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A159120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBMCJ-0008DC-TU
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 13:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jBMBf-0007c8-72
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jBMBe-0002oT-8p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:27:31 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jBMBc-0002nG-1g; Mon, 09 Mar 2020 13:27:28 -0400
Received: by mail-pl1-x642.google.com with SMTP id j20so4254802pll.6;
 Mon, 09 Mar 2020 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BZngQXGMUcd9HSfvr8IOy8qIk/2ixiIy5QrDgre2vx0=;
 b=AKS2M+gWUJ28ir7RFBtbVPchPt7iyBv4j4AtB6Vlroyn2fO9vFg+4QJ5jpqdwxm97Z
 T5lxsD6QneeIiSC1mrQa2a6A8ARkBbHs7ZNwKBpabErQ2zzyBJ1v30SoTkzPpuEqvHlR
 QBHNIv1rblMiWOzAUDuy/Hyak7rN9u288iGgzgn3Tv4pQmS4flu69M8phfPT8JjkkiUa
 Rucv1WfFOQ6uraScFo7ySNDUcMxhAWbvJAotYbD3uZSNqH8L6ags23wGiil3HleUgG/d
 DlRpI/0GGNfhx/nnVPL0MhP+Q6QoeKUs4oyDC7PD/qL6PIzjzPaRB37MpfdI9sF4Zuuv
 6pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=BZngQXGMUcd9HSfvr8IOy8qIk/2ixiIy5QrDgre2vx0=;
 b=U6zgqC67zE494zfbOeRsAzH2Gq6QAMQdrGD6B05bbXxakih5OEq8/Gh5ukQlQnd3AC
 NIP5D9sktRO2OlKwpNg1FqNiEgz0F5Y0a5uzagqzP4tUUuwKTChzyZSmyyi5Q3eApJT7
 D0bBdCtiftHtbTSvm1w9bpsXidrMkstSgWPlNMIozrZwAWhpDM2zrg29Ai3aDr0ixxL+
 dBqCm2JfTVenZci9iSJix9QWarkaLhYKRZawaDtdfutlhppCQFRfhI6dIim9QoxYBvam
 TzFqzRb7F1YMIqdyk+DcxCsAAJODGoa2M/If/8ewWvanlTGCe+FQBOUhfSjS1P3m3+UI
 c9xA==
X-Gm-Message-State: ANhLgQ2Hqx5AMt3OibBC1i3mV9snw8gOI1OEAeZDN4i4lOR3C7RXTo8J
 Y6UqmqIKUeJ7TcpIrjAf3AY=
X-Google-Smtp-Source: ADFU+vusNBNI0NtDRVj9D2+taP4aOBrImsyA2PSc1FGnpquKhGTEUsJh9uMLPyASpHKszjmjMMmlrQ==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
 ay10mr17112803plb.288.1583774846907; 
 Mon, 09 Mar 2020 10:27:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id k9sm147850pjo.19.2020.03.09.10.27.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 09 Mar 2020 10:27:26 -0700 (PDT)
Date: Mon, 9 Mar 2020 10:27:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/3] Wire up USB controllers on fsl-imx6 and fsl-imx6ul
Message-ID: <20200309172724.GA25106@roeck-us.net>
References: <20200301170443.12904-1-linux@roeck-us.net>
 <CAFEAcA_VuY+1egn8B6=Tk8PKGuhAPuP4-=pwuWHQGQsfdXB=dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_VuY+1egn8B6=Tk8PKGuhAPuP4-=pwuWHQGQsfdXB=dw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 05:09:21PM +0000, Peter Maydell wrote:
> On Sun, 1 Mar 2020 at 17:04, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > This patch series wires up the USB controllers on fsl-imx6 and fsl-imx6ul
> > emulations.
> >
> > The first patch is a prerequisite for the following patches. It provides
> > a dummy implementation of a register widely used on i.MX systems, and
> > specifically the reset behavior of this register. This is needed to make
> > the USB ports operational without full implementation of an emulation
> > of its PHY controller.
> >
> > ----------------------------------------------------------------
> > Guenter Roeck (3):
> >       Add dummy i.MXS STMP register support
> >       arm: fsl-imx6ul: Wire up USB controllers
> >       hw/arm/fsl-imx6: Wire up USB controllers
> 
> I'm not a huge fan of the "dummy device that's really just
> implementing 4 registers from the middle of some other
> device" approach. Unless you think we're strongly likely
> to want to use it in other places, I think I'd prefer
> to just implement a (minimal/no-functionality) model of
> the PHY register block.
> 

Sure, no problem; I don't really have a preference. What would be
the best place for such a dummy phy ?

Thanks,
Guenter

