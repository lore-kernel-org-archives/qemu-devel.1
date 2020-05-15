Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D38C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 03:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C486206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 03:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C486206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZR2z-0008Db-NY
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 23:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZR2D-0007OM-Dk
 for qemu-devel@nongnu.org; Thu, 14 May 2020 23:29:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2465 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZR2B-0003Ai-2u
 for qemu-devel@nongnu.org; Thu, 14 May 2020 23:29:16 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id B358D67089E0417AE9A4;
 Fri, 15 May 2020 11:29:08 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 15 May 2020 11:28:43 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 15 May 2020 11:28:43 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Fri, 15 May 2020 11:28:43 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: "Zhang, Chen" <chen.zhang@intel.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Li Zhijian
 <lizhijian@cn.fujitsu.com>
Subject: RE: About migration/colo issue
Thread-Topic: About migration/colo issue
Thread-Index: AdYqZjudkmlVb8B9TvKOADpJ4VTuWAAAYZqA
Date: Fri, 15 May 2020 03:28:43 +0000
Message-ID: <02d979c3d0004d07abed10bb6ddeba26@huawei.com>
References: <7a26ed7efed94d2dbff591521d31076a@intel.com>
In-Reply-To: <7a26ed7efed94d2dbff591521d31076a@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: multipart/alternative;
 boundary="_000_02d979c3d0004d07abed10bb6ddeba26huaweicom_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 21:45:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--_000_02d979c3d0004d07abed10bb6ddeba26huaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Zhang Chen,

From your tracing log, it seems to be hanged in colo_flush_ram_cache()?
Does it come across a dead loop there ?
I'll test it by using the new qemu.

Thanks,
Hailiang

From: Zhang, Chen [mailto:chen.zhang@intel.com]
Sent: Friday, May 15, 2020 11:16 AM
To: Zhanghailiang <zhang.zhanghailiang@huawei.com>; Dr . David Alan Gilbert=
 <dgilbert@redhat.com>; qemu-devel <qemu-devel@nongnu.org>; Li Zhijian <liz=
hijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>; Lukas Straub <lukasstraub2@web.de>
Subject: About migration/colo issue

Hi Hailiang/Dave.

I found a urgent problem in current upstream code, COLO will stuck on secon=
dary checkpoint and later.
The guest will stuck by this issue.
I have bisect upstream code, this issue caused by Hailiang's optimize patch=
:

From 0393031a16735835a441b6d6e0495a1bd14adb90 Mon Sep 17 00:00:00 2001
From: zhanghailiang <zhang.zhanghailiang@huawei.com<mailto:zhang.zhanghaili=
ang@huawei.com>>
Date: Mon, 24 Feb 2020 14:54:10 +0800
Subject: [PATCH] COLO: Optimize memory back-up process

This patch will reduce the downtime of VM for the initial process,
Previously, we copied all these memory in preparing stage of COLO
while we need to stop VM, which is a time-consuming process.
Here we optimize it by a trick, back-up every page while in migration
process while COLO is enabled, though it affects the speed of the
migration, but it obviously reduce the downtime of back-up all SVM'S
memory in COLO preparing stage.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com<mailto:zhang.z=
hanghailiang@huawei.com>>
Message-Id: <20200224065414.36524-5-zhang.zhanghailiang@huawei.com<mailto:2=
0200224065414.36524-5-zhang.zhanghailiang@huawei.com>>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com<mailto:dgilbert@=
redhat.com>>
  minor typo fixes

Hailiang, do you have time to look into it?


