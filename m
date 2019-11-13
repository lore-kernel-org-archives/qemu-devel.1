Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DDEC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4A920637
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JVcJdcec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4A920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUw37-0001ZI-7N
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 12:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1iUvzu-0007UK-IR
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:00:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1iUvzs-0005hL-QH
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:00:01 -0500
Received: from mail-eopbgr720122.outbound.protection.outlook.com
 ([40.107.72.122]:50176 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1iUvzs-0005g4-Co
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:00:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIudF/JomIVHN79opi3S6yiSzubOFEeazXrZ9W7ZOCwpIapRmJppIB6qNU7tPWto51P0bkQISXixDYjtdNJL+5gloH9B4qHrJkM6uKpzO/8Mpw6xtdf1fhNd+hnuamJ9ZMavHQu8GduALOZATpitdLcVMQCfLe593J1DKPYZwbxcNPTZWvDlbvuxRk2p47JpS1zs4TQigL6OXvchlwpKX7KoBgDD3hsa1A8KeLKQBLNhYg4nw8Ojj3BS0hKk4H/aalaKEJSt13UHvz4NJkLrQBjTRQxsjVq91t6tjzmhmijhj6Ckv0/8UrAZolUCBXyJDJY+GB6ylFnct776TN8s6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pxY3cxj2poMSKPCYPSQYTcma66601xCu0u7CdhStB4=;
 b=T+uZZDaBLQv8PgEq0sYkn2ewoiALw1a5UdgU+bPvJ0Co6krOFfLOKesg7Ya2MTbXKoPk2KF8QPPEUOnCmXHDmKYJdVc0cLuIGm0TM6sNoMr1a4bJ8bf7VZTfPxim/JhliKleO33d2dZitgl7WGoqyumrHWzXlUUFYLt0IEvadDES3oc4k/CJHZ6uJe08W40ZPn3JGYatoAQYXa82f96VglHjDUVFdXBgbf3e2NRcNsyvrTTfcIXddn6vylRtAAgn+wiQ5k4GAOPP38UvA/X4zK8mI7A3F0kJa8xjrjlSS/eKgSkgrCbfORKWSXqcHUouuLg3brcxcnvkcOxwJ1SWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pxY3cxj2poMSKPCYPSQYTcma66601xCu0u7CdhStB4=;
 b=JVcJdcecG/TPsY6DPGWnWzyHJP1nUeuOaLSg5K4ukvQsfGoiLeWJwCFiUkdgTNkhVeVli6rKKNhBGouKSmkytb7Bb8iqWeol9l+7GWRqhxDG0lgMp3EUbh+8BLLnO8mpQVfb9GgC6IyjsSTI6F879Fo08RzXjnUcNrDdZHUjOPM=
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.15; Wed, 13 Nov 2019 16:59:58 +0000
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9]) by MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9%6]) with mapi id 15.20.2474.008; Wed, 13 Nov 2019
 16:59:58 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Justin Terry (VM)"
 <juterry@microsoft.com>
