Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E814C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 01:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA3420728
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 01:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA3420728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=windowslive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbDSM-0001dB-8c
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 20:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foxen@windowslive.com>)
 id 1kbAh5-0003BH-VR
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 17:58:55 -0500
Received: from mail-db8eur05olkn2023.outbound.protection.outlook.com
 ([40.92.89.23]:3073 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foxen@windowslive.com>)
 id 1kbAh3-0004Pk-P4
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 17:58:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPfKx94c/MqU0+PsU7BCNSlAxtlOQuAlfRFRjJaTj0bas7iKOuonWswlhdlx354DWQBpWBZHiGosjsCCl7R9jmQ+SO5dijqxu7n4tCR7GzUWwYABnX/n1mLmLADqMWELncsoBUo2uZq8ypGwDA7JBe59kT9za7tjMc+l7jy1q9QmhAIeX9PvYRxOpTNt4ZvAdeDdpb9C7YQFypAjjUj4UuxoUwkGAOz8UoCPkHE2U3OczCssjYPutJYmRVqld4gkRGUKx4zryF4V62Cu8BX4MNz5QelVpKVAKC+E/FEwNPO7wwnXDkk+oSldGm+1JIS8QJPm5XLDrp2XL1XLczc0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT6k39KN63S17edyhXAOAsyGNFou670DGujRXWD4Hcs=;
 b=iXAVoNGU69JxNSOgNh6D66J/U5XmmlKwzwZp3poXhHcz+naKGMOWoQNXE4itUSj+CItB7ZfeTEH46ssQCI1oehZsyvpf165h0BuJ/YeKQv5sNH9kE5eHWgoLtTUW/l19ar0mwct9LVl0KuzWm0A9/Olr5tJUlGZkUGzMOSIGMLRjru8P8CMjPcf0dJOo0sF15nkeJtsdApc1ZQrLQtIbxKZ+tStky1DVXi0jHpoWHpWKytlLpb4BhvsmfgUwsWYK5Rf/Ia7BQaTo+ewNKqB4XrkWDb8aPbO/PS4nCpnhheekePpZCLECK44PJ1aCGCt0bdaIztgnug8oFWh6hHy3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM6EUR05FT051.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::45) by
 AM6EUR05HT004.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::112)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3520.15; Fri, 6 Nov
 2020 22:43:48 +0000
Received: from AM0PR03MB6292.eurprd03.prod.outlook.com
 (2a01:111:e400:fc11::4c) by AM6EUR05FT051.mail.protection.outlook.com
 (2a01:111:e400:fc11::439) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.17 via Frontend
 Transport; Fri, 6 Nov 2020 22:43:48 +0000
