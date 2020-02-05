Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7C1C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAC12467B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKdoHU4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAC12467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izP1p-0006cW-BJ
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 13:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1izP1C-0006Be-Ik
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1izP1B-0007dj-DY
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:03:18 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1izP1B-0007YY-8h; Wed, 05 Feb 2020 13:03:17 -0500
Received: by mail-ot1-x344.google.com with SMTP id 66so2775657otd.9;
 Wed, 05 Feb 2020 10:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q5F9z5GTzKruioiIN8akW+j+HF5FBcfXn9UBrSai4iU=;
 b=EKdoHU4ZAaGliFUZstJnXWu5BlKHb3nEH/3fG7B32r4crFLJPU5RBzZO33syw85Vtr
 hOCuPO7x4KJfg3pdw9oQPfQi3Ht5NAUMbyK944OXvEko3SSqhTdMnXrt5CYA6ec8IyJB
 OgeenQQVq7qJHeiibtgvlE/GY/blSSOh50Pd9m/EfD3V5prJOIxf+q/D0qITqbkHNSvp
 DPtqQxemg5lpIwnmVnoNI99AC3vLT78CZDwaUFbHpAHsRXUXPXa/MspxEHh9VRQ53QNL
 nq2V8EDHEmSG1KLkUbcl1hSUzfxZ8AT8AHfSq+vI9gvMiDx+IT/APxD45PmyeV254/Nx
 wxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q5F9z5GTzKruioiIN8akW+j+HF5FBcfXn9UBrSai4iU=;
 b=AM65TTqLf7JIHqBaBfN0O1aWpEg3V3wpRaLOB88vSFjpULBbG5l4HsK5FK1r3+fZXB
 uqYO73lcm0x0RD9o19ldpzQF6eY+RK/OSwZQRzod9FkMnBoqWPZ87pUenrhAiXUHf0Wu
 zvt+eb2BeZJbCWNvSptfH33lCefTktJQBl3ZnsXCzNR162V/AlOr988MxDsY9Hx9pgOH
 alihhcdc7aRyl6ziD++hirX9hFVU8XGB3TpKOaV7rZhbH+J9GdLtqzlSB+bsh2UH0+ul
 leZ14kfJXNPfYZQu29wvKmfUYFzAfElyILC/mDmLt1P7XDwj/TeMMhS7g9tZ5bLDT49R
 onfg==
X-Gm-Message-State: APjAAAXp3N4axzds9BwBCquHtcbnp2EhJdaI0qe9V5epCvHEt1lhfGzK
 8V0tASUd/1quncMzI4sfs59ilaSdE5NE6/WQ5ck=
X-Google-Smtp-Source: APXvYqxKSWVmgPj2nEHSCJMrqXT8BBYRPVbytyztnHj6o5FAGhrPb9Epsxl1bnPOF6P34yQUBtSoIwkHrEBX9vu5d0E=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr25733884otk.64.1580925796470; 
 Wed, 05 Feb 2020 10:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
 <7a775153-f18d-e766-1d8f-33607f5fa05b@amsat.org>
 <2396dfd4-6c85-d17a-b358-bd058c757f14@redhat.com>
 <CAAdtpL7vPCQ8k91nvBWc_NLrmhu6OPVprUSL8uzi_v6HMiSrnw@mail.gmail.com>
 <CAL1e-=gd-ymYd3_cods8BAtwbQeJFodmnmsNo-gLx381rXHKxQ@mail.gmail.com>
 <20200205175115.GT2221087@redhat.com>
In-Reply-To: <20200205175115.GT2221087@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 5 Feb 2020 19:03:05 +0100
Message-ID: <CAL1e-=jHpNmTdWSiHZ_StC0MXjLLsyq0cfSE=45=6SwoFnfiaA@mail.gmail.com>
Subject: Re: [PATCH for-5.0 3/4] Remove the core bluetooth code
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> The deprecation policy is primarily intended for notifying of changes
> to QEMU's stable interfaces ( CLI, HMP, QMP) which affect behaviour
> and usage of QEMU at runtime & are liable to break apps managing
> QEMU.
>
> Changes to build time options have no strong reason to be subjected to
> the deprecation process.

This sounds reasonable to me.

But: Should our deprecation policy be clearer on what is subject to
our deprecation procedure, and what is not?

Regards,
Aleksandar

> If we remove an option at build time the effect
> is noticed immediately and the solution is straightforward (stop passing
> the option). We have added / removed configure options at will with little
> negative feedback historically. We'll have far biggest changes coming to
> the build system in future too, with the introduction of meson.
>
> I don't think we want to constrain & complicate our work in modernizing
> the build system by declaring that any changes to it must go through
> deprecation.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
>

