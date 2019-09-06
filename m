Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F490C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE1E206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TKBptu/h";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RhOjnwrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE1E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Gx8-0002Wb-SH
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=145f821d7=Dmitry.Fomichev@wdc.com>)
 id 1i6GvO-0001Jn-7A
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=145f821d7=Dmitry.Fomichev@wdc.com>)
 id 1i6GvN-00020M-0B
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:17:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11727)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=145f821d7=Dmitry.Fomichev@wdc.com>)
 id 1i6GvG-0001qI-Kd; Fri, 06 Sep 2019 12:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567786639; x=1599322639;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TSe4q44y2xdyxYIqN2Gk4CEFYJvqTOUgbS/3jpinGaA=;
 b=TKBptu/h3HD1qT/rF7qEz4wHnD4kOJZZmubU6t0gxTHMcx7GAPzMobIw
 +bj72u79LpxWlnlvJwZ1o6SnuY4H6xCKmI8xAXOsOoutaOF8pBn1oaLaG
 MwlxHDjAmLWTrRopq3GbMfaI7P/Q31BerOuPXgPvDsLRVE1FQAAzhdTfy
 vYY0mvBJdfpfIbGkwZTW9EMgm+8NMxlPxt9zQ3b9sDyHaBOHaROaSsRLT
 nvHgAvVFgLtgGbU7yB14qA18TG1ODujA1qd8pZB3xsKOSAk7wiZ/zYDiv
 y62ndey3P3Q5vhZhoZFGqF9Pz5EKSMF63ivKRihogQ12w5TuDlk5zMZk1 g==;
IronPort-SDR: wsDxnHw33pA1CMBMExWf+45sKXbIVDvd/XUMYrX5IpFvIb8pN+sMMDM6B2iocWFb8inDk0LaH4
 ye2Ogy6wktKCC4TuXZaTYMuLIuzPNEMYHJUtrV/szhAccToS5Eg+XQtzpFfPRG6iU8qzcaX9qW
 5jH05dC/BLJIaH6yqfFOImY5aflBzYw8SjrAteyNBvPpHGi3S23d9bO7azbbKJ/YL6qPTaDy8/
 WW2/XFgPPAMpDv8yyxumjoyOVysVay7b2sw/RBI8QSBHWW32aiTYW4l2kluJCHOS5hfwAPa+m+
 2Es=
X-IronPort-AV: E=Sophos;i="5.64,473,1559491200"; d="scan'208";a="117677453"
Received: from mail-by2nam05lp2050.outbound.protection.outlook.com (HELO
 NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.50])
 by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2019 00:17:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMmm5W8DV6oJiv8+sGOCU8g8X4nD41+V4Ykg2y34IKcsa/5NOAs99g676fcJ+Np0XhRhTmH2LF84jRvheJJbEMFqBu0iaTtAO9z5WanF3QYJlGiDEd614zYOnm6a75XPe9ql0BejrTD7f8jEquQbP8PJR08+Kyqwx8xT9bVSFxcdU20OuN3OryEduFJj2oD6foXOia/ktH1axxSgHk8ObuZuWDcRIXu8AXX6/Li+wqwdlMwFTTI/Y2C/dmA0yoAXJ/c8/zRiRZ6IBRXTRCVCkD8D8QJjfM3HeCkANr4Fwqy5hlUjt54QdSWZVbd+UQdRnsFvSrZwp7OKpzOFIuEezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSe4q44y2xdyxYIqN2Gk4CEFYJvqTOUgbS/3jpinGaA=;
 b=k4ulQuOhiGpfLAgQC9iqf7my9T5G29MV4uKtnSJjChHg6nX3OJM1Ksjy3OMXv4HREsM7LNiDSKtd1iR96qIdiRG65B/7fDwvXFHy9880cG9sDNb0WHnBoQQIz0evBPqt/qUZ5NwDovAqU7VFfaKfqbtEPxJ3uqjVSWbtWJwv3c4CnpOFZGq8oFMnac34L4t627sANMQaJxGVez/n64n/SdYUtzdYpn0JIIxQKC5ClAhbwvtx4ZT+rIqt4lTU5RjZHzM1y8mPh2RMFvJ0NFd8MOyATsk8kq3vK/b6NG/vtmxb1zkayy1Ze3WjBiR2aJIqhB4pafEwj86F2QLv+PBaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSe4q44y2xdyxYIqN2Gk4CEFYJvqTOUgbS/3jpinGaA=;
 b=RhOjnwrAgophPh5A4HHJoWjzlIR2UEA2PCSZIJWZCqrxwnGy5UVlAVC/vtp5kXTsaY/TF6LOk4eZMBi6D8JX1bzEIIeru6ttHnO4fTSAGdR53XkvZAsZJahpeWd3B8B1Bmm/CHVssNTQN43ypfnFaDEueneHv0onfgjtJVgR+TM=
