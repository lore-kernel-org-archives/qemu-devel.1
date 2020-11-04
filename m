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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660A6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD254206CA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD254206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=windowslive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLwa-0005th-LQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foxen@windowslive.com>)
 id 1kaLvh-00052E-KP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:46:37 -0500
Received: from mail-am6eur05olkn2078.outbound.protection.outlook.com
 ([40.92.91.78]:16480 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foxen@windowslive.com>)
 id 1kaLvb-0002rB-RS
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:46:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jnf1AyTg2Q4nMbQ4TPQhyzfeh3iDsxY7F+X4HRubDoZYjVY5wlzKP99/OPky4XkHU/ovh7UmDZtBHHPKvSz7vQ7rM+qKiBYjEJvjGR1ivjvI5tqYIp+vMYIYjZMiTDXeVkkMZ3tnLRGJBICk1j01lO75lQ5yFWteAxYpJnszAviKLOm1Bces6T59/7j0+Ke1aXkehB6sm/K/j53lmLmGLn2zMpjaqqp8kDDQCzqCGnCmq+2Ji++Ts50U6VZUHfCuHORCmO165CZKIV1ssbNsDMMb/Mmeg/QoY2slHxvqEtRQ18Zw1SXClL2oGvsD2WSMCz5vKJQbk6K3BUjpCpBg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF77jr8dEU+9bBKelvkvmijoIX2KOKadoP5urqD1/CA=;
 b=bkZzamx/P7aGBXV6r5ZeHrTJZVdzt+YhTeF/KUBEg/Gee3JU/Mo50tjSogAtYZakiYhMOaFO1CKwIhg+qRsfP7KH7zslKbXAy8J8IC2NWLgRQXxe1bSMXjAMiXfwrATYr3Y0UYdz0geHdl+NSSev7w3Sw1qXUxlYN01Xv5CpRpj5iGDiV2EaJZLUuxuTPwvGI233DIT5z91HFkGqH6HOfLLs+7eHdL6mPgegsyr5NAYyLD/DA6kIFQdGDpOY9QJPX+HgeWTL/eDy7Xkb9WQRA6QcYGF3qCSzpDXf69NgQ2b3Ohi2drf5E/lSNfk1Y4inAh+MKDpsUmLsfMJFbLUUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM6EUR05FT032.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::51) by
 AM6EUR05HT018.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::388)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3520.15; Wed, 4 Nov
 2020 16:46:27 +0000
Received: from AM0PR03MB6292.eurprd03.prod.outlook.com
 (2a01:111:e400:fc11::50) by AM6EUR05FT032.mail.protection.outlook.com
 (2a01:111:e400:fc11::101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3520.15 via Frontend
 Transport; Wed, 4 Nov 2020 16:46:27 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:C7740B6E674A1F639C96C9F6E7CB103942AFA4025D8AE590311A08AF30D01B1B;
 UpperCasedChecksum:A66CB12BE39627A0161DF25115AC7F5AB170571F7C26389F1483413F5E5B1BE8;
 SizeAsReceived:7450; Count:45
Received: from AM0PR03MB6292.eurprd03.prod.outlook.com
 ([fe80::bc55:cbe1:29ae:e5b0]) by AM0PR03MB6292.eurprd03.prod.outlook.com
 ([fe80::bc55:cbe1:29ae:e5b0%9]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 16:46:27 +0000
From: Fotis Xenakis <foxen@windowslive.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH v2] Add virtio-fs in OSv overview blog post
Date: Wed,  4 Nov 2020 18:46:16 +0200
Message-ID: <AM0PR03MB629226965B72D3808EFB8795A6EF0@AM0PR03MB6292.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TMN: [OR+JuOXiBbADFpGJqEYutT6tzP8xdI3bxrkThUbLjskTifxH0mDw9+LEcmpzBc0E]
X-ClientProxiedBy: VI1P194CA0007.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::17) To AM0PR03MB6292.eurprd03.prod.outlook.com
 (2603:10a6:20b:15e::24)
X-Microsoft-Original-Message-ID: <20201104164616.46323-1-foxen@windowslive.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:587:e81e:b103:7882:f80e:1722:90ab)
 by VI1P194CA0007.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Wed, 4 Nov 2020 16:46:26 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 0f51c344-616b-4b52-bbff-08d880e12c54
X-MS-TrafficTypeDiagnostic: AM6EUR05HT018:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZmCA1eQi94WdDkxJ37bYe0vZi9muYMO1RcGJ+yjaTzxWwrPv8jVCJsMWJBC3pMzZ/QUakYDYATZRB9F1DOURI9Vz0G6CFECbXyJOOtT272Q+Q5+J8VFdfukeFZcn12MYl6RYKl1JpwNDPUvv0b4aiQqJ34C4A1kJAYNlJ2Xyg5jDNlHyDPv4PyZ5Hpsy++JlmT6fzLsoo9TggzjV/BohJ//Nu1jKkaWcHY7+bODRocRjhdl2M8CuTu2aMeKsvTV
X-MS-Exchange-AntiSpam-MessageData: m6tZN2aednSbiTFxxfqc4H+x1DucGSHTovjZS9luXhotLR6h5xfJLDgdpf7EoO5PcynzVj9aS61zp4klJcf2Ltr4IGuu6AktwvuOqkQRuwpz+tKAhw0DjBKRXsNhWZGPIpylo2+3DXg1LsS6n1RRD5dNYZyndP18QuTHdSRgLlAFwY0jCRZKLRoPmVOEhqou5MBUlC+DNFGsFA2dF5fAbg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f51c344-616b-4b52-bbff-08d880e12c54
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 16:46:27.5878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT032.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT018
Received-SPF: pass client-ip=40.92.91.78; envelope-from=foxen@windowslive.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 11:46:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
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
Cc: virtio-fs@redhat.com, thuth@redhat.com,
 Fotis Xenakis <foxen@windowslive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This post briefly goes over the main points of virtio-fs and OSv, a
