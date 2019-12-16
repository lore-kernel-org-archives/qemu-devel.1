Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6057DC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3852082E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="pZTIUMOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3852082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59399 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igwgM-0007M5-3y
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 15:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <julio.montes@intel.com>) id 1igwfd-0006xP-9Z
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1igwfb-0007WD-8G
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:08:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:10362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1igwfa-0007Ix-N0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:08:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 11:16:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
 d="scan'208,217";a="247149482"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga002.fm.intel.com with ESMTP; 16 Dec 2019 11:16:22 -0800
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 11:16:22 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 11:16:22 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 16 Dec 2019 11:16:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gccrxFqLp8CnDtG53Fr7Dn1F1TT59IflZKSDdug2IsadiZjI9IbwEC9vNhcIYkfLqCEvG+rd1lL1iHJKPRQM/dv2jca/tOZIY73QcZVV8lLqtLvp9dhGkJJgRlzaVm61yaRSEIoHvbOTebYw7IPNZRXMoePB3emmSKoqPJwHMYlv8e4/AeGOd4HsCj0raCmQkN4cQNTzPoD2kyXYhRvWlYTHtOl8pc372MYWx1RnN3kamVCCi5rn1r2BFaQbhOyW2uFThGp+XQZm2rS7gezbPmpa/hHKyzbQy9MzsHXhua53RhZhg/33kBBj3MLRU0T0wW8xZxISXBcbGLXuHGAGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9gm/qz9eBVUp3G148/4Jb4emRNTQt+Sjfplz5P3VmQ=;
 b=L8Ra+daT52AABcKp8fzdi7BRpTe2oZnB2bfhodVZpyrLVt4q8jaHnogJ/J+9WaUyiOJOm0gr7s1NlZsAIIAzjFcmAmVC2WPSeFnbw/Ix2dC7fz0G4rq7tJXqYP5YHnjqPEc55S9OSTNXHecKETqrYhHa9TufljDlNyRGhpsr4BLd1S7AgjmAsNbGmgmniaRWdvL1YbEo+TsR6Mlef1tHSO9ISzN9dNai+LNLh9kKUs5by5tNhODfVZ/T5preS2iGtzHtz3YkAVFBYAQ5tgzlh2kTbhJ5A2SDth15VPLjtmmYrtoNZxi7vAyqX3IpLZGJUXnmlXL5anFSX3uQ3FA94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9gm/qz9eBVUp3G148/4Jb4emRNTQt+Sjfplz5P3VmQ=;
 b=pZTIUMOBv/ZJHkco/aDaRHkzV4dzqVnY9SXqqdvST/IRk185SCeGWXy5P+ddqkiaTKFBmZ6UdRjb2gew2Va4kM8uGeTv1NVJ/9Rce1iv4u0H579k/0UiKVlt96pUR++n2GnlN4L4Y54V+odM3+T/cJ3UG67ap0NLYvJbwEYK7P0=
