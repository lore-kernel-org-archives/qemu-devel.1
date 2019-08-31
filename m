Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545DCC3A59F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 05:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CCE23697
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 05:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CCE23697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3vo3-0007h5-6X
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 01:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i3vmy-0007FF-P2
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 01:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i3vmx-0008S4-GX
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 01:19:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i3vmx-0008ON-An
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 01:19:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so5366345wmg.5
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 22:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GYBG64x82mA8qpzhNlDzQHz7rZMvZAsAorlqlXoDlJE=;
 b=G0jQaYkiKsJjCYyY/LzJSDS7tlk5ofPM2Rg0kH7XfsPY34hZcjN9Ig6zXPcZA/0CnS
 HgJhC52EqC5HCRRju11VKCMubyR8bI3E0dZ0A3iCiFpONZmdx1kZIFdwmoUAGE6jSRGJ
 iuc8pXgkb7EOmJNo9KIk8pE99Q0+964IXYH4kFJWWhaY0jxfNM1AvrNGQ4Ir6OwhNRrs
 F2MN7zPTW7zLYxX6QP51MivWpCMCpB+lMWtEJ8syfw7NDi+GTbYG+eYt5JYwzD0WVeCx
 MkCTFl2Oa/9HSJTOoLDW5nXYRXSngxNA9qBCiEnl34+7F12JKXFBVPOtrd38qW6mVWKZ
 n6VQ==
X-Gm-Message-State: APjAAAWMk6pZTridO6HywMUTabVyTPuaUOO2rTsZB2cBAPsh+tJ1TkDA
 fPVOHKvs0GEUsk2rpTgTKPM=
X-Google-Smtp-Source: APXvYqybVhOjIXPsgjew7cywmBzyNXfq9KUnkzQmFIX0eYyPKLT+eVDYlmlc7SO3LEdlGCTe77QaXg==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr23343583wml.175.1567228742057; 
 Fri, 30 Aug 2019 22:19:02 -0700 (PDT)
Received: from thl530.multi.box (pD9E83624.dip0.t-ipconnect.de.
 [217.232.54.36])
 by smtp.gmail.com with ESMTPSA id w5sm5716991wmm.43.2019.08.30.22.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 22:19:01 -0700 (PDT)
Date: Sat, 31 Aug 2019 07:18:57 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190831071857.5e3f53dc@thl530.multi.box>
In-Reply-To: <CAFEAcA9uech2_Uc1XnxSm8Dk2rEAuyvxtnH74e_oCgw7ovVCaw@mail.gmail.com>
References: <20190709073222.26370-1-huth@tuxfamily.org>
 <20190709073222.26370-3-huth@tuxfamily.org>
 <CAFEAcA9uech2_Uc1XnxSm8Dk2rEAuyvxtnH74e_oCgw7ovVCaw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v4 2/6] m68k: Add NeXTcube keyboard device
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Tue, 13 Aug 2019 11:16:44 +0100
schrieb Peter Maydell <peter.maydell@linaro.org>:

> On Tue, 9 Jul 2019 at 08:35, Thomas Huth <huth@tuxfamily.org> wrote:
> >
> > It is likely still quite incomplete (e.g. mouse and interrupts are
> > not implemented yet), but it is good enough for keyboard input at
> > the firmware monitor.
> > This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch
> > at
> >
> >  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-kbd.c
> >
> > and altered to fit the latest interface of the current QEMU (e.g.
> > to use memory_region_init_io() instead of
> > cpu_register_physical_memory()).
> >
> > Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> > +static void nextkbd_class_init(ObjectClass *oc, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > +
> > +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > +    dc->realize = nextkbd_realize;
> > +    dc->reset = nextkbd_reset;
> > +}  
> 
> This one definitely needs migration state...

m68k machines are currently unmigratable - see vmstate_m68k_cpu in
target/m68k/cpu.c. So I assume it's currently enough if I add a
".unmigratable = 1" here, too?

 Thomas

