Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2892C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C1D2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C1D2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZzbD-0008DY-2c
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 10:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1iZzZT-00074f-LK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1iZzZQ-0001w9-TN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:49:38 -0500
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:53055)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1iZzZQ-0001dV-Mx
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:49:36 -0500
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY
 m4a0041g.houston.softwaregrp.com WITH ESMTP; 
 Wed, 27 Nov 2019 15:46:48 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 27 Nov 2019 15:28:28 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 27 Nov 2019 15:28:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6fikrKwlFWrIZcZJcRAx/PX6s/77I2vRGjdI0z/HJYR08ByNIwqXu/lT4OVBZzDHNjRIoNeRMeUaY15CgFOUCaZYOuGcIh/8tjERM/N2JldohpUGy8yuzL/8fBBNx4dxrJAxn77j05zqo0XCaknwKQxAgRyhVXUnM8VoMGuVjiPeJDDF7hszhy+hSwGS1kwuR9MxCXPJF3r+28H/j9xlSCgxEojuGCU3CjeFzogZ0EUSnL9NCMsLHPsM1LH1NIxb+g1bZE7Cyv1INfu1sdvcwBY0RmZJqCGPOUcrc31OIQoaiXeWINtepgiUSjw0qu0HQIpdEa/Kb81bh0GfFdbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ66DujVpUvO2EtOh5v6in21IDmA+0Y+vmNZJEGWPWg=;
 b=UxMGB0VVWx28NWGs4X1NALUyYb6BuKrtuH/27fDJVq2odrauxHWky+20A0uKGkVoLqp0MU+3QYt3JwJkwJHrXy4OH11gIKHVJDbthvHsc1BlIB31X6qjp+/ELvw+6Wx5RyPzKxX2qpGHgZBASKn2cwMYe4BWOU511doeKbNzfJk8DJXtUTE/IyJ5zjMIPG2XmIA4Ez9uXsoZxEyQMKW0Mw2Z0QRBRUlK2WbjadR/fLSFGFE2SSpcjKjE9iN0PLw6J+oTwW2O4q0UCJo+bRHiOLGCa+0pY/Tv3Wf+8ITsUu5tGh8S9rhU+pkBbZZZX9S/bzOgypKKAuX/mnpdkm5Wpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2950.namprd18.prod.outlook.com (20.179.59.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 15:28:27 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::e452:516b:bc31:3280]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::e452:516b:bc31:3280%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 15:28:27 +0000
