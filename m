Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9DAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D434206CA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D434206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=windowslive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLmb-000706-Au
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foxen@windowslive.com>)
 id 1kaLlI-0005ks-8t
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:35:52 -0500
Received: from mail-db8eur05olkn2014.outbound.protection.outlook.com
 ([40.92.89.14]:44065 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foxen@windowslive.com>)
 id 1kaLlE-0001ED-E0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:35:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1sV0ZuvpHZcqpk9ULH2erk3M5+I34ltVg9l3SiH/LLrA59Yds0fF1KnpWU8WxVrYHMn37B9P9WEgGH+0feom9lzRxpRgC3JibXrGf5rbLQ+1aVXpfcY5GfidgYLyNqmjuq1NZQpyaWrzxyqIvbBa7jckf04l+FNnfLwSli2INCQzAlQszOz0r5epRmyNW1aOT+ztujm8Pgnt6rxsWOHUz4GiG8H8K2g86W+ObJxsE6KcV5s8cT17xHZCNSs5QuVVMQJHI0uhnNvIQAMtJlFpClvZnihpQSvzMbRWMd4fbL1tyY8eLk/AJLjLENk6atzRmWOC7vLgW6ry6CTvrTHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOplJXcl0H80+cQhKFPmaB+z2Nj3Fe9vmmga+y4mJHk=;
 b=gPCcyte9HYK4T+XG3wDRMHi4XPUPe7Le15ZFraqMX0RYEmhamSwVri6dYtKOrCamVTq9aM+b350E1p8Aelby5zh3tUHDyhS4SOF7SY1h2c7Cxn7cIf+SgygeR1Ms/serj1BZXzdL29yDPreo5jKT0Km+UI5MMGXRIC9l0q90azBXWlkvh9cr69ZWVFnVaOh8O6Azn7xyKbSc8Be8QNDHP4wquVWHB9knYiJ/FyBYOHHd7PL12vjz/5zgIBM/U4FtYRKsor54xuWIvfeQlQR6jh36DG2hhN+AeQawFWzDe+goFEu6uMPCv/jwNGKEHBuc8AxAGnA8TPEsp868+dVgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR05FT036.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::47) by
 VI1EUR05HT076.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::189)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3520.15; Wed, 4 Nov
 2020 16:35:45 +0000
