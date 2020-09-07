Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709EEC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D6820678
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D6820678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFIrY-000407-MW
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ligang6@huawei.com>)
 id 1kFHlA-0003Cs-4G
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:04:40 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:43572 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ligang6@huawei.com>)
 id 1kFHl6-00047A-Ku
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:04:39 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id E2C1A918B914A4AD88C4;
 Mon,  7 Sep 2020 22:04:20 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 7 Sep 2020 22:04:20 +0800
Received: from dggeme758-chm.china.huawei.com ([10.6.80.69]) by
 dggeme758-chm.china.huawei.com ([10.6.80.69]) with mapi id 15.01.1913.007;
 Mon, 7 Sep 2020 22:04:20 +0800
From: "ligang (P)" <ligang6@huawei.com>
To: "kvm@veger.kernel.org" <kvm@veger.kernel.org>, "libvir-list@redhat.com"
 <libvir-list@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: watchdog fed successfully event of 6300esb
Thread-Topic: watchdog fed successfully event of 6300esb
Thread-Index: AdaFH7BNpUzBhBuURViHR9x8GKhq/w==
Date: Mon, 7 Sep 2020 14:04:20 +0000
Message-ID: <624825e298f94650a7b69f483c9de84d@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.182.123.125]
Content-Type: multipart/alternative;
 boundary="_000_624825e298f94650a7b69f483c9de84dhuaweicom_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255; envelope-from=ligang6@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 10:04:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Sep 2020 11:14:03 -0400
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
Cc: "openstack-discuss@lists.openstack.org"
 <openstack-discuss@lists.openstack.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_624825e298f94650a7b69f483c9de84dhuaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi folks,

I have an question to discuss about the 6300esb watchdog.

I think is it possible that qemu can send an event while the watchdog succe=
ssfully fed by the vm at the first time.

Here is the situation:

Qemu will send an VIR_DOMAIN_EVENT_ID_WATCHDOG event while watch dog timeou=
t, and if the action of the watchdog in xml of the vm was set to "reset", t=
he vm will be rebooted while timeout.

I have an monitor process that register callback function of the VIR_DOMAIN=
_EVENT_ID_WATCHDOG event, the callback function will send an alarm to my up=
per layer monitor platform indicate that the vm is fault, and the cluster d=
eployed business on the vm will isolate the vm by the alarm.

And after the vm rebooted , the monitor process will receive an reboot even=
t and send it to the platform, the upper layer monitor platform will clear =
the alarm, and business continue to run on the vm.

In most cases ,the watch dog process in vm will feed the watchdog after vm =
rebooted and all things go back on track.

In some other cases,the guestos may failed to start (in my environment vm s=
tart failed by io error), but the reboot event will still be received and t=
he alarm will be cleared and the vm is still fault. So the this may not a g=
ood idea to clear the alarm by the reboot event.

So, I think it will be helpful that the qemu can send an event while the wa=
tchdog successfully fed by the vm at the first time. So I can exactly know =
that the guest os go back on running and the watch dog initialized successf=
ully.

Or any other opintion about this situation.

Thanks.


--_000_624825e298f94650a7b69f483c9de84dhuaweicom_
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
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
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
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi folks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I have an question to discuss a=
bout the 6300esb watchdog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I think is it possible that qem=
u can send an event while the watchdog successfully fed by the vm at the fi=
rst time.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Here is the situation:<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Qemu will send an VIR_DOMAIN_EV=
ENT_ID_WATCHDOG event while watch dog timeout, and if the action of the wat=
chdog in xml of the vm was set to &#8220;reset&#8221;, the vm will be reboo=
ted while timeout.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I have an monitor process that =
register callback function of the VIR_DOMAIN_EVENT_ID_WATCHDOG event, the c=
allback function will send an alarm to my upper layer monitor platform indi=
cate that the vm is fault, and the cluster
 deployed business on the vm will isolate the vm by the alarm. <o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">And after the vm rebooted , the=
 monitor process will receive an reboot event and send it to the platform, =
the upper layer monitor platform will clear the alarm, and business continu=
e to run on the vm.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">In most cases ,the watch dog pr=
ocess in vm will feed the watchdog after vm rebooted and all things go back=
 on track.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">In some other cases,the guestos=
 may failed to start (in my environment vm start failed by io error), but t=
he reboot event will still be received and the alarm will be cleared and th=
e vm is still fault. So the this may
 not a good idea to clear the alarm by the reboot event.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">So, I think it will be helpful =
that the qemu can send an event while the watchdog successfully fed by the =
vm at the first time. So I can exactly know that the guest os go back on ru=
nning and the watch dog initialized
 successfully.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Or any other opintion about thi=
s situation.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_624825e298f94650a7b69f483c9de84dhuaweicom_--

