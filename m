Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A6CCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C3420663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFiPr59W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C3420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNMCn-0003g6-R5
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 15:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iNKWO-0004cQ-A8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iNKWM-00021B-Ic
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iNKWM-00020W-BW
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lX/3QxEsVxDkQeF2JlWiQZAaJNICVWnllYRdeXZE0zg=;
 b=MFiPr59WcLLeLp1EMrRRArl23QUUaX1bJ+FlucUbCUaB3td/jhu+56JeGxsHVKvF0G6A7B
 0vZcJJvfVIalYgl0TMA2yNKZzJwMzfxWsnI/lIWdrWjYgKKAjfpGPmoLom3aPr65NJRxfN
 e9s+Z+fGAxQ/nu+KY2KiNVu94n+kGfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-8LlAzWhINzqgD_3Fi8Y9Lg-1; Wed, 23 Oct 2019 13:34:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF0DC800D62;
 Wed, 23 Oct 2019 17:34:00 +0000 (UTC)
Received: from [10.10.121.155] (ovpn-121-155.rdu2.redhat.com [10.10.121.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 458845DC18;
 Wed, 23 Oct 2019 17:34:00 +0000 (UTC)
Subject: Re: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
To: =?UTF-8?Q?Fernando_Casas_Sch=c3=b6ssow?= <casasfernando@outlook.com>
References: <VI1PR03MB481484C08A04458ACA64F7A0A46C0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <dbb363cf-bc3a-6de5-a62a-1467208d0017@redhat.com>
 <VI1PR03MB4814DBEC71814C520D123ADDA46B0@VI1PR03MB4814.eurprd03.prod.outlook.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <73ddcea3-0e0a-45be-55e7-bca81076c12d@redhat.com>
Date: Wed, 23 Oct 2019 13:33:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <VI1PR03MB4814DBEC71814C520D123ADDA46B0@VI1PR03MB4814.eurprd03.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8LlAzWhINzqgD_3Fi8Y9Lg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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



On 10/23/19 1:28 PM, Fernando Casas Sch=F6ssow wrote:
> Hi John,
>=20
> Thanks for looking into this.
> I can quickly repro the problem with qemu 4.0 binary with debugging
> symbols enabled as I have it available already.
> Doing the same with qemu 4.1 or development head may be too much hassle
> but if it's really the only way I can give it try.
>=20
> Would it worth it to try with 4.0 first and get the strack trace or it
> will not help and the only way to go is with 4.1 (or dev)?
>=20
> Thanks,
>=20
> Fernando
>=20

If 4.0 is what you have access to, having the stack trace for that is
better than not, but confirming it happens on the latest release would
be nice.

Can you share your workflow for virsh that reproduces the failure?

--js

> On mi=E9, oct 23, 2019 at 5:34 PM, John Snow <jsnow@redhat.com> wrote:
>> On 10/18/19 5:41 PM, Fernando Casas Sch=F6ssow wrote:
>>
>>     Hi,=20
>>
>> Hi! Thanks for the report.
>>
>>     Today while working with two different Windows Server 2012 R2
>>     guests I found that when I try to attach an ISO file to a SCSI
>>     CD-ROM device through libvirt (virsh or virt-manager) while the
>>     guest is running, qemu crashes and the following message is
>>     logged: Assertion failed: blk_get_aio_context(d->conf.blk) =3D=3D
>>     s->ctx
>>     (/home/buildozer/aports/main/qemu/src/qemu-4.0.0/hw/scsi/virtio-scsi=
.c:
>>     virtio_scsi_ctx_check: 246) I can repro this at will. All I have
>>     to do is to try to attach an ISO file to the SCSI CDROM while the
>>     guest is running. The SCSI controller model is virtio-scsi with
>>     iothread enabled. Please find below all the details about my setup
>>     that I considered relevant but I missed something please don't
>>     hesitate to let me know:=20
>>
>> Looks like we got aio_context management wrong with iothread for the
>> media change events somewhere. Should be easy enough to fix if we
>> figure out where the bad assumption is.
>>
>>     Host arch: x86_64 Distro: Alpine Linux 3.10.2 qemu version: 4.0=20
>>
>> Do you have the ability to try 4.1, or the latest development head
>> with debugging symbols enabled?
>>
>>     Linux kernel version: 4.19.67 libvirt: 5.5.0 Emulated SCSI
>>     controller: virtio-scsi (with iothread enabled) Guest firmware:
>>     OVMF-EFI Guest OS: Window Server 2012 R2 Guest virtio drivers
>>     version: 171 (current stable) qemu command line:
>>     /usr/bin/qemu-system-x86_64 -name
>>     guest=3DDCHOMENET01,debug-threads=3Don -S -object
>>     secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/dom=
ain-78-DCHOMENET01/master-key.aes
>>     -machine pc-i440fx-4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Don -c=
pu
>>     IvyBridge,ss=3Don,vmx=3Doff,pcid=3Don,hypervisor=3Don,arat=3Don,tsc_=
adjust=3Don,umip=3Don,xsaveopt=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlock=
s=3D0x1fff
>>     -drive
>>     file=3D/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpflas=
h,format=3Draw,unit=3D0,readonly=3Don
>>     -drive
>>     file=3D/var/lib/libvirt/qemu/nvram/DCHOMENET01_VARS.fd,if=3Dpflash,f=
ormat=3Draw,unit=3D1
>>     -m 1536 -overcommit mem-lock=3Doff -smp
>>     1,sockets=3D1,cores=3D1,threads=3D1 -object iothread,id=3Diothread1 =
-uuid
>>     f06978ad-2734-44ab-a518-5dfcf71d625e -no-user-config -nodefaults
>>     -chardev socket,id=3Dcharmonitor,fd=3D33,server,nowait -mon
>>     chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
>>     base=3Dlocaltime,driftfix=3Dslew -global
>>     kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global
>>     PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot
>>     strict=3Don -device qemu-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x4 -devic=
e
>>     virtio-scsi-pci,iothread=3Diothread1,id=3Dscsi0,num_queues=3D1,bus=
=3Dpci.0,addr=3D0x5
>>     -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6
>>     -drive
>>     file=3D/storage/storage-hdd-vms/virtual_machines_hdd/dchomenet01.qco=
w2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,cache=3Dnone,discard=3Du=
nmap,aio=3Dthreads
>>     -device
>>     scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=3Ddr=
ive-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1,wr=
ite-cache=3Don
>>     -drive if=3Dnone,id=3Ddrive-scsi0-0-0-1,readonly=3Don -device
>>     scsi-cd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D1,device_id=3Ddr=
ive-scsi0-0-0-1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1
>>     -netdev tap,fd=3D41,id=3Dhostnet0,vhost=3Don,vhostfd=3D43 -device
>>     virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:99:b5:62,b=
us=3Dpci.0,addr=3D0x3
>>     -chardev
>>     socket,id=3Dcharserial0,host=3D127.0.0.1,port=3D4900,telnet,server,n=
owait -device
>>     isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
>>     spicevmc,id=3Dcharchannel0,name=3Dvdagent -device
>>     virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,=
id=3Dchannel0,name=3Dcom.redhat.spice.0
>>     -chardev socket,id=3Dcharchannel1,fd=3D45,server,nowait -device
>>     virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dcharchannel1,=
id=3Dchannel1,name=3Dorg.qemu.guest_agent.0
>>     -chardev spiceport,id=3Dcharchannel2,name=3Dorg.spice-space.webdav.0
>>     -device
>>     virtserialport,bus=3Dvirtio-serial0.0,nr=3D3,chardev=3Dcharchannel2,=
id=3Dchannel2,name=3Dorg.spice-space.webdav.0
>>     -device virtio-tablet-pci,id=3Dinput2,bus=3Dpci.0,addr=3D0x7 -spice
>>     port=3D5900,addr=3D127.0.0.1,disable-ticketing,seamless-migration=3D=
on
>>     -device
>>     qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_=
size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2
>>     -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir -device
>>     usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -cha=
rdev
>>     spicevmc,id=3Dcharredir1,name=3Dusbredir -device
>>     usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -dev=
ice
>>     virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -sandbox
>>     on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecon=
trol=3Ddeny
>>     -msg timestamp=3Don I can provide a core dump of the process if
>>     needed for debugging and the guest XML as well.=20
>>
>> A backtrace is probably a great starting point (from gdb: `thread
>> apply all bt`.) I don't know exactly what codepath is being exercised
>> when you "attach an ISO file" through libvirt's interface. If you
>> don't mind the hassle, trying on the 4.1 (or a development build would
>> be even more luxurious) and giving a stacktrace would be nice.
>>
>>     Thanks. Fernando=20
>>
>> Thanks! --js
>=20
>=20


