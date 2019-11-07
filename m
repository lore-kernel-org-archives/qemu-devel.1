Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5AAC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 22:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18CB21D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 22:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Pw3u4P1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18CB21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSqfU-00058e-3G
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 17:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1iSqdk-0004a8-Aa
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 17:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1iSqdi-0005fR-33
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 17:52:31 -0500
Received: from mail-eopbgr790097.outbound.protection.outlook.com
 ([40.107.79.97]:2433 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1iSqdh-0005bm-NK
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 17:52:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJrEutD3Fc9DHJ1WFBgIUJ6JwTuv1+DLOqi40P/hpe7e8Ili25CfMJde6uHNxvaCw2VgBZUGoJzJDH2ZVQaHTbgY0NZS3zIfDuqPWqmXU6z7YISxGYNkrQ5OTZMew3BSgLrV9sfJsznEB+/1lat7/bnp3OeERuEOBqyqTdZCOTmAXTu4g2FStch9BkrzLrlGVTryDbq2ei4NimCD7qMpRsfWv6R6SXWYD6ypqVajVzvl+//kzKOtuzfJ/8PbSR8c/L8za4oVxkBSoPj4KuDYY7EetLNZeFWDHm2roiph4DRCJWunfpt6WRwZVCLH82d3WfpqiAI0uzmIeT3elxT2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t//4QI91ueAtSI1GL4YrhEM/2qHIpjUFL+WhtkJh+JY=;
 b=BT9q3BYouqP8d/CaFf/F8RYBe5FQCJIW1VuoMkZxPj84E9TL1Y5WhjxrCZB9xThtY7HxYpZVRIsX2Ssy6tA+X3QspR4RTpR8yDrOD/Fn889/epZl14QyjPuNeAyG9b8Lm78jfxzvDYitTRJ4RXu5pGG2OkY7nZaQhLUz5OVF3VTpbK0kFQ/ltT3aGbkkQEqOu4pOIGsBCzs9SiqsdG0IndhSUHKFGCvClh4gl5AGmhioDLfqq/M9Q/x8xk0hnecPaHjIqadidI7tUbiVnhHLiA64KcBqIBId1kuNlC1K/rMVX0CVNjrlfdNEILFIcmoojPjkIJF6y2xjxTRqrsqVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t//4QI91ueAtSI1GL4YrhEM/2qHIpjUFL+WhtkJh+JY=;
 b=Pw3u4P1EAw7OF0dwCBTLm59MflXW/G91sZWi+otqHCch+QdY7zuvwuP37P4TWeOOgzD6IfansiSQqO4x/eX7Vy19pBuT3io21QGzbpuIgDc6c6cYa7MUhxMetZigYrrQTwOvP/VVsCcR6H8yBEUQyZat7D700nXKpd7cdo2xfbg=
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) by
 MW2PR2101MB1036.namprd21.prod.outlook.com (52.132.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.11; Thu, 7 Nov 2019 22:52:27 +0000
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9]) by MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9%7]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 22:52:27 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] WHPX: support for xcr0
Thread-Topic: [PATCH v2] WHPX: support for xcr0
Thread-Index: AdWVpCACQMQiiI0KR2iuY0/EuyLlQQAApmyAAAWkb6A=
Date: Thu, 7 Nov 2019 22:52:26 +0000
Message-ID: <MW2PR2101MB111666F06FADEC582CAE4184C0780@MW2PR2101MB1116.namprd21.prod.outlook.com>
References: <MW2PR2101MB1116F07C07A26FD7A7ED8DCFC0780@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <1c446cc0-8a22-41d6-fe38-db0b7333ed89@weilnetz.de>
In-Reply-To: <1c446cc0-8a22-41d6-fe38-db0b7333ed89@weilnetz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:fdd2:fbfa:b235:c4a3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ccee17f-093a-4420-df0c-08d763d52977
x-ms-traffictypediagnostic: MW2PR2101MB1036:
x-microsoft-antispam-prvs: <MW2PR2101MB10368CBA4BDF3FEE64DBB1CFC0780@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(55016002)(33656002)(99286004)(102836004)(5660300002)(110136005)(71190400001)(316002)(22452003)(52536014)(76116006)(66946007)(66556008)(64756008)(66446008)(66476007)(6506007)(186003)(6116002)(7696005)(76176011)(46003)(14444005)(256004)(486006)(476003)(11346002)(446003)(74316002)(8990500004)(7736002)(10290500003)(478600001)(71200400001)(14454004)(305945005)(25786009)(8936002)(81166006)(6246003)(4326008)(2906002)(10090500001)(8676002)(81156014)(6436002)(9686003)(229853002)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1036;
 H:MW2PR2101MB1116.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fRum5I/8hHPCjBnBS5gdc13cwJPhHgBTzg6DE7ixNCep4ptcg+LLgVGANL54Izap9w940b7g4cOMlvJ9tNydme5vxZejuTVkVc02LyZLGo091jR6vo/sg8SXpDAXvvNZLm2J5UICro2/nbKz/FlLK9f4ZZt+W6xVToxDQw3X4/wLPwhKLJfHSu76Tp67VA7fYXg+fryguQ2yrziSL4SerMD48pJ/ktcadfWBUL5X+w7O7J9vYx8NtNozIV83Ka/WlXQ8nCV+jdYbdDN89UfYsbtimEY/8lSMvCZIV5UKrs/UHATqhiWi22wMVR/4VZJ284//iwHVcMUPVp977dXTnKL1dPofDnDCsTaerk+2u4ld2Bn5RdsZbIC5fKVnl8n4EbC8zA+8+9UVmiVKasnnfONjNPjqU0mAo8N0lL1JBs/Yfs0wKadSYjlTBF4Kz7wR
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccee17f-093a-4420-df0c-08d763d52977
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 22:52:26.1005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ev/qnLOLkRBlvLsIBXirLy92PTm33PBK9oEi4+yph1pS8l8M8LSUP0rzWMk0SS7LSwSXVvXX3BP5hpwz0gqk0PO5SadCXRXsaS84V/PlYSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.97
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