From: Liang Yan <LYan@suse.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [RFC][PATCH 0/3] IVSHMEM version 2 device for QEMU
Thread-Topic: [RFC][PATCH 0/3] IVSHMEM version 2 device for QEMU
Thread-Index: AQHVmI/KIQtCt3MU0EuTRnTT0BFR+aefPX0A
Date: Wed, 27 Nov 2019 15:28:27 +0000
Message-ID: <efd5fa87-90de-fccc-97a5-a4fc71a050c8@suse.com>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1573477032.git.jan.kiszka@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:610:38::35) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=LYan@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2605:a000:160e:228::3d1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bd3269b-c3d8-403d-9930-08d7734e72ec
x-ms-traffictypediagnostic: BYAPR18MB2950:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR18MB29505DEAE08CF6F0716F637CBF440@BYAPR18MB2950.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(52314003)(99286004)(53546011)(5660300002)(76176011)(36756003)(86362001)(2906002)(52116002)(31696002)(102836004)(7736002)(966005)(71190400001)(46003)(2616005)(11346002)(81166006)(6436002)(186003)(446003)(6486002)(71200400001)(6116002)(81156014)(54906003)(66946007)(25786009)(6512007)(31686004)(6306002)(66476007)(64756008)(66446008)(14444005)(8936002)(14454004)(6506007)(386003)(110136005)(256004)(305945005)(316002)(4326008)(66556008)(8676002)(229853002)(478600001)(80792005)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR18MB2950;
 H:BYAPR18MB2888.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /+en3lAljHxKrwLbejoSXCxWHvbH14mV9XsPcCPoOSPFU/WFt4HHTNNBb0auq+Ccg+G/NBW8kYWiDmaWspltir8cIfS35GgSt1s5m/Q/nNPq3hNdjkleTnpbCeTDjoaojfb9PJI8gQzJCSxROAZ/3ZcI3Js7iGBzibg2V33jn4DerBJhCwy/F9u5Y8cqg1iF8TQCxKwFtwvPylec7rbtutfJeoPE7n7+bXIihgynO6cmQRnRhaJ5i3BrHGRDjlje8iGazx5kBOgqrfkxpM1Z23yV72F9n68o2cbybTLZdf/qym6HS22/XuWsFDP3+GdTaVEF0AnMCaTCK8pYNjBAQLws+ZA4rVOM/Nqs24ggC+IIhPn/bYVziSVd0lOSp3W/RbMOCHfHNhykX/2aCxZDI0MkM3Y5wBPGjMZFCnZZJJ9pKBD9IMIpVydde+JJWtbQ4N7RFUM3JmilRSBWztQFPgSyIOdv8FAmGmcq6f5ZhIg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <760A38F7C04EAC4CBDFEAF0633DB81FD@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd3269b-c3d8-403d-9930-08d7734e72ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 15:28:27.1065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYC7D0/4TjBRP98O86FeNXJYCJ/iV8mnPqcuW5x4eiAGzbZKO8exaq2JWGe2uxZw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2950
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.2.87
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDExLzExLzE5IDc6NTcgQU0sIEphbiBLaXN6a2Egd3JvdGU6DQo+IFRvIGdldCB0aGUg
YmFsbCByb2xsaW5nIGFmdGVyIG15IHByZXNlbnRhdGlvbiBvZiB0aGUgdG9waWMgYXQgS1ZNIEZv
cnVtDQo+IFsxXSBhbmQgbWFueSBmcnVpdGZ1bCBkaXNjdXNzaW9ucyBhcm91bmQgaXQsIHRoaXMg
aXMgYSBmaXJzdCBjb25jcmV0ZQ0KPiBjb2RlIHNlcmllcy4gQXMgZGlzY3Vzc2VkLCBJJ20gc3Rh
cnRpbmcgd2l0aCB0aGUgSVZTSE1FTSBpbXBsZW1lbnRhdGlvbg0KPiBvZiBhIFFFTVUgZGV2aWNl
IGFuZCBzZXJ2ZXIuIEl0J3MgUkZDIGJlY2F1c2UsIGJlc2lkZXMgc3BlY2lmaWNhdGlvbiBhbmQN
Cj4gaW1wbGVtZW50YXRpb24gZGV0YWlscywgdGhlcmUgd2lsbCBzdGlsbCBiZSBzb21lIGRlY2lz
aW9ucyBuZWVkZWQgYWJvdXQNCj4gaG93IHRvIGludGVncmF0ZSB0aGUgbmV3IHZlcnNpb24gYmVz
dCBpbnRvIHRoZSBleGlzdGluZyBjb2RlIGJhc2VzLg0KPiANCj4gSWYgeW91IHdhbnQgdG8gcGxh
eSB3aXRoIHRoaXMsIHRoZSBiYXNpYyBzZXR1cCBvZiB0aGUgc2hhcmVkIG1lbW9yeQ0KPiBkZXZp
Y2UgaXMgZGVzY3JpYmVkIGluIHBhdGNoIDEgYW5kIDMuIFVJTyBkcml2ZXIgYW5kIGFsc28gdGhl
DQo+IHZpcnRpby1pdnNobWVtIHByb3RvdHlwZSBjYW4gYmUgZm91bmQgYXQNCj4gDQo+ICAgICBo
dHRwOi8vZ2l0Lmtpc3prYS5vcmcvP3A9bGludXguZ2l0O2E9c2hvcnRsb2c7aD1yZWZzL2hlYWRz
L3F1ZXVlcy9pdnNobWVtMg0KPiANCj4gQWNjZXNzaW5nIHRoZSBkZXZpY2UgdmlhIFVJTyBpcyB0
cml2aWFsIGVub3VnaC4gSWYgeW91IHdhbnQgdG8gdXNlIGl0DQo+IGZvciB2aXJ0aW8sIHRoaXMg
aXMgYWRkaXRpb25hbGx5IHRvIHRoZSBkZXNjcmlwdGlvbiBpbiBwYXRjaCAzIG5lZWRlZCBvbg0K
PiB0aGUgdmlydGlvIGNvbnNvbGUgYmFja2VuZCBzaWRlOg0KPiANCj4gICAgIG1vZHByb2JlIHVp
b19pdnNobWVtDQo+ICAgICBlY2hvICIxYWY0IDExMTAgMWFmNCAxMTAwIGZmYzAwMyBmZmZmZmYi
ID4gL3N5cy9idXMvcGNpL2RyaXZlcnMvdWlvX2l2c2htZW0vbmV3X2lkDQo+ICAgICBsaW51eC90
b29scy92aXJ0aW8vdmlydGlvLWl2c2htZW0tY29uc29sZSAvZGV2L3VpbzANCj4gDQo+IEFuZCBm
b3IgdmlydGlvIGJsb2NrOg0KPiANCj4gICAgIGVjaG8gIjFhZjQgMTExMCAxYWY0IDExMDAgZmZj
MDAyIGZmZmZmZiIgPiAvc3lzL2J1cy9wY2kvZHJpdmVycy91aW9faXZzaG1lbS9uZXdfaWQNCj4g
ICAgIGxpbnV4L3Rvb2xzL3ZpcnRpby92aXJ0aW8taXZzaG1lbS1jb25zb2xlIC9kZXYvdWlvMCAv
cGF0aC90by9kaXNrLmltZw0KPiANCj4gQWZ0ZXIgdGhhdCwgeW91IGNhbiBzdGFydCB0aGUgUUVN
VSBmcm9udGVuZCBpbnN0YW5jZSB3aXRoIHRoZQ0KPiB2aXJ0aW8taXZzaG1lbSBkcml2ZXIgaW5z
dGFsbGVkIHdoaWNoIGNhbiB1c2UgdGhlIG5ldyAvZGV2L2h2Yyogb3INCj4gL2Rldi92ZGEqIGFz
IHVzdWFsLg0KPiANCj4gQW55IGZlZWRiYWNrIHdlbGNvbWUhDQoNCkhpLCBKYW4sDQoNCkkgaGF2
ZSBiZWVuIHBsYXlpbmcgeW91ciBjb2RlIGZvciBsYXN0IGZldyB3ZWVrcywgbW9zdGx5IHN0dWR5
IGFuZCB0ZXN0LA0Kb2YgY291cnNlLiBSZWFsbHkgbmljZSB3b3JrLiBJIGhhdmUgYSBmZXcgcXVl
c3Rpb25zIGhlcmU6DQoNCkZpcnN0LCBxZW11IHBhcnQgbG9va3MgZ29vZCwgSSB0cmllZCB0ZXN0
IGJldHdlZW4gY291cGxlIFZNcywgYW5kIGRldmljZQ0KY291bGQgcG9wIHVwIGNvcnJlY3RseSBm
b3IgYWxsIG9mIHRoZW0sIGJ1dCBJIGhhZCBzb21lIHByb2JsZW1zIHdoZW4NCnRyeWluZyBsb2Fk
IGRyaXZlci4gRm9yIGV4YW1wbGUsIGlmIHNldCB1cCB0d28gVk1zLCB2bTEgYW5kIHZtMiwgc3Rh
cnQNCml2c2htZW0gc2VydmVyIGFzIHlvdSBzdWdnZXN0ZWQuIHZtMSBjb3VsZCBsb2FkIHVpb19p
dnNobWVtIGFuZA0KdmlydGlvX2l2c2htZW0gY29ycmVjdGx5LCB2bTIgY291bGQgbG9hZCB1aW9f
aXZzaG1lbSBidXQgY291bGQgbm90IHNob3cNCnVwICIvZGV2L3VpbzAiLCB2aXJ0aW9faXZzaG1l
bSBjb3VsZCBub3QgYmUgbG9hZGVkIGF0IGFsbCwgdGhlc2Ugc3RpbGwNCmV4aXN0IGV2ZW4gSSBz
d2l0Y2ggdGhlIGxvYWQgc2VxdWVuY2Ugb2Ygdm0xIGFuZCB2bTIsIGFuZCBzb21ldGltZXMNCnJl
c2V0ICJ2aXJ0aW9faXZzaG1lbSIgY291bGQgY3Jhc2ggYm90aCB2bTEgYW5kIHZtMi4gTm90IHF1
aXRlIHN1cmUgdGhpcw0KaXMgYnVnIG9yICJJdnNobWVtIE1vZGUiIGlzc3VlLCBidXQgSSB3ZW50
IHRocm91Z2ggaXZzaG1lbS1zZXJ2ZXIgY29kZSwNCmRpZCBub3QgcmVsYXRlZCBpbmZvcm1hdGlv
bi4NCg0KSSBzdGFydGVkIHNvbWUgY29kZSB3b3JrIHJlY2VudGx5LCBzdWNoIGFzIGZpeCBjb2Rl
IHN0eWxlIGlzc3VlcyBhbmQNCnNvbWUgd29yayBiYXNlZCBvbiBhYm92ZSB0ZXN0aW5nLCBob3dl
dmVyIEkga25vdyB5b3UgYXJlIGFsc28gd29ya2luZyBvbg0KUkZDIFYyLCBiZXNpZGUgdGhlIHBy
b3RvY29sIGJldHdlZW4gc2VydmVyLWNsaWVudCBhbmQgY2xpZW50LWNsaWVudCBpcw0Kbm90IGZp
bmFsaXplZCB5ZXQgZWl0aGVyLCB0aGluZ3MgbWF5IGNoYW5nZSwgc28gbXVjaCBhcHByZWNpYXRl
IGlmIHlvdQ0KY291bGQgc3F1ZWV6ZSBtZSBpbnRvIHlvdXIgZGV2ZWxvcCBzY2hlZHVsZSBhbmQg
c2hhcmUgd2l0aCBtZSBzb21lDQpwbGFucywgOi0pICBNYXliZSBJIGNvdWxkIHNlbmQgc29tZSBw
dWxsIHJlcXVlc3QgaW4geW91ciBnaXRodWIgcmVwbz8NCg0KSSBwZXJzb25hbGx5IGxpa2UgdGhp
cyBwcm9qZWN0IGEgbG90LCB0aGVyZSB3b3VsZCBiZSBhIGxvdCBvZiBwb3RlbnRpYWwNCmFuZCB1
c2VyIGNhc2UgZm9yIGl0LCBlc3BlY2lhbGx5IHNvbWUgZGV2aWNlcyBsaWtlDQppdnNobWVtLW5l
dC9pdnNobWVtLWJsb2NrLiBBbnl3YXksIHRoYW5rcyBmb3IgYWRkaW5nIG1lIHRvIHRoZSBsaXN0
LCBhbmQNCmxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5Lg0KDQpCZXN0LA0KTGlhbmcNCg0K
PiANCj4gSmFuDQo+IA0KPiBQUzogTGV0IG1lIGtub3cgaWYgSSBtaXNzZWQgc29tZW9uZSBwb3Rl
bnRpYWxseSBpbnRlcmVzdGVkIGluIHRoaXMgdG9waWMNCj4gb24gQ0MgLSBvciBpZiB5b3Ugd291
bGQgbGlrZSB0byBiZSBkcm9wcGVkIGZyb20gdGhlIGxpc3QuDQo+IA0KPiBQUFM6IFRoZSBKYWls
aG91c2UgcXVldWVzIGFyZSBjdXJyZW50bHkgb3V0IG9mIHN5bmMgL3dydCBtaW5vciBkZXRhaWxz
DQo+IG9mIHRoaXMgb25lLCBwcmltYXJpbHkgdGhlIGRldmljZSBJRC4gV2lsbCB1cGRhdGUgdGhl
bSB3aGVuIHRoZSBnZW5lcmFsDQo+IGRpcmVjdGlvbiBpcyBjbGVhci4NCj4gDQo+IFsxXSBodHRw
czovL2t2bWZvcnVtMjAxOS5zY2hlZC5jb20vZXZlbnQvVG14SQ0KPiANCj4gSmFuIEtpc3prYSAo
Myk6DQo+ICAgaHcvbWlzYzogQWRkIGltcGxlbWVudGF0aW9uIG9mIGl2c2htZW0gcmV2aXNpb24g
MiBkZXZpY2UNCj4gICBkb2NzL3NwZWNzOiBBZGQgc3BlY2lmaWNhdGlvbiBvZiBpdnNobWVtIGRl
dmljZSByZXZpc2lvbiAyDQo+ICAgY29udHJpYjogQWRkIHNlcnZlciBmb3IgaXZzaG1lbSByZXZp
c2lvbiAyDQo+IA0KPiAgTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgICAzICsNCj4gIE1ha2VmaWxlLm9ianMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgMSArDQo+ICBjb25maWd1cmUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
IDEgKw0KPiAgY29udHJpYi9pdnNobWVtMi1zZXJ2ZXIvTWFrZWZpbGUub2JqcyAgICAgfCAgICAx
ICsNCj4gIGNvbnRyaWIvaXZzaG1lbTItc2VydmVyL2l2c2htZW0yLXNlcnZlci5jIHwgIDQ2MiAr
KysrKysrKysrKysNCj4gIGNvbnRyaWIvaXZzaG1lbTItc2VydmVyL2l2c2htZW0yLXNlcnZlci5o
IHwgIDE1OCArKysrKw0KPiAgY29udHJpYi9pdnNobWVtMi1zZXJ2ZXIvbWFpbi5jICAgICAgICAg
ICAgfCAgMzEzICsrKysrKysrKw0KPiAgZG9jcy9zcGVjcy9pdnNobWVtLTItZGV2aWNlLXNwZWMu
bWQgICAgICAgfCAgMzMzICsrKysrKysrKw0KPiAgaHcvbWlzYy9NYWtlZmlsZS5vYmpzICAgICAg
ICAgICAgICAgICAgICAgfCAgICAyICstDQo+ICBody9taXNjL2l2c2htZW0yLmMgICAgICAgICAg
ICAgICAgICAgICAgICB8IDEwOTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGlu
Y2x1ZGUvaHcvbWlzYy9pdnNobWVtMi5oICAgICAgICAgICAgICAgIHwgICA0OCArKw0KPiAgMTEg
ZmlsZXMgY2hhbmdlZCwgMjQxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgY29udHJpYi9pdnNobWVtMi1zZXJ2ZXIvTWFrZWZpbGUub2Jqcw0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGNvbnRyaWIvaXZzaG1lbTItc2VydmVyL2l2c2htZW0yLXNlcnZl
ci5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgY29udHJpYi9pdnNobWVtMi1zZXJ2ZXIvaXZzaG1l
bTItc2VydmVyLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBjb250cmliL2l2c2htZW0yLXNlcnZl
ci9tYWluLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL3NwZWNzL2l2c2htZW0tMi1kZXZp
Y2Utc3BlYy5tZA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvaXZzaG1lbTIuYw0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvbWlzYy9pdnNobWVtMi5oDQo+IA0K

