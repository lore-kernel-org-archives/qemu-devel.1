Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03138C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A2B23429
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mLd/WFYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A2B23429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3lQs-0005lq-Pc
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 14:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3lMl-00040d-7E
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3lMi-0000mP-VK
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:11:19 -0400
Received: from mail-eopbgr150115.outbound.protection.outlook.com
 ([40.107.15.115]:48548 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3lMb-0000MB-Ob; Fri, 30 Aug 2019 14:11:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjoj7UZj+aZHELq67VfluxlytDjet1+jU1RAczcWgHHV/H42o/mAZ6Y/jUgPII5+O+IlsuabrL5m8zN5K8p+U/P2XcybSFASag9+ZulbXdxTjTSWppu+c8w3mt0cp593cywOScQT3Z1wpgd9OFE29fAOGV1YEnYdxhuQZnH7qkQz8DhohkKUvbULMo9j3CDxSIm+YCVxHyZ5H7rAZsc9hTjMd8SCqQOIEqx6c7tyEqXs5VlyeSNqBpRDgapDNGiYj0A9I24i1cOJ1VwAoLNSfHtDf2BvDR49I+iB6ccQp3cgku69aQ9smQauiO4wz5vycXof3uHGm0oRnJ8NRa2EHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esVz9WS71hnkqClMpJMxRB4ZlrRcCkRRVwbsY5O5Fgk=;
 b=f6gr4RZuhiVSFXMhRWtn897a4JclChX5hunVdV1OTnR7kPpArpCrX3EjJbxcqBQvCu9kxDGSfFv3qrSJ1PVJ2F5bC4h95p4pB+ZqFi6zrJMjAUSmmtJKvUS2/aQzcH7glD5fPu+NgHBD1DjcwTRnYYTGgZ7ORQPoMfXTDZnZfijU4IuJ/btADQpsk2OaAikrSJlYmAoZyOA9iHjifx75Xff2t9osjj5FhSCQ4WgU/Qt0+5JMpJqfbfROMJ3m1JM6V05NquJRyMPghKuOrA8aU6GhveH/8q9SNtAWHl22nw0H/GVgxkXd8CcG2v3iN77W9UalkcK/C8bkKx2tOSs0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esVz9WS71hnkqClMpJMxRB4ZlrRcCkRRVwbsY5O5Fgk=;
 b=mLd/WFYjRwfsD4Nr2KcID2odSMiPsntNyC308UgfNTDTIr67FXItpEMkxItjULEjxA+2rZccdAEk49TmWydJulSBrjHBQSoTKqy+LuO4OvCr2nb5oxLwSeHFJ4xSrjicw752cwOS3FN0GCvwHwFoiKr0YGg4UgwVGCgeTFqBSoo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5370.eurprd08.prod.outlook.com (52.133.240.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 18:11:04 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 18:11:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/5] nbd: Implement client use of NBD
 FAST_ZERO
Thread-Index: AQHVWcIJJKnc7e4DxUeQDIdpxc9A66cUCQuA
Date: Fri, 30 Aug 2019 18:11:03 +0000
Message-ID: <8dc987a5-ec87-faa6-1e86-d7c3573694f7@virtuozzo.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <20190823143726.27062-4-eblake@redhat.com>
In-Reply-To: <20190823143726.27062-4-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0154.eurprd05.prod.outlook.com
 (2603:10a6:7:28::41) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190830211101167
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbf0afab-ad97-4281-28c8-08d72d756bb2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5370; 
x-ms-traffictypediagnostic: DB8PR08MB5370:
x-microsoft-antispam-prvs: <DB8PR08MB5370272EAE0C59F3D067357AC1BD0@DB8PR08MB5370.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39840400004)(199004)(189003)(4326008)(64756008)(66476007)(14454004)(81156014)(81166006)(8676002)(316002)(6512007)(86362001)(36756003)(31696002)(305945005)(52116002)(6116002)(6486002)(110136005)(66066001)(54906003)(6436002)(99286004)(7736002)(3846002)(2906002)(8936002)(26005)(53936002)(76176011)(2616005)(25786009)(446003)(71200400001)(478600001)(256004)(14444005)(6246003)(71190400001)(102836004)(486006)(66446008)(31686004)(66946007)(229853002)(5660300002)(2501003)(6506007)(476003)(11346002)(66556008)(186003)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5370;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hipa0Y5icjTuV9ZDgN0WZQBsrarf1P+O1TY9G4zsGj0l3jTjvXtT1vbC4KZW7pQsEqlUOKLg12BiwH3qTuqxZjHKH6vURwhNBtGDIHE38f0WlfOJw0ULstZfIQPw2ojkg/OTUc+VIrYmvLg9WABtbGU3iRqVC71Tb0efDqpwv5prDX3/+f7VQ+K3uBp65BlOpciDbQzX13gsnPwgIc6wc/QJzusVaCp+5b6N5IUMYeu4WnTY6LqOko3uFv2tjepukmltJXWjQFQ0rKqK1O8IYBOci+6cRgM2gaYquCR9JQC7LNTu6zOH/ZqNrC4tlQFufyt7skXvbxZdwmh4LwHnZ2aXtAjyf/ieA7uPXy9FKGkVfOANkruV4dkXM7sbaoiDov1+u0npVzY/hk3bbtOvKLt44E2EXSrJxY45oOZ+eeA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2A6E9ACAACAFF4CB954CFA3E19D6CF3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf0afab-ad97-4281-28c8-08d72d756bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:11:03.9587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrPx/zgnO49UXk2wzS6hWWHhAmlvvr0aEyiVgxXlsdbzcxyMSNPTf/IudE17GbLCjziSa+KLptjJX4wDtTs+DZ/YAfELSnXzBvibQjcPpXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5370
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.115
Subject: Re: [Qemu-devel] [PATCH 3/5] nbd: Implement client use of NBD
 FAST_ZERO
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
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>, "open
 list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMDguMjAxOSAxNzozNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gVGhlIGNsaWVudCBzaWRlIGlz