The detail log:
Primary node:
13322@1589511271.917346:colo_receive_message<mailto:13322@1589511271.917346=
:colo_receive_message> Receive 'checkpoint-ready' message
{"timestamp": {"seconds": 1589511271, "microseconds": 917406}, "event": "RE=
SUME"}
13322@1589511271.917842:colo_vm_state_change<mailto:13322@1589511271.917842=
:colo_vm_state_change> Change 'stop' =3D> 'run'
13322@1589511291.243346:colo_send_message<mailto:13322@1589511291.243346:co=
lo_send_message> Send 'checkpoint-request' message
13322@1589511291.243978:colo_receive_message<mailto:13322@1589511291.243978=
:colo_receive_message> Receive 'checkpoint-reply' message
{"timestamp": {"seconds": 1589511291, "microseconds": 244096}, "event": "ST=
OP"}
13322@1589511291.244444:colo_vm_state_change<mailto:13322@1589511291.244444=
:colo_vm_state_change> Change 'run' =3D> 'stop'
13322@1589511291.244561:colo_send_message<mailto:13322@1589511291.244561:co=
lo_send_message> Send 'vmstate-send' message
13322@1589511291.258594:colo_send_message<mailto:13322@1589511291.258594:co=
lo_send_message> Send 'vmstate-size' message
13322@1589511305.412479:colo_receive_message<mailto:13322@1589511305.412479=
:colo_receive_message> Receive 'vmstate-received' message
13322@1589511309.031826:colo_receive_message<mailto:13322@1589511309.031826=
:colo_receive_message> Receive 'vmstate-loaded' message
{"timestamp": {"seconds": 1589511309, "microseconds": 31862}, "event": "RES=
UME"}
13322@1589511309.033075:colo_vm_state_change<mailto:13322@1589511309.033075=
:colo_vm_state_change> Change 'stop' =3D> 'run'
{"timestamp": {"seconds": 1589511311, "microseconds": 111617}, "event": "VN=
C_CONNECTED", "data": {"server": {"auth": "none", "family": "ipv4", "servic=
e": "5907", "host": "0.0.0.0", "websocket": false}, "client": {"family": "i=
pv4", "service": "51564", "host": "10.239.13.19", "websocket": false}}}
{"timestamp": {"seconds": 1589511311, "microseconds": 116197}, "event": "VN=
C_INITIALIZED", "data": {"server": {"auth": "none", "family": "ipv4", "serv=
ice": "5907", "host": "0.0.0.0", "websocket": false}, "client": {"family": =
"ipv4", "service": "51564", "host": "10.239.13.19", "websocket": false}}}
13322@1589511311.243271:colo_send_message<mailto:13322@1589511311.243271:co=
lo_send_message> Send 'checkpoint-request' message
13322@1589511311.351361:colo_receive_message<mailto:13322@1589511311.351361=
:colo_receive_message> Receive 'checkpoint-reply' message
{"timestamp": {"seconds": 1589511311, "microseconds": 351439}, "event": "ST=
OP"}
13322@1589511311.415779:colo_vm_state_change<mailto:13322@1589511311.415779=
:colo_vm_state_change> Change 'run' =3D> 'stop'
13322@1589511311.416001:colo_send_message<mailto:13322@1589511311.416001:co=
lo_send_message> Send 'vmstate-send' message
13322@1589511311.418620:colo_send_message<mailto:13322@1589511311.418620:co=
lo_send_message> Send 'vmstate-size' message

Secondary node:
{"timestamp": {"seconds": 1589510920, "microseconds": 778207}, "event": "RE=
SUME"}
23619@1589510920.778835:colo_vm_state_change<mailto:23619@1589510920.778835=
:colo_vm_state_change> Change 'stop' =3D> 'run'
23619@1589510920.778891:colo_send_message<mailto:23619@1589510920.778891:co=
lo_send_message> Send 'checkpoint-ready' message
23619@1589510940.105539:colo_receive_message<mailto:23619@1589510940.105539=
:colo_receive_message> Receive 'checkpoint-request' message
{"timestamp": {"seconds": 1589510940, "microseconds": 105712}, "event": "ST=
OP"}
23619@1589510940.105917:colo_vm_state_change<mailto:23619@1589510940.105917=
:colo_vm_state_change> Change 'run' =3D> 'stop'
23619@1589510940.105971:colo_send_message<mailto:23619@1589510940.105971:co=
lo_send_message> Send 'checkpoint-reply' message
23619@1589510940.106767:colo_receive_message<mailto:23619@1589510940.106767=
:colo_receive_message> Receive 'vmstate-send' message
23619@1589510940.122808:colo_flush_ram_cache_begin<mailto:23619@1589510940.=
122808:colo_flush_ram_cache_begin> dirty_pages 2456
23619@1589510953.618672:colo_flush_ram_cache_end<mailto:23619@1589510953.61=
8672:colo_flush_ram_cache_end>
23619@1589510953.945083:colo_receive_message<mailto:23619@1589510953.945083=
:colo_receive_message> Receive 'vmstate-size' message
23619@1589510954.274816:colo_send_message<mailto:23619@1589510954.274816:co=
lo_send_message> Send 'vmstate-received' message
qemu-system-x86_64: warning: TSC frequency mismatch between VM (2792980 kHz=
) and host (2925999 kHz), and TSC scaling unavailable
{"timestamp": {"seconds": 1589510957, "microseconds": 754184}, "event": "RE=
SUME"}
23619@1589510957.894113:colo_vm_state_change<mailto:23619@1589510957.894113=
:colo_vm_state_change> Change 'stop' =3D> 'run'
23619@1589510957.894162:colo_send_message<mailto:23619@1589510957.894162:co=
lo_send_message> Send 'vmstate-loaded' message
23619@1589510960.105977:colo_receive_message<mailto:23619@1589510960.105977=
:colo_receive_message> Receive 'checkpoint-request' message
{"timestamp": {"seconds": 1589510960, "microseconds": 106148}, "event": "ST=
OP"}
23619@1589510960.213773:colo_vm_state_change<mailto:23619@1589510960.213773=
:colo_vm_state_change> Change 'run' =3D> 'stop'
23619@1589510960.213797:colo_send_message<mailto:23619@1589510960.213797:co=
lo_send_message> Send 'checkpoint-reply' message
23619@1589510960.278771:colo_receive_message<mailto:23619@1589510960.278771=
:colo_receive_message> Receive 'vmstate-send' message
23619@1589510960.423268:colo_flush_ram_cache_begin<mailto:23619@1589510960.=
423268:colo_flush_ram_cache_begin> dirty_pages 25








--_000_02d979c3d0004d07abed10bb6ddeba26huaweicom_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#1F497D">Hi Zhang Chen,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#1F497D">From your tracing log, it seems to be hanged in colo_flush_ram_ca=
che()?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#1F497D">Does it come across a dead loop there ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#1F497D">I&#8217;ll test it by using the new qemu.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#1F497D">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#1F497D">Hailiang<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#1F497D"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> Zhang, Chen [mailto:chen.zhang@intel.com]
<br>
<b>Sent:</b> Friday, May 15, 2020 11:16 AM<br>
<b>To:</b> Zhanghailiang &lt;zhang.zhanghailiang@huawei.com&gt;; Dr . David=
 Alan Gilbert &lt;dgilbert@redhat.com&gt;; qemu-devel &lt;qemu-devel@nongnu=
.org&gt;; Li Zhijian &lt;lizhijian@cn.fujitsu.com&gt;<br>
<b>Cc:</b> Jason Wang &lt;jasowang@redhat.com&gt;; Lukas Straub &lt;lukasst=
raub2@web.de&gt;<br>
<b>Subject:</b> About migration/colo issue<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Hailiang/Dave.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I found a urgent problem in cur=
rent upstream code, COLO will stuck on secondary checkpoint and later.<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The guest will stuck by this is=
sue.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I have bisect upstream code, th=
is issue caused by Hailiang&#8217;s optimize patch:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From 0393031a16735835a441b6d6e0=
495a1bd14adb90 Mon Sep 17 00:00:00 2001<br>
From: zhanghailiang &lt;<a href=3D"mailto:zhang.zhanghailiang@huawei.com">z=
hang.zhanghailiang@huawei.com</a>&gt;<br>
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
Signed-off-by: zhanghailiang &lt;<a href=3D"mailto:zhang.zhanghailiang@huaw=
ei.com">zhang.zhanghailiang@huawei.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20200224065414.36524-5-zhang.zhanghailian=
g@huawei.com">20200224065414.36524-5-zhang.zhanghailiang@huawei.com</a>&gt;=
<br>
Signed-off-by: Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat=
.com">dgilbert@redhat.com</a>&gt;<br>
&nbsp; minor typo fixes<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hailiang, do you have time to l=
ook into it?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The detail log:<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Primary node:<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"mailto:13322@1589511=
271.917346:colo_receive_message">13322@1589511271.917346:colo_receive_messa=
ge</a> Receive 'checkpoint-ready' message<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589511271, &quot;microsecond=
s&quot;: 917406}, &quot;event&quot;: &quot;RESUME&quot;}<br>
<a href=3D"mailto:13322@1589511271.917842:colo_vm_state_change">13322@15895=
11271.917842:colo_vm_state_change</a> Change 'stop' =3D&gt; 'run'<br>
<a href=3D"mailto:13322@1589511291.243346:colo_send_message">13322@15895112=
91.243346:colo_send_message</a> Send 'checkpoint-request' message<br>
<a href=3D"mailto:13322@1589511291.243978:colo_receive_message">13322@15895=
11291.243978:colo_receive_message</a> Receive 'checkpoint-reply' message<br=
>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589511291, &quot;microsecond=
s&quot;: 244096}, &quot;event&quot;: &quot;STOP&quot;}<br>
<a href=3D"mailto:13322@1589511291.244444:colo_vm_state_change">13322@15895=
11291.244444:colo_vm_state_change</a> Change 'run' =3D&gt; 'stop'<br>
<a href=3D"mailto:13322@1589511291.244561:colo_send_message">13322@15895112=
91.244561:colo_send_message</a> Send 'vmstate-send' message<br>
<a href=3D"mailto:13322@1589511291.258594:colo_send_message">13322@15895112=
91.258594:colo_send_message</a> Send 'vmstate-size' message<br>
<a href=3D"mailto:13322@1589511305.412479:colo_receive_message">13322@15895=
11305.412479:colo_receive_message</a> Receive 'vmstate-received' message<br=
>
<a href=3D"mailto:13322@1589511309.031826:colo_receive_message">13322@15895=
11309.031826:colo_receive_message</a> Receive 'vmstate-loaded' message<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589511309, &quot;microsecond=
s&quot;: 31862}, &quot;event&quot;: &quot;RESUME&quot;}<br>
<a href=3D"mailto:13322@1589511309.033075:colo_vm_state_change">13322@15895=
11309.033075:colo_vm_state_change</a> Change 'stop' =3D&gt; 'run'<br>
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
<a href=3D"mailto:13322@1589511311.243271:colo_send_message">13322@15895113=
11.243271:colo_send_message</a> Send 'checkpoint-request' message<br>
<a href=3D"mailto:13322@1589511311.351361:colo_receive_message">13322@15895=
11311.351361:colo_receive_message</a> Receive 'checkpoint-reply' message<br=
>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589511311, &quot;microsecond=
s&quot;: 351439}, &quot;event&quot;: &quot;STOP&quot;}<br>
<a href=3D"mailto:13322@1589511311.415779:colo_vm_state_change">13322@15895=
11311.415779:colo_vm_state_change</a> Change 'run' =3D&gt; 'stop'<br>
<a href=3D"mailto:13322@1589511311.416001:colo_send_message">13322@15895113=
11.416001:colo_send_message</a> Send 'vmstate-send' message<br>
<a href=3D"mailto:13322@1589511311.418620:colo_send_message">13322@15895113=
11.418620:colo_send_message</a> Send 'vmstate-size' message<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Secondary node:<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">{&quot;timestamp&quot;: {&quot;=
seconds&quot;: 1589510920, &quot;microseconds&quot;: 778207}, &quot;event&q=
uot;: &quot;RESUME&quot;}<br>
<a href=3D"mailto:23619@1589510920.778835:colo_vm_state_change">23619@15895=
10920.778835:colo_vm_state_change</a> Change 'stop' =3D&gt; 'run'<br>
<a href=3D"mailto:23619@1589510920.778891:colo_send_message">23619@15895109=
20.778891:colo_send_message</a> Send 'checkpoint-ready' message<br>
<a href=3D"mailto:23619@1589510940.105539:colo_receive_message">23619@15895=
10940.105539:colo_receive_message</a> Receive 'checkpoint-request' message<=
br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589510940, &quot;microsecond=
s&quot;: 105712}, &quot;event&quot;: &quot;STOP&quot;}<br>
<a href=3D"mailto:23619@1589510940.105917:colo_vm_state_change">23619@15895=
10940.105917:colo_vm_state_change</a> Change 'run' =3D&gt; 'stop'<br>
<a href=3D"mailto:23619@1589510940.105971:colo_send_message">23619@15895109=
40.105971:colo_send_message</a> Send 'checkpoint-reply' message<br>
<a href=3D"mailto:23619@1589510940.106767:colo_receive_message">23619@15895=
10940.106767:colo_receive_message</a> Receive 'vmstate-send' message<br>
<a href=3D"mailto:23619@1589510940.122808:colo_flush_ram_cache_begin">23619=
@1589510940.122808:colo_flush_ram_cache_begin</a> dirty_pages 2456<br>
<a href=3D"mailto:23619@1589510953.618672:colo_flush_ram_cache_end">23619@1=
589510953.618672:colo_flush_ram_cache_end</a><br>
<a href=3D"mailto:23619@1589510953.945083:colo_receive_message">23619@15895=
10953.945083:colo_receive_message</a> Receive 'vmstate-size' message<br>
<a href=3D"mailto:23619@1589510954.274816:colo_send_message">23619@15895109=
54.274816:colo_send_message</a> Send 'vmstate-received' message<br>
qemu-system-x86_64: warning: TSC frequency mismatch between VM (2792980 kHz=
) and host (2925999 kHz), and TSC scaling unavailable<br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589510957, &quot;microsecond=
s&quot;: 754184}, &quot;event&quot;: &quot;RESUME&quot;}<br>
<a href=3D"mailto:23619@1589510957.894113:colo_vm_state_change">23619@15895=
10957.894113:colo_vm_state_change</a> Change 'stop' =3D&gt; 'run'<br>
<a href=3D"mailto:23619@1589510957.894162:colo_send_message">23619@15895109=
57.894162:colo_send_message</a> Send 'vmstate-loaded' message<br>
<a href=3D"mailto:23619@1589510960.105977:colo_receive_message">23619@15895=
10960.105977:colo_receive_message</a> Receive 'checkpoint-request' message<=
br>
{&quot;timestamp&quot;: {&quot;seconds&quot;: 1589510960, &quot;microsecond=
s&quot;: 106148}, &quot;event&quot;: &quot;STOP&quot;}<br>
<a href=3D"mailto:23619@1589510960.213773:colo_vm_state_change">23619@15895=
10960.213773:colo_vm_state_change</a> Change 'run' =3D&gt; 'stop'<br>
<a href=3D"mailto:23619@1589510960.213797:colo_send_message">23619@15895109=
60.213797:colo_send_message</a> Send 'checkpoint-reply' message<br>
<a href=3D"mailto:23619@1589510960.278771:colo_receive_message">23619@15895=
10960.278771:colo_receive_message</a> Receive 'vmstate-send' message<br>
<a href=3D"mailto:23619@1589510960.423268:colo_flush_ram_cache_begin">23619=
@1589510960.423268:colo_flush_ram_cache_begin</a> dirty_pages 25<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_02d979c3d0004d07abed10bb6ddeba26huaweicom_--

