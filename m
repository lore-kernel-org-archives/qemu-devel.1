Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D45C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C2E20665
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oDNfCC4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C2E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIYq-00015L-8J
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBISw-0005tI-9a
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBISu-0006f9-Tb
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:56:50 -0400
Received: from mail-eopbgr150129.outbound.protection.outlook.com
 ([40.107.15.129]:15817 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBISu-0006ev-Ok; Fri, 20 Sep 2019 08:56:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4+X/ccDMGM/xa9QFeWlYEDkt0edNcddcH62klV4m80FHX7LqiwvSJZb9tbYcmJNU50AiyhT67PzKoPpZ6qyBJohZx5sgXAoCPFe/fzHul5VWTdy4v9UaRIvWKZbKgrt3Oljp5DjC8BaPNRGZHA88p5KENgU0qqivOLTs3Q8hXpdAMAFedbl/sPMOyqUxClwBkiMuzrfXsbdHJN3Y76Duu4hEi/LoWfYDPl8DXLCaJx2RxJqpVVop1FWg0a8WlW9Q8nZ/XFkPj9qu/VyNC7Xup5Kj2S0bv4s2JasgK5S2iQyEpfFyX6fyOB5Jfa+IjXcCgO024PMnkVHyOZiN0ksDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTIzADAuN0z/AyYOVmcRzAn4kGREmMFxaMNGGdZelsA=;
 b=JLtUmjlyekJ+m0M4SkP/xBaRtqSJcXhTJZmiwaE8hOnX4DrUskUCRtY1rcb3APg7Lu2u5HAhqRI4OVrT+8QDMv9FIOfYWFeOXXu34yI+hw54o/4bmHfPR4ozGhpCRrMmt8LdspNSpib99mkIW0RWwd+sN1GUEsRTAoKX5X+yInCjnE4beVwSw9LXJ28a8NaMhuE6sAW8KBNNLYWb7q8oSn4OLZvoT134Bc5onE+BQwJtlWnlRa8xr6JtqPWFVD91amtukJmeOOevf5tU0Cb40ghcasNBms7M4SVEwwqN2+Q81tqr0/QP+vO385XAU1PKl77k89d9Mcp+0rqqqhsCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTIzADAuN0z/AyYOVmcRzAn4kGREmMFxaMNGGdZelsA=;
 b=oDNfCC4zeXEKMqqMfr9u7uUrhSUdOYrSf9Rf+uOlrZEU0Ql95Yn/VkRUCXJ9exdXXqaCts+4Pfw9wbwSDYogRWDJ42boGUFs34aiX3xlH3N5wEcQl3j+OS/NR+PZ6Zqqkj+v2+dI6gXaGesu0/5urTfqEqfUkdVQZp3Bs1LUwBk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5401.eurprd08.prod.outlook.com (10.255.185.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 12:56:47 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 12:56:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v11 04/14] block/backup: introduce BlockCopyState
Thread-Topic: [PATCH v11 04/14] block/backup: introduce BlockCopyState
Thread-Index: AQHVZ8HWULZDkPZpMke6HdjhrfznqKcp8daAgAqhiQCAAAKhgIAAADEA
Date: Fri, 20 Sep 2019 12:56:47 +0000
Message-ID: <fbcb6733-b19f-e275-71cb-466238d8b193@virtuozzo.com>
References: <20190910102332.20560-1-vsementsov@virtuozzo.com>
 <20190910102332.20560-5-vsementsov@virtuozzo.com>
 <bafea6c6-38cc-1848-92ea-ec891457515a@virtuozzo.com>
 <bb798ca2-dd22-9ffe-de08-a4d0d8891f30@redhat.com>
 <abf4fdcc-2ca3-7ec5-93ff-95be6b480a5d@virtuozzo.com>
In-Reply-To: <abf4fdcc-2ca3-7ec5-93ff-95be6b480a5d@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0141.eurprd05.prod.outlook.com
 (2603:10a6:7:28::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920155644426
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a287d9b5-2f31-4df4-0702-08d73dc9fed5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5401; 
x-ms-traffictypediagnostic: DB8PR08MB5401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB54013A585007F987D83B81D6C1880@DB8PR08MB5401.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:96;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(346002)(376002)(39850400004)(189003)(199004)(446003)(8936002)(11346002)(486006)(2616005)(316002)(476003)(25786009)(81166006)(8676002)(76176011)(186003)(36756003)(81156014)(53546011)(386003)(99286004)(52116002)(31686004)(86362001)(7416002)(6506007)(102836004)(5660300002)(71190400001)(256004)(71200400001)(26005)(6436002)(14454004)(4326008)(478600001)(6486002)(2501003)(229853002)(64756008)(66946007)(66446008)(66556008)(66476007)(6512007)(54906003)(66066001)(110136005)(305945005)(7736002)(31696002)(2906002)(6116002)(107886003)(3846002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5401;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qAsVH0rRdg9xUGrGyZ/SglHqPAFAWiy03IW9GReFHk5kvp80BT8IbNu5DR97LAsPzMucItVbBVr58ymwSIJ0IFH7SEVjSbHTa9AqUOEFSDTvgnPlOieVzEPxyv5xKn5/EW1XOfhPINcsSEPn8wmdvnwko3g4To/NsrPZ0qkFt2pIggHvmCHr/amqzXCJtnFGaOZ6P9hnmZUhiKfLHfVKgpo1W+sCgaLXox8BtFBe0dSShaxLXTbaQBGwG6ayjInaLjcO49xElXSLrBL+6JNCcRdwSSIvAeBncbGBL0FrhFGf8gw8CHni1qBFyJYw0nRoMVn4IcXGKPnYPgDeXZfNRQCzXyBwP7ca9iKDo6qqsPG0sai2lQo3i8OsXc9ecv8rDqPyPYe8ydcN+Y4bm0cyD0KTLSN0li9XzAehGX8zBA8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5942A9FD644C940AFEE603DE4EA7433@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a287d9b5-2f31-4df4-0702-08d73dc9fed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 12:56:47.0610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZPsOOs2GBKN2xNjUGqnyaz7CfC/yXFu87HzOx5baPUUXT6a/Sh+Xfhssqfegx9jjzYtp35+Kzdf2PWuvYEvbZ/ecgJ/Q369exNTr/2P1vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.129
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
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxNTo1NiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjAuMDkuMjAxOSAxNTo0NiwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMTMuMDkuMTkgMjA6MjUs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMTAuMDkuMjAxOSAxMzoy
MywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gU3BsaXQgY29weWlu
ZyBjb2RlIHBhcnQgZnJvbSBiYWNrdXAgdG8gImJsb2NrLWNvcHkiLCBpbmNsdWRpbmcgc2VwYXJh
dGUNCj4+Pj4gc3RhdGUgc3RydWN0dXJlIGFuZCBmdW5jdGlvbiByZW5hbWluZy4gVGhpcyBpcyBu
ZWVkZWQgdG8gc2hhcmUgaXQgd2l0aA0KPj4+PiBiYWNrdXAtdG9wIGZpbHRlciBkcml2ZXIgaW4g
ZnVydGhlciBjb21taXRzLg0KPj4+Pg0KPj4+PiBOb3RlczoNCj4+Pj4NCj4+Pj4gMS4gQXMgQmxv
Y2tDb3B5U3RhdGUga2VlcHMgb3duIEJsb2NrQmFja2VuZCBvYmplY3RzLCByZW1haW5pbmcNCj4+
Pj4gam9iLT5jb21tb24uYmxrIHVzZXJzIG9ubHkgdXNlIGl0IHRvIGdldCBicyBieSBibGtfYnMo
KSBjYWxsLCBzbyBjbGVhcg0KPj4+PiBqb2ItPmNvbW1lbi5ibGsgcGVybWlzc2lvbnMgc2V0IGlu
IGJsb2NrX2pvYl9jcmVhdGUgYW5kIGFkZA0KPj4+PiBqb2ItPnNvdXJjZV9icyB0byBiZSB1c2Vk
IGluc3RlYWQgb2YgYmxrX2JzKGpvYi0+Y29tbW9uLmJsayksIHRvIGtlZXANCj4+Pj4gaXQgbW9y
ZSBjbGVhciB3aGljaCBicyB3ZSB1c2Ugd2hlbiBpbnRyb2R1Y2UgYmFja3VwLXRvcCBmaWx0ZXIg
aW4NCj4+Pj4gZnVydGhlciBjb21taXQuDQo+Pj4+DQo+Pj4+IDIuIFJlbmFtZSBzL2luaXRpYWxp
emluZ19iaXRtYXAvc2tpcF91bmFsbG9jYXRlZC8gdG8gc291bmQgYSBiaXQgYmV0dGVyDQo+Pj4+
IGFzIGludGVyZmFjZSB0byBCbG9ja0NvcHlTdGF0ZQ0KPj4+Pg0KPj4+PiAzLiBTcGxpdCBpcyBu
b3QgdmVyeSBjbGVhbjogdGhlcmUgbGVmdCBzb21lIGR1cGxpY2F0ZWQgZmllbGRzLCBiYWNrdXAN
Cj4+Pj4gY29kZSB1c2VzIHNvbWUgQmxvY2tDb3B5U3RhdGUgZmllbGRzIGRpcmVjdGx5LCBsZXQn
cyBwb3N0cG9uZSBpdCBmb3INCj4+Pj4gZnVydGhlciBpbXByb3ZlbWVudHMgYW5kIGtlZXAgdGhp
cyBjb21tZW50IHNpbXBsZXIgZm9yIHJldmlldy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0K
Pj4+PiAtLS0NCj4+Pg0KPj4+DQo+Pj4gWy4uXQ0KPj4+DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBC
bG9ja0NvcHlTdGF0ZSAqYmxvY2tfY29weV9zdGF0ZV9uZXcoDQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBCbG9ja0RyaXZlclN0YXRlICpzb3VyY2UsIEJsb2NrRHJpdmVyU3RhdGUgKnRhcmdldCwNCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgIGludDY0X3QgY2x1c3Rlcl9zaXplLCBCZHJ2UmVxdWVzdEZsYWdz
IHdyaXRlX2ZsYWdzLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgUHJvZ3Jlc3NCeXRlc0NhbGxiYWNr
RnVuYyBwcm9ncmVzc19ieXRlc19jYWxsYmFjaywNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFByb2dy
ZXNzUmVzZXRDYWxsYmFja0Z1bmMgcHJvZ3Jlc3NfcmVzZXRfY2FsbGJhY2ssDQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoCB2b2lkICpwcm9ncmVzc19vcGFxdWUsIEVycm9yICoqZXJycCkNCj4+Pj4gK3sN
Cj4+Pj4gK8KgwqDCoCBCbG9ja0NvcHlTdGF0ZSAqczsNCj4+Pj4gK8KgwqDCoCBpbnQgcmV0Ow0K
Pj4+PiArwqDCoMKgIHVpbnQ2NF90IG5vX3Jlc2l6ZSA9IEJMS19QRVJNX0NPTlNJU1RFTlRfUkVB
RCB8IEJMS19QRVJNX1dSSVRFIHwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBCTEtfUEVSTV9XUklURV9VTkNIQU5HRUQgfCBCTEtfUEVSTV9H
UkFQSF9NT0Q7DQo+Pj4+ICvCoMKgwqAgQmRydkRpcnR5Qml0bWFwICpjb3B5X2JpdG1hcDsNCj4+
Pj4gKw0KPj4+PiArwqDCoMKgIGNvcHlfYml0bWFwID0gYmRydl9jcmVhdGVfZGlydHlfYml0bWFw
KHNvdXJjZSwgY2x1c3Rlcl9zaXplLCBOVUxMLCBlcnJwKTsNCj4+Pj4gK8KgwqDCoCBpZiAoIWNv
cHlfYml0bWFwKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsNCj4+Pj4gK8Kg
wqDCoCB9DQo+Pj4+ICvCoMKgwqAgYmRydl9kaXNhYmxlX2RpcnR5X2JpdG1hcChjb3B5X2JpdG1h
cCk7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoCBzID0gZ19uZXcoQmxvY2tDb3B5U3RhdGUsIDEpOw0K
Pj4+PiArwqDCoMKgICpzID0gKEJsb2NrQ29weVN0YXRlKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCAuc291cmNlID0gYmxrX25ldyhiZHJ2X2dldF9haW9fY29udGV4dChzb3VyY2UpLA0KPj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQkxLX1BF
Uk1fQ09OU0lTVEVOVF9SRUFELCBub19yZXNpemUpLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgLnRh
cmdldCA9IGJsa19uZXcoYmRydl9nZXRfYWlvX2NvbnRleHQodGFyZ2V0KSwNCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJMS19QRVJNX1dS
SVRFLCBub19yZXNpemUpLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgLmNvcHlfYml0bWFwID0gY29w
eV9iaXRtYXAsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAuY2x1c3Rlcl9zaXplID0gY2x1c3Rlcl9z
aXplLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgLmxlbiA9IGJkcnZfZGlydHlfYml0bWFwX3NpemUo
Y29weV9iaXRtYXApLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgLndyaXRlX2ZsYWdzID0gd3JpdGVf
ZmxhZ3MsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAudXNlX2NvcHlfcmFuZ2UgPSAhKHdyaXRlX2Zs
YWdzICYgQkRSVl9SRVFfV1JJVEVfQ09NUFJFU1NFRCksDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAu
cHJvZ3Jlc3NfYnl0ZXNfY2FsbGJhY2sgPSBwcm9ncmVzc19ieXRlc19jYWxsYmFjaywNCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIC5wcm9ncmVzc19yZXNldF9jYWxsYmFjayA9IHByb2dyZXNzX3Jlc2V0
X2NhbGxiYWNrLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgLnByb2dyZXNzX29wYXF1ZSA9IHByb2dy
ZXNzX29wYXF1ZSwNCj4+Pj4gK8KgwqDCoCB9Ow0KPj4+PiArDQo+Pj4+ICvCoMKgwqAgcy0+Y29w
eV9yYW5nZV9zaXplID0gUUVNVV9BTElHTl9VUChNSU4oYmxrX2dldF9tYXhfdHJhbnNmZXIocy0+
c291cmNlKSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBibGtfZ2V0X21heF90
cmFuc2ZlcihzLT50YXJnZXQpKSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+Y2x1c3Rl
cl9zaXplKTsNCj4+Pg0KPj4+IHByZWV4aXN0ZW50LCBidXQgaXQgb2J2aW91c2x5IHNob3VsZCBi
ZSBRRU1VX0FMSUdOX0RPV04uIEkgY2FuIHJlc2VuZCB3aXRoIGEgc2VwYXJhdGUNCj4+PiBmaXgs
IGl0IG1heSBiZSBmaXhlZCB3aGlsZSBxdWV1aW5nIChpZiByZXNlbmQgaXMgbm90IG5lZWRlZCBm
b3Igb3RoZXIgcmVhc29ucykgb3INCj4+PiBJJ2xsIHNlbmQgYSBmb2xsb3ctdXAgZml4IGxhdGVy
LCB3aGljaGV2ZXIgeW91IHByZWZlci4NCj4+DQo+PiBIbSwgdHJ1ZS7CoCBCdXQgdGhlbiB3ZeKA
mWxsIGFsc28gbmVlZCB0byBoYW5kbGUgdGhlICh1bmxpa2VseSwgYWRtaXR0ZWRseSkNCj4+IGNh
c2Ugd2hlcmUgbWF4X3RyYW5zZmVyIDwgY2x1c3Rlcl9zaXplIHNvIHRoaXMgd291bGQgdGhlbiBy
ZXR1cm4gMCAoYnkNCj4+IHNldHRpbmcgdXNlX2NvcHlfcmFuZ2UgPSBmYWxzZSkuwqAgU28gaG93
IGFib3V0IHRoaXM6DQo+IA0KPiBEb25lIGluIFtQQVRDSCB2MTIgMC8yXSBiYWNrdXA6IGNvcHlf
cmFuZ2UgZml4ZXMuDQo+IElmIGl0IGlzIGNvbnZlbmllbnQgSSdsbCByZWJhc2UgdGhlc2Ugc2Vy
aWVzIG9uICJbUEFUQ0ggdjEyIDAvMl0gYmFja3VwOiBjb3B5X3JhbmdlIGZpeGVzIg0KPiANCg0K
T3IgdmljZSB2ZXJzYQ0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

