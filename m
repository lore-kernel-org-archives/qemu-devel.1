Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A359C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 03:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30FB52054F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 03:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FB52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZQql-00057H-Dq
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 23:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jZQpp-0003pw-Fj
 for qemu-devel@nongnu.org; Thu, 14 May 2020 23:16:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:8787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jZQpm-0006cL-TY
 for qemu-devel@nongnu.org; Thu, 14 May 2020 23:16:28 -0400
IronPort-SDR: /fRF7LmriesGQTPbWe9P1bU456Han1lA1qoN04c73Uh1iqnsWj3r8rt5UPQGENUoA+QkW15Lbb
 nAbpkHLTOmjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2020 20:16:21 -0700
IronPort-SDR: naaBlX9Iz0pBghTl3Fa3l/jxFwJhAtZDwq6xbrBMXyXXYBF7TTy+mLaNHgb7qPKtJOrdZbj1EH
 Fp6mBHW++tQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
 d="scan'208,217";a="410311654"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga004.jf.intel.com with ESMTP; 14 May 2020 20:16:20 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 14 May 2020 20:16:20 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 11:16:18 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Fri, 15 May 2020 11:16:18 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Li Zhijian
 <lizhijian@cn.fujitsu.com>
Subject: About migration/colo issue
Thread-Topic: About migration/colo issue
Thread-Index: AdYqZjudkmlVb8B9TvKOADpJ4VTuWA==
Date: Fri, 15 May 2020 03:16:18 +0000
Message-ID: <7a26ed7efed94d2dbff591521d31076a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: multipart/alternative;
 boundary="_000_7a26ed7efed94d2dbff591521d31076aintelcom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.24; envelope-from=chen.zhang@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:16:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_7a26ed7efed94d2dbff591521d31076aintelcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Hailiang/Dave.

I found a urgent problem in current upstream code, COLO will stuck on secon=
dary checkpoint and later.
The guest will stuck by this issue.
I have bisect upstream code, this issue caused by Hailiang's optimize patch=
:

From 0393031a16735835a441b6d6e0495a1bd14adb90 Mon Sep 17 00:00:00 2001
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Mon, 24 Feb 2020 14:54:10 +0800
Subject: [PATCH] COLO: Optimize memory back-up process

This patch will reduce the downtime of VM for the initial process,
Previously, we copied all these memory in preparing stage of COLO
while we need to stop VM, which is a time-consuming process.
Here we optimize it by a trick, back-up every page while in migration
process while COLO is enabled, though it affects the speed of the
migration, but it obviously reduce the downtime of back-up all SVM'S
memory in COLO preparing stage.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Message-Id: <20200224065414.36524-5-zhang.zhanghailiang@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  minor typo fixes

Hailiang, do you have time to look into it?


