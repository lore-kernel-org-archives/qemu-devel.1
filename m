Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B85C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A9D2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=exaleapsemi.onmicrosoft.com header.i=@exaleapsemi.onmicrosoft.com header.b="yuvHgRgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A9D2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exaleapsemi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYCm-0002AP-1G
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.VJ@exaleapsemi.com>)
 id 1jyYBu-0001iG-GJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:11:06 -0400
Received: from mail-eopbgr1390135.outbound.protection.outlook.com
 ([40.107.139.135]:21408 helo=IND01-BO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.VJ@exaleapsemi.com>)
 id 1jyYBr-0001cH-DY
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVz90e1+Xx8zqrgNyBgGwDpmLz3GqAV+ZHAD7GcV3GNGH0BgI+Rtr8mZT7Kp7r9l0iVcP70vmlOvDKTHzHgbwHfLQJy4jVxk0OsE3M7ovlyhUDMmPGGYPrcnCWH10XXuDaJIOKFuFnAgorwpH/COlPG1MEr0hEBJw8cZY9GpL4Uatinz7L/LJKfCooDWkuNNzFZRbALIJeGFarXBVa9xNvku1YrWgeBuDG2LFdPZgH5SfMNDuYVC025JJvpKDdqIwPvUWlroW0d27QXdv3ctPLAopjihahqf/LdMEuKA4w8bQkHOaVG8DILnELeoR3kvL7J/u7bPvqTzxRK9uzonYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAuIs9IVsEG3yVBCGNCXdtCcG5gMd0J6G8W9LTgWA4k=;
 b=hasMDj2Y94VZhWVJV+MSYkR7glHhZJWci5nDS8FoQaGYG4ze0uKmnmst8rc+583wJ4NgM3oVMupgO6qhAmhNq73sttpKhDaSHT1Ztu3bqG5gIjMKEiTcVU4TZjsS0MOHR2v/xzV36jJ8fdoJYDVUGolY2uC/DEX3/C4YVxkrR4LUAWNkhXDmvQAseLH8b2EP4xOhNaym1dXRZvyqcslNUNTDLRZEVKoWwF4gAmB9nM70Dlj+QvEO2f9WKGnJd0PCCPclznf2Nz9VS2Y/Fo1JuF8DChsNZJyQb/LDJcIXhAumvhzCNgquy6F0szJn3GPGcxHxzPVb6UggRlxWPdoGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exaleapsemi.com; dmarc=pass action=none
 header.from=exaleapsemi.com; dkim=pass header.d=exaleapsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=exaleapsemi.onmicrosoft.com; s=selector2-exaleapsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAuIs9IVsEG3yVBCGNCXdtCcG5gMd0J6G8W9LTgWA4k=;
 b=yuvHgRgb/2CZ03cDFokz6KRSlts9Q+3qh0i/DQkSfGA/NQFcH+D/HzkOx9U346r3PeVdGac+GRfHtVNhl5jqusM7bmQWzENxCQF0s2vorDsyj1dCMQhF2BvbkmLFIP6whTI0U+96/IHSxAimqNs9TO6HYvwplkxzJoRgYQilbmY=
Received: from BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:36::20)
 by BMXPR01MB3607.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:58::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Thu, 23 Jul
 2020 09:55:46 +0000
Received: from BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::adf5:6e2d:b2df:3e72]) by BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::adf5:6e2d:b2df:3e72%2]) with mapi id 15.20.3216.023; Thu, 23 Jul 2020
 09:55:46 +0000