unikernel running under QEMU/KVM and taking advantage of its virtio-fs
implementation.

Changes since v1:
- Fixed wording and links, as suggested by Thomas Huth.
- Added a short example of virtio-fs usage in OSv.

Signed-off-by: Fotis Xenakis <foxen@windowslive.com>
---
 _posts/2020-11-04-osv-virtio-fs.md           | 143 +++++++++++++++++++
 screenshots/2020-11-04-unikernel-vs-gpos.svg |   1 +
 2 files changed, 144 insertions(+)
 create mode 100644 _posts/2020-11-04-osv-virtio-fs.md
 create mode 100644 screenshots/2020-11-04-unikernel-vs-gpos.svg

diff --git a/_posts/2020-11-04-osv-virtio-fs.md b/_posts/2020-11-04-osv-vir=
tio-fs.md
new file mode 100644
index 0000000..78ccab1
--- /dev/null
+++ b/_posts/2020-11-04-osv-virtio-fs.md
@@ -0,0 +1,143 @@
+---
+layout: post
+title:  "Using virtio-fs on a unikernel"
+author: Fotis Xenakis
+date:   2020-11-04 02:00:00 +0200
+categories: [storage, virtio-fs, unikernel, OSv]
+---
+
+This article provides an overview of [virtio-fs](https://virtio-fs.gitlab.=
io/),
+a novel way for sharing the host file system with guests and
+[OSv](https://github.com/cloudius-systems/osv), a specialized, lightweight
+operating system (unikernel) for the cloud, as well as how these two fit
+together.
+
+## virtio-fs
+
+Virtio-fs is a new host-guest shared filesystem, purpose-built for local f=
ile
+system semantics and performance. To that end, it takes full advantage of =
the
+host's and the guest's colocation on the same physical machine, unlike
+network-based efforts, like virtio-9p.
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
+window. It's a shared memory window between the host and the guest, expose=
d as
+device memory (a PCI BAR) to the second. Upon request, the host (QEMU) map=
s file contents to the window for the guest to access directly. This bears =
performance
+gains due to taking VMEXITs out of the read/write data path and bypassing =
the
+guest page cache on Linux, while not counting against the VM's memory (sin=
ce
+it's just device memory, managed on the host).
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
+OSv is a [unikernel](https://en.wikipedia.org/wiki/Unikernel) (framework).=
 The
+two defining characteristics of a unikernel are:
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
+OSv in particular strives for binary compatibility with Linux, using a [dy=
namic
+linker](https://github.com/cloudius-systems/osv/wiki/Dynamic-Linker). This=
 means
+that applications built for Linux should run as OSv unikernels without req=
uiring
+modifications or even rebuilding, at least most of the time. Of course, no=
t the
+whole Linux ABI is supported, with system calls like `fork()` and relatives
+missing by design in all unikernels, which lack the notion of a process. D=
espite
+this limitation, OSv is quite full featured, with full SMP support, virtual
+memory, a virtual file system (and many filesystem implementations, includ=
ing
+ZFS) as well as a mature networking stack, based on the FreeBSD sources.
+
+At this point, one is sure to wonder "Why bother with unikernels?". The pr=
oblem
+they were originally
+[introduced](http://unikernel.org/files/2013-asplos-mirage.pdf) to solve i=
s the
+bloated software stack in modern cloud computing. Running general-purpose
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
+For example, to build the `cli` OSv image, bootable from virtio-fs, using =
the
+core OSv [build
+system](https://github.com/cloudius-systems/osv#building-osv-kernel-and-cr=
eating-images):
+```
+scripts/build fs=3Dvirtiofs export=3Dall image=3Dcli
+```
+This results in a minimal image (just the initramfs), while the root fs co=
ntents
+are placed in a directory on the host (`build/export` here, by default).
+
+[Running](https://github.com/cloudius-systems/osv#running-osv) the above i=
mage
+is just a step away (may want to use the virtio-fs development version of
+[QEMU](https://gitlab.com/virtio-fs/qemu/-/tree/virtio-fs-dev), e.g. for D=
AX
+window support):
+```
+scripts/run.py --virtio-fs-tag=3Dmyfs --virtio-fs-dir=3D$(pwd)/build/export
+```
+This orchestrates running both virtiofsd and QEMU, using the contents of
+`build/export` as the root file system. Any changes to this directory, dir=
ectly
+from the host will be visible in the guest without re-running the previous=
 build
+step.
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


