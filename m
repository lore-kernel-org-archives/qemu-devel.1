Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56805C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4A420716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KXkis0b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4A420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjcR-0000Kb-9J
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iwjbV-0008K0-EI
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iwjbU-0006fc-5d
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:25:45 -0500
Received: from mail-eopbgr70133.outbound.protection.outlook.com
 ([40.107.7.133]:3297 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iwjbT-0006de-21; Wed, 29 Jan 2020 04:25:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwnRcCPdU+Q0zPVYvi2cQ9aNdBgMHbjTqinXKqxy7P7CiUak0KRQ9mYZAKUU3mXu7gglIhGHzB7qLmuW5plu5MLg2shTzmcyu3UvT4e1FHgnJtQ7gaTTwiTed4H4wGcn082qJ+4OQSQguT9wPVHDCtrMxt7LWUy9vtqak+mPnUu+pvBBeufetblk20UVb79uZHxg1s673/ImgOZXwJI4VP+SdBlzUQhlRFw25TUFLtfcxkW0g8XyEimGvqMz8DsDNYYgCipCShj2GzDceCL/Itb1swTonVXKaBF9ROD/lZ4bZFo7hBJlTwd5NyykSbrCfubJAeXJgK23nDwU4l0ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqzIjEckj18iBx/57KNfjU4EKeKIMhdlIlhLsmFtfpk=;
 b=DmvkRh2qw+4XBAVpKG53HFj0k+lIliqvGNCIQtHBgmQQXSNrIWWiBckN9dauDFj7hKsK6vfF8x1OYmhSE6RJvVxANYFT+uBXfn4dCip8L8T9fwl6aZIQrHyrjnhSHOgcOG6tAMC+bBnVIkSVr9KjAsv5Ea/2PVERNBhXwTIynCc43gWnLruJAVBtuHi9FyxgawFWWGr0+lrcDQj/JCl4F+7keVHH/glTZLl6E1ld66NrGg6ql07v2j7J5C3FnSJSCOmKlVyGMfYq6PxRzjH5ncoUejIoG4x7dpoFlpMWfrQl2b+Z6llHEd+YQ7kxrFYSbgyPaug0+ILgJkasQ56rrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqzIjEckj18iBx/57KNfjU4EKeKIMhdlIlhLsmFtfpk=;
 b=KXkis0b/5nVobn2otLxC83yOMsKIDYgxl/vIK5wVtYpZj/roS5Uv8lGhN9VVmVtE7CDh6I273qhUKVf9rBvtFAneqWPGb95xPczwBBunuMuVRRYcFccf8AS+cgFfm1Y+secF8jJKpX+Wse2vehwrDXxXKszWgrvIG//hS0iRN0A=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3624.eurprd08.prod.outlook.com (20.177.116.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Wed, 29 Jan 2020 09:25:40 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 09:25:40 +0000
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Wed, 29 Jan 2020 09:25:39 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 3/7] block/block-copy: factor out
 block_copy_find_inflight_req
Thread-Topic: [PATCH v2 3/7] block/block-copy: factor out
 block_copy_find_inflight_req
