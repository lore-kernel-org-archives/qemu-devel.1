Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F191CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 21:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BF120679
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 21:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SilpBNym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BF120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLZm6-0000Kr-Ei
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 17:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casasfernando@outlook.com>) id 1iLZlQ-0008Au-5v
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 17:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casasfernando@outlook.com>) id 1iLZlN-00014B-K6
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 17:26:23 -0400
Received: from mail-oln040092071054.outbound.protection.outlook.com
 ([40.92.71.54]:31028 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casasfernando@outlook.com>)
 id 1iLZlM-00012d-PO; Fri, 18 Oct 2019 17:26:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maEx2Ri9CiINmNbTfr7M5tdtGZRFlIf/1WdT8JZcFb1Bg14IkbbvpmRvm+wGIpN8WLpVbpuBPB8v2hoeEf+kbFmVqZ4B2Yy4zINNaWkNrpm9O8LnCi0161Vu8nLh71GfntaY1dI+lLHN5Rx2ktlj/DmyotnqoZ8G/Z6hqBEDgNkIjDnPQd+Ve8Jlrr9TNuNgJcKsDkfYH3nG0s/6Cc6FqEAhgtq/FsE54sGyCjiysqReOJERR+HfjKskRxaaLL8KHjjASnXzP1K1ix2fDrh3x5d/CTLNs2j9SJCWO8QFGNxiwLCe5zN7ZJ8VXwBgyVxNnxFSEPVjtB6kt2tqjZW2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp8sCteAN0RR2zF80j+8JkBLsHL7cTihJmt0c85dclU=;
 b=WH0m4dU4Z3LvXl0HJzqfdXPL3yJTP1aTJ1P6o7F+V4LgxOp8onyha641x6rdAITsJnb02Uc4ezOHYXASnlzyZRwa+dcBjQLZikd2/+kuR+WR9Ku95vMuIqsvp/oyRbMIRNLKPzziV09wBfBdRMpT7RZJ8OGzT5fKpWVUBbWoeZMmgQwakZAjJCM99iSgD9687pfmPbg8XEjR+TS9xLwLTd1V7aP8G3bcKBZeDG9zS3e97LNE5phhJ5UzC5nFws4QycF67s/RnatRCwNYtFdN+KQXx6yuowd90FPi52SNOlNoCmQ8lBmha+IvT58VYlp+LUQKOUeM8Q9m95lCbWmADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp8sCteAN0RR2zF80j+8JkBLsHL7cTihJmt0c85dclU=;
 b=SilpBNymZ98/ha/gPBJJIf2N/i0BCqCXrDNnT+GQxxw/BgvrBufsCJg8+XHisenUFC6FD93/oDHw/tvAq5QfnIKFkFG0dFQ0m6CO1sq9d4GXeHkd5gzisoc2wynGjAXcLN9Mvp1lN4SXtVkyY4hs+8vtLBs73nKnAdiajmLHra7ez6ORjDIaF68f6KGIb36y0belx7HsI3pIzNz7g1EoLTVfw2o3pY/ED2ewQ1lMK6NOVZnPGdlirB1yZWnMLbcAWajKVBMjpE19KpUM8sraIheXSGhTMlU9ctkyjXpSbo/WNdbCCTkoW53YB7D5CoJ5kMM7d3H/zCEiE2pAcDW5Mw==
Received: from VE1EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (10.152.18.54) by VE1EUR03HT085.eop-EUR03.prod.protection.outlook.com
 (10.152.19.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15; Fri, 18 Oct
 2019 21:26:16 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com (10.152.18.60) by
 VE1EUR03FT026.mail.protection.outlook.com (10.152.18.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 21:26:16 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75]) by VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75%6]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 21:26:16 +0000
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
To: QEMU Developers <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Topic: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Index: AQHVhfqst2hJzspceUeOPqO+fuJixA==
Date: Fri, 18 Oct 2019 21:26:16 +0000
Message-ID: <VI1PR03MB48149AFE8CC9A7B88F796844A46C0@VI1PR03MB4814.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::32) To VI1PR03MB4814.eurprd03.prod.outlook.com
 (2603:10a6:803:b7::21)
