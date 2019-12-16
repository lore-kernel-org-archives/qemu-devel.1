Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8CBC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC86920CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="TsdIiMcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC86920CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igw2V-00087P-W5
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <julio.montes@intel.com>) id 1igw1t-0007ir-A0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1igw1q-0004d5-Mn
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:27:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:60459)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1igw1q-0004OK-7f
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:27:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 11:27:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
 d="scan'208,217";a="247154853"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga002.fm.intel.com with ESMTP; 16 Dec 2019 11:27:29 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 11:27:29 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 11:27:28 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 16 Dec 2019 11:27:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3e/gd8FZ3s4dFbMbB/jsct7hMQH6oooqn4SB8rEUEV3GqZ0qBSAPOnAQf3LnjX8ETX9RSyRXB5AzITrzGi4WKmEh47fdtAXi2UswcsmKSjMUbGJ4KQiAVJc46C1OLMRgty4ghhk+6kwN/VLxaxjmk6XU8jln8Bj5Ni1BC/LbWjYCBh/eBLuwKxXvphFRlhGjyNo2EfGZxdnsMQp3b7LRAGffKKxL5w4tIDwsRdIdcb4ptlt/HDj+LE1J0n4Ngv2O/R+pOvNRhdS4rW3j98cSRt9RpZkCrm2dXqLraGYOfzXb0jWpmVKQ7AA6rH26iJKsg3tPp/qYUutpUgkuSJDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c8ZyWWm38izzc6NCORTesb8tM77N9YjRsEfVgRNOSM=;
 b=OuSp29Kl+haf87JG7w6nHzHZHA0FssQHnaWMEUQLoU5qf6AnSshkFA581ICpfJxos2ngxFffaR5gifGdl2rVi+2P4Rh5CwxUGYcFiWOE85rBFD3LUe2rwQtOMFRAFKe3QmSmGS/6WnkOb+EBwGYNz6FNhALve6s3nCMdy+Uz3OB4cTR2tvBSOFD+Av5AptVzuJEKUT6HGRtlJf7hyYQ2alGjq6hOcHWyKXvdTrPeoti9TQlas749Pqc5RO5ine55ahISemSv5QaWQyDDZVV+hK5uc05SAKQCVmVSoUpy3ZNDKkKYl3lEj0zpVIDUAb0TPKfVP7bm57h2hJrR7zxGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c8ZyWWm38izzc6NCORTesb8tM77N9YjRsEfVgRNOSM=;
 b=TsdIiMcSIauoOB45JaZBNgPNH4OGRM8Uhwc71yV8hHg/0c3GR49QziaT3Fly20KJoAi3AY3B2cc1eOV1jEqx6YBw7QIv+BS4dJWlBiEeGmu2rGtqVRNWG1LSXGzGMTKzoqZT5TrNT7HuEvuO0NvlH+sQw/CSlcdEtSWzIlD4WWI=
