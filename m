Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9832C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51422071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="r5QwkO/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51422071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg2M-0004g7-Pb
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzc-0007tx-2D
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfza-0001yA-GN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:24 -0500
Received: from mail-mw2nam10on2110.outbound.protection.outlook.com
 ([40.107.94.110]:45280 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfza-0001tn-7U
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyzAB66gdcjN+eIJEhSxJvhm42qDxS3eVF5Rv7DZ4OpDk0wf+8H5JUP5n8+pRuUPWcZax+nxZxjsTXd4O91p9PMvg4OBRGHX0KNJSkYm6lJDyK9PAxlQBki9ZyfTTm1NyC6KMvXK1GZnYVwT+elhIsYcaqWM9xKLb6YbVM8TTHgCOOYIbtGExJQNdBaN+p1MgNH70WPL34qaQlDcOKVQysZ96S+FRiA0ZHHIDS3PGoW6mgbULCYBWdy9Z+tweq0QGfXNzZxVVAkEFjyQKjlbEap1BMGMsUu9FHO4W4tk4WAOL/1A6149ns8SfRMKoqF/fRCSPXMMbhAiRWZ56ztPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMCyJN3nzC2ixzb7DkXR5cQ3SesaeOMGZjfVp8Oc6oQ=;
 b=B9yzvlFU12zkefbTTqVpNjaV5vPQsgDziWeyK23BzxZjCbPBOussRi61bRHnmHIfTd1fLtw1jfcRTbnpkT7ttF5tZryqm8rd7ILvQsJXLcvrfwh1xsQDQnS687f4DRiiA/VenlI6LV5U1er9r3i80SHct2NGRE45ds1ob2e2/QcG1vAw+ILaIvo3LSkOieD6LabfCOkMTKEjTchxB6RsV+XUKQA1Frs0t0p+sUpNbcZZyYa2EmoWhZ5jHPGtEjf96sZ/163ocRXfaBYdnCEfcts9NVOGtaU4hcuB6cgTrfMfZsBZRr/S80Q4uVbanHwuEOJlMok10fM1DosXMXXscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMCyJN3nzC2ixzb7DkXR5cQ3SesaeOMGZjfVp8Oc6oQ=;
 b=r5QwkO/4CL/21eFVZcXT0fBJRW0FkRzakbRX4ZTNSkBvZSliy+V5IvAoIK/Pbsj6C/qLcqfUSTzyBjGw7FWINWFjrOftXQWwYoEpYeCdYdqZPdQOU9MHYyQxMqxnYmir918D1vpltn4FSy6Vu8uUqN4Nmr6JESXYOM/eo8wVEv8=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:21 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:21 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:18 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 09/21] libqos: split qos-test and libqos makefile vars
Thread-Topic: [PATCH v8 09/21] libqos: split qos-test and libqos makefile vars
Thread-Index: AQHV1mXAnqhNAPsH+EumEwZ5o7EBVg==
Date: Wed, 29 Jan 2020 05:34:18 +0000
Message-ID: <20200129053357.27454-10-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24b72875-e1a6-4dad-62a3-08d7a47ce309
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4206B22A2DDCAA67B2E62876BA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2THsEF2sMBK/Q1Dn/ppOQ39SXh866ahiafu5HL9C31fNIHWExoO8twb35THdqeKiZWm5dBqpX0xprN6fMkGBvZqRcUCYee+CoP5AXcspD+MGW4zDARWncsXBLBBWEDl+sEk6rXP15SsJyRKfGaQmSip+MTwfv3oJlOD1ue8DGOrT4eQBJ/5Rnfq7ZCRrtPGPootxXxJGFcv3Y3pKN7J4t921toT9onV7bYASt916PhmBI0/LskfmeVEhO1uilhMHYCWLgzY+XN21ZrQf3T4Cn4EulEG7NyVphJU2+85oakY9DHuIRHbOVmITW4D/tIirMFmz1g/kaEU8tOdgWyNqJgEha1YN/V1/U2ajmZrVRPn+JFwAY9N7CXDUAPDB7FbhCGLQ47jkQ+CEAjK1rVjVz4NMY2pkPIgqnZnKtMeHK8mCKZb62ll4A2V4+aWdagYE
x-ms-exchange-antispam-messagedata: SOgtBy9EoEvlUTQu4LuZOuXKRjwF3H0zVc+TboO+MG45lHbj5BdP3QW98qeNKUW9sjdHvqK6wPrJYfavmxojTr/Uke3TgUynNByPhB+Q3AvyLPK6r5/8aKdtwy2oeoqkf6o2gW38WO4CthUV76OcdQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <53578642B95A8243A7F3A9E639E2294B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b72875-e1a6-4dad-62a3-08d7a47ce309
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:19.0236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCEKbM3Y034r0SOCiB3e4mBuKLX2T0YZqzhvS2MOVm+7e3mTIAXZHgp/CuB72IV3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.110
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