From: "Pankaj  Vinadrao Joshi" <Pankaj.VJ@exaleapsemi.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: Replacing existing kernel with new on qemuriscv64
Thread-Topic: Replacing existing kernel with new on qemuriscv64
Thread-Index: AQHWXmlvPudUmHc3zkyu85nr5qnBjKkQsVcAgAAU6KuAAAeAAIAAq8qtgALcmwCAAFyYlQ==
Date: Thu, 23 Jul 2020 09:55:46 +0000
Message-ID: <BMXPR01MB23448730F4DA9C023315C3FAEE760@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB2344EC13172300E0384B97B8EE7B0@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
 <CAKmqyKOsS+bTM=R4gEHBaDCGh3Lmo-bKiG=zbnHS30EwP70RoQ@mail.gmail.com>
 <BMXPR01MB2344CFB0D2C0CBD133ACCD0AEE7B0@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
 <CAKmqyKMdoXP1axxLMY4onNUkc7yxZi4RX-vE3f=gzPpnsV4Whw@mail.gmail.com>
 <BMXPR01MB234400F77C27A37B859AFC50EE780@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>,
 <CAKmqyKPq_oa6-7aVPFxDC8sdEMfR2g3WoY_Anr1TUoJsPdWG-Q@mail.gmail.com>
In-Reply-To: <CAKmqyKPq_oa6-7aVPFxDC8sdEMfR2g3WoY_Anr1TUoJsPdWG-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=exaleapsemi.com;
x-originating-ip: [157.33.180.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c98282f0-2456-48aa-909e-08d82eee9238
x-ms-traffictypediagnostic: BMXPR01MB3607:
x-microsoft-antispam-prvs: <BMXPR01MB3607F2C1933CBBDEFE490E6DEE760@BMXPR01MB3607.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7m3UTXBZk+T4DSHaQXQppksqgGjvfqmGwbMgS9hKH41rACn7JfQf7EuM4SVn6Wth8crmIK7mJyrFtdCZqPh9IwzsmqkOC1DpZgz4apRQtlzJmtz7lJVc26uIEAN9NofB2R6tRQ2XDOLGna1bIQhfr932feeQFB163ElTfxE2O6ighfkmNeDZTrnLSPOBRrz0NYHkFmINwRA5bCyrTfnyg0f65HUnC3IJFBz/YQpQccfyJXqUURRmbYVQaeRG3wtqCzk5UIYP1q8pVDqI7twfb/QAvaepVk/328HNZEyD6vXjieHIB3OvawMi+19n19WCkuMUIxkw7MQaC7iILlGmmQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(39830400003)(346002)(396003)(136003)(6916009)(26005)(53546011)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(6506007)(8936002)(19627405001)(4326008)(83380400001)(8676002)(2906002)(33656002)(55016002)(9686003)(186003)(86362001)(52536014)(7696005)(508600001)(316002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: hSRO/lBaCt5vYjhZcr8m0rraQy6Ic/eEG5xJ62VQlKBmMl6P5Puhi56YnxMy7F+WbrYEMYG0wRbOeB00U9ZrJ/SC4gOaotL8bXWmS6zo8ExEjUFNkxdBJdDHdJVdhzfJ8d9RPF8ygSRRV9+y39yWU4r9vzHV7RN+VP+xKDH3zQFgRMc7N0XkD7Eud3EFgi+zrqyoeUeQdthr9BjIxIlcnZFQpKQW0igetgqfMrLj4fqh31qMRW9eDdyWJVEdH9xjPU4a7qRcdBHXwO0pI6QPbX3+6oSEn7MkdXl7XA8Uq5MT3PjMwmXnzTmf+p+GjRyfyGAAtOkjHc8xEWrBcmxERt9/knKmUFAZGfxMME2I7W2ZOXr5yLskbNPUHhmHG9i2HfdZjqwyJNrnLQ6WDvjczwyH5bj+qK0FusjXXG8NHlN4fFG2CwaYfgKZCc3oWMBQJKhpxFXBBQhTyBkfkIEToRWvTbJvmds4dB3s25un6HA=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BMXPR01MB23448730F4DA9C023315C3FAEE760BMXPR01MB2344INDP_"
MIME-Version: 1.0
X-OriginatorOrg: exaleapsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c98282f0-2456-48aa-909e-08d82eee9238
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 09:55:46.2040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34df156e-9bc4-4450-9e80-487c0e7f9471
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i17JP75gGmIdbiYO95MyTYEWeouhyO7scZylD+OjFDjsc/0X93DwW3Scvl+mm9aOWGef4oG7Ah6//FRHnMrJXSfr6jwgK0gjfT1XBWyiutg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB3607
Received-SPF: pass client-ip=40.107.139.135;
 envelope-from=Pankaj.VJ@exaleapsemi.com;
 helo=IND01-BO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:10:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

--_000_BMXPR01MB23448730F4DA9C023315C3FAEE760BMXPR01MB2344INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
yes am building it natively for riscv (sifive's u540 hardware ) and in /boo=
t  i am able to find System.map-5.7.2 and vmlinux-5.7.2

root@exaleapsemi:~/linux-stable# make install
make: Warning: File '.vmlinux.cmd' has modification time 1221719 s in the f=
uture
make[1]: Warning: File 'arch/riscv/boot/.Image.cmd' has modification time 1=
221720 s in the future
sh ./arch/riscv/boot/install.sh 5.7.2 \
arch/riscv/boot/Image System.map "/boot"
Installing normal kernel

But now i want to boot with this kernel but i am not able to do so..its boo=
ting from the earlier kernel only..i am not able to figure out why this is =
happening ,while building kernel on x86 with $make install and after reboot=
 i am able to get the new kernel but the same doesnt seems to be working on=
 my hardware.
How i should do that??Kindly suggest.

Thanks
________________________________
From: Alistair Francis <alistair23@gmail.com>
Sent: Thursday, July 23, 2020 6:07 AM
To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Subject: Re: Replacing existing kernel with new on qemuriscv64

On Mon, Jul 20, 2020 at 10:31 PM Pankaj Vinadrao Joshi
<Pankaj.VJ@exaleapsemi.com> wrote:
>
> Hi,
> i will explain what i mean is, i am using sifive's u540 hardware for whic=
h we have built our own custom kernel using openembedded-core lets say 5.5.=
6 and now i want to build the other kernel lets say 5.7, natively

Natively for which platform? You want to do build a new kernel on the
hardware and then boot into that? The kernel's are kept in a boot
partition, you should just have to copy them to that location.

> and replace the old kernel with new one,and for this i really did not und=
erstood where and what exactly i should modify to boot from the new kernel?=
?

Yep, just replace the old one.

>
> The steps what i followed are following
>
> 1) i have cloned the kernel source
> 2)make menuconfig
> 3)make -j4
> 4)make modules_install
> 5make install

