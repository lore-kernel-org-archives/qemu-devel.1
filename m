Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F57C2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185A320848
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="iiHaqYyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185A320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJKFU-0008Dk-9O
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 13:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <julio.montes@intel.com>) id 1jJKEc-0007Q4-6m
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1jJKEY-00068J-Oz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:59:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:17462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1jJKEY-00065Q-1k
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:59:26 -0400
IronPort-SDR: g8Rign1pzC+SQxdPihKYB3DDMhvJmtfhiNWKIaUOx4s5mYrLBna0mGc30Eo1QwSGVVpnOxWIZm
 SdeifWrNbY/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 09:59:23 -0700
IronPort-SDR: 0wJKf0NH56LrPp4Me+IfEngsbqbCj3EI9Huwis7s/zCS2o+T10IGIgM0pTrjz6MbkGxSIMYtW3
 m8MH5Eeij86w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
 d="scan'208,217";a="422364085"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga005.jf.intel.com with ESMTP; 31 Mar 2020 09:59:23 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 09:59:23 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 09:59:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 31 Mar 2020 09:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx9jwiWN9vkvWAlybs2xm6FR01reFgPesRbZQkvAzYFBSdUsb6c4LGo9iCseixzoCpucevjg2UJq0YMrBMhsDjeKuqT9k5atIXRnErGEnVyVrovequyoH54TAjIRQHSjEZRfEgB2OwZVTI7PYD/wchNSHKZ/XTMqAzSFY4j9dTAEOFHMu8qgaCGxuGTnoEeJG+82ZIphtTcac04ZN9RI+coQxzzfbobBqzyU2ztBLzqHL6i/kPxdiwY0WTeLoRqtjXSt8M1pKyBBIgdipfDCZE+B21YaaAC3qGbvpjUFahAwf/3AIAE1ESH7w7oO2XeQ+EDFtqo4LJQzd5a57XCoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu5TPRNjI5ezQxVSo8J9z0ZnOwaYyd3UGPuLWjv25tQ=;
 b=QOrSv+cSJ9BYCPOUXZsjyY7nFevMOUj0GlHdEYIPOjD0akMpM8L78o9nkZJHwJxHhSj3nq8BCNM1bH8Ii4alm9Qw7Kg5OvT2wtkwtIvKMPNJIj4AdMsm64RTuu0Qpqf5U3r8Fv6RPnd9UOfd170/mPVrXEtINt0e2ztI27QCod6AAXulJL9LdPP8g4rE91ow0uJih9RB7CMm66DTeIw1lo6sYacKuXI0uIwcSsDB61ljsFmWeCKqtGK12lb0GooDnbhMx9XDNtaxxiqfMYKi2ArlqQqP+yK11VviLhudDFyq0WPlQWWCo7pIWguZX8sVOFVGnZVYqTuLcFIw8W62Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu5TPRNjI5ezQxVSo8J9z0ZnOwaYyd3UGPuLWjv25tQ=;
 b=iiHaqYyg8i8/Dumtzf+LOGXDOkoFnuRR3GUlkzaiH4vMWrWrbjRHuFzlZuasAdk1DnuEqLgdQhLCVHrE3B3U9GL7acXNwAe7Vg2Jx3g/fwkxNskmJgGTj9ojePKvIe5suNp3lYuGWDzKWaiWMqSjBw8wiXqdDskIkl+KatnNF/Q=