x-incomingtopheadermarker: OriginalChecksum:6702F896892B01793EACC1C2A7A5978BDFFD984E7E87AD9ADC2C709EE854B6C3;
 UpperCasedChecksum:FC49EA8C20C96B1D09C5585F7434C07176F808B7FAC5528043B44767C0D5652A;
 SizeAsReceived:7500; Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: pantheon-mail/1.0.8
x-tmn: [JMTd4fTGc5hjDQeSA00iVMrDonMYh24BxxrkT0zDuY4=]
x-microsoft-original-message-id: <1571433973.5255.0@smtp-mail.outlook.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: VE1EUR03HT085:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8c4w+u1O9WsKmYZumSpd01C+vuwiJ9lXxblw8NMB+EDdFyVJ9uarXrtRxWPwx43V3EmsLiVOtHPqUMbFNDslp0H/tGUcrIoOtjPkRN2IbMPtKIby4QBK/ivJTmGSbzWy2PJdR57GW6uZwpkXuOwgvV27g7yNEPkhdmZZpWswkqOTzma2jVWcf+tmdYrhqW0
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_VI1PR03MB48149AFE8CC9A7B88F796844A46C0VI1PR03MB4814eurp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0aa1f6-0fca-4fff-0f87-08d75411ceb3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 21:26:16.0909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT085
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.71.54
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

--_000_VI1PR03MB48149AFE8CC9A7B88F796844A46C0VI1PR03MB4814eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Today while working with two different Windows Server 2012 R2 guests I foun=
d that when I try to attach an ISO file to a SCSI CD-ROM device through lib=
virt (virsh or virt-manager) while the guest is running, qemu crashes and t=
he following message is logged:

Assertion failed: blk_get_aio_context(d->conf.blk) =3D=3D s->ctx (/home/bui=
ldozer/aports/main/qemu/src/qemu-4.0.0/hw/scsi/virtio-scsi.c: virtio_scsi_c=
tx_check: 246)

I can repro this at will. All I have to do is to try to attach an ISO file =
to the SCSI CDROM while the guest is running.
The SCSI controller model is virtio-scsi with iothread enabled.
Please find below all the details about my setup that I considered relevant=
 but I missed something please don't hesitate to let me know:

Host arch: x86_64
Distro: Alpine Linux 3.10.2
qemu version: 4.0
Linux kernel version: 4.19.67
libvirt: 5.5.0
Emulated SCSI controller: virtio-scsi (with iothread enabled)
Guest firmware: OVMF-EFI
Guest OS: Window Server 2012 R2
Guest virtio drivers version: 171 (current stable)

qemu command line:

/usr/bin/qemu-system-x86_64 -name guest=3DDCHOMENET01,debug-threads=3Don -S=
 -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/d=
omain-78-DCHOMENET01/master-key.aes -machine pc-i440fx-4.0,accel=3Dkvm,usb=
=3Doff,dump-guest-core=3Don -cpu IvyBridge,ss=3Don,vmx=3Doff,pcid=3Don,hype=
rvisor=3Don,arat=3Don,tsc_adjust=3Don,umip=3Don,xsaveopt=3Don,hv_time,hv_re=
laxed,hv_vapic,hv_spinlocks=3D0x1fff -drive file=3D/usr/share/edk2.git/ovmf=
-x64/OVMF_CODE-pure-efi.fd,if=3Dpflash,format=3Draw,unit=3D0,readonly=3Don =
-drive file=3D/var/lib/libvirt/qemu/nvram/DCHOMENET01_VARS.fd,if=3Dpflash,f=
ormat=3Draw,unit=3D1 -m 1536 -overcommit mem-lock=3Doff -smp 1,sockets=3D1,=
cores=3D1,threads=3D1 -object iothread,id=3Diothread1 -uuid f06978ad-2734-4=
4ab-a518-5dfcf71d625e -no-user-config -nodefaults -chardev socket,id=3Dchar=
monitor,fd=3D33,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=
=3Dcontrol -rtc base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_=
policy=3Ddelay -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -globa=
l PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device qemu-xhci,id=3Dusb,bus=
=3Dpci.0,addr=3D0x4 -device virtio-scsi-pci,iothread=3Diothread1,id=3Dscsi0=
,num_queues=3D1,bus=3Dpci.0,addr=3D0x5 -device virtio-serial-pci,id=3Dvirti=
o-serial0,bus=3Dpci.0,addr=3D0x6 -drive file=3D/storage/storage-hdd-vms/vir=
tual_machines_hdd/dchomenet01.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scs=
i0-0-0-0,cache=3Dnone,discard=3Dunmap,aio=3Dthreads -device scsi-hd,bus=3Ds=
csi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=3Ddrive-scsi0-0-0-0,drive=
=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1,write-cache=3Don -drive=
 if=3Dnone,id=3Ddrive-scsi0-0-0-1,readonly=3Don -device scsi-cd,bus=3Dscsi0=