make install is probably not going to understand what to do. I think
you will need to manually do this. I can't remember where the
partition is, but it should be easy to find.

Alistair

>
> Hope now its clear what i was trying to ask for??
>
> Thanks & regards
> Pankaj
>
>
>
> ________________________________
> From: Alistair Francis <alistair23@gmail.com>
> Sent: Tuesday, July 21, 2020 12:10 AM
> To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
> Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Subject: Re: Replacing existing kernel with new on qemuriscv64
>
> On Mon, Jul 20, 2020 at 11:19 AM Pankaj Vinadrao Joshi
> <Pankaj.VJ@exaleapsemi.com> wrote:
> >
> > Hi Alistair Francis,
> >
> > Thanks for your response.I have same concern for other riscv hardware w=
ith custom kernel will same be applicable for it?If no from where i should =
change my kernel image since there also i am not able to find grub and the =
clarification given on web are seems to be very specific to x86 arch where =
i should look in case of riscv ??
>
> Hello,
>
> I'm not really sure what you are asking.
>
> The way to update the kernel will depend on how you are booting it and
> where it is stored. GRUB supports RISC-V, but as there is no UEFI
> support in the kernel (yet) it probably isn't the best boot method.
> Most hardware will probably use u-boot instead.
>
> Alistair
>
> >
> > Thanks
> >
> > ________________________________
> > From: Alistair Francis <alistair23@gmail.com>
> > Sent: Monday, July 20, 2020 10:29 PM
> > To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
> > Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> > Subject: Re: Replacing existing kernel with new on qemuriscv64
> >
> > On Mon, Jul 20, 2020 at 2:46 AM Pankaj Vinadrao Joshi
> > <Pankaj.VJ@exaleapsemi.com> wrote:
> > >
> > > Hi ,
> > > I am trying to replace my existing kernel image which is 5.5.6 to 5.5=
.7 on qemuriscv64 i would like to mention i have built my qemu image with o=
penembedded-core.
> > >
> > > i have tried to build the kernel 5.5.7 natively,i was able to build t=
he kernel successfully and in my /boot folder i am able to see vmlinux-5.5.=
7  but now i want to install this image..i have tried to do it by make inst=
all i didnt got any error with it but when i rebooted my system i am gettin=
g
> > >
> > > i have followed the following steps to build kernel
> > > $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel#  make menuconfig ar=
ch=3Driscv64
> > > $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make -j4
> > > $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make modules_instal=
l
> > > $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make install
> > > sh ./arch/riscv/boot/install.sh 5.5.7 \
> > > arch/riscv/boot/Image System.map "/boot"
> > > Installing normal kernel
> > >
> > > $reboot
> > > 13024.451157] printk: systemd-shutdow: 37 output lines suppressed due=
 to ratelimiting
