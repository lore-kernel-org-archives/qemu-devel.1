Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D060CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A0D2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Jjf/rmFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A0D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNO6Q-00004x-B5
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 17:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casasfernando@outlook.com>) id 1iNKsi-0006Ca-ME
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casasfernando@outlook.com>) id 1iNKsf-00067a-36
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:57:11 -0400
Received: from mail-oln040092067102.outbound.protection.outlook.com
 ([40.92.67.102]:9707 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casasfernando@outlook.com>)
 id 1iNKse-00066b-5u; Wed, 23 Oct 2019 13:57:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmlsB9f1p6w3Qk0egGpDKIbjAzmp7hEjomArQ1U6SLFE6f4d1eCD9qpr+9r4Jl5ZTTTck47ohfNOVHwGpBikiQ2MCBftrURqES3hKb3b7noq1OQDz1rhOlJT5KHm5U/OJAASXkyS4YPnW52MPAFhbLJPsdSbAhLnuXtS76PTcKLoQewhCpJ0YG7mOBQBMghi4UrF+8Z4pLxEoWZAUzKLqDaWAdfZFKY8c224GzA4bykUS3SgTyM8TeRnNniegYJF+tiQ7DDBuBbl1AdrJjdBvW3SYp2oHUIodhAJKMLMAxdRI7GSAtSBr0FZ05BxgeWsRhWRTybpGFbVlutcX7MIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yruokr1+IX4BhPofyd3yHVweuZYEnCvXEk7019NztJo=;
 b=IMN1jbibynnkGXsUoui2rH5ztV0e+uFzBnOxXoz3J6zMTZv/LTu5VUfIrZvKGlkaqg06N9uf1L/nehaGn8got4zwQJLRqRMWEVmaoOaQxO2Qvl91J/I+mnWicBkJiELm0csIFyKbtWsK8ADGhd8p16i0mKgfqE6EVYNwI8uCqOmpkmqlT8K34lZaupLpr8Dpzc/tMD4Kh5/I9GaGgx/ZjCmR4S9oQJfMRfeWTdKRlBBTbrkQgAFd1z7y04cE050ojsyouNl2i8JV3E9w9iqrdKf5crEQ2EIgduwFOUfdfeWasy7YCJL0uJeJROAGIfhm9DjKjGbQk9vxzbpc7D9Vfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yruokr1+IX4BhPofyd3yHVweuZYEnCvXEk7019NztJo=;
 b=Jjf/rmFr9pEFCS8sIcFQrGqOZp+6OinFCoDijnzXn+Y8MZsGfxEaYLRGFA+sffVIVwem6nk18IoBVCel3joqWHpwXKmLIoUVT7lz78gCN1G/l09cKV1X62rgD/Ixp2y7e5qVEzmoZ7HY/RGtgEhwJtREezOGXMjjJ8/WvFegxyACovSLPqEqGtfmzAxcNaEykSbBVLG24NrVJvgiJXEz5hF+4NzHYdRAcxgxOxv2cjcEGCD/bbafQ8ZKN9l1Ej978aLegDuE5m9RLAHqM54xAcAhYpy1Jjokh8/yfUxCr1Z9En8jZWFXhKPb3N1768Z0tbUCSf29aaVDtJHuZgTJpA==
Received: from AM5EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (10.152.8.51) by AM5EUR02HT089.eop-EUR02.prod.protection.outlook.com
 (10.152.9.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Wed, 23 Oct
 2019 17:57:06 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com (10.152.8.51) by
 AM5EUR02FT056.mail.protection.outlook.com (10.152.9.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 23 Oct 2019 17:57:05 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75]) by VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75%6]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 17:57:05 +0000
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Topic: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Index: AQHVhfzB7lc3mC9pr0OyFBE/io6S3qdoYtGAgAAfrICAAAGkgIAABnKA
Date: Wed, 23 Oct 2019 17:57:05 +0000
Message-ID: <VI1PR03MB48142C8AFFD94EDD5339F6D6A46B0@VI1PR03MB4814.eurprd03.prod.outlook.com>
References: <VI1PR03MB481484C08A04458ACA64F7A0A46C0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <dbb363cf-bc3a-6de5-a62a-1467208d0017@redhat.com>
 <VI1PR03MB4814DBEC71814C520D123ADDA46B0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <73ddcea3-0e0a-45be-55e7-bca81076c12d@redhat.com>
