Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89373CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40830205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B4PQBUzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40830205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNN91-0006IP-Dt
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 16:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casasfernando@outlook.com>) id 1iNKQm-0000fR-V0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casasfernando@outlook.com>) id 1iNKQk-0007yg-Ic
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:28:20 -0400
Received: from mail-oln040092072044.outbound.protection.outlook.com
 ([40.92.72.44]:42231 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casasfernando@outlook.com>)
 id 1iNKQi-0007vB-Kb; Wed, 23 Oct 2019 13:28:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eb1mVt6b6iVqDTyg3W08VLKTt1k2JcKeuYNqxytWJiinPWdluuab6D8EbviXWT2NPEXK+SmTkwgMEPvF+iB32UoTtaRSzEtyzEgROW46hDLKU4sXnw86CT4P8aRC909OTzOa95kq2pgTaufx3xCRiKdipaOIcDhMjZbp53ZjIEDeDaXZVJvNNG/+hUuPbTukomuq7ocnLpyd/XUo0julZeLqrkebuzI7o8zF6fSKsK7J5LuCBSW8vFwK4XxD1L0vuYufe8vjtUiM0QWs9X6DJEAfFJ/gxBlG8Nr4vh2ob+bH07YvR4gsAezF7D4bQEvJUhn2U934uZOFjHkoN924cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ripv8WRYjg7TpyrgkkawEtQ47BbM9DaG2AoOmcMKlbg=;
 b=IPhZi7bwoHRDxZzAHX4pLia9TG1/Y5YKEkQhCt5jN2kBBXlEeP6RBdhhydtLAHN/7DSTVnAeTDqJwdQLMZJwmkMelFd+scq/3bkIyv9xCIpbPCMxJiqGLm9XRrVwpf9gctJ6vL2ZBaM/ZaEcXjg6GZL7vU39OmJWVDzLd3qA6Z9wc10oN3KdT4yogCVKFiFbP8b+X0jsiKkV9SD5/swIa1YpNUKLecEC4sepU7k6uOmlE0oZe/i2aYArprKyAU4igBvxplmzzXwGt0QO39GoFoRoZNA6RdqworLIdV3ioJP6FjTXiju8JXAz1blZrVHC5ID8syIcxaNQw3vFv5jXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ripv8WRYjg7TpyrgkkawEtQ47BbM9DaG2AoOmcMKlbg=;
 b=B4PQBUzIYncH9lGJ8Yj7zpCF9De5fdEpp+0P2h0ZssYIw89vBkmJhVFUGDINjp7sBA4VEC5xFas/+HS5gzM9bxipfm6xSvr2X7iCMahTdadoiUxam8Z1x6c8RT1rdPACg+qqqWMRi/FJ8SVlJF5ytk4Ar6jzSmeeD/E8mmeHKXDmxJ88vM9KvQ99pM205fyE+o5QUXQUrtEGQ+vprjjaEgJugtFsVH46++1UzENeyTzvMWRj4RpXU1Y7KrYB8nYXeMHP5VMicWANiW3IiwW3HqqGo2U90fEfFxBfwwYU+oy3zt5bn3mfNuK0uqsS2Es84kvyO6SyfLTEHzdxljFwMA==
Received: from DB5EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (10.152.20.53) by DB5EUR03HT045.eop-EUR03.prod.protection.outlook.com
 (10.152.21.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.23; Wed, 23 Oct
 2019 17:28:10 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com (10.152.20.57) by
 DB5EUR03FT007.mail.protection.outlook.com (10.152.20.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Wed, 23 Oct 2019 17:28:10 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75]) by VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75%6]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 17:28:10 +0000
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Topic: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Index: AQHVhfzB7lc3mC9pr0OyFBE/io6S3qdoYtGAgAAfrIA=
Date: Wed, 23 Oct 2019 17:28:10 +0000
Message-ID: <VI1PR03MB4814DBEC71814C520D123ADDA46B0@VI1PR03MB4814.eurprd03.prod.outlook.com>
References: <VI1PR03MB481484C08A04458ACA64F7A0A46C0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <dbb363cf-bc3a-6de5-a62a-1467208d0017@redhat.com>
In-Reply-To: <dbb363cf-bc3a-6de5-a62a-1467208d0017@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0143.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::35) To VI1PR03MB4814.eurprd03.prod.outlook.com
 (2603:10a6:803:b7::21)