.0,channel=3D0,scsi-id=3D0,lun=3D1,device_id=3Ddrive-scsi0-0-0-1,drive=3Ddr=
ive-scsi0-0-0-1,id=3Dscsi0-0-0-1 -netdev tap,fd=3D41,id=3Dhostnet0,vhost=3D=
on,vhostfd=3D43 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52=
:54:00:99:b5:62,bus=3Dpci.0,addr=3D0x3 -chardev socket,id=3Dcharserial0,hos=
t=3D127.0.0.1,port=3D4900,telnet,server,nowait -device isa-serial,chardev=
=3Dcharserial0,id=3Dserial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdag=
ent -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchan=
nel0,id=3Dchannel0,name=3Dcom.redhat.spice.0 -chardev socket,id=3Dcharchann=
el1,fd=3D45,server,nowait -device virtserialport,bus=3Dvirtio-serial0.0,nr=
=3D2,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dorg.qemu.guest_agent.0 -ch=
ardev spiceport,id=3Dcharchannel2,name=3Dorg.spice-space.webdav.0 -device v=
irtserialport,bus=3Dvirtio-serial0.0,nr=3D3,chardev=3Dcharchannel2,id=3Dcha=
nnel2,name=3Dorg.spice-space.webdav.0 -device virtio-tablet-pci,id=3Dinput2=
,bus=3Dpci.0,addr=3D0x7 -spice port=3D5900,addr=3D127.0.0.1,disable-ticketi=
ng,seamless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,=
vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=
=3Dpci.0,addr=3D0x2 -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir -devi=
ce usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev=
 spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-redir,chardev=3Dcharr=
edir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-balloon-pci,id=3Dball=
oon0,bus=3Dpci.0,addr=3D0x8 -sandbox on,obsolete=3Ddeny,elevateprivileges=
=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny -msg timestamp=3Don

I can provide a core dump of the process if needed for debugging and the gu=
est XML as well.

Thanks.

Fernando



--_000_VI1PR03MB48149AFE8CC9A7B88F796844A46C0VI1PR03MB4814eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <95698BD07CC53F4DABED93AFDD7B71EB@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
Hi,
<div><br>
</div>
<div>Today while working with two different Windows Server 2012 R2 guests I=
 found that when I try to attach an ISO file to a SCSI CD-ROM device throug=
h libvirt (virsh or virt-manager) while the guest is running, qemu crashes =
and the following message is logged:<br>
<div><br>
</div>
<div>Assertion failed: blk_get_aio_context(d-&gt;conf.blk) =3D=3D s-&gt;ctx=
 (/home/buildozer/aports/main/qemu/src/qemu-4.0.0/hw/scsi/virtio-scsi.c: vi=
rtio_scsi_ctx_check: 246)</div>
<div><br>
</div>
<div>I can repro this at will. All I have to do is to try to attach an ISO =
file to the SCSI CDROM while the guest is running.</div>
<div>The SCSI controller model is virtio-scsi with iothread enabled.</div>
<div>Please find below all the details about my setup that I considered rel=
evant but I missed something please don't hesitate to let me know:</div>
<div><br>
</div>
<div>Host arch: x86_64</div>
<div>Distro: Alpine Linux 3.10.2</div>
<div>qemu version: 4.0</div>
<div>Linux kernel version: 4.19.67</div>
<div>libvirt: 5.5.0</div>
<div>Emulated SCSI controller: virtio-scsi (with iothread enabled)</div>
<div>Guest firmware: OVMF-EFI</div>
<div>Guest OS: Window Server 2012 R2</div>
<div>Guest virtio drivers version: 171 (current stable)</div>
<div><br>
</div>
<div>qemu command line:</div>
<div><br>
</div>
<div>/usr/bin/qemu-system-x86_64 -name guest=3DDCHOMENET01,debug-threads=3D=
on -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/q=
emu/domain-78-DCHOMENET01/master-key.aes -machine pc-i440fx-4.0,accel=3Dkvm=
,usb=3Doff,dump-guest-core=3Don -cpu IvyBridge,ss=3Don,vmx=3Doff,pcid=3Don,=
hypervisor=3Don,arat=3Don,tsc_adjust=3Don,umip=3Don,xsaveopt=3Don,hv_time,h=
v_relaxed,hv_vapic,hv_spinlocks=3D0x1fff
 -drive file=3D/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpfla=
