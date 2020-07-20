Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E597C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB19208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=exaleapsemi.onmicrosoft.com header.i=@exaleapsemi.onmicrosoft.com header.b="Y3NikZ2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB19208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exaleapsemi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSNI-00037s-KF
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.VJ@exaleapsemi.com>)
 id 1jxQjT-0007i2-Q5
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:01:09 -0400
Received: from mail-bo1ind01on0722.outbound.protection.outlook.com
 ([2a01:111:f400:fea5::722]:59851
 helo=IND01-BO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.VJ@exaleapsemi.com>)
 id 1jxQjP-0007Cs-QN
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:01:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6prm7/ItV0ZcjKUpLyyEoJwSXTJinuAflQnZhE5JyHu6X/zoVW57xxfrapiNdhB6XI2o0XV7VUYxxjDUMwXOE4drZY/LmikZDWYPiw8bLmwohukgjA6DUWUyb6Rza6gvNCLO4kHkZ0CVLS7hwrXO/BH3r1V5Q+RdJAH8F9JJyITkk2MRoPAbaGgj2CpdGnSKj7yD5kIpkTk5sImT1n3IceAYrQCwq1tEpoQz+gBzjOhIMBwNAdhNjAE+kUZoa14PmM3PcQXn5cFp/M10QQy/r34mMHeHFkGaN+KyUG8s/soZysEiV/uEaIT6ytGHA23kZd7kP9AXv0o8ZD6pBQvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN2laifAlgLpY5uhvB8v995rPmHPNEUMioMz6/ezp2s=;
 b=LT70P7+1ub17ufVFgkWtfog9qAPTqQDcgmjagrkznJKs6Mx3ihq5fqlwcI3FQvhlqQ8D2HjvWq4eYQM6AkiROHB5zgwC4lCLdf2Z07sevE/ipjwetm6T1pk/ThVQxNXK7Q3xOwCi18pU5r+YyfAw2yVGm50UczApBii0c9jOA2/bu6gY/3QNUNqjyRi2Ti5WMQwk0g8GvXaUGNPCmUzVj+NBlfLtstqLGOhDQEWYoqlZ8QNBOibW6MJmanchyf6zJCGt08iXL/Upn69G8ZhSCbsjrQZ0LG3PqKL96HwuKBzW07UMcKMRqbgZ9ELHZ3KZGQNHv/PcPKBgqbL9ArD1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exaleapsemi.com; dmarc=pass action=none
 header.from=exaleapsemi.com; dkim=pass header.d=exaleapsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=exaleapsemi.onmicrosoft.com; s=selector2-exaleapsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN2laifAlgLpY5uhvB8v995rPmHPNEUMioMz6/ezp2s=;
 b=Y3NikZ2t4XwUFoJ8ZCb/MfXAfJwBuYU5r6UHl3iwk1xQwMfSufekTFEYYON7wOmJ3bkX2kmj6gRMVrpWvne8WEPrM5dTbQihjejgXEBIwUOygfBOLfanXTOKMQEQGhQ0nfAiFvVFgC/ZnzxSeHeZdNeshY4ffvg4JRZYBzdPSTE=
Received: from BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:36::20)
 by BMXPR01MB2246.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:3e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 07:45:26 +0000