Received: from DM6PR11MB4089.namprd11.prod.outlook.com (20.176.126.91) by
 DM6PR11MB2764.namprd11.prod.outlook.com (20.176.95.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Mon, 16 Dec 2019 19:27:25 +0000
Received: from DM6PR11MB4089.namprd11.prod.outlook.com
 ([fe80::3ceb:88f0:7717:7ecd]) by DM6PR11MB4089.namprd11.prod.outlook.com
 ([fe80::3ceb:88f0:7717:7ecd%7]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 19:27:25 +0000
From: "Montes, Julio" <julio.montes@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertion
 `ret == cpu->kvm_msr_buf->nmsrs' failed.
Thread-Topic: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertion
 `ret == cpu->kvm_msr_buf->nmsrs' failed.
Thread-Index: AQHVsfc5K/GHgo1+SUW1rgjP3fus/6e42ICAgABkWoCAA9UT0YAAFtUAgAAAo+s=
Date: Mon, 16 Dec 2019 19:27:25 +0000
Message-ID: <DM6PR11MB40892D78881D0349598800429A510@DM6PR11MB4089.namprd11.prod.outlook.com>
References: <DM6PR11MB4089A0B695CB84FB288068B89A540@DM6PR11MB4089.namprd11.prod.outlook.com>
 <2c28287e-1869-751d-f7c8-04605ef4b337@redhat.com>
 <d969066a-b10c-ebbc-b784-a19a66a5a831@redhat.com>
 <DM6PR11MB4089FF5F11BC215320EB502E9A510@DM6PR11MB4089.namprd11.prod.outlook.com>,
 <CABgObfYLEov5YpYzsfD_WtGdnwbrr=vStpKY2+qHs0w+AVCAfQ@mail.gmail.com>
In-Reply-To: <CABgObfYLEov5YpYzsfD_WtGdnwbrr=vStpKY2+qHs0w+AVCAfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=julio.montes@intel.com; 
x-originating-ip: [134.134.139.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78097b49-e85a-4c74-eeb3-08d7825dfb53
x-ms-traffictypediagnostic: DM6PR11MB2764:
x-microsoft-antispam-prvs: <DM6PR11MB2764DACDBAE53314E507158B9A510@DM6PR11MB2764.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(19627405001)(76116006)(91956017)(54906003)(6506007)(66476007)(86362001)(55016002)(53546011)(6916009)(186003)(2906002)(66446008)(64756008)(66946007)(966005)(66556008)(26005)(5660300002)(7696005)(316002)(4326008)(33656002)(478600001)(71200400001)(8936002)(8676002)(9686003)(81156014)(81166006)(52536014)(81973001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR11MB2764;
 H:DM6PR11MB4089.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WxaFsC7EggGJK2OPguaC2FbR0KvlBhtTHDGSD11jT4SRZGa/DH5TTpqAouf+X1Jc4eBwx4yCsHWLYH8qbb7v0lhXE8sAIZRNULMjwWH2Ty6L9/zmdBd3ht5pf+JdxT5bVsHbhqH5MocLMoTuJ6Qorm4Cd4bq2qPg4zqeYtOV4eFXSoU8H+W1SumU3Xo49fLPWqnQY06bM9p/LWfGKlHYnj+tk8vzala5SyX3dcGsvfCr+QCYIi7pSoIxbHpofRF3zM5Qz78V+77d/DAUqc/QKjgXtobpmJJaiif9HuzpjWbFsRSsxKuAPBPbv1VlMHUdlJHYmDZKRmxMSz4Pst/zTLZZalRHJixtqrywTKIlOyLVnleI69u3lynbyTt8n95FLqxQZs5LoptELea0KgQ5wkx+zVXX0P4inkydZePRLKEOZatmxjDAi0eUJeXAvVs+M+vv22ZKIun4t4rT0Y3SGAQhvxRj6o4e6Kal3S6YXkAWJze31V+xwuOnLftAsoHRgFrHvCAUUdxX+m/sXYbP3Q==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR11MB40892D78881D0349598800429A510DM6PR11MB4089namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 78097b49-e85a-4c74-eeb3-08d7825dfb53
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 19:27:25.5886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYdP6nAUfgl4Gbb6HmqUWnb52R6mQLwvIrgZKLii5RyAz+77n7aaZ4iys2TexI2dU7pDMZWe/8S+N1gzv0WEYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2764
X-OriginatorOrg: intel.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DM6PR11MB40892D78881D0349598800429A510DM6PR11MB4089namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

here the log https://paste.centos.org/view/cbaae252

Thanks

-
Julio
________________________________
From: Paolo Bonzini <pbonzini@redhat.com>
Sent: Monday, December 16, 2019 1:23 PM
To: Montes, Julio <julio.montes@intel.com>
Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>; qemu-devel <qemu-devel@no=
ngnu.org>; Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertio=
n `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.


> 1) running "vmxcap" on the Azure VM

You need to run "modprobe msr" before.

Paolo



$ sudo ./vmxcap
Basic VMX Information
Traceback (most recent call last):
  File "./vmxcap", line 280, in <module>
    c.show()
  File "./vmxcap", line 82, in show
    value =3D msr().read(self.msr, 0)
  File "./vmxcap", line 33, in __init__
    self.f =3D open('/dev/msr0', 'rb', 0)
IOError: [Errno 2] No such file or directory: '/dev/msr0'

> 2) adding "-vmx-xsaves,-vmx-shadow-vmcs" to the "-cpu" option and, if it
> works, add only one of the two.

nop, this didn't work


> 3) if it doesn't work, adding "-vmx" to the "-cpu" option.  Either way,
> run "x86info -a" in the resulting VM.

yes, -vmx works

x86info -a  ->  https://paste.centos.org/view/f88f02f4


thanks

-
Julio

________________________________
From: Paolo Bonzini <pbonzini@redhat.com<mailto:pbonzini@redhat.com>>
Sent: Saturday, December 14, 2019 1:30 AM
To: Philippe Mathieu-Daud=E9 <philmd@redhat.com<mailto:philmd@redhat.com>>;=
 Montes, Julio <julio.montes@intel.com<mailto:julio.montes@intel.com>>; qem=
u-devel <qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org>>
Cc: Eduardo Habkost <ehabkost@redhat.com<mailto:ehabkost@redhat.com>>
Subject: Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertio=
n `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

On 14/12/19 02:31, Philippe Mathieu-Daud=E9 wrote:
>
> failed to launch qemu: exit status 1, error messages from qemu log:
> qemu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000
> qemu-system-x86_64: /root/qemu/target/i386/kvm.c:2947: kvm_put_msrs:
> Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

It could be a KVM bug too.  The following features are being enabled:

#define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
#define VMX_SECONDARY_EXEC_SHADOW_VMCS              0x00004000
#define VMX_SECONDARY_EXEC_ENABLE_INVPCID           0x00001000
#define VMX_SECONDARY_EXEC_RDRAND_EXITING           0x00000800
#define VMX_SECONDARY_EXEC_ENABLE_VPID              0x00000020
#define VMX_SECONDARY_EXEC_ENABLE_EPT               0x00000002
#define VMX_SECONDARY_EXEC_DESC                     0x00000004
#define VMX_SECONDARY_EXEC_RDTSCP                   0x00000008

Can you try:

1) running "vmxcap" on the Azure VM

2) adding "-vmx-xsaves,-vmx-shadow-vmcs" to the "-cpu" option and, if it
works, add only one of the two.

3) if it doesn't work, adding "-vmx" to the "-cpu" option.  Either way,
run "x86info -a" in the resulting VM.

Thanks,

Paolo


--_000_DM6PR11MB40892D78881D0349598800429A510DM6PR11MB4089namp_
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
<div>here the log <a href=3D"https://paste.centos.org/view/cbaae252" id=3D"=
LPlnk704098">
https://paste.centos.org/view/cbaae252</a><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
-</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Julio<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Paolo Bonzini &lt;pbo=
nzini@redhat.com&gt;<br>
<b>Sent:</b> Monday, December 16, 2019 1:23 PM<br>
<b>To:</b> Montes, Julio &lt;julio.montes@intel.com&gt;<br>
<b>Cc:</b> Philippe Mathieu-Daud=E9 &lt;philmd@redhat.com&gt;; qemu-devel &=
lt;qemu-devel@nongnu.org&gt;; Eduardo Habkost &lt;ehabkost@redhat.com&gt;<b=
r>
<b>Subject:</b> Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: A=
ssertion `ret =3D=3D cpu-&gt;kvm_msr_buf-&gt;nmsrs' failed.</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"auto">
<div>
<div class=3D"x_gmail_quote">
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
&gt; <font size=3D"2"><span style=3D"font-size:11pt">1) running &quot;vmxca=
p&quot; on the Azure VM</span></font></div>
</div>
</blockquote>
</div>
</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">You need to run &quot;modprobe msr&quot; before.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Paolo</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">
<div class=3D"x_gmail_quote">
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span><br>
</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span>$ sudo ./vmxcap <br>
</span>
<div>Basic VMX Information<br>
</div>
<div>Traceback (most recent call last):<br>
</div>
<div>&nbsp; File &quot;./vmxcap&quot;, line 280, in &lt;module&gt;<br>
</div>
<div>&nbsp; &nbsp; c.show()<br>
</div>
<div>&nbsp; File &quot;./vmxcap&quot;, line 82, in show<br>
</div>
<div>&nbsp; &nbsp; value =3D msr().read(self.msr, 0)<br>
</div>
<div>&nbsp; File &quot;./vmxcap&quot;, line 33, in __init__<br>
</div>
<div>&nbsp; &nbsp; self.f =3D open('/dev/msr0', 'rb', 0)<br>
</div>
<span>IOError: [Errno 2] No such file or directory: '/dev/msr0'</span><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
&gt; <font size=3D"2"><span style=3D"font-size:11pt">2) adding &quot;-vmx-x=
saves,-vmx-shadow-vmcs&quot; to the &quot;-cpu&quot; option and, if it<br>
&gt; works, add only one of the two.<br>
</span></font></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
nop, this didn't work</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<font size=3D"2"><span style=3D"font-size:11pt">&gt; 3) if it doesn't work,=
 adding &quot;-vmx&quot; to the &quot;-cpu&quot; option.&nbsp; Either way,<=
br>
&gt; run &quot;x86info -a&quot; in the resulting VM.</span></font></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
yes, -vmx works</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
x86info -a&nbsp; -&gt;&nbsp; <a href=3D"https://paste.centos.org/view/f88f0=
2f4" id=3D"x_m_-2086736129460788907LPlnk201976" target=3D"_blank" rel=3D"no=
referrer">
https://paste.centos.org/view/f88f02f4</a><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
thanks</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
-</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Julio<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_m_-2086736129460788907appendonsend"></div>
<hr style=3D"display:inline-block; width:98%">
<div id=3D"x_m_-2086736129460788907divRplyFwdMsg" dir=3D"ltr"><font face=3D=
"Calibri, sans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>From:</=
b> Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
<b>Sent:</b> Saturday, December 14, 2019 1:30 AM<br>
<b>To:</b> Philippe Mathieu-Daud=E9 &lt;<a href=3D"mailto:philmd@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt;; Montes, J=
ulio &lt;<a href=3D"mailto:julio.montes@intel.com" target=3D"_blank" rel=3D=
"noreferrer">julio.montes@intel.com</a>&gt;; qemu-devel &lt;<a href=3D"mail=
to:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noreferrer">qemu-devel@n=
ongnu.org</a>&gt;<br>
<b>Cc:</b> Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">ehabkost@redhat.com</a>&gt;<br>
<b>Subject:</b> Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: A=
ssertion `ret =3D=3D cpu-&gt;kvm_msr_buf-&gt;nmsrs' failed.</font>
<div>&nbsp;</div>
</div>
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div>On 14/12/19 02:31, Philippe Mathieu-Daud=E9 wrote:<br>
&gt; <br>
&gt; failed to launch qemu: exit status 1, error messages from qemu log:<br=
>
&gt; qemu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000<=
br>
&gt; qemu-system-x86_64: /root/qemu/target/i386/kvm.c:2947: kvm_put_msrs:<b=
r>
&gt; Assertion `ret =3D=3D cpu-&gt;kvm_msr_buf-&gt;nmsrs' failed.<br>
<br>
It could be a KVM bug too.&nbsp; The following features are being enabled:<=
br>
<br>
#define VMX_SECONDARY_EXEC_XSAVES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x001000=
00<br>
#define VMX_SECONDARY_EXEC_SHADOW_VMCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00004000<br>
#define VMX_SECONDARY_EXEC_ENABLE_INVPCID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0x00001000<br>
#define VMX_SECONDARY_EXEC_RDRAND_EXITING&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000800<br>
#define VMX_SECONDARY_EXEC_ENABLE_VPID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000020<br>
#define VMX_SECONDARY_EXEC_ENABLE_EPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000002<br>
#define VMX_SECONDARY_EXEC_DESC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0x00000004<br>
#define VMX_SECONDARY_EXEC_RDTSCP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000=
08<br>
<br>
Can you try:<br>
<br>
1) running &quot;vmxcap&quot; on the Azure VM<br>
<br>
2) adding &quot;-vmx-xsaves,-vmx-shadow-vmcs&quot; to the &quot;-cpu&quot; =
option and, if it<br>
works, add only one of the two.<br>
<br>
3) if it doesn't work, adding &quot;-vmx&quot; to the &quot;-cpu&quot; opti=
on.&nbsp; Either way,<br>
run &quot;x86info -a&quot; in the resulting VM.<br>
<br>
Thanks,<br>
<br>
Paolo<br>
<br>
</div>
</span></font></div>
</div>
</blockquote>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR11MB40892D78881D0349598800429A510DM6PR11MB4089namp_--