sh,format=3Draw,unit=3D0,readonly=3Don -drive file=3D/var/lib/libvirt/qemu/=
nvram/DCHOMENET01_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 -m 1536 -overco=
mmit mem-lock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1
 -object iothread,id=3Diothread1 -uuid f06978ad-2734-44ab-a518-5dfcf71d625e=
 -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,fd=3D33,serve=
r,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=
=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay
 -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.dis=
able_s4=3D1 -boot strict=3Don -device qemu-xhci,id=3Dusb,bus=3Dpci.0,addr=
=3D0x4 -device virtio-scsi-pci,iothread=3Diothread1,id=3Dscsi0,num_queues=
=3D1,bus=3Dpci.0,addr=3D0x5 -device virtio-serial-pci,id=3Dvirtio-serial0,b=
us=3Dpci.0,addr=3D0x6
 -drive file=3D/storage/storage-hdd-vms/virtual_machines_hdd/dchomenet01.qc=
ow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,cache=3Dnone,discard=3D=
unmap,aio=3Dthreads -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,l=
un=3D0,device_id=3Ddrive-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0=
-0-0,bootindex=3D1,write-cache=3Don
 -drive if=3Dnone,id=3Ddrive-scsi0-0-0-1,readonly=3Don -device scsi-cd,bus=
=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D1,device_id=3Ddrive-scsi0-0-0-1,dr=
ive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1 -netdev tap,fd=3D41,id=3Dhostnet0,=
vhost=3Don,vhostfd=3D43 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,=
mac=3D52:54:00:99:b5:62,bus=3Dpci.0,addr=3D0x3
 -chardev socket,id=3Dcharserial0,host=3D127.0.0.1,port=3D4900,telnet,serve=
r,nowait -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev spi=
cevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus=3Dvirtio-=
serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spi=
ce.0
 -chardev socket,id=3Dcharchannel1,fd=3D45,server,nowait -device virtserial=
port,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dcharchannel1,id=3Dchannel1,nam=
e=3Dorg.qemu.guest_agent.0 -chardev spiceport,id=3Dcharchannel2,name=3Dorg.=
spice-space.webdav.0 -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D3,c=
hardev=3Dcharchannel2,id=3Dchannel2,name=3Dorg.spice-space.webdav.0
 -device virtio-tablet-pci,id=3Dinput2,bus=3Dpci.0,addr=3D0x7 -spice port=
=3D5900,addr=3D127.0.0.1,disable-ticketing,seamless-migration=3Don -device =
qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=
=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 -chardev
 spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dcharr=
edir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev spicevmc,id=3Dcharredir1,na=
me=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.=
0,port=3D3 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8
 -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resource=
control=3Ddeny -msg timestamp=3Don</div>
<div><br>
</div>
<div>I can provide a core dump of the process if needed for debugging and t=
he guest XML as well.</div>
<div><br>
</div>
<div>Thanks.</div>
<div><br>
</div>
<div>Fernando</div>
<div><br>
</div>
<div><br>
</div>
</div>
</body>
</html>

--_000_VI1PR03MB48149AFE8CC9A7B88F796844A46C0VI1PR03MB4814eurp_--

