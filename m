Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C33C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F922077C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="NjvFnXXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F922077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQKy-0005q8-AG
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1a-00076q-2d
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1Y-0006P7-GH
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:57 -0500
Received: from mail-bn7nam10on2103.outbound.protection.outlook.com
 ([40.107.92.103]:38113 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1Y-0006Ou-CQ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9V0aEvwB3cI2cNerX0fU5eUSutMLza3TGRDx7n4HBFFN5Jr2dF1Kmwjl+T50UHy+ZVu5+438cJ8o37Vmxge3Ond6H0lYGLPsNnMmjvYfIjdop8Hcs3kXwr7tZ2FM+neiJprRGATjjeAQV31j5ENBC5MFsWHlqxZaj+ozjeXeWVwSgwH6HjSbw1VLJkn2K/VcZHak9wDRuO5PqQR0m8RlrigE4q14GEhNV+A4RZ9GRFLJ6zNrgOQltAVayXP6Qso1YK2rqvGbCHhJys+TPFpiOPlYik24fUwDDDsAHGyfjkE/d8JFuo6wfwb7bT2tNNPZQdzC28p5wJYZaf2Lu48Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMCyJN3nzC2ixzb7DkXR5cQ3SesaeOMGZjfVp8Oc6oQ=;
 b=aFBMIyykUtWylBvx0jpoEmDwihh4Puw4/zFIkvZUpEGB3XnJUu+UAuVh/qK+eIFUzzQ6A70uF8FM+RTlkLV9Xlg1sWho8iNxGVNlnFXwXhcGkMe/P/nMDxztIKhcJlGvDDkM0LFkzL9XKp1wdzpQruj9MXWP9dD6yXomB5xL1K6NCpzIh3ToP+oZqAHC3i/SdnLduoHB7aG+DNoykqJsOACcZU/aaBqp+jLzCGn15ggevlnO6+dCERnPbMeWKAZ1406n2xwcrZFsy2ezRmOmiPbbBvuptblIdXyKczOUCIUmE5tHyX4K6kzewbmE/i8S6EsiPuEg6OE11svMmw+KrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMCyJN3nzC2ixzb7DkXR5cQ3SesaeOMGZjfVp8Oc6oQ=;
 b=NjvFnXXOeStX5uHWs/9p8eKENpbeFa6MHvIKHxHvs0SfkqPsAD8LpdbHCG0eK42UNYwtyEVGIuTS/mAZyN9miA/p1JCty8LK3Aguj0nmavTN+63And9VcSmg6VAwU85UQdOs9WgOX4ZVoElKxAShd1BwzkavaEHLMSfcm9cJlks=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:55 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:55 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:54 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 09/20] libqos: split qos-test and libqos makefile vars
Thread-Topic: [PATCH v7 09/20] libqos: split qos-test and libqos makefile vars
Thread-Index: AQHVz1YjAh3VVXV3W0yi2moYqESzFg==
Date: Mon, 20 Jan 2020 05:54:54 +0000
Message-ID: <20200120055410.22322-14-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f4d10c2-64e4-4088-22b5-08d79d6d45e4
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB439916A1A5296F39334C929BBA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqqKjoB0bT7Zs9QiAAJVLbOeKHn58MzMh128m3Bmxaf7wcUVnKKcArf9OX5SiBRkLuK66AjFoVoQ4+92WaZvamh1wXTe+/UrEcWDkIZrsGpjbkIks6bvlW0r60tRgALPc5cKe+zSPC9bWlUZQbS7/shyIpbV67ncz3MfTiY0z+GnH/eJcL7HKEZZH8QicpWBnaP+nGV1W0VY3CgQNLWekBSmI9OdvZhhCT6fuGY2mMWApicgQUZLLEg7lE+3a5OsZSx0ec6d6qWwZHQTBNm/CWHxv5Ua7OawunUlE9uWme84FEpfKpdlrnWIbkKOs2Mzy0BCcels2wSSGwNlsoVHeqnLl/U8b5+mH/oIRGHfJvOJulBX65ZCT/lw38CWIj5PHbB4ke4qEGxM/DUkQ1Ydy95djL4Z5F+wIMiRnNNqKMZZu0+pABhjjdV9Mi1pODfs
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9251B6770E25A4DAAEC9EEEC62470F2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4d10c2-64e4-4088-22b5-08d79d6d45e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:54.7988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8hesdP6xycM5q3IA2TmBM+iOqrVvXsG3CAEBu0pSjjcGUgBbnirQq6Hq+T7iArf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.103
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Bulekov, 
 Alexander" <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TW9zdCBxb3MtcmVsYXRlZCBvYmplY3RzIHdlcmUgc3BlY2lmaWVkIGluIHRoZSBxb3MtdGVzdC1v