Received: from CO2PR04MB2328.namprd04.prod.outlook.com (10.166.95.11) by
 CO2PR04MB2295.namprd04.prod.outlook.com (10.166.200.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 6 Sep 2019 16:17:13 +0000
Received: from CO2PR04MB2328.namprd04.prod.outlook.com
 ([fe80::b44d:f58f:f4bd:fdea]) by CO2PR04MB2328.namprd04.prod.outlook.com
 ([fe80::b44d:f58f:f4bd:fdea%12]) with mapi id 15.20.2241.018; Fri, 6 Sep 2019
 16:17:13 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v6 1/4] block: Add zoned device model
 property
Thread-Index: AQHVY2Pin1anYO+b30CJivznw8xpWKceToiAgACHxAA=
Date: Fri, 6 Sep 2019 16:17:12 +0000
Message-ID: <412e2d4dacac702f443ebe0b8b0871460a953b70.camel@wdc.com>
References: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
 <20190904210100.10501-2-dmitry.fomichev@wdc.com>
 <20190906081117.asr67hq26eqqooxd@steredhat>
In-Reply-To: <20190906081117.asr67hq26eqqooxd@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dmitry.Fomichev@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95f96a2b-7411-4668-b374-08d732e5ad5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:CO2PR04MB2295; 
x-ms-traffictypediagnostic: CO2PR04MB2295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB2295BC7E5A55BC26E4420B94E1BA0@CO2PR04MB2295.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(53936002)(446003)(6506007)(476003)(6116002)(3846002)(66066001)(76116006)(91956017)(118296001)(11346002)(2616005)(2906002)(26005)(6246003)(99286004)(478600001)(36756003)(76176011)(2501003)(14454004)(186003)(4326008)(25786009)(5660300002)(102836004)(54906003)(316002)(66946007)(7736002)(305945005)(71200400001)(71190400001)(256004)(229853002)(14444005)(6436002)(6486002)(8936002)(66446008)(64756008)(66556008)(2351001)(6916009)(486006)(86362001)(66476007)(5640700003)(8676002)(6512007)(1730700003)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CO2PR04MB2295;
 H:CO2PR04MB2328.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GJcMB1m4dtrByWOfVQDGbrZaqIjfJlvBxqqvr88sNK7RkbOdYByj3pCS0GWtck9xw+7E9obF3FL7sO5dCstI0hLJol0XdRVVynutnFf/g0H2sq8g1PwCtxUuCHGMW3RkrzhcOR/m7CKKwSs7TuNwnAAigdJQ97O8tMqX8snhWvAw4jxpdPKPRitvl/ArBeH340Kfxq668Apz5tZn3xO5UvcAO1XsFUY4bLT9jcK2bMh/FGLlvozvHBlahrt7zB89EIuRaGYuwaG18KcllnzO+INaEZ9/bd9bBA5ddFVvVR593oUKvUfHxjaGcUAzJ0SflqZfyOBpaAZ/42wob+4MW7Xjon6zLjJBfQVV1EpWHus0YStqQaEqE/YtdoVhIe2ZJyVAgOxvelsYI1RBdijKKS3o80wSo4l733nBt0xLdkM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <329A49D1A6D6D54CB26EAA2F925822AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f96a2b-7411-4668-b374-08d732e5ad5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 16:17:13.1659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoUqE4Bo33K8rB60Cl2SpJRXyILGqIxV2z2PwxiEb31iP1p9A3SZOybMIDOXXotawSDH+t+qtLjym84/e2iSow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2295
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: Re: [Qemu-devel] [PATCH v6 1/4] block: Add zoned device model
 property
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDE5LTA5LTA2IGF0IDEwOjExICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3Jv
dGU6DQo+IE9uIFdlZCwgU2VwIDA0LCAyMDE5IGF0IDA1OjAwOjU3UE0gLTA0MDAsIERtaXRyeSBG
b21pY2hldiB3cm90ZToNCj4gPiBUaGlzIGNvbW1pdCBhZGRzIFpvbmVkIERldmljZSBNb2RlbCAo
YXMgZGVmaW5lZCBpbiBUMTAgWkJDIGFuZA0KPiA+IFQxMyBaQUMgc3RhbmRhcmRzKSBhcyBhIGJs
b2NrIGRyaXZlciBwcm9wZXJ0eSwgYWxvbmcgd2l0aCBzb21lDQo+ID4gdXNlZnVsIGFjY2VzcyBm
dW5jdGlvbnMuDQo+ID4gDQo+ID4gQSBuZXcgYmFja2VuZCBkcml2ZXIgcGVybWlzc2lvbiwgQkxL
X1BFUk1fU1VQUE9SVF9ITV9aT05FRCwgaXMgYWxzbw0KPiA+IGludHJvZHVjZWQuIE9ubHkgdGhl
IGRyaXZlcnMgaGF2aW5nIHRoaXMgcGVybWlzc2lvbiB3aWxsIGJlIGFsbG93ZWQNCj4gPiB0byBv
cGVuIGhvc3QgbWFuYWdlZCB6b25lZCBibG9jayBkZXZpY2VzLg0KPiA+IA0KPiA+IE5vIGNvZGUg
aXMgYWRkZWQgeWV0IHRvIGluaXRpYWxpemUgb3IgY2hlY2sgdGhlIHZhbHVlIG9mIHRoaXMgbmV3
DQo+ID4gcHJvcGVydHksIHRoZXJlZm9yZSB0aGlzIGNvbW1pdCBkb2Vzbid0IGNoYW5nZSBhbnkg
ZnVuY3Rpb25hbGl0eS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgRm9taWNoZXYg
PGRtaXRyeS5mb21pY2hldkB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBibG9jay5jICAgICAgICAg
ICAgICAgICAgIHwgMTUgKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvYmxvY2svYmxvY2su
aCAgICAgfCAxOSArKysrKysrKysrKysrKysrKystDQo+ID4gIGluY2x1ZGUvYmxvY2svYmxvY2tf
aW50LmggfCAgMyArKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Jsb2NrLmMgYi9ibG9jay5jDQo+
ID4gaW5kZXggODc0YTI5YTk4My4uNjlmNTY1ZTFlOSAxMDA2NDQNCj4gPiAtLS0gYS9ibG9jay5j
DQo+ID4gKysrIGIvYmxvY2suYw0KPiA+IEBAIC00Njc5LDYgKzQ2NzksMjEgQEAgdm9pZCBiZHJ2
X2dldF9nZW9tZXRyeShCbG9ja0RyaXZlclN0YXRlICpicywgdWludDY0X3QgKm5iX3NlY3RvcnNf
cHRyKQ0KPiA+ICAgICAgKm5iX3NlY3RvcnNfcHRyID0gbmJfc2VjdG9ycyA8IDAgPyAwIDogbmJf
c2VjdG9yczsNCj4gPiAgfQ0KPiA+ICANCj4gPiArQmRydlpvbmVkTW9kZWwgYmRydl9nZXRfem9u
ZWRfbW9kZWwoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+ID4gK3sNCj4gPiArICAgIHJldHVybiBi
cy0+Ymwuem9uZWRfbW9kZWw7DQo+ID4gK30NCj4gPiArDQo+ID4gK2Jvb2wgYmRydl9pc19obV96
b25lZChCbG9ja0RyaXZlclN0YXRlICpicykNCj4gPiArew0KPiA+ICsgICAgLyoNCj4gPiArICAg
ICAqIEhvc3QgQXdhcmUgem9uZSBkZXZpY2VzIGFyZSBzdXBwb3NlZCB0byBiZSBhYmxlIHRvIHdv
cmsNCj4gPiArICAgICAqIGp1c3QgbGlrZSByZWd1bGFyIGJsb2NrIGRldmljZXMuIFRodXMsIHdl
IG9ubHkgY29uc2lkZXINCj4gPiArICAgICAqIEhvc3QgTWFuYWdlZCBkZXZpY2VzIHRvIGJlIHpv
bmVkIGhlcmUuDQo+ID4gKyAgICAgKi8NCj4gPiArICAgIHJldHVybiBiZHJ2X2dldF96b25lZF9t
b2RlbChicykgPT0gQkRSVl9aT05FRF9NT0RFTF9ITTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgYm9v
bCBiZHJ2X2lzX3NnKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPiA+ICB7DQo+ID4gICAgICByZXR1
cm4gYnMtPnNnOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmggYi9pbmNs
dWRlL2Jsb2NrL2Jsb2NrLmgNCj4gPiBpbmRleCAxMjRhZDQwODA5Li4yOGQwNjVlZDgwIDEwMDY0
NA0KPiA+IC0tLSBhL2luY2x1ZGUvYmxvY2svYmxvY2suaA0KPiA+ICsrKyBiL2luY2x1ZGUvYmxv
Y2svYmxvY2suaA0KPiA+IEBAIC0yNzEsMTggKzI3MSwzMyBAQCBlbnVtIHsNCj4gPiAgICAgICAq
Lw0KPiA+ICAgICAgQkxLX1BFUk1fR1JBUEhfTU9EICAgICAgICAgID0gMHgxMCwNCj4gPiAgDQo+
ID4gKyAgICAvKioNCj4gPiArICAgICAqIFRoaXMgcGVybWlzc2lvbiBpcyByZXF1aXJlZCB0byBv
cGVuIGhvc3QtbWFuYWdlZCB6b25lZCBibG9jayBkZXZpY2VzLg0KPiA+ICsgICAgICovDQo+ID4g
KyAgICBCTEtfUEVSTV9TVVBQT1JUX0hNX1pPTkVEICAgPSAweDIwLA0KPiA+ICsNCj4gPiAgICAg
IEJMS19QRVJNX0FMTCAgICAgICAgICAgICAgICA9IDB4MWYsDQo+IA0KPiBTaG91bGQgd2UgdXBk
YXRlIEJMS19QRVJNX0FMTCB0byAweDNmPw0KPiANClN0ZWZhbm8sIGdvb2QgY2F0Y2ghIFdpbGwg
dXBkYXRlIGFuZCByZXNlbmQuLi4NCg0KPiBUaGFua3MsDQo+IFN0ZWZhbm8NCj4gDQo=