PiA+IFlvdSB3aWxsIG5lZWQgdGhlIFdpbmRvd3MgMTAgU0RLIGZvciBSUzUgKGJ1aWxkIDE3NzYz
KSBvciBhYm92ZSB0bw0KPiA+IHRvIGJlIGFibGUgdG8gY29tcGlsZSB0aGlzIHBhdGNoIGJlY2F1
c2Ugb2YgdGhlIGRlZmluaXRpb24gb2YgdGhlDQo+ID4gWENSMCByZWdpc3Rlci4NCj4gPg0KPiA+
IENoYW5nZXMgc2luY2UgdjE6DQo+ID4gLSBBZGRlZCBhIHNpZ24tb2ZmIGxpbmUgaW4gdGhlIHBh
dGNoLg0KPiANCj4gDQo+IEkgYW0gbm90IHZlcnkgaGFwcHkgd2l0aCB0aGUgY3VycmVudCBzaXR1
YXRpb24gd2hpY2ggc3VnZ2VzdHMgdXNpbmcgbm9uDQo+IGZyZWUgaGVhZGVyIGZpbGVzIGZyb20g
dGhlIE1pY3Jvc29mdCBXaW5kb3dzIFNESywgdGh1cyBtYWtpbmcgaXQNCj4gaW1wb3NzaWJsZSB0
byBwcm9kdWNlIFFFTVUgZXhlY3V0YWJsZXMgZm9yIFdpbmRvd3Mgd2l0aCBXSFBYIHN1cHBvcnQN
Cj4gd2l0aG91dCBoYXZpbmcgbGVnYWwgY29tcGxpY2F0aW9ucy4NCj4gDQo+IENvdWxkIHlvdSBw
bGVhc2UgYWRkIHRoZSByZXF1aXJlZCBoZWFkZXJzIHdpdGggYSBzdWl0YWJsZSBsaWNlbnNlIHRv
IHRoZQ0KPiBRRU1VIHNvdXJjZSBjb2RlPyBUaGF0IHdvdWxkIGNsYXJpZnkgdGhlIGxpY2Vuc2Ug
aXNzdWUgYW5kIG1ha2UgYnVpbGRzDQo+IHdpdGggV0hQWCBtdWNoIGVhc2llciBiZWNhdXNlIHRo
b3NlIGZpbGVzIHdvdWxkIG5vdCBoYXZlIHRvIGJlIGV4dHJhY3RlZA0KPiBmcm9tIGEgdmVyeSBs
YXJnZSBTREsgaW5zdGFsbGF0aW9uLg0KPiANCj4gSXQgd291bGQgYWxzbyBiZSBhY2NlcHRhYmxl
IGlmIE1pY3Jvc29mdCBjb3VsZCB1cGRhdGUgdGhlIGxpY2Vuc2UNCj4gY29tbWVudHMgaW4gdGhv
c2UgZmlsZXMgYW5kIHVzZSBhIFFFTVUgY29tcGF0aWJsZSBsaWNlbnNlLg0KPg0KSSBhZ3JlZSBp
biBwcmluY2lwbGUgdGhhdCB0aGVyZSBzaG91bGQgYmUgYW4gZWFzaWVyIHdheSB0byBjb25zdW1l
IHRoZSBXaW5kb3dzDQpTREsgaGVhZGVycyB3aXRob3V0IGhhdmluZyB0byBwbGF5IGFyb3VuZCB3
aXRoIHRoZSBsaWNlbnNlcy4gSSBhbHNvIGFncmVlIHRoYXQNCnRoYXQgd2lsbCBtYWtlIGxpZmUg
bG90IGVhc2llciBmb3IgbWFueSBkZXZlbG9wZXJzLiBJIGFtIHJlYWNoaW5nIG91dA0KaW50ZXJu
YWxseSBoZXJlIHRvIHNlZSB3aGF0IGNhbiBiZSBkb25lIGFib3V0IHRoaXMsIGJ1dCwgdGhhdCBt
aWdodCB0YWtlIHNvbWUNCnRpbWUuIE1lYW53aGlsZSwgaXMgaXQgcG9zc2libGUgdG8gbWFrZSBz
b21lIHByb2dyZXNzIG9uIHRoaXMgcGF0Y2g/DQoNCj4gS2luZCByZWdhcmRzDQo+IFN0ZWZhbiBX
ZWlsDQo+IA0KPiANCg0K