In-Reply-To: <73ddcea3-0e0a-45be-55e7-bca81076c12d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0132.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::24) To VI1PR03MB4814.eurprd03.prod.outlook.com
 (2603:10a6:803:b7::21)
x-incomingtopheadermarker: OriginalChecksum:3E6478D8910A5F295A7DB83B6574434E3A36716D00F0A0A3B2FF3B6489F91A17;
 UpperCasedChecksum:B83E8820ABB96B48A760F2BA76D0432A98A70EDA8235F09656FAFB7BAF1BEB28;
 SizeAsReceived:7648; Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: pantheon-mail/1.0.8
x-tmn: [sC1bGaDZyPj8UcpbsWZ/n/4aGRaPPeHtdG0ZPeyJkQo=]
x-microsoft-original-message-id: <1571853423.2552.1@smtp-mail.outlook.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: AM5EUR02HT089:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mvhmgAZysIVgjac1yyJNcMyth/SiIruYLcLjrZZTGVBwwAyvXiBkY/Z6rsM1V/gekfE7XLBQXEpBKuA0gdkSMX4WDwVoMVmMpooSgBG4DEsFL/R1IsKMP+Sp0bUS82v/FCze2TMM/6IfpVcEuHYiMA6KjZHDSjoHvtE63DkxtfT+PsQMfIhXi8yz8g9oXRFn
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_VI1PR03MB48142C8AFFD94EDD5339F6D6A46B0VI1PR03MB4814eurp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 124822d2-7b7c-4a96-f8ec-08d757e26a4c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 17:57:05.7966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT089
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.67.102
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
Cc: Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_VI1PR03MB48142C8AFFD94EDD5339F6D6A46B0VI1PR03MB4814eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In virsh I would do this while the guest is running:

virsh attach-disk <vmname> <path_to_ISO_file> <guest_device> --type cdrom -=
-mode readonly

Following the example for guest from my first email:

virsh attach-disk DCHOMENET01 /resources/virtio-win-0.1.171-stable.iso sdb =
--type cdrom --mode readonly

Right after executing this, qemu crashes and log the assertion.
I can repro this also from virt-manager by selecting the cdrom device -> Co=
nnect -> selecting the ISO file -> Choose volume -> Ok (basically the same =
but in the gui).

I may be able to try 4.1. Will look into it and report back.

On mi=E9, oct 23, 2019 at 7:33 PM, John Snow <jsnow@redhat.com> wrote:
On 10/23/19 1:28 PM, Fernando Casas Sch=F6ssow wrote:
Hi John, Thanks for looking into this. I can quickly repro the problem with=
 qemu 4.0 binary with debugging symbols enabled as I have it available alre=
ady. Doing the same with qemu 4.1 or development head may be too much hassl=
e but if it's really the only way I can give it try. Would it worth it to t=
ry with 4.0 first and get the strack trace or it will not help and the only=
 way to go is with 4.1 (or dev)? Thanks, Fernando
