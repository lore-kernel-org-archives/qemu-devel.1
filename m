Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB3DC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8349214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIt1H+dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8349214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3jKy-00060y-Te
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 11:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3jKG-00050I-Qv
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3jKF-0000w8-FP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:32:52 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3jKF-0000vv-8r
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:32:51 -0500
Received: by mail-oi1-x241.google.com with SMTP id j132so17215466oih.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 08:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3EkU9fRDfAmOAJzb4m2OoiRdooXjQJ9MMCQ8IuXlDFE=;
 b=tIt1H+dQUIlXyEeq8id3VdXHYXbN9UJT2Bv+4h0mvpS+ASfUJblhtjLr0WeGl7q9jM
 8EYVtiwaySR1DRCiC/XTW0au8EYA3RKMBsmaSanqJGh4LzsZmoYCiwzLrOuIBq8J5BVy
 k3JcErPIbX5bXgeBseh42KFdPIUqxBBf+aI+7f6331Fd1Hvd2Ge7TSlmCWgUkmPl0oZC
 m0OHQOOZqCbH+fp2JfH3HDBfDauAUgG2ZlygeSBtwUYNqYPFt5rWxc9juPdNxk7vf8K9
 Hx1w01JFdJAfpFN2BLOZWsh9ajHdVZpnyDtQzs6dyhj41dMz97Rfgj/3a/9MyZbPfKWG
 esqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3EkU9fRDfAmOAJzb4m2OoiRdooXjQJ9MMCQ8IuXlDFE=;
 b=n5jsUuNx7Xe7tgx7zzwUU6+CzjZKdSvn+Pa/p5up+nyRXOxpvBXckB7htBW4Muh0oz
 YOklxqQ/yK8smbCcwAQR6ZQ5N2+RXuxrqd8y1SVoaTfIge9JhDFtJ1slc3NSAPhbpekk
 u6S/r4XjrCJVMQ2csq214pGbcbPhPGEObf6Psli/wPnbjrRsb0iRj9beQSnGqe4XL2X6
 adQMtt2cqd0DpbyRS2LCykiqRAikzBHKwve3dsTQZhHiPCfe41imwoxw12fxI8Yg5/Me
 DEjR7goF/lfL4PpTjxHQ8uLKN7M5Lcyg4vG+PXsO2sruj36202MjFPKcZGo8m1Da+9mP
 AWTA==
X-Gm-Message-State: APjAAAUipZgk+3QSlIbRb3N7z0kYvtAn7GO0lskpkXrrODJQAmiN3Q1s
 Ubedaye7LXX+Rwk6VCp5nzpbLfpFhq47GFMoTCwTYA==
X-Google-Smtp-Source: APXvYqzSUe0eSqNhcwYkA419VKxiok7CErYugk1NmnKpRC2lEpK+QZz+CFKKb3A9DoZsMzegvsty7Ain27vmiDEpYDw=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr10769068oiy.170.1581957170077; 
 Mon, 17 Feb 2020 08:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
 <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
 <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
 <e530629d-c029-1d7c-b5b7-cdbbeb397a4d@redhat.com>
In-Reply-To: <e530629d-c029-1d7c-b5b7-cdbbeb397a4d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 16:32:39 +0000
Message-ID: <CAFEAcA-KzWv=_kZUPNE6yyUSA36XY+q91ihJ_xh4euJ9RsyaLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 16:15, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Per this comment in qdev.c, unrealize() is the expected default:
>
>      /* by default all devices were considered as hotpluggable,
>       * so with intent to check it in generic qdev_unplug() /
>       * device_set_realized() functions make every device
>       * hotpluggable. Devices that shouldn't be hotpluggable,
>       * should override it in their class_init()
>       */
>      dc->hotpluggable =3D true;

This comment sounds like it's documenting what was the
previous default ("were considered") and making a minimal
change to avoid breaking existing code where a device
does want to be hotpluggable but isn't explicitly saying so.
I forget how exactly it works (the mechanism has changed
several times) but in practice a sysbus device is generally
not hotpluggable, and that's what most devices are.

> I get for qemu-system-aarch64:
>
>
> - qdev objects missing instance_finalize():
>
>      bcm2835-sdhost-bus
>      PCIE
>      pxa2xx-mmci-bus
>      qtest-accel
>      sdhci-bus
>      tcg-accel

Note that you don't need an instance_finalize() if it
would have nothing to do, which may be the case here.

> - non-hotpluggable devices implementing unrealize():
>
>      VGA

Not sure which device this is, I couldn't find a TYPE_
define with this name. Is it an abstract or common
device type used by the hotpluggable pci VGA card?

> - hotpluggable devices missing unrealize()
>
>      a15mpcore_priv
>      a9mpcore_priv

Most of these are not really hotpluggable. What is
confusing your test code is that sysbus devices get
the default 'hotpluggable =3D true' setting, but other
conditions usually prevent hotplugging. (The reason
hotpluggable is true is the default is because of
handling of 'dynamic sysbus' devices which live on
the 'platform bus'.) In particular, I think that
anything with !dc->user_creatable can't be hotplugged
unless board code specifically tries it, which would
be a bug for most of these devices.

Also, if there isn't anything for a device's unrealize
method to do, it doesn't need to provide one.

thanks
-- PMM

