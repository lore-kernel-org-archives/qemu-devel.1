Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE9C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF2820640
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6xy4anv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF2820640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7MIe-0006iz-E1
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7MGt-0005bz-LK
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7MGs-0002Xk-MP
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:12:07 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7MGs-0002We-IV
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:12:06 -0400
Received: by mail-ot1-x341.google.com with SMTP id s28so12986106otd.4
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RTch4eV1jmX5zX4OJNUCOx4ZHCwcI/CURdtAAQ1gGgc=;
 b=Y6xy4anvu44Nz+DXzP1XjZnSaEoArfxdtdlpGEDqOHPPoFfMpIKBViqzzME4MDtfTE
 9f+htdLqF8LKzG2gSWcgx2v1rKOY1/bXdafgtS6sJSgfqYhqoVyOMI2x4hwh96Wd35e+
 tdFbFu7VRJbnOomRUGotlgJ8ic+ZwgSPCGRywk6iCE6B2wqRInJQ2idUA9QY0tIoP5YW
 zMwLt/xEOAqk+Pk0LQTxF88YpjvUCfx0Z0Pb909q0rRGpcg0TSLovC+Gdg4NW1AyM1ir
 yE5aEQMkEBMaXni3jsNeNgRLjPG0I9V6wb5Cer73CWYVqKWiePyMdDl4Nqzzcr3z5x3N
 4/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RTch4eV1jmX5zX4OJNUCOx4ZHCwcI/CURdtAAQ1gGgc=;
 b=d7DoaVyC4H+s/BVmQwgdni0VBNuU19+HDXfQjvjnJsxRXyEmXVWxNb91Vsatww9dcB
 w7jsmR2ft66wa4Utkg9FHU8GMOteHeJ/0GfXzcQ4kPqjwaZMDNQz46ixjsrJTUSjbZNV
 nyxURxM3iHuVQfIAvE9c4rkwRq6lzXfONpPqCahB2/x2mUccvMu1zrZ05gpReBGt+Qin
 jTw6POmDI8+aTgyWCHR6d5ysZeaHOOb7TCiJhDmNUd/sB3EZL59TlX0xdk96e59Nsdv0
 GYMCMZr0QDTELAivm7AIJ1gpNaWACFc9VHYv6SHxqjLIfYFTzqIfnZrxZweHWLcsT4pW
 ut4A==
X-Gm-Message-State: APjAAAXYewlRKqHPe7L0ur+fxVmH148ru7dLbUN3eUS7sFu9D8gkMk7s
 2ISE1gkbTSCyBTdC53/qziUPYIW4dZNJ91Fc3e3n5g==
X-Google-Smtp-Source: APXvYqyv/DyqJF9yvSKzLvBuxVYTkQEvOTweF8309LzLunRQY+pF/neGTsD9j5EJoLtY5KCq6Nk2S05GtXih+1PRqGA=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr20719827oti.91.1568045524898; 
 Mon, 09 Sep 2019 09:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190909155813.27760-1-laurent@vivier.eu>
 <20190909155813.27760-9-laurent@vivier.eu>
In-Reply-To: <20190909155813.27760-9-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2019 17:11:53 +0100
Message-ID: <CAFEAcA9NiHrGekrEte7__aGKSz-JBObdbWdMxmxduYozngDUNQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v9 8/9] hw/m68k: add a dummy SWIM floppy
 controller
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Sep 2019 at 17:05, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

> +static void sysbus_swim_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->realize =3D sysbus_swim_realize;
> +}

Missing reset and VMState for migration. These should be
baseline requirements for adding new device models to the
tree, because in an ideal world every device would support
both -- we should be gradually fixing the existing devices
which are missing these, and not letting new devices in,
so the situation gets gradually better, not worse.

thanks
-- PMM

