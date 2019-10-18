Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45F1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 21:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B74421925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 21:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sUXvp6BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B74421925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLa0d-0003TP-NJ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 17:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casasfernando@outlook.com>) id 1iLZzo-0002vm-51
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 17:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casasfernando@outlook.com>) id 1iLZzm-0007Xc-6o
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 17:41:15 -0400
Received: from mail-oln040092067086.outbound.protection.outlook.com
 ([40.92.67.86]:54428 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casasfernando@outlook.com>)
 id 1iLZzm-0007W7-0v; Fri, 18 Oct 2019 17:41:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPamI6Iemdpqj3V4aVo8sOyV90uFZIDtNBEKqD+7xGVFnNwYlcsMgRIBMacve6a60hyQQQI9QOWWNyAFCJzasSyrgFMLLnMtAFA349KzxfzOVhomjkht7eOMxqlrk0IbcjYK+oX2UTRmD0l+PUc4nZJrM9uXUiOCihfT9528F03pYHHhkOTh+FsC2yqu4OJIZ0PDLcY2Yn8yfz6tG+1RFtaojlPrEyBTa/VroGom+Yu4NM7Heh2dOkmhyKBED+kwIW/ylfOhCJeDd6PYpYssjboj1bHldtkdPu7UxywHr3Uut+pJEgdsHQbo8Jm5L48lNt+ekypG5Ahl8pqEyfl5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54Q9lEz7rmoiKbb/xVHEtnOYueBoQxLUZ/i+E/RGuxo=;
 b=ZJc3eSgiKnJ65kcNog1SnRzKJCjHaCx7d4P14/ep4dcb/YAQbhUXtOZgPrLXp1ZFkVHtmhn28/w4BYu68Y/dw4GwS/FvAVH+CHx8s/8rOUPJs75B6RTn5im+SGs1LxN1scdVaZ/HwHx2VXL6U5c69QA9vUzLbLgt87loSJJJCJfnxkPsGkH7wrBWf+s9vPLTkW8mpM3zTTJe4WF6MZ3REgB0F1eoYJL/G5feXACHWINHf7UPwtRpRDeYV6eXXJbdXdjs4W1Q2he9uC5iy5a2iuz1P5j/ugQU/K1SEjn/Nr2i75s6mgpSWW+SrOmXw11aSmCzBqpgZEYQ8I27y4W2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54Q9lEz7rmoiKbb/xVHEtnOYueBoQxLUZ/i+E/RGuxo=;
 b=sUXvp6BRdIWniaFCkG8i2B6Q/XgITd94q6UC9oqpW2EDAyBJ2m7W3ie6xZDGYQpTRvs3q8FSxNS+HHfnN59IqKmPkrSd3e+T2F0NrUkzHqExML7MheZpqcZ8GrN31RqnJIAvQGGSgtnhLY9NYABV3LKD1YOAE77vzIxWOF5wU0AbZxPWL60xOYtwSnDSRkIO7hUlJcI1ZEdr31Bki41zS/fhMfyZhYzBCLd1XZ0CwaHUD6EchlOiJnaz+nlido3Mbtt0KVRBiicRYQYmqn+8OG/HPVau43SgSC3Bt8Ah+t+xpHJt+sDGTx8L6AfZbh3aKVqTGVQuYDKuqYBWJhAiWw==
Received: from AM5EUR02FT030.eop-EUR02.prod.protection.outlook.com
 (10.152.8.56) by AM5EUR02HT041.eop-EUR02.prod.protection.outlook.com
 (10.152.9.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.14; Fri, 18 Oct
 2019 21:41:11 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com (10.152.8.52) by
 AM5EUR02FT030.mail.protection.outlook.com (10.152.8.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Fri, 18 Oct 2019 21:41:11 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75]) by VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75%6]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 21:41:11 +0000
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Topic: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Index: AQHVhfzB7lc3mC9pr0OyFBE/io6S3g==
Date: Fri, 18 Oct 2019 21:41:10 +0000
Message-ID: <VI1PR03MB481484C08A04458ACA64F7A0A46C0@VI1PR03MB4814.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0016.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::28) To VI1PR03MB4814.eurprd03.prod.outlook.com
 (2603:10a6:803:b7::21)
x-incomingtopheadermarker: OriginalChecksum:E2C5A701985300EC2A0611B8637CA2EF61530B8EB6D3C95ECB615EAB42E43EA6;
 UpperCasedChecksum:A2CFE216BA1D75E54A8E848DF5C948C1F61ACE418D1BF20F31B2C8D85E96EA39;
 SizeAsReceived:7485; Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: pantheon-mail/1.0.8
