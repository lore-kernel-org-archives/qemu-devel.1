Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF41C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 16:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4579E2070C
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 16:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Wnd3+fsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4579E2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwU9N-0007Ok-CZ
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 12:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51193)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwU8l-0006qG-UK
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 12:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwU8k-00051r-Vi
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 12:22:47 -0400
Received: from mail-eopbgr10118.outbound.protection.outlook.com
 ([40.107.1.118]:49892 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwU8k-00050h-Cn; Sat, 10 Aug 2019 12:22:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BShRIReJ87X3EdLxhypfs+tcuhDdEiLNw4KBj0j2t9aCBlHvaG3nmVugTUfUdwOvLKPMwKIeEbFD1OoxVTxB6g0o5eLxkCR0I3tafpt6lHNazD4okAw0IyKwfeJizsZob2rUY64mObd2/63jz6mPyeQuHVLSRj9CGL6amPJ30W7v41gvVT1PI1P9dRIGuiX38NeGx0A0eegS/iNM1GxrhEL+oTiMKPFbPWg9PS0/OuVteCuwDJtSLFcpxX0FEjpR+sCcRbXvB/pxbp2Z0+O6mJoW5aBxkjp/LGoK1tJTOypi04XRmX1gCsFRWZZeU4YCCpJEbh+GH11lwFJB5ZfR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuU3xY1Mw8ukhbjzF2hMsJm52lFsruVn0+EiWKTIedE=;
 b=L84QnSHhkzzHrcAcOJsmVKQU8+SKkEcTlPuxTdd2evDPSlsj9BIpKIy2R5RYi+JBfw/BfdMR/gRQJ9h7eh8ppjgMfRzMfAQWghrRg+iXiJEGSvJRP8Kqqsc1veU+Q5op+G4SDRi78xM7iAmqKoQx56XVYOsI1ftXs4RcOHim0h+tuNZO/6X1YFCtv06CH1X4w4yY2ZvELV24ZU3sq4iAEXlO0+pDZ4fmSZzD9MxOk90wWZa3tDQnf+aTqX46kPx3OC8Y6GcUoDklWCdhK81iqDRRmoZny405bK1XiLO7sgFqpnY6jSmcJI1lZ+V1YyHNMitBa2zEXuk4UNP4lZjGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuU3xY1Mw8ukhbjzF2hMsJm52lFsruVn0+EiWKTIedE=;
 b=Wnd3+fsZC/dYNQYaaFWOzrjTd4dZbB+OfgDfPQ4KvoMesC+51tmAFnoM/CBPdkaSoe3qrabtFYkLMf8Vb21lIp4sLzgDzxWlPls0wZIE1PJ/LKE0AIeBEGqpKEgmGrc8cdHZO4LaXXBJbUUTJ8Q50tu1hW/RRUwXIr9kZUe2nXw=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB4467.eurprd08.prod.outlook.com (20.179.32.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Sat, 10 Aug 2019 16:22:43 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::1d02:1f6:aa28:4aff]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::1d02:1f6:aa28:4aff%3]) with mapi id 15.20.2157.022; Sat, 10 Aug 2019
 16:22:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 18/42] block: Use CAFs in bdrv_refresh_filename()
Thread-Index: AQHVTs2Tpg0rwzu2E0eUMbCSHPFQp6b0kg0A
Date: Sat, 10 Aug 2019 16:22:43 +0000
Message-ID: <b37f873b-cb6c-1d91-475b-98ee050caa2b@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-19-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-19-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:7:66::19) To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810192240618
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abbedebe-eab6-44c0-da9b-08d71daef89c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB4467; 
x-ms-traffictypediagnostic: AM0PR08MB4467:
x-microsoft-antispam-prvs: <AM0PR08MB44678142ABCDBAAA9F2B8E2DC1D10@AM0PR08MB4467.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39840400004)(189003)(199004)(14454004)(110136005)(54906003)(558084003)(7736002)(2501003)(31686004)(478600001)(31696002)(66066001)(305945005)(86362001)(316002)(99286004)(6506007)(386003)(71200400001)(71190400001)(52116002)(186003)(53936002)(76176011)(2906002)(26005)(5660300002)(102836004)(81156014)(8936002)(486006)(6116002)(3846002)(6246003)(66556008)(66946007)(4326008)(66476007)(25786009)(446003)(476003)(66446008)(11346002)(2616005)(64756008)(8676002)(6512007)(36756003)(229853002)(256004)(6486002)(81166006)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4467;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c9BWrsuQxQAU7G9BKXUnBhTMYVEcft3c2IyLZxLkDUrw7ZCcG660K7psXOx2801zwe35uFh4tR1ueexOIJLl631R3lCGjG8GUL+JCR7aZzyF/QkSeO7BktqeRUXt9qinwSIK7k+mjZZRSmVjWQ2+YFOFlSRoX5az8ukUL4ZlFM0NVcLTaGNDuix24cSjB9LgopGTSIPs932mfAy8dur5wFDE51KIWekZqj0JM4kuxJW4qU1sLdLl1JtvE74+JTggLLzld76mGqiQzXx+LAWetDMUIYgnDe3sT7EdNvrwLxgUq0Q3R4C/9x/VgyO9hEFKEFUplM3wsD72U2dkDoQ0lrelzNg+q9++qsRFviD9rct3gwgOx7AiYoYd1NkUNHURK2Co7i3do4mluRNUvWlGcZBrpc2ROf2hTYlC0pXnkPo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <642077046D12EE419830DF689F9AF421@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbedebe-eab6-44c0-da9b-08d71daef89c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 16:22:43.0680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVOkLyTAwfSw2Q1GHlOoIM7IQ+Uxng4Mo5CL3CaqnTUNHXDMhOoSoLmn0Q0zNbZ2dmO1d58QASEy1DCoEmJ4WpU1S4gkml5i1ZJD9DcwKdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4467
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.118
Subject: Re: [Qemu-devel] [PATCH v6 18/42] block: Use CAFs in
 bdrv_refresh_filename()
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBiZHJ2X3JlZnJlc2hfZmlsZW5h
bWUoKSBhbmQgdGhlIGtpbmQgb2YgcmVsYXRlZCBiZHJ2X2Rpcm5hbWUoKSBzaG91bGQNCj4gbG9v
ayB0byB0aGUgcHJpbWFyeSBjaGlsZCB3aGVuIHRoZXkgd2lzaCB0byBjb3B5IHRoZSB1bmRlcmx5
aW5nIGZpbGUncw0KPiBmaWxlbmFtZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8
bXJlaXR6QHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

