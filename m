Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1AAC35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 03:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB552071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 03:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELSTn8nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB552071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Lug-0003EC-AA
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 22:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j5Lu1-0002So-Hw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 22:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j5Lu0-0004IB-56
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 22:56:29 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:33585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j5Ltz-0004Gr-B9; Fri, 21 Feb 2020 22:56:28 -0500
Received: by mail-lf1-x143.google.com with SMTP id n25so2978305lfl.0;
 Fri, 21 Feb 2020 19:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=woi3ySoOv+ecVjiWFyYVse2ocLaVQusf6u61ghetHjk=;
 b=ELSTn8nfG/aP3692/2BXMX9wqhcgumN43JxMaAkwCa1Fy0dLq7J6M16ZbxoPoZtXWe
 zdZyDmJSTx+cg7ZHxy22/qOz3Ju5y/O/QKGLTIjUykx/+syUd1zcLkdQiDlGjg+3Zrlw
 XI5w06CQm8lxqOPvuH9zApeZ/N8JUVuqWjD8eyMFf5XcWwhxaWeof/8sroNbxbrwZHBh
 GaX+AJKvzDWr1J16sFsVQAZB6g2eVzqswNatm3eZIhmgpoKXWdvRdbHSW+Uj2/sudQMe
 zOSz9zEcEVHxE+nl7Y2iYT8kLGtRxWS1UBucifGkPl2EBV6tTZmmqPs8+hQ+QDHT6BmP
 l+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=woi3ySoOv+ecVjiWFyYVse2ocLaVQusf6u61ghetHjk=;
 b=YBDU9lrcXpsuI9UQfkv4avqRWR26pK6gBU6alrDt+OroCkwnwuvVbq0qvTP8qzD/Zx
 ewAQeSfFRRgXX2XV14AvOsiPizbn93YBBLPR0ZWbPzY8eWCpxRsK08pyFbvd03UHmXuG
 qdQX2nZZ1HAEoCcCTlhD/829WTWHksuXLmHq9M+5oT2JMBB91GAUFfsTl9bsu89V/10D
 tFW/wuUWeaT76dV/qfw4B5wJcKRsBV3RO3qDXCqnNJKuliFV9trVpbSM3t5vdEfuxZow
 LE5Y7iJFWqHMwOssZQo/SeTchPDUFZLrpMKorgoOADdTpOXwmrWmbsrzsANSWqDF9DFp
 RqpA==
X-Gm-Message-State: APjAAAWtt0eWxOkR+A/aCK9isYSIoo6Fcdw3/p6AY7C4PJx+UvvkBPA+
 gfgI6hDpgGwkjxsFF0TGmNuys+UmBzopKk2vCkI=
X-Google-Smtp-Source: APXvYqxeM44GttoGQF3eaDfLd9JU5I6BO3+C/3AVsAhwlU+sT8EDAljt5SHURF8HNAaMNsdBYK4R1NIHC3+kskSMV6Y=
X-Received: by 2002:a19:5057:: with SMTP id z23mr21917399lfj.132.1582343785797; 
 Fri, 21 Feb 2020 19:56:25 -0800 (PST)
MIME-Version: 1.0
References: <1582209758-2996-1-git-send-email-bmeng.cn@gmail.com>
 <1582209758-2996-2-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKOHyix_J-T=sFdwX=jTnxG8TO0r6i6edFixVdMZjZy7yQ@mail.gmail.com>
 <CAEUhbmUJ9gvX0paRF8o5PY_DWvT=16sVmrrnota+PqqEJHV2dg@mail.gmail.com>
In-Reply-To: <CAEUhbmUJ9gvX0paRF8o5PY_DWvT=16sVmrrnota+PqqEJHV2dg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Feb 2020 19:55:59 -0800
Message-ID: <CAKmqyKOHprQ2_1DzKiSR7iCnZMy7hUBWZ9H2fsRo-wQ6hkiJRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: sifive_u: Update BIOS_FILENAME for 32-bit
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 6:53 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sat, Feb 22, 2020 at 3:51 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Thu, Feb 20, 2020 at 6:43 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Update BIOS_FILENAME to consider 32-bit bios image file name.
> > >
> > > Tested booting Linux v5.5 32-bit image (built from rv32_defconfig
> > > plus CONFIG_SOC_SIFIVE) with the default 32-bit bios image.
> >
> > Do we really want to support a 32-bit sifive_u machine?
> >
>
> QEMU is an emulator, why not? With 32-bit sifive_u machine, we can
> have 32-bit test coverage for SiFive specific drivers that cannot be
> done with the 'virt' machine.

That is a good point.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> Regards,
> Bin

