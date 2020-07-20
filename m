Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0997CC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 00:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B423D2080D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 00:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWJJseDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B423D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxgXE-0001l8-1W
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 20:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pratkpranav@gmail.com>)
 id 1jxfII-0004Zh-KC
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 19:34:02 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c]:34529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pratkpranav@gmail.com>)
 id 1jxfIG-0003cJ-GC
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 19:34:02 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id v26so3560239ood.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 16:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=UARNb/Mr6PDgMeauSWXNzkt5oMkBklijh14RriYkV2I=;
 b=uWJJseDSY90fB/ow1GDGXDnaONhfKMhaKUzUleynLirb7tNv+DfbOqnH7gRIp59akH
 ZGi8zJYfIwkGb/u7LbI8UEXNr8XYR9Wa3ZB9888dHbrT+iw08vwQJgYgvgPIgVsYhgtA
 1hOgzkLsSr6Z9GJoIAiDiRZV7B+BpNQvMIv7uljaPcXXgx7J3jO3Wvd5qV7TD+nklI69
 52vh1Yc3AZQe9Uj39VHVIOltOAgl/wuTthuJMBh26N9RaL6iifsxBYVbtyYctHBCvENO
 z0rQwY0uCIK57jtDM3F2A3QDTXO5SKLfgwhB8EGOj1kCbDSeyACbu6g5c9wwjhOznQAP
 2oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=UARNb/Mr6PDgMeauSWXNzkt5oMkBklijh14RriYkV2I=;
 b=qLP+oWrvllRpJYPdy+m6gLkbXPoPFl5oGZOCjAy6orA87rg5rcUbkZK96Sznp2ijp1
 42JG1HDaVmMq68a2DGZau9xsrCWesEscFpd+v3sGHd88JbsCqHZV0N+ZvLL33tUMFONl
 qmJBVaErqT/YX/5SZKj/kYoXQGRVkRrPIYZJzBEtXUifa7bjb6TyPFmEdUD6CmP6qY6D
 xpgxR7zSC84AJp3c8xs/Jd9kzF9iaXQ4LHGAiTR0uEtrZ74DXkQ5uCze/JiRaxyuO0tM
 zW//laYdd85J+gtQvGFW2IOz4DOgT9hcem2X2oPskdM/dsYouiu0FnUaPyD6UulBJH+Y
 cXTw==
X-Gm-Message-State: AOAM532vmJoOvsx7Jm2c1riHRCW/tbb3E/jewfMmJlpsNsnX/JCpIqni
 r/xyrqdKsucY1LjeCpKP8RGht7EKnlSWxWu0PVgIL2qoke8=
X-Google-Smtp-Source: ABdhPJyAq4Pad9E9gh51unV28Iwum38XnrMv+gVXjwNdVOAFkp2nsFpRWSuIo/cpR5UPAFr5jg/SMEZU1Ik0VMltn7k=
X-Received: by 2002:a4a:c903:: with SMTP id v3mr21800499ooq.32.1595288038341; 
 Mon, 20 Jul 2020 16:33:58 -0700 (PDT)
MIME-Version: 1.0
From: Pratik Pranav <pratkpranav@gmail.com>
Date: Tue, 21 Jul 2020 05:03:20 +0530
Message-ID: <CA+qpawBshnNYNYopazRjnjdcN4mfWCA7ur0b6vbJjJtG_Z3NPw@mail.gmail.com>
Subject: Problem with ivshmem doobell interrupt
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d6ffe305aae7f098"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=pratkpranav@gmail.com; helo=mail-oo1-xc2c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jul 2020 20:52:33 -0400
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

--000000000000d6ffe305aae7f098
Content-Type: text/plain; charset="UTF-8"

Hi,

My name is Pratik Pranav,  a second-year undergraduate student,
majoring in Computer
Science at Indian Institute of Technology(IIT), Delhi. I am currently
working on building a messaging layer between two VMs(x86 and ARM) using
ivshmem(rev 1) and currently deploying on QEMU.


I am facing a problem while registering an interrupt in doorbell registers.
Whenever I am registering an interrupt on doorbell-registers, I can see the
interrupt handler run when the interrupt is registered from ARM to x86, but
not from x86 to ARM. Although I think interrupts are reaching the ARM VM
concluded from the following output obtained by changing IVSHMEM_DEBUG to 1
in ivshmem.c.


