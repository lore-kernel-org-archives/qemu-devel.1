Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE3C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDCC21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="fzIM5XNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDCC21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifrxY-00046O-QM
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 15:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <julio.montes@intel.com>) id 1ifrwm-0003ah-Jq
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1ifrwj-00036v-VH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:53:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:62958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1ifrwj-0002eu-Cs
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:53:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Dec 2019 12:53:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
 d="scan'208,217";a="297032910"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by orsmga001.jf.intel.com with ESMTP; 13 Dec 2019 12:53:47 -0800
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Dec 2019 12:53:47 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX123.amr.corp.intel.com (10.22.240.116) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Dec 2019 12:53:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Dec 2019 12:53:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVU/DUknmEZWXfOymsOnZK1rI0q6t5oM4bmOWSaVfaBsskDWmtTalNxYPXVnJOEf1lnRP5nrtZUSfOotJXMtOAB1Qip7eD+ewLtz+ZEkCRmUqIxqBHsS3Iz+ZvneycTDP2u+/6bttbMVNNt9Q7NfE26QYTFz939aE7Hj3FkwSHtPjZY+kHMao6seOYjQtDAYXWzjbGg6tDyx46Xqf9UOYyLpHFrQq3NAJLA9PkWqOwSJwNUACJlXL/RYpO6nz/aLS1sCe9JKF5fuKbrbDmAZxJtJbmqLeICr90qioPv7JtqyJedK7ZcX3fRUFB7GBiK7Tx37d1BSfvxJezSs47ItsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS9AN/niKsT6FrXu5eR36sogXPqdZEO6VCT1EzphAsY=;
 b=FXzENS7OYTPwAQJO2I/b5/GuXYpbPVM0S5SPrxQBgwgA63X26pY9c9yPodLuYT5cnJh2Y2j13Hi29pea8yHULidJOHzInSh0fmTBz4QkGe0meYM+hDKgJv3wURMcawxAlPX76VVY3SLS9hXcpEYbW96dDMqGZwfhfRMoCGVyd/6Ceg4Cp8Dmt8wqA8xVH4aynAbTW8za2BdWU4iPirC4w+oFf3D6vGlPd2yRCNldo8IihC9PvA4eoLEveStbgu+71deR4kPNHVYZOWvrcrgswKRpMOf4Y/Ow5SS1Jn4xd6v3q6NQ74P1r1kOwp0zLi/DCwRAbynsAT+VTB75cNOnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS9AN/niKsT6FrXu5eR36sogXPqdZEO6VCT1EzphAsY=;
 b=fzIM5XNIoHvuchQPBXAWtPKgkWO2B5AlRUdVYafMPQ69byQbNaS1IN/fgYKhaWNk7b3DvyBU+GY5QTpkNGNP3I/ZbHC223kSU9vNuRpQHtfylvMwmtqnYPx+W/jLwNgPo3dMv329TJhwxzRphW3QnlVIMb9GNGrg18n733Sams8=
