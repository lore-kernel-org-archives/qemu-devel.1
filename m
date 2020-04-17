Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27044C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E645E2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rWAarUpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E645E2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPRCO-0007lt-30
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 09:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jPRBO-0006vh-VX
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1jPRBN-0001os-4e
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:37:26 -0400
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com
 ([40.107.237.72]:47937 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1jPRBM-0001ng-Qc
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:37:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0K1HOlGvazDDeyZp3zJYTEjSPlLrzlDL+Y3DToJtuTZd1zKIN+8B6pdESP0uRcj/baThcn+4ZzOux68iWXYFGkHHDmj0xdv+48ezHjte2oG7OFwrjcqJyU3LvHxueUUwQaeN2f/kTbZBd099gxo+eqVS2MFgXoLTIFbAkrj7ioMj9oLxXer4sW4qJOqwNW6VJXr96lqixRVhKYCvUEK+ObYKeJGdK2czFTO1/ok80BfZh/d98A175K3oK0LM/5PhlAE9qZtyKxzT1e3nI359q/NHdaN0bwlQ2lLyCfyXL1Z4V1wVC2Y839L3J1wyJQc1IffgKWc7IHQp4XqGJHGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4dqrAiOXmlTLDQ1gGjZqnNuFoHEjypuIxZhA6OM/vQ=;
 b=fldscORL5HhBGJYdw4NT4GMaJgq4+OQHo9YS176j23X/KRJmqo81sVt/7nE/8nv74NyAvCY02hEEXNl30FVuvkmcswEDXPEDwEg9nGobpI2AiB2hlJoMtaHWcAsP+QBCdDTqUEJqa6A4RDKksE/8UuJwocJ0PEyctoXxqKDryV2dTzoD11D+5ga18lSCK0TjNnbwMHbbW2oLLNCoOkn4RChfV8sMnFaJgLgXVmY6NPdAi5LWZGNTu3Dr9jRem3xq9MQaf0fbxnyuOFPy4lrYlVGWKi9I3UfMhDDSMoBJ1wx/nW8e8FZLCRzvjgUPm+RW5ZXfOSYvXc8Tg+5/K2tMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4dqrAiOXmlTLDQ1gGjZqnNuFoHEjypuIxZhA6OM/vQ=;
 b=rWAarUpm/3UeMADiasA47x0DktX4rokhUqS8nQtjZG8sZlFz210RSP8VVI8FR1qtidzZnGLmeqy9nXGIxQVh10tqJo6EGW7YIpLiHMuqq/vcvmNmt9eDdEx0ZKYxUdV39f7ZX12E2R8lTr2Rt1A0aFu2w3Q9zumGrb+HtdhVWjg=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6051.namprd02.prod.outlook.com (2603:10b6:a03:1b5::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Fri, 17 Apr
 2020 13:37:22 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4594:49b5:fa72:7e82]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4594:49b5:fa72:7e82%7]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 13:37:22 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Subject: RE: [PATCH] chardev/char-socket: Properly make qio connections non
 blocking
Thread-Topic: [PATCH] chardev/char-socket: Properly make qio connections non
 blocking
Thread-Index: AQHWFLhNvrYYT51AlUqPZqq2zeUNLqh9SquAgAADtvA=
Date: Fri, 17 Apr 2020 13:37:22 +0000
Message-ID: <BY5PR02MB6772E34932CB07254692A676CAD90@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1587126653-5839-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAJ+F1CKCjv6rY3t0Lk9sTUFcop2xgjf=TjmkEGM54AzWCwx-XQ@mail.gmail.com>
 <20200417131359.GC69711@redhat.com>