-------------------------------------------------------------

IVSHMEM: interrupt on vector 0x56430d1ce940 3

IVSHMEM: interrupt on vector 0x56430d1ce940 2

IVSHMEM: interrupt on vector 0x56430d1ce940 1

IVSHMEM: interrupt on vector 0x56430d1ce940 0

-------------------------------------------------------------


All the interrupt lines are visible in /proc/interrupts in both the VMs
with MSIX enabled.


I am adding the sample code on which I am working right now. Its a simple
code just for checking whether interrupts work.


The command prompts I am using currently are:


x86: sudo qemu/x86_64-softmmu/qemu-system-x86_64 *--enable-kvm* -m 2048
-smp 4 *-chardev socket,path=/tmp/ivshmem_socket,id=foo -device
ivshmem-doorbell,chardev=foo,vectors=4* -hda x86.img -netdev
tap,id=x86nic,ifname=tap0 -device e1000,netdev=x86nic,mac=52:54:00:12:34:60
-nographic


arm: sudo qemu/aarch64-softmmu/qemu-system-aarch64 -cpu cortex-a57
-smp 2 *-chardev
socket,path=/tmp/ivshmem_socket,id=foo -device
ivshmem-doorbell,chardev=foo,vectors=4*  -m 2048 -M virt -bios qemu_efi.fd
-drive if=none,file=arm.img,id=hd0 -device virtio-blk-device,drive=hd0
-netdev tap,id=armnic,ifname=tap1 -device
e1000,netdev=armnic,mac=52:54:00:12:34:63 -nographic


Could you suggest anything?

I will be highly thankful to you.


Thank you for your consideration.

Keenly awaiting your reply,

Yours Sincerely,

Pratik Pranav

Second-Year Undergraduate

Computer Science and Technology

Indian Institute of Technology(IIT), Delhi


[image: photo]
Pratik Pranav
Student, Computer Science and Engineering at  Indian Institute of
Technology, Delhi
A  Satpura Hostel, IIT Delhi, Hauz Khas, New Delhi-110016
M  8936051771  <8936051771>
E  cs1180368@cse.iitd.ac.in  <cs1180368@cse.iitd.ac.in>
<http://www.linkedin.com/in/pratik-pranav-92629616b/>

--000000000000d6ffe305aae7f098
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><p style=3D"background:transparent;color:rgb(14,16,26=
);margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transparent;m=
argin-top:0pt;margin-bottom:0pt">Hi,</span></p><p style=3D"background:trans=
parent;color:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><span style=3D=
"background:transparent;margin-top:0pt;margin-bottom:0pt">My name is Pratik=
 Pranav,=C2=A0<span style=3D"background:transparent;margin-top:0pt;margin-b=
ottom:0pt">=C2=A0a second-year undergraduate student, majoring in</span><st=
rong style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt"><spa=
n style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">=C2=A0<=
/span></strong>Computer Science at Indian Institute of Technology(IIT), Del=
hi.</span><strong style=3D"background:transparent;margin-top:0pt;margin-bot=
tom:0pt"><span style=3D"background:transparent;margin-top:0pt;margin-bottom=
:0pt">=C2=A0</span></strong><span style=3D"background:transparent;margin-to=
p:0pt;margin-bottom:0pt">I am currently working on building a messaging lay=
er between two VMs(x86 and ARM) using ivshmem(rev 1) and currently deployin=
g on QEMU.=C2=A0</span></p><p style=3D"background:transparent;color:rgb(14,=
16,26);margin-top:0pt;margin-bottom:0pt"><br></p><p style=3D"background:tra=
nsparent;color:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><span style=
=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">I am facing a =
problem while registering an interrupt in doorbell registers. Whenever I am=
 registering an interrupt on doorbell-registers, I can see the interrupt ha=
