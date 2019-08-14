Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF5FC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3282083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ShlkY1gA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3282083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxvmU-00056B-KD
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 12:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxvkx-0003DW-Ke
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxvkv-0003Hm-7n
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:04:10 -0400
Received: from mail-eopbgr00123.outbound.protection.outlook.com
 ([40.107.0.123]:48859 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxvku-0003Gt-Mk; Wed, 14 Aug 2019 12:04:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccOtYW5zrd42ZFDPO/wiMLAgrkeJa/j60TLWYOR7U//G5pigDmVUUE2GCjsAnF2HkrK6denEbgxTjyfYlkctttlvnMd38ZVIrOzm9paVOvbuFPFesLKvOWJS6tAl6zcJHfVDcDtPKFyxCyQITLi6chGD01975EuPUqBYBacbmq6el6/KK5GK0Y5TmQJw9MmBsuTsQVApjDHfgLJN4xIRAYE2RMRQ10tI781nvKHkvbgKPQnovLGfS8fIT6jmTSdGDg+Uou9ydMCa5KCFPJl44HJnigCEqiA45THbEXSLYFUzTTzhBvAEZ+riccUJaX7dzSgSk02BLiB53Ohx0t/kXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bChvIVpqvl6olR+NkU0vUR8IxKSbeSdtAsKuBQyfxT4=;
 b=lzg6ys9ScVjz2PcZMk668qxkg6PQFRdwHcrHBSvK0FbANv8dCW051AMzuxV54Wc5Pr1vDMFT1ZNOQp5tk0+I1RVJ+TcTmQ+6BojWECddu3a+fRgoDC1w7IMXvF9E7YvZD+hJM6AbEnIJNUFOqXxBFwOK+UVhXwXAtu3lM7GGLgY6mVDL9lkU6dPyt3RNI8EPHH3OZ+jEUEOSv2q+hKr3oAbx8YDVRe1zbqVIztripymARCj9+L3BJ/nfWJ5k2R7ElWi6iC+R1z0vhSmNXlvEHQUL+2P8RsxbzlkZLR0hDdjyx2cx2m7DLAxRH6rEcMKh87CtaBPZje6evVlLpmiMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bChvIVpqvl6olR+NkU0vUR8IxKSbeSdtAsKuBQyfxT4=;
 b=ShlkY1gADx2xAQONy68I5obdPvomp6rkWRnX0F56PpX8h5B0fPFa8HmKW8HDyiQ6Yb7W8VFZj2IpnjKTFO3Z/MOa+mpaAyK3oAIUK3DNST23sUdcEFU9ya68Q8G8Iet3IqASpk20KHXQpy7/mk/AbcNpkRWEvQ7ZmcKVRI5f7w8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5212.eurprd08.prod.outlook.com (20.179.15.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Wed, 14 Aug 2019 16:04:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 16:04:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 30/42] qemu-img: Use child access functions
Thread-Index: AQHVTs2mPQbLcZ69wUy4Q/V/qX6mnab61i4A
Date: Wed, 14 Aug 2019 16:04:06 +0000
Message-ID: <ba7a8a5a-8df4-4765-f1f9-4ce4582582f4@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-31-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-31-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0045.eurprd09.prod.outlook.com
 (2603:10a6:7:15::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190814190404411
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f338af82-a213-43fb-97c3-08d720d108ca
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5212; 
x-ms-traffictypediagnostic: DB8PR08MB5212:
x-microsoft-antispam-prvs: <DB8PR08MB521273EC29FDCC5F46C619BDC1AD0@DB8PR08MB5212.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:309;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(376002)(396003)(136003)(346002)(189003)(199004)(6506007)(71190400001)(316002)(305945005)(26005)(86362001)(2501003)(66066001)(102836004)(386003)(478600001)(186003)(7736002)(71200400001)(31686004)(99286004)(14454004)(31696002)(76176011)(52116002)(8936002)(6512007)(5660300002)(66946007)(256004)(54906003)(6246003)(4326008)(476003)(53936002)(66556008)(110136005)(64756008)(2616005)(66446008)(6486002)(81166006)(2906002)(6436002)(25786009)(81156014)(36756003)(446003)(66476007)(229853002)(486006)(6116002)(8676002)(3846002)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5212;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kUS2tCCmW8z+xZ8KUheLm8fzDIPYnGqnRH8RUD2AeM9Vn5gZ0NH197peR7D8zlGEedmNKmqelonz/+fAmVkZ7OFuT3v0W1Je/NNKlDkSKqwz4gNDCOR9trW9+3lAy0pynL8T/hEARb5vgk582oKY7+t4E19XkNw8BLsTbWCc697725sNtdSMp6ODiNmseneBBTz12/QVrDe1X8MNSge1izBcfnfiduawtVY3DqJRyOGrTmCVitBzj5juHqJC4o0sWu1WsM/XB1q/ldm1to/+DOw/tbUuE5BzI0CA1T4RzxiBNVw5egHHuuMwXsunFrYen0LWy2aBQdMp32iNhuV98Efkez0zds0SVTiwJT4pX07yoM1U1Y/e3nlOQIio8JXjm4/xO9zvYPLNy1Fh0rL9d+Q/nuQQWd89qLkLW/mOHrs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <85D5A2DAFD58FB499C166004766EE420@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f338af82-a213-43fb-97c3-08d720d108ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 16:04:06.4773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzYhuUPjEjALkupfRdAL0oQlMrZBTSn7XOF6PMBiyQY1MKSMefEkHiuXZYgji/ZajAIf5XAT15YpMjSCtTy86cK7IGJNWAGRvaVnu8xUBO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5212
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.123
Subject: Re: [Qemu-devel] [PATCH v6 30/42] qemu-img: Use child access
 functions
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

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIGNoYW5nZXMgaW90ZXN0
IDIwNCdzIG91dHB1dCwgYmVjYXVzZSBibGtkZWJ1ZyBvbiB0b3Agb2YgYSBDT1cgbm9kZQ0KPiB1
c2VkIHRvIG1ha2UgcWVtdS1pbWcgbWFwIGRpc3JlZ2FyZCB0aGUgcmVzdCBvZiB0aGUgYmFja2lu
ZyBjaGFpbiAodGhlDQo+IGJhY2tpbmcgY2hhaW4gd2FzIGJyb2tlbiBieSB0aGUgZmlsdGVyKS4g
IFdpdGggdGhpcyBwYXRjaCwgdGhlDQo+IGFsbG9jYXRpb24gaW4gdGhlIGJhc2UgaW1hZ2UgaXMg
cmVwb3J0ZWQgY29ycmVjdGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVp
dHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgcWVtdS1pbWcuYyAgICAgICAgICAgICAgICAgfCAz
MyArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVz
dHMvMjA0Lm91dCB8ICAxICsNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyks
IDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3FlbXUtaW1nLmMgYi9xZW11LWlt
Zy5jDQo+IGluZGV4IDc5OTgzNzcyZGUuLjNiMzBjNWFlNzAgMTAwNjQ0DQo+IC0tLSBhL3FlbXUt
aW1nLmMNCj4gKysrIGIvcWVtdS1pbWcuYw0KPiBAQCAtMTAxMiw3ICsxMDEyLDcgQEAgc3RhdGlj
IGludCBpbWdfY29tbWl0KGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gICAgICAgICAgIC8qIFRo
aXMgaXMgZGlmZmVyZW50IGZyb20gUU1QLCB3aGljaCBieSBkZWZhdWx0IHVzZXMgdGhlIGRlZXBl
c3QgZmlsZSBpbg0KPiAgICAgICAgICAgICogdGhlIGJhY2tpbmcgY2hhaW4gKGkuZS4sIHRoZSB2
ZXJ5IGJhc2UpOyBob3dldmVyLCB0aGUgdHJhZGl0aW9uYWwNCj4gICAgICAgICAgICAqIGJlaGF2
aW9yIG9mIHFlbXUtaW1nIGNvbW1pdCBpcyB1c2luZyB0aGUgaW1tZWRpYXRlIGJhY2tpbmcgZmls
ZS4gKi8NCj4gLSAgICAgICAgYmFzZV9icyA9IGJhY2tpbmdfYnMoYnMpOw0KPiArICAgICAgICBi
YXNlX2JzID0gYmRydl9iYWNraW5nX2NoYWluX25leHQoYnMpOw0KPiAgICAgICAgICAgaWYgKCFi
YXNlX2JzKSB7DQo+ICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZygmbG9jYWxfZXJyLCAiSW1hZ2Ug
ZG9lcyBub3QgaGF2ZSBhIGJhY2tpbmcgZmlsZSIpOw0KPiAgICAgICAgICAgICAgIGdvdG8gZG9u
ZTsNCj4gQEAgLTE2MzIsMTggKzE2MzIsMjAgQEAgc3RhdGljIGludCBjb252ZXJ0X2l0ZXJhdGlv
bl9zZWN0b3JzKEltZ0NvbnZlcnRTdGF0ZSAqcywgaW50NjRfdCBzZWN0b3JfbnVtKQ0KPiAgICAg
ICBpZiAocy0+c2VjdG9yX25leHRfc3RhdHVzIDw9IHNlY3Rvcl9udW0pIHsNCj4gICAgICAgICAg
IHVpbnQ2NF90IG9mZnNldCA9IChzZWN0b3JfbnVtIC0gc3JjX2N1cl9vZmZzZXQpICogQkRSVl9T
RUNUT1JfU0laRTsNCj4gICAgICAgICAgIGludDY0X3QgY291bnQ7DQo+ICsgICAgICAgIEJsb2Nr
RHJpdmVyU3RhdGUgKnNyY19icyA9IGJsa19icyhzLT5zcmNbc3JjX2N1cl0pOw0KPiArICAgICAg
ICBCbG9ja0RyaXZlclN0YXRlICpiYXNlOw0KPiArDQo+ICsgICAgICAgIGlmIChzLT50YXJnZXRf
aGFzX2JhY2tpbmcpIHsNCj4gKyAgICAgICAgICAgIGJhc2UgPSBiZHJ2X2ZpbHRlcmVkX2Nvd19i
cyhiZHJ2X3NraXBfcndfZmlsdGVycyhzcmNfYnMpKTsNCj4gKyAgICAgICAgfSBlbHNlIHsNCj4g
KyAgICAgICAgICAgIGJhc2UgPSBOVUxMOw0KPiArICAgICAgICB9DQo+ICAgDQo+ICAgICAgICAg
ICBkbyB7DQo+ICAgICAgICAgICAgICAgY291bnQgPSBuICogQkRSVl9TRUNUT1JfU0laRTsNCj4g
ICANCj4gLSAgICAgICAgICAgIGlmIChzLT50YXJnZXRfaGFzX2JhY2tpbmcpIHsNCj4gLSAgICAg
ICAgICAgICAgICByZXQgPSBiZHJ2X2Jsb2NrX3N0YXR1cyhibGtfYnMocy0+c3JjW3NyY19jdXJd
KSwgb2Zmc2V0LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
dW50LCAmY291bnQsIE5VTEwsIE5VTEwpOw0KPiAtICAgICAgICAgICAgfSBlbHNlIHsNCj4gLSAg
ICAgICAgICAgICAgICByZXQgPSBiZHJ2X2Jsb2NrX3N0YXR1c19hYm92ZShibGtfYnMocy0+c3Jj
W3NyY19jdXJdKSwgTlVMTCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBvZmZzZXQsIGNvdW50LCAmY291bnQsIE5VTEwsDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7DQo+IC0gICAgICAgICAgICB9
DQo+ICsgICAgICAgICAgICByZXQgPSBiZHJ2X2Jsb2NrX3N0YXR1c19hYm92ZShzcmNfYnMsIGJh
c2UsIG9mZnNldCwgY291bnQsICZjb3VudCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwpOw0KPiAgIA0KPiAgICAgICAgICAgICAgIGlmIChy
ZXQgPCAwKSB7DQo+ICAgICAgICAgICAgICAgICAgIGlmIChzLT5zYWx2YWdlKSB7DQo+IEBAIC0y
NDkwLDcgKzI0OTIsOCBAQCBzdGF0aWMgaW50IGltZ19jb252ZXJ0KGludCBhcmdjLCBjaGFyICoq
YXJndikNCj4gICAgICAgICAgICAqIHMudGFyZ2V0X2JhY2tpbmdfc2VjdG9ycyBoYXMgdG8gYmUg
bmVnYXRpdmUsIHdoaWNoIGl0IHdpbGwNCj4gICAgICAgICAgICAqIGJlIGF1dG9tYXRpY2FsbHkp
LiAgVGhlIGJhY2tpbmcgZmlsZSBsZW5ndGggaXMgdXNlZCBvbmx5DQo+ICAgICAgICAgICAgKiBm
b3Igb3B0aW1pemF0aW9ucywgc28gc3VjaCBhIGNhc2UgaXMgbm90IGZhdGFsLiAqLw0KPiAtICAg
ICAgICBzLnRhcmdldF9iYWNraW5nX3NlY3RvcnMgPSBiZHJ2X25iX3NlY3RvcnMob3V0X2JzLT5i
YWNraW5nLT5icyk7DQo+ICsgICAgICAgIHMudGFyZ2V0X2JhY2tpbmdfc2VjdG9ycyA9DQo+ICsg
ICAgICAgICAgICBiZHJ2X25iX3NlY3RvcnMoYmRydl9maWx0ZXJlZF9jb3dfYnMob3V0X2JzKSk7
DQoNCmJkcnZfbmJfc2VjdG9ycyhiZHJ2X2JhY2tpbmdfY2hhaW5fbmV4dChvdXRfYnMpKQ0KDQo+
ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICBzLnRhcmdldF9iYWNraW5nX3NlY3RvcnMgPSAt
MTsNCj4gICAgICAgfQ0KPiBAQCAtMjg1Myw2ICsyODU2LDcgQEAgc3RhdGljIGludCBnZXRfYmxv
Y2tfc3RhdHVzKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBpbnQ2NF90IG9mZnNldCwNCj4gICANCj4g
ICAgICAgZGVwdGggPSAwOw0KPiAgICAgICBmb3IgKDs7KSB7DQo+ICsgICAgICAgIGJzID0gYmRy
dl9za2lwX3J3X2ZpbHRlcnMoYnMpOw0KPiAgICAgICAgICAgcmV0ID0gYmRydl9ibG9ja19zdGF0
dXMoYnMsIG9mZnNldCwgYnl0ZXMsICZieXRlcywgJm1hcCwgJmZpbGUpOw0KPiAgICAgICAgICAg
aWYgKHJldCA8IDApIHsNCj4gICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiBAQCAtMjg2MSw3
ICsyODY1LDcgQEAgc3RhdGljIGludCBnZXRfYmxvY2tfc3RhdHVzKEJsb2NrRHJpdmVyU3RhdGUg
KmJzLCBpbnQ2NF90IG9mZnNldCwNCj4gICAgICAgICAgIGlmIChyZXQgJiAoQkRSVl9CTE9DS19a
RVJPfEJEUlZfQkxPQ0tfREFUQSkpIHsNCj4gICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAg
ICAgIH0NCj4gLSAgICAgICAgYnMgPSBiYWNraW5nX2JzKGJzKTsNCj4gKyAgICAgICAgYnMgPSBi
ZHJ2X2ZpbHRlcmVkX2Nvd19icyhicyk7DQo+ICAgICAgICAgICBpZiAoYnMgPT0gTlVMTCkgew0K
PiAgICAgICAgICAgICAgIHJldCA9IDA7DQo+ICAgICAgICAgICAgICAgYnJlYWs7DQo+IEBAIC0z
MjE2LDYgKzMyMjAsNyBAQCBzdGF0aWMgaW50IGltZ19yZWJhc2UoaW50IGFyZ2MsIGNoYXIgKiph
cmd2KQ0KPiAgICAgICB1aW50OF90ICpidWZfb2xkID0gTlVMTDsNCj4gICAgICAgdWludDhfdCAq
YnVmX25ldyA9IE5VTEw7DQo+ICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJzID0gTlVMTCwgKnBy
ZWZpeF9jaGFpbl9icyA9IE5VTEw7DQo+ICsgICAgQmxvY2tEcml2ZXJTdGF0ZSAqdW5maWx0ZXJl
ZF9iczsNCj4gICAgICAgY2hhciAqZmlsZW5hbWU7DQo+ICAgICAgIGNvbnN0IGNoYXIgKmZtdCwg
KmNhY2hlLCAqc3JjX2NhY2hlLCAqb3V0X2Jhc2VmbXQsICpvdXRfYmFzZWltZzsNCj4gICAgICAg
aW50IGMsIGZsYWdzLCBzcmNfZmxhZ3MsIHJldDsNCj4gQEAgLTMzNTAsNiArMzM1NSw4IEBAIHN0
YXRpYyBpbnQgaW1nX3JlYmFzZShpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICAgICAgIH0NCj4g
ICAgICAgYnMgPSBibGtfYnMoYmxrKTsNCj4gICANCj4gKyAgICB1bmZpbHRlcmVkX2JzID0gYmRy
dl9za2lwX3J3X2ZpbHRlcnMoYnMpOw0KPiArDQo+ICAgICAgIGlmIChvdXRfYmFzZWZtdCAhPSBO
VUxMKSB7DQo+ICAgICAgICAgICBpZiAoYmRydl9maW5kX2Zvcm1hdChvdXRfYmFzZWZtdCkgPT0g
TlVMTCkgew0KPiAgICAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiSW52YWxpZCBmb3JtYXQgbmFt
ZTogJyVzJyIsIG91dF9iYXNlZm10KTsNCj4gQEAgLTMzNjEsNyArMzM2OCw3IEBAIHN0YXRpYyBp
bnQgaW1nX3JlYmFzZShpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICAgICAgIC8qIEZvciBzYWZl
IHJlYmFzaW5nIHdlIG5lZWQgdG8gY29tcGFyZSBvbGQgYW5kIG5ldyBiYWNraW5nIGZpbGUgKi8N
Cj4gICAgICAgaWYgKCF1bnNhZmUpIHsNCj4gICAgICAgICAgIFFEaWN0ICpvcHRpb25zID0gTlVM
TDsNCj4gLSAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYmFzZV9icyA9IGJhY2tpbmdfYnMoYnMp
Ow0KPiArICAgICAgICBCbG9ja0RyaXZlclN0YXRlICpiYXNlX2JzID0gYmRydl9maWx0ZXJlZF9j
b3dfYnModW5maWx0ZXJlZF9icyk7DQo+ICAgDQo+ICAgICAgICAgICBpZiAoYmFzZV9icykgew0K
PiAgICAgICAgICAgICAgIGJsa19vbGRfYmFja2luZyA9IGJsa19uZXcocWVtdV9nZXRfYWlvX2Nv
bnRleHQoKSwNCj4gQEAgLTM1MTcsNyArMzUyNCw3IEBAIHN0YXRpYyBpbnQgaW1nX3JlYmFzZShp
bnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICAgICAgICAgICAgICAgICAgICAqIElmIGNsdXN0ZXIg
d2Fzbid0IGNoYW5nZWQgc2luY2UgcHJlZml4X2NoYWluLCB3ZSBkb24ndCBuZWVkDQo+ICAgICAg
ICAgICAgICAgICAgICAqIHRvIHRha2UgYWN0aW9uDQo+ICAgICAgICAgICAgICAgICAgICAqLw0K
PiAtICAgICAgICAgICAgICAgIHJldCA9IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlKGJhY2tpbmdf
YnMoYnMpLCBwcmVmaXhfY2hhaW5fYnMsDQo+ICsgICAgICAgICAgICAgICAgcmV0ID0gYmRydl9p
c19hbGxvY2F0ZWRfYWJvdmUodW5maWx0ZXJlZF9icywgcHJlZml4X2NoYWluX2JzLA0KDQpzL3Vu
ZmlsdGVyZWRfYnMvYmRydl9maWx0ZXJlZF9jb3dfYnModW5maWx0ZXJlZF9icykvDQoNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmFsc2UsIG9mZnNl
dCwgbiwgJm4pOw0KPiAgICAgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPiAgICAgICAg
ICAgICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJlcnJvciB3aGlsZSByZWFkaW5nIGltYWdlIG1l
dGFkYXRhOiAlcyIsDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMjA0Lm91dCBi
L3Rlc3RzL3FlbXUtaW90ZXN0cy8yMDQub3V0DQo+IGluZGV4IGYzYTEwZmJlOTAuLjY4NDc3NGQ3
NjMgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yMDQub3V0DQo+ICsrKyBiL3Rl
c3RzL3FlbXUtaW90ZXN0cy8yMDQub3V0DQo+IEBAIC01OSw1ICs1OSw2IEBAIE9mZnNldCAgICAg
ICAgICBMZW5ndGggICAgICAgICAgRmlsZQ0KPiAgIDB4OTAwMDAwICAgICAgICAweDI0MDAwMDAg
ICAgICAgVEVTVF9ESVIvdC5JTUdGTVQNCj4gICAweDNjMDAwMDAgICAgICAgMHgxMTAwMDAwICAg
ICAgIFRFU1RfRElSL3QuSU1HRk1UDQo+ICAgMHg2YTAwMDAwICAgICAgIDB4NDAwMDAwICAgICAg
ICBURVNUX0RJUi90LklNR0ZNVA0KPiArMHg2ZTAwMDAwICAgICAgIDB4MTIwMDAwMCAgICAgICBU
RVNUX0RJUi90LklNR0ZNVC5iYXNlDQo+ICAgTm8gZXJyb3JzIHdlcmUgZm91bmQgb24gdGhlIGlt
YWdlLg0KPiAgICoqKiBkb25lDQo+IA0KDQpXaXRoIHR3byBmaXhlczoNClJldmlld2VkLWJ5OiBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