If 4.0 is what you have access to, having the stack trace for that is bette=
r than not, but confirming it happens on the latest release would be nice. =
Can you share your workflow for virsh that reproduces the failure? --js
On mi=E9, oct 23, 2019 at 5:34 PM, John Snow <jsnow@redhat.com<mailto:jsnow=
@redhat.com>> wrote:
On 10/18/19 5:41 PM, Fernando Casas Sch=F6ssow wrote: Hi, Hi! Thanks for th=
e report. Today while working with two different Windows Server 2012 R2 gue=
sts I found that when I try to attach an ISO file to a SCSI CD-ROM device t=
hrough libvirt (virsh or virt-manager) while the guest is running, qemu cra=
shes and the following message is logged: Assertion failed: blk_get_aio_con=
text(d->conf.blk) =3D=3D s->ctx (/home/buildozer/aports/main/qemu/src/qemu-=
4.0.0/hw/scsi/virtio-scsi.c: virtio_scsi_ctx_check: 246) I can repro this a=
t will. All I have to do is to try to attach an ISO file to the SCSI CDROM =
while the guest is running. The SCSI controller model is virtio-scsi with i=
othread enabled. Please find below all the details about my setup that I co=
nsidered relevant but I missed something please don't hesitate to let me kn=
ow: Looks like we got aio_context management wrong with iothread for the me=
dia change events somewhere. Should be easy enough to fix if we figure out =
where the bad assumption is. Host arch: x86_64 Distro: Alpine Linux 3.10.2 =
qemu version: 4.0 Do you have the ability to try 4.1, or the latest develop=
ment head with debugging symbols enabled? Linux kernel version: 4.19.67 lib=
virt: 5.5.0 Emulated SCSI controller: virtio-scsi (with iothread enabled) G=
uest firmware: OVMF-EFI Guest OS: Window Server 2012 R2 Guest virtio driver=
s version: 171 (current stable) qemu command line: /usr/bin/qemu-system-x86=
_64 -name guest=3DDCHOMENET01,debug-threads=3Don -S -object secret,id=3Dmas=
terKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-78-DCHOMENET01/mas=
ter-key.aes -machine pc-i440fx-4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3D=
on -cpu IvyBridge,ss=3Don,vmx=3Doff,pcid=3Don,hypervisor=3Don,arat=3Don,tsc=
_adjust=3Don,umip=3Don,xsaveopt=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinloc=
ks=3D0x1fff -drive file=3D/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.f=
d,if=3Dpflash,format=3Draw,unit=3D0,readonly=3Don -drive file=3D/var/lib/li=
bvirt/qemu/nvram/DCHOMENET01_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 -m 1=
536 -overcommit mem-lock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -ob=
ject iothread,id=3Diothread1 -uuid f06978ad-2734-44ab-a518-5dfcf71d625e -no=
-user-config -nodefaults -chardev socket,id=3Dcharmonitor,fd=3D33,server,no=
wait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dloc=
altime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -n=
o-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 =
-boot strict=3Don -device qemu-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x4 -device=
 virtio-scsi-pci,iothread=3Diothread1,id=3Dscsi0,num_queues=3D1,bus=3Dpci.0=
,addr=3D0x5 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=
=3D0x6 -drive file=3D/storage/storage-hdd-vms/virtual_machines_hdd/dchomene=
t01.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,cache=3Dnone,disc=
ard=3Dunmap,aio=3Dthreads -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=
=3D0,lun=3D0,device_id=3Ddrive-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Ds=
csi0-0-0-0,bootindex=3D1,write-cache=3Don -drive if=3Dnone,id=3Ddrive-scsi0=
-0-0-1,readonly=3Don -device scsi-cd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,=
lun=3D1,device_id=3Ddrive-scsi0-0-0-1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-=
0-0-1 -netdev tap,fd=3D41,id=3Dhostnet0,vhost=3Don,vhostfd=3D43 -device vir=
tio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:99:b5:62,bus=3Dpci.0=
,addr=3D0x3 -chardev socket,id=3Dcharserial0,host=3D127.0.0.1,port=3D4900,t=
elnet,server,nowait -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -=
chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bu=
s=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom=
.redhat.spice.0 -chardev socket,id=3Dcharchannel1,fd=3D45,server,nowait -de=
vice virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dcharchannel1,id=
=3Dchannel1,name=3Dorg.qemu.guest_agent.0 -chardev spiceport,id=3Dcharchann=
el2,name=3Dorg.spice-space.webdav.0 -device virtserialport,bus=3Dvirtio-ser=
ial0.0,nr=3D3,chardev=3Dcharchannel2,id=3Dchannel2,name=3Dorg.spice-space.w=
ebdav.0 -device virtio-tablet-pci,id=3Dinput2,bus=3Dpci.0,addr=3D0x7 -spice=
 port=3D5900,addr=3D127.0.0.1,disable-ticketing,seamless-migration=3Don -de=
vice qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_si=
ze_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 -chardev sp=
icevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dcharredi=
r0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev spicevmc,id=3Dcharredir1,name=
=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,=
port=3D3 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -s=
andbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecon=
trol=3Ddeny -msg timestamp=3Don I can provide a core dump of the process if=
 needed for debugging and the guest XML as well. A backtrace is probably a =
