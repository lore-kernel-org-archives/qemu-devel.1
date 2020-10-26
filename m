Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17459C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 03:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7156F20795
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 03:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7156F20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWtT3-0000ai-53
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 23:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d0u9.su@outlook.com>)
 id 1kWtRt-0008UH-37
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 23:45:33 -0400
Received: from mail-dm6nam10olkn2015.outbound.protection.outlook.com
 ([40.92.41.15]:56192 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d0u9.su@outlook.com>)
 id 1kWtRo-0000g8-Tb
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 23:45:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DN8ruHKU/7relBp6R5TPVy/DKusD/Jk1AdHG24YzlkaUYV7RvbA7h7vZs0lY4yzuiNr5M/7CrECFND8mh58JW/gR5Bz0PcLHDpQM2qzi23NCK5kRROfhlxQoEHN4lys0Y4j/dYvYKp3LLWfjRy875OdKz+vLG2APsYb03k/PfweofZ8e5UGQHzwbM3KsLpPsxGEAADDyQEAbqChuOB5HOmq/cIgsphHmTE+GOgXg9Bue+k98dwLwUi1XVM+Kh/SgCFKdBqF/mUz1mcSgjSAaZg8iOLlfjK//Anu3Q7Be8CLEvbty4wE+Sn13K0erMdW5wpXf1HNtNeI4JHwcaF8CGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I11XJRBM86SYETDCRXEURUOFdbi5mffgxzLHsLX7MwA=;
 b=Qyu6X1tsWmr8IUrqq09JfWm/DQszJMD/Fhf2wSgW8WYoWFu3U57l7IvovVuCWiNZnpQpD4msetFdfrXHOaAqmxqRePeHB7xI08hY5JQSLCnFTYR4V2FtOwbIz1SMaeVVGWYyBkdp8e/NiomxIT20q6NOYSD5JxgKxUY11CwLTs+N7mqCLtBTntTYH+HTyuzZb3FtfeuIVzE6FVzka7a6hAq5m/r7YtrEMTpPmXvb4R/XKfkrw7+9uF62dcobfNnhPVkGJ5dV3TVD4OM8/QmvvGhRtk/PT5RO1SRy84mYHLURMRY1lG1Kgik+TAP+8DH4Gobg0gAHhl8pchaIMa7nFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I11XJRBM86SYETDCRXEURUOFdbi5mffgxzLHsLX7MwA=;
 b=QhQdofmL9VZrWFaaIydI5xFgk3Rr+k2ldNDFGxlutKL5g66iqq9yq4oKB+fI4Z7cJaKfDMfrwSCTPXXWrVFalkbPYAPrnbZHBHonkJJ+TGPeG3LtKkr2axreykBORhMhjv4rj2c87UxRLyaM3815OYDiGcXGbDSodst1VXMawVJr/x3VTZFeBl1upfNgIryB/Zg5KJfqs8iNkZwEO2fioZlD3K4KqQ455olhFnOxKrQVtF3DOtdN+LW7vlbxwDvnHM8sI94IMArriR6xW6mLBA4U6rGmXFocPgJ/vHy9Ad6+9mZXB2UAe/Utf1hgufutOtXoFpQ2chmv8JY+O8n6XQ==
Received: from BN7NAM10FT050.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e8f::4a) by
 BN7NAM10HT063.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e8f::314)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 03:30:22 +0000
Received: from BYAPR11MB2664.namprd11.prod.outlook.com
 (2a01:111:e400:7e8f::4e) by BN7NAM10FT050.mail.protection.outlook.com
 (2a01:111:e400:7e8f::284) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 03:30:22 +0000
