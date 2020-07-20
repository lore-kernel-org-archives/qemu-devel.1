Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24004C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B13208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=exaleapsemi.onmicrosoft.com header.i=@exaleapsemi.onmicrosoft.com header.b="gafijPXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B13208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exaleapsemi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxaPN-0003w4-Ui
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.VJ@exaleapsemi.com>)
 id 1jxaO9-0003V5-Le
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:19:45 -0400
Received: from mail-eopbgr1390132.outbound.protection.outlook.com
 ([40.107.139.132]:16190 helo=IND01-BO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.VJ@exaleapsemi.com>)
 id 1jxaO6-0003Kd-D5
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:19:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd+llfATo14cU0R3PbhWtOdbtbiggLjhnecDH8Fhvb3m9YDT7LyncgrS8MlHrmhCrwmanfVsb3fSiWZt5AYU5JvS3idHlGkwpJBDjQzF/P37mr40QK3w+4z3ffP2k3qwKvjZZ/Hw0YXJW77R8XavPa3pc8LB0qIve4jwwYfbfX2Dl1g0FQ+eOxtTG5WpER3nPdW91smLEo5HKr+fEzTSt/Sj5wMZWJMBjjWcBgvzDKL5IW4abXBssPWr/4yFq3YOZ2ttaJo9+uI41rJ1j4EQItjVlQNAZkgYb8JawjimJwTeXbPLqIH4MeRwYTJLZtfFlYFLw+Fd345Iyt0N+XHH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDGzS1gEmBM904x0agXAYJiHHX1iIewjMP4oLTfoDLE=;
 b=Cc8JthDqp1WDQNMlahHZ/vs5LzTF1KGxFFhd5wjCII/oGxMVD6NgyW7dqe1MN5ubN2ghstoc/qwdAqNcbY364cf32qHOKeJYF8Terw91lfqDsW+G39TsSeRNfmzuM2FDY0J44hMkiuSAncW7RKMx+yD5HBYJj3DE8WBz9t0PCcmAks6dUSx3mn/sgAuEAxGgD58Y6GWkjbr0jUhtJNruu8HkIVw5UCOenP4EZvwPi/n2lPWr7Jp5u3LTYIDBLEQqIhqiBHplOh6nHnZlE4W9C/Tef0Au5XS7h0V1B6kLhpgbdKujQ25cssdXqjUb2H9jPgJV0FFhuiKRFQZBCNau+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exaleapsemi.com; dmarc=pass action=none
 header.from=exaleapsemi.com; dkim=pass header.d=exaleapsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=exaleapsemi.onmicrosoft.com; s=selector2-exaleapsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDGzS1gEmBM904x0agXAYJiHHX1iIewjMP4oLTfoDLE=;
 b=gafijPXgvsmaJg/OJgtwW1VilxW4X0L6egEBWtVLuBmMyR2Le1P44h+BsdUaVzilxhCOzBrKOXoNmIogkJgrlGAV8gXBaAUH9BhZhgAFD7cJP09jbiJuRiSGOTotNDthsaS5ELKAdg6tHwTTAZwqNiP7CKlQZMZCNIGdfalcY00=
Received: from BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:36::20)
 by BM1PR0101MB1521.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 18:19:36 +0000
Received: from BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::adf5:6e2d:b2df:3e72]) by BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::adf5:6e2d:b2df:3e72%2]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:19:36 +0000
From: "Pankaj  Vinadrao Joshi" <Pankaj.VJ@exaleapsemi.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: Replacing existing kernel with new on qemuriscv64
Thread-Topic: Replacing existing kernel with new on qemuriscv64
Thread-Index: AQHWXmlvPudUmHc3zkyu85nr5qnBjKkQsVcAgAAU6Ks=
Date: Mon, 20 Jul 2020 18:19:36 +0000
Message-ID: <BMXPR01MB2344CFB0D2C0CBD133ACCD0AEE7B0@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB2344EC13172300E0384B97B8EE7B0@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>,
 <CAKmqyKOsS+bTM=R4gEHBaDCGh3Lmo-bKiG=zbnHS30EwP70RoQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOsS+bTM=R4gEHBaDCGh3Lmo-bKiG=zbnHS30EwP70RoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=exaleapsemi.com;