Received: from BY5PR11MB3960.namprd11.prod.outlook.com (2603:10b6:a03:185::30)
 by BY5PR11MB3927.namprd11.prod.outlook.com (2603:10b6:a03:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 16:59:21 +0000
Received: from BY5PR11MB3960.namprd11.prod.outlook.com
 ([fe80::f80d:8a9b:8bf3:47a7]) by BY5PR11MB3960.namprd11.prod.outlook.com
 ([fe80::f80d:8a9b:8bf3:47a7%5]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 16:59:20 +0000
From: "Montes, Julio" <julio.montes@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
Thread-Topic: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
Thread-Index: AQHWB3m8r1FB2qyA5Umhq8e1klXMS6hi5RMAgAAGPUWAAABloA==
Date: Tue, 31 Mar 2020 16:59:20 +0000
Message-ID: <BY5PR11MB3960FE6E5F51F95EF9DFAAAB9AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
References: <20200331162752.1209928-1-vkuznets@redhat.com>,
 <f976c1b0-2f50-d9f6-0921-2fc8e25ddb80@redhat.com>,
 <BY5PR11MB396059E9E1FFE4B93EDE38E89AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
In-Reply-To: <BY5PR11MB396059E9E1FFE4B93EDE38E89AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=julio.montes@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6dec41f-193a-4bf6-3958-08d7d594db5a
x-ms-traffictypediagnostic: BY5PR11MB3927:
x-microsoft-antispam-prvs: <BY5PR11MB3927DEE9036F8D91E344BAF49AC80@BY5PR11MB3927.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:169;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3960.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(39860400002)(136003)(376002)(346002)(366004)(396003)(55016002)(2906002)(54906003)(9686003)(8676002)(110136005)(52536014)(81166006)(53546011)(81156014)(478600001)(6506007)(30864003)(316002)(86362001)(4326008)(8936002)(7696005)(66476007)(19627405001)(26005)(71200400001)(2940100002)(76116006)(66946007)(64756008)(33656002)(66556008)(5660300002)(66446008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lss71WJR1KLZal9OjjCtwzlx4PPDwETiOvp5mdMEUuXuYd0xysAl3bYgLTjbQBXwJKnikTgNt92l/d+bEQ8ZQI+baIPQuZRnYRzvkOtbT7Ba5NKT5OZbWkISfPoF7JJPfuw4MEPicGf/PU8xj7RUzI1H1etuoltrv/PV8Da6Sr1C175BMhvE/OCj1ETBmWeUQAUzFuY2S+33XH1NuP9z103KGOZEmf+/utgloFajvWesuILcqoHUlrFR9ifsEKfcpWc6a5PctuDowz0GfBSDd+khKpGvVBFimI7LzskTNQYue1Oq8eWZu01LrSmJ0JoP6wlT75zESiHquh8fjy4susUO4zKQJA1s+atyNuoMZkTadj2Nd/W4iywsg9cV9EbG3nduby9dcCcR/KLuhM920aPC+NvFbJfA95Etwmd3cY2x12i0lpDRGYgcjKw0geVB
x-ms-exchange-antispam-messagedata: 7ldAk40TkmvdIHdKVoBhAU7+QHAVbHCwVkM+r1MgMMSseYznl/Ho0s9ABhUtaYjMJL08tZzMzfB0qPBznhyhXy+CBeN1s69YvUWeh4ujSF0dRtTA2xM+wFpMTFgZLzJOEoyTAZUDaa/D2x+IF99KQQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BY5PR11MB3960FE6E5F51F95EF9DFAAAB9AC80BY5PR11MB3960namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dec41f-193a-4bf6-3958-08d7d594db5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 16:59:20.5675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5VIVrD+e9NfOlWF3/36fH21s1J70DEcNCvkKcvTe6a9tNkGC/XtPH5GP8K9QH72L+VRGlTkUhbA0Kc7VjeKFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3927
X-OriginatorOrg: intel.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.43
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
Cc: Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR11MB3960FE6E5F51F95EF9DFAAAB9AC80BY5PR11MB3960namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sorry for my last email, it was incomplete

Hi Vitaly

thanks for raising this, unfortunately this patch didn't work for me, I sti=
ll get the same error:

qemu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000
qemu-system-x86_64: /home/testpmem/go/src/github.com/kata-containers/qemu/t=
arget/i386/kvm.c:2695: kvm_buf_set_msrs: Assertion `ret =3D=3D cpu->kvm_msr=
_buf->nmsrs

my qemu command line:
/usr/bin/qemu-system-x86_64 -name sandbox-f218abcb05f6e05cc68768f74e9106303=
066f377a877c03ddc64e1e5e8685633 -uuid 8189ac12-5a5c-4989-bf82-c0218f8a3d33 =
-machine pc,accel=3Dkvm,kernel_irqchip,nvdimm -cpu host,pmu=3Doff -qmp unix=
:/run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f377a877c03ddc64e1e5e868563=
3/qmp.sock,server,nowait -m 2048M,slots=3D10,maxmem=3D17041M -device pci-br=
idge,bus=3Dpci.0,id=3Dpci-bridge-0,chassis_nr=3D1,shpc=3Don,addr=3D2,romfil=
e=3D -device virtio-serial-pci,disable-modern=3Dtrue,id=3Dserial0,romfile=
=3D -device virtconsole,chardev=3Dcharconsole0,id=3Dconsole0 -chardev socke=
t,id=3Dcharconsole0,path=3D/run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f=
377a877c03ddc64e1e5e8685633/console.sock,server,nowait -device nvdimm,id=3D=
nv0,memdev=3Dmem0 -object memory-backend-file,id=3Dmem0,mem-path=3D/usr/sha=
re/kata-containers/kata-containers-clearlinux-32700-osbuilder-891b61c-agent=
-73afd1a.img,size=3D134217728 -device virtio-scsi-pci,id=3Dscsi0,disable-mo=
dern=3Dtrue,romfile=3D -object rng-random,id=3Drng0,filename=3D/dev/urandom=
 -device virtio-rng-pci,rng=3Drng0,romfile=3D -device virtserialport,charde=
v=3Dcharch0,id=3Dchannel0,name=3Dagent.channel.0 -chardev socket,id=3Dcharc=
h0,path=3D/run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f377a877c03ddc64e1=
e5e8685633/kata.sock,server,nowait -device virtio-9p-pci,disable-modern=3Dt=
rue,fsdev=3Dextra-9p-kataShared,mount_tag=3DkataShared,romfile=3D -fsdev lo=
cal,id=3Dextra-9p-kataShared,path=3D/run/kata-containers/shared/sandboxes/f=
218abcb05f6e05cc68768f74e9106303066f377a877c03ddc64e1e5e8685633,security_mo=
del=3Dnone -netdev tap,id=3Dnetwork-0,vhost=3Don,vhostfds=3D3,fds=3D4 -devi=
ce driver=3Dvirtio-net-pci,netdev=3Dnetwork-0,mac=3D02:42:ac:11:00:02,disab=
le-modern=3Dtrue,mq=3Don,vectors=3D4,romfile=3D -global kvm-pit.lost_tick_p=
olicy=3Ddiscard -vga none -no-user-config -nodefaults -nographic -daemonize=
 -object memory-backend-ram,id=3Ddimm1,size=3D2048M -numa node,memdev=3Ddim=
m1 -kernel /usr/share/kata-containers/vmlinuz-5.4.15-71 -append tsc=3Drelia=
ble no_timer_check rcupdate.rcu_expedited=3D1 i8042.direct=3D1 i8042.dumbkb=
d=3D1 i8042.nopnp=3D1 i8042.noaux=3D1 noreplace-smp reboot=3Dk console=3Dhv=
c0 console=3Dhvc1 iommu=3Doff cryptomgr.notests net.ifnames=3D0 pci=3Dlastb=
us=3D0 root=3D/dev/pmem0p1 rootflags=3Ddax,data=3Dordered,errors=3Dremount-=
ro ro rootfstype=3Dext4 debug systemd.show_status=3Dtrue systemd.log_level=
=3Ddebug panic=3D1 nr_cpus=3D4 agent.use_vsock=3Dfalse systemd.unit=3Dkata-=
containers.target systemd.mask=3Dsystemd-networkd.service systemd.mask=3Dsy=
stemd-networkd.socket agent.log=3Ddebug agent.log=3Ddebug -pidfile /run/vc/=
vm/f218abcb05f6e05cc68768f74e9106303066f37
7a877c03ddc64e1e5e8685633/pid -D /run/vc/vm/f218abcb05f6e05cc68768f74e91063=
03066f377a877c03ddc64e1e5e8685633/qemu.log -smp 1,cores=3D1,threads=3D1,soc=
kets=3D4,maxcpus=3D4



./vmxcap output:

Basic VMX Information
  Hex: 0x98100000000001
  Revision                                 1
  VMCS size                                4096
  VMCS restricted to 32 bit addresses      no
  Dual-monitor support                     no
  VMCS memory type                         6
  INS/OUTS instruction information         no
  IA32_VMX_TRUE_*_CTLS support             yes
pin-based controls
  External interrupt exiting               yes
  NMI exiting                              yes
  Virtual NMIs                             yes
  Activate VMX-preemption timer            no
  Process posted interrupts                no
primary processor-based controls
  Interrupt window exiting                 yes
  Use TSC offsetting                       yes
  HLT exiting                              forced
  INVLPG exiting                           yes
  MWAIT exiting                            forced
  RDPMC exiting                            yes
  RDTSC exiting                            yes
  CR3-load exiting                         default
  CR3-store exiting                        default
  CR8-load exiting                         yes
  CR8-store exiting                        yes
  Use TPR shadow                           yes
  NMI-window exiting                       yes
  MOV-DR exiting                           yes
  Unconditional I/O exiting                yes
  Use I/O bitmaps                          yes
  Monitor trap flag                        no
  Use MSR bitmaps                          yes
  MONITOR exiting                          forced
  PAUSE exiting                            yes
  Activate secondary control               yes
secondary processor-based controls
  Virtualize APIC accesses                 no
  Enable EPT                               yes
  Descriptor-table exiting                 yes
  Enable RDTSCP                            yes
  Virtualize x2APIC mode                   no
  Enable VPID                              yes
  WBINVD exiting                           no
  Unrestricted guest                       no
  APIC register emulation                  no
  Virtual interrupt delivery               no
  PAUSE-loop exiting                       no
  RDRAND exiting                           yes
  Enable INVPCID                           yes
  Enable VM functions                      no
  VMCS shadowing                           no
  Enable ENCLS exiting                     no
  RDSEED exiting                           no
  Enable PML                               no
  EPT-violation #VE                        no
  Conceal non-root operation from PT       no
  Enable XSAVES/XRSTORS                    no
  Mode-based execute control (XS/XU)       no
  Sub-page write permissions               no
  GPA translation for PT                   no
  TSC scaling                              no
  User wait and pause                      no
  ENCLV exiting                            no
VM-Exit controls
  Save debug controls                      default
  Host address-space size                  forced
  Load IA32_PERF_GLOBAL_CTRL               no
  Acknowledge interrupt on exit            yes
  Save IA32_PAT                            yes
  Load IA32_PAT                            yes
  Save IA32_EFER                           yes
  Load IA32_EFER                           yes
  Save VMX-preemption timer value          no
  Clear IA32_BNDCFGS                       no
  Conceal VM exits from PT                 no
  Clear IA32_RTIT_CTL                      no
VM-Entry controls
  Load debug controls                      default
  IA-32e mode guest                        yes
  Entry to SMM                             no
  Deactivate dual-monitor treatment        no
  Load IA32_PERF_GLOBAL_CTRL               no
  Load IA32_PAT                            yes
  Load IA32_EFER                           yes
  Load IA32_BNDCFGS                        no
  Conceal VM entries from PT               no
  Load IA32_RTIT_CTL                       no
Miscellaneous data
  Hex: 0x40
  VMX-preemption timer scale (log2)        0
  Store EFER.LMA into IA-32e mode guest control no
  HLT activity state                       yes
  Shutdown activity state                  no
  Wait-for-SIPI activity state             no
  PT in VMX operation                      no
  IA32_SMBASE support                      no
  Number of CR3-target values              0
  MSR-load/store count recommendation      0
  IA32_SMM_MONITOR_CTL[2] can be set to 1  no
  VMWRITE to VM-exit information fields    no
  Inject event with insn length=3D0          no
  MSEG revision identifier                 0
VPID and EPT capabilities
  Hex: 0xf0106114040
  Execute-only EPT translations            no
  Page-walk length 4                       yes
  Paging-structure memory type UC          no
  Paging-structure memory type WB          yes
  2MB EPT pages                            yes
  1GB EPT pages                            no
  INVEPT supported                         yes
  EPT accessed and dirty flags             no
  Advanced VM-exit information for EPT violations no
  Single-context INVEPT                    yes
  All-context INVEPT                       yes
  INVVPID supported                        yes
  Individual-address INVVPID               yes
  Single-context INVVPID                   yes
  All-context INVVPID                      yes
  Single-context-retaining-globals INVVPID yes
VM Functions
  Hex: 0x0
  EPTP Switching                           no


________________________________
From: Montes, Julio <julio.montes@intel.com>
Sent: Tuesday, March 31, 2020 10:56 AM
To: Paolo Bonzini <pbonzini@redhat.com>; Vitaly Kuznetsov <vkuznets@redhat.=
com>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>; Eduardo Habkost <ehabkost@redhat=
.com>; Dr . David Alan Gilbert <dgilbert@redhat.com>; Richard Henderson <rt=
h@twiddle.net>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary exec=
ution controls

Hi Vitaly

thanks for raising this, unfortunately this patch didn't work for me, I sti=
ll get the same error:


my qemu command line:

________________________________
From: Qemu-devel <qemu-devel-bounces+julio.montes=3Dintel.com@nongnu.org> o=
n behalf of Paolo Bonzini <pbonzini@redhat.com>
Sent: Tuesday, March 31, 2020 10:32 AM
To: Vitaly Kuznetsov <vkuznets@redhat.com>; qemu-devel@nongnu.org <qemu-dev=
el@nongnu.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>; Eduardo Habkost <ehabkost@redhat=
.com>; Dr . David Alan Gilbert <dgilbert@redhat.com>; Richard Henderson <rt=
h@twiddle.net>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary exec=
ution controls

On 31/03/20 18:27, Vitaly Kuznetsov wrote:
> Commit 048c95163b4 ("target/i386: work around KVM_GET_MSRS bug for
> secondary execution controls") added a workaround for KVM pre-dating
> commit 6defc591846d ("KVM: nVMX: include conditional controls in /dev/kvm
> KVM_GET_MSRS") which wasn't setting certain available controls. The
> workaround uses generic CPUID feature bits to set missing VMX controls.
>
> It was found that in some cases it is possible to observe hosts which
> have certain CPUID features but lack the corresponding VMX control.
>
> In particular, it was reported that Azure VMs have RDSEED but lack
> VMX_SECONDARY_EXEC_RDSEED_EXITING; attempts to enable this feature
> bit result in QEMU abort.
>
> Resolve the issue but not applying the workaround when we don't have
> to. As there is no good way to find out if KVM has the fix itself, use
> 95c5c7c77c ("KVM: nVMX: list VMX MSRs in KVM_GET_MSR_INDEX_LIST") instead
> as these [are supposed to] come together.
>
> Fixes: 048c95163b4 ("target/i386: work around KVM_GET_MSRS bug for second=
ary execution controls")
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Queued, thanks.

Paolo

> ---
>  target/i386/kvm.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 69eb43d796e6..4901c6dd747d 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -106,6 +106,7 @@ static bool has_msr_arch_capabs;
>  static bool has_msr_core_capabs;
>  static bool has_msr_vmx_vmfunc;
>  static bool has_msr_ucode_rev;
> +static bool has_msr_vmx_procbased_ctls2;
>
>  static uint32_t has_architectural_pmu_version;
>  static uint32_t num_architectural_pmu_gp_counters;
> @@ -490,21 +491,28 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMStat=
e *s, uint32_t index)
>      value =3D msr_data.entries[0].data;
>      switch (index) {
>      case MSR_IA32_VMX_PROCBASED_CTLS2:
> -        /* KVM forgot to add these bits for some time, do this ourselves=
.  */
> -        if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) & CPUID_XSAVE=
_XSAVES) {
> -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) & CPUID_EXT_RDR=
AND) {
> -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << 32=
;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX=
_INVPCID) {
> -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << 32=
;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX=
_RDSEED) {
> -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << 32=
;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) & CPUI=
D_EXT2_RDTSCP) {
> -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
> +        if (!has_msr_vmx_procbased_ctls2) {
> +            /* KVM forgot to add these bits for some time, do this ourse=
lves. */
> +            if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) &
> +                CPUID_XSAVE_XSAVES) {
> +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) &
> +                CPUID_EXT_RDRAND) {
> +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING <=
< 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
> +                CPUID_7_0_EBX_INVPCID) {
> +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID <=
< 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
> +                CPUID_7_0_EBX_RDSEED) {
> +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING <=
< 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) &
> +                CPUID_EXT2_RDTSCP) {
> +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
> +            }
>          }
>          /* fall through */
>      case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
> @@ -2060,6 +2068,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>              case MSR_IA32_UCODE_REV:
>                  has_msr_ucode_rev =3D true;
>                  break;
> +            case MSR_IA32_VMX_PROCBASED_CTLS2:
> +                has_msr_vmx_procbased_ctls2 =3D true;
> +                break;
>              }
>          }
>      }
>



--_000_BY5PR11MB3960FE6E5F51F95EF9DFAAAB9AC80BY5PR11MB3960namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<div style=3D"background-color: white; color: black;">
<div>
<div>
<div dir=3D"ltr">
<div style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, sans=
-serif; background-color: white;">
Sorry for my last email, it was incomplete<br>
</div>
<div style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, sans=
-serif; background-color: white;">
<br>
</div>
<div style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, sans=
-serif; background-color: white;">
Hi Vitaly</div>
<div style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, sans=
-serif; background-color: white;">
<br>
</div>
<div style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, sans=
-serif; background-color: white;">
thanks for raising this, unfortunately this patch didn't work for me, I sti=
ll get the same error:</div>
<div style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, sans=
-serif; background-color: white;">
<br>
</div>
<div style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, sans=
-serif; background-color: white;">
<span>qemu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000=
<br>
</span><span>qemu-system-x86_64: /home/testpmem/go/src/github.com/kata-cont=
ainers/qemu/target/i386/kvm.c:2695: kvm_buf_set_msrs: Assertion `ret =3D=3D=
 cpu-&gt;kvm_msr_buf-&gt;nmsrs</span><br>
</div>
<div style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, sans=
-serif; background-color: white;">
<br>
</div>
<div style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, sans=
-serif; background-color: white;">
my qemu command line:</div>
</div>
</div>
</div>
</div>
/usr/bin/qemu-system-x86_64 -name sandbox-f218abcb05f6e05cc68768f74e9106303=
066f377a877c03ddc64e1e5e8685633 -uuid 8189ac12-5a5c-4989-bf82-c0218f8a3d33 =
-machine pc,accel=3Dkvm,kernel_irqchip,nvdimm -cpu host,pmu=3Doff -qmp unix=
:/run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f377a877c03ddc64e1e5e868563=
3/qmp.sock,server,nowait
 -m 2048M,slots=3D10,maxmem=3D17041M -device pci-bridge,bus=3Dpci.0,id=3Dpc=
i-bridge-0,chassis_nr=3D1,shpc=3Don,addr=3D2,romfile=3D -device virtio-seri=
al-pci,disable-modern=3Dtrue,id=3Dserial0,romfile=3D -device virtconsole,ch=
ardev=3Dcharconsole0,id=3Dconsole0 -chardev socket,id=3Dcharconsole0,path=
=3D/run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f377a877c03ddc64e1e5e8685=
633/console.sock,server,nowait
 -device nvdimm,id=3Dnv0,memdev=3Dmem0 -object memory-backend-file,id=3Dmem=
0,mem-path=3D/usr/share/kata-containers/kata-containers-clearlinux-32700-os=
builder-891b61c-agent-73afd1a.img,size=3D134217728 -device virtio-scsi-pci,=
id=3Dscsi0,disable-modern=3Dtrue,romfile=3D -object
 rng-random,id=3Drng0,filename=3D/dev/urandom -device virtio-rng-pci,rng=3D=
rng0,romfile=3D -device virtserialport,chardev=3Dcharch0,id=3Dchannel0,name=
=3Dagent.channel.0 -chardev socket,id=3Dcharch0,path=3D/run/vc/vm/f218abcb0=
5f6e05cc68768f74e9106303066f377a877c03ddc64e1e5e8685633/kata.sock,server,no=
wait
 -device virtio-9p-pci,disable-modern=3Dtrue,fsdev=3Dextra-9p-kataShared,mo=
unt_tag=3DkataShared,romfile=3D -fsdev local,id=3Dextra-9p-kataShared,path=
=3D/run/kata-containers/shared/sandboxes/f218abcb05f6e05cc68768f74e91063030=
66f377a877c03ddc64e1e5e8685633,security_model=3Dnone
 -netdev tap,id=3Dnetwork-0,vhost=3Don,vhostfds=3D3,fds=3D4 -device driver=
=3Dvirtio-net-pci,netdev=3Dnetwork-0,mac=3D02:42:ac:11:00:02,disable-modern=
=3Dtrue,mq=3Don,vectors=3D4,romfile=3D -global kvm-pit.lost_tick_policy=3Dd=
iscard -vga none -no-user-config -nodefaults -nographic -daemonize
 -object memory-backend-ram,id=3Ddimm1,size=3D2048M -numa node,memdev=3Ddim=
m1 -kernel /usr/share/kata-containers/vmlinuz-5.4.15-71 -append tsc=3Drelia=
ble no_timer_check rcupdate.rcu_expedited=3D1 i8042.direct=3D1 i8042.dumbkb=
d=3D1 i8042.nopnp=3D1 i8042.noaux=3D1 noreplace-smp
 reboot=3Dk console=3Dhvc0 console=3Dhvc1 iommu=3Doff cryptomgr.notests net=
.ifnames=3D0 pci=3Dlastbus=3D0 root=3D/dev/pmem0p1 rootflags=3Ddax,data=3Do=
rdered,errors=3Dremount-ro ro rootfstype=3Dext4 debug systemd.show_status=
=3Dtrue systemd.log_level=3Ddebug panic=3D1 nr_cpus=3D4 agent.use_vsock=3Df=
alse
 systemd.unit=3Dkata-containers.target systemd.mask=3Dsystemd-networkd.serv=
ice systemd.mask=3Dsystemd-networkd.socket agent.log=3Ddebug agent.log=3Dde=
bug -pidfile /run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f37</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
7a877c03ddc64e1e5e8685633/pid -D /run/vc/vm/f218abcb05f6e05cc68768f74e91063=
03066f377a877c03ddc64e1e5e8685633/qemu.log -smp 1,cores=3D1,threads=3D1,soc=
kets=3D4,maxcpus=3D4</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
./vmxcap output:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span>Basic VMX Information<br>
</span>
<div>&nbsp; Hex: 0x98100000000001<br>
</div>
<div>&nbsp; Revision &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
</div>
<div>&nbsp; VMCS size &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;4096<br>
</div>
<div>&nbsp; VMCS restricted to 32 bit addresses &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; Dual-monitor support &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; VMCS memory type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 6<br>
</div>
<div>&nbsp; INS/OUTS instruction information &nbsp; &nbsp; &nbsp; &nbsp; no=
<br>
</div>
<div>&nbsp; IA32_VMX_TRUE_*_CTLS support &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; yes<br>
</div>
<div>pin-based controls<br>
</div>
<div>&nbsp; External interrupt exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; NMI exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Virtual NMIs &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Activate VMX-preemption timer &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;no<br>
</div>
<div>&nbsp; Process posted interrupts &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;no<br>
</div>
<div>primary processor-based controls<br>
</div>
<div>&nbsp; Interrupt window exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Use TSC offsetting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; HLT exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;forced<br>
</div>
<div>&nbsp; INVLPG exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; MWAIT exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;forced<br>
</div>
<div>&nbsp; RDPMC exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; RDTSC exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; CR3-load exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; default<br>
</div>
<div>&nbsp; CR3-store exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;default<br>
</div>
<div>&nbsp; CR8-load exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; CR8-store exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Use TPR shadow &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; NMI-window exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; MOV-DR exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Unconditional I/O exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Use I/O bitmaps &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Monitor trap flag &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; Use MSR bitmaps &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; MONITOR exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;forced<br>
</div>
<div>&nbsp; PAUSE exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Activate secondary control &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; yes<br>
</div>
<div>secondary processor-based controls<br>
</div>
<div>&nbsp; Virtualize APIC accesses &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Enable EPT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Descriptor-table exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Enable RDTSCP &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Virtualize x2APIC mode &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Enable VPID &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; WBINVD exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Unrestricted guest &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; APIC register emulation &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; Virtual interrupt delivery &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; no<br>
</div>
<div>&nbsp; PAUSE-loop exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; RDRAND exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Enable INVPCID &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Enable VM functions &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; VMCS shadowing &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Enable ENCLS exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; RDSEED exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Enable PML &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; EPT-violation #VE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; Conceal non-root operation from PT &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Enable XSAVES/XRSTORS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; Mode-based execute control (XS/XU) &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Sub-page write permissions &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; no<br>
</div>
<div>&nbsp; GPA translation for PT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; TSC scaling &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; User wait and pause &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; ENCLV exiting &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>VM-Exit controls<br>
</div>
<div>&nbsp; Save debug controls &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;default<br>
</div>
<div>&nbsp; Host address-space size &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;forced<br>
</div>
<div>&nbsp; Load IA32_PERF_GLOBAL_CTRL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Acknowledge interrupt on exit &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;yes<br>
</div>
<div>&nbsp; Save IA32_PAT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Load IA32_PAT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Save IA32_EFER &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Load IA32_EFER &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Save VMX-preemption timer value &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;no<br>
</div>
<div>&nbsp; Clear IA32_BNDCFGS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Conceal VM exits from PT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Clear IA32_RTIT_CTL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>VM-Entry controls<br>
</div>
<div>&nbsp; Load debug controls &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;default<br>
</div>
<div>&nbsp; IA-32e mode guest &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Entry to SMM &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Deactivate dual-monitor treatment &nbsp; &nbsp; &nbsp; &nbsp;no=
<br>
</div>
<div>&nbsp; Load IA32_PERF_GLOBAL_CTRL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Load IA32_PAT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Load IA32_EFER &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Load IA32_BNDCFGS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; Conceal VM entries from PT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; no<br>
</div>
<div>&nbsp; Load IA32_RTIT_CTL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; no<br>
</div>
<div>Miscellaneous data<br>
</div>
<div>&nbsp; Hex: 0x40<br>
</div>
<div>&nbsp; VMX-preemption timer scale (log2) &nbsp; &nbsp; &nbsp; &nbsp;0<=
br>
</div>
<div>&nbsp; Store EFER.LMA into IA-32e mode guest control no<br>
</div>
<div>&nbsp; HLT activity state &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Shutdown activity state &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; Wait-for-SIPI activity state &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; no<br>
</div>
<div>&nbsp; PT in VMX operation &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; IA32_SMBASE support &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; Number of CR3-target values &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;0<br>
</div>
<div>&nbsp; MSR-load/store count recommendation &nbsp; &nbsp; &nbsp;0<br>
</div>
<div>&nbsp; IA32_SMM_MONITOR_CTL[2] can be set to 1 &nbsp;no<br>
</div>
<div>&nbsp; VMWRITE to VM-exit information fields &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; Inject event with insn length=3D0 &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;no<br>
</div>
<div>&nbsp; MSEG revision identifier &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; 0<br>
</div>
<div>VPID and EPT capabilities<br>
</div>
<div>&nbsp; Hex: 0xf0106114040<br>
</div>
<div>&nbsp; Execute-only EPT translations &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;no<br>
</div>
<div>&nbsp; Page-walk length 4 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Paging-structure memory type UC &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;no<br>
</div>
<div>&nbsp; Paging-structure memory type WB &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;yes<br>
</div>
<div>&nbsp; 2MB EPT pages &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; 1GB EPT pages &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;no<br>
</div>
<div>&nbsp; INVEPT supported &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; EPT accessed and dirty flags &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; no<br>
</div>
<div>&nbsp; Advanced VM-exit information for EPT violations no<br>
</div>
<div>&nbsp; Single-context INVEPT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; All-context INVEPT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; INVVPID supported &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Individual-address INVVPID &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; Single-context INVVPID &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; yes<br>
</div>
<div>&nbsp; All-context INVVPID &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yes<br>
</div>
<div>&nbsp; Single-context-retaining-globals INVVPID yes<br>
</div>
<div>VM Functions<br>
</div>
<div>&nbsp; Hex: 0x0<br>
</div>
<span>&nbsp; EPTP Switching &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; no</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Montes, Julio &lt;jul=
io.montes@intel.com&gt;<br>
<b>Sent:</b> Tuesday, March 31, 2020 10:56 AM<br>
<b>To:</b> Paolo Bonzini &lt;pbonzini@redhat.com&gt;; Vitaly Kuznetsov &lt;=
vkuznets@redhat.com&gt;; qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt=
;<br>
<b>Cc:</b> Marcelo Tosatti &lt;mtosatti@redhat.com&gt;; Eduardo Habkost &lt=
;ehabkost@redhat.com&gt;; Dr . David Alan Gilbert &lt;dgilbert@redhat.com&g=
t;; Richard Henderson &lt;rth@twiddle.net&gt;<br>
<b>Subject:</b> Re: [PATCH] target/i386: do not set unsupported VMX seconda=
ry execution controls</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
Hi Vitaly</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
thanks for raising this, unfortunately this patch didn't work for me, I sti=
ll get the same error:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
my qemu command line:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Qemu-devel &lt;qemu=
-devel-bounces&#43;julio.montes=3Dintel.com@nongnu.org&gt; on behalf of Pao=
lo Bonzini &lt;pbonzini@redhat.com&gt;<br>
<b>Sent:</b> Tuesday, March 31, 2020 10:32 AM<br>
<b>To:</b> Vitaly Kuznetsov &lt;vkuznets@redhat.com&gt;; qemu-devel@nongnu.=
org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> Marcelo Tosatti &lt;mtosatti@redhat.com&gt;; Eduardo Habkost &lt=
;ehabkost@redhat.com&gt;; Dr . David Alan Gilbert &lt;dgilbert@redhat.com&g=
t;; Richard Henderson &lt;rth@twiddle.net&gt;<br>
<b>Subject:</b> Re: [PATCH] target/i386: do not set unsupported VMX seconda=
ry execution controls</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On 31/03/20 18:27, Vitaly Kuznetsov wrote:<br>
&gt; Commit 048c95163b4 (&quot;target/i386: work around KVM_GET_MSRS bug fo=
r<br>
&gt; secondary execution controls&quot;) added a workaround for KVM pre-dat=
ing<br>
&gt; commit 6defc591846d (&quot;KVM: nVMX: include conditional controls in =
/dev/kvm<br>
&gt; KVM_GET_MSRS&quot;) which wasn't setting certain available controls. T=
he<br>
&gt; workaround uses generic CPUID feature bits to set missing VMX controls=
.<br>
&gt; <br>
&gt; It was found that in some cases it is possible to observe hosts which<=
br>
&gt; have certain CPUID features but lack the corresponding VMX control.<br=
>
&gt; <br>
&gt; In particular, it was reported that Azure VMs have RDSEED but lack<br>
&gt; VMX_SECONDARY_EXEC_RDSEED_EXITING; attempts to enable this feature<br>
&gt; bit result in QEMU abort.<br>
&gt; <br>
&gt; Resolve the issue but not applying the workaround when we don't have<b=
r>
&gt; to. As there is no good way to find out if KVM has the fix itself, use=
<br>
&gt; 95c5c7c77c (&quot;KVM: nVMX: list VMX MSRs in KVM_GET_MSR_INDEX_LIST&q=
uot;) instead<br>
&gt; as these [are supposed to] come together.<br>
&gt; <br>
&gt; Fixes: 048c95163b4 (&quot;target/i386: work around KVM_GET_MSRS bug fo=
r secondary execution controls&quot;)<br>
&gt; Suggested-by: Paolo Bonzini &lt;pbonzini@redhat.com&gt;<br>
&gt; Signed-off-by: Vitaly Kuznetsov &lt;vkuznets@redhat.com&gt;<br>
<br>
Queued, thanks.<br>
<br>
Paolo<br>
<br>
&gt; ---<br>
&gt;&nbsp; target/i386/kvm.c | 41 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;---------------<br>
&gt;&nbsp; 1 file changed, 26 insertions(&#43;), 15 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/kvm.c b/target/i386/kvm.c<br>
&gt; index 69eb43d796e6..4901c6dd747d 100644<br>
&gt; --- a/target/i386/kvm.c<br>
&gt; &#43;&#43;&#43; b/target/i386/kvm.c<br>
&gt; @@ -106,6 &#43;106,7 @@ static bool has_msr_arch_capabs;<br>
&gt;&nbsp; static bool has_msr_core_capabs;<br>
&gt;&nbsp; static bool has_msr_vmx_vmfunc;<br>
&gt;&nbsp; static bool has_msr_ucode_rev;<br>
&gt; &#43;static bool has_msr_vmx_procbased_ctls2;<br>
&gt;&nbsp; <br>
&gt;&nbsp; static uint32_t has_architectural_pmu_version;<br>
&gt;&nbsp; static uint32_t num_architectural_pmu_gp_counters;<br>
&gt; @@ -490,21 &#43;491,28 @@ uint64_t kvm_arch_get_supported_msr_feature(=
KVMState *s, uint32_t index)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D msr_data.entries[0].data;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (index) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case MSR_IA32_VMX_PROCBASED_CTLS2:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* KVM forgot to add these=
 bits for some time, do this ourselves.&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supported=
_cpuid(s, 0xD, 1, R_ECX) &amp; CPUID_XSAVE_XSAVES) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va=
lue |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES &lt;&lt; 32;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supported=
_cpuid(s, 1, 0, R_ECX) &amp; CPUID_EXT_RDRAND) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va=
lue |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING &lt;&lt; 32;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supported=
_cpuid(s, 7, 0, R_EBX) &amp; CPUID_7_0_EBX_INVPCID) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va=
lue |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID &lt;&lt; 32;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supported=
_cpuid(s, 7, 0, R_EBX) &amp; CPUID_7_0_EBX_RDSEED) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va=
lue |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING &lt;&lt; 32;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supported=
_cpuid(s, 0x80000001, 0, R_EDX) &amp; CPUID_EXT2_RDTSCP) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va=
lue |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP &lt;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!has_msr_vmx_procb=
ased_ctls2) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* KVM forgot to add these bits for some time, do this ourselves. */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_XSAVE_XSAVES) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES &l=
t;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_EXT_RDRAND) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EX=
ITING &lt;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_7_0_EBX_INVPCID) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_IN=
VPCID &lt;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_7_0_EBX_RDSEED) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EX=
ITING &lt;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_EXT2_RDTSCP) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP &l=
t;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fall through =
*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case MSR_IA32_VMX_TRUE_PINBASED_CTLS:<br=
>
&gt; @@ -2060,6 &#43;2068,9 @@ static int kvm_get_supported_msrs(KVMState *=
s)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; case MSR_IA32_UCODE_REV:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_msr_ucode_rev =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; case MSR_IA32_VMX_PROCBASED_CTLS2:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; has_msr_vmx_procbased_ctls2 =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR11MB3960FE6E5F51F95EF9DFAAAB9AC80BY5PR11MB3960namp_--