Received: from BYAPR11MB2664.namprd11.prod.outlook.com
 ([fe80::2164:d6ba:9ca3:3090]) by BYAPR11MB2664.namprd11.prod.outlook.com
 ([fe80::2164:d6ba:9ca3:3090%4]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 03:30:22 +0000
From: Douglas Su <d0u9.su@outlook.com>
To: QEMU Developers <qemu-devel@nongnu.org>
CC: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: Enable MSI-X support in PCIe device.
Thread-Topic: Enable MSI-X support in PCIe device.
Thread-Index: AQHWqOtsbiQu9ZKUjUCwfcsDfQs236mpPo8u
Date: Mon, 26 Oct 2020 03:30:21 +0000
Message-ID: <BYAPR11MB266438F1968B1180660D2868EC190@BYAPR11MB2664.namprd11.prod.outlook.com>
References: <BYAPR11MB26641AF7375C0C2A2652D8C8EC1A0@BYAPR11MB2664.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB26641AF7375C0C2A2652D8C8EC1A0@BYAPR11MB2664.namprd11.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:86C5DB9150A5F5847024742410CA7BDD6D95FB35F6DF4A96AEFD67E37D515182;
 UpperCasedChecksum:1317F7200F152DF3DD4B6CEB96AAD00103CBD30EEC5F0358B33EA122D8872FAC;
 SizeAsReceived:6886; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [RUxP1MQrXWe7OtaBMaXg0P+USl7I6+tp]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 1613f60b-922a-49d8-f12e-08d8795f7858
x-ms-traffictypediagnostic: BN7NAM10HT063:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qnET0GbJgYnnUKjLdVkAQTJxnloqh4i6hub/7sJLP2VhzgC0t2CVjVTut4XL0WHFE3POo2IY1mttV6loZVwti840ElswHN8K2FuTLYz/YEDGdCLQAkch8viaEXEUn+FntG6moadXsv9iJPTR9bMJbe5o7wvszB5bx8h5oCUJ4wfgr7+RtCmQUT3HA1C1AkJgJRrlk5VewE/twXyF9RoVg==
x-ms-exchange-antispam-messagedata: 8AKNZ//fwgHSyJrMx7mxPk6gItNrdqPSjJ+HNVUUOGSbBzrxXefUswQdxBGzMQskys4E2cHjiXvX7KxUUsa0JQiS9UKKt1tyAQ37C0kSrOxAh06fy57ZPvpfz23miTstf5suTQTQ6zAqwm7BATYqBA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BYAPR11MB266438F1968B1180660D2868EC190BYAPR11MB2664namp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT050.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1613f60b-922a-49d8-f12e-08d8795f7858
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 03:30:21.9994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7NAM10HT063
Received-SPF: pass client-ip=40.92.41.15; envelope-from=d0u9.su@outlook.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 23:45:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BYAPR11MB266438F1968B1180660D2868EC190BYAPR11MB2664namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have tried to use msi only, but failed again. Is there and documentation =
details this?

________________________________
From: Qemu-devel <qemu-devel-bounces+d0u9.su=3Doutlook.com@nongnu.org> on b=
ehalf of Douglas Su <d0u9.su@outlook.com>
Sent: Thursday, October 22, 2020 20:32
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: Enable MSI-X support in PCIe device.

To use MSI-X interrupt in my PCIe device, In realize() function I make a MS=
IX initialization like this:

#define MYDEV_MSIX_VEC_NUM 5

void realize() {
    memory_region_init(&mydev->msix, OBJECT(edu), "mydev-msix",
                       MYDEV_MSIX_SIZE);
    pci_register_bar(pdev, MYDEV_MSIX_IDX,
                     PCI_BASE_ADDRESS_SPACE_MEMORY, &mydev->msix);

    rv =3D msix_init(pdev, MYDEV_MSIX_VEC_NUM,
                   &edu->msix, MYDEV_MSIX_IDX, MYDEV_MSIX_TABLE,
                   &edu->msix, MYDEV_MSIX_IDX, MYDEV_MSIX_PBA,
                   0, errp);
}

After this, a simple logic is added  to trigger interrupt by writing comman=
d to a specific BAR0 address.

void trigger() {
    msix_notify(pdev, 1);         // send vector 1 to msix
}

In the OS driver, MSIX is enabled via `pci_alloc_irq_vectors()`, which is d=
etailed in Linux Kernel's documentation `Documentation/PCI/msi-howto.rst` (=
I use kernel 5.7).

It is correct to obtain the number of vector from that function but failed =
to receive interrupt from device. The IRQ, which is returned from `pci_irq_=
vector`, is registered via `request_irq()` in the deriver.

Can anyone give a clue?


--_000_BYAPR11MB266438F1968B1180660D2868EC190BYAPR11MB2664namp_
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
I have tried to use msi only, but failed again. Is there and documentation =
details this?</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Qemu-devel &lt;qemu-d=
evel-bounces+d0u9.su=3Doutlook.com@nongnu.org&gt; on behalf of Douglas Su &=
lt;d0u9.su@outlook.com&gt;<br>
<b>Sent:</b> Thursday, October 22, 2020 20:32<br>
<b>To:</b> QEMU Developers &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> Enable MSI-X support in PCIe device.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">To use MSI-X interrupt in my PCIe device, In reali=
ze() function I make a MSIX initialization like this:<br>
<br>
#define MYDEV_MSIX_VEC_NUM 5<br>
<br>
void realize() {<br>
&nbsp;&nbsp;&nbsp; memory_region_init(&amp;mydev-&gt;msix, OBJECT(edu), &qu=
ot;mydev-msix&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MYDEV_MSIX_SIZE);=
<br>
&nbsp;&nbsp;&nbsp; pci_register_bar(pdev, MYDEV_MSIX_IDX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI_BASE_ADDRESS_SPACE_MEMORY=
, &amp;mydev-&gt;msix);<br>
<br>
&nbsp;&nbsp;&nbsp; rv =3D msix_init(pdev, MYDEV_MSIX_VEC_NUM,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;edu-&gt;msix, MYDEV_MSIX_IDX, MYDEV_=
MSIX_TABLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;edu-&gt;msix, MYDEV_MSIX_IDX, MYDEV_=
MSIX_PBA,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, errp);<br>
}<br>
<br>
After this, a simple logic is added&nbsp; to trigger interrupt by writing c=
ommand to a specific BAR0 address.<br>
<br>
void trigger() {<br>
&nbsp;&nbsp;&nbsp; msix_notify(pdev, 1);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; // send vector 1 to msix<br>
}<br>
<br>
In the OS driver, MSIX is enabled via `pci_alloc_irq_vectors()`, which is d=
etailed in Linux Kernel's documentation `Documentation/PCI/msi-howto.rst` (=
I use kernel 5.7).<br>
<br>
It is correct to obtain the number of vector from that function but failed =
to receive interrupt from device. The IRQ, which is returned from `pci_irq_=
vector`, is registered via `request_irq()` in the deriver.<br>
<br>
Can anyone give a clue?<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR11MB266438F1968B1180660D2868EC190BYAPR11MB2664namp_--