x-originating-ip: [2405:204:9590:b44:e582:8190:55ba:b0a4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 091797fd-2e09-449d-3974-08d82cd975a3
x-ms-traffictypediagnostic: BM1PR0101MB1521:
x-microsoft-antispam-prvs: <BM1PR0101MB15211499457803C2664ABF23EE7B0@BM1PR0101MB1521.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkVVc8cQ4vxZ83K6745dWN58MmyELBQpLSF+/gW+aaOooFsypmoWTn4yBUlCf5dmm0CsvMP9JgEGfZvHeI7KtqGPLGJZPJV9b0VEfbNXc+wa1P/nyMbqHMXCy7c29H8WFZsBNraGgScTny02BuUpvtfAyPSrNDjsBuHTOdjysAai+vXwFVeESxo9X1bvlJnDEv7dupXM0ultCNdAJeA3uaSYj7MrnvVwasL1SGrGx0zJYaORxIMBJe5/EGk3kg25th+Gy/ZwvsWiCFr8WhN6tKKufAKobM8dHC/61quYPf23Q/+ceq1aBH6PmZ1BHjwz+bDaNvEv+rF66ZkuYcNRuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(39830400003)(366004)(136003)(346002)(4326008)(33656002)(8936002)(52536014)(186003)(2906002)(508600001)(8676002)(316002)(5660300002)(55016002)(83380400001)(66946007)(66556008)(64756008)(66476007)(76116006)(19627405001)(7696005)(66446008)(6506007)(86362001)(6916009)(71200400001)(9686003)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: +GmPK+NEJGPvtImOAorVGyj9dHceO1FOKgwxV33NU98xxE0lRWGO/26fywmkDDnTKA7jG5Hq2tUeYMs7NB97IZ57Fp1C6N0kPHPi9AynqzmJ8ZTGrM+8Ly0DC89jodr3jilKvfn44Zep5W6UC3kzAv5jrO8ZupV5Izd0pSwj0vfRlLi092WgRbcYPd26neDjqSk6teIsGKh2ABnrJlebq/2QHMTitxs1HvTgJeNTrIiKEDbsbM2v4IIhTqSuBTFDbERu/ippTIKQQGuwN3ADJJ+jlpSBaxAysaeFc+CfS3KKw8x72zei90EphaQmEX7GDpyJqH98TZMwG+IXln6m6REWyil2iLookhNPwLP0X7/F5L0+UgKVAth17jfBVf/HU+aoZJQGbPoX5nNSMm/+qLOr+YtgGPFcf3w4wLpQXuCdb/nkcY0ZXTqy/nv8a5V0E46KRxYCCoKfK/mHKYBsjV4BotKpW4HGpEphUGRWZbr6/PwSQL28vQ/hsmIuajVadpNvJJY99ZuRuEmtZSr/84+RHWlfLS2DIpVSUF9rXRg=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BMXPR01MB2344CFB0D2C0CBD133ACCD0AEE7B0BMXPR01MB2344INDP_"
MIME-Version: 1.0
X-OriginatorOrg: exaleapsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 091797fd-2e09-449d-3974-08d82cd975a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 18:19:36.5292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34df156e-9bc4-4450-9e80-487c0e7f9471
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSGpb+pbPHbvd0kV/J1fb1BPGX/9Z16l5vWdU3LxlOdc6zIyRLRkjUi9aNryI03Lk6Dl7kaIracT6KtyDaIzptMESWSRsemjwLTt3xFx68c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BM1PR0101MB1521
Received-SPF: pass client-ip=40.107.139.132;
 envelope-from=Pankaj.VJ@exaleapsemi.com;
 helo=IND01-BO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 14:19:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

--_000_BMXPR01MB2344CFB0D2C0CBD133ACCD0AEE7B0BMXPR01MB2344INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alistair Francis,

Thanks for your response.I have same concern for other riscv hardware with =
custom kernel will same be applicable for it?If no from where i should chan=
ge my kernel image since there also i am not able to find grub and the clar=
ification given on web are seems to be very specific to x86 arch where i sh=
ould look in case of riscv ??

Thanks

________________________________
From: Alistair Francis <alistair23@gmail.com>
Sent: Monday, July 20, 2020 10:29 PM
To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: Re: Replacing existing kernel with new on qemuriscv64

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
[EXT]

--_000_BMXPR01MB2344CFB0D2C0CBD133ACCD0AEE7B0BMXPR01MB2344INDP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Alistair Francis,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks for your response.I have same concern for other riscv hardware with =
custom kernel will same be applicable for it?If no from where i should chan=
ge my kernel image since there also i am not able to find grub and the clar=
ification given on web are seems
 to be very specific to x86 arch where i should look in case of riscv ??</d=
iv>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alistair Francis &lt;=
alistair23@gmail.com&gt;<br>
<b>Sent:</b> Monday, July 20, 2020 10:29 PM<br>
<b>To:</b> Pankaj Vinadrao Joshi &lt;Pankaj.VJ@exaleapsemi.com&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> Re: Replacing existing kernel with new on qemuriscv64</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><span style=3D"font-family: calibri, arial, helvet=
ica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-color: rg=
ba(0, 0, 0, 0);">On Mon, Jul 20, 2020 at 2:46 AM Pankaj Vinadrao Joshi</spa=
n><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&lt;Pank=
aj.VJ@exaleapsemi.com&gt; wrote:</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt;</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; Hi =
,</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; I a=
m trying to replace my existing kernel image which is 5.5.6 to 5.5.7 on qem=
uriscv64 i would like to mention i have
 built my qemu image with openembedded-core.</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt;</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; i h=
ave tried to build the kernel 5.5.7 natively,i was able to build the kernel=
 successfully and in my /boot folder
 i am able to see vmlinux-5.5.7&nbsp; but now i want to install this image.=
.i have tried to do it by make install i didnt got any error with it but wh=
en i rebooted my system i am getting</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt;</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; i h=
ave followed the following steps to build kernel</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; $ro=
ot@qemuriscv64-exaleapsemi-r2:/usr/src/kernel#&nbsp; make menuconfig arch=
=3Driscv64</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; $ro=
ot@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make -j4</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; $ro=
ot@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make modules_install</span><=
br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; $ro=
ot@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make install</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; sh =
./arch/riscv/boot/install.sh 5.5.7 \</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; arc=
h/riscv/boot/Image System.map &quot;/boot&quot;</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; Ins=
talling normal kernel</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt;</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; $re=
boot</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; 130=
24.451157] printk: systemd-shutdow: 37 output lines suppressed due to ratel=
imiting</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
024.527282] systemd-shutdown[1]: Syncing filesystems and block devices.</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
024.668538] systemd-shutdown[1]: Sending SIGTERM to remaining processes...<=
/span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
024.719496] systemd-journald[87]: Received SIGTERM from PID 1 (systemd-shut=
dow).</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
024.769405] systemd-shutdown[1]: Sending SIGKILL to remaining processes...<=
/span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
024.834318] systemd-shutdown[1]: Unmounting file systems.</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
024.868285] [13413]: Remounting '/' read-only in with options '(null)'.</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
025.228499] EXT4-fs (vda): re-mounted. Opts: (null)</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
025.358123] systemd-shutdown[1]: All filesystems unmounted.</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
025.358576] systemd-shutdown[1]: Deactivating swaps.</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
025.361264] systemd-shutdown[1]: All swaps deactivated.</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
025.361727] systemd-shutdown[1]: Detaching loop devices.</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
025.420602] systemd-shutdown[1]: All loop devices detached.</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
025.421071] systemd-shutdown[1]: Detaching DM devices.</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
025.595237] reboot: Restarting system</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.599875] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.600329] (detected by 0, t=3D5252 jiffies, g=3D2837145, q=3D17)</span><b=
r>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.600763] rcu: All QSes seen, last rcu_sched kthread activity 5252 (42981=
53942-4298148690), jiffies_till_next_fqs=3D1,
 root -&gt;qsmask 0x0</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.601503] systemd-shutdow R&nbsp; running task&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
 0x00000008</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.602053] Call Trace:</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.602562] [&lt;ffffffe00006d3fc&gt;] walk_stackframe&#43;0x0/0xa4</span><=
