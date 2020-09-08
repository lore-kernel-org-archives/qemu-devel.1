Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1B4C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFB1206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Nex8/tMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFB1206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbvQ-00070o-A1
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kFbuj-000682-FW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:35:53 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com
 ([40.107.92.68]:26977 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kFbug-0000zs-QT
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:35:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud/TRYLRJsRxR4/8adr8gjJJ3noCOkuiSL9uietHh1RMix2nI9K/I92EmYAv1qbQprvHmXqUQ2iWnzcRTFkkrdvaOOfB3OThR+pRoWWAEBgxwXxGCJuiIPa4iy0kubyDI+c5CnjTB24BVAK6V6yYg3MqAJIfjm0uZkR0C0aMKliLjlhQZdBlo+4Oog2sRKJxaYm4mqe1WiQarGTXDw4DCykAiJS6eIwK+/T1vhMviAGhLXWNwpqHltrikQtd1HvIyyMzC2K0yWRJrdvEuMYU2tozOmOp90YJx6ajIA0/qUGEUJV0OfCXbTrWrpSI+Ey5ooxu5tB36Iu/mLuFDtGFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A++uFN8vQe3MQn6ywX3GqoN6PyN/rM99WGK5s2dnOE=;
 b=YobjtLLj64Wc93LiK0lDhj7n8WpJSy4tIgd1sFKlKRwaVoo+BQTjaaSHayui8hz/Az1am3kH/KT+mlWDvnArp1Xetg531cVaNgJrYLdYoU4n4XHPod+Q0PNL61GpIMYEPPO0oNjm56EH0qEo172jaEpuqEtMV4K8ZQ45YJuKCBTfQ4eO9mF4GZzz/PU3A8bhrkknfmXT/z/EpDa/RY0Kwx60S5puHGYZGz8OeBqqbVsx+IstiOTdZEAFRm6+BfYIOGo41x0s+nh9QlAaNIWhyMzkrPLnxojiooa+xFOwEriQM9D5Vr+PT+MXqs3MLfv3h1jHr0U/d1nCt7Ir6mktrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A++uFN8vQe3MQn6ywX3GqoN6PyN/rM99WGK5s2dnOE=;
 b=Nex8/tMqIY9TXlMZy564cmdWy1G+P6Nc8v128bcTb7YFzR7Fs6GhZGjzEJLJhl4wusjeRyeWV4wLZFZ+K46zniP9qJd1h5eIPL0tJAhNhFCZH71jMOxaBnlDiJ5o0QDlgskdbZ8ieUVFxSbrL5xPPflWDpGjsAY4w9ruQUOQaqo=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5975.namprd02.prod.outlook.com (2603:10b6:a03:118::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 11:35:48 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 11:35:48 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?J01hcmMtQW5kcsOpIEx1cmVhdSc=?= <marcandre.lureau@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Edgar
 Iglesias <edgari@xilinx.com>, Francisco Eduardo Iglesias
 <figlesia@xilinx.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [PATCH v4 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
Thread-Topic: [PATCH v4 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
Thread-Index: AQHWfW+Ua1yvfd0S/EK+NcJs9pMBDKlUAL+AgAqNz+CAAAypgIAAAVCAgAAQfFA=
Date: Tue, 8 Sep 2020 11:35:47 +0000
Message-ID: <BY5PR02MB67724F130F0AF42FB0689148CA290@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <cefca93c-37d5-63b7-aff3-e6966d771892@redhat.com>
 <BY5PR02MB6772B6F211489F7E2A9D5CCDCA290@BY5PR02MB6772.namprd02.prod.outlook.com>
 <2330f661-2ef0-cfb5-4a05-8a2d43ab53e4@redhat.com>
 <79ff4a95-d276-6681-6a06-9b8dc66de93f@redhat.com>
In-Reply-To: <79ff4a95-d276-6681-6a06-9b8dc66de93f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [49.205.235.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 566eb650-08a9-417a-77c2-08d853eb551f
x-ms-traffictypediagnostic: BYAPR02MB5975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5975E4ACC5EF395E49D72650CA290@BYAPR02MB5975.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sk5YbHF22BCk7YIIg5iUQsjiWfBHxRfqkzbSCZxnZAIvIGRhvPtEgYjrtPAPJyQkNQSRCxs9PvfHv+3hZeVaF7+CrTCLmQn5oueTOPaTU3VYV6ndUkDZe2saIks9B1NkUgqVoc7x7ybr+w9oJsFzr0JMDNCMByEYodnfusZ6rqXXI4qaB06lURd3lZyTUxHq5DhefqdnhY5rW6HNirk+a9cQcEJ6dy65b49sLJCpb/jhk//WzFt+DFmWTL9RH9o8YzUR6Ce+0MUBGO4y69QhljGN3CU52aJuMEmNU5p7TQRq4l6w8uOUKKP+iQ/CM8KrpzsZfxFEEHWzhERRolvHYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(5660300002)(186003)(26005)(8676002)(86362001)(8936002)(66556008)(7696005)(6506007)(66946007)(83380400001)(478600001)(66476007)(33656002)(71200400001)(53546011)(4326008)(7416002)(52536014)(316002)(76116006)(66446008)(64756008)(110136005)(2906002)(9686003)(55016002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BC7kfOtWSsWmgl8m7mLXw8Eg+8vs23lKYE99Nembdr6Nm4uh5LPO7OdQ2t7LMBjC7/EsOfN05+m+7LWTUr59l/8gD0GPUUiO5Aa9sClS2MejuiYvEUALkBuJZaBfJ7N3h126BqktU5KwX9mCcJVi7s467dx8nTZliEYDNaIkMK5H5K7NbihALjDF4zG4WTAy3pNJu5GkRn87wbkYme6YqsCR5gqJTJbiJCujfSbeaPzSxleSMOG7LgSUeOJMLxw0YGvDV+aREcTcaFjrYCa/5W213osEgDvOZERluBWLGKk42cITK4lqM0UZU5xLVZylBJRjMo/BjI7BIWZQy6ZjFD+8xWRUN+99CEP3G/OfZR7yhSfNGy8/EzOlSfWTUkFwy/lit3ewtis8FZHu67fLLgrUNuRTx+9it1gGKZmb1cJ0nuJ16lDL8HPswQJ4IAcicFHUbSE/sdfn4NyxGB7aHeHSbqkovlw3TWOiOu3Dv9egf5itcUJL8BnGwSwxIwHhXgUU02BPhkdkCdBw8LZXj0qdho1V4EKaF9ZeONpLH1TLRj7XgkKgYPicL9QTF8SBPgkaA6NkREFJ3agahwnaHZuhwBkIAR9Pu49nVqnaFfiuikcSNLa3MrqUbVaZC1DTTBsajrWE7OB/XRaxb/F4Ow==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566eb650-08a9-417a-77c2-08d853eb551f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 11:35:48.2350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //T0WeQupuVhQyfO0CuPzkGt1bQ4Prcl64ihJo0kef8UlZVYIVT4lj5owkecPefssxGPiCS+EuYE2Nt8mEx74A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5975
Received-SPF: pass client-ip=40.107.92.68; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 07:35:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGhpbGlwcGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBTZXB0ZW1iZXIgOCwgMjAyMCA0OjA1IFBNDQo+IFRvOiBTYWkgUGF2YW4gQm9kZHUgPHNhaXBh
dmFAeGlsaW54LmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz47IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT47DQo+ICdNYXJjLUFuZHLD
qSBMdXJlYXUnIDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pDQo+
IDxwYm9uemluaUByZWRoYXQuY29tPjsgR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+
OyBFZGdhcg0KPiBJZ2xlc2lhcyA8ZWRnYXJpQHhpbGlueC5jb20+OyBGcmFuY2lzY28gRWR1YXJk
byBJZ2xlc2lhcw0KPiA8ZmlnbGVzaWFAeGlsaW54LmNvbT47IERhdmlkIEdpYnNvbiA8ZGF2aWRA
Z2lic29uLmRyb3BiZWFyLmlkLmF1Pg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBBbGlz
dGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+Ow0KPiBFZHVhcmRvIEhhYmtv
c3QgPGVoYWJrb3N0QHJlZGhhdC5jb20+OyBZaW5nIEZhbmcNCj4gPGZhbmd5aW5nMUBodWF3ZWku
Y29tPjsgVmlrcmFtIEdhcmh3YWwgPGZudXZAeGlsaW54LmNvbT47IFBhdWwNCj4gWmltbWVybWFu
IDxwYXVsZHppbUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS83XSB1c2Iv
aGNkLXhoY2k6IE1ha2UgZG1hIHJlYWQvd3JpdGVzIGhvb2tzIHBjaQ0KPiBmcmVlDQo+IA0KPiBP
biA5LzgvMjAgMTI6MzAgUE0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiA+Pj4g
T24gOC8yOC8yMCA5OjE5IFBNLCBTYWkgUGF2YW4gQm9kZHUgd3JvdGU6DQo+ID4+Pj4gVGhpcyBw
YXRjaCBzdGFydHMgbWFraW5nIHRoZSBoY2QteGhjaS5jIHBjaSBmcmVlLCBhcyBwYXJ0IG9mIHRo
aXMNCj4gPj4+PiByZXN0cnVjdHVyaW5nIGRtYSByZWFkL3dyaXRlcyBhcmUgaGFuZGxlZCB3aXRo
b3V0IHBhc3NpbmcgcGNpIG9iamVjdC4NCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IFNh
aSBQYXZhbiBCb2RkdSA8c2FpLnBhdmFuLmJvZGR1QHhpbGlueC5jb20+DQo+ID4+Pj4gLS0tDQo+
ID4+Pj4gIGh3L3VzYi9oY2QteGhjaS5jIHwgMjQgKysrKysrKysrKystLS0tLS0tLS0tLS0tICBo
dy91c2IvaGNkLXhoY2kuaA0KPiA+Pj4+IHwNCj4gPj4+PiAzICsrKw0KPiA+Pj4+ICAyIGZpbGVz
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+Pj4+DQo+ID4g
Wy4uLl0NCj4gPj4+PiAtLS0gYS9ody91c2IvaGNkLXhoY2kuaA0KPiA+Pj4+ICsrKyBiL2h3L3Vz
Yi9oY2QteGhjaS5oDQo+ID4+Pj4gQEAgLTIyLDYgKzIyLDggQEANCj4gPj4+PiAgI2lmbmRlZiBI
V19VU0JfSENEX1hIQ0lfSA0KPiA+Pj4+ICAjZGVmaW5lIEhXX1VTQl9IQ0RfWEhDSV9IDQo+ID4+
Pj4NCj4gPj4+PiArI2luY2x1ZGUgInN5c2VtdS9kbWEuaCINCj4gPj4+DQo+ID4+PiBBZGRyZXNz
U3BhY2UgaXMgZm9yd2FyZC1kZWNsYXJlZCBpbiAicWVtdS90eXBlZGVmcy5oIiwgc28gbm8gbmVl
ZCB0bw0KPiA+Pj4gaW5jbHVkZSBpdCBoZXJlICh5ZXMgaW4gdGhlIHNvdXJjZXMgaW5jbHVkaW5n
IGhjZC14aGNpLmgpLg0KPiA+PiBbU2FpIFBhdmFuIEJvZGR1XSBZZXMgeW91IGFyZSByaWdodCEs
IGJ1dCB3aXRob3V0IHRoaXMgIiBkbWFfYWRkcl90ICIgaXMNCj4gdW5kZWZpbmVkLg0KPiA+PiBB
dCB0aGlzIHBvaW50IG9mIHRoZSBwYXRjaCwgaGNkLXhoY2kuaCBpcyBjb21waWxlZCBhbG9uZyB3
aXRoIHBjaS5oIHdoaWNoDQo+IHdvdWxkIHByb3ZpZGUgJ2RtYV9hZGRyX3QnLCBidXQgd2hlbiB3
ZSBzdHJpcCB0aGUgcGNpIHdyYXBwZXIgYXJvdW5kIGhjZC0NCj4geGhjaSB3ZSB3b3VsZCBtaXNz
IGl0LiBMZXQgbWUga25vdywgaWYgaXRzIGdvb2QgdG8gYWRkIGxhdGVyIGluIHRoZSBwYXRjaCBz
ZXJpZXMNCj4gd2hlbiB0aGUgc3BsaXQgaGFwcGVucy4NCj4gPg0KPiA+IE9LIDooIEknZCBwcmVm
ZXIgdG8gb25seSBpbmNsdWRlICJzeXNlbXUvZG1hLmgiIGluIGh3L3VzYi9oY2QteGhjaS5jLg0K
PiA+DQo+ID4gQ2MnaW5nIERhdmlkIHdobyBhZGRlZCBkbWFfYWRkcl90IGluIGNvbW1pdCBlNTMz
MmU2MzM0Zg0KPiA+ICgiaW9tbXU6IEludHJvZHVjZSBJT01NVSBlbXVsYXRpb24gaW5mcmFzdHJ1
Y3R1cmUiKSwgaXQgbWlnaHQgYmUNCj4gPiBzaW1wbGVyIHRvIG1vdmUgaXRzIGRlY2xhcmF0aW9u
IHRvICJxZW11L3R5cGVkZWZzLmgiDQo+ID4gdG9vLg0KPiANCj4gQnR3IHRoaXMgdHlwZSBzaG91
bGQgYmUgcG9pc29uZWQgZm9yIHVzZXItbW9kZS4NCltTYWkgUGF2YW4gQm9kZHVdIFRoYW5rcywg
SSB3b3VsZCB0cnkgdG8gZGVmaW5lIHRoZW0gaW4gdHlwZWRlZnMuaC4gDQpCVFcgSSdtIG5vdCBj
bGVhciBhYm91dCBwb2lzb25pbmcgdGhlbiBpbiB1c2VyLW1vZGUuIERvIHlvdSBtZWFuIGhpZGUg
dGhlc2UgZGVmaW5lcyBmb3IgdXNlci1tb2RlID8NCg0KUmVnYXJkcw0KU2FpIFBhdmFuDQo+IA0K
PiA+DQo+ID4gU28gbm8gY2hhbmdlIG5lZWRlZCBmb3IgdGhpcyBwYXRjaC4NCj4gPg0KPiA+Pg0K
PiA+PiBSZWdhcmRzLA0KPiA+PiBTYWkgUGF2YW4NCj4gPj4+DQo+ID4+PiBXaXRoIHRoYXQgZml4
ZWQ6DQo+ID4+PiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBy
ZWRoYXQuY29tPg0KPiA+Pj4NCj4gPj4+PiArDQo+ID4+Pj4gICNkZWZpbmUgVFlQRV9YSENJICJi
YXNlLXhoY2kiDQo+ID4+Pj4gICNkZWZpbmUgVFlQRV9ORUNfWEhDSSAibmVjLXVzYi14aGNpIg0K
PiA+Pj4+ICAjZGVmaW5lIFRZUEVfUUVNVV9YSENJICJxZW11LXhoY2kiDQo+ID4+Pj4gQEAgLTE4
OSw2ICsxOTEsNyBAQCBzdHJ1Y3QgWEhDSVN0YXRlIHsNCj4gPj4+Pg0KPiA+Pj4+ICAgICAgVVNC
QnVzIGJ1czsNCj4gPj4+PiAgICAgIE1lbW9yeVJlZ2lvbiBtZW07DQo+ID4+Pj4gKyAgICBBZGRy
ZXNzU3BhY2UgKmFzOw0KPiA+Pj4+ICAgICAgTWVtb3J5UmVnaW9uIG1lbV9jYXA7DQo+ID4+Pj4g
ICAgICBNZW1vcnlSZWdpb24gbWVtX29wZXI7DQo+ID4+Pj4gICAgICBNZW1vcnlSZWdpb24gbWVt
X3J1bnRpbWU7DQo+ID4+Pj4NCj4gPj4NCj4gPg0KDQo=

