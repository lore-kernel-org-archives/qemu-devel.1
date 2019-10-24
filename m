Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18911CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A8120650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLOqYyKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A8120650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfoa-0005aU-Jx
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iNefS-0004n0-5E
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iNefQ-0004G1-Nd
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:04:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35768
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iNefQ-0004Fr-Jk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571929488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GiMr20w2rI1E2fFgdOUikpMrLQV+Up+oJpdVo2qzyU=;
 b=SLOqYyKDuM3Ivp7fYoSKcAqK9Pnbvh3RM/9pnFoSnXU+VB/dKsHT3VvvtkInmoexn8Oozm
 atxdEn5oSuvT/hmuncF6CgBO4VTyRRgW/muC/TapoTye9XlZpJabluOKiZK1jhDwx7UqUz
 3Ptpko6jtftp82Zb75AJpYMCDTlXam8=
Received: from mimecast-mx01.redhat.com (209.132.183.4 [209.132.183.4])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-1I2SLdhwPbaY-oanSqFgNA-1; Thu, 24 Oct 2019 11:04:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42615476;
 Thu, 24 Oct 2019 15:02:34 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEEF1196B2;
 Thu, 24 Oct 2019 15:02:33 +0000 (UTC)
Date: Thu, 24 Oct 2019 09:02:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: Cannot use more than one MSI interrupts
Message-ID: <20191024090233.3a532ff6@x1.home>
In-Reply-To: <MN2PR02MB62053C534A3F1406267EBC4C8B6A0@MN2PR02MB6205.namprd02.prod.outlook.com>
References: <MN2PR02MB62053C534A3F1406267EBC4C8B6A0@MN2PR02MB6205.namprd02.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 1I2SLdhwPbaY-oanSqFgNA-1
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 14:45:28 +0000
Thanos Makatos <thanos.makatos@nutanix.com> wrote:

> I have a Ubuntu VM (4.15.0-48-generic) to which I pass through a PCI devi=
ce,
> specifically a virtual NVMe controller. The problem I have is that only o=
ne I/O queue
> is initialized, while there should be more (e.g. four). I'm using upstrea=
m QEMU
> v4.1.0 confgiured without any additional options. Most likely there's som=
ething
> broken with my virtual device implementation but I can't figure out exact=
ly
> what, I was hoping to get some debugging directions.
>=20
> I run QEMU as follows:
>=20
> ~/src/qemu/x86_64-softmmu/qemu-system-x86_64 \
>         -kernel bionic-server-cloudimg-amd64-vmlinuz-generic \
>         -smp cores=3D2,sockets=3D2 \
>         -nographic \
>         -append "console=3DttyS0 root=3D/dev/sda1 single nvme.sgl_thresho=
ld=3D0 nokaslr nvme.io_queue_depth=3D4" \
>         -initrd bionic-server-cloudimg-amd64-initrd-generic \
>         -hda bionic-server-cloudimg-amd64.raw \
>         -hdb data.raw \
>         -m 1G \
>         -object memory-backend-file,id=3Dram-node0,prealloc=3Dyes,mem-pat=
h=3Dmem,share=3Dyes,size=3D1073741824 -numa node,nodeid=3D0,cpus=3D0-3,memd=
ev=3Dram-node0 \
>         -device vfio-pci,sysfsdev=3D/sys/bus/mdev/devices/00000000-0000-0=
000-0000-000000000000 \
>         -trace enable=3Dvfio*,file=3Dqemu.trace \
>         -net none \
>         -s
>=20
> This is what QEMU thinks of the devices:
>=20
> (qemu) info pci
>   Bus  0, device   0, function 0:
>     Host bridge: PCI device 8086:1237
>       PCI subsystem 1af4:1100
>       id ""
>   Bus  0, device   1, function 0:
>     ISA bridge: PCI device 8086:7000
>       PCI subsystem 1af4:1100
>       id ""
>   Bus  0, device   1, function 1:
>     IDE controller: PCI device 8086:7010
>       PCI subsystem 1af4:1100
>       BAR4: I/O at 0xc000 [0xc00f].
>       id ""
>   Bus  0, device   1, function 3:
>     Bridge: PCI device 8086:7113
>       PCI subsystem 1af4:1100
>       IRQ 9.
>       id ""
>   Bus  0, device   2, function 0:
>     VGA controller: PCI device 1234:1111
>       PCI subsystem 1af4:1100
>       BAR0: 32 bit prefetchable memory at 0xfd000000 [0xfdffffff].
>       BAR2: 32 bit memory at 0xfebf4000 [0xfebf4fff].
>       BAR6: 32 bit memory at 0xffffffffffffffff [0x0000fffe].
>       id ""
>   Bus  0, device   3, function 0:
>     Class 0264: PCI device 4e58:0001
>       PCI subsystem 0000:0000
>       IRQ 11.
>       BAR0: 32 bit memory at 0xfebf0000 [0xfebf3fff].
>       id ""
>=20
> And this is what the guest thinks of the device in question:
>=20
> root@ubuntu:~# lspci -vvv -s 00:03.0
> 00:03.0 Non-Volatile memory controller: Device 4e58:0001 (prog-if 02 [NVM=
 Express])
>         Physical Slot: 3
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 24
>         NUMA node: 0
>         Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=3D1=
6K]
>         Capabilities: [40] Power Management version 0
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,=
D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME=
-
>         Capabilities: [48] MSI: Enable+ Count=3D1/4 Maskable- 64bit+
>                 Address: 00000000fee01004  Data: 4023
>         Capabilities: [60] Express (v1) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <6=
4ns, L1 <1us
>                         ExtTag- AttnBtn+ AttnInd- PwrInd- RBE- FLReset- S=
lotPowerLimit 128.000W
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Uns=
upported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- =
TransPend-
>                 LnkCap: Port #0, Speed unknown, Width x0, ASPM not suppor=
ted, Exit Latency L0s <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- D=
LActive- BWMgmt- ABWMgmt-
>         Kernel driver in use: nvme
>         Kernel modules: nvme
>=20
> I tried debugging the guest kernel and I think the following if is taken =
in
> pci_msi_domain_check_cap():
>=20
> if (pci_msi_desc_is_multi_msi(desc) &&
>     !(info->flags & MSI_FLAG_MULTI_PCI_MSI))                    =20
>         return 1;
>=20
> because flags is 0x3b (MSI_FLAG_MULTI_PCI_MSI is 0x4). And this I think m=
eans
> that MSI_FLAG_MULTI_PCI_MSI is not set for that msi_domain_info.
>=20
> # grep -i msi qemu.trace
> 1327@1571926064.595365:vfio_msi_setup 00000000-0000-0000-0000-00000000000=
0 PCI MSI CAP @0x48
> 1334@1571926073.489691:vfio_msi_enable  (00000000-0000-0000-0000-00000000=
0000) Enabled 1 MSI vectors
> 1334@1571926073.501741:vfio_msi_disable  (00000000-0000-0000-0000-0000000=
00000)
> 1334@1571926073.507127:vfio_msi_enable  (00000000-0000-0000-0000-00000000=
0000) Enabled 1 MSI vectors
> 1327@1571926073.520840:vfio_msi_interrupt  (00000000-0000-0000-0000-00000=
0000000) vector 0 0xfee01004/0x4023
> ... more vfio_msi_interrupt ...
>=20
> How can I further debug this?

The quick answer is to implement MSI-X in your device, MSI requires a
contiguous block of vectors and there's limited support for actually
making use of more than a single vector.  There is almost no real
hardware that doesn't implement MSI-X for multiple vector support.
Thanks,

Alex


