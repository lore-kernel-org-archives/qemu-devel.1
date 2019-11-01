Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A451CCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1B6208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fuZQvMRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1B6208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQZD5-0001fq-Gp
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iQZBD-0008Ml-KS
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iQZBC-00014Q-2Y
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:49:39 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com
 ([40.107.3.90]:61186 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1iQZBB-00012z-8e; Fri, 01 Nov 2019 11:49:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl7labAf7sSbT12RrMGJwWhvx7xW70B+n55uQ1lw0U7j+k6Y0AfiACTwQfTDM5kX0rBF5x2f6GWAppqrygBlwP1Xrqc8mltoy0uVPBKBtpBiyPKd9I6QtnMW5ddoLP2HpRxCkx3+fyZNcPJlYoBcE+faViJNzuyGv8I0dvDUR8Hga5GCOfD5BlT2O+7GQGpSQ4g/2XMjBtkbcHkoXBkMcOpg2CXfQwt87wKZBx2MNCZD4pOqGPUnnYQCPGbswbU3IxLXv2c1OtVQDs244VdoQ/jacIB53CfSII4Howhj22u8Askkj5JXwdNxZ+AkVvfqGM+1qho/3oJbLSwcc4L5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlUVRPGhrfcjCGKZ+YJUViYqRfREFnYBIHJncY2AlDI=;
 b=JAbEk1E1kgOtpDxgsnuwVFZjh1xWVUVsgf2aR3mZPVlN7TO7ry6gfet+5cPxrfpvQ8K6zF+xPJ5/QeVTaPIAmU3TTSQH+F+TzVXkraDlmxfJrZtc0ik9pjZ0/UU3cSdLQ8g1GFIXJVfsGeR2DOvl2t0e4Aw8o39vEQrHoBAEGtK0HKDo7zfMyt8tl9m6ha4vCJj81i/1chC9sjjl+LbvWkazQ4tLEH78ml8R1K8Bh/J8eGWk2KdRMeGuLYlotrD6BaaqU5FQ7EewMeTVfmsTKYBtpveGS0GEajoXkQYyvmidOI9OOrutDwZ1d74yFGPqb2Z9PBHWmVm83fq7ro6DTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlUVRPGhrfcjCGKZ+YJUViYqRfREFnYBIHJncY2AlDI=;
 b=fuZQvMRSprs3d0d6ohtQi+VgWtosx8Hva0qFYjN53VZ6/wj2Zk0ilJb1rsKwZOL/iDRwTJcAsveANuloUXiIIeqWZsHyP7/ZQTnUoqO9/UrXBMz6xitwESP9btBiVcnUayI70wltvN3hhFhX0QgvSZUOzc7XT66DUAmHJp6C1Lc=
Received: from DB7PR08MB3052.eurprd08.prod.outlook.com (52.135.131.139) by
 DB7PR08MB3353.eurprd08.prod.outlook.com (52.134.111.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Fri, 1 Nov 2019 15:49:34 +0000
Received: from DB7PR08MB3052.eurprd08.prod.outlook.com
 ([fe80::b0a9:80ac:af62:a71e]) by DB7PR08MB3052.eurprd08.prod.outlook.com
 ([fe80::b0a9:80ac:af62:a71e%6]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 15:49:34 +0000
From: "Denis V. Lunev" <den@openvz.org>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Subject: Re: bitmaps -- copying allocation status into dirty bitmaps
Thread-Topic: bitmaps -- copying allocation status into dirty bitmaps
Thread-Index: AQHVkMsDMjLlBWBCwU+eAAEvYbPCRqd2dlEA
Date: Fri, 1 Nov 2019 15:49:34 +0000
Message-ID: <c8a31188-ff21-368e-12ca-0481a51c3136@openvz.org>
References: <b9b55376-3d6d-5dc2-2db3-bdced9e2d46a@redhat.com>
In-Reply-To: <b9b55376-3d6d-5dc2-2db3-bdced9e2d46a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0039.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::27)
 To DB7PR08MB3052.eurprd08.prod.outlook.com
 (2603:10a6:5:28::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.217.168.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 460674f2-b5c9-4658-0385-08d75ee31752
x-ms-traffictypediagnostic: DB7PR08MB3353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR08MB33536BDE7B5E52CBAACE1679B6620@DB7PR08MB3353.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(39850400004)(366004)(376002)(199004)(189003)(107886003)(7736002)(71200400001)(476003)(8936002)(486006)(26005)(256004)(102836004)(66446008)(66946007)(186003)(81166006)(446003)(81156014)(42882007)(14454004)(2616005)(54906003)(316002)(11346002)(64756008)(66476007)(66556008)(110136005)(31696002)(6512007)(25786009)(71190400001)(8676002)(229853002)(14444005)(4326008)(6246003)(6436002)(31686004)(305945005)(99286004)(3846002)(6116002)(6486002)(386003)(2906002)(52116002)(478600001)(53546011)(6506007)(36756003)(66066001)(76176011)(5660300002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3353;
 H:DB7PR08MB3052.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ecYyHRZLtkiK+jDklAWd6GI97szn5nq5GwjDJM0e1gpMqYB8MF0SE5XvYIcY2wBWDt9vMN//zJxzgLR5Ey+6XnDQHzBDSkNRTj3bT+fU/tDTkyqhkjKkWb0T6hXoLnbUDq/XmgTDpGRb0eGmMwGIkr0Dnn8Y1QzzRuiwCZdsCj3Co0zLjiXoQ1o0pihyFs7qbYW8PtMIZkeDakIg2zjaMBgGTMNlzcY+f0Ir6f4qaWeVGFEp3Oc7Y919PLIVSlGTxEoU+oWRs6JtoSqTm2B4JBzu7CmzZ1dKnWuXk3XhXuFY4lZbq9yNi9jebgXEJ+FlUz6RkKa/4sR1Zm5JlEaRJUaOjVWtaZ6NI+PPNs472HInDAcXqLdKacyhngCPnHd6OI4Q9q+noAXXUn+PAO46FZn4ziEp0LorNcQeygK8QBnk9cz0B0xTaI+o6R6w2CGI
Content-Type: text/plain; charset="utf-8"
Content-ID: <05AC5495DC01E24F92777E0951CA7C06@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 460674f2-b5c9-4658-0385-08d75ee31752
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 15:49:34.0890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06Jfr/k+CeWu+Ny4v0yhuCLnlOD09AgsioQ6xGg2lL/F0bNCARInkSRdfvInAGR1OeN+uYqOCVHN7DcmZwD9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3353
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.90
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTEvMS8xOSA0OjQyIFBNLCBKb2huIFNub3cgd3JvdGU6DQo+IEhpLCBpbiBvbmUgb2YgbXkg
aW5mYW1vdXNseSB1bnJlYWRhYmxlIGFuZCBsb25nIHN0YXR1cyBlbWFpbHMsIEkNCj4gbWVudGlv
bmVkIHBvc3NpYmx5IHdhbnRpbmcgdG8gY29weSBhbGxvY2F0aW9uIGRhdGEgaW50byBiaXRtYXBz
IGFzIGEgd2F5DQo+IHRvIGVuYWJsZSB1c2VycyB0byBjcmVhdGUgKGV4dGVybmFsKSBzbmFwc2hv
dHMgZnJvbSBvdXRzaWRlIG9mIHRoZQ0KPiBsaWJ2aXJ0L3FlbXUgY29udGV4dC4NCj4NCj4gKFRo
YXQgaXM6IHRvIHJlcGFpciBjaGVja3BvaW50cyBpbiBsaWJ2aXJ0IGFmdGVyIGEgdXNlciBleHRl
bmRlZCB0aGUNCj4gYmFja2luZyBjaGFpbiB0aGVtc2VsdmVzLCB5b3Ugd2FudCB0byByZXN0b3Jl
IGJpdG1hcCBpbmZvcm1hdGlvbiBmb3INCj4gdGhhdCBub2RlLiBDb252ZW5pZW50bHksIHRoaXMg
aW5mb3JtYXRpb24gSVMgdGhlIGFsbG9jYXRpb24gbWFwLCBzbyB3ZQ0KPiBjYW4gZG8gdGhpcy4p
DQo+DQo+IEl0IGNhbWUgdXAgYXQgS1ZNIEZvcnVtIHRoYXQgd2UgcHJvYmFibHkgZG8gd2FudCB0
aGlzLCBiZWNhdXNlIG9WaXJ0DQo+IGxpa2VzIHRoZSBpZGVhIG9mIGJlaW5nIGFibGUgdG8gbWFu
aXB1bGF0ZSB0aGVzZSBjaGFpbnMgZnJvbSBvdXRzaWRlIG9mDQo+IGxpYnZpcnQvcWVtdS4NCj4N
Cj4gRGVuaXMgc3VnZ2VzdGVkIHRoYXQgaW5zdGVhZCBvZiBhIG5ldyBjb21tYW5kLCB3ZSBjYW4g
Y3JlYXRlIGEgc3BlY2lhbA0KPiBuYW1lIC0tIG1heWJlICIjQUxMT0NBVEVEIiBvciBzb21ldGhp
bmcgc2ltaWxhciB0aGF0IGNhbiBuZXZlciBiZQ0KPiBhbGxvY2F0ZWQgYXMgYSB1c2VyLWRlZmlu
ZWQgYml0bWFwIG5hbWUgLS0gYXMgYSBzcGVjaWFsIHNvdXJjZSBmb3IgdGhlDQo+IG1lcmdlIGNv
bW1hbmQuDQo+DQo+IFlvdSdkIGlzc3VlIGEgbWVyZ2UgZnJvbSAiI0FMTE9DQVRFRCIgdG8gIm15
Qml0bWFwMCIgdG8gY29weSB0aGUgY3VycmVudA0KPiBhbGxvY2F0aW9uIGRhdGEgaW50byAibXlC
aXRtYXAwIiwgZm9yIGluc3RhbmNlLg0Kb3JpZ2luYWwgcHJvYmxlbSB3YXMgYSBsaXR0bGUgYml0
IGluY29ycmVjdC4gQWZ0ZXIgc29tZSB0aG91Z2h0cyBJIGZvdW5kDQp0aGF0IHRoaXMgaXMgTk9U
IGVub3VnaC4gV2Ugc2hvdWxkIGFsc28gYWRkIHplcm9lZCBjbHVzdGVycyB0byB0aGUNCmJpdG1h
cCB0byBtZXJnZSEgVGhleSBkbyBjb3ZlciBzb21lIGRhdGEgY2x1c3RlcnMgZnJvbSB0aGUgb3Jp
Z2luYWwNCmltYWdlLg0KDQpUaHVzIHdlIHNob3VsZCBlaXRoZXIgcHJvdmlkZSAiQUxMT0NBVEVE
IiBiaXRtYXAgZm9yIG90aGVyIHB1cnBvc2VzLA0KYW5kIHdlIHNob3VsZCBzdXBwbHkgIkNIQU5H
RUQiIHdoaWNoIGNvbnRhaW5zIGFsbG9jYXRlZCBBTkQNCmV4cGxpY2l0bHkgemVyb2VkIGNsdXN0
ZXJzLg0KDQpEZW4NCj4gU29tZSB0aG91Z2h0czoNCj4NCj4gLSBUaGUgb25seSBjb21tYW5kcyB3
aGVyZSB0aGlzIHBzZXVkby1iaXRtYXAgbWFrZXMgc2Vuc2UgaXMgbWVyZ2UuDQo+IGVuYWJsZS9k
aXNhYmxlL3JlbW92ZS9jbGVhci9hZGQgZG9uJ3QgbWFrZSBzZW5zZSBoZXJlLg0KPg0KPiAtIFRo
aXMgcHNldWRvIGJpdG1hcCBtaWdodCBtYWtlIHNlbnNlIGZvciBiYWNrdXAsIGJ1dCBpdCdzIG5v
dCBuZWVkZWQ7DQo+IHlvdSBjYW4ganVzdCBtZXJnZSBpbnRvIGFuIGVtcHR5L2VuYWJsZWQgYml0
bWFwIGFuZCB0aGVuIHVzZSB0aGF0Lg0KPg0KPiAtIENyZWF0aW5nIGFuIGFsbG9jYXRpb24gYml0
bWFwIG9uLXRoZS1mbHkgaXMgcHJvYmFibHkgbm90IHBvc3NpYmxlDQo+IGRpcmVjdGx5IGluIHRo
ZSBtZXJnZSBjb21tYW5kLCBiZWNhdXNlIHRoZSBkaXNrIHN0YXR1cyBjYWxscyBtaWdodCB0YWtl
DQo+IHRvbyBsb25nLi4uDQo+DQo+IEhtLCBhY3R1YWxseSwgSSdtIG5vdCBzdXJlIGhvdyB0byBz
b2x2ZSB0aGF0IG9uZS4gTWVyZ2Ugd291bGQgbmVlZCB0bw0KPiBiZWNvbWUgYSBqb2IgKG9yIGFu
IGFzeW5jIFFNUCBjb21tYW5kPykgb3Igd2UnZCBuZWVkIHRvIGtlZXAgYW4NCj4gYWxsb2NhdGlv
biBiaXRtYXAgb2JqZWN0IGFyb3VuZCBhbmQgaW4tc3luYy4gSSBkb24ndCByZWFsbHkgd2FudCB0
byBkbw0KPiBlaXRoZXIsIHNvIG1heWJlIEknbSBtaXNzaW5nIGFuIG9idmlvdXMvYmV0dGVyIHNv
bHV0aW9uLg0KPg0KPiBBbHNvLCB3aXRoIHJlZ2FyZHMgdG8gaW50cm9zcGVjdGlvbiwgaWYgd2Ug
ZG8gY3JlYXRlIGEgc3BlY2lhbCByZXNlcnZlZA0KPiBuYW1lIGxpa2UgI0FMTE9DQVRFRCwgd2Ug
bmVlZCB0byBtYWtlIHN1cmUgdGhhdCB0aGlzIGlzIGF2YWlsYWJsZSBhbmQNCj4gb2J2aW91cyB2
aWEgdGhlIFFBUEkgc2NoZW1hLg0KPg0KPiAtLWpzDQo+DQoNCg==

