Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489C0C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072C421881
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S1aenYLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072C421881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7i0N-0002IA-CR
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i7hzH-00011e-0t
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i7hzF-0002oa-EN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:23:22 -0400
Received: from mail-eopbgr130100.outbound.protection.outlook.com
 ([40.107.13.100]:6023 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i7hzE-0002mx-K9; Tue, 10 Sep 2019 11:23:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ufv2c/idii2dxlZIw99bYyPvfmiGoP0Q9ZPy2+waGG4mssjilCnqygUnTXqO2lM4NTVnK7fgvj8ch8k21VmhBebmUloWaj9QKrCCnrVr0yqf2hd+5yzfw69q9r9FYCLaufNxvvwHVlrwSCYKVlNsMS4bK4T7CVvqLdyHl1MIVfzG3qehcfSuNwtn12RmtUAqpWakYaftajhqwJuIgIGx5Yjc5QkuDbDE1n3YNRsaifkugYSWR34tZNLVZQdzspeq16iL3MLLPDgcUYpDXTrd4uOSAXNY8L5FjcZ69RYN84qcthU7be7hK/JxKTif/vI9+mRe5kJ9jYJ6D4bxNDuEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V1ft9CSFZLxkXPRqGu/h2JcDnHWcegKWfK+RkzT+F0=;
 b=id8sQvwxV3avC0sy/SNLp0xd1jpW/FDIBXIMR95HkJQLKI3PI2CT4wBwLhT2YQaxUvFc+Afyee/8kM8xn6G/VOqnXe9NXX8aDbBQI3N61PrB6YGMJhzfiyZ8eANrtTjMO8k5/OU3OF85AP7f5yFxCUtvaKaFHPAmRV3AVK76I8xM+KUhsoW/l1GIAch6YCovsLIiiL4XZlJDqZk8BmEPdkz4oHl/EQ4Qu4zYw48u/kgLb4sFiXOa7twu9kBH0FV9JczjDHFtXY07DvEAzSi/y512urqMqLtfCN6r+Fb4nBrImUh3mPnbLRfwE/tdqnBNRIfHp7+U/bEwbC8YePk7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V1ft9CSFZLxkXPRqGu/h2JcDnHWcegKWfK+RkzT+F0=;
 b=S1aenYLuR088YiyFUpUHZb8QuQv5/oPDiEyBK8+j08eRYM6aVczJCOZiAWyIXbPsk6YoKhM3bQAlG3k3L2ib0l7HZC8f2bOydafrNgKynDOakUCHRg6NFz3gASggvTuIon0KsYnvgzMA20JU83LfSUNUzc7XvGimTrRP0wAh3pI=
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) by
 AM6PR08MB4055.eurprd08.prod.outlook.com (20.179.1.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Tue, 10 Sep 2019 15:23:16 +0000
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42]) by AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42%3]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 15:23:16 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v9 3/9] block: add empty account cookie type
Thread-Index: AQHVZMxiDUZj6ilux0Wa9VlYDWN40Kcjc2eAgAGaUQA=
Date: Tue, 10 Sep 2019 15:23:15 +0000
Message-ID: <c5135305-df31-b009-73c3-837a01fdcf40@virtuozzo.com>
References: <20190906160120.70239-1-anton.nefedov@virtuozzo.com>
 <20190906160120.70239-4-anton.nefedov@virtuozzo.com>
 <w51k1ah8qqa.fsf@maestria.local.igalia.com>