ndler run when the interrupt is registered from ARM to x86, but not from x8=
6 to ARM. Although I think interrupts are reaching the ARM VM concluded fro=
m the following output obtained by changing IVSHMEM_DEBUG to 1 in ivshmem.c=
.</span></p><p style=3D"background:transparent;color:rgb(14,16,26);margin-t=
op:0pt;margin-bottom:0pt"><br></p><p style=3D"background:transparent;color:=
rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><span style=3D"background:t=
ransparent;margin-top:0pt;margin-bottom:0pt">------------------------------=
-------------------------------</span></p><p style=3D"background:transparen=
t;color:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><span style=3D"back=
ground:transparent;margin-top:0pt;margin-bottom:0pt">IVSHMEM: interrupt on =
vector 0x56430d1ce940 3</span></p><p style=3D"background:transparent;color:=
rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><span style=3D"background:t=
ransparent;margin-top:0pt;margin-bottom:0pt">IVSHMEM: interrupt on vector 0=
x56430d1ce940 2</span></p><p style=3D"background:transparent;color:rgb(14,1=
6,26);margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transpare=
nt;margin-top:0pt;margin-bottom:0pt">IVSHMEM: interrupt on vector 0x56430d1=
ce940 1</span></p><p style=3D"background:transparent;color:rgb(14,16,26);ma=
rgin-top:0pt;margin-bottom:0pt"><span style=3D"background:transparent;margi=
n-top:0pt;margin-bottom:0pt">IVSHMEM: interrupt on vector 0x56430d1ce940 0<=
/span></p><p style=3D"background:transparent;color:rgb(14,16,26);margin-top=
:0pt;margin-bottom:0pt"><span style=3D"background:transparent;margin-top:0p=
t;margin-bottom:0pt">------------------------------------------------------=
-------</span></p><p style=3D"background:transparent;color:rgb(14,16,26);ma=
rgin-top:0pt;margin-bottom:0pt"><br></p><p style=3D"background:transparent;=
color:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt">All the interrupt lin=
es are visible in /proc/interrupts in both the VMs with MSIX enabled.<br></=
p><p style=3D"background:transparent;color:rgb(14,16,26);margin-top:0pt;mar=
gin-bottom:0pt"><br></p><p style=3D"background:transparent;color:rgb(14,16,=
26);margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transparent=
;margin-top:0pt;margin-bottom:0pt">I am adding the sample code on which I a=
m working right now. Its a simple code just for checking whether interrupts=
 work.</span></p><p style=3D"background:transparent;color:rgb(14,16,26);mar=
gin-top:0pt;margin-bottom:0pt"><br></p><p style=3D"background:transparent;c=
olor:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><span style=3D"backgro=
und:transparent;margin-top:0pt;margin-bottom:0pt">The command prompts I am =
using currently are:</span></p><p style=3D"background:transparent;color:rgb=
(14,16,26);margin-top:0pt;margin-bottom:0pt"><br></p><p style=3D"background=
:transparent;color:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><span st=
yle=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">x86: sudo q=
emu/x86_64-softmmu/qemu-system-x86_64=C2=A0</span><strong style=3D"backgrou=
nd:transparent;margin-top:0pt;margin-bottom:0pt"><span style=3D"background:=
transparent;margin-top:0pt;margin-bottom:0pt">--enable-kvm</span></strong><=
span style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">=C2=
=A0-m 2048 -smp 4=C2=A0</span><strong style=3D"background:transparent;margi=
n-top:0pt;margin-bottom:0pt"><span style=3D"background:transparent;margin-t=
op:0pt;margin-bottom:0pt">-chardev socket,path=3D/tmp/ivshmem_socket,id=3Df=
oo -device ivshmem-doorbell,chardev=3Dfoo,vectors=3D4</span></strong><span =
style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">=C2=A0-hd=
a x86.img -netdev tap,id=3Dx86nic,ifname=3Dtap0 -device e1000,netdev=3Dx86n=
ic,mac=3D52:54:00:12:34:60 -nographic</span></p><p style=3D"background:tran=
sparent;color:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><br></p><p st=
yle=3D"background:transparent;color:rgb(14,16,26);margin-top:0pt;margin-bot=
tom:0pt"><span style=3D"background:transparent;margin-top:0pt;margin-bottom=
:0pt">arm: sudo qemu/aarch64-softmmu/qemu-system-aarch64 -cpu cortex-a57 -s=
mp 2=C2=A0</span><strong style=3D"background:transparent;margin-top:0pt;mar=
gin-bottom:0pt"><span style=3D"background:transparent;margin-top:0pt;margin=
-bottom:0pt">-chardev socket,path=3D/tmp/ivshmem_socket,id=3Dfoo -device iv=
shmem-doorbell,chardev=3Dfoo,vectors=3D4</span></strong><span style=3D"back=
ground:transparent;margin-top:0pt;margin-bottom:0pt">=C2=A0=C2=A0-m 2048 -M=
 virt -bios qemu_efi.fd -drive if=3Dnone,file=3Darm.img,id=3Dhd0 -device vi=
