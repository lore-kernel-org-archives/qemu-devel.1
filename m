Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3DFECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD062089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T7dAPZjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD062089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9um-0007lh-5G
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iL9rB-0004W0-G0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iL9rA-0004Hg-1y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:46:37 -0400
Received: from mail-eopbgr00137.outbound.protection.outlook.com
 ([40.107.0.137]:6018 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iL9qx-0004FI-SY; Thu, 17 Oct 2019 13:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUwYoGEuazFcTX4vqoA+oXkXsD3LX+clIWVmadn7/pb1rSy/TeJ93fY5di80tosO4PncOw1s0mj1GSP8gB/2hD9vubelEWnluiiwuNAUO0JfLLNw8yCWknFrSXmHO9hb+WjM1N48qhJ8p+705wQV79MOxlP0FTX68S1eDwGAGTsJZb1YdDUUhBhA23v/C52DsW34kIRnR2rS1dV68sXaPC0i5n+uzu4/imob0Lkgue/l546kV146vL40v81agIXprb34kHGUZ5YjT/7TjwJxjEx96S4xUuJ1ad8jzFHzn0pspv0RCsbEXR5Ffw9nvhBXpoFPBOLwknGq/sbZbL3SIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPnlbbiIP8+SZ2SOhc50i5kokCD1pq/jTnYjIpEzA6c=;
 b=FXypQd2xbFAVDPWtcmOKihKsxt3JG1xDB3zr7m8/5DHhCB9Ug5gaq101pbrY9SguIBDPKDlWrplfyPO/MUftEq4vLczE/PcYlfNHpsYNsQjAdq6vsuJZvfnIBLBQc7t+F5zzn4vpWkS7P7kJ31cl+nyU7byHIAdWrUJjIBjvcedlP4Yd7EOI7auqwaxXcWlw9IbmEMO+/9rT3MNJE4PTHSNLLK7i8Dv9yZgM1xFzjyVY1Dt0WumZptX0GvwCZ361MEhVcvLZkhTBWT1kRNywmWdvMvmzUCF/vXDwtm8FHc9DZQ7bDN15LN7NfhpynaThUsEoft3gWIxvwe86W5Wr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPnlbbiIP8+SZ2SOhc50i5kokCD1pq/jTnYjIpEzA6c=;
 b=T7dAPZjMF/PFa0gPms3eCNIoGzlnJgEKWbYAP5TJEx1fJ7kiruA1p7fX8n8wvFGCr45kwVLRzgMkEJKQwyCKjBhYLAg9UJqLyfTltV3+rXt4yj+64FAKNo0/Z6y6ivD5fE0R39psOMOg7jramUTW8QXTLDGzX/qtNcUNAHWTOA0=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB4001.eurprd08.prod.outlook.com (20.178.118.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 17:46:15 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 17:46:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 4/4] tests/qemu-iotests: add case for block-stream
 compress
Thread-Topic: [PATCH v4 4/4] tests/qemu-iotests: add case for block-stream
 compress
Thread-Index: AQHVhD7XLKzHwcBXaUunuc7jAroBIadfHQoA
Date: Thu, 17 Oct 2019 17:46:14 +0000
Message-ID: <64430297-1b6c-e0fd-3584-270ae53ff342@virtuozzo.com>
References: <1571243333-882302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571243333-882302-5-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1571243333-882302-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0019.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::29) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191017204612424
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 039b785e-f767-44d3-e717-08d75329e800
x-ms-traffictypediagnostic: AM0PR08MB4001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4001FF1E04E6749D02018F68C16D0@AM0PR08MB4001.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(376002)(39850400004)(366004)(189003)(199004)(4326008)(26005)(2501003)(8676002)(76176011)(305945005)(52116002)(186003)(7736002)(2906002)(2201001)(3846002)(6116002)(31696002)(102836004)(66446008)(66946007)(8936002)(86362001)(386003)(6506007)(66476007)(64756008)(66556008)(99286004)(256004)(478600001)(5660300002)(31686004)(71190400001)(25786009)(14454004)(81156014)(81166006)(6246003)(71200400001)(66066001)(476003)(2616005)(6512007)(107886003)(54906003)(36756003)(110136005)(6486002)(6436002)(486006)(446003)(229853002)(316002)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4001;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0EJKBPN+k8mYlOkfSsDJHEg0Kwx38Js4TVz8hQ1KiytR5DBv3+tDxqqrPKgipTJIXxm+OXFjXXmEbuArII0R6VRvuiFaydLS0FfM0TmgWKvfS6fIir0+pwpgpZTeFEM1C29Lg+WLY3ONRGuAxBTTdU8u7kcc/12AZTp91gVG4A8sZwOp8BkYElW+ENb3Q1mnCX6dIZlIdxb5WAeyX/OihpFh/yP42tnVnXdAPFU7pDcLzPxRdcEgxElsofoo/GeMXTijGeqXbnFpm0oF7iB/Bh2MGVQUJg5c5HLOgWHD9rYiI03swx8bm58uSp+b6/CgheHMzR9Be4KzzvVDtRo6+mwuacpTgVjROp7VhsmLq16YWtpYbNNA5UzexPZXYhLl2ljKFg2Px85MEssNmH2EKKg7pSDq+bM5zrUzo2QOWo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB5034A4FD80194E8E1135E929EBB548@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039b785e-f767-44d3-e717-08d75329e800
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 17:46:14.8541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9i3fqyjJmxwVgUoWopq1gr6sDS8jSd39GuVFrM75kGO8X70c67SwmwfLGexeHUJ9bhpobXx+7cLbDHl7PiKwCCwN3fThupHsk0ZkQnuIc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4001
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.137
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMTAuMjAxOSAxOToyOCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IEFkZCBhIGNhc2Ug
dG8gdGhlIGlvdGVzdCAjMDMwIHRoYXQgdGVzdHMgdGhlICdjb21wcmVzcycgb3B0aW9uIGZvciBh
DQo+IGJsb2NrLXN0cmVhbSBqb2IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtl
dmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMv
cWVtdS1pb3Rlc3RzLzAzMCAgICAgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzAzMC5vdXQgfCAgNCArKy0t
DQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8wMzAgYi90ZXN0cy9xZW11LWlv
dGVzdHMvMDMwDQo+IGluZGV4IGYzNzY2ZjIuLmYwZjBlMjYgMTAwNzU1DQo+IC0tLSBhL3Rlc3Rz
L3FlbXUtaW90ZXN0cy8wMzANCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzAzMA0KPiBAQCAt
MjEsNyArMjEsOCBAQA0KPiAgIGltcG9ydCB0aW1lDQo+ICAgaW1wb3J0IG9zDQo+ICAgaW1wb3J0
IGlvdGVzdHMNCj4gLWZyb20gaW90ZXN0cyBpbXBvcnQgcWVtdV9pbWcsIHFlbXVfaW8NCj4gK2Zy
b20gaW90ZXN0cyBpbXBvcnQgcWVtdV9pbWcsIHFlbXVfaW8sIHFlbXVfaW1nX3BpcGUNCj4gK2lt
cG9ydCBqc29uDQo+ICAgDQo+ICAgYmFja2luZ19pbWcgPSBvcy5wYXRoLmpvaW4oaW90ZXN0cy50
ZXN0X2RpciwgJ2JhY2tpbmcuaW1nJykNCj4gICBtaWRfaW1nID0gb3MucGF0aC5qb2luKGlvdGVz
dHMudGVzdF9kaXIsICdtaWQuaW1nJykNCj4gQEAgLTk1Niw2ICs5NTcsNTQgQEAgY2xhc3MgVGVz
dFNldFNwZWVkKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAgIA0KPiAgICAgICAgICAgc2VsZi5j
YW5jZWxfYW5kX3dhaXQocmVzdW1lPVRydWUpDQo+ICAgDQo+ICtjbGFzcyBUZXN0Q29tcHJlc3Nl
ZChpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4gKyAgICB0ZXN0X2ltZ19pbml0X3NpemUgPSAwDQo+
ICsNCj4gKyAgICBkZWYgc2V0VXAoc2VsZik6DQo+ICsgICAgICAgIHFlbXVfaW1nKCdjcmVhdGUn
LCAnLWYnLCBpb3Rlc3RzLmltZ2ZtdCwgYmFja2luZ19pbWcsICcxTScpDQo+ICsgICAgICAgIHFl
bXVfaW1nKCdjcmVhdGUnLCAnLWYnLCBpb3Rlc3RzLmltZ2ZtdCwgJy1vJywNCj4gKyAgICAgICAg
ICAgICAgICAgJ2JhY2tpbmdfZmlsZT0lcycgJSBiYWNraW5nX2ltZywgbWlkX2ltZykNCj4gKyAg
ICAgICAgcWVtdV9pbWcoJ2NyZWF0ZScsICctZicsIGlvdGVzdHMuaW1nZm10LCAnLW8nLA0KPiAr
ICAgICAgICAgICAgICAgICAnYmFja2luZ19maWxlPSVzJyAlIG1pZF9pbWcsIHRlc3RfaW1nKQ0K
PiArICAgICAgICBxZW11X2lvKCctYycsICd3cml0ZSAtUCAweDEgMCA1MTJrJywgYmFja2luZ19p
bWcpDQo+ICsgICAgICAgIHRvcCA9IGpzb24ubG9hZHMocWVtdV9pbWdfcGlwZSgnaW5mbycsICct
LW91dHB1dD1qc29uJywgdGVzdF9pbWcpKQ0KPiArICAgICAgICBzZWxmLnRlc3RfaW1nX2luaXRf
c2l6ZSA9IHRvcFsnYWN0dWFsLXNpemUnXQ0KPiArICAgICAgICBzZWxmLnZtID0gaW90ZXN0cy5W
TSgpLmFkZF9kcml2ZSh0ZXN0X2ltZywgImJhY2tpbmcubm9kZS1uYW1lPW1pZCwiICsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImJhY2tpbmcuYmFja2luZy5u
b2RlLW5hbWU9YmFzZSwiICsNCg0KYmFzZSBub2RlLW5hbWUgaXMgdW51c2VkIGFjdHVhbGx5DQoN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImNvbXByZXNzPW9u
IikNCj4gKyAgICAgICAgc2VsZi52bS5sYXVuY2goKQ0KPiArDQo+ICsgICAgZGVmIHRlYXJEb3du
KHNlbGYpOg0KPiArICAgICAgICBzZWxmLnZtLnNodXRkb3duKCkNCj4gKyAgICAgICAgb3MucmVt
b3ZlKHRlc3RfaW1nKQ0KPiArICAgICAgICBvcy5yZW1vdmUobWlkX2ltZykNCj4gKyAgICAgICAg
b3MucmVtb3ZlKGJhY2tpbmdfaW1nKQ0KPiArDQo+ICsgICAgZGVmIHRlc3Rfc3RyZWFtX2NvbXBy
ZXNzKHNlbGYpOg0KPiArICAgICAgICBzZWxmLmFzc2VydF9ub19hY3RpdmVfYmxvY2tfam9icygp
DQo+ICsNCj4gKyAgICAgICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ2Jsb2NrLXN0cmVhbScsIGRl
dmljZT0nbWlkJywgam9iX2lkPSdzdHJlYW0tbWlkJykNCj4gKyAgICAgICAgc2VsZi5hc3NlcnRf
cW1wKHJlc3VsdCwgJ3JldHVybicsIHt9KQ0KPiArDQo+ICsgICAgICAgIHNlbGYud2FpdF91bnRp
bF9jb21wbGV0ZWQoZHJpdmU9J3N0cmVhbS1taWQnKQ0KPiArICAgICAgICAjIFJlbW92ZSBvdGhl
ciAnSk9CX1NUQVRVU19DSEFOR0UnIGV2ZW50cyBmb3IgdGhlIGpvYiAnc3RyZWFtLW1pZCcNCj4g
KyAgICAgICAgc2VsZi52bS5nZXRfcW1wX2V2ZW50cyh3YWl0PVRydWUpDQoNCkhtbSwgSSB0aGlu
ayBpdCdzIHVuc2FmZS4uIE9uZSBtb3JlIGV2ZW50IG1heSBiZSBzdGlsbCBpbiBwaXBlLi4uDQoN
CkkgdGhpbmssIGJldHRlciBpcyBqdXN0IGRvDQpzZWxmLnZtLndhaXRfZXZlbnQobmFtZT0nQkxP
Q0tfSk9CX0NPTVBMRVRFRCksIGFuZCBpZ25vcmUgSk9CX1NUQVRVU19DSEFOR0UgZXZlbnRzLg0K
DQo+ICsNCj4gKyAgICAgICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ2Jsb2NrLXN0cmVhbScsIGRl
dmljZT0nZHJpdmUwJywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgam9iX2lkPSdz
dHJlYW0tdG9wJykNCj4gKyAgICAgICAgc2VsZi5hc3NlcnRfcW1wKHJlc3VsdCwgJ3JldHVybics
IHt9KQ0KPiArDQo+ICsgICAgICAgIHNlbGYud2FpdF91bnRpbF9jb21wbGV0ZWQoZHJpdmU9J3N0
cmVhbS10b3AnKQ0KPiArICAgICAgICBzZWxmLnZtLnNodXRkb3duKCkNCj4gKw0KPiArICAgICAg
ICB0b3AgPSBqc29uLmxvYWRzKHFlbXVfaW1nX3BpcGUoJ2luZm8nLCAnLS1vdXRwdXQ9anNvbics
IHRlc3RfaW1nKSkNCj4gKyAgICAgICAgbWlkID0ganNvbi5sb2FkcyhxZW11X2ltZ19waXBlKCdp
bmZvJywgJy0tb3V0cHV0PWpzb24nLCBtaWRfaW1nKSkNCj4gKyAgICAgICAgYmFzZSA9IGpzb24u
bG9hZHMocWVtdV9pbWdfcGlwZSgnaW5mbycsICctLW91dHB1dD1qc29uJywgYmFja2luZ19pbWcp
KQ0KPiArDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0RXF1YWwobWlkWydhY3R1YWwtc2l6ZSddLCBi
YXNlWydhY3R1YWwtc2l6ZSddKQ0KPiArICAgICAgICBzZWxmLmFzc2VydExlc3ModG9wWydhY3R1
YWwtc2l6ZSddLCBtaWRbJ2FjdHVhbC1zaXplJ10pDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0TGVz
cyhzZWxmLnRlc3RfaW1nX2luaXRfc2l6ZSwgdG9wWydhY3R1YWwtc2l6ZSddKQ0KDQpJIHRoaW5r
IGxhc3QgYXNzZXJ0aW9uIGlzIGNvdmVyZWQgYnkgcHJldmlvdXMgdHdvLg0KDQpBbmQgSSdtIHN0
aWxsIHVuc3VyZSBhYm91dCB1c2luZyBhY3R1YWwtc2l6ZS4gRGlyZWN0IGNoZWNraW5nIG51bWJl
ciBvZiBjb21wcmVzc2VkDQpjbHVzdGVycyBieSBxZW11LWltZyBjaGVjayBtYXliZSBiZXR0ZXIu
DQoNCj4gKw0KPiAgIGlmIF9fbmFtZV9fID09ICdfX21haW5fXyc6DQo+ICAgICAgIGlvdGVzdHMu
bWFpbihzdXBwb3J0ZWRfZm10cz1bJ3Fjb3cyJywgJ3FlZCddLA0KPiAgICAgICAgICAgICAgICAg
ICAgc3VwcG9ydGVkX3Byb3RvY29scz1bJ2ZpbGUnXSkNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8wMzAub3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzAzMC5vdXQNCj4gaW5kZXgg
NmQ5YmVlMS4uYWY4ZGFjMSAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzAzMC5v
dXQNCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzAzMC5vdXQNCj4gQEAgLTEsNSArMSw1IEBA
DQo+IC0uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCj4gKy4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4NCj4gICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC1SYW4gMjcgdGVzdHMNCj4gK1JhbiAyOCB0
ZXN0cw0KPiAgIA0KPiAgIE9LDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==

