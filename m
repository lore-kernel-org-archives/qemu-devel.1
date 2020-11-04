Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8192521734
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8192521734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=windowslive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJT2-0008Iq-5r
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 09:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foxen@windowslive.com>)
 id 1ka77h-0006D7-UJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:58:01 -0500
Received: from mail-oln040092075101.outbound.protection.outlook.com
 ([40.92.75.101]:49486 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foxen@windowslive.com>)
 id 1ka77e-0007Fl-1x
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:58:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjs/7tmF/n85+4AZSWD3upjBru/gOl9pO/QsoLRXaDlQ7QEecLnMKZjJ7/XLpM5JHjyMrgeSjfuviMysQ/a3cS2sHRvXsq5j5+1DkdNdZ67NESj7WtVwG1hU+OnkJ6Lw95QrhBStRDzISK3EONWKEnnnAGyhO2ECySQnFXV3rqr+MMEbqvs1t/TsnZm/pTVgMrw9nmFK6bu+0a7wKGLhgr4c4iDx5QXdw8mIUvLJLCMH4WnfcLiWVWKsXs5eyC8KQHOA+NgoLpquNm6Ir+PCaW1P63d/hJ6IrNVQRH7NGteOk3qbdLZwX/vJGrfnr4E3Dg4sruv/HlhdpzLqs+7fRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U0GyTwMFh8pGELZ43Ca1POfdPuKYu8oxMDoLOnKtXg=;
 b=VLXVilv9sI1s1oEQknLRlJM7vRXZLZ3RPO5CxRkIVxkuw+6Lwm4/DkLd9/LFB8wo7jiBaZw9yQJZazy3R/HL4XdbBYPO+atJbORslmvuRVhCvCp/kMs+bX4zSQfLRHWv3ajfDLkn3AEMpbQeE8p1IlT7okTn+m3Z3Li4kMOnny4rwyO+fEkuK03smc03fbX2ybItpXB9RzLz52Wh4BI1frTxuB8H2TBokGM16EMnEOKD6D7KSz5j9wC5L6MBNa4KT7cwdhp+Uy/inyOE/lMmzYEoE0iGRyBBZCJ7rqCdyIxhhMgNEgWsW+wLrNlE9cpZFj/GF2WiTJxfdIwjAJ2/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HE1EUR04FT052.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0d::43) by
 HE1EUR04HT134.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0d::194)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3520.15; Wed, 4 Nov
 2020 00:42:52 +0000
Received: from AM0PR03MB6292.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0d::50) by HE1EUR04FT052.mail.protection.outlook.com
 (2a01:111:e400:7e0d::297) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3520.15 via Frontend
 Transport; Wed, 4 Nov 2020 00:42:52 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:703F6CE4E452A63825AE4266027E45FF043312441129A6343ABC10567751F498;
 UpperCasedChecksum:94295F2C75D18581C04DA6AC0B692E130ED9247F756C6AB2813C5A65AE0093B3;
 SizeAsReceived:7452; Count:45
Received: from AM0PR03MB6292.eurprd03.prod.outlook.com
 ([fe80::bc55:cbe1:29ae:e5b0]) by AM0PR03MB6292.eurprd03.prod.outlook.com
 ([fe80::bc55:cbe1:29ae:e5b0%9]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 00:42:52 +0000
From: Fotis Xenakis <foxen@windowslive.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] Add virtio-fs in OSv overview blog post
Date: Wed,  4 Nov 2020 02:42:22 +0200
Message-ID: <AM0PR03MB62920E8F53722876D6FD3D30A6EF0@AM0PR03MB6292.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TMN: [tmJJ4DgquOkiK/sSWG4bsNaz6JruYLPYe/isqO0350r8AxAnQukBs9gU1K53lv47]
X-ClientProxiedBy: VI1PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::14) To AM0PR03MB6292.eurprd03.prod.outlook.com
 (2603:10a6:20b:15e::24)