x-incomingtopheadermarker: OriginalChecksum:8D9C5C23FF54B42C6DD3C06A88BBEA67E711749260089D05102FFA3E8096BE26;
 UpperCasedChecksum:0171775980A43AA9989A761CCD58659B35FB6D4581DB5F16D90EAB10A6AC5535;
 SizeAsReceived:7496; Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: pantheon-mail/1.0.8
x-tmn: [qmoaREQIj8U7ILDrCb42+Ty3c63iA/itlSK2q2v22Ws=]
x-microsoft-original-message-id: <1571851687.2552.0@smtp-mail.outlook.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: DB5EUR03HT045:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jR51QDYRs7GTNtRcrQvXNT0gUwhPjA5tsRtGUomIcZpZpcg0emtKPREIo34o9eIOA1WluA8iG+h295JNe2gcG/W2Ttb+PK2NnqUHFDWa/F50nJsKYEyl6XsU+kNMFpdqbkr8LlR8xN/7nbu03h2YHE+x1S887V1BDC9yLWiRMrt5BM95JKsY4/83UHUoj9Y
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_VI1PR03MB4814DBEC71814C520D123ADDA46B0VI1PR03MB4814eurp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 004a9fc0-4963-4323-3b48-08d757de6002
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 17:28:10.6316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT045
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.72.44
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

--_000_VI1PR03MB4814DBEC71814C520D123ADDA46B0VI1PR03MB4814eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi John,

Thanks for looking into this.
I can quickly repro the problem with qemu 4.0 binary with debugging symbols=
 enabled as I have it available already.
Doing the same with qemu 4.1 or development head may be too much hassle but=
 if it's really the only way I can give it try.

Would it worth it to try with 4.0 first and get the strack trace or it will=
 not help and the only way to go is with 4.1 (or dev)?

Thanks,

Fernando