The detail log:
Primary node:
13322@1589511271.917346:colo_receive_message Receive 'checkpoint-ready' mes=
sage
{"timestamp": {"seconds": 1589511271, "microseconds": 917406}, "event": "RE=
SUME"}
13322@1589511271.917842:colo_vm_state_change Change 'stop' =3D> 'run'
13322@1589511291.243346:colo_send_message Send 'checkpoint-request' message
13322@1589511291.243978:colo_receive_message Receive 'checkpoint-reply' mes=
sage
{"timestamp": {"seconds": 1589511291, "microseconds": 244096}, "event": "ST=
OP"}
13322@1589511291.244444:colo_vm_state_change Change 'run' =3D> 'stop'
13322@1589511291.244561:colo_send_message Send 'vmstate-send' message
13322@1589511291.258594:colo_send_message Send 'vmstate-size' message
13322@1589511305.412479:colo_receive_message Receive 'vmstate-received' mes=
sage
13322@1589511309.031826:colo_receive_message Receive 'vmstate-loaded' messa=
ge
{"timestamp": {"seconds": 1589511309, "microseconds": 31862}, "event": "RES=
UME"}
13322@1589511309.033075:colo_vm_state_change Change 'stop' =3D> 'run'
{"timestamp": {"seconds": 1589511311, "microseconds": 111617}, "event": "VN=
C_CONNECTED", "data": {"server": {"auth": "none", "family": "ipv4", "servic=
e": "5907", "host": "0.0.0.0", "websocket": false}, "client": {"family": "i=
pv4", "service": "51564", "host": "10.239.13.19", "websocket": false}}}
{"timestamp": {"seconds": 1589511311, "microseconds": 116197}, "event": "VN=
C_INITIALIZED", "data": {"server": {"auth": "none", "family": "ipv4", "serv=
ice": "5907", "host": "0.0.0.0", "websocket": false}, "client": {"family": =
"ipv4", "service": "51564", "host": "10.239.13.19", "websocket": false}}}
13322@1589511311.243271:colo_send_message Send 'checkpoint-request' message
13322@1589511311.351361:colo_receive_message Receive 'checkpoint-reply' mes=
sage
{"timestamp": {"seconds": 1589511311, "microseconds": 351439}, "event": "ST=
OP"}
13322@1589511311.415779:colo_vm_state_change Change 'run' =3D> 'stop'
13322@1589511311.416001:colo_send_message Send 'vmstate-send' message
13322@1589511311.418620:colo_send_message Send 'vmstate-size' message

Secondary node:
{"timestamp": {"seconds": 1589510920, "microseconds": 778207}, "event": "RE=
SUME"}
23619@1589510920.778835:colo_vm_state_change Change 'stop' =3D> 'run'
23619@1589510920.778891:colo_send_message Send 'checkpoint-ready' message
23619@1589510940.105539:colo_receive_message Receive 'checkpoint-request' m=
essage
{"timestamp": {"seconds": 1589510940, "microseconds": 105712}, "event": "ST=
OP"}
23619@1589510940.105917:colo_vm_state_change Change 'run' =3D> 'stop'
23619@1589510940.105971:colo_send_message Send 'checkpoint-reply' message
23619@1589510940.106767:colo_receive_message Receive 'vmstate-send' message
23619@1589510940.122808:colo_flush_ram_cache_begin dirty_pages 2456
23619@1589510953.618672:colo_flush_ram_cache_end
23619@1589510953.945083:colo_receive_message Receive 'vmstate-size' message
23619@1589510954.274816:colo_send_message Send 'vmstate-received' message
qemu-system-x86_64: warning: TSC frequency mismatch between VM (2792980 kHz=
) and host (2925999 kHz), and TSC scaling unavailable
{"timestamp": {"seconds": 1589510957, "microseconds": 754184}, "event": "RE=
SUME"}
23619@1589510957.894113:colo_vm_state_change Change 'stop' =3D> 'run'
23619@1589510957.894162:colo_send_message Send 'vmstate-loaded' message
23619@1589510960.105977:colo_receive_message Receive 'checkpoint-request' m=
essage
{"timestamp": {"seconds": 1589510960, "microseconds": 106148}, "event": "ST=
OP"}
23619@1589510960.213773:colo_vm_state_change Change 'run' =3D> 'stop'
23619@1589510960.213797:colo_send_message Send 'checkpoint-reply' message
23619@1589510960.278771:colo_receive_message Receive 'vmstate-send' message
23619@1589510960.423268:colo_flush_ram_cache_begin dirty_pages 25








--_000_7a26ed7efed94d2dbff591521d31076aintelcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Hailiang/Dave.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I found a urgent problem in current upstream code, C=
OLO will stuck on secondary checkpoint and later.<o:p></o:p></p>
<p class=3D"MsoNormal">The guest will stuck by this issue.<o:p></o:p></p>
<p class=3D"MsoNormal">I have bisect upstream code, this issue caused by Ha=
iliang&#8217;s optimize patch:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">From 0393031a16735835a441b6d6e0495a1bd14adb90 Mon Se=
p 17 00:00:00 2001<br>
From: zhanghailiang &lt;zhang.zhanghailiang@huawei.com&gt;<br>
Date: Mon, 24 Feb 2020 14:54:10 &#43;0800<br>
Subject: [PATCH] COLO: Optimize memory back-up process<br>
<br>
This patch will reduce the downtime of VM for the initial process,<br>
Previously, we copied all these memory in preparing stage of COLO<br>
while we need to stop VM, which is a time-consuming process.<br>
Here we optimize it by a trick, back-up every page while in migration<br>
process while COLO is enabled, though it affects the speed of the<br>
migration, but it obviously reduce the downtime of back-up all SVM'S<br>
memory in COLO preparing stage.<br>
<br>
Signed-off-by: zhanghailiang &lt;zhang.zhanghailiang@huawei.com&gt;<br>
Message-Id: &lt;20200224065414.36524-5-zhang.zhanghailiang@huawei.com&gt;<b=
r>
Signed-off-by: Dr. David Alan Gilbert &lt;dgilbert@redhat.com&gt;<br>
&nbsp; minor typo fixes<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hailiang, do you have time to look into it?<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The detail log:<o:p></o:p></p>
<p class=3D"MsoNormal">Primary node:<o:p></o:p></p>
<p class=3D"MsoNormal">13322@1589511271.917346:colo_receive_message Receive=
 'checkpoint-ready' message<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589511271, &quot;microsecond=
s&quot;: 917406}, &quot;event&quot;: &quot;RESUME&quot;}<br>
13322@1589511271.917842:colo_vm_state_change Change 'stop' =3D&gt; 'run'<br=
>
13322@1589511291.243346:colo_send_message Send 'checkpoint-request' message=
<br>
13322@1589511291.243978:colo_receive_message Receive 'checkpoint-reply' mes=
sage<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589511291, &quot;microsecond=
s&quot;: 244096}, &quot;event&quot;: &quot;STOP&quot;}<br>
13322@1589511291.244444:colo_vm_state_change Change 'run' =3D&gt; 'stop'<br=
>
13322@1589511291.244561:colo_send_message Send 'vmstate-send' message<br>
13322@1589511291.258594:colo_send_message Send 'vmstate-size' message<br>
13322@1589511305.412479:colo_receive_message Receive 'vmstate-received' mes=
sage<br>
13322@1589511309.031826:colo_receive_message Receive 'vmstate-loaded' messa=
ge<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589511309, &quot;microsecond=
s&quot;: 31862}, &quot;event&quot;: &quot;RESUME&quot;}<br>
13322@1589511309.033075:colo_vm_state_change Change 'stop' =3D&gt; 'run'<br=
>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589511311, &quot;microsecond=
s&quot;: 111617}, &quot;event&quot;: &quot;VNC_CONNECTED&quot;, &quot;data&=
quot;: {&quot;server&quot;: {&quot;auth&quot;: &quot;none&quot;, &quot;fami=
ly&quot;: &quot;ipv4&quot;, &quot;service&quot;: &quot;5907&quot;, &quot;ho=
st&quot;: &quot;0.0.0.0&quot;, &quot;websocket&quot;: false}, &quot;client&=
quot;: {&quot;family&quot;: &quot;ipv4&quot;, &quot;service&quot;: &quot;51=
564&quot;, &quot;host&quot;:
 &quot;10.239.13.19&quot;, &quot;websocket&quot;: false}}}<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589511311, &quot;microsecond=