X-Microsoft-Original-Message-ID: <20201104004222.46290-1-foxen@windowslive.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:587:e81e:b103:7882:f80e:1722:90ab)
 by VI1PR04CA0116.eurprd04.prod.outlook.com (2603:10a6:803:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 4 Nov 2020 00:42:52 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 86a2f38e-72f8-4317-e1c6-08d8805a8ffe
X-MS-TrafficTypeDiagnostic: HE1EUR04HT134:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+ExPIh209xxs1h+ZBd1v8Cbn0MAuddoaNNg24rc9x4f8g83qKgMQjMqZ+ABsbe8NA+sbkVgtTzH9JgZU+NfL7DifhtKtl9Asep03r8LyfDqvfjjrqoSwAeVZyTxPLOf2310YDmt/uMjDgDHeTptRfJqeS/CxIw6XH98JenEqdmgRMFCSjTEXLbCWOhFoCBhiLkIEvc+uFco7RFM0wemeaeFdwwFSFIVwPTnIePJRAgY8KuXYdC2+JkLgo8Nx/dK
X-MS-Exchange-AntiSpam-MessageData: uNTGHJffUD2oOQC0BKX0w7jCZoLrOTD9oqXw/3e0b4kUu0qWvtW3vW+XslGHli8IkL2AE9lskR/GG/s0RVG0QV3XN8mTXgNeSA6W2OxE85ymy2ACp5Wad0edcbqBo/jMmyBqu8kgcPiXbQGeDIAqiKsmu0t+kAqlFi3jcDT7FaObF8OaoMK24vGx62Xjfb4O57SgP1LFzjbtDqSUPEmxkA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a2f38e-72f8-4317-e1c6-08d8805a8ffe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 00:42:52.7349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR04FT052.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR04HT134
Received-SPF: pass client-ip=40.92.75.101; envelope-from=foxen@windowslive.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 19:57:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Nov 2020 09:07:47 -0500
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
Cc: virtio-fs@redhat.com, thuth@redhat.com,
 Fotis Xenakis <foxen@windowslive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This post briefly goes over the main points of virtio-fs and OSv, a
unikernel running under QEMU/KVM and taking advantage of its virtio-fs
implementation.

Feel free to review, I will be more than happy to address any comments.

Signed-off-by: Fotis Xenakis <foxen@windowslive.com>
---
 _posts/2020-11-04-osv-virtio-fs.md           | 123 +++++++++++++++++++
 screenshots/2020-11-04-unikernel-vs-gpos.svg |   1 +
 2 files changed, 124 insertions(+)
 create mode 100644 _posts/2020-11-04-osv-virtio-fs.md
 create mode 100644 screenshots/2020-11-04-unikernel-vs-gpos.svg

diff --git a/_posts/2020-11-04-osv-virtio-fs.md b/_posts/2020-11-04-osv-vir=
tio-fs.md
new file mode 100644
index 0000000..af5bb0d
--- /dev/null
+++ b/_posts/2020-11-04-osv-virtio-fs.md
@@ -0,0 +1,123 @@
+---
+layout: post
+title:  "Using virtio-fs on a unikernel"
+author: Fotis Xenakis
+date:   2020-11-04 02:00:00 +0200
+categories: [storage, virtio-fs, unikernel, OSv]
+---
+
+This article provides an overview of virtio-fs, a novel way for sharing th=
e host
+file system with guests and OSv, a specialized, light-weight operating sys=
tem
+(unikernel) for the cloud, as well as how these two fit together.
+
+## virtio-fs
+
+[Virtio-fs](https://virtio-fs.gitlab.io/) is a new host-guest shared files=
ystem,
+purpose-built for local file system semantics and performance. To that end=
, it
+takes full advantage of the host's and the guest's colocation on the same
+physical machine, unlike network-based efforts, like virtio-9p.
+
+As the name suggests, virtio-fs builds on virtio for providing an efficient
+transport: it is included in the (currently draft, to become v1.2) virtio
+[specification](https://github.com/oasis-tcs/virtio-spec) as a new device.=
 The
+protocol used by the device is a slightly extended version of
+[FUSE](https://github.com/libfuse/libfuse), providing a solid foundation f=
or
+all file system operations native on Linux. Implementation-wise, on the QE=
MU
+side, it takes the approach of splitting between the guest interface (hand=
led
+by QEMU) and the host file system interface (the device "backend"). The la=
tter
+is handled by virtiofsd ("virtio-fs daemon"), running as a separate proces=
s,
+utilizing the
+[vhost-user](https://www.qemu.org/docs/master/interop/vhost-user.html) pro=
tocol
+to communicate with QEMU.
+
+One prominent performance feature of virtio-fs is the DAX (Direct Access)
+window. What is that? It's a shared memory window between the host and the
+guest, exposed as device memory (a PCI BAR) to the second. How is it used?=
 Upon
+request, the host (QEMU) maps file contents to the window for the guest to
+access directly. This bears performance gains due to taking VMEXITs out of=
 the
+read/write data path and bypassing the guest page cache on Linux, while not
+counting against the VM's memory (since it's just device memory, managed o=
n the
+host).
+
+![virtio-fs DAX architecture](https://gitlab.com/virtio-fs/virtio-fs.gitla=
b.io/-/raw/master/architecture.svg)
+
+Virtio-fs is under active development, with its community focussing on a p=
air of
+device implementation in QEMU and device driver in Linux. Both components =
are
+already available upstream in their initial iterations, while upstreaming
+continues further e.g. with DAX window support.
+
+## OSv
+
+[OSv](https://github.com/cloudius-systems/osv) is a
+[unikernel](https://en.wikipedia.org/wiki/Unikernel) (framework). The two
+defining characteristics of a unikernel are:
+
+- **Application-specialized**: a unikernel is an executable machine image,
+  consisting of an application and supporting code (drivers, memory manage=
ment,
+  runtime etc.) linked together, running in a single address space (typica=
lly
+  in guest "kernel mode").
+- **Library OS**: each unikernel only contains the functionality mandated =
by its
+  application in terms of non-application code, i.e. no unused drivers, or=
 even
+  whole subsystems (e.g. networking, if the application doesn't use the
+  network).
+
+OSv in particular strives for binary compatibility with Linux. What this m=
eans
+is that applications built for Linux should run as OSv unikernels without
+requiring modifications or even rebuilding, at least most of the time. Of
+course, not the whole Linux ABI is supported, with system calls like `fork=
()`
+and relatives missing by design in all unikernels, which lack the notion o=
f a
+process. Despite this limitation, OSv is quite full featured, with full SMP
+support, virtual memory, a virtual file system (and many filesystem
+implementations, including ZFS) as well as a mature networking stack, base=
d of
+off FreeBSD's.
+
+At this point, one is sure to wonder "Why bother with unikernels?". The pr=
oblem
+they were originally
+[introduced](http://unikernel.org/files/2013-asplos-mirage.pdf) to solve is
+that of bloat in the modern cloud software stack. Running general-purpose
+operating systems as guests, typically for a single application/service, o=
n top
+of a hypervisor which already takes care of isolation and provides a stand=
ard
+device model means duplication, as well as loss of efficiency. This is were
+unikernels come in, trying to be just enough to support a single applicati=
on
+and as light-weight as possible, based on the assumption that they are exe=
cuting
+inside a VM. Below is an illustration of the comparison between
+general-purpose OS, unikernels and containers (as another approach to the =
same
+problem, for completeness).
+
+![Unikernels vs GPOS vs containers](/screenshots/2020-11-04-unikernel-vs-g=
pos.svg)
+
+## OSv, meet virtio-fs
+
+As is apparent e.g. from the container world, it is very common for applic=
ations
+running in isolated environments (such as containers, or unikernels even m=
ore
+so) to require host file system access. Whereas containers sharing the host
+kernel thus have an obvious, controlled path to the host file system, with
+unikernels this has been more complex: all solutions were somewhat heavywe=
ight,
+requiring a network link or indirection through network protocols. Virtio-=
fs
+then provided a significantly more attractive route: straight-forward mapp=
ing of
+fs operations (via FUSE), reusing the existing virtio transport and decent
+performance without high memory overhead.
+
+The OSv community quickly identified the opportunity and came up with a
+read-only implementation on its side, when executing under QEMU. This emph=
asized
+being lightweight complexity-wise, while catering to many of its applicati=
ons'
+requirements (they are stateless, think e.g. serverless). Notably, it incl=
udes
+support for the DAX window (even before that's merged in upstream QEMU),
+providing [excellent performance](https://github.com/foxeng/diploma), dire=
ctly
+rivalling that of its local (non-shared) counterparts such as ZFS and ROFS=
 (an
+OSv-specific read-only file system).
+
+One central point is OSv's support for booting from virtio-fs: this enables
+deploying a modified version or a whole new application **without rebuildi=
ng**
+the image, just by adjusting its root file system contents on the host. La=
st,
+owing to the DAX window practically providing low-overhead access to the h=
ost's
+page cache, scalability is also expected to excel, with it being a common
+concern due to the potentially high density of unikernels per host.
+
+## Conclusion
+
+OSv has gained a prominent new feature, powered by virtio-fs and its QEMU
+implementation. This allows efficient, lightweight and performant access t=
o the
+host's file system, thanks to the native virtio transport, usage of the FU=
SE
+protocol and the DAX window architecture. In turn, it enables use cases li=
ke
+rapid unikernel reconfiguration.
diff --git a/screenshots/2020-11-04-unikernel-vs-gpos.svg b/screenshots/202=
0-11-04-unikernel-vs-gpos.svg
new file mode 100644
index 0000000..010db7e
--- /dev/null
+++ b/screenshots/2020-11-04-unikernel-vs-gpos.svg
@@ -0,0 +1 @@
+<svg xmlns=3D"http://www.w3.org/2000/svg" xmlns:xlink=3D"http://www.w3.org=
/1999/xlink" version=3D"1.1" width=3D"681px" height=3D"201px" viewBox=3D"-0=
.5 -0.5 681 201"><defs/><g><rect x=3D"40" y=3D"160" width=3D"160" height=3D=
"40" fill=3D"#f5f5f5" stroke=3D"#666666" pointer-events=3D"all"/><g transfo=
rm=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visib=
le; text-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100=
%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><d=
iv xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-ite=
ms: unsafe center; justify-content: unsafe center; width: 158px; height: 1p=
x; padding-top: 180px; margin-left: 41px;"><div style=3D"box-sizing: border=
-box; font-size: 0; text-align: center; "><div style=3D"display: inline-blo=
ck; font-size: 12px; font-family: Helvetica; color: #333333; line-height: 1=
.2; pointer-events: all; white-space: normal; word-wrap: normal; ">Hardware=
</div></div></div></foreignObject><text x=3D"120" y=3D"184" fill=3D"#333333=
" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Hardw=
are</text></switch></g><rect x=3D"40" y=3D"120" width=3D"160" height=3D"40"=
 fill=3D"#dae8fc" stroke=3D"#6c8ebf" pointer-events=3D"all"/><g transform=
=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible=
; text-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%"=
 requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div=
 xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items=
: unsafe center; justify-content: unsafe center; width: 158px; height: 1px;=
 padding-top: 140px; margin-left: 41px;"><div style=3D"box-sizing: border-b=
ox; font-size: 0; text-align: center; "><div style=3D"display: inline-block=
; font-size: 12px; font-family: Helvetica; color: #000000; line-height: 1.2=
; pointer-events: all; white-space: normal; word-wrap: normal; ">Host OS</d=
iv></div></div></foreignObject><text x=3D"120" y=3D"144" fill=3D"#000000" f=
ont-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Host OS<=
/text></switch></g><rect x=3D"40" y=3D"80" width=3D"160" height=3D"40" fill=
=3D"#dae8fc" stroke=3D"#6c8ebf" pointer-events=3D"all"/><g transform=3D"tra=
nslate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-=
align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requir=
edFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=
=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsa=
fe center; justify-content: unsafe center; width: 158px; height: 1px; paddi=
ng-top: 100px; margin-left: 41px;"><div style=3D"box-sizing: border-box; fo=
nt-size: 0; text-align: center; "><div style=3D"display: inline-block; font=
-size: 12px; font-family: Helvetica; color: #000000; line-height: 1.2; poin=
ter-events: all; white-space: normal; word-wrap: normal; ">Hypervisor</div>=
</div></div></foreignObject><text x=3D"120" y=3D"104" fill=3D"#000000" font=
-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Hypervisor<=
/text></switch></g><rect x=3D"40" y=3D"40" width=3D"160" height=3D"40" fill=
=3D"#f8cecc" stroke=3D"#b85450" pointer-events=3D"all"/><g transform=3D"tra=
nslate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-=
align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requir=
edFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=
=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsa=
fe center; justify-content: unsafe center; width: 158px; height: 1px; paddi=
ng-top: 60px; margin-left: 41px;"><div style=3D"box-sizing: border-box; fon=
t-size: 0; text-align: center; "><div style=3D"display: inline-block; font-=
size: 12px; font-family: Helvetica; color: #000000; line-height: 1.2; point=
er-events: all; white-space: normal; word-wrap: normal; ">Guest OS</div></d=
iv></div></foreignObject><text x=3D"120" y=3D"64" fill=3D"#000000" font-fam=
ily=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Guest OS</text>=
</switch></g><rect x=3D"40" y=3D"0" width=3D"160" height=3D"40" fill=3D"#f8=
cecc" stroke=3D"#b85450" pointer-events=3D"all"/><g transform=3D"translate(=
-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: =
left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatu=
res=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http=
://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe cente=
r; justify-content: unsafe center; width: 158px; height: 1px; padding-top: =
20px; margin-left: 41px;"><div style=3D"box-sizing: border-box; font-size: =
0; text-align: center; "><div style=3D"display: inline-block; font-size: 12=
px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-event=
s: all; white-space: normal; word-wrap: normal; ">Application</div></div></=
div></foreignObject><text x=3D"120" y=3D"24" fill=3D"#000000" font-family=
=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Application</text>=
</switch></g><rect x=3D"0" y=3D"120" width=3D"40" height=3D"40" fill=3D"#ff=
ffff" stroke=3D"#000000" pointer-events=3D"all"/><g transform=3D"translate(=
-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: =
left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatu=
res=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http=
://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe cente=
r; justify-content: unsafe center; width: 38px; height: 1px; padding-top: 1=
40px; margin-left: 1px;"><div style=3D"box-sizing: border-box; font-size: 0=
; text-align: center; "><div style=3D"display: inline-block; font-size: 12p=
x; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events=
: all; white-space: normal; word-wrap: normal; ">HKS</div></div></div></for=
eignObject><text x=3D"20" y=3D"144" fill=3D"#000000" font-family=3D"Helveti=
ca" font-size=3D"12px" text-anchor=3D"middle">HKS</text></switch></g><rect =
x=3D"0" y=3D"80" width=3D"40" height=3D"40" fill=3D"#ffffff" stroke=3D"#000=
000" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch>=
<foreignObject style=3D"overflow: visible; text-align: left;" pointer-event=
s=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3=
.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/x=
html" style=3D"display: flex; align-items: unsafe center; justify-content: =
unsafe center; width: 38px; height: 1px; padding-top: 100px; margin-left: 1=
px;"><div style=3D"box-sizing: border-box; font-size: 0; text-align: center=
; "><div style=3D"display: inline-block; font-size: 12px; font-family: Helv=
etica; color: #000000; line-height: 1.2; pointer-events: all; white-space: =
normal; word-wrap: normal; ">HUS</div></div></div></foreignObject><text x=
=3D"20" y=3D"104" fill=3D"#000000" font-family=3D"Helvetica" font-size=3D"1=
2px" text-anchor=3D"middle">HUS</text></switch></g><rect x=3D"0" y=3D"40" w=
idth=3D"40" height=3D"40" fill=3D"#ffffff" stroke=3D"#000000" pointer-event=
s=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject sty=
le=3D"overflow: visible; text-align: left;" pointer-events=3D"none" width=
=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/fe=
ature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"d=
isplay: flex; align-items: unsafe center; justify-content: unsafe center; w=
idth: 38px; height: 1px; padding-top: 60px; margin-left: 1px;"><div style=
=3D"box-sizing: border-box; font-size: 0; text-align: center; "><div style=
=3D"display: inline-block; font-size: 12px; font-family: Helvetica; color: =
#000000; line-height: 1.2; pointer-events: all; white-space: normal; word-w=
rap: normal; ">GKS</div></div></div></foreignObject><text x=3D"20" y=3D"64"=
 fill=3D"#000000" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=
=3D"middle">GKS</text></switch></g><rect x=3D"0" y=3D"0" width=3D"40" heigh=
t=3D"40" fill=3D"#ffffff" stroke=3D"#000000" pointer-events=3D"all"/><g tra=
nsform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: v=
isible; text-align: left;" pointer-events=3D"none" width=3D"100%" height=3D=
"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility=
"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align=
-items: unsafe center; justify-content: unsafe center; width: 38px; height:=
 1px; padding-top: 20px; margin-left: 1px;"><div style=3D"box-sizing: borde=
r-box; font-size: 0; text-align: center; "><div style=3D"display: inline-bl=
ock; font-size: 12px; font-family: Helvetica; color: #000000; line-height: =
1.2; pointer-events: all; white-space: normal; word-wrap: normal; ">GUS</di=
v></div></div></foreignObject><text x=3D"20" y=3D"24" fill=3D"#000000" font=
-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">GUS</text><=
/switch></g><rect x=3D"280" y=3D"160" width=3D"160" height=3D"40" fill=3D"#=
f5f5f5" stroke=3D"#666666" pointer-events=3D"all"/><g transform=3D"translat=
e(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-align=
: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFea=
tures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"ht=
tp://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe cen=
ter; justify-content: unsafe center; width: 158px; height: 1px; padding-top=
: 180px; margin-left: 281px;"><div style=3D"box-sizing: border-box; font-si=
ze: 0; text-align: center; "><div style=3D"display: inline-block; font-size=
: 12px; font-family: Helvetica; color: #333333; line-height: 1.2; pointer-e=
vents: all; white-space: normal; word-wrap: normal; ">Hardware</div></div><=
/div></foreignObject><text x=3D"360" y=3D"184" fill=3D"#333333" font-family=
=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Hardware</text></s=
witch></g><rect x=3D"280" y=3D"120" width=3D"160" height=3D"40" fill=3D"#da=
e8fc" stroke=3D"#6c8ebf" pointer-events=3D"all"/><g transform=3D"translate(=
-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: =
left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatu=
res=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http=
://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe cente=
r; justify-content: unsafe center; width: 158px; height: 1px; padding-top: =
140px; margin-left: 281px;"><div style=3D"box-sizing: border-box; font-size=
: 0; text-align: center; "><div style=3D"display: inline-block; font-size: =
12px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-eve=
nts: all; white-space: normal; word-wrap: normal; ">Host OS</div></div></di=
v></foreignObject><text x=3D"360" y=3D"144" fill=3D"#000000" font-family=3D=
"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Host OS</text></switc=
h></g><rect x=3D"280" y=3D"80" width=3D"160" height=3D"40" fill=3D"#dae8fc"=
 stroke=3D"#6c8ebf" pointer-events=3D"all"/><g transform=3D"translate(-0.5 =
-0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: left;=
" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=
=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://=
www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center; =
justify-content: unsafe center; width: 158px; height: 1px; padding-top: 100=
px; margin-left: 281px;"><div style=3D"box-sizing: border-box; font-size: 0=
; text-align: center; "><div style=3D"display: inline-block; font-size: 12p=
x; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events=
: all; white-space: normal; word-wrap: normal; ">Hypervisor</div></div></di=
v></foreignObject><text x=3D"360" y=3D"104" fill=3D"#000000" font-family=3D=
"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Hypervisor</text></sw=
itch></g><rect x=3D"280" y=3D"40" width=3D"160" height=3D"40" fill=3D"#f8ce=
cc" stroke=3D"#b85450" pointer-events=3D"all"/><g transform=3D"translate(-0=
.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: le=
ft;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeature=
s=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http:/=
/www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center;=
 justify-content: unsafe center; width: 158px; height: 1px; padding-top: 60=
px; margin-left: 281px;"><div style=3D"box-sizing: border-box; font-size: 0=
; text-align: center; "><div style=3D"display: inline-block; font-size: 12p=
x; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events=
: all; white-space: normal; word-wrap: normal; ">Unikernel</div></div></div=
></foreignObject><text x=3D"360" y=3D"64" fill=3D"#000000" font-family=3D"H=
elvetica" font-size=3D"12px" text-anchor=3D"middle">Unikernel</text></switc=
h></g><rect x=3D"240" y=3D"120" width=3D"40" height=3D"40" fill=3D"#ffffff"=
 stroke=3D"#000000" pointer-events=3D"all"/><g transform=3D"translate(-0.5 =
-0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: left;=
" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=
=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://=
www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center; =
justify-content: unsafe center; width: 38px; height: 1px; padding-top: 140p=
x; margin-left: 241px;"><div style=3D"box-sizing: border-box; font-size: 0;=
 text-align: center; "><div style=3D"display: inline-block; font-size: 12px=
; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events:=
 all; white-space: normal; word-wrap: normal; ">HKS</div></div></div></fore=
ignObject><text x=3D"260" y=3D"144" fill=3D"#000000" font-family=3D"Helveti=
ca" font-size=3D"12px" text-anchor=3D"middle">HKS</text></switch></g><rect =
x=3D"240" y=3D"80" width=3D"40" height=3D"40" fill=3D"#ffffff" stroke=3D"#0=
00000" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switc=
h><foreignObject style=3D"overflow: visible; text-align: left;" pointer-eve=
nts=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.=
w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999=
/xhtml" style=3D"display: flex; align-items: unsafe center; justify-content=
: unsafe center; width: 38px; height: 1px; padding-top: 100px; margin-left:=
 241px;"><div style=3D"box-sizing: border-box; font-size: 0; text-align: ce=
nter; "><div style=3D"display: inline-block; font-size: 12px; font-family: =
Helvetica; color: #000000; line-height: 1.2; pointer-events: all; white-spa=
ce: normal; word-wrap: normal; ">HUS</div></div></div></foreignObject><text=
 x=3D"260" y=3D"104" fill=3D"#000000" font-family=3D"Helvetica" font-size=
=3D"12px" text-anchor=3D"middle">HUS</text></switch></g><rect x=3D"240" y=
=3D"40" width=3D"40" height=3D"40" fill=3D"#ffffff" stroke=3D"#000000" poin=
ter-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignO=
bject style=3D"overflow: visible; text-align: left;" pointer-events=3D"none=
" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/S=
VG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" sty=
le=3D"display: flex; align-items: unsafe center; justify-content: unsafe ce=
nter; width: 38px; height: 1px; padding-top: 60px; margin-left: 241px;"><di=
v style=3D"box-sizing: border-box; font-size: 0; text-align: center; "><div=
 style=3D"display: inline-block; font-size: 12px; font-family: Helvetica; c=
olor: #000000; line-height: 1.2; pointer-events: all; white-space: normal; =
word-wrap: normal; ">GKS</div></div></div></foreignObject><text x=3D"260" y=
=3D"64" fill=3D"#000000" font-family=3D"Helvetica" font-size=3D"12px" text-=
anchor=3D"middle">GKS</text></switch></g><rect x=3D"520" y=3D"160" width=3D=
"160" height=3D"40" fill=3D"#f5f5f5" stroke=3D"#666666" pointer-events=3D"a=
ll"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"=
overflow: visible; text-align: left;" pointer-events=3D"none" width=3D"100%=
" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Ex=
tensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: =
flex; align-items: unsafe center; justify-content: unsafe center; width: 15=
8px; height: 1px; padding-top: 180px; margin-left: 521px;"><div style=3D"bo=
x-sizing: border-box; font-size: 0; text-align: center; "><div style=3D"dis=
play: inline-block; font-size: 12px; font-family: Helvetica; color: #333333=
; line-height: 1.2; pointer-events: all; white-space: normal; word-wrap: no=
rmal; ">Hardware</div></div></div></foreignObject><text x=3D"600" y=3D"184"=
 fill=3D"#333333" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=
=3D"middle">Hardware</text></switch></g><rect x=3D"520" y=3D"120" width=3D"=
160" height=3D"40" fill=3D"#dae8fc" stroke=3D"#6c8ebf" pointer-events=3D"al=
l"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"o=
verflow: visible; text-align: left;" pointer-events=3D"none" width=3D"100%"=
 height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Ext=
ensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: f=
lex; align-items: unsafe center; justify-content: unsafe center; width: 158=
px; height: 1px; padding-top: 140px; margin-left: 521px;"><div style=3D"box=
-sizing: border-box; font-size: 0; text-align: center; "><div style=3D"disp=
lay: inline-block; font-size: 12px; font-family: Helvetica; color: #000000;=
 line-height: 1.2; pointer-events: all; white-space: normal; word-wrap: nor=
mal; ">Host OS</div></div></div></foreignObject><text x=3D"600" y=3D"144" f=
ill=3D"#000000" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D=
"middle">Host OS</text></switch></g><rect x=3D"520" y=3D"80" width=3D"160" =
height=3D"40" fill=3D"#dae8fc" stroke=3D"#6c8ebf" pointer-events=3D"all"/><=
g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overfl=
ow: visible; text-align: left;" pointer-events=3D"none" width=3D"100%" heig=
ht=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensib=
ility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; =
align-items: unsafe center; justify-content: unsafe center; width: 158px; h=
eight: 1px; padding-top: 100px; margin-left: 521px;"><div style=3D"box-sizi=
ng: border-box; font-size: 0; text-align: center; "><div style=3D"display: =
inline-block; font-size: 12px; font-family: Helvetica; color: #000000; line=
-height: 1.2; pointer-events: all; white-space: normal; word-wrap: normal; =
">Container runtime</div></div></div></foreignObject><text x=3D"600" y=3D"1=
04" fill=3D"#000000" font-family=3D"Helvetica" font-size=3D"12px" text-anch=
or=3D"middle">Container runtime</text></switch></g><rect x=3D"520" y=3D"40"=
 width=3D"160" height=3D"40" fill=3D"#fff2cc" stroke=3D"#d6b656" pointer-ev=
ents=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject =
style=3D"overflow: visible; text-align: left;" pointer-events=3D"none" widt=
h=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/f=
eature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"=
display: flex; align-items: unsafe center; justify-content: unsafe center; =
width: 158px; height: 1px; padding-top: 60px; margin-left: 521px;"><div sty=
le=3D"box-sizing: border-box; font-size: 0; text-align: center; "><div styl=
e=3D"display: inline-block; font-size: 12px; font-family: Helvetica; color:=
 #000000; line-height: 1.2; pointer-events: all; white-space: normal; word-=
wrap: normal; ">Container</div></div></div></foreignObject><text x=3D"600" =
y=3D"64" fill=3D"#000000" font-family=3D"Helvetica" font-size=3D"12px" text=
-anchor=3D"middle">Container</text></switch></g><rect x=3D"480" y=3D"120" w=
idth=3D"40" height=3D"40" fill=3D"#ffffff" stroke=3D"#000000" pointer-event=
s=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject sty=
le=3D"overflow: visible; text-align: left;" pointer-events=3D"none" width=
=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/fe=
ature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"d=
isplay: flex; align-items: unsafe center; justify-content: unsafe center; w=
idth: 38px; height: 1px; padding-top: 140px; margin-left: 481px;"><div styl=
e=3D"box-sizing: border-box; font-size: 0; text-align: center; "><div style=
=3D"display: inline-block; font-size: 12px; font-family: Helvetica; color: =
#000000; line-height: 1.2; pointer-events: all; white-space: normal; word-w=
rap: normal; ">HKS</div></div></div></foreignObject><text x=3D"500" y=3D"14=
4" fill=3D"#000000" font-family=3D"Helvetica" font-size=3D"12px" text-ancho=
r=3D"middle">HKS</text></switch></g><rect x=3D"480" y=3D"40" width=3D"40" h=
eight=3D"80" fill=3D"#ffffff" stroke=3D"#000000" pointer-events=3D"all"/><g=
 transform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflo=
w: visible; text-align: left;" pointer-events=3D"none" width=3D"100%" heigh=
t=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibi=
lity"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; a=
lign-items: unsafe center; justify-content: unsafe center; width: 38px; hei=
ght: 1px; padding-top: 80px; margin-left: 481px;"><div style=3D"box-sizing:=
 border-box; font-size: 0; text-align: center; "><div style=3D"display: inl=
ine-block; font-size: 12px; font-family: Helvetica; color: #000000; line-he=
ight: 1.2; pointer-events: all; white-space: normal; word-wrap: normal; ">H=
US</div></div></div></foreignObject><text x=3D"500" y=3D"84" fill=3D"#00000=
0" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">HUS<=
/text></switch></g></g><switch><g requiredFeatures=3D"http://www.w3.org/TR/=
SVG11/feature#Extensibility"/><a transform=3D"translate(0,-5)" xlink:href=
=3D"https://desk.draw.io/support/solutions/articles/16000042487" target=3D"=
_blank"><text text-anchor=3D"middle" font-size=3D"10px" x=3D"50%" y=3D"100%=
">Viewer does not support full SVG 1.1</text></a></switch></svg>
\ No newline at end of file
--=20
2.29.2


