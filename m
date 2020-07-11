Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B757EC433E5
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803A92075F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBTXTDSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803A92075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juI0U-0003sU-Ns
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 12:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1juHza-0002ye-Tm; Sat, 11 Jul 2020 12:04:47 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1juHzZ-0008Fe-5P; Sat, 11 Jul 2020 12:04:46 -0400
Received: by mail-io1-xd42.google.com with SMTP id y2so9152468ioy.3;
 Sat, 11 Jul 2020 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qAv4wtGtW3f7U1j9J1L89c5M7AU1zwEe2GupDNrZhZI=;
 b=EBTXTDSXZzUr1ApZPuAdUmOXximMrzeNKlennUKl/GhO2WAjJh9PMcsHz6BtirTixT
 cMhJdyl6gqTM16NfO7qBm8rUfrssBeKYyPVk5dNKE0Ej781+PGcStYpbbINzGF3zeGpP
 7nNaHXp3zQJxAUbAcDMwGuEYMYt+i1uVhHXeYRwYSqMq1umrUaTKu09eLleG+bS1osgP
 SUHlbOPCE3DDxveuYyeI3MTazQbY0Te8MQXhaM2UWB1K10xlKabxxGuEm7touDfzIMr9
 QhL9f2+krFjk/JJoAxwG/IGEFHHboXCaVNp4swdwIPfwGTkLzBqDavLc11F1kv7fF1DA
 36qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qAv4wtGtW3f7U1j9J1L89c5M7AU1zwEe2GupDNrZhZI=;
 b=J/PCeEz/75/MZeQb4gR9lsgWe43b/TFonqjey24zarTc3AoN4CXsgCOg2wRR5u1Rsh
 G6goEtJm2xGTMq9R80rt/u0i1wq5a6pVdTljya1UdTKBGjlJPRgxkN7V12pYBW4laSI4
 wcl1C2TgzOOycUj7WxzUuZxjuR11g3gKGhP1zKXA9n3+mmKgOk9Tg6xeqzfm+ikjks4o
 PWFbAcpFCE2duzrOC/jblJaIyzZyoI6Pmu6visjTMRZhVDaw5o+TZPN3C/2LWyKHnQj6
 mB8VvZETzxDt0yVvTA4BRZ2fn9UGUFYL5XxpNmk8Skq15RIWpSmat/Z3VtcC8YaOG38P
 kN7Q==
X-Gm-Message-State: AOAM533R7dGOYtGnDQ1+euwpdxeC3HeQxy2oKhJdSvO1JPLgSDA+3Kiv
 OxNooGnpq4jPl1U5MUWvHWAZ3QRcfEA9lveaNo1iVXOU
X-Google-Smtp-Source: ABdhPJxtL0Vu9eTSKaddo/uuFy3LYZUzm8MZDKi/lkNsmhHebqDy1Mz8QlczPjrqNGQrvKYxYGIBNVaELQLTQC0f8KM=
X-Received: by 2002:a5d:9ed0:: with SMTP id a16mr52426634ioe.176.1594483482898; 
 Sat, 11 Jul 2020 09:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKPvn7dALUHhK=na1svr==oZ2rvyFOnw8FvRJZP23uHN7Q@mail.gmail.com>
 <mhng-842d31db-ac34-4bab-a523-808f1f542101@palmerdabbelt-glaptop1>
 <CAEUhbmUPxCmo-4SPm8JwG7emD0YfLeAMSgd7mWaCH2VDZJTtsA@mail.gmail.com>
In-Reply-To: <CAEUhbmUPxCmo-4SPm8JwG7emD0YfLeAMSgd7mWaCH2VDZJTtsA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 11 Jul 2020 08:54:48 -0700
Message-ID: <CAKmqyKN=HfpTs=d8RzXcaVYZQ-pH_kvO9VV5h4CKAtLSKaVqyQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/riscv: sifive_u: Provide a reliable way for
 bootloader to detect whether it is running in QEMU
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Palmer Dabbelt <palmerdabbelt@google.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 9, 2020 at 5:50 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Palmer,
>
> On Fri, Jul 10, 2020 at 8:45 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> >
> > On Thu, 09 Jul 2020 15:09:18 PDT (-0700), alistair23@gmail.com wrote:
> > > On Thu, Jul 9, 2020 at 3:07 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >>
> > >> From: Bin Meng <bin.meng@windriver.com>
> > >>
> > >> The reset vector codes are subject to change, e.g.: with recent
> > >> fw_dynamic type image support, it breaks oreboot again.
> > >
> > > This is a recurring problem, I have another patch for Oreboot to fix
> > > the latest breakage.
> > >
> > >>
> > >> Add a subregion in the MROM, with the size of machine RAM stored,
> > >> so that we can provide a reliable way for bootloader to detect
> > >> whether it is running in QEMU.
> > >
> > > I don't really like this though. I would prefer that we don't
> > > encourage guest software to behave differently on QEMU. I don't think
> > > other upstream boards do this.
> >
> > I agree.  If you want an explicitly virtual board, use the virt board.  Users
> > of sifive_u are presumably trying to do their best to test against what the
> > hardware does without actually using the hardware.  Otherwise there should be
> > no reason to use the sifive_u board, as it's just sticking a layer of
> > complexity in the middle of everything.
>
> Understood. Then let's drop this patch.
>
> >
> > > Besides Oreboot setting up the clocks are there any other users of this?
> >
> > IIRC we have a scheme for handling the clock setup in QEMU where we accept
> > pretty much any control write and then just return reads that say the PLLs have
> > locked.  I'd be in favor of improving the scheme to improve compatibility with
> > the actual hardware, but adding some way for programs to skip the clocks
> > because they know they're in QEMU seems like the wrong way to go.
> >
>
> Yep, that's my question to Oreboot too.
>
> U-Boot SPL can boot with QEMU and no problem was seen with clock
> settings in PRCI model in QEMU.

I don't think it's an unsolvable problem. There is just little work on
Oreboot to run on QEMU. I can dig into it a bit and see if I can find
a better fix on the Oreboot side.

Alistair

>
> Regards,
> Bin

