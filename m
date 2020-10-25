Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF79C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 15:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4BC208A9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 15:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jto3EeFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4BC208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWi19-00005b-Ui
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 11:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWhzC-0007Y2-34; Sun, 25 Oct 2020 11:31:10 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:36839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWhz8-00042C-Vp; Sun, 25 Oct 2020 11:31:09 -0400
Received: by mail-yb1-xb41.google.com with SMTP id f140so5567815ybg.3;
 Sun, 25 Oct 2020 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8k9W7heNWf310LbU1MGkloWciXvS7ZYGJRs1ES0KcV0=;
 b=Jto3EeFw+PHl1DnoR+jSTqDM/nBIs61S0gTpeux6rBr3SB1bF+bEV8pSGPiQxVARqk
 TnsynWYFdZ/YCF8sbNp094fngLfFsmW9IpHL7pzGbSeu0HxqdXgLPIDIWNjw9kXGsRRa
 nEQDYbyliONqXnxqePDk4TQdLsxkdjaFYevRgsg9864rWe6nT/ge0khAr0NR/dYzF1yF
 DfYRSmxdc/r9LA2MzHFlX/mCgb8Jsla5TR4oVzkU61QWND0WUMXSRc+V1SM04PZ/1EiO
 6u4M6w3iS8mrwC49Jk7Pa58NZ+PlPgcHSu1bFkIXtEQFMuVsYfzv+CMTGiBOKzuwU+/k
 mkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8k9W7heNWf310LbU1MGkloWciXvS7ZYGJRs1ES0KcV0=;
 b=OAvuUceFGg0yHY9O8g5AsxCqefSwbgbfontdYO4LcCVumafMZ3YTNuUMyNqxqcJyHf
 hsYxmc0ep+v8Us2jeO2Ce7cIcoiwn7Vm/uVyRdy0R01ENA7srToHsnEIMBU2EPrxoonC
 mqQjAafwNlKZvTmGdtDFWU/fPhE4TL2pV96kXkzt+HuG15vCXzL/gFag5jgtXN7OhdSs
 Ryl2AL5D3GhdkvwQh98G18SAPOmdhDnclcPCOttecoT6GJY8YLhHCP955GjjvayVrvAh
 MwRwH7zOvMiyS0YbYo34TMWC9yIGCbF9C4XD5q7zngY+B4GT0sCB322FdtYkbSlIcn64
 E86g==
X-Gm-Message-State: AOAM533g6QPJ/HL/xoCWhJ/ro08LRiRw1r4hjh9k56T7otVAlaRmZov3
 gKKqmgDhb0g73nPsyW8FtH6mvkH4aNYWZH8Cc/U=
X-Google-Smtp-Source: ABdhPJxMNgQZU6IbzltupheVNCXlOpudLJFIsfjTkR0o5JKZUSHB2RxY4EQqMEOEFWxnETOqwiTKivucu8xFT8okMA0=
X-Received: by 2002:a25:4113:: with SMTP id o19mr15190094yba.314.1603639865575; 
 Sun, 25 Oct 2020 08:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201024215200.494209-1-nieklinnenbank@gmail.com>
 <fd949ad0-f7fd-561e-33d8-57133a9afd31@amsat.org>
 <3bb92403-f955-d887-a301-1ff38259b49f@amsat.org>
In-Reply-To: <3bb92403-f955-d887-a301-1ff38259b49f@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 25 Oct 2020 23:30:54 +0800
Message-ID: <CAEUhbmV9Q-+4zF62xwq4dHdBCiwOU43dnJKvdYEx10Wg=H8POw@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: expand Orange Pi PC SD images for
 NetBSD, Armbian above nearest power of two
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 25, 2020 at 8:13 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 10/25/20 2:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Niek,
> >
> > On 10/24/20 11:52 PM, Niek Linnenbank wrote:
> >> The acceptance tests for the Orange Pi PC need to expand the SD card
> >> images
> >> to a size which is a power of two. As Qemu uses the size of the SD
> >> image file
> >> as well for the size of the emulated SD card, this can sometimes give
> >> problems
> >> for guests that assume a certain minimum size of the SD card.
> >>
> >> This commit resolves the following acceptance test error for the
> >> NetBSD 9.0 test
> >> of the Orange Pi PC by increasing the size of the expanded SD card
> >> image to two times
> >> the nearest power of two:
> >>
> >>     (5/5)
> >> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orang=
epi_uboot_netbsd9:
> >> |console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
> >>    console: DRAM: 1024 MiB
> >>    console: Failed to set core voltage! Can't set CPU frequency
> >>    /console: Trying to boot from MMC1
> >>    console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
> >> Allwinner Technology
> >>    ...
> >>    console: Starting kernel ...
> >>    console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
> >>    ...
> >>    console: [   1.3300167] sdmmc0: SD card status: 4-bit, C0
> >>    console: [   1.3300167] ld0 at sdmmc0:
> >> <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
> >
> > The test has this comment:
> >
> >     # This test download a 304MB compressed image and expand it to 2GB
> >
> > Once uncompressed the image is ~1.2GB before rounding to 2GB.
> >
> >>    console: [   1.3430678] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec,
> >> 512 bytes/sect x 2097152 sectors
> >
> > Why the card appears as 1GB??     ^^^^^^^
> >
> > Can you try reverting commit 6d2d4069c47?
> > ("sd: Correct the maximum size of a Standard Capacity SD Memory Card")
>
> Now I remember, I hit the similar problem 2 years ago :S
>
> See the description of the C_SIZE field in CSD register:
>
>    "To indicate 2 GByte card, BLOCK_LEN shall be 1024 bytes."

Ah, yes! 2 GiB is special in the spec. Thanks Philippe!

>
> This model uses a fixed BLOCK_LEN =3D 512 bytes.
>

Niek, could you please try the following patch?
http://patchwork.ozlabs.org/project/qemu-devel/patch/20201025152357.11865-1=
-bmeng.cn@gmail.com/

Regards,
Bin

