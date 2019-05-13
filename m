Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28432C04AAA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68DE20879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H+hIyfoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68DE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58771 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQCSe-00031D-Tr
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 11:01:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hQCQS-0001VZ-05
	for qemu-devel@nongnu.org; Mon, 13 May 2019 10:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hQCEQ-0000Zh-Fs
	for qemu-devel@nongnu.org; Mon, 13 May 2019 10:47:11 -0400
Received: from mail-eopbgr90125.outbound.protection.outlook.com
	([40.107.9.125]:59024
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hQCEO-0000YH-T0; Mon, 13 May 2019 10:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=1geoMEXB+FkXENxt9gKovVdwC1zS8Gsjf7XWaaRzVVY=;
	b=H+hIyfoeHrS9wvJOhfURySlzSRIGxf6wtumbanZVTp8BSgrXwZftTuAbFzK3Be9HNCWzoKrFuvWZyX+dRrpcnC+v52tu7mr7rUgZX8Ca9rgCnac831DNXVWQtQl0MgFrEvu7TC82Wubd5jPNtfh5YeqQNgXQqTpFBwSAMkNfpX8=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4810.eurprd08.prod.outlook.com (52.133.107.12) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.20; Mon, 13 May 2019 14:47:06 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1878.024;
	Mon, 13 May 2019 14:47:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH] nbd/server: Nicer spelling of max BLOCK_STATUS reply
	length
Thread-Index: AQHVB0OCRUIno+V6F0mF/Up1/Ona46ZpCfuAgAAYnYCAAARWAA==
Date: Mon, 13 May 2019 14:47:06 +0000
Message-ID: <d2af0a95-0a58-34a3-5f89-f72ad6ea7a43@virtuozzo.com>
References: <20190510151735.29687-1-eblake@redhat.com>
	<f72c864a-b695-cf35-f183-f1818fc5609a@virtuozzo.com>
	<3dfc080f-9878-f40f-f8c0-40c134bf99b6@redhat.com>
In-Reply-To: <3dfc080f-9878-f40f-f8c0-40c134bf99b6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0267.eurprd05.prod.outlook.com
	(2603:10a6:3:fc::19) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190513174704309
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3c872a3-ce5e-4d3a-c331-08d6d7b1de6f
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4810; 
x-ms-traffictypediagnostic: PR2PR08MB4810:
x-microsoft-antispam-prvs: <PR2PR08MB4810B687E5690B94ABDA7C00C10F0@PR2PR08MB4810.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39840400004)(376002)(366004)(396003)(346002)(136003)(199004)(189003)(55674003)(36756003)(52116002)(81166006)(53546011)(6116002)(81156014)(4744005)(8676002)(6512007)(6506007)(386003)(102836004)(3846002)(5660300002)(8936002)(31686004)(99286004)(6486002)(6436002)(71190400001)(478600001)(68736007)(71200400001)(316002)(66066001)(229853002)(14444005)(110136005)(2906002)(14454004)(305945005)(76176011)(7736002)(11346002)(66446008)(2616005)(31696002)(4326008)(186003)(66476007)(64756008)(446003)(66946007)(256004)(73956011)(26005)(6246003)(2501003)(53936002)(86362001)(66556008)(25786009)(486006)(476003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4810;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1fADrj7PUY5ZA7SoRUwZ0pZEWpzy4k9PHZxE4GTMLblqNMepNQMt6ACjOdtsom9marNKkNNjXeCHJbEnTxkUNtRaHhKiRFuyk27GkR95vwgg1Z757lr2m3D1Pj/+Lk4FkE42g6fUrWepy0eoY3LknDmTi+04Eu+kK0gcg9j9y25kLdsx7tzh4NSPDZFxoS/2Z8iz+9XVLtrjaCB8wiRezGlbigakN/7AyXqQ3ZAsufaMN/g7YdAqJM1ow79IseCOMgYyvdtpacfr7NOQTDv6bWYgtZM35xlQI8zPanzV17av1TWzuhidsDOmx23OAeB6/vWT68xyZnH7p1FvrU5yQS7JpYfLx9vlNxPs8AbJHmY66eXyWqd3Up7h0ngxEkrKYb1tYkslJuLBEtQ2TJWe97FdPq4Af5mhzzxIn0D5Kh0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E6327E77EF12044AD7C26A1AE5930D7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c872a3-ce5e-4d3a-c331-08d6d7b1de6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 14:47:06.4416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4810
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.125
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Nicer spelling of max
 BLOCK_STATUS reply length
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDUuMjAxOSAxNzozMSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNS8xMy8xOSA1OjAzIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMTAuMDUuMjAxOSAxODox
NywgRXJpYyBCbGFrZSB3cm90ZToNCj4+PiBDb21taXQgM2QwNjhhZmYgKDMuMCkgaW50cm9kdWNl
ZCBOQkRfTUFYX0JJVE1BUF9FWFRFTlRTIGFzIGEgbGltaXQgb24NCj4+PiBob3cgbGFyZ2Ugd2Ug
d291bGQgYWxsb3cgYSByZXBseSB0byBOQkRfQ01EX0JMT0NLX1NUQVRVUyB0byBncm93IHdoZW4N
Cj4+PiBpdCBpcyB2aXNpdGluZyBhIHFlbXU6ZGlydHktYml0bWFwOiBjb250ZXh0LiAgTGF0ZXIs
IGNvbW1pdCBmYjdhZmM3OQ0KPj4+ICgzLjEpIHJldXNlZCB0aGUgY29uc3RhbnQgdG8gbGltaXQg
YmFzZTphbGxvY2F0aW9uIGNvbnRleHQgcmVwbGllcywNCj4+PiBhbHRob3VnaCB0aGUgbmFtZSBp
cyBub3cgbGVzcyBhcHByb3ByaWF0ZSBpbiB0aGF0IHNpdHVhdGlvbi4NCj4+Pg0KPj4+IFJlbmFt
ZSB0aGluZ3MsIGFuZCBpbXByb3ZlIHRoZSBtYWNybyB0byB1c2UgdW5pdHMuaCBmb3IgYmV0dGVy
DQo+Pj4gbGVnaWJpbGl0eS4gVGhlbiByZWZvcm1hdCB0aGUgY29tbWVudCB0byBjb21wbHkgd2l0
aCBjaGVja3BhdGNoIHJ1bGVzDQo+Pj4gYWRkZWQgaW4gdGhlIG1lYW50aW1lLiBObyBzZW1hbnRp
YyBjaGFuZ2UuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVk
aGF0LmNvbT4NCj4+DQo+Pg0KPj4gV2l0aCBvciB3aXRob3V0IFN0ZWZhbm8ncyBzdWdnZXN0aW9u
Og0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gDQo+IEknbSBhc3N1bWluZyBSZXZpZXdlZC1ieSBp
bnN0ZWFkIG9mIFNpZ25lZC1vZmYtYnk/DQo+IA0KDQpBaGEsIG9mIGNvdXJzZS4gQ29weS1wYXN0
ZWQgYW5kIGZvcmdldCB0byBmaXgoDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

