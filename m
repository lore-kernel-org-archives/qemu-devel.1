Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A9C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DABC21527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUw6JxC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DABC21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW16e-0005u4-AH
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kW15R-0004qx-7X; Fri, 23 Oct 2020 13:42:45 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:41629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kW15L-0002WG-Qk; Fri, 23 Oct 2020 13:42:43 -0400
Received: by mail-yb1-xb44.google.com with SMTP id c129so1853925yba.8;
 Fri, 23 Oct 2020 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=c6n2eHqG4+PsWDOtCAeejiImndE+pLOyantk6AYGU1A=;
 b=gUw6JxC9LVqslYqxBwuZj9MEPZt6ee7F0LTFUAjeb9yMOrHBr+mt1BNNbmU8MYHMEL
 NlRr0XBl4Jw2gz4UK7ZpgdIqcX823hP6Oa70XuMY89uvMtQdvLB3oE4v3g3k2UMmRfO0
 WcHAlE8hFuW7iLsSItMg94vSkYe3s7rNnYh2pJ7AJ77wBRgZ+rdL+rj/+vbRXKQN3POa
 NmcmTOgOCxthkkYgc/VndhQyTM0VgGW/6ci85XiPGvrHNocjHj8AlCsbDmmSWmAEjP1A
 +IJqwzXnzBKHqjQogbY6XQewob2GSSeueT42M8Y7oKNDOGRz6LHw+b+yWyA56/riV8yo
 hBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c6n2eHqG4+PsWDOtCAeejiImndE+pLOyantk6AYGU1A=;
 b=XcFBUA9e3n0EO8OuWPaJl2n5ckhPOTcnfVfxPBT/qf93SVh+7tQjp1trGEl3P1Mc//
 2ftixX5kJ/CojssoAUZnK1SoJeoRFaNuk+hjQtYWP3wYwPPUcNflMuqer9g1yKklPj4H
 qQjf2xRyeXZ0DXgSL9N1OrWuk1IbzGwf8FNZIzrxffhCQ7M8O7NN/pypJtVFZfN7WQys
 JyCmPZVLL/6GLorv0ma3CFl5Lpd7gNHCydwbdmJe0b7RrdXqKvvFaLfMC8mFr3HGCH/6
 LTW+5xzJU591Ic9V/kIDbP1rXCUn0BP6T5OovsPVrkuN5xg3RXrABEiqqBWewWI0kABz
 uj/A==
X-Gm-Message-State: AOAM531Irdeg6LF/AoWUCNo+FUMFuNX39a9yB8VFKblIVKyD7ag6jNPh
 M55zp0jkwKbA8pKIG32aqC4TbuAkXG8NHvOduVY=
X-Google-Smtp-Source: ABdhPJzAUiLF2nkGoIO2zu/F8ABRGDwQi1j2PFbkFiwvdstjQS2rGAWhQOg9fbrPyUkd7QGonjZbxGmb0Db/laU2GnM=
X-Received: by 2002:a25:386:: with SMTP id 128mr4828364ybd.122.1603474957926; 
 Fri, 23 Oct 2020 10:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201023131808.3198005-1-f4bug@amsat.org>
In-Reply-To: <20201023131808.3198005-1-f4bug@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 24 Oct 2020 01:42:26 +0800
Message-ID: <CAEUhbmWJQHJgdvgjXRy3jzJLQC9w3cCdft40ium0TbjEq=9pQw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
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

On Fri, Oct 23, 2020 at 9:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Series meant to help Bin Meng to debug the SD card issue
> reported by Michael Roth.

Thank you for the patches.

>
> Philippe Mathieu-Daud=C3=A9 (4):
>   Revert "hw/sd: Fix incorrect populated function switch status data
>     structure"
>   tests/acceptance: Allow running Orange Pi test using cached artifacts
>   tests/acceptance: Extract do_test_arm_orangepi_armbian_uboot() method
>   tests/acceptance: Test U-Boot/Linux from Armbian 20.08 on Orange Pi PC
>
>  hw/sd/sd.c                             |  3 +-
>  tests/acceptance/boot_linux_console.py | 68 +++++++++++++++++++-------
>  2 files changed, 50 insertions(+), 21 deletions(-)

With this series, I used:

$ ARMBIAN_ARTIFACTS_CACHED=3D1 AVOCADO_ALLOW_LARGE_STORAGE=3D1 make check-a=
cceptance

It looks that the failure still exists? Log below:

13-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_arm_orangep=
i_bionic_20_08/debug.log:

01:11:27 DEBUG| =3D> boot
01:11:27 DEBUG| unable to select a mode
01:11:27 DEBUG| Device 0: unknown device
01:11:27 DEBUG| BOOTP broadcast 1
01:11:27 DEBUG| DHCP client bound to address 10.0.2.15 (1 ms)
01:11:27 DEBUG| *** Warning: no boot file name; using '0A00020F.img'
01:11:27 DEBUG| Using ethernet@1c30000 device
01:11:27 DEBUG| TFTP from server 10.0.2.2; our IP address is 10.0.2.15
01:11:27 DEBUG| Filename '0A00020F.img'.
01:11:27 DEBUG| Load address: 0x42000000
01:11:27 DEBUG| Loading: *^H
01:11:27 DEBUG| TFTP error: 'Access violation' (2)
01:11:27 DEBUG| Not retrying...

Regards,
Bin

