Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E47C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 18:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E742054F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 18:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="a1OWQ272"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E742054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxbqn-0003cK-8D
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 14:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46667)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hxboI-0002AT-HM
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hxboH-00066N-FC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:46:18 -0400
Received: from mail-eopbgr700116.outbound.protection.outlook.com
 ([40.107.70.116]:21025 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hxboH-00061l-6I
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKmotOSCdSXgl8CM9HMAkmXPC+4vOnCpKNBdHh3S+ZnL9t07kpNb1Hp0HWazS0FZFDfFXvuk9GhDT3SZneSWLTNCjdv1qx+ZVkrLoKJQeZadmIK6UseAn50sl8L6DYw1txCE/ATSJmzQrFbjW7/nrhOw87rN92R/xn0bjbD5NdrQY8Hszz4lemoXDfRkU4C7r9Jb4yv5HmxZrdqUfa4qwQBi/aEoSG1kl0aPEbwuZVRnZLIi2wF91STOFRsLW2uOzItomDe3PeSeIesn7ACfoP51tpDsJz+iNY1E2mPj9iNpaCUK9LeEfPlLhsasRhZVcZjc2Nabo2itWvUM11WhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQfankis6BK3XJ9hOlDzYCs+4AWSJWgk1T/QplsRgO4=;
 b=SDfQouVU3jFZrG5w8BKvuSFcYsVNdC8lMloZs9JS2NDPwpaciJY0+JSqUNGWZp37TNtHQi0h7QCtlziICmfsxqRQQjgiiCgSykGdnatRJVuvbUt//JigxtRMm/tCBQuVgyBR8CY85zYKRdiJ17SMm1m8mBidzKBN8/sVbbFzH3NEtEAXNe4W50ON/W2SzdDlyZNroCVK1CFd5d4FM6aEUJEvyIj7Ykq9Utf0pQniISv9I5QNVQ6QGyjXnbJY27oo0qsDiUT1J3lpnjKU4i0fMDT/WT+sAnun77sSg9PwVOTKRi89ugqeTotL8OXo9kDxH7mUdS7Hxegb7rjyi3spag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQfankis6BK3XJ9hOlDzYCs+4AWSJWgk1T/QplsRgO4=;
 b=a1OWQ272TAyEQoBtXEXtcRYgW+XA6TmKJrNWXP1qBwUUapFIPvOUWOPch8T7w+wENpgnxTtRyMsv5CKc8WjQhI+be1TPJbI0DeBOChy8rYoTAfOA8nP0iPiHYpqyMz4X82xEkm+578lmRI5K0QDhqeMtSlLDcRXkbnxEYL/xEr4=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2664.namprd03.prod.outlook.com (10.173.37.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 18:46:01 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 18:46:01 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "bsd@redhat.com" <bsd@redhat.com>
Thread-Topic: [RFC PATCH v2 02/17] fuzz: Add fuzzer configure options
Thread-Index: AQHVS1zx9SvDhiU2WUGEo5Mghzc1qqb4JvS6gAFQ+wA=
Date: Tue, 13 Aug 2019 18:46:01 +0000
Message-ID: <bf410f8f87af309d9bc8ffebbf362f20d5202c89.camel@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-3-alxndr@bu.edu>
 <jpgzhkeovo5.fsf@linux.bootlegged.copy>
In-Reply-To: <jpgzhkeovo5.fsf@linux.bootlegged.copy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [128.197.127.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f333aae-372a-4954-2f7d-08d7201e7d06
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2664; 
x-ms-traffictypediagnostic: CY4PR03MB2664:
x-microsoft-antispam-prvs: <CY4PR03MB26647D7F3DE682E7C47FA0A4BAD20@CY4PR03MB2664.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(199004)(189003)(14454004)(75432002)(478600001)(6246003)(6916009)(6116002)(2351001)(5640700003)(99286004)(86362001)(2501003)(6436002)(53936002)(3846002)(36756003)(4326008)(54906003)(66556008)(88552002)(64756008)(6486002)(486006)(76116006)(476003)(446003)(66946007)(2616005)(316002)(5660300002)(118296001)(25786009)(66446008)(256004)(71200400001)(66476007)(66066001)(786003)(91956017)(71190400001)(6512007)(11346002)(102836004)(6506007)(229853002)(8676002)(1730700003)(186003)(81166006)(7736002)(2906002)(8936002)(305945005)(26005)(76176011)(81156014)(42522002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2664;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kqNYa5qJEqSGHeZ567ps0MtT8+YFoeOxuNByG2gzJptEjOG00iNIn53IZb5RfdwQZwO210+VDPpAFarGBh8TPEOxZ5yndEVlEgfVsOs7sqXMW5tQuoT4puqqmMPs6PI8AcAA/vHKIQ0WgfJbVAcKL01itJTxE/AKfCNx2XdW0YPB9tdtwcnmfb5gr2F24pRnGFkhnM5zmYv4I2c3TlTECupHQI6fNrHFd9l0oUTjCaopUvW5UguTC1h91NQSPRfpBlv4M0UUJ6xU+FWNoTsbcn/We+D9N5nSZbIXzhFWVFkNHjp1ziJ4mx1BNDjkifpuiIv2brK5uWmNaNFRdK4RbcBqD7uiyQmu0v+85ZzIpUNLNyRN2s8dxsgGnU1iRh3gk9vIajfdPqCl+ipbqV+pDdyvUO421QvVtVxHMFZwFm4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <995800D3F824584EAB51D10EE685D4B5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f333aae-372a-4954-2f7d-08d7201e7d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 18:46:01.4299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4pVapaafX3Gd+rKVI6n+955ppAhPauYS0ChiVCcC1o4VVEyoXWJF0U0g8OYN87u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2664
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.116
Subject: Re: [Qemu-devel] [RFC PATCH v2 02/17] fuzz: Add fuzzer configure
 options
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gTW9uLCAyMDE5LTA4LTEyIGF0IDE4OjM5IC0wNDAwLCBCYW5kYW4gRGFzIHdyb3RlOg0KPiAi
T2xlaW5paywgQWxleGFuZGVyIiA8YWx4bmRyQGJ1LmVkdT4gd3JpdGVzOg0KPiAuLi4NCj4gPiAg
aWYgdGVzdCAiJHN1cHBvcnRlZF9jcHUiID0gIm5vIjsgdGhlbg0KPiA+ICAgICAgZWNobw0KPiA+
IEBAIC03MzA2LDYgKzczMTAsMTcgQEAgZmkNCj4gPiAgaWYgdGVzdCAiJHNoZWVwZG9nIiA9ICJ5
ZXMiIDsgdGhlbg0KPiA+ICAgIGVjaG8gIkNPTkZJR19TSEVFUERPRz15IiA+PiAkY29uZmlnX2hv
c3RfbWFrDQo+ID4gIGZpDQo+ID4gK2lmIHRlc3QgIiRmdXp6aW5nIiA9ICJ5ZXMiIDsgdGhlbg0K
PiA+ICsgIFFFTVVfQ0ZMQUdTPSIkUUVNVV9DRkxBR1MgLWZzYW5pdGl6ZT1mdXp6ZXIsYWRkcmVz
cyAgLWZwcm9maWxlLQ0KPiA+IGluc3RyLWdlbmVyYXRlIg0KPiA+ICsgIFFFTVVfQ0ZMQUdTPSIk
UUVNVV9DRkxBR1MgLWZwcm9maWxlLWluc3RyLWdlbmVyYXRlIC1mY292ZXJhZ2UtDQo+ID4gbWFw
cGluZyINCj4gDQo+IFdoYXQgaXMgdGhlIHB1cnBvc2Ugb2YgLWZwcm9maWxlLWluc3RyLWdlbmVy
YXRlID8gQ292ZXJhZ2UgaW5mbyA/DQo+IChMaXN0ZWQgdHdpY2UgYWJvdmUpDQpZZXMsIGl0J3Mg
Zm9yIGNvdmVyYWdlIGluZm8uIEknbGwgZml4IGl0IHNvIGl0IGlzIG9ubHkgbGlzdGVkIG9uY2Uu
DQoNCj4gQmFuZGFuDQo+IA0KPiA+ICsgIFFFTVVfTERGTEFHUz0iJExERkxBR1MgLWZzYW5pdGl6
ZT1mdXp6ZXIsYWRkcmVzcyINCj4gPiArDQo+ID4gKyAgIyBBZGQgdGVzdHMvIHRvIGluY2x1ZGUg
cGF0aCwgc2luY2UgdGhpcyBpcyBkb25lIGluDQo+ID4gdGVzdHMvTWFrZWZpbGUuaW5jbHVkZSwN
Cj4gPiArICAjIGFuZCByZXF1aXJlZCBmb3IgUU9TIG9iamVjdHMgdG8gYnVpbGQuIFRoaXMgY2Fu
IGJlIHJlbW92ZWQNCj4gPiBpZi93aGVuIHRoZQ0KPiA+ICsgICMgZnV6emVyIGlzIGNvbXBpbGVk
IHVzaW5nIHJ1bGVzIGluIHRlc3RzL01ha2VmaWxlLmluY2x1ZGUNCj4gPiArICBRRU1VX0lOQ0xV
REVTPSItaXF1b3RlIFwkKFNSQ19QQVRIKS90ZXN0cyAkUUVNVV9JTkNMVURFUyINCj4gPiArICBl
Y2hvICJDT05GSUdfRlVaWj15IiA+PiAkY29uZmlnX2hvc3RfbWFrDQo+ID4gK2ZpDQo+ID4gIA0K
PiA+ICBpZiB0ZXN0ICIkdGNnX2ludGVycHJldGVyIiA9ICJ5ZXMiOyB0aGVuDQo+ID4gICAgUUVN
VV9JTkNMVURFUz0iLWlxdW90ZSBcJChTUkNfUEFUSCkvdGNnL3RjaSAkUUVNVV9JTkNMVURFUyIN
Cg0K

