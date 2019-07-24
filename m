Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D70EC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A91B21BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YtT833sG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A91B21BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqDzC-0003Bl-F8
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 05:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53568)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqDyz-0002ha-AJ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqDyx-0003w1-R5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:54:49 -0400
Received: from mail-eopbgr150107.outbound.protection.outlook.com
 ([40.107.15.107]:46966 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqDyx-0003vQ-LO; Wed, 24 Jul 2019 05:54:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ9b7kxDa53GP7jyIurwWIloGl4e6uj2Xy8xm4ER0I5GwKCiIzRIcprVtql/vUmr33qw8H6AxmND2+UnFqpMsdNH/ZTTp3G+GgMaj/Qq/FZC7WI3rZJ5k+iRxUX/JH+iqiI2RnFqBVPmIPSw4NFbBOKPV2WVf59ib4DAXyGAnEjkx2Ab9IhiXuyRqCxkP6TrPNVhqzK7kAoZIJ0u4nLuHJmg0tvg/YKuidMJFqkX1AFlXAVRpGFY6KxdLqjZJ9z50pAvEHFmEq9muXkCXNlmFkylIMQTVNtVK9bOWdOMdeCtEUJfLQZcSwKcnipuyEqKa80rVDJUaX+EWzOxT6DIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rkGWq8G28wlamZxdixjqKw/nzG3xOLaPW+qeh97z0k=;
 b=aRoq/ZWOsS8EJFdNZPPXCiSAnNZw9HVxqfQVIqbenNmbnTuICRVG5JC3YHWgdGc2mPWnGKJ3AxlrLBySZGW8E9eHWxUosd68vjtBoCSdu2tix3RhzDXOX8WZ2lRMkrD1h/GW8j0DqK3+Uf5Zn8jP9JUQuNBzKsbWIP27kEXitKAs5R4RpEmOV2LoB1XfFTYy4X9PMDqT1iF83vobRU2NgKlHHQOkS5FY4gyGKnMEXLahKKzWY3ukFJAHPPYtUCYBx+OZuB8hp8VD9LO9UmlPWQwrvFFMWro0jlcEmjdRcW26SXwtQ4Clr/Q0DEmKNh1XoBBKiI8rK5TZoPOhsMT8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rkGWq8G28wlamZxdixjqKw/nzG3xOLaPW+qeh97z0k=;
 b=YtT833sGvO+QymuPlG/luqYDyMCjigOZ/Mg/nlx1/UX+EIVPbek9HIU8d1tw+m0Daj3eWVjlZMI6tkXflEFX5eOxThB7aCJgdDy4iODNd2Xc+W3FfhlgZPNPCVcCYoRtxTknxBTQyray7taeyx5+AzHULYpbLqGxxSxkqq3t0NQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3931.eurprd08.prod.outlook.com (20.179.10.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 24 Jul 2019 09:54:46 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Wed, 24 Jul 2019
 09:54:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 33/42] blockdev: Fix active commit choice
Thread-Index: AQHVIWvMnB+nkUgz2kCIZe++5LqMP6aiwJeAgABsYgCAAvn0AIAzod2A
Date: Wed, 24 Jul 2019 09:54:45 +0000
Message-ID: <92803acf-9b06-0aa3-d96d-bdcf65fe27b1@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-34-mreitz@redhat.com>
 <2670e61d-6c9b-9499-8e41-01c294379e47@virtuozzo.com>
 <761c245d-3bb3-5fb3-21e4-0085caaffd2a@redhat.com>
 <72c0be9e-cff6-1c6d-3f9b-d257d92a8cc6@virtuozzo.com>
In-Reply-To: <72c0be9e-cff6-1c6d-3f9b-d257d92a8cc6@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0046.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190724125443868
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69904a50-72df-4d00-f6d7-08d7101cf547
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3931; 
x-ms-traffictypediagnostic: DB8PR08MB3931:
x-microsoft-antispam-prvs: <DB8PR08MB39314F13C939B5EB84C81D1DC1C60@DB8PR08MB3931.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(346002)(366004)(136003)(199004)(189003)(478600001)(446003)(53546011)(11346002)(26005)(14454004)(229853002)(316002)(8676002)(2616005)(5660300002)(256004)(2501003)(6116002)(486006)(6486002)(25786009)(110136005)(3846002)(14444005)(31696002)(305945005)(6512007)(54906003)(6436002)(7736002)(99286004)(476003)(68736007)(53936002)(4326008)(66476007)(31686004)(66446008)(66556008)(6246003)(86362001)(81166006)(36756003)(81156014)(76176011)(2906002)(8936002)(102836004)(52116002)(186003)(64756008)(71190400001)(66946007)(71200400001)(66066001)(386003)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3931;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3uhmZiaCxq/FT7sazo9ULRygK3iQD5TWkjYKRq+t6KJXP9pqxU+eMDbCpsvl9boACTMVs0lqxNKPza9Ie5V9P9NWOq57FIP0oz0MsrkuX5mAECl7OPIwBa/yOqtbTmRFhe1tg1/zM9yNV31m6ldQfnuJtqrihkgkh34vprSlMmoQwLv6LjiVEkegeeor33CRQAspz3DlWEtfDZ+TvS5MOv3VZSsVD6w6fWqFx/0WjruYziEpplBuZCwVwCel/Cq/w3AeQOOqqO8gmRHBnEorE1UTPvMwJy3O8wXPbjqs1Xmp/von1Bddbd57Aku1ecRCt+C7vwz17gBRvnm6WTYE5wc5sdl9dovuqZIRjGu4xqwOIUlF88sq87kqtL5SdwLvuYMJxv9IHS1elkmtl2lG/JLvBWMUNvVMXAPfP2+xMmI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E7A97894698D141AEA3C6D73008F0F1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69904a50-72df-4d00-f6d7-08d7101cf547
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 09:54:45.8659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3931
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.107
Subject: Re: [Qemu-devel] [PATCH v5 33/42] blockdev: Fix active commit choice
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

MjEuMDYuMjAxOSAxNjoyNiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTkuMDYuMjAxOSAxODo1OSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMTkuMDYuMTkgMTE6MzEs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMTMuMDYuMjAxOSAxOjA5
LCBNYXggUmVpdHogd3JvdGU6DQo+Pj4+IFdlIGhhdmUgdG8gcGVyZm9ybSBhbiBhY3RpdmUgY29t
bWl0IHdoZW5ldmVyIHRoZSB0b3Agbm9kZSBoYXMgYSBwYXJlbnQNCj4+Pj4gdGhhdCBoYXMgdGFr
ZW4gdGhlIFdSSVRFIHBlcm1pc3Npb24gb24gaXQuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiDCoMKgIGJsb2Nr
ZGV2LmMgfCAyNCArKysrKysrKysrKysrKysrKysrKystLS0NCj4+Pj4gwqDCoCAxIGZpbGUgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAt
LWdpdCBhL2Jsb2NrZGV2LmMgYi9ibG9ja2Rldi5jDQo+Pj4+IGluZGV4IGE0NjRjYWJmOWUuLjUz
NzBmM2I3MzggMTAwNjQ0DQo+Pj4+IC0tLSBhL2Jsb2NrZGV2LmMNCj4+Pj4gKysrIGIvYmxvY2tk
ZXYuYw0KPj4+PiBAQCAtMzI5NCw2ICszMjk0LDcgQEAgdm9pZCBxbXBfYmxvY2tfY29tbWl0KGJv
b2wgaGFzX2pvYl9pZCwgY29uc3QgY2hhciAqam9iX2lkLCBjb25zdCBjaGFyICpkZXZpY2UsDQo+
Pj4+IMKgwqDCoMKgwqDCoMKgICovDQo+Pj4+IMKgwqDCoMKgwqDCoCBCbG9ja2Rldk9uRXJyb3Ig
b25fZXJyb3IgPSBCTE9DS0RFVl9PTl9FUlJPUl9SRVBPUlQ7DQo+Pj4+IMKgwqDCoMKgwqDCoCBp
bnQgam9iX2ZsYWdzID0gSk9CX0RFRkFVTFQ7DQo+Pj4+ICvCoMKgwqAgdWludDY0X3QgdG9wX3Bl
cm0sIHRvcF9zaGFyZWQ7DQo+Pj4+IMKgwqDCoMKgwqDCoCBpZiAoIWhhc19zcGVlZCkgew0KPj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGVlZCA9IDA7DQo+Pj4+IEBAIC0zNDA2LDE0ICszNDA3
LDMxIEBAIHZvaWQgcW1wX2Jsb2NrX2NvbW1pdChib29sIGhhc19qb2JfaWQsIGNvbnN0IGNoYXIg
KmpvYl9pZCwgY29uc3QgY2hhciAqZGV2aWNlLA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBn
b3RvIG91dDsNCj4+Pj4gwqDCoMKgwqDCoMKgIH0NCj4+Pj4gLcKgwqDCoCBpZiAodG9wX2JzID09
IGJzKSB7DQo+Pj4+ICvCoMKgwqAgLyoNCj4+Pj4gK8KgwqDCoMKgICogQWN0aXZlIGNvbW1pdCBp
cyByZXF1aXJlZCBpZiBhbmQgb25seSBpZiBzb21lb25lIGhhcyB0YWtlbiBhDQo+Pj4+ICvCoMKg
wqDCoCAqIFdSSVRFIHBlcm1pc3Npb24gb24gdGhlIHRvcCBub2RlLsKgIEhpc3RvcmljYWxseSwg
d2UgaGF2ZSBhbHdheXMNCj4+Pj4gK8KgwqDCoMKgICogdXNlZCBhY3RpdmUgY29tbWl0IGZvciB0
b3Agbm9kZXMsIHNvIGNvbnRpbnVlIHRoYXQgcHJhY3RpY2UuDQo+Pj4+ICvCoMKgwqDCoCAqIChB
Y3RpdmUgY29tbWl0IGlzIG5ldmVyIHJlYWxseSB3cm9uZy4pDQo+Pj4NCj4+PiBIbW0sIGlmIHdl
IHN0YXJ0IGFjdGl2ZSBjb21taXQgd2hlbiBub2JvZHkgaGFzIHdyaXRlIGFjY2VzcywgdGhhbg0K
Pj4+IHdlIGxlYXZlIGEgcG9zc2liaWxpdHkgdG8gc29tZW9uZSB0byBnZXQgdGhpcyBhY2Nlc3Mg
ZHVyaW5nIGNvbW1pdC4NCj4+DQo+PiBJc27igJl0IHRoYXQgYmxvY2tlZCBieSB0aGUgY29tbWl0
IGZpbHRlcj/CoCBJZiBpdCBpc27igJl0LCBpdCBzaG91bGQgYmUuDQo+Pg0KPj4+IEFuZCBkdXJp
bmcNCj4+PiBwYXNzaXZlIGNvbW1pdCB3cml0ZSBhY2Nlc3MgaXMgYmxvY2tlZC4gU28sIG1heSBi
ZSByaWdodCB3YXkgaXMgZG8gYWN0aXZlIGNvbW1pdA0KPj4+IGFsd2F5cz8gQmVuZWZpdHM6DQo+
Pj4gMS4gT25lIGNvZGUgcGF0aC4gYW5kIGl0IHNob3VsZG4ndCBiZSB3b3JzZSB3aGVuIG5vIHdy
aXRlcnMsIHdpdGhvdXQgZ3Vlc3Qgd3JpdGVzDQo+Pj4gbWlycm9yIGNvZGUgc2hvdWxkbid0IHdv
cmsgd29yc2UgdGhhbiBwYXNzaXZlIGNvbW1pdCwgaWYgaXQgaXMsIGl0IHNob3VsZCBiZSBmaXhl
ZC4NCj4+PiAyLiBQb3NzaWJpbGl0eSBvZiB3cml0ZSBhY2Nlc3MgaWYgdXNlciBuZWVkcyBpdCBk
dXJpbmcgY29tbWl0DQo+Pj4gMy4gSSdtIHN1cmUgdGhhdCBhY3RpdmUgY29tbWl0IChtaXJyb3Ig
Y29kZSkgYWN0dWFsbHkgd29ya3MgZmFzdGVyLCBhcyBpdCB1c2VzDQo+Pj4gYXN5bmMgcmVxdWVz
dHMgYW5kIHNtYXJ0ZXIgaGFuZGxpbmcgb2YgYmxvY2sgc3RhdHVzLg0KPj4NCj4+IERpc2FkdmFu
dGFnZTogU29tZXRoaW5nIG1heSBicmVhayBiZWNhdXNlIHRoZSBiYXNpYyBjb21taXQgam9iIGRv
ZXMgbm90DQo+PiBlbWl0IEJMT0NLX0pPQl9SRUFEWSBhbmQgdGh1cyBkb2VzIG5vdCByZXF1aXJl
IGJsb2NrLWpvYi1jb21wbGV0ZS4NCj4+DQo+PiBUZWNobmljYWxseSBldmVyeXRoaW5nIHNob3Vs
ZCBleHBlY3Qgam9icyB0byBwb3RlbnRpYWxseSBlbWl0DQo+PiBCTE9DS19KT0JfUkVBRFksIGJ1
dCB3aG8ga25vd3MuwqAgSSB0aGluayB3ZeKAmWQgd2FudCBhdCBsZWFzdCBhDQo+PiBkZXByZWNh
dGlvbiBwZXJpb2QuDQo+Pg0KPj4gTWF4DQo+IA0KPiBPSywgc28gdGhpcyBpcyBmb3IgZnV0dXJl
Li4gVGhlbjoNCj4gDQo+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNClN0cmFuZ2UsIEkgaGF2ZSB0aGlzIG1haWwg
YXV0b21hdGljYWxseSByZXR1cm5lZCBiYWNrLiBEaWQgeW91IHJlY2VpdmUgaXQ/DQoNCj4gDQo+
Pg0KPj4+PiArwqDCoMKgwqAgKi8NCj4+Pj4gK8KgwqDCoCBiZHJ2X2dldF9jdW11bGF0aXZlX3Bl
cm0odG9wX2JzLCAmdG9wX3Blcm0sICZ0b3Bfc2hhcmVkKTsNCj4+Pj4gK8KgwqDCoCBpZiAodG9w
X3Blcm0gJiBCTEtfUEVSTV9XUklURSB8fA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgYmRydl9za2lw
X3J3X2ZpbHRlcnModG9wX2JzKSA9PSBiZHJ2X3NraXBfcndfZmlsdGVycyhicykpDQo+Pj4+ICvC
oMKgwqAgew0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaGFzX2JhY2tpbmdfZmlsZSkg
ew0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3NldGcoZXJycCwgIidi
YWNraW5nLWZpbGUnIHNwZWNpZmllZCwiDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIgYnV0ICd0b3AnIGlzIHRoZSBh
Y3RpdmUgbGF5ZXIiKTsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91
dDsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgY29t
bWl0X2FjdGl2ZV9zdGFydChoYXNfam9iX2lkID8gam9iX2lkIDogTlVMTCwgYnMsIGJhc2VfYnMs
DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgam9iX2ZsYWdzLCBzcGVlZCwgb25fZXJyb3IsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAoIWhhc19qb2JfaWQpIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoNCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIEVtdWxhdGUgaGVyZSB3aGF0IGJsb2NrX2pvYl9j
cmVhdGUoKSBkb2VzLCBiZWNhdXNlIGl0DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KiBpcyBwb3NzaWJsZSB0aGF0IEBicyAhPSBAdG9wX2JzICh0aGUgYmxvY2sgam9iIHNob3VsZA0K
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYmUgbmFtZWQgYWZ0ZXIgQGJzLCBldmVu
IGlmIEB0b3BfYnMgaXMgdGhlIGFjdHVhbA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogc291cmNlKQ0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGpvYl9pZCA9IGJkcnZfZ2V0X2RldmljZV9uYW1lKGJzKTsNCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGNvbW1pdF9hY3RpdmVf
c3RhcnQoam9iX2lkLCB0b3BfYnMsIGJhc2VfYnMsIGpvYl9mbGFncywgc3BlZWQsIG9uX2Vycm9y
LA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZmlsdGVyX25vZGVfbmFtZSwgTlVMTCwgTlVMTCwgZmFsc2UsICZsb2NhbF9l
cnIpOw0KPj4+PiDCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqAgQmxvY2tEcml2ZXJTdGF0ZSAqb3ZlcmxheV9icyA9IGJkcnZfZmluZF9vdmVybGF5KGJzLCB0
b3BfYnMpOw0KPj4+Pg0KPj4+DQo+Pj4NCj4+DQo+Pg0KPiANCj4gDQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K