s&quot;: 116197}, &quot;event&quot;: &quot;VNC_INITIALIZED&quot;, &quot;dat=
a&quot;: {&quot;server&quot;: {&quot;auth&quot;: &quot;none&quot;, &quot;fa=
mily&quot;: &quot;ipv4&quot;, &quot;service&quot;: &quot;5907&quot;, &quot;=
host&quot;: &quot;0.0.0.0&quot;, &quot;websocket&quot;: false}, &quot;clien=
t&quot;: {&quot;family&quot;: &quot;ipv4&quot;, &quot;service&quot;: &quot;=
51564&quot;, &quot;host&quot;:
 &quot;10.239.13.19&quot;, &quot;websocket&quot;: false}}}<br>
13322@1589511311.243271:colo_send_message Send 'checkpoint-request' message=
<br>
13322@1589511311.351361:colo_receive_message Receive 'checkpoint-reply' mes=
sage<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589511311, &quot;microsecond=
s&quot;: 351439}, &quot;event&quot;: &quot;STOP&quot;}<br>
13322@1589511311.415779:colo_vm_state_change Change 'run' =3D&gt; 'stop'<br=
>
13322@1589511311.416001:colo_send_message Send 'vmstate-send' message<br>
13322@1589511311.418620:colo_send_message Send 'vmstate-size' message<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Secondary node:<o:p></o:p></p>
<p class=3D"MsoNormal">{&quot;timestamp&quot;: {&quot;seconds&quot;: 158951=
0920, &quot;microseconds&quot;: 778207}, &quot;event&quot;: &quot;RESUME&qu=
ot;}<br>
23619@1589510920.778835:colo_vm_state_change Change 'stop' =3D&gt; 'run'<br=
>
23619@1589510920.778891:colo_send_message Send 'checkpoint-ready' message<b=
r>
23619@1589510940.105539:colo_receive_message Receive 'checkpoint-request' m=
essage<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589510940, &quot;microsecond=
s&quot;: 105712}, &quot;event&quot;: &quot;STOP&quot;}<br>
23619@1589510940.105917:colo_vm_state_change Change 'run' =3D&gt; 'stop'<br=
>
23619@1589510940.105971:colo_send_message Send 'checkpoint-reply' message<b=
r>
23619@1589510940.106767:colo_receive_message Receive 'vmstate-send' message=
<br>
23619@1589510940.122808:colo_flush_ram_cache_begin dirty_pages 2456<br>
23619@1589510953.618672:colo_flush_ram_cache_end<br>
23619@1589510953.945083:colo_receive_message Receive 'vmstate-size' message=
<br>
23619@1589510954.274816:colo_send_message Send 'vmstate-received' message<b=
r>
qemu-system-x86_64: warning: TSC frequency mismatch between VM (2792980 kHz=
) and host (2925999 kHz), and TSC scaling unavailable<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589510957, &quot;microsecond=
s&quot;: 754184}, &quot;event&quot;: &quot;RESUME&quot;}<br>
23619@1589510957.894113:colo_vm_state_change Change 'stop' =3D&gt; 'run'<br=
>
23619@1589510957.894162:colo_send_message Send 'vmstate-loaded' message<br>
23619@1589510960.105977:colo_receive_message Receive 'checkpoint-request' m=
essage<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589510960, &quot;microsecond=
s&quot;: 106148}, &quot;event&quot;: &quot;STOP&quot;}<br>
23619@1589510960.213773:colo_vm_state_change Change 'run' =3D&gt; 'stop'<br=
>
23619@1589510960.213797:colo_send_message Send 'checkpoint-reply' message<b=
r>
23619@1589510960.278771:colo_receive_message Receive 'vmstate-send' message=
<br>
23619@1589510960.423268:colo_flush_ram_cache_begin dirty_pages 25<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_7a26ed7efed94d2dbff591521d31076aintelcom_--

