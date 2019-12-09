Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42287C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089BB20692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTTDgD2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089BB20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieMXF-0000fq-2a
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <daniel.thompson@linaro.org>) id 1ieMWR-0000Fc-4p
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <daniel.thompson@linaro.org>) id 1ieMWP-0002O3-KF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:08:34 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <daniel.thompson@linaro.org>)
 id 1ieMWP-0002LX-7m
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:08:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so17090333wru.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 09:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ioF9gOYZwQRQay1Cw3ZQd95BcX21otjmgrUHOTzhRPc=;
 b=mTTDgD2+Iw1cBbT3UDV1VWZMAnWhJm0s734NqNT55Za2NLBygIFdPeBj7n0URp2OpP
 AjpZ+eMJCJFTbPR9d6xxUjExAlK34HbmYOih6iAYV06l9OlPvdI5hm2PP0ggKvZ2XOox
 HtzH7p4LgLUu6b9azxElwjaYnkASTWoW+7nK7P8zUCqTVgzbV6GMKCekKZq8u1eA01Cl
 CMNtLHfO/Y7EP/2iP+QPUbPONHZjBCp5vNUlTAFvUpoUcyyw1bluxGZ76AeMFtrpgTcI
 I9kR7WkMK0xsMLKomSfQYYGBMvWT9m+wdFdLsvBsgJ/a2ZLz+To2n8WbGSVGPuVGRtEd
 FFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ioF9gOYZwQRQay1Cw3ZQd95BcX21otjmgrUHOTzhRPc=;
 b=ZAy1ICp0mBEDUxgGnNLmc09Hd0tMXnu2fRKEbL4KsshTFstHaGDx2GRa67scSHBDGX
 8wKAgP2TDXTp3iKCFW91r3AIyDtlabDQSpH2jHg1XvcJFrgVjmU6vsRgI04pXz8xw4Vg
 fkIZ/WST/41artYsNmwByhYTZDrkXE0Wdy8WA0zHAD/nfomO3IvHAUcietE82U/ryGaN
 gB8bcesiQWqo6iSogQHqZ6hliAi20kclNQNtVcIu1wuWKzsVtdDr9atM4YfUerYMTAil
 1swFSzUNuzrzV9jE2X9YFZ0qWZsTkOJfrSdGXkWbAWMqpKvBEFXJ3befEc54o60RF4Im
 FMmA==
X-Gm-Message-State: APjAAAUq9jOEOlZnHquR9lz6CstUOxvsu/SwK/V+cmr5B0kjIk8lAjAq
 /bIkf4V7Sl6IanZDmOBWFWQ6rg==
X-Google-Smtp-Source: APXvYqyBab0ty4M+7hsxV+0ALRG1YL6lMBRIkB4UmNU5BJRlAwYcYvmcpES7LAMjhsG11JO4iafvGQ==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr3465705wro.194.1575911309788; 
 Mon, 09 Dec 2019 09:08:29 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id b185sm428329wme.36.2019.12.09.09.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 09:08:29 -0800 (PST)
Date: Mon, 9 Dec 2019 17:08:27 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/arm/virt: Second uart for normal-world
Message-ID: <20191209170827.yojyts6qdvpxbkp4@holly.lan>
References: <20191209152456.977399-1-daniel.thompson@linaro.org>
 <CAFEAcA-sgFKev2MiOjRAzuE0trNYQoNe6LOFLeghGm73N1h=SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-sgFKev2MiOjRAzuE0trNYQoNe6LOFLeghGm73N1h=SA@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

On Mon, Dec 09, 2019 at 03:36:17PM +0000, Peter Maydell wrote:
> On Mon, 9 Dec 2019 at 15:25, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> >
> > The virt machine can have two UARTs but the second UART is only
> > registered when secure-mode support is enabled. Change the machine so
> > this UART is always registered bringing the behaviour of the virt
> > machine closer to x86 land, where VMs can be expected to support two
> > UARTs. This approach is also similar to how a TZPC would typically
> > make a UART inaccessible to normal world on physical hardware.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >
> > Notes:
> >     It is difficult to add a UART without some kind of odd difference of
> >     behaviour somewhere. As far as I could tell the choices are:
> >
> >     1. Move the secure UART from UART1 to UART2. This is a
> >        not-backward-compatible difference of behaviour (will likely break
> >        the command lines for existing users of the secure UART).
> >
> >     2. We tack the new UART on at the end, meaning UART1 will re-enumerates
> >        as UART2 when secure mode is enabled/disabled. This is rather
> >        surprising for users.
> >
> >     3. UART1 is registered and inaccessible when secure mode is not enabled
> >        (e.g. user must provide a dummy -serial argument to skip the missing
> >        UART)
> >
> >     4. Normal world can only use the second UART if there is no secure mode
> >        support.
> >
> >     5. Don't support an extra UART ;-)
> >
> >     Of these I concluded that #4 was least worst! Ultimately it is should be
> >     unsurprising for users because it is how most physical hardware works
> >     (e.g. a trustzone controller is used to make an existing UART
> >     inaccessible to normal world).
> 
> This change looks simple but it will break booting of UEFI
> in the guest. Unfortunately UEFI enumerates UARTs in the guest
> in the opposite order to the Linux kernel, so whichever way
> round you put the extra UART something will get it wrong and
> stop producing output where the user expects.
> 
> I think the conclusion I came to was that the only way to
> avoid breaking existing command lines would be to only
> create the second UART if the user explicitly asked for
> it somehow. (Possibly just looking at "if there really is
> a 2nd serial on the command line" with "if (serial_hd(1)"
> would suffice, or perhaps not.)

I don't object to making it command line dependant (it is certainly
lower risk) but, out of interest, has using /aliases to force the
kernel to enumerate the serial nodes in the existing order been ruled
out for any reason.

With something like the patch below we can give /dev/ttyAMA0
with a stable device number regardless of the order of the UARTs
within the DT:

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a5cca04dba7f..7078cfc0c106 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -225,8 +225,12 @@ static void create_fdt(VirtMachineState *vms)
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
 
-    /* /chosen must exist for load_dtb to fill in necessary properties later */
+    /*
+     * /chosen and /aliases must exist for load_dtb to fill in
+     * necessary properties later
+     */
     qemu_fdt_add_subnode(fdt, "/chosen");
+    qemu_fdt_add_subnode(fdt, "/aliases");
 
     /* Clock node, for the benefit of the UART. The kernel device tree
      * binding documentation claims the PL011 node clock properties are
@@ -754,6 +758,9 @@ static void create_uart(const VirtMachineState *vms,
qemu_irq *pic, int uart,
 
     if (uart == VIRT_UART) {
         qemu_fdt_setprop_string(vms->fdt, "/chosen", "stdout-path", nodename);
+	qemu_fdt_setprop_string(vms->fdt, "/aliases", "serial0", nodename);
+    } else if (!vms->secure) {
+	qemu_fdt_setprop_string(vms->fdt, "/aliases", "serial1", nodename);
     } else {
         /* Mark as not usable by the normal world */
         qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");


> You also need to do something to add the 2nd UART to the ACPI tables.
> 
> (Very out of date and broken patchset from last time I looked at this:
> https://lists.gnu.org/archive/html/qemu-arm/2017-12/msg00063.html
> )

Thanks for the heads up. I'll have to do a bit of reading/testing
before I get back to you on that!


Daniel.