> > > [13024.527282] systemd-shutdown[1]: Syncing filesystems and block dev=
ices.
> > > [13024.668538] systemd-shutdown[1]: Sending SIGTERM to remaining proc=
esses...
> > > [13024.719496] systemd-journald[87]: Received SIGTERM from PID 1 (sys=
temd-shutdow).
> > > [13024.769405] systemd-shutdown[1]: Sending SIGKILL to remaining proc=
esses...
> > > [13024.834318] systemd-shutdown[1]: Unmounting file systems.
> > > [13024.868285] [13413]: Remounting '/' read-only in with options '(nu=
ll)'.
> > > [13025.228499] EXT4-fs (vda): re-mounted. Opts: (null)
> > > [13025.358123] systemd-shutdown[1]: All filesystems unmounted.
> > > [13025.358576] systemd-shutdown[1]: Deactivating swaps.
> > > [13025.361264] systemd-shutdown[1]: All swaps deactivated.
> > > [13025.361727] systemd-shutdown[1]: Detaching loop devices.
> > > [13025.420602] systemd-shutdown[1]: All loop devices detached.
> > > [13025.421071] systemd-shutdown[1]: Detaching DM devices.
> > > [13025.595237] reboot: Restarting system
> > > [13046.599875] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > > [13046.600329] (detected by 0, t=3D5252 jiffies, g=3D2837145, q=3D17)
> > > [13046.600763] rcu: All QSes seen, last rcu_sched kthread activity 52=
52 (4298153942-4298148690), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
> > > [13046.601503] systemd-shutdow R  running task        0     1      0 =
0x00000008
> > > [13046.602053] Call Trace:
> > > [13046.602562] [<ffffffe00006d3fc>] walk_stackframe+0x0/0xa4
> > > [13046.602890] [<ffffffe00006d5e2>] show_stack+0x2a/0x34
> > > [13046.603156] [<ffffffe000091094>] sched_show_task+0x158/0x174
> > > [13046.603442] [<ffffffe0000c4dde>] rcu_sched_clock_irq+0x6b2/0x6ec
> > > [13046.603740] [<ffffffe0000ccadc>] update_process_times+0x1e/0x44
> > > [13046.604009] [<ffffffe0000d79dc>] tick_sched_handle.isra.16+0x30/0x=
3e
> > > [13046.604331] [<ffffffe0000d7a38>] tick_sched_timer+0x4e/0x94
> > > [13046.604620] [<ffffffe0000cd44a>] __hrtimer_run_queues+0x10c/0x2de
> > > [13046.604928] [<ffffffe0000cdc96>] hrtimer_interrupt+0xcc/0x1d6
> > > [13046.605236] [<ffffffe0005d3f7c>] riscv_timer_interrupt+0x32/0x3a
> > > [13046.605580] [<ffffffe0007889ce>] do_IRQ+0xae/0xba
> > > [13046.605837] [<ffffffe00006bd3c>] ret_from_exception+0x0/0xc
> > > [13046.606127] [<ffffffe00006ca58>] machine_restart+0xc/0xe
> > > [13046.606508] rcu: rcu_sched kthread starved for 5252 jiffies! g2837=
145 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
> > > [13046.606990] rcu: RCU grace-period kthread stack dump:
> > > [13046.607257] rcu_sched       R  running task        0    10      2 =
0x00000000
> > > [13046.607610] Call Trace:
> > > [13046.607774] [<ffffffe000784258>] __schedule+0x1a8/0x482
> > > [13046.608044] [<ffffffe000784592>] schedule+0x60/0xda
> > > [13046.608304] [<ffffffe000787a56>] schedule_timeout+0x15c/0x2b2
> > > [13046.608602] [<ffffffe0000c2ec8>] rcu_gp_kthread+0x4cc/0x7ec
> > > [13046.608889] [<ffffffe00008b0f2>] kthread+0xf0/0x102
> > > [13046.609162] [<ffffffe00006bd3c>] ret_from_exception+0x0/0xc
> > >
> > > ..... so on getting continuously......
> > >
> > >
> > > Can someone help me out how i can replace my kernel to 5.5.7 since i =
am not able to find grub or grub2 on my riscv platform?? i have googled for=
 the solution but most of them seems to be x86 specific where they are tryi=