Received: from BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::adf5:6e2d:b2df:3e72]) by BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::adf5:6e2d:b2df:3e72%2]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 07:45:26 +0000
From: "Pankaj  Vinadrao Joshi" <Pankaj.VJ@exaleapsemi.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Replacing existing kernel with new on qemuriscv64
Thread-Topic: Replacing existing kernel with new on qemuriscv64
Thread-Index: AQHWXmlvPudUmHc3zkyu85nr5qnBjA==
Date: Mon, 20 Jul 2020 07:45:26 +0000
Message-ID: <BMXPR01MB2344EC13172300E0384B97B8EE7B0@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none; nongnu.org; dmarc=none action=none header.from=exaleapsemi.com; 
x-originating-ip: [2405:204:9590:b44:fd38:28d1:95f4:7eea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 691d7c79-f927-46ee-0755-08d82c80ddf0
x-ms-traffictypediagnostic: BMXPR01MB2246:
x-microsoft-antispam-prvs: <BMXPR01MB2246797097793A872FA56C49EE7B0@BMXPR01MB2246.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOLQjwcjaPYjjkARHv8Ful6wGtVotbQi1nSe678RZb3dmWuSbo51l2WV1NHP16fJHyLKgW6SnExIxbcQIW6S4zPnv5Gyo7IFftcEv109t42TMgLLPRjPJHF2pFLGVtbZPm8tb8mVKMiRNp3UfOp8sWj8FW/nyLogNcx/j9myNnpUMv0jDTeAH4gNiXnTuvcNsjBGV4TVAWIrb36cpVvKyBJ83Vr8MsN4qhAP8hpBpPR4YKa3whlDTPt+6dCtkdA+XvcybCHO7vXX1DH8pccwDYGlSiTJWU3t+guZAe9rEPBkVlcaEq0HasUU7oTqR9/p9jObjCwjBQm2+4nfrWbPYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(376002)(366004)(136003)(39830400003)(83380400001)(8676002)(66946007)(316002)(76116006)(66446008)(33656002)(52536014)(66556008)(66476007)(64756008)(5660300002)(2906002)(8936002)(9686003)(19627405001)(6506007)(6916009)(7696005)(55016002)(186003)(86362001)(508600001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: +6rCVTIEj9PgDL88SLInTHBjVuJ9Wjqk1qyd5o5O1/zj/xFeD6L3QLkEBpiKOo5tIfS3eby3xEvW1AtfzQsj3UbjwcOtMnV0/eD8KVvRLyL84a/vxycmlAFwOCC1Je9e7ED6N/oKvBueiPiUUvfdenATWWaeVvQKqSR064o6ZW+ei6uITn17tHOWe0h/0rtzMPUR2Ca1B+Jse3XISMrCK793RdJpqiM8b4x2208AZsI/zGfoiB00y55vZTnqSaRxkeOQGQ2llnGqaKtA1piKHpRMmbpypac5Qy+Tp5DHPU2tFI+w9DzR+RWowiFUenNirSMGaYT/J4rtiO0pWD98fMgct5kgXoQgd9OsnoRFJDZF+dCFoFX5992ToidSVs1nC72ffXmaRgkMBbciG+Sf4OljUqL0X3BFyNagdH7pbj+EAdl5jzkNKuBIR6RkdNKWGhwMfqVCmHmHAXVL5UJX5y8+x+G11wc3u7E+KmX/j6Jnqal3zjG/uO2A7M+U2YeEcJgutkqoOC2FKk3dmIkuST+qst5sKHxWX/4MbNQLYvc=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BMXPR01MB2344EC13172300E0384B97B8EE7B0BMXPR01MB2344INDP_"
MIME-Version: 1.0
X-OriginatorOrg: exaleapsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 691d7c79-f927-46ee-0755-08d82c80ddf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 07:45:26.1657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34df156e-9bc4-4450-9e80-487c0e7f9471
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OG+OadCvYYVGHM86tjboPDkgSeQRRk1+egpasurjqr8f9/FIj+rC7UBxtH4Lm5JLkOA5ML8ltSY03nTutipFTv/aWwv2dr1UrGWG9AVvrQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB2246
Received-SPF: pass client-ip=2a01:111:f400:fea5::722;
 envelope-from=Pankaj.VJ@exaleapsemi.com;
 helo=IND01-BO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jul 2020 05:44:35 -0400
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

--_000_BMXPR01MB2344EC13172300E0384B97B8EE7B0BMXPR01MB2344INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi ,
I am trying to replace my existing kernel image which is 5.5.6 to 5.5.7 on =
qemuriscv64 i would like to mention i have built my qemu image with openemb=
edded-core.

i have tried to build the kernel 5.5.7 natively,i was able to build the ker=
nel successfully and in my /boot folder i am able to see vmlinux-5.5.7  but=
 now i want to install this image..i have tried to do it by make install i =
didnt got any error with it but when i rebooted my system i am getting

i have followed the following steps to build kernel
$root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel#  make menuconfig arch=3Dr=
iscv64
$root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make -j4
$root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make modules_install
$root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make install
sh ./arch/riscv/boot/install.sh 5.5.7 \
arch/riscv/boot/Image System.map "/boot"
Installing normal kernel

$reboot
13024.451157] printk: systemd-shutdow: 37 output lines suppressed due to ra=
telimiting
[13024.527282] systemd-shutdown[1]: Syncing filesystems and block devices.
[13024.668538] systemd-shutdown[1]: Sending SIGTERM to remaining processes.=
..
[13024.719496] systemd-journald[87]: Received SIGTERM from PID 1 (systemd-s=
hutdow).
[13024.769405] systemd-shutdown[1]: Sending SIGKILL to remaining processes.=
..
[13024.834318] systemd-shutdown[1]: Unmounting file systems.
[13024.868285] [13413]: Remounting '/' read-only in with options '(null)'.
[13025.228499] EXT4-fs (vda): re-mounted. Opts: (null)
[13025.358123] systemd-shutdown[1]: All filesystems unmounted.
[13025.358576] systemd-shutdown[1]: Deactivating swaps.
[13025.361264] systemd-shutdown[1]: All swaps deactivated.
[13025.361727] systemd-shutdown[1]: Detaching loop devices.
[13025.420602] systemd-shutdown[1]: All loop devices detached.
[13025.421071] systemd-shutdown[1]: Detaching DM devices.
[13025.595237] reboot: Restarting system
[13046.599875] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[13046.600329] (detected by 0, t=3D5252 jiffies, g=3D2837145, q=3D17)
[13046.600763] rcu: All QSes seen, last rcu_sched kthread activity 5252 (42=
98153942-4298148690), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
[13046.601503] systemd-shutdow R  running task        0     1      0 0x0000=
0008
[13046.602053] Call Trace:
[13046.602562] [<ffffffe00006d3fc>] walk_stackframe+0x0/0xa4
[13046.602890] [<ffffffe00006d5e2>] show_stack+0x2a/0x34
[13046.603156] [<ffffffe000091094>] sched_show_task+0x158/0x174
[13046.603442] [<ffffffe0000c4dde>] rcu_sched_clock_irq+0x6b2/0x6ec
[13046.603740] [<ffffffe0000ccadc>] update_process_times+0x1e/0x44
[13046.604009] [<ffffffe0000d79dc>] tick_sched_handle.isra.16+0x30/0x3e
[13046.604331] [<ffffffe0000d7a38>] tick_sched_timer+0x4e/0x94
[13046.604620] [<ffffffe0000cd44a>] __hrtimer_run_queues+0x10c/0x2de
[13046.604928] [<ffffffe0000cdc96>] hrtimer_interrupt+0xcc/0x1d6
[13046.605236] [<ffffffe0005d3f7c>] riscv_timer_interrupt+0x32/0x3a
[13046.605580] [<ffffffe0007889ce>] do_IRQ+0xae/0xba
[13046.605837] [<ffffffe00006bd3c>] ret_from_exception+0x0/0xc
[13046.606127] [<ffffffe00006ca58>] machine_restart+0xc/0xe
[13046.606508] rcu: rcu_sched kthread starved for 5252 jiffies! g2837145 f0=
x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[13046.606990] rcu: RCU grace-period kthread stack dump:
[13046.607257] rcu_sched       R  running task        0    10      2 0x0000=
0000
[13046.607610] Call Trace:
[13046.607774] [<ffffffe000784258>] __schedule+0x1a8/0x482
[13046.608044] [<ffffffe000784592>] schedule+0x60/0xda
[13046.608304] [<ffffffe000787a56>] schedule_timeout+0x15c/0x2b2
[13046.608602] [<ffffffe0000c2ec8>] rcu_gp_kthread+0x4cc/0x7ec
[13046.608889] [<ffffffe00008b0f2>] kthread+0xf0/0x102
[13046.609162] [<ffffffe00006bd3c>] ret_from_exception+0x0/0xc

..... so on getting continuously......


Can someone help me out how i can replace my kernel to 5.5.7 since i am not=
 able to find grub or grub2 on my riscv platform?? i have googled for the s=
olution but most of them seems to be x86 specific where they are trying to =
change the grub??Where i should modify for riscv to get my kernel up????


Thanks

--_000_BMXPR01MB2344EC13172300E0384B97B8EE7B0BMXPR01MB2344INDP_
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
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
Hi ,</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
I am trying to replace my existing kernel image which is 5.5.6 to 5.5.7 on =
qemuriscv64 i would like to mention i have built my qemu image with openemb=
edded-core.</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
<br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
i have tried to build the kernel 5.5.7 natively,i was able to build the ker=
nel successfully and in my /boot folder i am able to see vmlinux-5.5.7&nbsp=
; but now i want to install this image..i have tried to do it by make insta=
ll i didnt got any error with it but
 when i rebooted my system i am getting&nbsp;</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
<br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
i have followed the following steps to build kernel</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
$<span style=3D"margin: 0px; background-color: white">root@qemuriscv64-exal=
eapsemi-r2:/usr/src/kernel#&nbsp;&nbsp;</span>make menuconfig arch=3Driscv6=
4</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
$<span style=3D"margin: 0px; background-color: white">root@qemuriscv64-exal=
eapsemi-r2:/usr/src/kernel#&nbsp;</span>make -j4</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
$<span style=3D"margin: 0px; background-color: white">root@qemuriscv64-exal=
eapsemi-r2:/usr/src/kernel#&nbsp;</span>make modules_install</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
<span style=3D"margin: 0px">$root@qemuriscv64-exaleapsemi-r2:/usr/src/kerne=
l# make install</span><br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
<div style=3D"margin: 0px; background-color: white">sh ./arch/riscv/boot/in=
stall.sh 5.5.7 \</div>
<div style=3D"margin: 0px; background-color: white">arch/riscv/boot/Image S=
ystem.map &quot;/boot&quot;</div>
<div style=3D"margin: 0px; background-color: white">Installing normal kerne=
l</div>
<br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
<span style=3D"margin: 0px">$reboot</span><br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
<div style=3D"margin: 0px; background-color: white"><span style=3D"margin: =
0px">13024.451157] printk: systemd-shutdow: 37 output lines suppressed due =
to ratelimiting<br>
</span>
<div style=3D"margin: 0px">[13024.527282] systemd-shutdown[1]: Syncing file=
systems and block devices.<br>
</div>
<div style=3D"margin: 0px">[13024.668538] systemd-shutdown[1]: Sending SIGT=
ERM to remaining processes...<br>
</div>
<div style=3D"margin: 0px">[13024.719496] systemd-journald[87]: Received SI=
GTERM from PID 1 (systemd-shutdow).<br>
</div>
<div style=3D"margin: 0px">[13024.769405] systemd-shutdown[1]: Sending SIGK=
ILL to remaining processes...<br>
</div>
<div style=3D"margin: 0px">[13024.834318] systemd-shutdown[1]: Unmounting f=
ile systems.<br>
</div>
<div style=3D"margin: 0px">[13024.868285] [13413]: Remounting '/' read-only=
 in with options '(null)'.<br>
</div>
<div style=3D"margin: 0px">[13025.228499] EXT4-fs (vda): re-mounted. Opts: =
(null)<br>
</div>
<div style=3D"margin: 0px">[13025.358123] systemd-shutdown[1]: All filesyst=
ems unmounted.<br>
</div>
<div style=3D"margin: 0px">[13025.358576] systemd-shutdown[1]: Deactivating=
 swaps.<br>
</div>
<div style=3D"margin: 0px">[13025.361264] systemd-shutdown[1]: All swaps de=
activated.<br>
</div>
<div style=3D"margin: 0px">[13025.361727] systemd-shutdown[1]: Detaching lo=
op devices.<br>
</div>
<div style=3D"margin: 0px">[13025.420602] systemd-shutdown[1]: All loop dev=
ices detached.<br>
</div>
<div style=3D"margin: 0px">[13025.421071] systemd-shutdown[1]: Detaching DM=
 devices.<br>
</div>
<div style=3D"margin: 0px">[13025.595237] reboot: Restarting system<br>
</div>
<div style=3D"margin: 0px">[13046.599875] rcu: INFO: rcu_sched detected sta=
lls on CPUs/tasks:<br>
</div>
<div style=3D"margin: 0px">[13046.600329] (detected by 0, t=3D5252 jiffies,=
 g=3D2837145, q=3D17)<br>
</div>
<div style=3D"margin: 0px">[13046.600763] rcu: All QSes seen, last rcu_sche=
d kthread activity 5252 (4298153942-4298148690), jiffies_till_next_fqs=3D1,=
 root -&gt;qsmask 0x0<br>
</div>
<div style=3D"margin: 0px">[13046.601503] systemd-shutdow R &nbsp;running t=
ask &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; 1 &nbsp; &nbsp; &nbsp;0 0x00=
000008<br>
</div>
<div style=3D"margin: 0px">[13046.602053] Call Trace:<br>
</div>
<div style=3D"margin: 0px">[13046.602562] [&lt;ffffffe00006d3fc&gt;] walk_s=
tackframe&#43;0x0/0xa4<br>
</div>
<div style=3D"margin: 0px">[13046.602890] [&lt;ffffffe00006d5e2&gt;] show_s=
tack&#43;0x2a/0x34<br>
</div>
<div style=3D"margin: 0px">[13046.603156] [&lt;ffffffe000091094&gt;] sched_=
show_task&#43;0x158/0x174<br>
</div>
<div style=3D"margin: 0px">[13046.603442] [&lt;ffffffe0000c4dde&gt;] rcu_sc=
hed_clock_irq&#43;0x6b2/0x6ec<br>
</div>
<div style=3D"margin: 0px">[13046.603740] [&lt;ffffffe0000ccadc&gt;] update=
_process_times&#43;0x1e/0x44<br>
</div>
<div style=3D"margin: 0px">[13046.604009] [&lt;ffffffe0000d79dc&gt;] tick_s=
ched_handle.isra.16&#43;0x30/0x3e<br>
</div>
<div style=3D"margin: 0px">[13046.604331] [&lt;ffffffe0000d7a38&gt;] tick_s=
ched_timer&#43;0x4e/0x94<br>
</div>
<div style=3D"margin: 0px">[13046.604620] [&lt;ffffffe0000cd44a&gt;] __hrti=
mer_run_queues&#43;0x10c/0x2de<br>
</div>
<div style=3D"margin: 0px">[13046.604928] [&lt;ffffffe0000cdc96&gt;] hrtime=
r_interrupt&#43;0xcc/0x1d6<br>
</div>
<div style=3D"margin: 0px">[13046.605236] [&lt;ffffffe0005d3f7c&gt;] riscv_=
timer_interrupt&#43;0x32/0x3a<br>
</div>
<div style=3D"margin: 0px">[13046.605580] [&lt;ffffffe0007889ce&gt;] do_IRQ=
&#43;0xae/0xba<br>
</div>
<div style=3D"margin: 0px">[13046.605837] [&lt;ffffffe00006bd3c&gt;] ret_fr=
om_exception&#43;0x0/0xc<br>
</div>
<div style=3D"margin: 0px">[13046.606127] [&lt;ffffffe00006ca58&gt;] machin=
e_restart&#43;0xc/0xe<br>
</div>
<div style=3D"margin: 0px">[13046.606508] rcu: rcu_sched kthread starved fo=
r 5252 jiffies! g2837145 f0x2 RCU_GP_WAIT_FQS(5) -&gt;state=3D0x0 -&gt;cpu=
=3D0<br>
</div>
<div style=3D"margin: 0px">[13046.606990] rcu: RCU grace-period kthread sta=
ck dump:<br>
</div>
<div style=3D"margin: 0px">[13046.607257] rcu_sched &nbsp; &nbsp; &nbsp; R =
&nbsp;running task &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp;10 &nbsp; &nbs=
p; &nbsp;2 0x00000000<br>
</div>
<div style=3D"margin: 0px">[13046.607610] Call Trace:<br>
</div>
<div style=3D"margin: 0px">[13046.607774] [&lt;ffffffe000784258&gt;] __sche=
dule&#43;0x1a8/0x482<br>
</div>
<div style=3D"margin: 0px">[13046.608044] [&lt;ffffffe000784592&gt;] schedu=
le&#43;0x60/0xda<br>
</div>
<div style=3D"margin: 0px">[13046.608304] [&lt;ffffffe000787a56&gt;] schedu=
le_timeout&#43;0x15c/0x2b2<br>
</div>
<div style=3D"margin: 0px">[13046.608602] [&lt;ffffffe0000c2ec8&gt;] rcu_gp=
_kthread&#43;0x4cc/0x7ec<br>
</div>
<div style=3D"margin: 0px">[13046.608889] [&lt;ffffffe00008b0f2&gt;] kthrea=
d&#43;0xf0/0x102<br>
</div>
<div style=3D"margin: 0px">[13046.609162] [&lt;ffffffe00006bd3c&gt;] ret_fr=
om_exception&#43;0x0/0xc&nbsp;</div>
<div style=3D"margin: 0px"><br>
</div>
<div style=3D"margin: 0px">..... so on getting continuously......</div>
</div>
<br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
<br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
Can someone help me out how i can replace my kernel to 5.5.7 since i am not=
 able to find grub or grub2 on my riscv platform?? i have googled for the s=
olution but most of them seems to be x86 specific where they are trying to =
change the grub??Where i should
 modify for riscv to get my kernel up????</div>
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks</div>
</body>
</html>

--_000_BMXPR01MB2344EC13172300E0384B97B8EE7B0BMXPR01MB2344INDP_--

