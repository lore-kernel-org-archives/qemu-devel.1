Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E85C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F141D20656
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGTg7LB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F141D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOyvh-00018y-A6
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:22:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hOytU-0007fr-Gc
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hOytT-0003wd-GD
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:20:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hOytT-0003wE-9Y
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:20:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id y2so6040971wmi.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 23:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=NGSIMk3cHw0irzIfdgZUgyHPOWGt5wXxbwpL+7hWrps=;
	b=FGTg7LB2Uqcr1i7QfrHeLRgE8xXjStpowHb0GOck1lUVluDI/xApdGIMjzoAN5MjNa
	j9rOYEI17vmEDxXal4/Salvha7sGjwlLbMrN8DErj/GJUxVbXyPCoSfRo7SwAiWGFCDP
	HsbLL/U8JNgEHVNt3tCke9JA4JvGM/TMhQg/VvtlXI3lEsS6aj3f/ZIHXeHtQdwoT6k7
	a/6rEyuajnusWVK2kI4aP2MNC6NMF2TU7oOB0PH2f0zLNCJI5S7TKA5ZbNnvEVXIFTLP
	3Lq72TQPR1/Of4Oyz4CoMsHxSryJt1RiH2Fg8VKpSilpYU4UdQRw9qW5YwfMqlLreuXq
	KJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=NGSIMk3cHw0irzIfdgZUgyHPOWGt5wXxbwpL+7hWrps=;
	b=gycW920WYKbw8KZ2d2u0UTmQr+vNipCvEVAkCYM0x5X1i4ptYhPLijSk1naVwHitF4
	vOpBQlyvKBusbSKZqoLkBtRd1PIuZ835yikRZEL1se7VzrbuGYYxF+49DlkwpHxOXX33
	dd6Kc2tQ3F/46DeWLz8C5PEf7vQSEU9tPxe17iOPRBEPRPxmj5+XT9A0uET3KPtKtWue
	+5Y7jjEawddKRFK+ikfKbgWJfrfLY9Pi9/RGny98Al562ZEDWsPXBoptmQRxUFjyeMLh
	SfM7WfMY4U5UIvA50uYpcv/JPkeCIIfttsask2NdjU6oj2IUfLZ4pDQpPpofZj6+QpeU
	Y/vw==
X-Gm-Message-State: APjAAAWyS37gbpNExlx26XndPHVaYhEB5rXt+9D/BXln7Ue3mLui56zk
	ICYWMbVGTbNW9AsJxlCTrzc=
X-Google-Smtp-Source: APXvYqzBEQrVg6JM+0Hee60N7TKkdgtf2nW20kfABYZWv5LBRwbyh9cXMhQVt0rUU8zkm3WiUxhNHA==
X-Received: by 2002:a1c:2e89:: with SMTP id u131mr5824810wmu.82.1557469230022; 
	Thu, 09 May 2019 23:20:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0d:c0b:ba00:6fce:9bd8:fb12:6a42])
	by smtp.gmail.com with ESMTPSA id
	g10sm4620158wrw.80.2019.05.09.23.20.28
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 23:20:29 -0700 (PDT)
To: Hou Qiming <hqm03ster@gmail.com>
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrndpONH_fVHbktHbBXvXPKESeRfis06TjrNRRfBpJzXLA@mail.gmail.com>
	<b6064b77-5ca4-03e1-80ef-027313096cb2@gmail.com>
	<CABSdmrkW6G23ZGDA7iLucM45vL0HHGsr2F76H0Mf8S0xkhPnsQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <3e619b5c-8fb3-2655-2d92-37598db098d8@gmail.com>
Date: Fri, 10 May 2019 09:20:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABSdmrkW6G23ZGDA7iLucM45vL0HHGsr2F76H0Mf8S0xkhPnsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 3/3] ramfb enhancement
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/10/19 5:20 AM, Hou Qiming wrote:
> > Please format the commit subject with a prefix and do not use the same
> > subject for all the pacthes
> > in the series, for this patch it can be something like:
>
> I'll resend the patches with improved title lines after other issues 
> are cleared. Thanks for the advice.
>
> > Will this result in a silent failure? So we need to add something to 
> the
> > log?
>
> Based on my experience with OVMF, the "silent failure" only happens 
> when the firmware is malicious. In the current workflow, the only 
> failure modes are:
> - The firmware does not support ramfb, in which case the patch is 
> never reached
> - The firmware fails to allocate a big framebuffer, in which case it 
> writes log to the serial and hangs / reboots, likely before reaching 
> the patch
>
> If you insist, I can add a log. I need to ask though, what is the 
> standard way to change something in [PATCH 1/3]? I've never done it 
> before and there doesn't seem to be an easy git command for that.

No need for now, I think. Thanks for the explanations.

>
> > It is actually a cool feature, changing the resolution following a
> > display window
> > resize, but sadly is not stable enough. Let's hope it will be fixed 
> someday.
>
> I agree. It's kind of hard to validate everything properly...
>
> Then again, ramfb is not exactly efficient (requiring a full screen 
> glTexSubImage2D every frame). After the boot screen, I feel it's 
> better to leave such fancy features to GVT / virtio-gl / ...
>
>     > Write an initial resolution to the configuration space on guest
>     reset,
>     > which a later BIOS / OVMF patch can take advantage of.
>     >
>
>     I like the idea of moving the ramfb configuration to the PCI
>     configuration space,
>     do you think is possible to move all the ramfb configuration there
>     so we
>     will
>     not need the fw-config file?
>     ()
>
>
> I need to clarify that when I say "configuration space", I mean the 
> fw-config file. What I did is to initialize that fw-config content to 
> the resolution specified on the command line instead of all-zeros.
>
> ramfb is not a PCI device and I don't think it's possible to move its 
> configuration there. Even when it's attached to vfio-pci, it's 
> technically a separate thing from the guest's POV.
>

Got it, thanks. Is a pity ramfb is not a PCI device :), it was worth the 
question anyway.
Thanks for info,
Marcel


>     Is this chunk related to this patch? If not, you may want to split it.
>
>
> Yes. That last chunk lets the user specify an initial resolution 
> without an EDID when ramfb is created as `-device vfio-pci,ramfb=on`. 
> It can be useful when debugging GPU passthrough in EFI shell or the 
> Windows Recovery thing (which shows up in ramfb).
> Qiming
>


