Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34673C35670
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 04:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4672067D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 04:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhWrUyOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4672067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5iRK-00008F-4I
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 23:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j5iQk-00088K-Vd
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 22:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j5iQk-00024i-0N
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 22:59:46 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:35416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j5iQj-00024P-Su; Sat, 22 Feb 2020 22:59:45 -0500
Received: by mail-yw1-xc41.google.com with SMTP id i190so3634317ywc.2;
 Sat, 22 Feb 2020 19:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=mLUD0Tfh1gY4f7W+19o7k3ooXhot98r8f2MwTNGaSjI=;
 b=UhWrUyOQT0667mMAjDcFFeNnKFHGNNad1bXV5IgYNRMl2qgkKwMsYCltp6Pyyu3i33
 5/rwJk8dHvX5vWCQKjAn6LsTdH6I68MyfYBPkszYcE0Vp/Q8/G2UdQNcRaksj9HQHmXH
 X/188B4iJS9trXm4jfT7oX4TySaiTXaui91TmtVQqjwofWWAd6sLSa/ZXUtXpVLH4hb/
 2Vodvpmdk/fz26Ox5UDYtacGRluSKzNJwxPfk33aRTTniQmciSLPg8KoyvEuxfCRLbWA
 MN2vH2S11bxcoIRshRGvcR+NPS9//GHdaGaSaut2gSFsGi6ZSXcD9FfNWZFTIFvH3Rga
 vZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=mLUD0Tfh1gY4f7W+19o7k3ooXhot98r8f2MwTNGaSjI=;
 b=m/QFxIGK8nJbLL6N40FVEmQi+S9e4hxkPukOSlpoXdbH0PfsaqLaxg3eMmUtUKp+BM
 dm29IQoPlh0VceD2ATdzB8/4G7vpdT9fRCX5Z7TN+bUs0higG/eDK0/CGNWo+rhSjMCK
 yC6RqyVID8B2Y8BqPuaQB5LAV5ARNkNHjXGX6M69MEiAQFZwouJwKD85zrFz44E/SF4Z
 QmPzxDpHOHku/DM81YyYql2m49XizdFyzzL4OjweUdvdR1Va/beJqtRQHn+mdKOfBLpL
 nyDUleVKKnj9zJmWiJZZs0Y5j8g0ot7aWnN3LlSljw1MAZwx7E8VY1JQAVCARWuJIK5M
 1kAA==
X-Gm-Message-State: APjAAAWYE+prkHTCpKDZtyWg1ajDYvOy8BOD8bf+lsy49+Jf8HEEYDIn
 wZSsfkNmXMaTqMuVk3yKlTKqM74M8O3D7Mtdisk=
X-Google-Smtp-Source: APXvYqxejFPsQw1szrYkluQSgPPx0gdyjbEJMpe00VxKkfVhCpTcdCANXN2jgPAX2CW3JP5/nVxP/T74lAK5AfQhzVU=
X-Received: by 2002:a81:8a06:: with SMTP id a6mr34218699ywg.240.1582430384989; 
 Sat, 22 Feb 2020 19:59:44 -0800 (PST)
MIME-Version: 1.0
References: <1581861317-30977-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1581861317-30977-1-git-send-email-bmeng.cn@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 23 Feb 2020 11:59:34 +0800
Message-ID: <CAEUhbmVJJNhgDvenWnWU134NneGDmtc_7i5TP2vKtKh=QzYrjQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: sifive_u: Add a "serial" property for board
 serial number
To: Alistair Francis <Alistair.Francis@wdc.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Sagar Karandikar <sagark@eecs.berkeley.edu>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Feb 16, 2020 at 9:55 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> At present the board serial number is hard-coded to 1, and passed
> to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> the serial number to generate a unique MAC address for the on-chip
> ethernet controller. When multiple QEMU 'sifive_u' instances are
> created and connected to the same subnet, they all have the same
> MAC address hence it creates a unusable network.
>
> A new "serial" property is introduced to specify the board serial
> number. When not given, the default serial number 1 is used.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> ---
>
> Changes in v2:
> - Move setting OTP serial number property from riscv_sifive_u_soc_init()
>   to riscv_sifive_u_soc_realize(), to fix the 'check-qtest-riscv' error.
>   I am not really sure why doing so could fix the 'make check' error.
>   The v1 patch worked fine and nothing seems wrong.
>
>  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
>  include/hw/riscv/sifive_u.h |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
>

Ping?

Regards,
Bin

