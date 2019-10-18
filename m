Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2D2CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC2220872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q5VlAsCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC2220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLV0n-000215-Ke
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLUqm-0007vV-2E
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLUqk-0007pz-N3
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:35 -0400
Received: from mail-eopbgr70125.outbound.protection.outlook.com
 ([40.107.7.125]:19704 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iLUqk-0007on-3L; Fri, 18 Oct 2019 12:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVDmYIubO4RZ6McNKQ2XJzTjR7TEJfS9A0kMUSc/QKDBifPuiML9V6pAR0u89jHCWYncWP2PvefgynfxpUBSxxjEhO17w8PcfrFw+sWipyuowKDqrpqkV5yhRixHl9kyqthAlBS+5u5JlRjKrsrBD5YRrlVgBm5EBUR+uqEVB1B0WMJFoiwii4QpvvXwUZdiS22QSPefJ2lJT12MjBDTxOdW15IMqtXoZjCaIe50J1UrARoZ9qap9WQtQDCt9RD9P473FzMQOt/CKecbwnZ/BwJ5GRzZW8W5MR11p2M2L0MLav79hPgiPCKPC1X9fN+8nRWyz57XDANqa6yiBcaM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OojNuedVto3QiteZ3qxJ4AmnKM8tW0YU1fOzFLypS4=;
 b=ch4Bzh/HjFf8EZ09FzwL/fznAyLuIPP+dVfJWRxKxOkRlxRBqzl1Btz0TMJ7++65j3nm7syJBpbwzSAz4T4b6J60dtlVHI29bmEF2PJXLYF0xSBAe2Qh0GydLeO9qB2okH9EvAST3E8NKgdXytjn8zUsxNX+EC36L+ND6uW0D9O970CcMlVfCkyNIBKzJT4sPdm5OPUE/7kvg1DyhKSy3KNT7q8DTypIwZ/mmQ/cDfJE8ri71ea4yY7gFVHqr1e0R/Le+m5Dm2BfWBobYxw1aoHe5wi6NxxzAb1dKlzmNIBLDIldtM8p3Jc09+sCVH73FqUzglhyxsXkVjZyr2ZYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OojNuedVto3QiteZ3qxJ4AmnKM8tW0YU1fOzFLypS4=;
 b=q5VlAsCOgaz4Gy1ooI9xVG6xYU5qlSx+YSpIN5ZdYon0lZRZmzgBQP8oytCnOu10hyo8ojKPDeo73TDiUIEE8akR8Fzo/l/0I0Qd3S3KY2VZXY2se2jENQIZolMRQJNtn8BL68iZtvogQcHfylW8+Qhb+AA74Erhc+oMEd6PVYQ=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB5458.eurprd08.prod.outlook.com (52.132.214.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 16:11:31 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 16:11:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 0/5] active-mirror: support unaligned guest operations
Thread-Topic: [PATCH v2 0/5] active-mirror: support unaligned guest operations
Thread-Index: AQHVgBNKyLh6vdaLOEKwM40g0gabyKdgmHIAgAAEzYA=
Date: Fri, 18 Oct 2019 16:11:31 +0000
Message-ID: <5467321d-69ef-8ba9-aa8c-2bbe4d59274a@virtuozzo.com>
References: <20191011090711.19940-1-vsementsov@virtuozzo.com>
 <dc555030-9238-126c-9256-8df6304d30e1@redhat.com>
In-Reply-To: <dc555030-9238-126c-9256-8df6304d30e1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0223.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::23) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191018191129217
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4e8f924-fc9b-42fb-36ec-08d753e5d6e9
x-ms-traffictypediagnostic: AM0PR08MB5458:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB54589E9645FA0726791988ACC16C0@AM0PR08MB5458.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(346002)(376002)(136003)(396003)(366004)(39850400004)(189003)(199004)(110136005)(25786009)(66476007)(66556008)(64756008)(2906002)(66946007)(6512007)(486006)(478600001)(6436002)(31686004)(66446008)(5660300002)(14454004)(66066001)(81156014)(81166006)(8676002)(229853002)(966005)(6306002)(256004)(6116002)(6486002)(476003)(2616005)(11346002)(3846002)(446003)(107886003)(31696002)(102836004)(71200400001)(71190400001)(186003)(76176011)(86362001)(6246003)(99286004)(53546011)(4326008)(305945005)(26005)(52116002)(2501003)(7736002)(8936002)(54906003)(316002)(6506007)(386003)(36756003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5458;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TuIiiIOOLyUXw77Ux+Uw20NDhX0hPFeeVc9uMrblrf15Di0lu+zU0w0hndQmrYbyv37DkxgXH5DptdFxQEGVdIECflwuJ3i4AUmvn45WCWaSma1uj8hVjpMzSudfkxqFJBU+wZCfJrh2aoeuThtHZHWPmS8ZjhwsiU6BZ8BfRR8um54DcSaNzrAl3R8TSxndgo67ht0ouRE0JDtnSdqR9K+7TsmPNI4av6Watz8OAQsPmsmlr1rLVGO3zAqdjZp0Ysq5mJLSjinEZeoyJjSdw3anbj16BdaFv/Cp5daKKlbBXQaHHcPFcSllT1mvEWOmz3Boap9ja5FOxaSi5jH5CP4eG42KYb8Ax3jcPDKUTvKAT1nw0F3D6Vim78ax9X6ipIB8cYSCncF7J1mmztYZEynQ7ZD+7mSb3P0ERQu/v+zwd8QNDBsid7uG+dgozvnqZ1k2aXZJPsF8g9OGok669A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A09DF2302BCC042B01BA934C42D87DF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e8f924-fc9b-42fb-36ec-08d753e5d6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 16:11:31.5748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hB8HRBk0e7alHYacRaGb6pvN8HOQX1rybLXkM4DqavmGvtUgb7vimACMO08DMOGAHVOxaxNEw/AqCDTxMeI2afZvv8q1xft370dEASpmhsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5458
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.125
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMTAuMjAxOSAxODo1NCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMS4xMC4xOSAxMTowNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IENvbW1pdCA5YWRjMWNiNDlh
ZjhkIGZpeGVkIGEgYnVnIGFib3V0IHVuYWxpZ25lZCAodG8gZGlydHkgYml0bWFwDQo+PiBncmFu
dWxhcml0eSkgZ3Vlc3Qgd3JpdGVzIChhbmQgZGlzY2FyZHMpIGJ5IHNpbXBseSByZXF1ZXN0aW5n
DQo+PiBjb3JyZXNwb25kaW5nIGFsaWdubWVudCBvbiBtaXJyb3ItdG9wIGZpbHRlci4gSG93ZXZl
ciBmb3JjaW5nIGxhcmdlDQo+PiBhbGlnbm1lbnQgb2J2aW91c2x5IGRlY3JlYXNlcyBwZXJmb3Jt
YW5jZSBvZiB1bmFsaWduZWQgcmVxdWVzdHMuDQo+Pg0KPj4gU28gaXQncyB0aW1lIGZvciBhIG5l
dyBzb2x1dGlvbiB3aGljaCBpcyBpbiAwNC4gQW5kIDA1IHJldmVydHMNCj4+IDlhZGMxY2I0OWFm
OGQuDQo+Pg0KPj4gdjI6DQo+PiAwMTogbmV3IGZpeCAoZG8gd2UgbmVlZCBpdCBmb3Igc3RhYmxl
PykNCj4gDQo+IEkgZG9u4oCZdCBrbm93PyA6LSkNCj4gDQo+IEnigJlsbCBqdXN0IGFkZCB0aGUg
c3RhYmxlIHRhZyBmb3IgZ29vZCBtZWFzdXJlLCBJIHN1cHBvc2UgaXQgY2Fu4oCZdCBodXJ0Lg0K
PiANCj4+IDAyLDAzLDA1OiBhZGQgTWF4J3Mgci1iDQo+PiAwNDogZml4IGJpdG1hcCBoYW5kbGlu
Zw0KPj4gICAgICBpbXByb3ZlIGNvbW1lbnRzDQo+Pg0KPj4gVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSAoNSk6DQo+PiAgICBoYml0bWFwOiBoYW5kbGUgc2V0L3Jlc2V0IHdpdGggemVybyBs
ZW5ndGgNCj4+ICAgIGJsb2NrL21pcnJvcjogc2ltcGxpZnkgZG9fc3luY190YXJnZXRfd3JpdGUN
Cj4+ICAgIGJsb2NrL2Jsb2NrLWJhY2tlbmQ6IGFkZCBibGtfY29fcHdyaXRldl9wYXJ0DQo+PiAg
ICBibG9jay9taXJyb3I6IHN1cHBvcnQgdW5hbGlnbmVkIHdyaXRlIGluIGFjdGl2ZSBtaXJyb3IN
Cj4+ICAgIFJldmVydCAibWlycm9yOiBPbmx5IG1pcnJvciBncmFudWxhcml0eS1hbGlnbmVkIGNo
dW5rcyINCj4+DQo+PiAgIGluY2x1ZGUvc3lzZW11L2Jsb2NrLWJhY2tlbmQuaCB8ICAgNCArDQo+
PiAgIGJsb2NrL2Jsb2NrLWJhY2tlbmQuYyAgICAgICAgICB8ICAxNyArKystDQo+PiAgIGJsb2Nr
L21pcnJvci5jICAgICAgICAgICAgICAgICB8IDE4MSArKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0NCj4+ICAgdXRpbC9oYml0bWFwLmMgICAgICAgICAgICAgICAgIHwgICA4ICsrDQo+
PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTE0IGluc2VydGlvbnMoKyksIDk2IGRlbGV0aW9ucygtKQ0K
PiANCj4gVGhhbmtzLCBhcHBsaWVkIHRvIG15IGJsb2NrIGJyYW5jaDoNCj4gDQo+IGh0dHBzOi8v
Z2l0LnhhbmNsaWMubW9lL1hhbkNsaWMvcWVtdS9jb21taXRzL2JyYW5jaC9ibG9jaw0KPiANCj4g
TWF4DQo+IA0KDQpUaGFuayB5b3UhDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