Received: from DM6PR11MB4089.namprd11.prod.outlook.com (20.176.126.91) by
 DM6PR11MB3017.namprd11.prod.outlook.com (20.177.219.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 13 Dec 2019 20:53:46 +0000
Received: from DM6PR11MB4089.namprd11.prod.outlook.com
 ([fe80::80a6:f5df:aaf0:eb7c]) by DM6PR11MB4089.namprd11.prod.outlook.com
 ([fe80::80a6:f5df:aaf0:eb7c%7]) with mapi id 15.20.2538.016; Fri, 13 Dec 2019
 20:53:46 +0000
From: "Montes, Julio" <julio.montes@intel.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertion `ret
 == cpu->kvm_msr_buf->nmsrs' failed.
Thread-Topic: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertion
 `ret == cpu->kvm_msr_buf->nmsrs' failed.
Thread-Index: AQHVsfc5K/GHgo1+SUW1rgjP3fus/w==
Date: Fri, 13 Dec 2019 20:53:46 +0000
Message-ID: <DM6PR11MB4089A0B695CB84FB288068B89A540@DM6PR11MB4089.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=julio.montes@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e5ab957-3389-4be1-52bb-08d7800e8bf8
x-ms-traffictypediagnostic: DM6PR11MB3017:
x-microsoft-antispam-prvs: <DM6PR11MB3017B5B5DDAC82AF226A7DEC9A540@DM6PR11MB3017.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39860400002)(396003)(376002)(366004)(346002)(189003)(199004)(64756008)(86362001)(66476007)(7696005)(66446008)(8936002)(76116006)(6506007)(9686003)(71200400001)(26005)(186003)(66556008)(81156014)(8676002)(2906002)(81166006)(5660300002)(6916009)(66946007)(33656002)(52536014)(19627405001)(55016002)(316002)(478600001)(81973001)(473944003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR11MB3017;
 H:DM6PR11MB4089.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k1o8XIIwzxqA+xXez/LQ3YJQ+y0xy2ojPMlnxQCAHy77b4GCWpcHQCTjZxl7iu6Feu+wYXZInZL4WTXeLMPm77zQsGt8J2Rob5xFq+2sDYREgJorO3pPybL0fMe2PWCSb0XvE+OgDA0wPQdwgSbXZ9yuYDm7NecB0dM/3P/sVtTUU+FbPaNijYR3wR091rcuxSiw/FgoCfG0GMoe08nuIWLQX3oKLOrWSsZIUJb4q/YXbtndGw+BNnYjjz/zBcwsNw+lIQnm7USbhE326+ahoz7E9bID1wdKM0NcyhMqcvbaTHM2zKwLFuONpmbzWAeelXGtaJDD1miArKncZ/ww2P4+Y2ug751WCqeZX1O3FIS8kyNjmDrDCY2pMrsodLEUfHRN5g+O4K7nnkSsbUMHrZ1bRTT1kifqooJ+GMkXXrUXersQsr11FlIsTkJBCWNYA+EpY50e2JJKasGa/zo4dtYoAxChaNLSCuWUhL6BNhWFvGPKJMYoAPOlECEyA3GhRhqflrcDB4zc27AHme40Dw==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR11MB4089A0B695CB84FB288068B89A540DM6PR11MB4089namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5ab957-3389-4be1-52bb-08d7800e8bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 20:53:46.1269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWhDBDKtK6N+5DBJ9Pvf0F2CXb3f3SanfDAN3f/35hw8au/pzIVZzUFhcfWfgU5zbz80YvBTFUkR+RojPHk9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3017
X-OriginatorOrg: intel.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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

--_000_DM6PR11MB4089A0B695CB84FB288068B89A540DM6PR11MB4089namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi folks

I'm trying to run qemu 4.2.0 in azure VMs, unfourtunately qemu fails:

failed to launch qemu: exit status 1, error messages from qemu log: qemu-sy=
stem-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000
qemu-system-x86_64: /root/qemu/target/i386/kvm.c:2947: kvm_put_msrs: Assert=
ion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

I'm using the following command line:

qemu-system-x86_64 -machine pc,accel=3Dkvm,kernel_irqchip,nvdimm -cpu host,=
pmu=3Doff \
-qmp unix:qmp.sock,server,nowait -m 2048M,slots=3D10,maxmem=3D8977M -device=
 pci-bridge,bus=3Dpci.0,id=3Dpci-bridge-0,chassis_nr=3D1,shpc=3Don,addr=3D2=
,romfile=3D \
-device virtio-serial-pci,disable-modern=3Dtrue,id=3Dserial0,romfile=3D -de=
vice virtconsole,chardev=3Dcharconsole0,id=3Dconsole0 \
-chardev socket,id=3Dcharconsole0,path=3Dconsole.sock,server,nowait -device=
 nvdimm,id=3Dnv0,memdev=3Dmem0 \
-object memory-backend-file,id=3Dmem0,mem-path=3Dkata-containers.img,size=
=3D134217728 -device virtio-scsi-pci,id=3Dscsi0,disable-modern=3Dtrue,romfi=
le=3D \
-object rng-random,id=3Drng0,filename=3D/dev/urandom -device virtio-rng,rng=
=3Drng0,romfile=3D -device virtserialport,chardev=3Dcharch0,id=3Dchannel0,n=
ame=3Dagent.channel.0 \
-chardev socket,id=3Dcharch0,path=3Dkata.sock,server,nowait -device virtio-=
9p-pci,disable-modern=3Dtrue,fsdev=3Dextra-9p-kataShared,mount_tag=3DkataSh=
ared,romfile=3D \
-fsdev local,id=3Dextra-9p-kataShared,path=3D/run/kata-containers/shared/sa=
ndboxes,security_model=3Dnone -netdev tap,id=3Dnetwork-0,vhost=3Don,vhostfd=
s=3D3,fds=3D4 \
-device driver=3Dvirtio-net-pci,netdev=3Dnetwork-0,mac=3Dea:4a:b6:1a:92:72,=
disable-modern=3Dtrue,mq=3Don,vectors=3D4,romfile=3D \
-global kvm-pit.lost_tick_policy=3Ddiscard -vga none -no-user-config -nodef=
aults -nographic -daemonize -object memory-backend-ram,id=3Ddimm1,size=3D20=
48M \
-numa node,memdev=3Ddimm1 -kernel /usr/share/kata-containers/vmlinuz-4.19.8=
6-60 \
-append "tsc=3Dreliable no_timer_check rcupdate.rcu_expedited=3D1 i8042.dir=
ect=3D1 i8042.dumbkbd=3D1 i8042.nopnp=3D1 i8042.noaux=3D1 noreplace-smp reb=
oot=3Dk \
console=3Dhvc0 console=3Dhvc1 iommu=3Doff cryptomgr.notests net.ifnames=3D0=
 pci=3Dlastbus=3D0 root=3D/dev/pmem0p1 rootflags=3Ddax,data=3Dordered,error=
s=3Dremount-ro \
ro rootfstype=3Dext4 debug systemd.show_status=3Dtrue systemd.log_level=3Dd=
ebug panic=3D1 nr_cpus=3D2 agent.use_vsock=3Dfalse systemd.unit=3Dkata-cont=
ainers.target \
systemd.mask=3Dsystemd-networkd.service systemd.mask=3Dsystemd-networkd.soc=
ket agent.log=3Ddebug agent.log=3Ddebug" \
-pidfile pid -D qemu.log -smp 1,cores=3D1,threads=3D1,sockets=3D2,maxcpus=
=3D2

Qemu 4.1.0 works fine
Qemu 4.2.0 **only** fails in azure VMs, in my workstation it works fine

any thoughts?


Information about the VM:

$ cat /sys/module/kvm_intel/parameters/nested
Y

$ cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 79
model name : Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz
stepping : 1
microcode : 0xffffffff
cpu MHz : 2294.685
cache size : 51200 KB
physical id : 0
siblings : 2
core id : 0
cpu cores : 1
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 20
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat p=
se36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_=
tsc rep_good nopl xtopology cpuid pni pclmulqdq vmx ssse3 fma cx16 pcid sse=
4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3d=
nowprefetch invpcid_single pti tpr_shadow vnmi ept vpid fsgsbase bmi1 hle a=
vx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt md_clear
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs=
 taa itlb_multihit
bogomips : 4589.37
clflush size : 64
cache_alignment : 64
address sizes : 44 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 79
model name : Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz
stepping : 1
microcode : 0xffffffff
cpu MHz : 2294.685
cache size : 51200 KB
physical id : 0
siblings : 2
core id : 0
cpu cores : 1
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 20
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat p=
se36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_=
tsc rep_good nopl xtopology cpuid pni pclmulqdq vmx ssse3 fma cx16 pcid sse=
4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3d=
nowprefetch invpcid_single pti tpr_shadow vnmi ept vpid fsgsbase bmi1 hle a=
vx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt md_clear
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs=
 taa itlb_multihit
bogomips : 4589.37
clflush size : 64
cache_alignment : 64
address sizes : 44 bits physical, 48 bits virtual
power management:

$ uname -a
Linux testcrio1 5.0.0-1027-azure #29~18.04.1-Ubuntu SMP Mon Nov 25 21:18:57=
 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

Thanks

-
Julio



--_000_DM6PR11MB4089A0B695CB84FB288068B89A540DM6PR11MB4089namp_
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
<span>Hi folks <br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div><br>
</div>
<div>I'm trying to run qemu 4.2.0 in azure VMs, unfourtunately qemu fails:<=
br>
</div>
<div><br>
</div>
<div>failed to launch qemu: exit status 1, error messages from qemu log: qe=
mu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000<br>
</div>
<div>qemu-system-x86_64: /root/qemu/target/i386/kvm.c:2947: kvm_put_msrs: A=
ssertion `ret =3D=3D cpu-&gt;kvm_msr_buf-&gt;nmsrs' failed.<br>
</div>
<div><br>
</div>
<div>I'm using the following command line:<br>
</div>
<div><br>
</div>
<div>qemu-system-x86_64 -machine pc,accel=3Dkvm,kernel_irqchip,nvdimm -cpu =
host,pmu=3Doff \<br>
</div>
<div>-qmp unix:qmp.sock,server,nowait -m 2048M,slots=3D10,maxmem=3D8977M -d=
evice pci-bridge,bus=3Dpci.0,id=3Dpci-bridge-0,chassis_nr=3D1,shpc=3Don,add=
r=3D2,romfile=3D \<br>
</div>
<div>-device virtio-serial-pci,disable-modern=3Dtrue,id=3Dserial0,romfile=
=3D -device virtconsole,chardev=3Dcharconsole0,id=3Dconsole0 \<br>
</div>
<div>-chardev socket,id=3Dcharconsole0,path=3Dconsole.sock,server,nowait -d=
evice nvdimm,id=3Dnv0,memdev=3Dmem0 \<br>
</div>
<div>-object memory-backend-file,id=3Dmem0,mem-path=3Dkata-containers.img,s=
ize=3D134217728 -device virtio-scsi-pci,id=3Dscsi0,disable-modern=3Dtrue,ro=
mfile=3D \<br>
</div>
<div>-object rng-random,id=3Drng0,filename=3D/dev/urandom -device virtio-rn=
g,rng=3Drng0,romfile=3D -device virtserialport,chardev=3Dcharch0,id=3Dchann=
el0,name=3Dagent.channel.0 \<br>
</div>
<div>-chardev socket,id=3Dcharch0,path=3Dkata.sock,server,nowait -device vi=
rtio-9p-pci,disable-modern=3Dtrue,fsdev=3Dextra-9p-kataShared,mount_tag=3Dk=
ataShared,romfile=3D \<br>
</div>
<div>-fsdev local,id=3Dextra-9p-kataShared,path=3D/run/kata-containers/shar=
ed/sandboxes,security_model=3Dnone -netdev tap,id=3Dnetwork-0,vhost=3Don,vh=
ostfds=3D3,fds=3D4 \<br>
</div>
<div>-device driver=3Dvirtio-net-pci,netdev=3Dnetwork-0,mac=3Dea:4a:b6:1a:9=
2:72,disable-modern=3Dtrue,mq=3Don,vectors=3D4,romfile=3D \<br>
</div>
<div>-global kvm-pit.lost_tick_policy=3Ddiscard -vga none -no-user-config -=
nodefaults -nographic -daemonize -object memory-backend-ram,id=3Ddimm1,size=
=3D2048M \<br>
</div>
<div>-numa node,memdev=3Ddimm1 -kernel /usr/share/kata-containers/vmlinuz-4=
.19.86-60 \<br>
</div>
<div>-append &quot;tsc=3Dreliable no_timer_check rcupdate.rcu_expedited=3D1=
 i8042.direct=3D1 i8042.dumbkbd=3D1 i8042.nopnp=3D1 i8042.noaux=3D1 norepla=
ce-smp reboot=3Dk \<br>
</div>
<div>console=3Dhvc0 console=3Dhvc1 iommu=3Doff cryptomgr.notests net.ifname=
s=3D0 pci=3Dlastbus=3D0 root=3D/dev/pmem0p1 rootflags=3Ddax,data=3Dordered,=
errors=3Dremount-ro \<br>
</div>
<div>ro rootfstype=3Dext4 debug systemd.show_status=3Dtrue systemd.log_leve=
l=3Ddebug panic=3D1 nr_cpus=3D2 agent.use_vsock=3Dfalse systemd.unit=3Dkata=
-containers.target \<br>
</div>
<div>systemd.mask=3Dsystemd-networkd.service systemd.mask=3Dsystemd-network=
d.socket agent.log=3Ddebug agent.log=3Ddebug&quot; \<br>
</div>
<div>-pidfile pid -D qemu.log -smp 1,cores=3D1,threads=3D1,sockets=3D2,maxc=
pus=3D2<br>
</div>
<div><br>
</div>
<div>
<div>Qemu 4.1.0 works fine<br>
</div>
<div>Qemu 4.2.0 **only** fails in azure VMs, in my workstation it works fin=
e<br>
</div>
<br>
</div>
<div>any thoughts?<br>
</div>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Information about the VM:<br>
<div><br>
</div>
<div>$ cat /sys/module/kvm_intel/parameters/nested<br>
</div>
<div>Y<br>
</div>
<div><br>
</div>
<div>$ cat /proc/cpuinfo <br>
</div>
<div>processor : 0<br>
</div>
<div>vendor_id : GenuineIntel<br>
</div>
<div>cpu family : 6<br>
</div>
<div>model : 79<br>
</div>
<div>model name : Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz<br>
</div>
<div>stepping : 1<br>
</div>
<div>microcode : 0xffffffff<br>
</div>
<div>cpu MHz : 2294.685<br>
</div>
<div>cache size : 51200 KB<br>
</div>
<div>physical id : 0<br>
</div>
<div>siblings : 2<br>
</div>
<div>core id : 0<br>
</div>
<div>cpu cores : 1<br>
</div>
<div>apicid : 0<br>
</div>
<div>initial apicid : 0<br>
</div>
<div>fpu : yes<br>
</div>
<div>fpu_exception : yes<br>
</div>
<div>cpuid level : 20<br>
</div>
<div>wp : yes<br>
</div>
<div>flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm cons=
tant_tsc rep_good nopl xtopology cpuid pni pclmulqdq vmx ssse3 fma cx16 pci=
d sse4_1 sse4_2 movbe popcnt aes
 xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single =
pti tpr_shadow vnmi ept vpid fsgsbase bmi1 hle avx2 smep bmi2 erms invpcid =
rtm rdseed adx smap xsaveopt md_clear<br>
</div>
<div>bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds s=
wapgs taa itlb_multihit<br>
</div>
<div>bogomips : 4589.37<br>
</div>
<div>clflush size : 64<br>
</div>
<div>cache_alignment : 64<br>
</div>
<div>address sizes : 44 bits physical, 48 bits virtual<br>
</div>
<div>power management:<br>
</div>
<div><br>
</div>
<div>processor : 1<br>
</div>
<div>vendor_id : GenuineIntel<br>
</div>
<div>cpu family : 6<br>
</div>
<div>model : 79<br>
</div>
<div>model name : Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz<br>
</div>
<div>stepping : 1<br>
</div>
<div>microcode : 0xffffffff<br>
</div>
<div>cpu MHz : 2294.685<br>
</div>
<div>cache size : 51200 KB<br>
</div>
<div>physical id : 0<br>
</div>
<div>siblings : 2<br>
</div>
<div>core id : 0<br>
</div>
<div>cpu cores : 1<br>
</div>
<div>apicid : 1<br>
</div>
<div>initial apicid : 1<br>
</div>
<div>fpu : yes<br>
</div>
<div>fpu_exception : yes<br>
</div>
<div>cpuid level : 20<br>
</div>
<div>wp : yes<br>
</div>
<div>flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm cons=
tant_tsc rep_good nopl xtopology cpuid pni pclmulqdq vmx ssse3 fma cx16 pci=
d sse4_1 sse4_2 movbe popcnt aes
 xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single =
pti tpr_shadow vnmi ept vpid fsgsbase bmi1 hle avx2 smep bmi2 erms invpcid =
rtm rdseed adx smap xsaveopt md_clear<br>
</div>
<div>bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds s=
wapgs taa itlb_multihit<br>
</div>
<div>bogomips : 4589.37<br>
</div>
<div>clflush size : 64<br>
</div>
<div>cache_alignment : 64<br>
</div>
<div>address sizes : 44 bits physical, 48 bits virtual<br>
</div>
<div>power management:<br>
</div>
<div><br>
</div>
<div>$ uname -a<br>
</div>
<div>Linux testcrio1 5.0.0-1027-azure #29~18.04.1-Ubuntu SMP Mon Nov 25 21:=
18:57 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux<br>
</div>
<div><br>
</div>
<div>Thanks<br>
</div>
<div><br>
</div>
<div>-<br>
</div>
<div>Julio<br>
</div>
<div><br>
</div>
<span></span><br>
</div>
</body>
</html>

--_000_DM6PR11MB4089A0B695CB84FB288068B89A540DM6PR11MB4089namp_--

