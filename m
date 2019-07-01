Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB59C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39A721479
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV+g2J0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39A721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi5hT-0006Dx-9v
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 19:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56580)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hi3Xn-0008Ek-PR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hi3Xm-0006a2-7R
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:08:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hi3Xm-0006Xr-1B
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:08:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id e8so14922690otl.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Cil1aGn+gB1c5c8M8UNEJSqGgQANhOfQidzwYwd+giQ=;
 b=PV+g2J0VBrzgx0UXYpOuG90TcdZ8Ikg0jSQkWDWz39NIppi7KhXicPQThkwmYRHq06
 nw6XUOGpNAmuwlJl3d9QZ7zajI6ykaxGZ5MJ4jYWYkikyRVHggv+yKR+AgXX424VFD2f
 XJXF/VpPWfLwiq17F7lMY9X5dYEt/118n/mjg5Ij/mQ58DQkRRg+fOcnvcm/LrJ57p2K
 SwKqe5EixFFk6ROJO/7ab2w1uodixituBfYesySh5Y0iB+l7EwjunWN8xPTy2RWHx38R
 /dr+CnvBJhrue48+a5Kj69ED8ar5Bz7LZ+hVPWjPxM6bUGB3wS7JiA4RBen8IQ0gQyIA
 uy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Cil1aGn+gB1c5c8M8UNEJSqGgQANhOfQidzwYwd+giQ=;
 b=ldN0RyS6TMW4zzqvP7bVGXrAPHWC3uXxwAD1uP1P/m5LQvzu9BXf7XQ70g9k0PpCLa
 4hkh+7i0Xbre9xKO6oGmBW/eBzpweN2Ojzqkof+vZvSuq6lXNAN/YAvHle5WclT1zCZ8
 wMuf7p9sNVS43AqTTEtIVha4VVpImGKB3ccHXZ5TRB/9kAuxVUwZ5xv7ek1oXa9GVjbx
 cdq/OTjGOgFbjPMxGOmRb2vC5+6Bps59XFDWFjfU/oFZp/7WIxu4mVQuCRFxEH+ysYTl
 iLcMp2KvCwKgh9eQCoJgHpOySVWyXohajY5iELbMLXIOdEFlOHUxfU0il/w3TY4CJwhT
 JH4Q==
X-Gm-Message-State: APjAAAW99kHO98K2huhzis9W+DrYCZD8KUYHXpBHO+iYz/ziue1BIo5b
 1D2jnjmfP7Hmsrahu1n6oGq2jFm5d4bUmp3jWcbg3Q==
X-Google-Smtp-Source: APXvYqyNI4RqG7CDN34DcsdJogatu10bAruoJExhUVWqQcyF/wYrROk6+8jtKmTPOABbGDS7z3zZT+jCzpO1TCstZdA=
X-Received: by 2002:a05:6830:c6:: with SMTP id x6mr430636oto.64.1562001415411; 
 Mon, 01 Jul 2019 10:16:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 10:16:54 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 10:16:54 -0700 (PDT)
In-Reply-To: <20190624222844.26584-1-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jul 2019 19:16:54 +0200
Message-ID: <CAL1e-=iLAKe+FunE2p9L3Ds8fPS2a8nf3hc=ga7CX6E2bjw0Uw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 00/10] hw/pci-host: Clean the GT64120 north
 bridge
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 25, 2019 12:31 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> w=
rote:
>
> Hi,
>
> This series clean the gt64120 device.
> It is no more target-dependent, and tracing is improved.
>

If nobody objects, I am going to select majority of the patches for mips
queue scheduled tomorrow. Those that remain will be those that Philippe
still didn't make his mind.

Thanks thousand times, Philippe!

Aleksandar

> Regards,
>
> Phil.
>
> Based-on: 20190624220056.25861-1-f4bug@amsat.org
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05304.html
>
> Philippe Mathieu-Daud=C3=A9 (10):
>   hw/mips/gt64xxx_pci: Fix multiline comment syntax
>   hw/mips/gt64xxx_pci: Fix 'tabs' coding style issues
>   hw/mips/gt64xxx_pci: Fix 'braces' coding style issues
>   hw/mips/gt64xxx_pci: Fix 'spaces' coding style issues
>   hw/mips/gt64xxx_pci: Use qemu_log_mask() instead of debug printf()
>   hw/mips/gt64xxx_pci: Convert debug printf()s to trace events
>   hw/mips/gt64xxx_pci: Align the pci0-mem size
>   hw/mips/gt64xxx_pci: Add a 'cpu_big_endian' qdev property
>   hw/mips/gt64xxx_pci: Move it to hw/pci-host/
>   hw/pci-host/gt64120: Clean the decoded address space
>
>  Makefile.objs                                 |   1 +
>  include/hw/mips/mips.h                        |   2 +-
>  hw/mips/mips_malta.c                          |   8 +-
>  hw/{mips/gt64xxx_pci.c =3D> pci-host/gt64120.c} | 542 ++++++++++--------
>  MAINTAINERS                                   |   2 +-
>  hw/mips/Makefile.objs                         |   2 +-
>  hw/mips/trace-events                          |   0
>  hw/pci-host/Makefile.objs                     |   2 +-
>  hw/pci-host/trace-events                      |   5 +
>  9 files changed, 307 insertions(+), 257 deletions(-)
>  rename hw/{mips/gt64xxx_pci.c =3D> pci-host/gt64120.c} (68%)
>  create mode 100644 hw/mips/trace-events
>
> --
> 2.19.1
>
>