Received: from DM6PR11MB4089.namprd11.prod.outlook.com (20.176.126.91) by
 DM6PR11MB4329.namprd11.prod.outlook.com (52.132.251.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Mon, 16 Dec 2019 19:16:21 +0000
Received: from DM6PR11MB4089.namprd11.prod.outlook.com
 ([fe80::3ceb:88f0:7717:7ecd]) by DM6PR11MB4089.namprd11.prod.outlook.com
 ([fe80::3ceb:88f0:7717:7ecd%7]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 19:16:20 +0000
From: "Montes, Julio" <julio.montes@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel
 <qemu-devel@nongnu.org>
Subject: Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertion
 `ret == cpu->kvm_msr_buf->nmsrs' failed.
Thread-Topic: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertion
 `ret == cpu->kvm_msr_buf->nmsrs' failed.
Thread-Index: AQHVsfc5K/GHgo1+SUW1rgjP3fus/6e42ICAgABkWoCAA9UT0Q==
Date: Mon, 16 Dec 2019 19:16:20 +0000
Message-ID: <DM6PR11MB4089FF5F11BC215320EB502E9A510@DM6PR11MB4089.namprd11.prod.outlook.com>
References: <DM6PR11MB4089A0B695CB84FB288068B89A540@DM6PR11MB4089.namprd11.prod.outlook.com>
 <2c28287e-1869-751d-f7c8-04605ef4b337@redhat.com>,
 <d969066a-b10c-ebbc-b784-a19a66a5a831@redhat.com>
In-Reply-To: <d969066a-b10c-ebbc-b784-a19a66a5a831@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=julio.montes@intel.com; 
x-originating-ip: [134.134.139.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91c27921-6608-4524-9955-08d7825c6f23
x-ms-traffictypediagnostic: DM6PR11MB4329:
x-microsoft-antispam-prvs: <DM6PR11MB43298865936D0B77946B73319A510@DM6PR11MB4329.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(86362001)(316002)(64756008)(66446008)(19627405001)(478600001)(66946007)(5660300002)(52536014)(6506007)(76116006)(91956017)(26005)(186003)(81166006)(8676002)(33656002)(7696005)(8936002)(81156014)(2906002)(4326008)(71200400001)(110136005)(9686003)(966005)(66476007)(55016002)(66556008)(53546011)(81973001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR11MB4329;
 H:DM6PR11MB4089.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPcgzxlpC80TtI3cALHTBpdyPoozFk166NIQaXQK8Z0ALYY1W/7lxX+/uzd8YLbiP2wVN8yjXbUltE9YIJjXzET0wWl5M9IVr1SyWpVTK2QJ7SOlCf6m6q1YUIEYU2dNHO7FFbJdwTGu1qtQ1flj7kEC5HnWywDvb5bk5swuFnZRxzwGM35UKe3Vh7jzPM8E+o5whEsl7e/Qv35lrr+31hUpto9rQR43V42T13/y86J6k+mv+2N6Y9PBm/ItkrXfcT2c8gdCHGwY9WVorU6SaBEO3b0JH1+80g5q6fwHzLlPGeZkkAIhaAzyLVEfPPRDXT9zczhVlXbTHwISeDUkeSeKXTrhxZShKIXTEI/BmthIYXIzY7mFca0O4mnQs8R5p0TmaGub2lnlHX6/a7jZuIPzM/VDgg/zcQ8i+ksicji0yekdR/IpSnxNVZOr+J6PxYaBFtkIEklQLy3kDZXA7PTbPnStBv/o7QJaPp4D6OB6rEvNa30MxSmx3oHROeSqZt/ISp7DG62E/KX0zWStZQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR11MB4089FF5F11BC215320EB502E9A510DM6PR11MB4089namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c27921-6608-4524-9955-08d7825c6f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 19:16:20.8671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JBeOMVjBoyCJRkdUm6L7FoY/v7KP5i0Md9hWjOzBgJ00AaDvs148IHiw4dMskfhS3txBLPee5wxgQ3D1ztvpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4329
X-OriginatorOrg: intel.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DM6PR11MB4089FF5F11BC215320EB502E9A510DM6PR11MB4089namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Paolo and Philippe

> Are you running also nested on your workstation?

yes, qemu in qemu

> 1) running "vmxcap" on the Azure VM

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
From: Paolo Bonzini <pbonzini@redhat.com>
Sent: Saturday, December 14, 2019 1:30 AM
To: Philippe Mathieu-Daud=E9 <philmd@redhat.com>; Montes, Julio <julio.mont=
es@intel.com>; qemu-devel <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>
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


--_000_DM6PR11MB4089FF5F11BC215320EB502E9A510DM6PR11MB4089namp_
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
Hi Paolo and Philippe</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&gt; <font size=3D"2"><span style=3D"font-size:11pt">Are you running also n=
ested on your workstation?</span></font><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
yes, qemu in qemu</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&gt; <font size=3D"2"><span style=3D"font-size:11pt">1) running &quot;vmxca=
p&quot; on the Azure VM</span></font><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&gt; <font size=3D"2"><span style=3D"font-size:11pt">2) adding &quot;-vmx-x=
saves,-vmx-shadow-vmcs&quot; to the &quot;-cpu&quot; option and, if it<br>
&gt; works, add only one of the two.<br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
nop, this didn't work</div>
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
<font size=3D"2"><span style=3D"font-size:11pt">&gt; 3) if it doesn't work,=
 adding &quot;-vmx&quot; to the &quot;-cpu&quot; option.&nbsp; Either way,<=
br>
&gt; run &quot;x86info -a&quot; in the resulting VM.</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
yes, -vmx works</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
x86info -a&nbsp; -&gt;&nbsp; <a href=3D"https://paste.centos.org/view/f88f0=
2f4" id=3D"LPlnk201976">
https://paste.centos.org/view/f88f02f4</a><br>
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
thanks</div>
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Paolo Bonzini &lt;pbo=
nzini@redhat.com&gt;<br>
<b>Sent:</b> Saturday, December 14, 2019 1:30 AM<br>
<b>To:</b> Philippe Mathieu-Daud=E9 &lt;philmd@redhat.com&gt;; Montes, Juli=
o &lt;julio.montes@intel.com&gt;; qemu-devel &lt;qemu-devel@nongnu.org&gt;<=
br>
<b>Cc:</b> Eduardo Habkost &lt;ehabkost@redhat.com&gt;<br>
<b>Subject:</b> Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: A=
ssertion `ret =3D=3D cpu-&gt;kvm_msr_buf-&gt;nmsrs' failed.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 14/12/19 02:31, Philippe Mathieu-Daud=E9 wrote:=
<br>
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
</body>
</html>

--_000_DM6PR11MB4089FF5F11BC215320EB502E9A510DM6PR11MB4089namp_--