Received: from AM0PR03MB6292.eurprd03.prod.outlook.com
 ([fe80::bc55:cbe1:29ae:e5b0]) by AM0PR03MB6292.eurprd03.prod.outlook.com
 ([fe80::bc55:cbe1:29ae:e5b0%9]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 22:43:48 +0000
From: Fotis Xenakis <foxen@windowslive.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [Virtio-fs] [qemu-web PATCH v2] Add virtio-fs in OSv overview
 blog post
Thread-Topic: [Virtio-fs] [qemu-web PATCH v2] Add virtio-fs in OSv overview
 blog post
Thread-Index: AQHWssoK3s/6fYjLwkqYhPTju7OCoqm7awqAgABEmU4=
Date: Fri, 6 Nov 2020 22:43:48 +0000
Message-ID: <AM0PR03MB62922C93066A83FBB8480E5EA6ED0@AM0PR03MB6292.eurprd03.prod.outlook.com>
References: <AM0PR03MB629226965B72D3808EFB8795A6EF0@AM0PR03MB6292.eurprd03.prod.outlook.com>,
 <20201106181155.GR3576@work-vm>
In-Reply-To: <20201106181155.GR3576@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:71C266F6849184919DDD0AAF2EF6294B83F3FF50355C0AF68C40F35A1A8CAB1A;
 UpperCasedChecksum:842B0AD6A3AC57B15F062735FE0B18277523CB905647CE36A40E5A482E2DB3C3;
 SizeAsReceived:7205; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [/zkbApgZDjYGLXKrzUzeSI8BwQh84YGjs6usnb8AX1aiQ9IXFomOcyAsZj+G8VHv]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 884b2e8c-a899-40e2-3e12-08d882a56d44
x-ms-traffictypediagnostic: AM6EUR05HT004:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: asCgruczbzqWmtCbVe8Hh0wsEJ5cBlkzpCwJf5vX6wgWHc/y+BwilSS/4QfJ5Dvo/Df6fnI+JJxXu0OEwXEbJIv5dIUnULdYaIaFqxUs59/HPgBqZ64u182jESozLs1VRzi9XogVX+0oyyus+i5are64Np8Myb0BGIWDZBIq91ErSnvSyKmuyTHUe7R9aEZpIqx2hN0QObU7lHPbKnpBOg==
x-ms-exchange-antispam-messagedata: JCZjRbKhlPfDLfl2kzhIwYF/F//EQXGReiH6EtCJeTQsk+rn4p7IVJGes6rQeXaYYjyopBrr8MLBEZhYuU9rr+NXYDq1vSaY5+SdJtjznpeifWBFloDxB/QbaK4id9UwLwqpTcshqsskp8CgOgpTUS+7kxVL/3PCGooqiOkAlkxyCrO4Smhzni61sR9pMzRBy0Y0J8uaD9CK0jhgOuIoug==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM0PR03MB62922C93066A83FBB8480E5EA6ED0AM0PR03MB6292eurp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT051.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 884b2e8c-a899-40e2-3e12-08d882a56d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 22:43:48.6860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT004
Received-SPF: pass client-ip=40.92.89.23; envelope-from=foxen@windowslive.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 17:58:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 06 Nov 2020 20:54:24 -0500
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
Cc: "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM0PR03MB62922C93066A83FBB8480E5EA6ED0AM0PR03MB6292eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Dr. David Alan Gilbert <dgilbert@redhat.com>
* Fotis Xenakis (foxen@windowslive.com) wrote:
> This post briefly goes over the main points of virtio-fs and OSv, a
> unikernel running under QEMU/KVM and taking advantage of its virtio-fs
> implementation.
>
> Changes since v1:
> - Fixed wording and links, as suggested by Thomas Huth.
> - Added a short example of virtio-fs usage in OSv.
>
> Signed-off-by: Fotis Xenakis <foxen@windowslive.com>

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

Hi Fotis,
Hello Dave,
  Since I'm not used to unikernels, I'm a little confused by this; I'd
appreciate some explanation.

  In your unikernel, does the root filesystem just contain data?  I mean
being a 'unikernel' aren't all the binaries and support all linked into
the kernel itself?
Short answer: the root file system doesn't contain only data, the
executable can also be loaded from it. Although a unikernel, it
supports both the embedded-in-kernel and separate-filesystem
approaches.

OSv is more heavy-weight than most unikernels, in the sense that it
supports a lot of features found in general-purpose OSs. One could
just describe it as a specialized, light-weight OS. On the filesystem
side, it's actually pretty close e.g. to Linux: it has a VFS and multiple
filesystems:

  *   pseudo-fs (devfs and others)
  *   ramfs, which is indeed embedded into the kernel
  *   ZFS and ROFS, on regular block devices
  *   NFS, virtio-fs

Also like Linux, it initially boots into its initramfs (embedded in the
kernel) and then typically mounts a root file system from a device
(ZFS, ROFS or virtio-fs), before executing the application code.

In case this is not clear, please feel free to ask further!

Fotis

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


--_000_AM0PR03MB62922C93066A83FBB8480E5EA6ED0AM0PR03MB6292eurp_
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
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
</div>
<div dir=3D"ltr"><font face=3D"Calibri, sans-serif" color=3D"#000000" style=
=3D"font-size:11pt"><b>From:</b> Dr. David Alan Gilbert &lt;dgilbert@redhat=
.com&gt;<br>
</font></div>
<blockquote class=3D"quotableTextTraining" style=3D"border-left: 3px solid =
rgb(200, 200, 200); border-top-color: rgb(200, 200, 200); border-right-colo=
r: rgb(200, 200, 200); border-bottom-color: rgb(200, 200, 200); padding-lef=
t: 1ex; margin-left: 0.8ex; color: rgb(102, 102, 102);">
<div id=3D"divRplyFwdMsg" dir=3D"ltr">
<div>* Fotis Xenakis (foxen@windowslive.com) wrote:<br>
</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">&gt; This post briefly goes over the main points o=
f virtio-fs and OSv, a<br>
&gt; unikernel running under QEMU/KVM and taking advantage of its virtio-fs=
<br>
&gt; implementation.<br>
&gt; <br>
&gt; Changes since v1:<br>
&gt; - Fixed wording and links, as suggested by Thomas Huth.<br>
&gt; - Added a short example of virtio-fs usage in OSv.<br>
&gt; <br>
&gt; Signed-off-by: Fotis Xenakis &lt;foxen@windowslive.com&gt;<br>
<br>
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
</div>
<div class=3D"PlainText">Hi Fotis,<br>
</div>
</span></font></div>
</blockquote>
<div class=3D"PlainText">Hello Dave,</div>
<blockquote class=3D"quotableTextTraining" style=3D"border-left: 3px solid =
rgb(200, 200, 200); border-top-color: rgb(200, 200, 200); border-right-colo=
r: rgb(200, 200, 200); border-bottom-color: rgb(200, 200, 200); padding-lef=
t: 1ex; margin-left: 0.8ex; color: rgb(102, 102, 102);">
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">&nbsp; Since I'm not used to unikernels, I'm a lit=
tle confused by this; I'd<br>
appreciate some explanation.<br>
<br>
&nbsp; In your unikernel, does the root filesystem just contain data?&nbsp;=
 I mean<br>
being a 'unikernel' aren't all the binaries and support all linked into<br>
</div>
<div class=3D"PlainText">the kernel itself?<br>
</div>
</span></font></div>
</blockquote>
<div class=3D"PlainText">Short answer: the root file system doesn't contain=
 only data, the</div>
<div class=3D"PlainText">executable can also be loaded from it. Although a =
unikernel, it</div>
<div class=3D"PlainText">supports both the embedded-in-kernel and separate-=
filesystem</div>
<div class=3D"PlainText">approaches.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">OSv is more heavy-weight than most unikernels, in =
the sense that it<br>
</div>
<div class=3D"PlainText">supports a lot of features found in general-purpos=
e OSs. One could</div>
<div class=3D"PlainText">just describe it as a specialized, light-weight OS=
. On the filesystem</div>
<div class=3D"PlainText">side, it's actually pretty close e.g. to Linux: it=
 has a VFS and multiple</div>
<div class=3D"PlainText">filesystems:</div>
<div class=3D"PlainText">
<ul>
<li>pseudo-fs (devfs and others)</li><li>ramfs, which is indeed embedded in=
to the kernel</li><li>ZFS and ROFS, on regular block devices</li><li>NFS, v=
irtio-fs<br>
</li></ul>
<div>Also like Linux, it initially boots into its initramfs (embedded in th=
e</div>
<div>kernel) and then typically mounts a root file system from a device</di=
v>
<div>(ZFS, ROFS or virtio-fs), before executing the application code.</div>
<div><br>
</div>
<div>In case this is not clear, please feel free to ask further!</div>
<div><br>
</div>
<div>Fotis</div>
</div>
<blockquote class=3D"quotableTextTraining" style=3D"border-left: 3px solid =
rgb(200, 200, 200); border-top-color: rgb(200, 200, 200); border-right-colo=
r: rgb(200, 200, 200); border-bottom-color: rgb(200, 200, 200); padding-lef=
t: 1ex; margin-left: 0.8ex; color: rgb(102, 102, 102);">
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
Dave<br>
-- <br>
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK<br>
</div>
</span></font></div>
</blockquote>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
</div>
</span></font></div>
</body>
</html>

--_000_AM0PR03MB62922C93066A83FBB8480E5EA6ED0AM0PR03MB6292eurp_--