Subject: RE: [PATCH] WHPX: refactor load library
Thread-Topic: [PATCH] WHPX: refactor load library
Thread-Index: AdWWczxfa/0gc1vPTEu6TOvflPR6ngDv8S+AAAQhWbA=
Date: Wed, 13 Nov 2019 16:59:57 +0000
Message-ID: <MW2PR2101MB11168A4B7D850F92B88C354BC0760@MW2PR2101MB1116.namprd21.prod.outlook.com>
References: <MW2PR2101MB1116386CFE4628B6767D6CDBC07B0@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <4d20ec63-7eae-7c7f-167b-f87709adcd78@redhat.com>
In-Reply-To: <4d20ec63-7eae-7c7f-167b-f87709adcd78@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:8:1cef:6b41:87e5:6afe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af66bf8a-1091-4e0e-1e01-08d7685aea4a
x-ms-traffictypediagnostic: MW2PR2101MB1129:|MW2PR2101MB1129:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB11294B5F557E12BB48DB6E7AC0760@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(13464003)(66946007)(74316002)(478600001)(66556008)(66476007)(76116006)(64756008)(55016002)(9686003)(486006)(107886003)(4326008)(6246003)(6116002)(8990500004)(110136005)(54906003)(22452003)(66446008)(33656002)(6436002)(316002)(86362001)(14454004)(81156014)(102836004)(81166006)(46003)(2906002)(305945005)(52536014)(76176011)(71200400001)(71190400001)(53546011)(6506007)(7736002)(10290500003)(229853002)(8676002)(5660300002)(446003)(25786009)(256004)(476003)(8936002)(10090500001)(99286004)(7696005)(186003)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1129;
 H:MW2PR2101MB1116.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8tM+QlAh0bJpzylXT1BNrptQP1+750xgzuKrk/OdZh3c3aWhCzDqTbXNg0SlQwASWCr5R1ZKsjDmH76uRbpXvrF5pgnt4GzQ2N8MhzI+n1YctP6Zc84H0TKr6PoDjwneLcjHhAP6rJfBx1gJmc+qPicCzBXSBUxgkcLumRlQ9sIhJNu57zQF/37X48dkRLTMYzL4PrH2a1zKyo6aYe4QyPUFMwkusXgXqnLKAi1DRpw0YXV7nxlFGVZb5aOiXZqPyRtui351y5/VEahVeTpXtRahlD3SV+4m8CDVn66wHnUkxnQVuw7PsESD2wl6Lw3vbN8bSNECVrVjSCm1MQRQPLrUP58ApF4THIMhwS3VDpqHzLr2+lE884+Z+viGG7sBE1Aej1KAmvOP3Belp9cMgIgNVnYQJRJPAoJopbeuzeXG1E4fj/zNuoOi/bpHWjI9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af66bf8a-1091-4e0e-1e01-08d7685aea4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 16:59:58.1736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6lKfigR6RtWx7xrKVP8EX0nfHaWycdDED69EPF9GKnCb+pnXBgBiTsONt/UpwQCJKjZD6+ZAR48cimHb1UHj5ObHhYxn+NgDx9kFGwitdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.122
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMywgMjAx
OSA3OjAwIEFNDQo+IFRvOiBTdW5pbCBNdXRodXN3YW15IDxzdW5pbG11dEBtaWNyb3NvZnQuY29t
PjsgUmljaGFyZCBIZW5kZXJzb24gPHJ0aEB0d2lkZGxlLm5ldD47IEVkdWFyZG8gSGFia29zdCA8
ZWhhYmtvc3RAcmVkaGF0LmNvbT47DQo+IFN0ZWZhbiBXZWlsIDxzd0B3ZWlsbmV0ei5kZT4NCj4g
Q2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgSnVzdGluIFRlcnJ5IChWTSkgPGp1dGVycnlAbWlj
cm9zb2Z0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gV0hQWDogcmVmYWN0b3IgbG9hZCBs
aWJyYXJ5DQo+IA0KPiBPbiAwOC8xMS8xOSAyMTozMSwgU3VuaWwgTXV0aHVzd2FteSB3cm90ZToN
Cj4gPg0KPiA+ICt0eXBlZGVmIGVudW0gV0hQRnVuY3Rpb25MaXN0IHsNCj4gPiArICAgIFdJTkhW
X1BMQVRGT1JNX0ZOU19ERUZBVUxULA0KPiA+ICsgICAgV0lOSFZfRU1VTEFUSU9OX0ZOU19ERUZB
VUxULA0KPiA+ICt9IFdIUEZ1bmN0aW9uTGlzdDsNCj4gPg0KPiANCj4gV2hhdCBkb2VzICJkZWZh
dWx0IiBzdGFuZCBmb3I/ICBJIGFzc3VtZSB5b3UgaGF2ZSBtb3JlIGNoYW5nZXMgdG8gdGhpcw0K
PiBmdW5jdGlvbiBpbiB0aGUgZnV0dXJlLg0KPiANClllcywgdGhlcmUgYXJlIG1vcmUgZnVuY3Rp
b25zIGNvbWluZywgc3VjaCBhcyBmb3IgWFNBVkUuIEkgdXNlZCAiZGVmYXVsdCIgdG8gcmVwcmVz
ZW50DQp3aGF0ZXZlciBpcyB0aGVyZSBjdXJyZW50bHksIGZvciBsYWNrIG9mIGEgYmV0dGVyIHRl
cm0uDQoNCj4gPiArICogTG9hZCB0aGUgZnVuY3Rpb25zIGZyb20gdGhlIGdpdmVuIGxpYnJhcnks
IHVzaW5nIHRoZSBnaXZlbiBoYW5kbGUuIElmIGENCj4gPiArICogaGFuZGxlIGlzIHByb3ZpZGVk
LCBpdCBpcyB1c2VkLCBvdGhlcndpc2UgdGhlIGxpYnJhcnkgaXMgb3BlbmVkLiBUaGUNCj4gPiAr
ICogaGFuZGxlIHdpbGwgYmUgdXBkYXRlZCBvbiByZXR1cm4gd2l0aCB0aGUgb3BlbmVkIG9uZS4N
Cj4gPiArICovDQo+ID4gK3N0YXRpYyBib29sIGxvYWRfd2hwX2RpcGF0Y2hfZm5zKEhNT0RVTEUg
KmhhbmRsZSwgV0hQRnVuY3Rpb25MaXN0IGZ1bmN0aW9uX2xpc3QpDQo+ID4gK3sNCj4gDQo+IFR5
cG8sICJkaXBhdGNoIiBpbnN0ZWFkIG9mICJkaXNwYXRjaCIuDQo+ID4NCj4gPiArICAgIGlmICho
TGliKSB7DQo+ID4gKyAgICAgICAgRnJlZUxpYnJhcnkoaFdpbkh2RW11bGF0aW9uKTsNCj4gPiAr
ICAgIH0NCj4gDQo+IFRoZSBhcmd1bWVudCB0byBGcmVlTGlicmFyeSBzaG91bGQgYmUgaExpYi4N
Cj4gDQoNClRoYW5rcywgd2lsbCBmaXggdGhlc2UgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0K