great starting point (from gdb: `thread apply all bt`.) I don't know exactl=
y what codepath is being exercised when you "attach an ISO file" through li=
bvirt's interface. If you don't mind the hassle, trying on the 4.1 (or a de=
velopment build would be even more luxurious) and giving a stacktrace would=
 be nice. Thanks. Fernando Thanks! --js



--_000_VI1PR03MB48142C8AFFD94EDD5339F6D6A46B0VI1PR03MB4814eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <C1B5A7B54BE337459C8B887DD4C51FC5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>In virsh I would do this while the guest is running:</div>
<div><br>
</div>
<div>virsh attach-disk &lt;vmname&gt; &lt;path_to_ISO_file&gt; &lt;guest_de=
vice&gt; --type cdrom --mode readonly</div>
<div><br>
</div>
<div>Following the example for guest from my first email:</div>
<div><br>
</div>
<div>virsh attach-disk DCHOMENET01 /resources/virtio-win-0.1.171-stable.iso=
 sdb --type cdrom --mode readonly</div>
<div><br>
</div>
<div>Right after executing this, qemu crashes and log the assertion.</div>
<div>I can repro this also from virt-manager by selecting the cdrom device =
-&gt; Connect -&gt; selecting the ISO file -&gt; Choose volume -&gt; Ok (ba=
sically the same but in the gui).</div>
<div><br>
</div>
<div>I may be able to try 4.1. Will look into it and report back.</div>
<br>
On mi=E9, oct 23, 2019 at 7:33 PM, John Snow &lt;jsnow@redhat.com&gt; wrote=
:<br>
<blockquote type=3D"cite">
<div class=3D"plaintext" style=3D"white-space: pre-wrap;">On 10/23/19 1:28 =
PM, Fernando Casas Sch=F6ssow wrote:
<blockquote>Hi John, Thanks for looking into this. I can quickly repro the =
problem with qemu 4.0 binary with debugging symbols enabled as I have it av=
ailable already. Doing the same with qemu 4.1 or development head may be to=
o much hassle but if it's really
 the only way I can give it try. Would it worth it to try with 4.0 first an=
d get the strack trace or it will not help and the only way to go is with 4=
.1 (or dev)? Thanks, Fernando
</blockquote>
If 4.0 is what you have access to, having the stack trace for that is bette=
r than not, but confirming it happens on the latest release would be nice. =
Can you share your workflow for virsh that reproduces the failure? --js
<blockquote>On mi=E9, oct 23, 2019 at 5:34 PM, John Snow &lt;<a href=3D"mai=
lto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote:
<blockquote>On 10/18/19 5:41 PM, Fernando Casas Sch=F6ssow wrote: Hi, Hi! T=
hanks for the report. Today while working with two different Windows Server=
 2012 R2 guests I found that when I try to attach an ISO file to a SCSI CD-=
ROM device through libvirt (virsh
 or virt-manager) while the guest is running, qemu crashes and the followin=
g message is logged: Assertion failed: blk_get_aio_context(d-&gt;conf.blk) =
=3D=3D s-&gt;ctx (/home/buildozer/aports/main/qemu/src/qemu-4.0.0/hw/scsi/v=
irtio-scsi.c: virtio_scsi_ctx_check: 246)
 I can repro this at will. All I have to do is to try to attach an ISO file=
 to the SCSI CDROM while the guest is running. The SCSI controller model is=
 virtio-scsi with iothread enabled. Please find below all the details about=
 my setup that I considered relevant
 but I missed something please don't hesitate to let me know: Looks like we=
 got aio_context management wrong with iothread for the media change events=
 somewhere. Should be easy enough to fix if we figure out where the bad ass=
umption is. Host arch: x86_64 Distro:
 Alpine Linux 3.10.2 qemu version: 4.0 Do you have the ability to try 4.1, =
or the latest development head with debugging symbols enabled? Linux kernel=
 version: 4.19.67 libvirt: 5.5.0 Emulated SCSI controller: virtio-scsi (wit=
h iothread enabled) Guest firmware:
 OVMF-EFI Guest OS: Window Server 2012 R2 Guest virtio drivers version: 171=
 (current stable) qemu command line: /usr/bin/qemu-system-x86_64 -name gues=