br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.602890] [&lt;ffffffe00006d5e2&gt;] show_stack&#43;0x2a/0x34</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.603156] [&lt;ffffffe000091094&gt;] sched_show_task&#43;0x158/0x174</spa=
n><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.603442] [&lt;ffffffe0000c4dde&gt;] rcu_sched_clock_irq&#43;0x6b2/0x6ec<=
/span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.603740] [&lt;ffffffe0000ccadc&gt;] update_process_times&#43;0x1e/0x44</=
span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.604009] [&lt;ffffffe0000d79dc&gt;] tick_sched_handle.isra.16&#43;0x30/0=
x3e</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.604331] [&lt;ffffffe0000d7a38&gt;] tick_sched_timer&#43;0x4e/0x94</span=
><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.604620] [&lt;ffffffe0000cd44a&gt;] __hrtimer_run_queues&#43;0x10c/0x2de=
</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.604928] [&lt;ffffffe0000cdc96&gt;] hrtimer_interrupt&#43;0xcc/0x1d6</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.605236] [&lt;ffffffe0005d3f7c&gt;] riscv_timer_interrupt&#43;0x32/0x3a<=
/span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.605580] [&lt;ffffffe0007889ce&gt;] do_IRQ&#43;0xae/0xba</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.605837] [&lt;ffffffe00006bd3c&gt;] ret_from_exception&#43;0x0/0xc</span=
><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.606127] [&lt;ffffffe00006ca58&gt;] machine_restart&#43;0xc/0xe</span><b=
r>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.606508] rcu: rcu_sched kthread starved for 5252 jiffies! g2837145 f0x2 =
RCU_GP_WAIT_FQS(5) -&gt;state=3D0x0 -&gt;cpu=3D0</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.606990] rcu: RCU grace-period kthread stack dump:</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.607257] rcu_sched&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp; running t=
ask&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 10&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 2 0x00000000</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.607610] Call Trace:</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.607774] [&lt;ffffffe000784258&gt;] __schedule&#43;0x1a8/0x482</span><br=
>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.608044] [&lt;ffffffe000784592&gt;] schedule&#43;0x60/0xda</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.608304] [&lt;ffffffe000787a56&gt;] schedule_timeout&#43;0x15c/0x2b2</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.608602] [&lt;ffffffe0000c2ec8&gt;] rcu_gp_kthread&#43;0x4cc/0x7ec</span=
><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.608889] [&lt;ffffffe00008b0f2&gt;] kthread&#43;0xf0/0x102</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; [13=
046.609162] [&lt;ffffffe00006bd3c&gt;] ret_from_exception&#43;0x0/0xc</span=
><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt;</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; ...=
.. so on getting continuously......</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt;</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt;</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; Can=
 someone help me out how i can replace my kernel to 5.5.7 since i am not ab=
le to find grub or grub2 on my riscv
 platform?? i have googled for the solution but most of them seems to be x8=
6 specific where they are trying to change the grub??Where i should modify =
for riscv to get my kernel up????</span><br>
<br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">You won'=
t be able to install a new kernel from the QEMU guest. You</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">will nee=
d to use OpenEmbedded to build a new kernel and boot that.</span><br>
<br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">Alistair=
</span><br>
<br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt;</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt;</sp=
an><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">&gt; Tha=
nks</span><br>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">[EXT]</s=
pan><br>
</div>
</span></font></div>
</body>
</html>

--_000_BMXPR01MB2344CFB0D2C0CBD133ACCD0AEE7B0BMXPR01MB2344INDP_--