On mi=E9, oct 23, 2019 at 5:34 PM, John Snow <jsnow@redhat.com> wrote:
On 10/18/19 5:41 PM, Fernando Casas Sch=F6ssow wrote:
Hi,
Hi! Thanks for the report.
Today while working with two different Windows Server 2012 R2 guests I foun=
d that when I try to attach an ISO file to a SCSI CD-ROM device through lib=
virt (virsh or virt-manager) while the guest is running, qemu crashes and t=
he following message is logged: Assertion failed: blk_get_aio_context(d->co=
nf.blk) =3D=3D s->ctx (/home/buildozer/aports/main/qemu/src/qemu-4.0.0/hw/s=
csi/virtio-scsi.c: virtio_scsi_ctx_check: 246) I can repro this at will. Al=
l I have to do is to try to attach an ISO file to the SCSI CDROM while the =
guest is running. The SCSI controller model is virtio-scsi with iothread en=
abled. Please find below all the details about my setup that I considered r=
elevant but I missed something please don't hesitate to let me know:
Looks like we got aio_context management wrong with iothread for the media =
change events somewhere. Should be easy enough to fix if we figure out wher=
e the bad assumption is.
Host arch: x86_64 Distro: Alpine Linux 3.10.2 qemu version: 4.0
Do you have the ability to try 4.1, or the latest development head with deb=
ugging symbols enabled?
Linux kernel version: 4.19.67 libvirt: 5.5.0 Emulated SCSI controller: virt=
io-scsi (with iothread enabled) Guest firmware: OVMF-EFI Guest OS: Window S=
erver 2012 R2 Guest virtio drivers version: 171 (current stable) qemu comma=
nd line: /usr/bin/qemu-system-x86_64 -name guest=3DDCHOMENET01,debug-thread=
s=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvi=
rt/qemu/domain-78-DCHOMENET01/master-key.aes -machine pc-i440fx-4.0,accel=
=3Dkvm,usb=3Doff,dump-guest-core=3Don -cpu IvyBridge,ss=3Don,vmx=3Doff,pcid=
=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=3Don,umip=3Don,xsaveopt=3Don,hv_=
time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -drive file=3D/usr/share/edk=
2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpflash,format=3Draw,unit=3D0,read=
only=3Don -drive file=3D/var/lib/libvirt/qemu/nvram/DCHOMENET01_VARS.fd,if=
=3Dpflash,format=3Draw,unit=3D1 -m 1536 -overcommit mem-lock=3Doff -smp 1,s=
ockets=3D1,cores=3D1,threads=3D1 -object iothread,id=3Diothread1 -uuid f069=
78ad-2734-44ab-a518-5dfcf71d625e -no-user-config -nodefaults -chardev socke=
t,id=3Dcharmonitor,fd=3D33,server,nowait -mon chardev=3Dcharmonitor,id=3Dmo=
nitor,mode=3Dcontrol -rtc base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.=
lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=
=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device qemu-xhci,id=
=3Dusb,bus=3Dpci.0,addr=3D0x4 -device virtio-scsi-pci,iothread=3Diothread1,=
id=3Dscsi0,num_queues=3D1,bus=3Dpci.0,addr=3D0x5 -device virtio-serial-pci,=
id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6 -drive file=3D/storage/storage-h=
dd-vms/virtual_machines_hdd/dchomenet01.qcow2,format=3Dqcow2,if=3Dnone,id=
=3Ddrive-scsi0-0-0-0,cache=3Dnone,discard=3Dunmap,aio=3Dthreads -device scs=
i-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=3Ddrive-scsi0-=
0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1,write-cache=
=3Don -drive if=3Dnone,id=3Ddrive-scsi0-0-0-1,readonly=3Don -device scsi-cd=
,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D1,device_id=3Ddrive-scsi0-0-0-=
1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1 -netdev tap,fd=3D41,id=3Dhostn=
et0,vhost=3Don,vhostfd=3D43 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dn=
et0,mac=3D52:54:00:99:b5:62,bus=3Dpci.0,addr=3D0x3 -chardev socket,id=3Dcha=
rserial0,host=3D127.0.0.1,port=3D4900,telnet,server,nowait -device isa-seri=
al,chardev=3Dcharserial0,id=3Dserial0 -chardev spicevmc,id=3Dcharchannel0,n=
ame=3Dvdagent -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=
=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spice.0 -chardev socket,id=
=3Dcharchannel1,fd=3D45,server,nowait -device virtserialport,bus=3Dvirtio-s=
erial0.0,nr=3D2,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dorg.qemu.guest_=
agent.0 -chardev spiceport,id=3Dcharchannel2,name=3Dorg.spice-space.webdav.=
0 -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D3,chardev=3Dcharchanne=
l2,id=3Dchannel2,name=3Dorg.spice-space.webdav.0 -device virtio-tablet-pci,=
id=3Dinput2,bus=3Dpci.0,addr=3D0x7 -spice port=3D5900,addr=3D127.0.0.1,disa=
ble-ticketing,seamless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_size=
=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_outp=
uts=3D1,bus=3Dpci.0,addr=3D0x2 -chardev spicevmc,id=3Dcharredir0,name=3Dusb=
redir -device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=
=3D2 -chardev spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-redir,ch=
ardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-balloon-=
pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -sandbox on,obsolete=3Ddeny,elevat=
eprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny -msg timestamp=3Don =
I can provide a core dump of the process if needed for debugging and the gu=
est XML as well.
A backtrace is probably a great starting point (from gdb: `thread apply all=
 bt`.) I don't know exactly what codepath is being exercised when you "atta=
ch an ISO file" through libvirt's interface. If you don't mind the hassle, =
trying on the 4.1 (or a development build would be even more luxurious) and=
 giving a stacktrace would be nice.
Thanks. Fernando
Thanks! --js