rtio-blk-device,drive=3Dhd0 -netdev tap,id=3Darmnic,ifname=3Dtap1 -device e=
1000,netdev=3Darmnic,mac=3D52:54:00:12:34:63 -nographic=C2=A0=C2=A0</span><=
/p><p style=3D"background:transparent;color:rgb(14,16,26);margin-top:0pt;ma=
rgin-bottom:0pt"><br></p><p style=3D"background:transparent;color:rgb(14,16=
,26);margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transparen=
t;margin-top:0pt;margin-bottom:0pt">Could you suggest anything?=C2=A0</span=
></p><p style=3D"background:transparent;color:rgb(14,16,26);margin-top:0pt;=
margin-bottom:0pt"><span style=3D"background:transparent;margin-top:0pt;mar=
gin-bottom:0pt">I will be highly thankful to you.</span></p><p style=3D"bac=
kground:transparent;color:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><=
br></p><p style=3D"background:transparent;color:rgb(14,16,26);margin-top:0p=
t;margin-bottom:0pt"><span style=3D"background:transparent;margin-top:0pt;m=
argin-bottom:0pt">Thank you for your consideration.</span></p><p style=3D"b=
ackground:transparent;color:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"=
><span style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">Ke=
enly awaiting your reply,</span></p><p style=3D"background:transparent;colo=
r:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><span style=3D"background=
:transparent;margin-top:0pt;margin-bottom:0pt">Yours Sincerely,</span></p><=
p style=3D"background:transparent;color:rgb(14,16,26);margin-top:0pt;margin=
-bottom:0pt"><span style=3D"background:transparent;margin-top:0pt;margin-bo=
ttom:0pt">Pratik Pranav</span></p><p style=3D"background:transparent;color:=
rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><span style=3D"background:t=
ransparent;margin-top:0pt;margin-bottom:0pt">Second-Year Undergraduate</spa=
n></p><p style=3D"background:transparent;color:rgb(14,16,26);margin-top:0pt=
;margin-bottom:0pt"><span style=3D"background:transparent;margin-top:0pt;ma=
rgin-bottom:0pt">Computer Science and Technology</span></p><p style=3D"back=
ground:transparent;color:rgb(14,16,26);margin-top:0pt;margin-bottom:0pt"><s=
pan style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">India=
n Institute of Technology(IIT), Delhi</span></p></div><div><br></div><br cl=
ear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div><table style=3D"max-width:600px;=
direction:ltr">
			<tbody><tr><td>=20
			 <table style=3D"max-width:440px;padding-bottom:10px;margin-bottom:8px" =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0"> <tbody><tr> <td> <table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" style=3D"display:inline-fle=