Received: from AM0PR03MB6292.eurprd03.prod.outlook.com
 (2a01:111:e400:fc12::51) by VI1EUR05FT036.mail.protection.outlook.com
 (2a01:111:e400:fc12::183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3520.15 via Frontend
 Transport; Wed, 4 Nov 2020 16:35:45 +0000
Received: from AM0PR03MB6292.eurprd03.prod.outlook.com
 ([fe80::bc55:cbe1:29ae:e5b0]) by AM0PR03MB6292.eurprd03.prod.outlook.com
 ([fe80::bc55:cbe1:29ae:e5b0%9]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 16:35:45 +0000
From: Fotis Xenakis <foxen@windowslive.com>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [qemu-web PATCH] Add virtio-fs in OSv overview blog post
Thread-Topic: [qemu-web PATCH] Add virtio-fs in OSv overview blog post
Thread-Index: AQHWskNtv/qaDaOSnU2Bfj7VI3PCVKm3uo0AgAAXLXU=
Date: Wed, 4 Nov 2020 16:35:45 +0000
Message-ID: <AM0PR03MB629214AC7AE3F2D6BF1B28A9A6EF0@AM0PR03MB6292.eurprd03.prod.outlook.com>
References: <AM0PR03MB62920E8F53722876D6FD3D30A6EF0@AM0PR03MB6292.eurprd03.prod.outlook.com>,
 <d7f5f49c-0cf4-0116-91ac-50bad486e31f@redhat.com>
In-Reply-To: <d7f5f49c-0cf4-0116-91ac-50bad486e31f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:ABB68E95A2B415325C55A6D52361A446B40F6C7E03378FBA68BC5CD5A14555E2;
 UpperCasedChecksum:4D149F52D16E9101A8AD3556687BF3167A770C450FCE24E8125AEE3FB059AAB8;
 SizeAsReceived:7186; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [WW0DWwkzNptoq7FS1HEkkuRrYXjQY80hDZRf0S7BOs+cHczkmj7hUSQnxtnUXqcv]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 738cdbf5-45eb-4d7c-d91c-08d880dfad9f
x-ms-traffictypediagnostic: VI1EUR05HT076:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVNL5KUCYmCFBDG2P99ASo2jVAdPdZK/N9tlOQWEgm7MpYsah/WLUx8PQgaaCk45dbEH+HJgIcTpTbK/F3z14Hm/b7nMYHY/87hDZxjxUEFdd46Cs2eSOW9p4OOgmcmBRueSZqCNfKxe0cBTNR86P+Icop4WNgmRWKeJF4zSbuLtwZ0gYmoYYd4/FUAkBUeYg1KT+GP5Bq9dZ5R+Mcta7ctRW3mOWgV9btwznTNV5JXNOsBUTo3zsAh/P5aeaDqI
x-ms-exchange-antispam-messagedata: /CGsTB6axUgY9OJD+DGuelDN5kUSZN6ltprhEOx9UwtLW0flJtJ8gcuixEUYawlkJkTbh2TS+VuGh2Vh26+y7w63D6PGF0h26Xc2hTiSnAyQjn0PqDf7qKzqx4a58zJfzij8SVxhZ3LM5wSnDUISS7fqEQQij1wsXCZnaBIuJFWt+nrcmgrMzz4OkNwm7iXuPlver4enfy2lzRhcJSfYJg==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM0PR03MB629214AC7AE3F2D6BF1B28A9A6EF0AM0PR03MB6292eurp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT036.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 738cdbf5-45eb-4d7c-d91c-08d880dfad9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 16:35:45.1115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT076
Received-SPF: pass client-ip=40.92.89.14; envelope-from=foxen@windowslive.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 11:35:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "virtio-fs@redhat.com" <virtio-fs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM0PR03MB629214AC7AE3F2D6BF1B28A9A6EF0AM0PR03MB6292eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Thomas Huth <thuth@redhat.com>
Sent: Wednesday, November 4, 2020 11:47
To: Fotis Xenakis <foxen@windowslive.com>; qemu-devel@nongnu.org <qemu-deve=
l@nongnu.org>
Cc: virtio-fs@redhat.com <virtio-fs@redhat.com>
Subject: Re: [qemu-web PATCH] Add virtio-fs in OSv overview blog post

On 04/11/2020 01.42, Fotis Xenakis wrote:
> This post briefly goes over the main points of virtio-fs and OSv, a
> unikernel running under QEMU/KVM and taking advantage of its virtio-fs
> implementation.
>
> Feel free to review, I will be more than happy to address any comments.

Thanks, articles for the QEMU blog are always welcome! Some comments below.=
..

> diff --git a/_posts/2020-11-04-osv-virtio-fs.md b/_posts/2020-11-04-osv-v=
irtio-fs.md
> new file mode 100644
> index 0000000..af5bb0d
> --- /dev/null
> +++ b/_posts/2020-11-04-osv-virtio-fs.md
> @@ -0,0 +1,123 @@
> +---
> +layout: post
> +title:  "Using virtio-fs on a unikernel"
> +author: Fotis Xenakis
> +date:   2020-11-04 02:00:00 +0200
> +categories: [storage, virtio-fs, unikernel, OSv]
> +---
> +
> +This article provides an overview of virtio-fs, a novel way for sharing =
the host
> +file system with guests and OSv, a specialized, light-weight operating s=
ystem
> +(unikernel) for the cloud, as well as how these two fit together.

I'd maybe add the links to the virtio-fs and OSv homepage in this paragraph
already, since they are mentioned here for the first time.
For links that you want to use multiple times, you can also declare them at
the end of the file, so that you only have to provide the URL one time. See
e.g. this article as an example:

https://gitlab.com/qemu-project/qemu-web/-/blob/master/_posts/2017-11-22-ha=
xm-usage-windows.md#L101
In fact I forgot to move the links after I added the introduction. Will fix=
 this in v2, thanks!

> +## virtio-fs
> +
> +[Virtio-fs](https://virtio-fs.gitlab.io/) is a new host-guest shared fil=
esystem,
> +purpose-built for local file system semantics and performance. To that e=
nd, it
> +takes full advantage of the host's and the guest's colocation on the sam=
e
> +physical machine, unlike network-based efforts, like virtio-9p.
> +
> +As the name suggests, virtio-fs builds on virtio for providing an effici=
ent
> +transport: it is included in the (currently draft, to become v1.2) virti=
o
> +[specification](https://github.com/oasis-tcs/virtio-spec) as a new devic=
e. The
> +protocol used by the device is a slightly extended version of
> +[FUSE](https://github.com/libfuse/libfuse), providing a solid foundation=
 for
> +all file system operations native on Linux. Implementation-wise, on the =
QEMU
> +side, it takes the approach of splitting between the guest interface (ha=
ndled
> +by QEMU) and the host file system interface (the device "backend"). The =
latter
> +is handled by virtiofsd ("virtio-fs daemon"), running as a separate proc=
ess,
> +utilizing the
> +[vhost-user](https://www.qemu.org/docs/master/interop/vhost-user.html) p=
rotocol
> +to communicate with QEMU.
> +
> +One prominent performance feature of virtio-fs is the DAX (Direct Access=
)
> +window. What is that? It's a shared memory window between the host and t=
he

I'd rather simply say "This is a shared ..." and scratch the "What is that?=
"
question.

> +guest, exposed as device memory (a PCI BAR) to the second. How is it use=
d? Upon

I'd rather drop the "How is it used?" question.
Changing both.
> +request, the host (QEMU) maps file contents to the window for the guest =
to
> +access directly. This bears performance gains due to taking VMEXITs out =
of the
> +read/write data path and bypassing the guest page cache on Linux, while =
not
> +counting against the VM's memory (since it's just device memory, managed=
 on the
> +host).
> +
> +![virtio-fs DAX architecture](https://gitlab.com/virtio-fs/virtio-fs.git=
lab.io/-/raw/master/architecture.svg)
> +
> +Virtio-fs is under active development, with its community focussing on a=
 pair of
> +device implementation in QEMU and device driver in Linux. Both component=
s are
> +already available upstream in their initial iterations, while upstreamin=
g
> +continues further e.g. with DAX window support.
> +
> +## OSv
> +
> +[OSv](https://github.com/cloudius-systems/osv) is a
> +[unikernel](https://en.wikipedia.org/wiki/Unikernel) (framework). The tw=
o
> +defining characteristics of a unikernel are:
> +
> +- **Application-specialized**: a unikernel is an executable machine imag=
e,
> +  consisting of an application and supporting code (drivers, memory mana=
gement,
> +  runtime etc.) linked together, running in a single address space (typi=
cally
> +  in guest "kernel mode").
> +- **Library OS**: each unikernel only contains the functionality mandate=
d by its
> +  application in terms of non-application code, i.e. no unused drivers, =
or even
> +  whole subsystems (e.g. networking, if the application doesn't use the
> +  network).
> +
> +OSv in particular strives for binary compatibility with Linux. What this=
 means

I'd rather say "This means that ..." instead.
Changed!
> +is that applications built for Linux should run as OSv unikernels withou=
t
> +requiring modifications or even rebuilding, at least most of the time.

Sorry for asking ignorant questions: Does that mean that OSv has a dynamic
linker for Linux ELF binaries?
That's exactly the case: https://github.com/cloudius-systems/osv/wiki/Dynam=
ic-Linker
I 'll add a reference in the text too.
> Of
> +course, not the whole Linux ABI is supported, with system calls like `fo=
rk()`
> +and relatives missing by design in all unikernels, which lack the notion=
 of a
> +process. Despite this limitation, OSv is quite full featured, with full =
SMP
> +support, virtual memory, a virtual file system (and many filesystem
> +implementations, including ZFS) as well as a mature networking stack, ba=
sed of
> +off FreeBSD's.

maybe rather "based on the FreeBSD sources" or something similar?
Sounds good and is accurate, adopted
> +At this point, one is sure to wonder "Why bother with unikernels?". The =
problem
> +they were originally
> +[introduced](http://unikernel.org/files/2013-asplos-mirage.pdf) to solve=
 is
> +that of bloat in the modern cloud software stack.

I'm not a native speaker, but I'd maybe rather say something like:
.. to solve is the burden of the bloat of the modern cload software stack ?
How about "... to solve is the bloated software stack in modern cloud compu=
ting"?

> Running general-purpose
> +operating systems as guests, typically for a single application/service,=
 on top
> +of a hypervisor which already takes care of isolation and provides a sta=
ndard
> +device model means duplication, as well as loss of efficiency. This is w=
ere
> +unikernels come in, trying to be just enough to support a single applica=
tion
> +and as light-weight as possible, based on the assumption that they are e=
xecuting
> +inside a VM. Below is an illustration of the comparison between
> +general-purpose OS, unikernels and containers (as another approach to th=
e same
> +problem, for completeness).
> +
> +![Unikernels vs GPOS vs containers](/screenshots/2020-11-04-unikernel-vs=
-gpos.svg)
> +
> +## OSv, meet virtio-fs
> +
> +As is apparent e.g. from the container world, it is very common for appl=
ications
> +running in isolated environments (such as containers, or unikernels even=
 more
> +so) to require host file system access. Whereas containers sharing the h=
ost
> +kernel thus have an obvious, controlled path to the host file system, wi=
th
> +unikernels this has been more complex: all solutions were somewhat heavy=
weight,
> +requiring a network link or indirection through network protocols. Virti=
o-fs
> +then provided a significantly more attractive route: straight-forward ma=
pping of
> +fs operations (via FUSE), reusing the existing virtio transport and dece=
nt
> +performance without high memory overhead.
> +
> +The OSv community quickly identified the opportunity and came up with a
> +read-only implementation on its side, when executing under QEMU. This em=
phasized
> +being lightweight complexity-wise, while catering to many of its applica=
tions'
> +requirements (they are stateless, think e.g. serverless). Notably, it in=
cludes
> +support for the DAX window (even before that's merged in upstream QEMU),
> +providing [excellent performance](https://github.com/foxeng/diploma), di=
rectly
> +rivalling that of its local (non-shared) counterparts such as ZFS and RO=
FS (an
> +OSv-specific read-only file system).
> +
> +One central point is OSv's support for booting from virtio-fs: this enab=
les
> +deploying a modified version or a whole new application **without rebuil=
ding**
> +the image, just by adjusting its root file system contents on the host. =
Last,
> +owing to the DAX window practically providing low-overhead access to the=
 host's
> +page cache, scalability is also expected to excel, with it being a commo=
n
> +concern due to the potentially high density of unikernels per host.

After reading the initial paragraphs of this mail, I was somehow expecting
to see at least a short example / description of how to use virtio-fs with
OSv ... do you maybe at least want to provide a pointer to further
documentation here so that people know where to look next if they want to
try out virtio-fs with OSv?
Unfortunately, documentation is kind of lacking in OSv (the source is the b=
est, if
not only documentation for anything not in the wiki).
I will add brief instructions here for using virtio-fs as the root file sys=
tem in OSv.

> +## Conclusion
> +
> +OSv has gained a prominent new feature, powered by virtio-fs and its QEM=
U
> +implementation. This allows efficient, lightweight and performant access=
 to the
> +host's file system, thanks to the native virtio transport, usage of the =
FUSE
> +protocol and the DAX window architecture. In turn, it enables use cases =
like
> +rapid unikernel reconfiguration.

 Thomas
Thank you very much for the feedback!

Fotis


--_000_AM0PR03MB629214AC7AE3F2D6BF1B28A9A6EF0AM0PR03MB6292eurp_
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
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
</div>
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Thomas Huth &lt;thuth=
@redhat.com&gt;<br>
<b>Sent:</b> Wednesday, November 4, 2020 11:47<br>
<b>To:</b> Fotis Xenakis &lt;foxen@windowslive.com&gt;; qemu-devel@nongnu.o=
rg &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> virtio-fs@redhat.com &lt;virtio-fs@redhat.com&gt;<br>
<b>Subject:</b> Re: [qemu-web PATCH] Add virtio-fs in OSv overview blog pos=
t</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">
<blockquote class=3D"quotableTextTraining" style=3D"border-left:3px solid r=
gb(200,200,200); border-top-color:rgb(200,200,200); border-right-color:rgb(=
200,200,200); border-bottom-color:rgb(200,200,200); padding-left:1ex; margi=
n-left:0.8ex; color:rgb(102,102,102)">
On 04/11/2020 01.42, Fotis Xenakis wrote:<br>
&gt; This post briefly goes over the main points of virtio-fs and OSv, a<br=
>
&gt; unikernel running under QEMU/KVM and taking advantage of its virtio-fs=
<br>
&gt; implementation.<br>
&gt; <br>
&gt; Feel free to review, I will be more than happy to address any comments=
.<br>
<br>
Thanks, articles for the QEMU blog are always welcome! Some comments below.=
..<br>
<br>
&gt; diff --git a/_posts/2020-11-04-osv-virtio-fs.md b/_posts/2020-11-04-os=
v-virtio-fs.md<br>
&gt; new file mode 100644<br>
&gt; index 0000000..af5bb0d<br>
&gt; --- /dev/null<br>
&gt; +++ b/_posts/2020-11-04-osv-virtio-fs.md<br>
&gt; @@ -0,0 +1,123 @@<br>
&gt; +---<br>
&gt; +layout: post<br>
&gt; +title:&nbsp; &quot;Using virtio-fs on a unikernel&quot;<br>
&gt; +author: Fotis Xenakis<br>
&gt; +date:&nbsp;&nbsp; 2020-11-04 02:00:00 +0200<br>
&gt; +categories: [storage, virtio-fs, unikernel, OSv]<br>
&gt; +---<br>
&gt; +<br>
&gt; +This article provides an overview of virtio-fs, a novel way for shari=
ng the host<br>
&gt; +file system with guests and OSv, a specialized, light-weight operatin=
g system<br>
&gt; +(unikernel) for the cloud, as well as how these two fit together.<br>
<br>
I'd maybe add the links to the virtio-fs and OSv homepage in this paragraph=
<br>
already, since they are mentioned here for the first time.<br>
For links that you want to use multiple times, you can also declare them at=
<br>
the end of the file, so that you only have to provide the URL one time. See=
<br>
e.g. this article as an example:<br>
<br>
<div><a href=3D"https://gitlab.com/qemu-project/qemu-web/-/blob/master/_pos=
ts/2017-11-22-haxm-usage-windows.md#L101">https://gitlab.com/qemu-project/q=
emu-web/-/blob/master/_posts/2017-11-22-haxm-usage-windows.md#L101</a></div=
>
</blockquote>
<div>In fact I forgot to move the links after I added the introduction. Wil=
l fix this in v2, thanks!</div>
<blockquote class=3D"quotableTextTraining" style=3D"border-left:3px solid r=
gb(200,200,200); border-top-color:rgb(200,200,200); border-right-color:rgb(=
200,200,200); border-bottom-color:rgb(200,200,200); padding-left:1ex; margi=
n-left:0.8ex; color:rgb(102,102,102)">
<br>
&gt; +## virtio-fs<br>
&gt; +<br>
&gt; +[Virtio-fs](https://virtio-fs.gitlab.io/) is a new host-guest shared =
filesystem,<br>
&gt; +purpose-built for local file system semantics and performance. To tha=
t end, it<br>
&gt; +takes full advantage of the host's and the guest's colocation on the =
same<br>
&gt; +physical machine, unlike network-based efforts, like virtio-9p.<br>
&gt; +<br>
&gt; +As the name suggests, virtio-fs builds on virtio for providing an eff=
icient<br>
&gt; +transport: it is included in the (currently draft, to become v1.2) vi=
rtio<br>
&gt; +[specification](https://github.com/oasis-tcs/virtio-spec) as a new de=
vice. The<br>
&gt; +protocol used by the device is a slightly extended version of<br>
&gt; +[FUSE](https://github.com/libfuse/libfuse), providing a solid foundat=
ion for<br>
&gt; +all file system operations native on Linux. Implementation-wise, on t=
he QEMU<br>
&gt; +side, it takes the approach of splitting between the guest interface =
(handled<br>
&gt; +by QEMU) and the host file system interface (the device &quot;backend=
&quot;). The latter<br>
&gt; +is handled by virtiofsd (&quot;virtio-fs daemon&quot;), running as a =
separate process,<br>
&gt; +utilizing the<br>
&gt; +[vhost-user](https://www.qemu.org/docs/master/interop/vhost-user.html=
) protocol<br>
&gt; +to communicate with QEMU.<br>
&gt; +<br>
&gt; +One prominent performance feature of virtio-fs is the DAX (Direct Acc=
ess)<br>
&gt; +window. What is that? It's a shared memory window between the host an=
d the<br>
<br>
I'd rather simply say &quot;This is a shared ...&quot; and scratch the &quo=
t;What is that?&quot;<br>
question.<br>
<br>
&gt; +guest, exposed as device memory (a PCI BAR) to the second. How is it =
used? Upon<br>
<br>
<div>I'd rather drop the &quot;How is it used?&quot; question.</div>
</blockquote>
<div>Changing both.</div>
<blockquote class=3D"quotableTextTraining" style=3D"border-left:3px solid r=
gb(200,200,200); border-top-color:rgb(200,200,200); border-right-color:rgb(=
200,200,200); border-bottom-color:rgb(200,200,200); padding-left:1ex; margi=
n-left:0.8ex; color:rgb(102,102,102)">
<div><span style=3D"color:rgb(102,102,102)">&gt; +request, the host (QEMU) =
maps file contents to the window for the guest to</span><br>
</div>
&gt; +access directly. This bears performance gains due to taking VMEXITs o=
ut of the<br>
&gt; +read/write data path and bypassing the guest page cache on Linux, whi=
le not<br>
&gt; +counting against the VM's memory (since it's just device memory, mana=
ged on the<br>
&gt; +host).<br>
&gt; +<br>
&gt; +![virtio-fs DAX architecture](<a href=3D"https://gitlab.com/virtio-fs=
/virtio-fs.gitlab.io/-/raw/master/architecture.svg">https://gitlab.com/virt=
io-fs/virtio-fs.gitlab.io/-/raw/master/architecture.svg</a>)<br>
&gt; +<br>
&gt; +Virtio-fs is under active development, with its community focussing o=
n a pair of<br>
&gt; +device implementation in QEMU and device driver in Linux. Both compon=
ents are<br>
&gt; +already available upstream in their initial iterations, while upstrea=
ming<br>
&gt; +continues further e.g. with DAX window support.<br>
&gt; +<br>
&gt; +## OSv<br>
&gt; +<br>
&gt; +[OSv](https://github.com/cloudius-systems/osv) is a<br>
&gt; +[unikernel](https://en.wikipedia.org/wiki/Unikernel) (framework). The=
 two<br>
&gt; +defining characteristics of a unikernel are:<br>
&gt; +<br>
&gt; +- **Application-specialized**: a unikernel is an executable machine i=
mage,<br>
&gt; +&nbsp; consisting of an application and supporting code (drivers, mem=
ory management,<br>
&gt; +&nbsp; runtime etc.) linked together, running in a single address spa=
ce (typically<br>
&gt; +&nbsp; in guest &quot;kernel mode&quot;).<br>
&gt; +- **Library OS**: each unikernel only contains the functionality mand=
ated by its<br>
&gt; +&nbsp; application in terms of non-application code, i.e. no unused d=
rivers, or even<br>
&gt; +&nbsp; whole subsystems (e.g. networking, if the application doesn't =
use the<br>
&gt; +&nbsp; network).<br>
&gt; +<br>
&gt; +OSv in particular strives for binary compatibility with Linux. What t=
his means<br>
<br>
<div>I'd rather say &quot;This means that ...&quot; instead.</div>
</blockquote>
<div>Changed!</div>
<blockquote class=3D"quotableTextTraining" style=3D"border-left:3px solid r=
gb(200,200,200); border-top-color:rgb(200,200,200); border-right-color:rgb(=
200,200,200); border-bottom-color:rgb(200,200,200); padding-left:1ex; margi=
n-left:0.8ex; color:rgb(102,102,102)">
<div><span style=3D"color:rgb(102,102,102)">&gt; +is that applications buil=
t for Linux should run as OSv unikernels without</span><br>
</div>
&gt; +requiring modifications or even rebuilding, at least most of the time=
.<br>
<br>
Sorry for asking ignorant questions: Does that mean that OSv has a dynamic<=
br>
<div>linker for Linux ELF binaries?</div>
</blockquote>
<div>That's exactly the case:&nbsp;<a href=3D"https://github.com/cloudius-s=
ystems/osv/wiki/Dynamic-Linker" id=3D"LPlnk439533">https://github.com/cloud=
ius-systems/osv/wiki/Dynamic-Linker</a></div>
<div>I 'll add a reference in the text too.</div>
<blockquote class=3D"quotableTextTraining" style=3D"border-left:3px solid r=
gb(200,200,200); border-top-color:rgb(200,200,200); border-right-color:rgb(=
200,200,200); border-bottom-color:rgb(200,200,200); padding-left:1ex; margi=
n-left:0.8ex; color:rgb(102,102,102)">
<div><span style=3D"color:rgb(102,102,102)">&gt; Of</span><br>
</div>
&gt; +course, not the whole Linux ABI is supported, with system calls like =
`fork()`<br>
&gt; +and relatives missing by design in all unikernels, which lack the not=
ion of a<br>
&gt; +process. Despite this limitation, OSv is quite full featured, with fu=
ll SMP<br>
&gt; +support, virtual memory, a virtual file system (and many filesystem<b=
r>
&gt; +implementations, including ZFS) as well as a mature networking stack,=
 based of<br>
&gt; +off FreeBSD's.<br>
<br>
<div>maybe rather &quot;based on the FreeBSD sources&quot; or something sim=
ilar?</div>
</blockquote>
<div>Sounds good and is accurate, adopted</div>
<blockquote class=3D"quotableTextTraining" style=3D"border-left:3px solid r=
gb(200,200,200); border-top-color:rgb(200,200,200); border-right-color:rgb(=
200,200,200); border-bottom-color:rgb(200,200,200); padding-left:1ex; margi=
n-left:0.8ex; color:rgb(102,102,102)">
<div><span style=3D"color:rgb(102,102,102)">&gt; +At this point, one is sur=
e to wonder &quot;Why bother with unikernels?&quot;. The problem</span></di=
v>
&gt; +they were originally<br>
&gt; +[introduced](http://unikernel.org/files/2013-asplos-mirage.pdf) to so=
lve is<br>
&gt; +that of bloat in the modern cloud software stack.<br>
<br>
I'm not a native speaker, but I'd maybe rather say something like:<br>
<div>.. to solve is the burden of the bloat of the modern cload software st=
ack ?</div>
</blockquote>
<div>How about &quot;... to solve is the bloated software stack in modern c=
loud computing&quot;?</div>
<blockquote class=3D"quotableTextTraining" style=3D"border-left:3px solid r=
gb(200,200,200); border-top-color:rgb(200,200,200); border-right-color:rgb(=
200,200,200); border-bottom-color:rgb(200,200,200); padding-left:1ex; margi=
n-left:0.8ex; color:rgb(102,102,102)">
<br>
&gt; Running general-purpose<br>
&gt; +operating systems as guests, typically for a single application/servi=
ce, on top<br>
&gt; +of a hypervisor which already takes care of isolation and provides a =
standard<br>
&gt; +device model means duplication, as well as loss of efficiency. This i=
s were<br>
&gt; +unikernels come in, trying to be just enough to support a single appl=
ication<br>
&gt; +and as light-weight as possible, based on the assumption that they ar=
e executing<br>
&gt; +inside a VM. Below is an illustration of the comparison between<br>
&gt; +general-purpose OS, unikernels and containers (as another approach to=
 the same<br>
&gt; +problem, for completeness).<br>
&gt; +<br>
&gt; +![Unikernels vs GPOS vs containers](/screenshots/2020-11-04-unikernel=
-vs-gpos.svg)<br>
&gt; +<br>
&gt; +## OSv, meet virtio-fs<br>
&gt; +<br>
&gt; +As is apparent e.g. from the container world, it is very common for a=
pplications<br>
&gt; +running in isolated environments (such as containers, or unikernels e=
ven more<br>
&gt; +so) to require host file system access. Whereas containers sharing th=
e host<br>
&gt; +kernel thus have an obvious, controlled path to the host file system,=
 with<br>
&gt; +unikernels this has been more complex: all solutions were somewhat he=
avyweight,<br>
&gt; +requiring a network link or indirection through network protocols. Vi=
rtio-fs<br>
&gt; +then provided a significantly more attractive route: straight-forward=
 mapping of<br>
&gt; +fs operations (via FUSE), reusing the existing virtio transport and d=
ecent<br>
&gt; +performance without high memory overhead.<br>
&gt; +<br>
&gt; +The OSv community quickly identified the opportunity and came up with=
 a<br>
&gt; +read-only implementation on its side, when executing under QEMU. This=
 emphasized<br>
&gt; +being lightweight complexity-wise, while catering to many of its appl=
ications'<br>
&gt; +requirements (they are stateless, think e.g. serverless). Notably, it=
 includes<br>
&gt; +support for the DAX window (even before that's merged in upstream QEM=
U),<br>
&gt; +providing [excellent performance](<a href=3D"https://github.com/foxen=
g/diploma">https://github.com/foxeng/diploma</a>), directly<br>
&gt; +rivalling that of its local (non-shared) counterparts such as ZFS and=
 ROFS (an<br>
&gt; +OSv-specific read-only file system).<br>
&gt; +<br>
&gt; +One central point is OSv's support for booting from virtio-fs: this e=
nables<br>
&gt; +deploying a modified version or a whole new application **without reb=
uilding**<br>
&gt; +the image, just by adjusting its root file system contents on the hos=
t. Last,<br>
&gt; +owing to the DAX window practically providing low-overhead access to =
the host's<br>
&gt; +page cache, scalability is also expected to excel, with it being a co=
mmon<br>
&gt; +concern due to the potentially high density of unikernels per host.<b=
r>
<br>
After reading the initial paragraphs of this mail, I was somehow expecting<=
br>
to see at least a short example / description of how to use virtio-fs with<=
br>
OSv ... do you maybe at least want to provide a pointer to further<br>
documentation here so that people know where to look next if they want to<b=
r>
<div>try out virtio-fs with OSv?</div>
</blockquote>
<div>Unfortunately, documentation is kind of lacking in OSv (the source is =
the best, if&nbsp;</div>
<div>not only documentation for anything not in the wiki).</div>
<div>I will add brief instructions here for using virtio-fs as the root fil=
e system in OSv.</div>
<blockquote class=3D"quotableTextTraining" style=3D"border-left:3px solid r=
gb(200,200,200); border-top-color:rgb(200,200,200); border-right-color:rgb(=
200,200,200); border-bottom-color:rgb(200,200,200); padding-left:1ex; margi=
n-left:0.8ex; color:rgb(102,102,102)">
<br>
&gt; +## Conclusion<br>
&gt; +<br>
&gt; +OSv has gained a prominent new feature, powered by virtio-fs and its =
QEMU<br>
&gt; +implementation. This allows efficient, lightweight and performant acc=
ess to the<br>
&gt; +host's file system, thanks to the native virtio transport, usage of t=
he FUSE<br>
&gt; +protocol and the DAX window architecture. In turn, it enables use cas=
es like<br>
&gt; +rapid unikernel reconfiguration.<br>
<br>
<div>&nbsp;Thomas<br>
</div>
</blockquote>
<div>Thank you very much for the feedback!</div>
<div><br>
</div>
<div>Fotis</div>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM0PR03MB629214AC7AE3F2D6BF1B28A9A6EF0AM0PR03MB6292eurp_--