--_000_VI1PR03MB4814DBEC71814C520D123ADDA46B0VI1PR03MB4814eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <1547E11F092DF548BEC2CEB7BA6DA7C8@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
Hi John,
<div><br>
</div>
<div>Thanks for looking into this.</div>
<div>I can quickly repro the problem with qemu 4.0 binary with debugging sy=
mbols enabled as I have it available already.</div>
<div>Doing the same with qemu 4.1 or development head may be too much hassl=
e but if it's really the only way I can give it try.</div>
<div><br>
</div>
<div>Would it worth it to try with 4.0 first and get the strack trace or it=
 will not help and the only way to go is with 4.1 (or dev)?</div>
<div><br>
</div>
<div>Thanks,</div>
<div><br>
</div>
<div>Fernando</div>
<div><br>
</div>
<div>On mi=E9, oct 23, 2019 at 5:34 PM, John Snow &lt;jsnow@redhat.com&gt; =
wrote:<br>
<blockquote type=3D"cite">
<div class=3D"plaintext" style=3D"white-space: pre-wrap;">On 10/18/19 5:41 =
PM, Fernando Casas Sch=F6ssow wrote:
<blockquote>Hi, </blockquote>
Hi! Thanks for the report.
<blockquote>Today while working with two different Windows Server 2012 R2 g=
uests I found that when I try to attach an ISO file to a SCSI CD-ROM device=
 through libvirt (virsh or virt-manager) while the guest is running, qemu c=
rashes and the following message
 is logged: Assertion failed: blk_get_aio_context(d-&gt;conf.blk) =3D=3D s-=
&gt;ctx (/home/buildozer/aports/main/qemu/src/qemu-4.0.0/hw/scsi/virtio-scs=
i.c: virtio_scsi_ctx_check: 246) I can repro this at will. All I have to do=
 is to try to attach an ISO file to the SCSI
 CDROM while the guest is running. The SCSI controller model is virtio-scsi=
 with iothread enabled. Please find below all the details about my setup th=
at I considered relevant but I missed something please don't hesitate to le=
t me know:
</blockquote>
Looks like we got aio_context management wrong with iothread for the media =
change events somewhere. Should be easy enough to fix if we figure out wher=
e the bad assumption is.
<blockquote>Host arch: x86_64 Distro: Alpine Linux 3.10.2 qemu version: 4.0=
 </blockquote>
Do you have the ability to try 4.1, or the latest development head with deb=
ugging symbols enabled?
<blockquote>Linux kernel version: 4.19.67 libvirt: 5.5.0 Emulated SCSI cont=
roller: virtio-scsi (with iothread enabled) Guest firmware: OVMF-EFI Guest =
OS: Window Server 2012 R2 Guest virtio drivers version: 171 (current stable=
) qemu command line: /usr/bin/qemu-system-x86_64
 -name guest=3DDCHOMENET01,debug-threads=3Don -S -object secret,id=3Dmaster=
Key0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-78-DCHOMENET01/master=
-key.aes -machine pc-i440fx-4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Don =
-cpu IvyBridge,ss=3Don,vmx=3Doff,pcid=3Don,hypervisor=3Don,arat=3Don,tsc_ad=
just=3Don,umip=3Don,xsaveopt=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=
=3D0x1fff
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
control=3Ddeny -msg timestamp=3Don I can provide a core dump of the process=
 if needed for debugging and the guest XML as well.
</blockquote>
A backtrace is probably a great starting point (from gdb: `thread apply all=
 bt`.) I don't know exactly what codepath is being exercised when you &quot=
;attach an ISO file&quot; through libvirt's interface. If you don't mind th=
e hassle, trying on the 4.1 (or a development
 build would be even more luxurious) and giving a stacktrace would be nice.
<blockquote>Thanks. Fernando </blockquote>
Thanks! --js </div>
</blockquote>
<br>
<br>
</div>
</body>
</html>

--_000_VI1PR03MB4814DBEC71814C520D123ADDA46B0VI1PR03MB4814eurp_--

