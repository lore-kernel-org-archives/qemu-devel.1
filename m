Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD0BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 15:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A3E20757
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 15:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucPUpEIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A3E20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWL5w-00064z-IJ
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 11:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWL4t-00056D-1z; Sat, 24 Oct 2020 11:03:32 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:44036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWL4q-0008FL-RJ; Sat, 24 Oct 2020 11:03:30 -0400
Received: by mail-yb1-xb43.google.com with SMTP id h6so3791636ybi.11;
 Sat, 24 Oct 2020 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VeeO++P8tjq/qDxJ4ktoRfla0e3Og32jcsqA6XUjLnM=;
 b=ucPUpEIxuZUdwbn5T/L9qCZFMiyS0wUw1pMQY7Wbc4sZBnPSDTGZYKqpF/brQRLuCt
 r/gxYj//uZLfFPDc9Y3CR0Pq32a+IfKBW6WVXOJ5o8WnVNvbVWqTqgNNji2lmEzcuShV
 aDnW/+ZjiGwYGXPFCYBaapeBhzhtOSLZPDh9yUw6l1t6EIR4wSQ0o6Tr523LaZG/ipTa
 A4mtVyLcKvYJEi6/VfPXS1oCRDCUZXNnBpS4uLzhz/6j4p1FPI2etKKPZq9YDPxY7xrk
 ANVH9qO1IwXyVr6PVuM5Qi4F9wAq/764b1EXVcIn/8zJLubfYQ0R8eN2dAMBNdRsq2xO
 66GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VeeO++P8tjq/qDxJ4ktoRfla0e3Og32jcsqA6XUjLnM=;
 b=EqRAo5at8o+g6NbY0voG/qB65Q01MvlRwlUVSu2wvtW1GzOFYzWrtHhwNbxYBGzJvC
 nvaCQNq4dOWkXDqYXf7wSgtUAnWWnBbkmvznXL6vo9Bz2z1iZ0tOtq6d+Atn7WEfwmIr
 QscKcCSCbKhlC/Rj3/Q5OqKLQynGgsJ2HWmorioGPoyRKEFrKZVsp0q1RoTrtZtINb3q
 zYmCb8vkRnm5OK3C0VAL4faqgPYi6ytGj68eeW548olyYlgpBVWoj+UpGoslNxs8Qj/Y
 iJRrnVIPMk7Vs38QNgUvnVjj1DjEnnOSwQFxYg0JDiWU5ccip6ZFjqFpr7AqDSs6FEnV
 Q/VA==
X-Gm-Message-State: AOAM530C3ZdQR+I/3wvVxHMSZEN2Tl5c7b+NYJx9OIs7m3l91t7qOQdU
 1o61+yL0LSlYQFQGw6n++tRGR+QL2DIu6070uG0=
X-Google-Smtp-Source: ABdhPJzyznrZqVKBsXovnC3y4bN9UJVhBxaDnlTGQhwb6+gXab9yaSYeu+bZuXXFvcLBh7H/OIfVVCgJ2XLhzJH4quk=
X-Received: by 2002:a25:386:: with SMTP id 128mr10044899ybd.122.1603551806766; 
 Sat, 24 Oct 2020 08:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <CAEUhbmWJQHJgdvgjXRy3jzJLQC9w3cCdft40ium0TbjEq=9pQw@mail.gmail.com>
 <e2863605-d90e-5e97-0a9b-35d7c2b15e34@amsat.org>
 <CAEUhbmXX9RH12_EuUd-HmipOFMWH1_2gvCjL_RRqXiOqvzzU=Q@mail.gmail.com>
 <fca4287e-37fb-dda0-784f-a053f0ad0cbc@amsat.org>
In-Reply-To: <fca4287e-37fb-dda0-784f-a053f0ad0cbc@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 24 Oct 2020 23:03:07 +0800
Message-ID: <CAEUhbmXh=-cVj_r7dBkbPkXpPed-6a+QR4R3Ky353aULiSDfSw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
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
 Bin Meng <bin.meng@windriver.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Sat, Oct 24, 2020 at 3:34 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 10/24/20 3:06 AM, Bin Meng wrote:
> > Hi Philippe,
> >
> > On Sat, Oct 24, 2020 at 1:56 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >>
> >> On 10/23/20 7:42 PM, Bin Meng wrote:
> >>> Hi Philippe,
> >>>
> >>> On Fri, Oct 23, 2020 at 9:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@am=
sat.org> wrote:
> >>>>
> >>>> Series meant to help Bin Meng to debug the SD card issue
> >>>> reported by Michael Roth.
> >>>
> >>> Thank you for the patches.
> >>>
> >>>>
> >>>> Philippe Mathieu-Daud=C3=A9 (4):
> >>>>     Revert "hw/sd: Fix incorrect populated function switch status da=
ta
> >>>>       structure"
> >>>>     tests/acceptance: Allow running Orange Pi test using cached arti=
facts
> >>>>     tests/acceptance: Extract do_test_arm_orangepi_armbian_uboot() m=
ethod
> >>>>     tests/acceptance: Test U-Boot/Linux from Armbian 20.08 on Orange=
 Pi PC
> >>>>
> >>>>    hw/sd/sd.c                             |  3 +-
> >>>>    tests/acceptance/boot_linux_console.py | 68 +++++++++++++++++++--=
-----
> >>>>    2 files changed, 50 insertions(+), 21 deletions(-)
> >>>
> >>> With this series, I used:
> >>>
> >>> $ ARMBIAN_ARTIFACTS_CACHED=3D1 AVOCADO_ALLOW_LARGE_STORAGE=3D1 make c=
heck-acceptance
> >>>
> >>> It looks that the failure still exists? Log below:
> >>>
> >>> 13-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_arm_o=
rangepi_bionic_20_08/debug.log:
> >>>
> >>> 01:11:27 DEBUG| =3D> boot
> >>> 01:11:27 DEBUG| unable to select a mode
> >>> 01:11:27 DEBUG| Device 0: unknown device
> >>> 01:11:27 DEBUG| BOOTP broadcast 1
> >>> 01:11:27 DEBUG| DHCP client bound to address 10.0.2.15 (1 ms)
> >>> 01:11:27 DEBUG| *** Warning: no boot file name; using '0A00020F.img'
> >>> 01:11:27 DEBUG| Using ethernet@1c30000 device
> >>> 01:11:27 DEBUG| TFTP from server 10.0.2.2; our IP address is 10.0.2.1=
5
> >>> 01:11:27 DEBUG| Filename '0A00020F.img'.
> >>> 01:11:27 DEBUG| Load address: 0x42000000
> >>> 01:11:27 DEBUG| Loading: *^H
> >>> 01:11:27 DEBUG| TFTP error: 'Access violation' (2)
> >>> 01:11:27 DEBUG| Not retrying...
> >>
> >> Have you rebuilt qemu-system-arm with the reverted patch included?
> >
> > Oops, I took it for granted that the `make check-acceptance` will
> > automatically rebuild the QEMU binary, which is not the case. Should
> > we enforce the rebuild before testing in Makefiles?
>
> Well I'm not sure, because I don't want to have to rebuild all
> targets before rerunning a single test, but this is a Meson issue
> that could be fixed soon. I'll let Cleber/Paolo decide.
>
> Does that mean I can add your "Tested-by: Bin Meng
> <bin.meng@windriver.com>" to the test patches btw?

Sure.

Regards,
Bin

