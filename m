Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A29C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED2D207DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRplmVa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED2D207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxZIT-0000ip-Q8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 13:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jxZHw-0000J5-AA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:09:16 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:45632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jxZHu-0001vN-Hc
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:09:16 -0400
Received: by mail-io1-xd44.google.com with SMTP id e64so18366994iof.12
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3Qqu4qo8xRSb4N0qU6t2nyQxHKJMJ5P7z2uREzVuhMc=;
 b=PRplmVa3Llai7oQ2lTyZoqHVnUJCGiC7IgyR9LROO6i0q4B9RJocgTqOp/7ElI453p
 zxXOuM2LVCPG24879hnKcrzHgZ2U2AM3FBqURldxF0DYlVgzRtzb6Y3Mc3jUgJ38hkOK
 7GUYeP1F08gNWoXyqNzuXmwaUeHjMkgbTtiKGOv7suJHgUOPVFu6dBXmO5Rmyhy0oLdx
 NUobh8pLOUMT6yiejzvMD7xwza2M5o5bjUXocl7v2+WU96b5HUEDBcUqKwVQ+L8EwKEz
 sUlP//e7EqylFadOaDBun6BsioAi9bANoz+ZUhF1LYEiekR5R4pS4JF/cZoKOVflHDB+
 +/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3Qqu4qo8xRSb4N0qU6t2nyQxHKJMJ5P7z2uREzVuhMc=;
 b=t4uHQHAJ/OJWqvqaHUbG29apdED4ZLjU1gqeyQvbAjQMy1FBPLuRE/NXCvA/wv3Nr2
 YaRn3RHlQg5K0CInQ0AXd4AxxIL04Fsx3dQCUeHpWNXGxbPsebIsJvHeQGYFEa5pvAAu
 Ktrb0BXc0sHMYBWw2HNOX3WWwedYalz6k/i5FeLKf/Ilz83OFe9hO+aES/4E9+bXfJVY
 LnjvcMT3H4CZlN5LrJD676lX1QaJXd3ukpOGheNqYYEdDIR1MuEPEpfG2cRErtRnK9YM
 /AWFY3Ci0nIB2eoD0UgI7MTyGQ+1LH9PI+i4kTvC14E7A27t+7wotbxU9Kj1ZWt+sFr6
 GoyA==
X-Gm-Message-State: AOAM530/n7g6Fvph9AAQ0KDSHIt6JdW17b0nwRRoRRgcWcZYTOCrppVQ
 1wbh6aO3vG9bXRmybOQKqYVEXNsr2gvbb4Q4rlk=
X-Google-Smtp-Source: ABdhPJxjcd2e3509z99R5avPUU8AoJowWFNayaqcrUCAYBX54Ix9jSoBhxG4kAK0E4ib1cEMm20FkSmXpbt22mHNx8E=
X-Received: by 2002:a6b:640f:: with SMTP id t15mr23589298iog.175.1595264952933; 
 Mon, 20 Jul 2020 10:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <BMXPR01MB2344EC13172300E0384B97B8EE7B0@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <BMXPR01MB2344EC13172300E0384B97B8EE7B0@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Jul 2020 09:59:08 -0700