Thread-Index: AQHVpVDT/cLeZd0kvEmd2pRRTGbj0agBwX+A
Date: Wed, 29 Jan 2020 09:25:40 +0000
Message-ID: <4619fb86-8788-dd49-84d9-5313e0ccd4d8@virtuozzo.com>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-4-vsementsov@virtuozzo.com>
In-Reply-To: <20191127180840.11937-4-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::16)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70a4886d-a4f0-4454-2985-08d7a49d34d9
x-ms-traffictypediagnostic: AM6PR08MB3624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB362480D1DF2D3F4243E9D0D7F4050@AM6PR08MB3624.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(366004)(39850400004)(136003)(189003)(199004)(54906003)(44832011)(110136005)(36756003)(8936002)(8676002)(6666004)(86362001)(478600001)(81166006)(2906002)(31686004)(81156014)(71200400001)(64756008)(66446008)(66556008)(66476007)(316002)(16576012)(66946007)(31696002)(53546011)(26005)(186003)(16526019)(4326008)(2616005)(956004)(5660300002)(6486002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3624;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6r3vdKU54fLOLRhfwMb/eOi0IwrFYMJ5uiCgOsfvUzCrLwRACkLNTvEg+HJjyzy0ez28cD/db9Qr8Ba5Nq/Izig4mqxIreFtKNx7duD1zfbODt68+r2sLaCiR265rD/4fwg81FshUdubLh5kwGTgm3Ar7C7QGmFXEqJkWQhsCQNCyYrpbAvMCTBFbnKIowaJ2k14HnyLGTRQbWZt7SFU4i60lLWnoHt27HhUu4U1iLhL6aoUlAPLYByjwKshFiHW3XVmL+Ux3hvUX5X0cAFfQavSGYeu4KW3n43Bdz1RvOUW0yd2tppvFy01dWP1Xv8Ryq7wmhjcPDIYDC9aQIjxu3hcS6i9DtWpifs6+j+dVqPZCA6XcRGngz1R3J0BCn1iB0EaUPruIcLXyW7HLFPBP0/ToWbXn26393jvD4Ixh+u6T/jTUCkS1hwg66GLBquY
x-ms-exchange-antispam-messagedata: uPVtdENXfQ9VJo88S2TsBX46SgZ1PwKKerQoqhMgsLhR1x20J0YNqwKMEjW/6x+RxKRRRAwlaEqEHCMa6pp30wrP5qu/yJdXDT4NKTmK8+2Hb3xg2pubyE/aPMkpFZc9F4tlcKAs6Xkt2PttWZFkQA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <931C5CD75AC7144789BCD360F31BF415@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a4886d-a4f0-4454-2985-08d7a49d34d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 09:25:40.0891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aRsnsDAUHa+vmWM2oT2KLF9H0RqtFakzgwg7llQLgwm1RlHk1gH9nsCweVCT487NznAX/vSOd+tGabT6TcD7nOoqH8VHTMUkkpIDrEUvAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3624
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.133
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI3LzExLzIwMTkgMjE6MDgsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IFNwbGl0IGJsb2NrX2NvcHlfZmluZF9pbmZsaWdodF9yZXEgdG8gYmUgdXNlZCBpbiBz
ZXByYXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPiAtLS0NCj4gICBibG9jay9ibG9jay1jb3B5
LmMgfCAzMSArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDE5IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2Jsb2NrL2Jsb2NrLWNvcHkuYyBiL2Jsb2NrL2Jsb2NrLWNvcHkuYw0KPiBpbmRleCA3NDI5NWQ5
M2Q1Li45NGU3ZTg1NWVmIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibG9jay1jb3B5LmMNCj4gKysr
IGIvYmxvY2svYmxvY2stY29weS5jDQo+IEBAIC0yNCwyMyArMjQsMzAgQEANCj4gICAjZGVmaW5l
IEJMT0NLX0NPUFlfTUFYX0JVRkZFUiAoMSAqIE1pQikNCj4gICAjZGVmaW5lIEJMT0NLX0NPUFlf
TUFYX01FTSAoMTI4ICogTWlCKQ0KPiAgIA0KPiArc3RhdGljIEJsb2NrQ29weUluRmxpZ2h0UmVx
ICpibG9ja19jb3B5X2ZpbmRfaW5mbGlnaHRfcmVxKEJsb2NrQ29weVN0YXRlICpzLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlu
dDY0X3Qgc3RhcnQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW50NjRfdCBlbmQpDQo+ICt7DQo+ICsgICAgQmxvY2tDb3B5SW5G
bGlnaHRSZXEgKnJlcTsNCj4gKw0KPiArICAgIFFMSVNUX0ZPUkVBQ0gocmVxLCAmcy0+aW5mbGln
aHRfcmVxcywgbGlzdCkgew0KPiArICAgICAgICBpZiAoZW5kID4gcmVxLT5zdGFydF9ieXRlICYm
IHN0YXJ0IDwgcmVxLT5lbmRfYnl0ZSkgew0KPiArICAgICAgICAgICAgcmV0dXJuIHJlcTsNCj4g
KyAgICAgICAgfQ0KPiArICAgIH0NCj4gKw0KPiArICAgIHJldHVybiBOVUxMOw0KPiArfQ0KPiAr
DQo+ICAgc3RhdGljIHZvaWQgY29yb3V0aW5lX2ZuIGJsb2NrX2NvcHlfd2FpdF9pbmZsaWdodF9y
ZXFzKEJsb2NrQ29weVN0YXRlICpzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IHN0YXJ0LA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IGVuZCkN
Cj4gICB7DQo+ICAgICAgIEJsb2NrQ29weUluRmxpZ2h0UmVxICpyZXE7DQo+IC0gICAgYm9vbCB3
YWl0ZWQ7DQo+IC0NCj4gLSAgICBkbyB7DQo+IC0gICAgICAgIHdhaXRlZCA9IGZhbHNlOw0KPiAt
ICAgICAgICBRTElTVF9GT1JFQUNIKHJlcSwgJnMtPmluZmxpZ2h0X3JlcXMsIGxpc3QpIHsNCj4g
LSAgICAgICAgICAgIGlmIChlbmQgPiByZXEtPnN0YXJ0X2J5dGUgJiYgc3RhcnQgPCByZXEtPmVu
ZF9ieXRlKSB7DQo+IC0gICAgICAgICAgICAgICAgcWVtdV9jb19xdWV1ZV93YWl0KCZyZXEtPndh
aXRfcXVldWUsIE5VTEwpOw0KPiAtICAgICAgICAgICAgICAgIHdhaXRlZCA9IHRydWU7DQo+IC0g
ICAgICAgICAgICAgICAgYnJlYWs7DQo+IC0gICAgICAgICAgICB9DQo+IC0gICAgICAgIH0NCj4g
LSAgICB9IHdoaWxlICh3YWl0ZWQpOw0KPiArDQo+ICsgICAgd2hpbGUgKChyZXEgPSBibG9ja19j
b3B5X2ZpbmRfaW5mbGlnaHRfcmVxKHMsIHN0YXJ0LCBlbmQpKSkgew0KPiArICAgICAgICBxZW11
X2NvX3F1ZXVlX3dhaXQoJnJlcS0+d2FpdF9xdWV1ZSwgTlVMTCk7DQo+ICsgICAgfQ0KPiAgIH0N
Cj4gICANCj4gICBzdGF0aWMgdm9pZCBibG9ja19jb3B5X2luZmxpZ2h0X3JlcV9iZWdpbihCbG9j
a0NvcHlTdGF0ZSAqcywNCj4gDQoNClJldmlld2VkLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5k
cmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRz
LA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