In-Reply-To: <20200417131359.GC69711@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49f98ef3-f3d1-42f0-a648-08d7e2d47548
x-ms-traffictypediagnostic: BY5PR02MB6051:|BY5PR02MB6051:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB605136ADC35DAA553A1F4608CAD90@BY5PR02MB6051.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(54906003)(9686003)(966005)(5660300002)(66556008)(66476007)(64756008)(66446008)(478600001)(71200400001)(86362001)(55016002)(76116006)(66946007)(316002)(53546011)(6506007)(33656002)(2906002)(81156014)(186003)(26005)(52536014)(4326008)(7696005)(8676002)(110136005)(8936002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDKXhQEdO69dlYoOKoCUJg5UFz8Ro6j5+KEBAEvo9llPAHrUJn4dLCJV9WJO6nHn7eEQSGoobikn9OjpylsikvP2IdlTg772+SgSc11HLuF1XiDEZg+u9NgEmhfzE0eRSXPGvkGHsgoP8dUE3VuZ6rjzfLzaSeN2eigg1bqc56sGGLQ7/uGn9Czkc+4YevE6TuXyR46f9aG4gaz0upe9IYSj6dWFhoSuqOhtSOCD31hdoHoF+nDfbpRKT0Nr6ft/640w06YZtaKcWoRD5jBn+g3F1HbLLYLTVSSeN4Lh7OWVlxDeScAfFGMfYDODJG9fsuDw38ZJf5TzTDfI91dbnNj2xL1kbTdcfUGOPJO7RUFi9nNGEySnmgkQxayoTBQ2ymukOxNxP9RyIoyZMCPLQF2Ch2Gr72dc8/9i9RjJNCQQ3L5u6l0PRm2H8RBdRhANo7rqr4k9NncWOQ2rHmDh3dG2mReoFfA/DG2zqizJ3cSYPIB9kiwtCGxmMNqsLNF3WQUlEKo3zr/vPUQF8/duGQ==
x-ms-exchange-antispam-messagedata: oI58gyB4NGVYLww0js/nSR6iIi8lXxwNEoJAXqrp0//RHEi6uXkEaMd+I2Hb85hnm4806zpJmQZXrIPzxiFhOl8nxDnnypxpk9zz5c2VitOw4fUHTTOV67E/88QIA21xHwsegKNHyMkynC3S/yL3zQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f98ef3-f3d1-42f0-a648-08d7e2d47548
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 13:37:22.3350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cxR3Ff/G6oruV/JrSaS8xnv3A9NrT1NZuNdIYWHL2UwWAf+MiZblBgl9buxkgUPzWJO3Q4Py6hmnJAhFhtVvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6051
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.237.72
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Edgar Iglesias <edgari@xilinx.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXBy
aWwgMTcsIDIwMjAgNjo0NCBQTQ0KPiBUbzogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUu
bHVyZWF1QGdtYWlsLmNvbT4NCj4gQ2M6IFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2YUB4aWxpbngu
Y29tPjsgUGFvbG8gQm9uemluaQ0KPiA8cGJvbnppbmlAcmVkaGF0LmNvbT47IEVkZ2FyIElnbGVz
aWFzIDxlZGdhcmlAeGlsaW54LmNvbT47IFFFTVUgPHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNoYXJkZXYvY2hhci1zb2NrZXQ6IFByb3Blcmx5IG1h
a2UgcWlvIGNvbm5lY3Rpb25zDQo+IG5vbiBibG9ja2luZw0KPiANCj4gT24gRnJpLCBBcHIgMTcs
IDIwMjAgYXQgMDM6MDE6MDlQTSArMDIwMCwgTWFyYy1BbmRyw6kgTHVyZWF1IHdyb3RlOg0KPiA+
IEhpDQo+ID4NCj4gPiBPbiBGcmksIEFwciAxNywgMjAyMCBhdCAyOjM4IFBNIFNhaSBQYXZhbiBC
b2RkdQ0KPiA+IDxzYWkucGF2YW4uYm9kZHVAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+
ID4gSW4gdGNwX2Nocl9zeW5jX3JlYWQgZnVuY3Rpb24sIHRoZXJlIGlzIGEgcG9zc2liaWxpdHkg
b2Ygc29ja2V0DQo+ID4gPiBkaXNjb25uZWN0aW9uIGR1cmluZyByZWFkLCB0aGVuIHRjcF9jaHJf
aHVwIGZ1bmN0aW9uIHdvdWxkIGNsZWFuIHVwDQo+ID4gPiB0aGUgcWlvIGNoYW5uZWwgcG9pbnRl
cnMoaS5lIGlvYywgc2lvYykuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2FpIFBhdmFu
IEJvZGR1IDxzYWkucGF2YW4uYm9kZHVAeGlsaW54LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGNo
YXJkZXYvY2hhci1zb2NrZXQuYyB8IDQgKysrLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvY2hh
cmRldi9jaGFyLXNvY2tldC5jIGIvY2hhcmRldi9jaGFyLXNvY2tldC5jIGluZGV4DQo+ID4gPiAx
ODVmZTM4Li4zMGYyYjJiIDEwMDY0NA0KPiA+ID4gLS0tIGEvY2hhcmRldi9jaGFyLXNvY2tldC5j
DQo+ID4gPiArKysgYi9jaGFyZGV2L2NoYXItc29ja2V0LmMNCj4gPiA+IEBAIC01NDksMTEgKzU0
OSwxMyBAQCBzdGF0aWMgaW50IHRjcF9jaHJfc3luY19yZWFkKENoYXJkZXYgKmNociwNCj4gPiA+
IGNvbnN0IHVpbnQ4X3QgKmJ1ZiwgaW50IGxlbikNCj4gPiA+DQo+ID4gPiAgICAgIHFpb19jaGFu
bmVsX3NldF9ibG9ja2luZyhzLT5pb2MsIHRydWUsIE5VTEwpOw0KPiA+ID4gICAgICBzaXplID0g
dGNwX2Nocl9yZWN2KGNociwgKHZvaWQgKikgYnVmLCBsZW4pOw0KPiA+ID4gLSAgICBxaW9fY2hh
bm5lbF9zZXRfYmxvY2tpbmcocy0+aW9jLCBmYWxzZSwgTlVMTCk7DQo+ID4NCj4gPiBCdXQgaGVy
ZSBpdCBjYWxscyB0Y3BfY2hyX3JlY3YoKS4gQW5kIEkgY2FuJ3QgZmluZCBjbGVhbnVwIHRoZXJl
Lg0KPiA+IE5ldmVydGhlbGVzcywgSSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBiZSBoYXJtbGVz
cy4NCj4gPg0KPiA+IEknZCBhc2sgRGFuaWVsIHRvIGhhdmUgYSBzZWNvbmQgbG9vay4NCj4gDQo+
IEkgZG9uJ3Qgc2VlIGFueSBidWcgdGhhdCBuZWVkcyBmaXhpbmcgaGVyZSwgYW5kIEkgcHJlZmVy
IHRoZSBjdXJyZW50IGNvZGUgYXMgaXQNCj4gZ2l2ZXMgY29uZmlkZW5jZSB0aGF0IG5vdGhpbmcg
dGNwX2Nocl9kaXNjb25uZWN0IGRvZXMgd2lsbCBhY2NpZGVudGFsbHkNCj4gYmxvY2suDQpbU2Fp
IFBhdmFuIEJvZGR1XSBUaGUgaXNzdWUgaXMgdHJpZ2dlcmVkIHdoZW4gJ3RjcF9jaHJfaHVwJyBj
YWxsYmFjaywgaXMgZGlzcGF0Y2hlZCB3aGVuIHNvY2tldCBodW5nIHVwIGR1cmluZyBhIGJsb2Nr
aW5nIHJlYWQuIFdoaWNoIGFsc28gY2FsbHMgdGNwX2Nocl9kaXNjb25uZWN0IGFuZCBjbGVhbnMg
dXAgaW9jLCBzaW9jIHBvaW50ZXJzLiBMYXRlciBiZWxvdyBsaW5lIHNlZ2ZhdWx0cyBkdWUgdG8g
bnVsbCBwb2ludGVycw0KDQoJIiBxaW9fY2hhbm5lbF9zZXRfYmxvY2tpbmcocy0+aW9jLCBmYWxz
ZSwgTlVMTCk7ICINCg0KUmVnYXJkcywNClNhaSBQYXZhbg0KPiANCj4gDQo+ID4gPiAgICAgIGlm
IChzaXplID09IDApIHsNCj4gPiA+ICAgICAgICAgIC8qIGNvbm5lY3Rpb24gY2xvc2VkICovDQo+
ID4gPiAgICAgICAgICB0Y3BfY2hyX2Rpc2Nvbm5lY3QoY2hyKTsNCj4gPiA+ICsgICAgICAgIHJl
dHVybiAwOw0KPiA+ID4gICAgICB9DQo+ID4gPiArICAgIC8qIENvbm5lY3Rpb24gaXMgZ29vZCAq
Lw0KPiA+ID4gKyAgICBxaW9fY2hhbm5lbF9zZXRfYmxvY2tpbmcocy0+aW9jLCBmYWxzZSwgTlVM
TCk7DQo+ID4gPg0KPiA+ID4gICAgICByZXR1cm4gc2l6ZTsNCj4gPiA+ICB9DQo+ID4gPiAtLQ0K
PiA+ID4gMi43LjQNCj4gPiA+DQo+ID4gPg0KPiA+DQo+ID4NCj4gPiAtLQ0KPiA+IE1hcmMtQW5k
csOpIEx1cmVhdQ0KPiA+DQo+IA0KPiBSZWdhcmRzLA0KPiBEYW5pZWwNCj4gLS0NCj4gfDogaHR0
cHM6Ly9iZXJyYW5nZS5jb20gICAgICAtby0gICAgaHR0cHM6Ly93d3cuZmxpY2tyLmNvbS9waG90
b3MvZGJlcnJhbmdlDQo+IDp8DQo+IHw6IGh0dHBzOi8vbGlidmlydC5vcmcgICAgICAgICAtby0g
ICAgICAgICAgICBodHRwczovL2ZzdG9wMTM4LmJlcnJhbmdlLmNvbSA6fA0KPiB8OiBodHRwczov
L2VudGFuZ2xlLXBob3RvLm9yZyAgICAtby0gICAgaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS9k
YmVycmFuZ2UNCj4gOnwNCg0K