x"> <tbody><tr> <td valign=3D"top" style=3D"vertical-align:top"> <table bor=
der=3D"0" cellpadding=3D"0" cellspacing=3D"0"> <tbody><tr> <td> <img src=3D=
"https://d36urhup7zbd7q.cloudfront.net/be596108-86aa-4cbd-8344-fb168a5004e4=
/IMG_20191006_132415.format_png.resize_200x.jpeg#logo" alt=3D"photo" width=
=3D"96" height=3D"110" style=3D"vertical-align:initial;border-radius:4px;ma=
x-width:120px"> </td> </tr> </tbody></table> </td> <td valign=3D"top" style=
=3D"vertical-align:top;padding-left:12px"> <table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0"> <tbody><tr> <td style=3D"padding-bottom:7px"> <ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" width=3D"100%" style=
=3D"line-height:1.6;font-family:sans-serif;font-size:11px;color:rgb(78,75,7=
6);padding-left:2px;font-weight:normal;width:100%"> <tbody><tr> <td> <span =
style=3D"font-family:sans-serif;color:rgb(69,102,142);padding:0px;margin:0p=
x;font-size:12px;font-weight:bold">Pratik Pranav</span><br> <span style=3D"=
color:rgb(69,102,142);font-family:sans-serif;font-size:12px">Student, Compu=
ter Science and Engineering </span> <span style=3D"color:rgb(69,102,142);fo=
nt-family:sans-serif;font-size:12px">at=C2=A0 </span><span style=3D"color:r=
gb(69,102,142);font-family:sans-serif;font-size:12px">Indian Institute of T=
echnology, Delhi</span> </td> </tr> </tbody></table> </td> </tr> <tr> <td s=
tyle=3D"border-top:5px solid rgb(69,102,142);line-height:0px">  </td> </tr>=
 <tr> <td style=3D"padding-bottom:7px;padding-top:5px;width:328px" width=3D=
"328"> <table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" width=3D"100=
%" style=3D"line-height:1.6;font-family:sans-serif;font-size:11px;color:rgb=
(78,75,76);padding-left:2px;font-weight:normal;width:100%"> <tbody><tr> <td=
> <span style=3D"color:rgb(69,102,142);font-family:sans-serif;font-weight:b=
old;font-size:12px">A=C2=A0</span> <span style=3D"font-size:12px;font-famil=
y:arial,serif"> Satpura Hostel, IIT Delhi, Hauz Khas, New Delhi-110016</spa=
n> </td> </tr> <tr> <td> <table align=3D"left" border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0"> <tbody><tr> <td>  <span style=3D"display:inline-flex"=
> <span style=3D"color:rgb(69,102,142);font-family:sans-serif;font-weight:b=
old;font-size:12px">M=C2=A0</span> <a href=3D"tel:8936051771" style=3D"text=
-decoration:none;font-family:sans-serif;font-size:12px;color:rgb(78,75,76)"=
 target=3D"_blank"> 8936051771=C2=A0 </a> </span> </td> </tr> </tbody></tab=
le> <table align=3D"left" border=3D"0" cellpadding=3D"0" cellspacing=3D"0">=
 <tbody><tr> <td>  <span style=3D"display:inline-flex"> <span style=3D"colo=
r:rgb(69,102,142);font-family:sans-serif;font-weight:bold;font-size:12px">E=
=C2=A0</span> <a href=3D"mailto:cs1180368@cse.iitd.ac.in" style=3D"text-dec=
oration:none;font-family:sans-serif;font-size:12px;color:rgb(78,75,76)" tar=
get=3D"_blank"> cs1180368@cse.iitd.ac.in=C2=A0 </a> </span> </td> </tr> </t=
body></table> </td> </tr> <tr> <td> </td> </tr> </tbody></table> </td> </tr=
> </tbody></table> </td> </tr> <tr> <td colspan=3D"2"> <table border=3D"0" =
cellpadding=3D"0" cellspacing=3D"0" width=3D"100%" style=3D"line-height:1.6=
;font-family:sans-serif;font-size:11px;color:rgb(78,75,76);padding-left:2px=
;font-weight:bold;width:100%"> <tbody><tr> <td style=3D"padding-top:7px"> <=
table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr style=3D"=
padding-top:10px"><td align=3D"left" style=3D"padding-right:5px;text-align:=
center;padding-top:0px"> <a href=3D"http://www.linkedin.com/in/pratik-prana=
v-92629616b/" target=3D"_blank"><img src=3D"https://cdn.gifo.wisestamp.com/=
social/linkedin/0077b5/16/0.png"></a></td></tr></tbody></table> </td> </tr>=
 </tbody></table> </td> </tr> <tr> <td style=3D"padding-top:6px" colspan=3D=
"2"> </td> </tr> </tbody></table> </td> </tr> </tbody></table> <table cellp=
adding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td></td></tr></tbod=
y></table></td></tr></tbody></table>
		=09
	=09
	</div></div></div></div></div>

--000000000000d6ffe305aae7f098--