ng to change the grub??Where i should modify for riscv to get my kernel up?=
???
> >
> > You won't be able to install a new kernel from the QEMU guest. You
> > will need to use OpenEmbedded to build a new kernel and boot that.
> >
> > Alistair
> >
> > >
> > >
> > > Thanks
> > [EXT]
> [EXT]
[EXT]

--_000_BMXPR01MB23448730F4DA9C023315C3FAEE760BMXPR01MB2344INDP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
yes am building it natively for riscv (sifive's u540 hardware ) and in /boo=
t&nbsp; i am able to find&nbsp;System.map-5.7.2 and&nbsp;<span>vmlinux-5.7.=
2<br>
</span><span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
root@exaleapsemi:~/linux-stable# <b>make install</b><br>
<div>make: Warning: File '.vmlinux.cmd' has modification time 1221719 s in =
the future<br>
</div>
<div>make[1]: Warning: File 'arch/riscv/boot/.Image.cmd' has modification t=
ime 1221720 s in the future<br>
</div>
<div>sh ./arch/riscv/boot/install.sh 5.7.2 \<br>
</div>
<div>arch/riscv/boot/Image System.map &quot;/boot&quot;<br>
</div>
<div>Installing normal kernel<br>
</div>
<div><br>
</div>
<div>But now i want to boot with this kernel but i am not able to do so..it=
s booting from the earlier kernel only..i am not able to figure out why thi=
s is happening ,while building kernel on x86 with $make install and after r=
eboot i am able to get the new kernel
 but the same doesnt seems to be working on my hardware.</div>
<div>How i should do that??Kindly suggest.</div>
<div><br>
</div>
<div>Thanks</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alistair Francis &lt;=
alistair23@gmail.com&gt;<br>
<b>Sent:</b> Thursday, July 23, 2020 6:07 AM<br>
<b>To:</b> Pankaj Vinadrao Joshi &lt;Pankaj.VJ@exaleapsemi.com&gt;<br>
<b>Subject:</b> Re: Replacing existing kernel with new on qemuriscv64</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, Jul 20, 2020 at 10:31 PM Pankaj Vinadrao J=
oshi<br>
&lt;Pankaj.VJ@exaleapsemi.com&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt; i will explain what i mean is, i am using sifive's u540 hardware for w=
hich we have built our own custom kernel using openembedded-core lets say 5=
.5.6 and now i want to build the other kernel lets say 5.7, natively<br>
<br>
Natively for which platform? You want to do build a new kernel on the<br>
hardware and then boot into that? The kernel's are kept in a boot<br>
partition, you should just have to copy them to that location.<br>
<br>
&gt; and replace the old kernel with new one,and for this i really did not =
understood where and what exactly i should modify to boot from the new kern=
el??<br>
<br>
Yep, just replace the old one.<br>
<br>
&gt;<br>
&gt; The steps what i followed are following<br>
&gt;<br>
&gt; 1) i have cloned the kernel source<br>
&gt; 2)make menuconfig<br>
&gt; 3)make -j4<br>
&gt; 4)make modules_install<br>
&gt; 5make install<br>
<br>
make install is probably not going to understand what to do. I think<br>
you will need to manually do this. I can't remember where the<br>
partition is, but it should be easy to find.<br>
<br>
Alistair<br>
<br>
&gt;<br>
&gt; Hope now its clear what i was trying to ask for??<br>
&gt;<br>
&gt; Thanks &amp; regards<br>
&gt; Pankaj<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: Alistair Francis &lt;alistair23@gmail.com&gt;<br>
&gt; Sent: Tuesday, July 21, 2020 12:10 AM<br>
&gt; To: Pankaj Vinadrao Joshi &lt;Pankaj.VJ@exaleapsemi.com&gt;<br>
&gt; Cc: qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
&gt; Subject: Re: Replacing existing kernel with new on qemuriscv64<br>
&gt;<br>
&gt; On Mon, Jul 20, 2020 at 11:19 AM Pankaj Vinadrao Joshi<br>
&gt; &lt;Pankaj.VJ@exaleapsemi.com&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi Alistair Francis,<br>
&gt; &gt;<br>
&gt; &gt; Thanks for your response.I have same concern for other riscv hard=
ware with custom kernel will same be applicable for it?If no from where i s=
hould change my kernel image since there also i am not able to find grub an=
d the clarification given on web are seems
 to be very specific to x86 arch where i should look in case of riscv ??<br=