YmoteSB2YXJpYWJsZS4NCnFvcy10ZXN0LW9iai15IGFsc28gaW5jbHVkZWQgcW9zLXRlc3QubyB3
aGljaCBkZWZpbmVzIGEgbWFpbigpLg0KVGhpcyBtYWRlIGl0IGRpZmZpY3VsdCB0byByZXB1cnBv
c2UgcW9zLXRlc3Qtb2JqLXkgdG8gbGluayBhbnl0aGluZw0KYmVzaWRlIHRlc3RzL3Fvcy10ZXN0
IGFnYWluc3QgbGlicW9zLiBUaGlzIGNoYW5nZSBzZXBhcmF0ZXMgb2JqZWN0cyB0aGF0DQphcmUg
bGlicW9zLXNwZWNpZmljIGFuZCBvbmVzIHRoYXQgYXJlIHFvcy10ZXN0IHNwZWNpZmljIGludG8g
ZGlmZmVyZW50DQp2YXJpYWJsZXMuDQoNClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBCdWxla292
IDxhbHhuZHJAYnUuZWR1Pg0KUmV2aWV3ZWQtYnk6IERhcnJlbiBLZW5ueSA8ZGFycmVuLmtlbm55
QG9yYWNsZS5jb20+DQpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVk
aGF0LmNvbT4NCi0tLQ0KIHRlc3RzL3F0ZXN0L01ha2VmaWxlLmluY2x1ZGUgfCA3MSArKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0
aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9NYWtl
ZmlsZS5pbmNsdWRlIGIvdGVzdHMvcXRlc3QvTWFrZWZpbGUuaW5jbHVkZQ0KaW5kZXggZTZiYjRh
YjI4Yy4uMDhhNDhjMTI1MiAxMDA2NDQNCi0tLSBhL3Rlc3RzL3F0ZXN0L01ha2VmaWxlLmluY2x1
ZGUNCisrKyBiL3Rlc3RzL3F0ZXN0L01ha2VmaWxlLmluY2x1ZGUNCkBAIC0xNTcsNTIgKzE1Nyw1
MyBAQCBjaGVjay1xdGVzdC1zMzkweC15ICs9IG1pZ3JhdGlvbi10ZXN0DQogIyBsaWJxb3MgLyBx
Z3JhcGggOg0KIGxpYnFncmFwaC1vYmoteSA9IHRlc3RzL3F0ZXN0L2xpYnFvcy9xZ3JhcGgubw0K
IA0KLWxpYnFvcy1vYmoteSA9ICQobGlicWdyYXBoLW9iai15KSB0ZXN0cy9xdGVzdC9saWJxb3Mv
cGNpLm8gdGVzdHMvcXRlc3QvbGlicW9zL2Z3X2NmZy5vDQotbGlicW9zLW9iai15ICs9IHRlc3Rz
L3F0ZXN0L2xpYnFvcy9tYWxsb2Mubw0KLWxpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJx
b3MvbGlicW9zLm8NCi1saWJxb3Mtc3BhcHItb2JqLXkgPSAkKGxpYnFvcy1vYmoteSkgdGVzdHMv
cXRlc3QvbGlicW9zL21hbGxvYy1zcGFwci5vDQorbGlicW9zLWNvcmUtb2JqLXkgPSAkKGxpYnFn
cmFwaC1vYmoteSkgdGVzdHMvcXRlc3QvbGlicW9zL3BjaS5vIHRlc3RzL3F0ZXN0L2xpYnFvcy9m
d19jZmcubw0KK2xpYnFvcy1jb3JlLW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy9tYWxsb2Mu
bw0KK2xpYnFvcy1jb3JlLW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy9saWJxb3Mubw0KK2xp
YnFvcy1zcGFwci1vYmoteSA9ICQobGlicW9zLWNvcmUtb2JqLXkpIHRlc3RzL3F0ZXN0L2xpYnFv
cy9tYWxsb2Mtc3BhcHIubw0KIGxpYnFvcy1zcGFwci1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJx
b3MvbGlicW9zLXNwYXByLm8NCiBsaWJxb3Mtc3BhcHItb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGli
cW9zL3J0YXMubw0KIGxpYnFvcy1zcGFwci1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvcGNp
LXNwYXByLm8NCi1saWJxb3MtcGMtb2JqLXkgPSAkKGxpYnFvcy1vYmoteSkgdGVzdHMvcXRlc3Qv
bGlicW9zL3BjaS1wYy5vDQorbGlicW9zLXBjLW9iai15ID0gJChsaWJxb3MtY29yZS1vYmoteSkg
dGVzdHMvcXRlc3QvbGlicW9zL3BjaS1wYy5vDQogbGlicW9zLXBjLW9iai15ICs9IHRlc3RzL3F0
ZXN0L2xpYnFvcy9tYWxsb2MtcGMubyB0ZXN0cy9xdGVzdC9saWJxb3MvbGlicW9zLXBjLm8NCiBs
aWJxb3MtcGMtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL2FoY2kubw0KIGxpYnFvcy11c2It
b2JqLXkgPSAkKGxpYnFvcy1zcGFwci1vYmoteSkgJChsaWJxb3MtcGMtb2JqLXkpIHRlc3RzL3F0
ZXN0L2xpYnFvcy91c2Iubw0KIA0KICMgcW9zIGRldmljZXM6DQotcW9zLXRlc3Qtb2JqLXkgPSB0
ZXN0cy9xdGVzdC9xb3MtdGVzdC5vICQobGlicWdyYXBoLW9iai15KQ0KLXFvcy10ZXN0LW9iai15
ICs9ICQobGlicW9zLXBjLW9iai15KSAkKGxpYnFvcy1zcGFwci1vYmoteSkNCi1xb3MtdGVzdC1v
YmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvZTEwMDBlLm8NCi1xb3MtdGVzdC1vYmoteSArPSB0
ZXN0cy9xdGVzdC9saWJxb3MvaTJjLm8NCi1xb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVzdC9s
aWJxb3MvaTJjLWlteC5vDQotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL2ky
Yy1vbWFwLm8NCi1xb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3Mvc2RoY2kubw0K
LXFvcy10ZXN0LW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy90cGNpMjAwLm8NCi1xb3MtdGVz
dC1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLm8NCi1xb3MtdGVzdC1vYmotJChD
T05GSUdfVklSVEZTKSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLTlwLm8NCi1xb3MtdGVz
dC1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLWJhbGxvb24ubw0KLXFvcy10ZXN0
LW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0aW8tYmxrLm8NCi1xb3MtdGVzdC1vYmot
eSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLW1taW8ubw0KLXFvcy10ZXN0LW9iai15ICs9
IHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0aW8tbmV0Lm8NCi1xb3MtdGVzdC1vYmoteSArPSB0ZXN0
cy9xdGVzdC9saWJxb3MvdmlydGlvLXBjaS5vDQotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRl
c3QvbGlicW9zL3ZpcnRpby1wY2ktbW9kZXJuLm8NCi1xb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9x
dGVzdC9saWJxb3MvdmlydGlvLXJuZy5vDQotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3Qv
bGlicW9zL3ZpcnRpby1zY3NpLm8NCi1xb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJx
b3MvdmlydGlvLXNlcmlhbC5vDQorbGlicW9zLW9iai15ID0gICQobGlicWdyYXBoLW9iai15KQ0K
K2xpYnFvcy1vYmoteSArPSAkKGxpYnFvcy1wYy1vYmoteSkgJChsaWJxb3Mtc3BhcHItb2JqLXkp
DQorbGlicW9zLW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy9lMTAwMGUubw0KK2xpYnFvcy1v
YmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvaTJjLm8NCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMv
cXRlc3QvbGlicW9zL2kyYy1pbXgubw0KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJx
b3MvaTJjLW9tYXAubw0KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3Mvc2RoY2ku
bw0KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdHBjaTIwMC5vDQorbGlicW9z
LW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0aW8ubw0KK2xpYnFvcy1vYmotJChDT05G
SUdfVklSVEZTKSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLTlwLm8NCitsaWJxb3Mtb2Jq
LXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL3ZpcnRpby1iYWxsb29uLm8NCitsaWJxb3Mtb2JqLXkg
Kz0gdGVzdHMvcXRlc3QvbGlicW9zL3ZpcnRpby1ibGsubw0KK2xpYnFvcy1vYmoteSArPSB0ZXN0
cy9xdGVzdC9saWJxb3MvdmlydGlvLW1taW8ubw0KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVz
dC9saWJxb3MvdmlydGlvLW5ldC5vDQorbGlicW9zLW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFv
cy92aXJ0aW8tcGNpLm8NCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL3ZpcnRp
by1wY2ktbW9kZXJuLm8NCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL3ZpcnRp
by1ybmcubw0KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLXNjc2ku
bw0KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLXNlcmlhbC5vDQog
DQogIyBxb3MgbWFjaGluZXM6DQotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9z
L2FhcmNoNjQteGxueC16Y3UxMDItbWFjaGluZS5vDQotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMv
cXRlc3QvbGlicW9zL2FybS1pbXgyNS1wZGstbWFjaGluZS5vDQotcW9zLXRlc3Qtb2JqLXkgKz0g
dGVzdHMvcXRlc3QvbGlicW9zL2FybS1uODAwLW1hY2hpbmUubw0KLXFvcy10ZXN0LW9iai15ICs9
IHRlc3RzL3F0ZXN0L2xpYnFvcy9hcm0tcmFzcGkyLW1hY2hpbmUubw0KLXFvcy10ZXN0LW9iai15
ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy9hcm0tc2FicmVsaXRlLW1hY2hpbmUubw0KLXFvcy10ZXN0
LW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy9hcm0tc21ka2MyMTAtbWFjaGluZS5vDQotcW9z
LXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL2FybS12aXJ0LW1hY2hpbmUubw0KLXFv
cy10ZXN0LW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy9hcm0teGlsaW54LXp5bnEtYTktbWFj
aGluZS5vDQotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL3BwYzY0X3BzZXJp
ZXMtbWFjaGluZS5vDQotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL3g4Nl82
NF9wYy1tYWNoaW5lLm8NCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL2FhcmNo
NjQteGxueC16Y3UxMDItbWFjaGluZS5vDQorbGlicW9zLW9iai15ICs9IHRlc3RzL3F0ZXN0L2xp
YnFvcy9hcm0taW14MjUtcGRrLW1hY2hpbmUubw0KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVz
dC9saWJxb3MvYXJtLW44MDAtbWFjaGluZS5vDQorbGlicW9zLW9iai15ICs9IHRlc3RzL3F0ZXN0
L2xpYnFvcy9hcm0tcmFzcGkyLW1hY2hpbmUubw0KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVz
dC9saWJxb3MvYXJtLXNhYnJlbGl0ZS1tYWNoaW5lLm8NCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMv
cXRlc3QvbGlicW9zL2FybS1zbWRrYzIxMC1tYWNoaW5lLm8NCitsaWJxb3Mtb2JqLXkgKz0gdGVz
dHMvcXRlc3QvbGlicW9zL2FybS12aXJ0LW1hY2hpbmUubw0KK2xpYnFvcy1vYmoteSArPSB0ZXN0
cy9xdGVzdC9saWJxb3MvYXJtLXhpbGlueC16eW5xLWE5LW1hY2hpbmUubw0KK2xpYnFvcy1vYmot
eSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvcHBjNjRfcHNlcmllcy1tYWNoaW5lLm8NCitsaWJxb3Mt
b2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL3g4Nl82NF9wYy1tYWNoaW5lLm8NCiANCiAjIHFv
cyB0ZXN0czoNCitxb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVzdC9xb3MtdGVzdC5vDQogcW9z
LXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvYWM5Ny10ZXN0Lm8NCiBxb3MtdGVzdC1vYmoteSAr
PSB0ZXN0cy9xdGVzdC9kczEzMzgtdGVzdC5vDQogcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRl
c3QvZTEwMDAtdGVzdC5vDQpAQCAtMjM0LDcgKzIzNSw3IEBAIGNoZWNrLXVuaXQteSArPSB0ZXN0
cy90ZXN0LXFncmFwaCQoRVhFU1VGKQ0KIHRlc3RzL3Rlc3QtcWdyYXBoJChFWEVTVUYpOiB0ZXN0
cy90ZXN0LXFncmFwaC5vICQobGlicWdyYXBoLW9iai15KQ0KIA0KIGNoZWNrLXF0ZXN0LWdlbmVy
aWMteSArPSBxb3MtdGVzdA0KLXRlc3RzL3F0ZXN0L3Fvcy10ZXN0JChFWEVTVUYpOiAkKHFvcy10
ZXN0LW9iai15KQ0KK3Rlc3RzL3F0ZXN0L3Fvcy10ZXN0JChFWEVTVUYpOiAkKHFvcy10ZXN0LW9i
ai15KSAkKGxpYnFvcy1vYmoteSkNCiANCiAjIFFUZXN0IGRlcGVuZGVuY2llczoNCiB0ZXN0cy9x
dGVzdC9xbXAtdGVzdCQoRVhFU1VGKTogdGVzdHMvcXRlc3QvcW1wLXRlc3Qubw0KLS0gDQoyLjIz
LjANCg0K

