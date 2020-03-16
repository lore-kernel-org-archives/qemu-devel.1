Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB73C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DBE20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MraBOAEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DBE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDusW-0006L6-2X
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDuAm-0001ng-Lk
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDuAl-0007q7-E3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:09:08 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDuAl-0007f3-7o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:09:07 -0400
Received: by mail-ot1-x344.google.com with SMTP id h17so214160otn.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A+Fyqn1mI1CNyLfdLpM4w01y1OBVvMKCqPMC43LB79o=;
 b=MraBOAEzqtcSST9s5HL9ns3Xj2bfPdmncEIA5pN1fzj34jcxkE6FpTls0Wngk9510o
 pM9DBd3wdWtm7/i8z3od3ELy/9dfNlH0gim5M0CkViWgMmGP2OE/naGn/rUvzrqF3ELu
 L2uSRdMD3SkfcPI228PxtAc/iRfNb3+KRuZjWR5pItIrksV0aQqHQB9PiU6/PHBqba1e
 dtMYTO1gQt4Lq9N8+840t77w26l6BmoT/wzOTTIzL4AL//o5SIP+vqYytF32TAehlLAo
 nDGVRy9pFhp3p06+0I7qw58tmEYKF5ZqPVdyrd1PA5ilvuSZYe1H5rxUiCBsl8iZyfE6
 ZAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A+Fyqn1mI1CNyLfdLpM4w01y1OBVvMKCqPMC43LB79o=;
 b=bSF6Qh96zpbHUQ4cp5urP3GifwjOv4ufjIFBLZVY7LlIQzAj3lIOY4eZ7Xmj1Zej6g
 yJ/bb7RQPxe7mBJ3ZTgJ0TE3isU4prCyoJicq3YRzN9FFukvjp6+OgPCJfBzA9mHY5dd
 K2XjdUKaKRYQx+JNDDS2GJ48V1HCuvqiLP+p8Ey8NA7btFmjYqGueGf7J43a1LM9XOi8
 bIlB+cVK2/JceTwIRcrPIiYlH92K50nUS/20EFpDNDBZ1Pz2bAMyR7Sa+li1FE1YRtm1
 JWZeLvyfIG518UmVh2RVyOjNO/G4YlL1/DhJaL8z7u41n0iq0ahR94stZm0KpnbihdIK
 nu1Q==
X-Gm-Message-State: ANhLgQ2TrOgmOqQ6vlE/2f+lJ/0P/fgFxMbJgdyVa7AXdcM7AVLb9HJv
 5KUnuK/Cz+FO2svZW8qIRZUAz0v7pG8fecAlgHZSug==
X-Google-Smtp-Source: ADFU+vutN7vdZZj5AG//fFa1esaU7sfBHHoAsopSTRteRv7qPEwIgxlnwtLM/msNDUwzEbp/Yap5Lm0LDsVF1Mcaquk=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr363080ota.221.1584382145979; 
 Mon, 16 Mar 2020 11:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-3-ehabkost@redhat.com>
 <20200315154559.GW1187748@habkost.net>
 <20200315170229-mutt-send-email-mst@kernel.org>
 <20200316173039.GB1817047@habkost.net>
In-Reply-To: <20200316173039.GB1817047@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 18:08:54 +0000
Message-ID: <CAFEAcA9CYeTjmUSbMtGjDazrh1p=5vLAd3bq7JBtLd0RfnruDw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmap-alloc: Include osdep.h before checking
 CONFIG_LINUX
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 17:51, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Yes, but both MAP_SYNC and MAP_SHARED_VALIDATE aren't available
> if the host is not Linux.
>
> Defining MAP_SYNC to 0 on MIPS would restore the existing
> behavior, so it seems like a reasonable step to fix the build
> failure.  But not even printing a warning when the host doesn't
> have MAP_SYNC (the existing behavior on MIPS and non-Linux) seems
> wrong.

The usual approach is that if you don't have the Linux-specific
feature available you quietly fall back to whatever the sensible
behaviour is for when the feature isn't present. We definitely
don't want to be printing warnings on non-Linux systems that
are effectively just saying "you're not running Linux". Same goes
for "host happens not to be running a bleeding-edge Linux kernel
and this feature isn't available yet".

thanks
-- PMM