t=3DDCHOMENET01,debug-threads=3Don -S -object secret,id=3DmasterKey0,format=
=3Draw,file=3D/var/lib/libvirt/qemu/domain-78-DCHOMENET01/master-key.aes
 -machine pc-i440fx-4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Don -cpu Ivy=
Bridge,ss=3Don,vmx=3Doff,pcid=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=3Do=
n,umip=3Don,xsaveopt=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff=
 -drive file=3D/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpfla=
sh,format=3Draw,unit=3D0,readonly=3Don
 -drive file=3D/var/lib/libvirt/qemu/nvram/DCHOMENET01_VARS.fd,if=3Dpflash,=
format=3Draw,unit=3D1 -m 1536 -overcommit mem-lock=3Doff -smp 1,sockets=3D1=
,cores=3D1,threads=3D1 -object iothread,id=3Diothread1 -uuid f06978ad-2734-=
44ab-a518-5dfcf71d625e -no-user-config -nodefaults
 -chardev socket,id=3Dcharmonitor,fd=3D33,server,nowait -mon chardev=3Dchar=
monitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dlocaltime,driftfix=3Dslew -=
global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global PIIX4=
_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot
 strict=3Don -device qemu-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x4 -device virt=
io-scsi-pci,iothread=3Diothread1,id=3Dscsi0,num_queues=3D1,bus=3Dpci.0,addr=
=3D0x5 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6=
 -drive file=3D/storage/storage-hdd-vms/virtual_machines_hdd/dchomenet01.qc=
ow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,cache=3Dnone,discard=3D=
unmap,aio=3Dthreads
 -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=3D=
drive-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1,=
write-cache=3Don -drive if=3Dnone,id=3Ddrive-scsi0-0-0-1,readonly=3Don -dev=
ice scsi-cd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D1,device_id=3Ddrive=
-scsi0-0-0-1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1
 -netdev tap,fd=3D41,id=3Dhostnet0,vhost=3Don,vhostfd=3D43 -device virtio-n=
et-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:99:b5:62,bus=3Dpci.0,addr=
=3D0x3 -chardev socket,id=3Dcharserial0,host=3D127.0.0.1,port=3D4900,telnet=
,server,nowait -device isa-serial,chardev=3Dcharserial0,id=3Dserial0
 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,=
bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dc=
om.redhat.spice.0 -chardev socket,id=3Dcharchannel1,fd=3D45,server,nowait -=
device virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dcharchannel1,=
id=3Dchannel1,name=3Dorg.qemu.guest_agent.0
 -chardev spiceport,id=3Dcharchannel2,name=3Dorg.spice-space.webdav.0 -devi=
ce virtserialport,bus=3Dvirtio-serial0.0,nr=3D3,chardev=3Dcharchannel2,id=
=3Dchannel2,name=3Dorg.spice-space.webdav.0 -device virtio-tablet-pci,id=3D=
input2,bus=3Dpci.0,addr=3D0x7 -spice port=3D5900,addr=3D127.0.0.1,disable-t=
icketing,seamless-migration=3Don
 -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram6=
4_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 -charde=
v spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dchar=
redir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev spicevmc,id=3Dcharredir1,n=
ame=3Dusbredir
 -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -d=
evice virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -sandbox on,o=
bsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny=
 -msg timestamp=3Don I can provide a core dump of the process
 if needed for debugging and the guest XML as well. A backtrace is probably=
 a great starting point (from gdb: `thread apply all bt`.) I don't know exa=
ctly what codepath is being exercised when you &quot;attach an ISO file&quo=
t; through libvirt's interface. If you don't
 mind the hassle, trying on the 4.1 (or a development build would be even m=
ore luxurious) and giving a stacktrace would be nice. Thanks. Fernando Than=
ks! --js
</blockquote>
</blockquote>
</div>
</blockquote>
<br>
<br>
</body>
</html>

--_000_VI1PR03MB48142C8AFFD94EDD5339F6D6A46B0VI1PR03MB4814eurp_--