In-Reply-To: <w51k1ah8qqa.fsf@maestria.local.igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0014.eurprd07.prod.outlook.com
 (2603:10a6:7:67::24) To AM6PR08MB5208.eurprd08.prod.outlook.com
 (2603:10a6:20b:eb::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 054f4f22-9382-4110-f376-08d73602cd2b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM6PR08MB4055; 
x-ms-traffictypediagnostic: AM6PR08MB4055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4055D618D753F972707ED07FF8B60@AM6PR08MB4055.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(478600001)(52116002)(99286004)(386003)(186003)(53546011)(31686004)(446003)(8676002)(256004)(81166006)(81156014)(26005)(15650500001)(14444005)(102836004)(7736002)(6116002)(3846002)(31696002)(2906002)(305945005)(5660300002)(11346002)(86362001)(6506007)(14454004)(8936002)(36756003)(71200400001)(71190400001)(25786009)(66946007)(66476007)(66556008)(64756008)(66446008)(110136005)(229853002)(66066001)(6246003)(2501003)(107886003)(316002)(6486002)(53936002)(2616005)(476003)(76176011)(486006)(6436002)(44832011)(54906003)(4326008)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4055;
 H:AM6PR08MB5208.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FVdr3ElrkbZBnlL2zhD91fbQdsUhdt6Ai+7hiJSdew4yalopBcZONcWWNwy15Zjlx/swdv7iLamZaaUtby87C9DahyaykTbx0FqzGvai/ktMFseXINBDbPkiGr6XpiK2YzeESeAnJwpV7D13Icr4GbhK70ULOv/OmcGBwW/Nb+DXV7GUltlal6/aJSlTKKdLchbsltEtb2idSuA1ofJQ8DqRiXH5lGVygazU86XoG2TBf5+uyE1F0hgqyboJJK3uZST2+GVmJEbCwP/RAAXHOezAJOd3C3C11G1Bn4MRTUJlEqC14TUrPoLx85dwvbXlWfo+x5sDAvdIYbw77Sop0imikSaKjeb+sUsq/ir8Mx5CpEiYV7EMa/qS6AUJGNR2q36a9+GaPzpk5vK7AXU45MvCwfJkcDlSvf6doTr2Gvg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5385A049A8E7BC4CA5B7C49AD0140643@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054f4f22-9382-4110-f376-08d73602cd2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 15:23:16.0685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VyaeAVwOr7b9+PuWbWWUSy/VOFTVr3/bVbpYfrNfsuBlau6GgA+lU6pQb+HJuO9SRZiCNsDl1cZCLs96vNfFPmYDXPkddbKm9PnefcV8lKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4055
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.100
Subject: Re: [Qemu-devel] [PATCH v9 3/9] block: add empty account cookie type
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gOS85LzIwMTkgNTo1NCBQTSwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE9uIEZyaSAwNiBT
ZXAgMjAxOSAwNjowMToxNCBQTSBDRVNULCBBbnRvbiBOZWZlZG92IHdyb3RlOg0KPj4gVGhpcyBh
ZGRzIHNvbWUgcHJvdGVjdGlvbiBmcm9tIGFjY291bnRpbmcgdW5pbml0aWFsaXplZCBjb29raWUu
DQo+PiBUaGF0IGlzLCBibG9ja19hY2N0X2ZhaWxlZC9kb25lIHdpdGhvdXQgcHJldmlvdXMgYmxv
Y2tfYWNjdF9zdGFydDsNCj4+IGluIHRoYXQgY2FzZSwgY29va2llIHByb2JhYmx5IGhvbGRzIHZh
bHVlcyBmcm9tIHByZXZpb3VzIG9wZXJhdGlvbi4NCj4+DQo+PiAoTm90ZTogaXQgbWlnaHQgYWxz
byBiZSB1bmluaXRpYWxpemVkIGhvbGRpbmcgZ2FyYmFnZSB2YWx1ZSBhbmQgdGhlcmUNCj4+IGlz
IHN0aWxsICI8IEJMT0NLX01BWF9JT1RZUEUiIGFzc2VydGlvbiBmb3IgdGhhdC4gIFNvDQo+PiBi
bG9ja19hY2N0X2ZhaWxlZC9kb25lIHdpdGhvdXQgcHJldmlvdXMgYmxvY2tfYWNjdF9zdGFydCBz
aG91bGQgYmUNCj4+IHVzZWQgd2l0aCBjYXV0aW9uLikNCj4+DQo+PiBDdXJyZW50bHkgdGhpcyBp
cyBwYXJ0aWN1bGFybHkgdXNlZnVsIGluIGlkZSBjb2RlIHdoZXJlIGl0J3MgaGFyZCB0bw0KPj4g
a2VlcCB0cmFjayB3aGV0aGVyIHRoZSByZXF1ZXN0IHN0YXJ0ZWQgYWNjb3VudGluZyBvciBub3Qu
IEZvciBleGFtcGxlLA0KPj4gdHJpbSByZXF1ZXN0cyBkbyB0aGUgYWNjb3VudGluZyBzZXBhcmF0
ZWx5Lg0KPiANCj4gU29ycnkgaWYgSSdtIHVuZGVyc3RhbmRpbmcgaXQgd3JvbmcsIGJ1dCBpdCBz
b3VuZHMgbGlrZSB5b3Uga25vdyB0aGF0DQo+IHRoZXJlJ3MgYSBidWcgaW4gdGhlIGlkZSBjb2Rl
ICh3aGVyZSB5b3UgY2FsbCBibG9ja19hY2N0X2RvbmUoKSB3aXRob3V0DQo+IGhhdmluZyBpdCBp
bml0aWFsaXplZCBpdCBmaXJzdCksIGFuZCB0aGUgcHVycG9zZSBvZiB0aGUgdGhpcyBwYXRjaCBp
cyB0bw0KPiBoaWRlIHRoZSBidWcgPw0KPiANCg0KaGksDQoNCm5vdCByZWFsbHk7IGluIHRoZSBl
eGlzdGluZyBjb2RlLCBJIGNhbid0IHNlZSBibG9ja19hY2N0X2RvbmUoKSB3aXRob3V0DQpibG9j
a19hY2N0X3N0YXJ0KCksIGJ1dCB0aGVyZSBtaWdodCBiZSBkb3VibGUtYWNjb3VudGluZyB0aG91
Z2g7DQplLmcuIGlkZV9hdGFwaV9jbWRfcmVhZF9kbWFfY2IoKTogaXQgY2FuIGFjY291bnQgdGhl
IHNhbWUgb3BlcmF0aW9uDQp0d2ljZSBsaWtlDQogICBpZGVfaGFuZGxlX3J3X2Vycm9yKCk7DQog
ICBnb3RvIGVvdDsNCiAgIGJsb2NrX2FjY3RfZmFpbGVkKCk7DQoNClRoZSBwYXRjaCBzaG91bGQg
c29sdmUgaXQuDQoNClRoZSBjb21taXQgbWVzc2FnZSBpcyBtaXNsZWFkaW5nLCBzb3JyeS4gSSds
bCBjaGFuZ2UgdG86DQoNCiA+IEVhY2ggYmxvY2tfYWNjdF9kb25lL2ZhaWxlZCBjYWxsIGlzIGRl
c2lnbmVkIHRvIGNvcnJlc3BvbmQgdG8gYQ0KID4gcHJldmlvdXMgYmxvY2tfYWNjdF9zdGFydCBj
YWxsLCB3aGljaCBpbml0aWFsaXplcyB0aGUgc3RhdHMgY29va2llLg0KID4gSG93ZXZlciBzb21l
dGltZXMgaXQgaXMgbm90IHRoZSBjYXNlLCBlLmcuIHNvbWUgZXJyb3IgcGF0aHMgbWlnaHQNCiA+
IHJlcG9ydCB0aGUgc2FtZSBjb29raWUgdHdpY2UgYmVjYXVzZSBpdCBpcyBoYXJkIHRvIGFjY3Vy
YXRlbHkgdHJhY2sgaWYNCiA+IHRoZSBjb29raWUgd2FzIHJlcG9ydGVkIHlldCBvciBub3QuDQoN
CiA+IFRoaXMgcGF0Y2ggY2xlYW5zIHRoZSBjb29raWUgYWZ0ZXIgcmVwb3J0Lg0KID4gKE5vdGU6
IGJsb2NrX2FjY3RfZmFpbGVkL2RvbmUgd2l0aG91dCBhIHByZXZpb3VzIGJsb2NrX2FjY3Rfc3Rh
cnQgYXQNCiA+IGFsbCBzaG91bGQgYmUgYXZvaWRlZC4gVW5pbml0aWFsaXplZCBjb29raWUgbWln
aHQgaG9sZCBhIGdhcmJhZ2UgdmFsdWUNCiA+IGFuZCB0aGVyZSBpcyBzdGlsbCAiPCBCTE9DS19N
QVhfSU9UWVBFIiBhc3NlcnRpb24gZm9yIHRoYXQpDQoNCiA+IEl0IHdpbGwgYmUgcGFydGljdWxh
cmx5IHVzZWZ1bCBpbiBpZGUgY29kZSB3aGVyZSBpdCdzIGhhcmQgdG8NCiA+IGtlZXAgdHJhY2sg
d2hldGhlciB0aGUgcmVxdWVzdCBkb25lIGl0cyBhY2NvdW50aW5nIG9yIG5vdDogaW4gdGhlDQog
PiBmb2xsb3dpbmcgcGF0Y2ggb2YgdGhlIHNlcmllcywgdHJpbSByZXF1ZXN0cyB3aWxsIGRvIHRo
ZSBhY2NvdW50aW5nDQogPiBzZXBhcmF0ZWx5Lg0KDQovQW50b24NCg==