IGZhaXJseSBzdHJhaWdodGZvcndhcmQ6IGlmIHRoZSBzZXJ2ZXIgYWR2ZXJ0aXNlZA0KPiBmYXN0
IHplcm8gc3VwcG9ydCwgdGhlbiB3ZSBjYW4gbWFwIHRoYXQgdG8gQkRSVl9SRVFfTk9fRkFMTEJB
Q0sNCj4gc3VwcG9ydC4gIEEgc2VydmVyIHRoYXQgYWR2ZXJ0aXNlcyBGQVNUX1pFUk8gYnV0IG5v
dCBXUklURV9aRVJPRVMNCj4gaXMgdGVjaG5pY2FsbHkgYnJva2VuLCBidXQgd2UgY2FuIGlnbm9y
ZSB0aGF0IHNpdHVhdGlvbiBhcyBpdCBkb2VzDQo+IG5vdCBjaGFuZ2Ugb3VyIGJlaGF2aW9yLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQoNClJl
dmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQoNCj4gDQo+IC0tLQ0KPiANCj4gUGVyaGFwcyB0aGlzIGlzIHdvcnRoIG1lcmdp
bmcgd2l0aCB0aGUgcHJldmlvdXMgcGF0Y2guDQo+IC0tLQ0KPiAgIGJsb2NrL25iZC5jIHwgNyAr
KysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2Jsb2NrL25iZC5jIGIvYmxvY2svbmJkLmMNCj4gaW5kZXggYmVlZDQ2ZmIzNDE0Li44
MzM5ZDcxMDYzNjYgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL25iZC5jDQo+ICsrKyBiL2Jsb2NrL25i
ZC5jDQo+IEBAIC0xMDQ0LDYgKzEwNDQsMTAgQEAgc3RhdGljIGludCBuYmRfY2xpZW50X2NvX3B3
cml0ZV96ZXJvZXMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGludDY0X3Qgb2Zmc2V0LA0KPiAgICAg
ICBpZiAoIShmbGFncyAmIEJEUlZfUkVRX01BWV9VTk1BUCkpIHsNCj4gICAgICAgICAgIHJlcXVl
c3QuZmxhZ3MgfD0gTkJEX0NNRF9GTEFHX05PX0hPTEU7DQo+ICAgICAgIH0NCj4gKyAgICBpZiAo
ZmxhZ3MgJiBCRFJWX1JFUV9OT19GQUxMQkFDSykgew0KPiArICAgICAgICBhc3NlcnQocy0+aW5m
by5mbGFncyAmIE5CRF9GTEFHX1NFTkRfRkFTVF9aRVJPKTsNCj4gKyAgICAgICAgcmVxdWVzdC5m
bGFncyB8PSBOQkRfQ01EX0ZMQUdfRkFTVF9aRVJPOw0KPiArICAgIH0NCj4gDQo+ICAgICAgIGlm
ICghYnl0ZXMpIHsNCj4gICAgICAgICAgIHJldHVybiAwOw0KPiBAQCAtMTIzOSw2ICsxMjQzLDkg
QEAgc3RhdGljIGludCBuYmRfY2xpZW50X2Nvbm5lY3QoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEVy
cm9yICoqZXJycCkNCj4gICAgICAgfQ0KPiAgICAgICBpZiAocy0+aW5mby5mbGFncyAmIE5CRF9G
TEFHX1NFTkRfV1JJVEVfWkVST0VTKSB7DQo+ICAgICAgICAgICBicy0+c3VwcG9ydGVkX3plcm9f
ZmxhZ3MgfD0gQkRSVl9SRVFfTUFZX1VOTUFQOw0KPiArICAgICAgICBpZiAocy0+aW5mby5mbGFn
cyAmIE5CRF9GTEFHX1NFTkRfRkFTVF9aRVJPKSB7DQo+ICsgICAgICAgICAgICBicy0+c3VwcG9y
dGVkX3plcm9fZmxhZ3MgfD0gQkRSVl9SRVFfTk9fRkFMTEJBQ0s7DQo+ICsgICAgICAgIH0NCj4g
ICAgICAgfQ0KPiANCj4gICAgICAgcy0+c2lvYyA9IHNpb2M7DQo+IA0KDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