x-tmn: [SwKNFEKe+a7SijGui+rQCJ2FGZ0TFgfN4Wv+mJ2vX9M=]
x-microsoft-original-message-id: <1571434868.5255.1@smtp-mail.outlook.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: AM5EUR02HT041:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9byihrWzB4nhQfEp9RY9+96Ap+Kr239oRgOiy3jrNhcoYgGCmBS+6xJBeK1C7arTgdwz/9wY7jCNxf7IFb3EvsdTb6QUn+ho5VhtSLhgWfcdycJ/6YQ40lIQx9oQi7WHeuTPkO7CreO4xDFL6jEDcRuFfN2W3W2ehbs+sVo+8lQjhkSaryLtbk0SaADj+FSc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F2F92856AB160F43B8239C647F3EF771@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 432f2f13-32c2-4156-650d-08d75413e424
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 21:41:10.9494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT041
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.67.86
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
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Today while working with two different Windows Server 2012 R2 guests I=20
found that when I try to attach an ISO file to a SCSI CD-ROM device=20
through libvirt (virsh or virt-manager) while the guest is running,=20
qemu crashes and the following message is logged:

Assertion failed: blk_get_aio_context(d->conf.blk) =3D=3D s->ctx=20
(/home/buildozer/aports/main/qemu/src/qemu-4.0.0/hw/scsi/virtio-scsi.c:=20
virtio_scsi_ctx_check: 246)

I can repro this at will. All I have to do is to try to attach an ISO=20
file to the SCSI CDROM while the guest is running.
The SCSI controller model is virtio-scsi with iothread enabled.
Please find below all the details about my setup that I considered=20
relevant but I missed something please don't hesitate to let me know:

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
=20
-object=20
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-78-=
DCHOMENET01/master-key.aes=20
-machine pc-i440fx-4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Don -cpu=20
IvyBridge,ss=3Don,vmx=3Doff,pcid=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=
=3Don,umip=3Don,xsaveopt=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x=
1fff=20
-drive=20
file=3D/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpflash,forma=
t=3Draw,unit=3D0,readonly=3Don=20
-drive=20
file=3D/var/lib/libvirt/qemu/nvram/DCHOMENET01_VARS.fd,if=3Dpflash,format=
=3Draw,unit=3D1=20
-m 1536 -overcommit mem-lock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1=
=20
-object iothread,id=3Diothread1 -uuid=20
f06978ad-2734-44ab-a518-5dfcf71d625e -no-user-config -nodefaults=20
-chardev socket,id=3Dcharmonitor,fd=3D33,server,nowait -mon=20
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc=20
base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay=20
-no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global=20
PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device=20
qemu-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x4 -device=20
virtio-scsi-pci,iothread=3Diothread1,id=3Dscsi0,num_queues=3D1,bus=3Dpci.0,=
addr=3D0x5=20
-device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6 -drive=
=20
file=3D/storage/storage-hdd-vms/virtual_machines_hdd/dchomenet01.qcow2,form=
at=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,cache=3Dnone,discard=3Dunmap,ai=
o=3Dthreads=20
-device=20
scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=3Ddrive-scs=
i0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1,write-cac=
he=3Don=20
-drive if=3Dnone,id=3Ddrive-scsi0-0-0-1,readonly=3Don -device=20
scsi-cd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D1,device_id=3Ddrive-scs=
i0-0-0-1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1=20
-netdev tap,fd=3D41,id=3Dhostnet0,vhost=3Don,vhostfd=3D43 -device=20
virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:99:b5:62,bus=3Dpc=
i.0,addr=3D0x3=20
-chardev=20
socket,id=3Dcharserial0,host=3D127.0.0.1,port=3D4900,telnet,server,nowait=20
-device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev=20
spicevmc,id=3Dcharchannel0,name=3Dvdagent -device=20
virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dch=
annel0,name=3Dcom.redhat.spice.0=20
-chardev socket,id=3Dcharchannel1,fd=3D45,server,nowait -device=20
virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dcharchannel1,id=3Dch=
annel1,name=3Dorg.qemu.guest_agent.0=20
-chardev spiceport,id=3Dcharchannel2,name=3Dorg.spice-space.webdav.0=20
-device=20
virtserialport,bus=3Dvirtio-serial0.0,nr=3D3,chardev=3Dcharchannel2,id=3Dch=
annel2,name=3Dorg.spice-space.webdav.0=20
-device virtio-tablet-pci,id=3Dinput2,bus=3Dpci.0,addr=3D0x7 -spice=20
port=3D5900,addr=3D127.0.0.1,disable-ticketing,seamless-migration=3Don=20
-device=20
qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=
=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2=20
-chardev spicevmc,id=3Dcharredir0,name=3Dusbredir -device=20
usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev=20
spicevmc,id=3Dcharredir1,name=3Dusbredir -device=20
usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device=20
virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -sandbox=20
on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3D=
deny=20
-msg timestamp=3Don

I can provide a core dump of the process if needed for debugging and=20
the guest XML as well.

Thanks.

Fernando