Message-ID: <CAKmqyKOsS+bTM=R4gEHBaDCGh3Lmo-bKiG=zbnHS30EwP70RoQ@mail.gmail.com>
Subject: Re: Replacing existing kernel with new on qemuriscv64
To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 2:46 AM Pankaj Vinadrao Joshi
<Pankaj.VJ@exaleapsemi.com> wrote:
>
> Hi ,
> I am trying to replace my existing kernel image which is 5.5.6 to 5.5.7 o=
n qemuriscv64 i would like to mention i have built my qemu image with opene=
mbedded-core.
>
> i have tried to build the kernel 5.5.7 natively,i was able to build the k=
ernel successfully and in my /boot folder i am able to see vmlinux-5.5.7  b=
ut now i want to install this image..i have tried to do it by make install =
i didnt got any error with it but when i rebooted my system i am getting
>
> i have followed the following steps to build kernel
> $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel#  make menuconfig arch=
=3Driscv64
> $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make -j4
> $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make modules_install
> $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make install
> sh ./arch/riscv/boot/install.sh 5.5.7 \
> arch/riscv/boot/Image System.map "/boot"
> Installing normal kernel
>
> $reboot
> 13024.451157] printk: systemd-shutdow: 37 output lines suppressed due to =
ratelimiting
> [13024.527282] systemd-shutdown[1]: Syncing filesystems and block devices=
.
> [13024.668538] systemd-shutdown[1]: Sending SIGTERM to remaining processe=
s...
> [13024.719496] systemd-journald[87]: Received SIGTERM from PID 1 (systemd=
-shutdow).
> [13024.769405] systemd-shutdown[1]: Sending SIGKILL to remaining processe=
s...
> [13024.834318] systemd-shutdown[1]: Unmounting file systems.
> [13024.868285] [13413]: Remounting '/' read-only in with options '(null)'=
.
> [13025.228499] EXT4-fs (vda): re-mounted. Opts: (null)
> [13025.358123] systemd-shutdown[1]: All filesystems unmounted.
> [13025.358576] systemd-shutdown[1]: Deactivating swaps.
> [13025.361264] systemd-shutdown[1]: All swaps deactivated.
> [13025.361727] systemd-shutdown[1]: Detaching loop devices.
> [13025.420602] systemd-shutdown[1]: All loop devices detached.
> [13025.421071] systemd-shutdown[1]: Detaching DM devices.
> [13025.595237] reboot: Restarting system
> [13046.599875] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [13046.600329] (detected by 0, t=3D5252 jiffies, g=3D2837145, q=3D17)
> [13046.600763] rcu: All QSes seen, last rcu_sched kthread activity 5252 (=
4298153942-4298148690), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
> [13046.601503] systemd-shutdow R  running task        0     1      0 0x00=
000008
> [13046.602053] Call Trace:
> [13046.602562] [<ffffffe00006d3fc>] walk_stackframe+0x0/0xa4
> [13046.602890] [<ffffffe00006d5e2>] show_stack+0x2a/0x34
> [13046.603156] [<ffffffe000091094>] sched_show_task+0x158/0x174
> [13046.603442] [<ffffffe0000c4dde>] rcu_sched_clock_irq+0x6b2/0x6ec
> [13046.603740] [<ffffffe0000ccadc>] update_process_times+0x1e/0x44
> [13046.604009] [<ffffffe0000d79dc>] tick_sched_handle.isra.16+0x30/0x3e
> [13046.604331] [<ffffffe0000d7a38>] tick_sched_timer+0x4e/0x94
> [13046.604620] [<ffffffe0000cd44a>] __hrtimer_run_queues+0x10c/0x2de
> [13046.604928] [<ffffffe0000cdc96>] hrtimer_interrupt+0xcc/0x1d6
> [13046.605236] [<ffffffe0005d3f7c>] riscv_timer_interrupt+0x32/0x3a
> [13046.605580] [<ffffffe0007889ce>] do_IRQ+0xae/0xba
> [13046.605837] [<ffffffe00006bd3c>] ret_from_exception+0x0/0xc
> [13046.606127] [<ffffffe00006ca58>] machine_restart+0xc/0xe
> [13046.606508] rcu: rcu_sched kthread starved for 5252 jiffies! g2837145 =
f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
> [13046.606990] rcu: RCU grace-period kthread stack dump:
> [13046.607257] rcu_sched       R  running task        0    10      2 0x00=
000000
> [13046.607610] Call Trace:
> [13046.607774] [<ffffffe000784258>] __schedule+0x1a8/0x482
> [13046.608044] [<ffffffe000784592>] schedule+0x60/0xda
> [13046.608304] [<ffffffe000787a56>] schedule_timeout+0x15c/0x2b2
> [13046.608602] [<ffffffe0000c2ec8>] rcu_gp_kthread+0x4cc/0x7ec
> [13046.608889] [<ffffffe00008b0f2>] kthread+0xf0/0x102
> [13046.609162] [<ffffffe00006bd3c>] ret_from_exception+0x0/0xc
>
> ..... so on getting continuously......
>
>
> Can someone help me out how i can replace my kernel to 5.5.7 since i am n=
ot able to find grub or grub2 on my riscv platform?? i have googled for the=
 solution but most of them seems to be x86 specific where they are trying t=
o change the grub??Where i should modify for riscv to get my kernel up????

You won't be able to install a new kernel from the QEMU guest. You
will need to use OpenEmbedded to build a new kernel and boot that.

Alistair

>
>
> Thanks

