Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E48C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 01:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF21720791
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 01:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+Hnnfk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF21720791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW826-0006gQ-IG
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 21:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kW80l-00067J-9V; Fri, 23 Oct 2020 21:06:23 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:45518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kW80h-0004rN-FM; Fri, 23 Oct 2020 21:06:22 -0400
Received: by mail-yb1-xb42.google.com with SMTP id s89so2669832ybi.12;
 Fri, 23 Oct 2020 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6iONO9iXi9R844aMpHyATWzUGqnrLaKueG1qSFM63H0=;
 b=D+Hnnfk+AMPtVdAgQJOv/bQ99jYjV1uIHyo5hWFnVENAYtVGGr5bR54ondz2Qi8nI6
 xfbOcfRfPnJR/uJNxS/1NrmpaK64aqvLJajYQirKmDxqjFUCW6hv7HxtLTFoOzIB7uY8
 MUu/uCYwziHvON9Qz1eAGacDIBlpsZ1uV6uvHzw/pDRFvbJOMWJwbGzxIqfSMbVV+USd
 PYjvecx6RB1Ka7wAJ8ySfq62VlbZcyFivVt3BSiX2NESW1RwatXLpU40NIf+Q6m6PNmy
 L7Lfo9fhm1Q6YM2+zH3B4ef5f/ib4b+kxIJ2ux2P0VVg17w1muk0iNy5woSMU+sLS1x2
 m56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6iONO9iXi9R844aMpHyATWzUGqnrLaKueG1qSFM63H0=;
 b=FLo4M8kUTJihyLwbIeTJcCkrcfJKTca79R44C+1Wx4wgJTk8+Cb2dUi9TtuVP/grX2
 ilkZWbSQfxKCacVWNeJH7aT4nNWtT747pfEsbPtnBMDtr/gk6H1XXRGkRZb+kao8xpe3
 hRv1scH5dTuRUY9z32Meg02ST+XbNfDAbzlOHXTuXVDhA5Os4Kk3F+3l5xYfF2FmqSfH
 r66rojg6r+P7mjIISK/gZx8NuEL7yUzJRk2op5COaiYad3NKF/pgXRw84GbFDHSexZQt
 ZQy9zJQpYTR5DLIFuThL8ZLaDHSXYnzIyw/6WrFXX6ZOsh+JcQ0nel9TiNgc7e/Wvbuj
 tJIQ==
X-Gm-Message-State: AOAM532GWMaPWm/7RW7eVvsT5V4mT/I4kC5JgLFDIP9nIDx1S4j1qAn8
 yjuk2O/uLERRRBSL0rXTE0OWstXu44wo6yqtaPw=
X-Google-Smtp-Source: ABdhPJxc8LZJrbqiYg7otDIWF+oF4TQDJx70J/bMz88oL7v4YGG4pxDo6rClHId9sm/iAbnXb8cy7YliBwxDoCmHz9k=
X-Received: by 2002:a25:328a:: with SMTP id y132mr6978879yby.306.1603501577953; 
 Fri, 23 Oct 2020 18:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <CAEUhbmWJQHJgdvgjXRy3jzJLQC9w3cCdft40ium0TbjEq=9pQw@mail.gmail.com>
 <e2863605-d90e-5e97-0a9b-35d7c2b15e34@amsat.org>
In-Reply-To: <e2863605-d90e-5e97-0a9b-35d7c2b15e34@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 24 Oct 2020 09:06:06 +0800
Message-ID: <CAEUhbmXX9RH12_EuUd-HmipOFMWH1_2gvCjL_RRqXiOqvzzU=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
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
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Sat, Oct 24, 2020 at 1:56 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 10/23/20 7:42 PM, Bin Meng wrote:
> > Hi Philippe,
> >
> > On Fri, Oct 23, 2020 at 9:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >>
> >> Series meant to help Bin Meng to debug the SD card issue
> >> reported by Michael Roth.
> >
> > Thank you for the patches.
> >
> >>
> >> Philippe Mathieu-Daud=C3=A9 (4):
> >>    Revert "hw/sd: Fix incorrect populated function switch status data
> >>      structure"
> >>    tests/acceptance: Allow running Orange Pi test using cached artifac=
ts
> >>    tests/acceptance: Extract do_test_arm_orangepi_armbian_uboot() meth=
od
> >>    tests/acceptance: Test U-Boot/Linux from Armbian 20.08 on Orange Pi=
 PC
> >>
> >>   hw/sd/sd.c                             |  3 +-
> >>   tests/acceptance/boot_linux_console.py | 68 +++++++++++++++++++-----=
--
> >>   2 files changed, 50 insertions(+), 21 deletions(-)
> >
> > With this series, I used:
> >
> > $ ARMBIAN_ARTIFACTS_CACHED=3D1 AVOCADO_ALLOW_LARGE_STORAGE=3D1 make che=
ck-acceptance
> >
> > It looks that the failure still exists? Log below:
> >
> > 13-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_arm_ora=
ngepi_bionic_20_08/debug.log:
> >
> > 01:11:27 DEBUG| =3D> boot
> > 01:11:27 DEBUG| unable to select a mode
> > 01:11:27 DEBUG| Device 0: unknown device
> > 01:11:27 DEBUG| BOOTP broadcast 1
> > 01:11:27 DEBUG| DHCP client bound to address 10.0.2.15 (1 ms)
> > 01:11:27 DEBUG| *** Warning: no boot file name; using '0A00020F.img'
> > 01:11:27 DEBUG| Using ethernet@1c30000 device
> > 01:11:27 DEBUG| TFTP from server 10.0.2.2; our IP address is 10.0.2.15
> > 01:11:27 DEBUG| Filename '0A00020F.img'.
> > 01:11:27 DEBUG| Load address: 0x42000000
> > 01:11:27 DEBUG| Loading: *^H
> > 01:11:27 DEBUG| TFTP error: 'Access violation' (2)
> > 01:11:27 DEBUG| Not retrying...
>
> Have you rebuilt qemu-system-arm with the reverted patch included?

Oops, I took it for granted that the `make check-acceptance` will
automatically rebuild the QEMU binary, which is not the case. Should
we enforce the rebuild before testing in Makefiles?

Regards,
Bin

