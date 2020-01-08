Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FE1C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 19:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 425B720678
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 19:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPxrics0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425B720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipH9u-0005RB-BM
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 14:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <afscoelho@gmail.com>) id 1ipH9C-00046r-Vn
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <afscoelho@gmail.com>) id 1ipH9B-0008T1-Uo
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:37:42 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <afscoelho@gmail.com>) id 1ipH9B-0008RA-LW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:37:41 -0500
Received: by mail-lj1-x241.google.com with SMTP id u1so4557728ljk.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 11:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u2ZVSgnJJXBZMVWUZ0NTllaT3Ak9EVQp91mhj4bIFMQ=;
 b=kPxrics0L6LWztvpxk/SW/a9csNxBwwaffB7K3o4J8NU0jf0mPgW+VCcQ4gd9/Y2mT
 gB1wz9x6HwKCzQ9S7lZMN8OOroKb4Ae2HZPR2IrMMZ1eG0d0znLYEnPbK4u/MNnxJK+X
 DxKXqcyfJas3CXJa3rtP1+oxTgzTABk377pXRFoBlo68etQfUl8VnIndLn84Pkd35jGt
 A2hwOBzZYzBQCNpsY2NIpHcF8+4nsp1SJ9z/DMVgCMOVanbRLGiHrA76UvizBDtwfiCq
 /GfFYEjzuZjvx6D//l4kI9XDoyRYvq3ZY3CAhz0FzNUfnidIkyAlkRzQiWihM5cMiSG6
 AoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u2ZVSgnJJXBZMVWUZ0NTllaT3Ak9EVQp91mhj4bIFMQ=;
 b=Oq8c1S9YWEIC9CvsLP0hKQMPOTyXv17nPGS2hauTnwHIcS1JB0BEPqS89Ww/8Xy7ef
 Vvlzl6mpbqWncgT4Zwe5pHWhAV6oA6TSLT+OF/TUZYIpBiVya9oBPwjC+1E+hZWZXyse
 iLpy2KkMBh6uOkczwE470xMKfsIm82Y0ZHUQO2DMjdQq6DsQWQub7R3CrZtp/LtsuuIx
 +cwhsJx+ZawbJUf67QiHlMh1eR1LrkWvTnKlheLkDhwrRiMwmBYJaeV3XcGPST3NDfQ/
 qxuc17leAilvDrUtYMoVJR8DkJvsPfloXd7gE2LRkN2yuKmsAkY0+GrA7B3ZKtikvuCk
 KMZQ==
X-Gm-Message-State: APjAAAUOt6As0v3zkUoH+kkv0dK/v1ueCQZ9ILaL0aNlPM6KLMm903NJ
 YeGR7TBYnFS+Y0hpg650AFLKIg1zo7VCeDY+62A=
X-Google-Smtp-Source: APXvYqzrzYpYNgk0C6QoSTJNBPhnrHSz6mQW5mUHmXGo87HQ0a9Zz3SH9K9FOv8u5yLdIxGgDtaCYifTUq2Pr43lyz0=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr3835337ljg.69.1578512258944; 
 Wed, 08 Jan 2020 11:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20200108161618.221116-1-afscoelho@gmail.com>
 <CAFEAcA9v-x31y0CraXkfAN3PVQs+Oyo3F+mTA593Duf0t1Wb0A@mail.gmail.com>
In-Reply-To: <CAFEAcA9v-x31y0CraXkfAN3PVQs+Oyo3F+mTA593Duf0t1Wb0A@mail.gmail.com>
From: =?UTF-8?B?QW5kcsOpIFNpbHZh?= <afscoelho@gmail.com>
Date: Wed, 8 Jan 2020 16:37:27 -0300
Message-ID: <CAGTcC7yDmpo843uQEQ9=nyqW-wc=XE+dLvqiLmDf6eHuAxeivg@mail.gmail.com>
Subject: Re: [PATCH] virtio: Prevent double swap due to target pre 1.0 VirtIO
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, it looks like. virtio_pci_config_read is called via a pointer
from memory_region_read_accessor and memory_region_write_accessor
calls virtio_pci_config_write.
I tested the patch in a linux/ppc64 host with a FreeBSD/ppc64 guest
and VirtIO 0.9 (legacy) driver and from what I saw the config area is
accessed only in these functions.

Thanks!
andr=C3=A9

On Wed, Jan 8, 2020 at 2:51 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On Wed, 8 Jan 2020 at 16:20, Andre Silva <afscoelho@gmail.com> wrote:
> >
> > Remove the bswap function calls after reading and before writing
> > memory bytes in virtio_pci_config_read and virtio_pci_config_write
> > because they are reverting back an already swapped bytes
>
> Is "because we wrote it via virtio_pci_config_write" really
> the only way that the data read by virtio_pci_config_read
> is ever set or updated ?
>
> thanks
> -- PMM