>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; I'm not really sure what you are asking.<br>
&gt;<br>
&gt; The way to update the kernel will depend on how you are booting it and=
<br>
&gt; where it is stored. GRUB supports RISC-V, but as there is no UEFI<br>
&gt; support in the kernel (yet) it probably isn't the best boot method.<br=
>
&gt; Most hardware will probably use u-boot instead.<br>
&gt;<br>
&gt; Alistair<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt;<br>
&gt; &gt; ________________________________<br>
&gt; &gt; From: Alistair Francis &lt;alistair23@gmail.com&gt;<br>
&gt; &gt; Sent: Monday, July 20, 2020 10:29 PM<br>
&gt; &gt; To: Pankaj Vinadrao Joshi &lt;Pankaj.VJ@exaleapsemi.com&gt;<br>
&gt; &gt; Cc: qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
&gt; &gt; Subject: Re: Replacing existing kernel with new on qemuriscv64<br=
>
&gt; &gt;<br>
&gt; &gt; On Mon, Jul 20, 2020 at 2:46 AM Pankaj Vinadrao Joshi<br>
&gt; &gt; &lt;Pankaj.VJ@exaleapsemi.com&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi ,<br>
&gt; &gt; &gt; I am trying to replace my existing kernel image which is 5.5=
.6 to 5.5.7 on qemuriscv64 i would like to mention i have built my qemu ima=
ge with openembedded-core.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; i have tried to build the kernel 5.5.7 natively,i was able t=
o build the kernel successfully and in my /boot folder i am able to see vml=
inux-5.5.7&nbsp; but now i want to install this image..i have tried to do i=
t by make install i didnt got any error with it
 but when i rebooted my system i am getting<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; i have followed the following steps to build kernel<br>
