Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E5C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2E020882
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="XngyfooC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2E020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxFW-0004RM-Ff
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAx0P-0003CW-MN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAx0O-00088S-Ej
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:01:57 -0400
Received: from mail-eopbgr800091.outbound.protection.outlook.com
 ([40.107.80.91]:7296 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAx0O-00086x-5r
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:01:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHzHNspWsDd45DZaYzwwxPs4W7IiljclpL/gql5+u06CcEz6o2yj93fGgWmMEtentS8BmXbauNVvDZyLLEOEBbZkT56aWIbrKfg6hK5UTK6iyd7wgU6jzEsG4sTFnQcyaJDRLU8JFCfFGtjCRVZRHQs36t2lZaDs7Ht7rgpB/PjIM1PyYY5TJMNcqv8CJX/M3jmHEDtVFcK2b3iuDWRMOltB3L1Lpk9K6ZbSga3NPMpsjqfRPr7Ove+bYCdSdpxkLAUTXIvvTcVkaQvMjxgr3OlCUbl0qiPsbge6dauVmn7San39xO6W27Hm1o9JMkvGRrYIK0vnlWr9b8YNBdbHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcRMxvL5aIEhhXCB1Vxliwv6M5IJkNYYN0R8OwIZSIM=;
 b=mUNR7/PDYPCiT76RisAlm2zi1Ne8vfZOzN9eL1gXkv4XDtlP78JXndSIeyBQM3r/yhU7RpYN0LO4JYceXBwWXcCP+7JCPrgu9i2US5Vh/qbpTvW/EmAW4Ku0c5I3R4cpltoGJ9TFxeotdlC/CJT9n+XmhdGX6dwy/7AR17Xm3/cKIfVdTsrCrDA8RFOHYEwnstGnruV/H/93Z/TL8VY5IMGAtLO/1xRvsB4MY9VkpfBAuzzjzjCusjcA9G0bVmBPj6Yxmjtq6E9eoXQ5RV1V8zh9DH5sVyOuy/vjWlW0YVix7P2xaxjp8whcwHnQ4/cwNkwm8ADRdBDtc904TzQrPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcRMxvL5aIEhhXCB1Vxliwv6M5IJkNYYN0R8OwIZSIM=;
 b=XngyfooCer+iatT6pkfEa8eTIXpRdBtDPjzmceuSsLUEXY6ul58bz+3vmqsEwdx97Jqi/WG5KnyPAkJta4XP6LXnkGrW7Vu8Cf8oD6HMz4ZOOx8X+KNN/Z6/g4VILlt9xekGSwtr0Rz3dYKfdme1cscyN8Z3QiXXTOWUEYSTJ9M=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2568.namprd03.prod.outlook.com (10.173.41.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Thu, 19 Sep 2019 14:01:53 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 14:01:53 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "stefanha@redhat.com" <stefanha@redhat.com>
Thread-Topic: [PATCH v3 17/22] fuzz: add support for fork-based fuzzing.
Thread-Index: AQHVbneO8lKIXFBEJ0KI61E+89ePjacy9cAAgAAS4IA=
Date: Thu, 19 Sep 2019 14:01:53 +0000
Message-ID: <e90af06e25d1a98300002c5f6326307e4fd242d9.camel@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-18-alxndr@bu.edu>
 <20190919125416.GR3606@stefanha-x1.localdomain>
In-Reply-To: <20190919125416.GR3606@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [128.197.127.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c4e1527-3f7b-44a4-4cbd-08d73d09ecd5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2568; 
x-ms-traffictypediagnostic: CY4PR03MB2568:
x-microsoft-antispam-prvs: <CY4PR03MB25682B712880C1B54EFB3546BA890@CY4PR03MB2568.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(3846002)(25786009)(2351001)(91956017)(76176011)(75432002)(5640700003)(6116002)(7736002)(71190400001)(26005)(2616005)(478600001)(99286004)(476003)(186003)(6512007)(11346002)(6506007)(446003)(102836004)(305945005)(71200400001)(2906002)(88552002)(5660300002)(66066001)(6436002)(36756003)(66476007)(1730700003)(4326008)(76116006)(6486002)(66946007)(66556008)(81166006)(2501003)(486006)(316002)(81156014)(786003)(118296001)(66446008)(256004)(6246003)(14454004)(64756008)(8676002)(6916009)(54906003)(229853002)(86362001)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2568;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cJVloFl7btsQ0twrJ7FN4ugRvIpjlxl2Cp8SgerkPv+TAS/2Dapabn3l47pfCiEcOSR4o94LNCE498s/kIlS3I9g0xIGaFUx1AZMyo1SfawCdEZbuEjLTsA8dTOPzHD5fZDaDz86P0LeGS8jihq6YmcQXqN425vmkb6rT8eN2KE4J4xatYjoOA6RD1ZTjNgM7mxxjQvq+yb2BJuE0O6xMyDl0CV+QQa3IFk+ycers+7bne5qrbZvX5PjIxwAcI4a/XAbmX1RkcstIyHePekegtl55vL/7JpY15QMenvV4OZdu4i+6uTa+ADY4d3i2p6gDCT9oeIFO4XElRlq2dPobZgQVzC62q7vJsj9UxgsZegP7bB2mUl1rRWwHI2FUBNbvCHaWvhnfuQFOH2qegkInZJDRjOYbQZkd4QaM6r9rQ4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2FF152280D46D4492341EDD2F3EA724@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4e1527-3f7b-44a4-4cbd-08d73d09ecd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 14:01:53.2186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+CpcV9ocj/zZ0bn4E9grdaHYkQ4nbaq1muEDX9uXJ+rvF+0ATAfR9aVDcTY7RxV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2568
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.91
Subject: Re: [Qemu-devel] [PATCH v3 17/22] fuzz: add support for fork-based
 fuzzing.
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDEzOjU0ICswMTAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIFdlZCwgU2VwIDE4LCAyMDE5IGF0IDExOjE5OjQ0UE0gKzAwMDAsIE9sZWluaWssIEFs
ZXhhbmRlciB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZXhlYy5jIGIvZXhlYy5jDQo+ID4gaW5k
ZXggMjM1ZDZiYzg4My4uZDM4MzhmNGVhNCAxMDA2NDQNCj4gPiAtLS0gYS9leGVjLmMNCj4gPiAr
KysgYi9leGVjLmMNCj4gPiBAQCAtMjI5NSw3ICsyMjk1LDkgQEAgc3RhdGljIHZvaWQgcmFtX2Js
b2NrX2FkZChSQU1CbG9jaw0KPiA+ICpuZXdfYmxvY2ssIEVycm9yICoqZXJycCwgYm9vbCBzaGFy
ZWQpDQo+ID4gICAgICAgICAgcWVtdV9yYW1fc2V0dXBfZHVtcChuZXdfYmxvY2stPmhvc3QsIG5l
d19ibG9jay0NCj4gPiA+bWF4X2xlbmd0aCk7DQo+ID4gICAgICAgICAgcWVtdV9tYWR2aXNlKG5l
d19ibG9jay0+aG9zdCwgbmV3X2Jsb2NrLT5tYXhfbGVuZ3RoLA0KPiA+IFFFTVVfTUFEVl9IVUdF
UEFHRSk7DQo+ID4gICAgICAgICAgLyogTUFEVl9ET05URk9SSyBpcyBhbHNvIG5lZWRlZCBieSBL
Vk0gaW4gYWJzZW5jZSBvZg0KPiA+IHN5bmNocm9ub3VzIE1NVSAqLw0KPiA+ICsjaWZuZGVmIENP
TkZJR19GVVpaIC8qIFRoaXMgY29uZmxpY3RzIHdpdGggZm9yay1iYXNlZCBmdXp6aW5nICovDQo+
ID4gICAgICAgICAgcWVtdV9tYWR2aXNlKG5ld19ibG9jay0+aG9zdCwgbmV3X2Jsb2NrLT5tYXhf
bGVuZ3RoLA0KPiA+IFFFTVVfTUFEVl9ET05URk9SSyk7DQo+ID4gKyNlbmRpZg0KPiA+ICAgICAg
ICAgIHJhbV9ibG9ja19ub3RpZnlfYWRkKG5ld19ibG9jay0+aG9zdCwgbmV3X2Jsb2NrLQ0KPiA+
ID5tYXhfbGVuZ3RoKTsNCj4gPiAgICAgIH0NCj4gPiAgfQ0KPiANCj4gSSBkaWRuJ3QgY2hlY2sg
TWFrZWZpbGUgY2hhbmdlcyBidXQgcmVndWxhciBzb2Z0bW11IGJpbmFyaWVzIHNob3VsZA0KPiBj
b250aW51ZSB0byB3b3JrIHdpdGggLS1lbmFibGUtZnV6emluZyBzbyB3ZSBjYW5ub3QgdXNlICNp
ZmRlZiBoZXJlLg0KPiBQZXJoYXBzIHRoaXMgc2hvdWxkIGJlIGEgcnVudGltZSBjaGVjayBzaW1p
bGFyIHRvIHF0ZXN0X2VuYWJsZWQoKQ0KDQpZZXMgLSBJJ2xsIGFkZCBhIHJ1bnRpbWUgY2hlY2su
IFRoZSBtYWtlZmlsZSByZXF1aXJlcyBhIG1ha2UgY2xlYW4NCmJldHdlZW4gc29mdG1tdSBhbmQg
ZnV6emVyIGJ1aWxkcywgc2luY2UgdGhlICIubyJzIGZvciB0aGUgZnV6emVyIGJ1aWxkDQphcmUg
Y29tcGlsZWQgd2l0aCBmc2FuaXRpemU9ZnV6emVyKG11c3QgYmUgbGlua2VkIGFnYWluc3QgbGli
ZnV6emVyKS4gDQpJIGNhbiBzZWUgdGhhdCB0aGUgI2lmbmRlZiBDT05GSUdfRlVaWiBpcyBhIHBy
b3BlciBzb2Z0bW11IGJ1aWxkcyB3aXRoDQotLWVuYWJsZS1mdXp6ZXIgYXJlIGN1cnJlbnRseSBi
cm9rZW4gZHVlIHRvIHRoZSBpZm5kZWYgQ09ORklHX0ZVWloNCmNoZWNrLg0K

