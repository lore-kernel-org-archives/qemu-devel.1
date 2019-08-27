Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA6C3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 01:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D7B20850
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 01:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB2pFPJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D7B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2QNm-0004WY-Ku
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 21:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rashmica.g@gmail.com>) id 1i2QMs-00041T-LL
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 21:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1i2QMr-0006XA-E0
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 21:33:54 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1i2QMo-0006Uv-Jc; Mon, 26 Aug 2019 21:33:50 -0400
Received: by mail-pl1-x644.google.com with SMTP id y1so10893183plp.9;
 Mon, 26 Aug 2019 18:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=mDeShrRdVrY6FWytadHxdKrz4l1eQGKAvhSA522f2Kw=;
 b=ZB2pFPJb8dt3c+N9F68RvdFDQv5MHt9UIXy3FmocH29TDaHEjFIOS7uIsJGzdHYIkI
 a2DgwahV+Zw6rIroDh0ILY2nw/T0G3Iit3a84DFgdPhqAjk4IuDhDui+G4Ds/S6DDmZz
 Attd4Yo6kwsXGd2cvxZZTlD9px/nnZx2St62eCXQjZ865GVCWhEYxi+TiHXeRIUIM5Ct
 kgfxQJ1HaFQdvak/JQUPUHAJMF8ckY+USqxAokEh+G1jFUcKpVST+6TdJwcyN3AYBJf6
 2w8JAN42AIM5qG0LwgmqyTkjpRZeEJgTEHE7NEwdnqsEsaL2ByerGqQA4mB9z7xy2cbV
 iUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=mDeShrRdVrY6FWytadHxdKrz4l1eQGKAvhSA522f2Kw=;
 b=TPcjBeIOrHZvH/z453pIqTkuRAUZyxlqFje9hR+1l3hTjjL8ge+vJhCXqopmGMvueP
 FbBamdzk6EpMt4BlisWzpy5a21Ihhahp2I78Lhy0SwCcb1Mxu2JN0ljChkwQYKu3Rxe1
 +fzAbPIgNCb2RxRWpyzlmV7s+OMR92ZjCSUkvL33jsnqnTY5pW6kIuFhUXySTL3I1SjQ
 KSbtB8QzS2zw5ImXKymXaHNHJovLA05TEYRDhG8Dst7vZBFpe2hLJEVXOOGnH34kzSPV
 B74Uu6lpPIc5MucaFjlbir6Td9usX+B6P2hD/W7sd+J9wbupHS1y+zMW3nNVXVX0Mav/
 Vzvw==
X-Gm-Message-State: APjAAAVvB690+KoqwgwHbhLGmjS0dsqjqexO9wGQAcnxCR5P8CK5Of5W
 a6bZMw4FzkhOoAlfXgwwRL0=
X-Google-Smtp-Source: APXvYqzTs5YFsZpsLlELK6uoUb54PcU/RQ6GtWOZFdLb7pARvDBWGhdAdILEHouGxaMas6viLBZfDA==
X-Received: by 2002:a17:902:6f10:: with SMTP id
 w16mr20666106plk.143.1566869628876; 
 Mon, 26 Aug 2019 18:33:48 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id z24sm15880987pfr.51.2019.08.26.18.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 18:33:48 -0700 (PDT)
Message-ID: <a27a64ed891e57c24f778ac544a73f3f77a0de01.camel@gmail.com>
From: Rashmica Gupta <rashmica.g@gmail.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, 
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Date: Tue, 27 Aug 2019 11:33:43 +1000
In-Reply-To: <120fa848-808f-b918-14f3-ab9d1f06532e@kaod.org>
References: <20190816073229.22787-1-rashmica.g@gmail.com>
 <120fa848-808f-b918-14f3-ab9d1f06532e@kaod.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Add Aspeed GPIO controller model
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
Cc: andrew@aj.id.au, aik@ozlabs.ru, qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-08-16 at 18:21 +0200, Cédric Le Goater wrote:
> On 16/08/2019 09:32, Rashmica Gupta wrote:
> > v5:
> > - integrated AspeedGPIOController fields into AspeedGPIOClass
> > - separated ast2600_3_6v and ast2600_1_8v into two classes
> 
> Rashmica,
> 
> This looks much nicer !  
> 
> Please take a look at branch aspeed-4.2 in which I have merged your
> v5 and modified slightly the ast2600 part. 
> 
>   
> 
https://github.com/legoater/qemu/commit/02b3df3f1a380eec4df7c49e88fa7ba27f75a610
> 
> I introduced a gpio_1_8v controller with its specific MMIO and IRQ
> definitions. Tell me what you think of it. The principal motivation
> behind these adjustments is that I don't know yet how we are going 
> to instantiate/realize the specific models of the AST2600 SoC. the 
> GPIO 1.8v is one of these extra controllers. 

This looks like a much better way to do this!
> 
> Thanks,
> 
> C.
> 
> > v4:
> > - proper interupt handling thanks to Andrew
> > - switch statements for reading and writing suggested by Peter
> > - some small cleanups suggested by Alexey
> > 
> > v3:
> > - didn't have each gpio set up as an irq 
> > - now can't access set AC on ast2400 (only exists on ast2500)
> > - added ast2600 implementation (patch 3)
> > - renamed a couple of variables for clarity
> > 
> > v2: Addressed Andrew's feedback, added debounce regs, renamed
> > get/set to
> > read/write to minimise confusion with a 'set' of registers.
> > 
> > Rashmica Gupta (3):
> >   hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500
> >   aspeed: add a GPIO controller to the SoC
> >   hw/gpio: Add in AST2600 specific implementation
> > 
> >  include/hw/arm/aspeed_soc.h   |    3 +
> >  include/hw/gpio/aspeed_gpio.h |  100 ++++
> >  hw/arm/aspeed_soc.c           |   17 +
> >  hw/gpio/aspeed_gpio.c         | 1006
> > +++++++++++++++++++++++++++++++++
> >  hw/gpio/Makefile.objs         |    1 +
> >  5 files changed, 1127 insertions(+)
> >  create mode 100644 include/hw/gpio/aspeed_gpio.h
> >  create mode 100644 hw/gpio/aspeed_gpio.c
> > 