&gt; &gt; &gt; $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel#&nbsp; make=
 menuconfig arch=3Driscv64<br>
&gt; &gt; &gt; $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make -j4<b=
r>
&gt; &gt; &gt; $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make modul=
es_install<br>
&gt; &gt; &gt; $root@qemuriscv64-exaleapsemi-r2:/usr/src/kernel# make insta=
ll<br>
&gt; &gt; &gt; sh ./arch/riscv/boot/install.sh 5.5.7 \<br>
&gt; &gt; &gt; arch/riscv/boot/Image System.map &quot;/boot&quot;<br>
&gt; &gt; &gt; Installing normal kernel<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; $reboot<br>
&gt; &gt; &gt; 13024.451157] printk: systemd-shutdow: 37 output lines suppr=
essed due to ratelimiting<br>
&gt; &gt; &gt; [13024.527282] systemd-shutdown[1]: Syncing filesystems and =
block devices.<br>
&gt; &gt; &gt; [13024.668538] systemd-shutdown[1]: Sending SIGTERM to remai=
ning processes...<br>
&gt; &gt; &gt; [13024.719496] systemd-journald[87]: Received SIGTERM from P=
ID 1 (systemd-shutdow).<br>
&gt; &gt; &gt; [13024.769405] systemd-shutdown[1]: Sending SIGKILL to remai=
ning processes...<br>
&gt; &gt; &gt; [13024.834318] systemd-shutdown[1]: Unmounting file systems.=
<br>
&gt; &gt; &gt; [13024.868285] [13413]: Remounting '/' read-only in with opt=
ions '(null)'.<br>
&gt; &gt; &gt; [13025.228499] EXT4-fs (vda): re-mounted. Opts: (null)<br>
&gt; &gt; &gt; [13025.358123] systemd-shutdown[1]: All filesystems unmounte=
d.<br>
&gt; &gt; &gt; [13025.358576] systemd-shutdown[1]: Deactivating swaps.<br>
&gt; &gt; &gt; [13025.361264] systemd-shutdown[1]: All swaps deactivated.<b=
r>
&gt; &gt; &gt; [13025.361727] systemd-shutdown[1]: Detaching loop devices.<=
br>
&gt; &gt; &gt; [13025.420602] systemd-shutdown[1]: All loop devices detache=
d.<br>
&gt; &gt; &gt; [13025.421071] systemd-shutdown[1]: Detaching DM devices.<br=
>
&gt; &gt; &gt; [13025.595237] reboot: Restarting system<br>
&gt; &gt; &gt; [13046.599875] rcu: INFO: rcu_sched detected stalls on CPUs/=
tasks:<br>
&gt; &gt; &gt; [13046.600329] (detected by 0, t=3D5252 jiffies, g=3D2837145=
, q=3D17)<br>
&gt; &gt; &gt; [13046.600763] rcu: All QSes seen, last rcu_sched kthread ac=
tivity 5252 (4298153942-4298148690), jiffies_till_next_fqs=3D1, root -&gt;q=
smask 0x0<br>
&gt; &gt; &gt; [13046.601503] systemd-shutdow R&nbsp; running task&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0 0x00000008<br>
&gt; &gt; &gt; [13046.602053] Call Trace:<br>
&gt; &gt; &gt; [13046.602562] [&lt;ffffffe00006d3fc&gt;] walk_stackframe+0x=
0/0xa4<br>
&gt; &gt; &gt; [13046.602890] [&lt;ffffffe00006d5e2&gt;] show_stack+0x2a/0x=
34<br>
&gt; &gt; &gt; [13046.603156] [&lt;ffffffe000091094&gt;] sched_show_task+0x=
158/0x174<br>
&gt; &gt; &gt; [13046.603442] [&lt;ffffffe0000c4dde&gt;] rcu_sched_clock_ir=
q+0x6b2/0x6ec<br>
&gt; &gt; &gt; [13046.603740] [&lt;ffffffe0000ccadc&gt;] update_process_tim=
es+0x1e/0x44<br>
&gt; &gt; &gt; [13046.604009] [&lt;ffffffe0000d79dc&gt;] tick_sched_handle.=
isra.16+0x30/0x3e<br>
&gt; &gt; &gt; [13046.604331] [&lt;ffffffe0000d7a38&gt;] tick_sched_timer+0=
x4e/0x94<br>
&gt; &gt; &gt; [13046.604620] [&lt;ffffffe0000cd44a&gt;] __hrtimer_run_queu=
es+0x10c/0x2de<br>
&gt; &gt; &gt; [13046.604928] [&lt;ffffffe0000cdc96&gt;] hrtimer_interrupt+=
0xcc/0x1d6<br>
&gt; &gt; &gt; [13046.605236] [&lt;ffffffe0005d3f7c&gt;] riscv_timer_interr=
upt+0x32/0x3a<br>
&gt; &gt; &gt; [13046.605580] [&lt;ffffffe0007889ce&gt;] do_IRQ+0xae/0xba<b=
r>
&gt; &gt; &gt; [13046.605837] [&lt;ffffffe00006bd3c&gt;] ret_from_exception=
+0x0/0xc<br>
&gt; &gt; &gt; [13046.606127] [&lt;ffffffe00006ca58&gt;] machine_restart+0x=
c/0xe<br>
&gt; &gt; &gt; [13046.606508] rcu: rcu_sched kthread starved for 5252 jiffi=
es! g2837145 f0x2 RCU_GP_WAIT_FQS(5) -&gt;state=3D0x0 -&gt;cpu=3D0<br>
&gt; &gt; &gt; [13046.606990] rcu: RCU grace-period kthread stack dump:<br>
&gt; &gt; &gt; [13046.607257] rcu_sched&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 R&nbsp; running task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbs=
p;&nbsp; 10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 0x00000000<br>
&gt; &gt; &gt; [13046.607610] Call Trace:<br>
&gt; &gt; &gt; [13046.607774] [&lt;ffffffe000784258&gt;] __schedule+0x1a8/0=
x482<br>
&gt; &gt; &gt; [13046.608044] [&lt;ffffffe000784592&gt;] schedule+0x60/0xda=
<br>
&gt; &gt; &gt; [13046.608304] [&lt;ffffffe000787a56&gt;] schedule_timeout+0=
x15c/0x2b2<br>
&gt; &gt; &gt; [13046.608602] [&lt;ffffffe0000c2ec8&gt;] rcu_gp_kthread+0x4=
cc/0x7ec<br>
&gt; &gt; &gt; [13046.608889] [&lt;ffffffe00008b0f2&gt;] kthread+0xf0/0x102=
<br>
&gt; &gt; &gt; [13046.609162] [&lt;ffffffe00006bd3c&gt;] ret_from_exception=
+0x0/0xc<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; ..... so on getting continuously......<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Can someone help me out how i can replace my kernel to 5.5.7=
 since i am not able to find grub or grub2 on my riscv platform?? i have go=
ogled for the solution but most of them seems to be x86 specific where they=
 are trying to change the grub??Where i should
 modify for riscv to get my kernel up????<br>
&gt; &gt;<br>
&gt; &gt; You won't be able to install a new kernel from the QEMU guest. Yo=
u<br>
&gt; &gt; will need to use OpenEmbedded to build a new kernel and boot that=
.<br>
&gt; &gt;<br>
&gt; &gt; Alistair<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks<br>
&gt; &gt; [EXT]<br>
&gt; [EXT]<br>
[EXT]<br>
</div>
</span></font></div>
</body>
</html>

--_000_BMXPR01MB23448730F4DA9C023315C3FAEE760BMXPR01MB2344INDP_--

