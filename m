Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD3C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 05:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D89B2073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 05:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="2TeSmJpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D89B2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQ3q-0000iZ-63
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 00:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1L-0006ip-U8
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1J-0006E1-UY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:43 -0500
Received: from mail-bn7nam10on2099.outbound.protection.outlook.com
 ([40.107.92.99]:53408 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1J-0006Cs-MA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3QfVFIWiDKl2GQYk9ClfAVaVvH0SD6VCmDa/I9bEBWYDqnh2ib9ZWpk5q7I/PWWXC5Jnj2Fyf6nN9ptZfu/zXGL5tvpAefwkvvLa7sJss94UlQMFDV90Ajr5bWmHYcajv82LIcLZf7K4Q8KbImVkm+PmTcyJ83Y5dK7QQqTUF7reGgFIkZLSwn75tTDO6+xPn5yIzjDcwQYZvRIfx/DkeHMt1ZAUFr88WzQsTt8EZNAcrfZkXiKfsmDg4MYjvS1yEEyiPSDfwnrO1jt2siaVjc5CuHIqtw6Ykgr7WkeLVc+z4fR8H6VQxpSQI0qlHRa1dLIDNO0PBnsb1PqzUhW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p+vnp0YfLcJ3PMsvU71rd3zLjwt6HcuY0L1Ue0bJ04=;
 b=JdjZb2nBWXCDaW2h8FR+iPA893xEZDtGDmUL2J3O6uULqH33p5Lg4pH3zeF6C4es4nQKvBc5RZAJk/qPrq1kqTChi4J6OnBBqwLGfy9Yple+Dcovl4Olhzre3cHawIbY6KZf0BS/px2Lfkxdj3hZHATDInCl6MCaj88lqt3xpcme7HPj3pEanA91pneDmIruASFIGWX6HZlKb5jB2TxygxxpZZFBK1lgiP9/nEEiiLvWBZsUG18Gcw1Ocb2xttTUM3cIG+74Guvuuz9RzcknMEAB/1aqCH7ZiXSu1Y4R0ZKSFDADBknyZd9Umr8NjXgS2osgSIuHJU3WuFyUviMsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p+vnp0YfLcJ3PMsvU71rd3zLjwt6HcuY0L1Ue0bJ04=;
 b=2TeSmJpV9JSuCy+6iErWwPKaVjvdHuMofr0eSDpVkajuKPWozxsrJDG0z7mdh7BATzBdQjWhHMzWIJxuxSBJSbdioTiy/Knify2K5pIttZDMX/DCzYZBPtxGEIVzC9O4lNH5n1DB3Vsh13tC5vWhaMc8QlQMB2JuiRx4uETamSA=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:38 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:37 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:35 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 00/20] Add virtual device fuzzing support
Thread-Topic: [PATCH v7 00/20] Add virtual device fuzzing support
Thread-Index: AQHVz1YY2lxtSCrptUaA4yCliGgtbg==
Date: Mon, 20 Jan 2020 05:54:36 +0000
Message-ID: <20200120055410.22322-1-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: dbe01f4a-3fc6-4d85-dd9d-08d79d6d3af5
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB439917C754FB6BCA9127F73EBA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
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
x-microsoft-antispam-message-info: euOHHAvrioJk6S0304yyHQlgy61FOHoAWMfde3cdCHIiTZav2U5JRTR9HRBntJ5MA+IK7PbtnCmRBY+HLYc974YgmkyC6+d15D4uuQPw8iM1fHFsAxq3coqN+O71NLntmsIp0TzIhWrqEOax/gM4Tr1Zl72yv1SZrgy7FAFzbPTOstiXhvTdnC4DUB47Nva0ee13NoJzRZ+WKuK63qfUbxnrF85NH7h/5YcqoI1W257xXyLXh6NJQ+rrA5I9MB1rcajRxMB4JVp0nzwVWQLqnFwXtlpIyQsjsYlBW04CoAqsnrAnEfRwErGVRW5yZZtphxJrPOGlXn8WUHZGfE/xnIl9titfQs74jbeArd0WXDTLVGvNMAQQbrPYfCFBmQ+XBznfxhNkkI9Pae328ntbmFh6MT1mqY6ONbVF30o3+58QkTVRgKXRUIOPXrv9FnB/
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8992C8BE22BB7449C5D0165F3B0B77F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe01f4a-3fc6-4d85-dd9d-08d79d6d3af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:36.9957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWoGlkmJ4XleGfh57J30UEHb47nX7F928EF3jwGyi+pcDpO82gbbUS0C0pqxEnWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.99
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
 "darren.kenny@oracle.com" <darren.kenny@oracle.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Bulekov, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBzZXJpZXMgYWRkcyBhIGZyYW1ld29yayBmb3IgY292ZXJhZ2UtZ3VpZGVkIGZ1enppbmcg
b2YNCnZpcnR1YWwtZGV2aWNlcy4gRnV6emluZyB0YXJnZXRzIGFyZSBiYXNlZCBvbiBxdGVzdCBh
bmQgY2FuIG1ha2UgdXNlIG9mDQp0aGUgbGlicW9zIGFic3RyYWN0aW9ucy4NCg0KVGhpcyB2ZXJz
aW9uIG1vc3RseSBjb250YWlucyBjbGVhbnVwIHdpdGggc29tZSBjaGFuZ2VzIHRvIHRoZSB2aXJ0
aW8tbmV0DQpmdXp6ZXIuDQoNClY3Og0KICogdmlydGlvLW5ldDogYWRkIHZpcnRpby1uZXQtY2hl
Y2stdXNlZCB3aGljaCB3YWl0cyBmb3IgaW5wdXRzIG9uDQogdGhlIHR4L2N0cmwgdnEgYnkgd2F0
Y2hpbmcgdGhlIHVzZWQgdnJpbmcuDQogKiB2aXJ0aW8tbmV0OiBhZGQgdmlydGlvLW5ldC1zb2Nr
ZXQgd2hpY2ggdXNlcyB0aGUgc29ja2V0IGJhY2tlbmQgYW5kIGNhbg0KIGV4ZXJjaXNlIHRoZSBy
eCBjb21wb25lbnRzIG9mIHZpcnRpby1uZXQuDQogKiB2aXJ0aW8tbmV0OiBhZGQgdmlydGlvLW5l
dC1zbGlycCB3aGljaCB1c2VzIHRoZSB1c2VyIGJhY2tlbmQgYW5kIGV4ZXJjaXNlcw0KIHNsaXJw
LiBUaGlzIG1heSBsZWFkIHRvIHJlYWwgdHJhZmZpYyBlbWl0dGVkIGJ5IHFlbXUgc28gaXQgaXMg
YmVzdCB0bw0KIHJ1biBpbiBhbiBpc29sYXRlZCBuZXR3b3JrIGVudmlyb25tZW50Lg0KICogYnVp
bGQgc2hvdWxkIHN1Y2NlZWQgYWZ0ZXIgZWFjaCBjb21taXQNCg0KVjUvVjY6DQogKiBhZGRlZCB2
aXJ0aW8tc2NzaSBmdXp6ZXINCiAqIGFkZCBzdXBwb3J0IGZvciB1c2luZyBmb3JrLWJhc2VkIGZ1
enplcnMgd2l0aCBtdWx0aXBsZSBsaWJmdXp6ZXINCiAgIHdvcmtlcnMNCiAqIG1pc2MgZml4ZXMg
YWRkcmVzc2luZyBWNCBjb21tZW50cw0KICogY2xlYW51cCBpbi1wcm9jZXNzIGhhbmRsZXJzL2ds
b2JhbHMgaW4gbGlicXRlc3QuYw0KICogc21hbGwgZml4ZXMgdG8gZm9yay1iYXNlZCBmdXp6aW5n
IGFuZCBzdXBwb3J0IGZvciBtdWx0aXBsZSB3b3JrZXJzDQogKiBjaGFuZ2VzIHRvIHRoZSB2aXJ0
aW8tbmV0IGZ1enplciB0byBraWNrIGFmdGVyIGVhY2ggdnEgYWRkDQoNClY0Og0KICogYWRkL3Ry
YW5zZmVyIGxpY2Vuc2UgaGVhZGVycyB0byBuZXcgZmlsZXMNCiAqIHJlc3RydWN0dXJlIHRoZSBh
ZGRlZCBRVGVzdENsaWVudFRyYW5zcG9ydE9wcyBzdHJ1Y3QNCiAqIHJlc3RydWN0dXJlIHRoZSBG
dXp6VGFyZ2V0IHN0cnVjdCBhbmQgZnV6emVyIHNrZWxldG9uDQogKiBmb3JrLWJhc2VkIGZ1enpl
ciBub3cgZGlyZWN0bHkgbW1hcHMgc2htIG92ZXIgdGhlIGNvdmVyYWdlIGJpdG1hcHMNCiAqIGZp
eGVzIHRvIGk0NDAgYW5kIHZpcnRpby1uZXQgZnV6eiB0YXJnZXRzDQogKiB1bmRvIHRoZSBjaGFu
Z2VzIHRvIHF0ZXN0X21lbXdyaXRlDQogKiBwb3NzaWJsZSB0byBidWlsZCAvZnV6eiBhbmQgL2Fs
bCBpbiB0aGUgc2FtZSBidWlsZC1kaXINCiAqIG1pc2MgZml4ZXMgdG8gYWRkcmVzcyBWMyBjb21t
ZW50cw0KDQpWMzoNCiAqIHJlYmFzZWQgb250byB2NC4xLjArDQogKiBhZGQgdGhlIGZ1enplciBh
cyBhIG5ldyBidWlsZC10YXJnZXQgdHlwZSBpbiB0aGUgYnVpbGQtc3lzdGVtDQogKiBhZGQgaW5k
aXJlY3Rpb24gdG8gcXRlc3QgY2xpZW50L3NlcnZlciBjb21tdW5pY2F0aW9uIGZ1bmN0aW9ucw0K
ICogcmVtb3ZlIHJhbWZpbGUgYW5kIHNuYXBzaG90LWJhc2VkIGZ1enppbmcgc3VwcG9ydA0KICog
YWRkIGk0NDBmeCBmdXp6LXRhcmdldCBhcyBhIHJlZmVyZW5jZSBmb3IgZGV2ZWxvcGVycy4NCiAq
IGFkZCBsaW5rZXItc2NyaXB0IHRvIGFzc2lzdCB3aXRoIGZvcmstYmFzZWQgZnV6emVyDQoNClYy
Og0KICogc3BsaXQgb2ZmIGNoYW5nZXMgdG8gcW9zIHZpcnRpby1uZXQgYW5kIHF0ZXN0IHNlcnZl
ciB0byBvdGhlciBwYXRjaGVzDQogKiBtb3ZlIHZsOm1haW4gaW5pdGlhbGl6YXRpb24gaW50byBu
ZXcgZnVuYzogcWVtdV9pbml0DQogKiBtb3ZlZCB1c2VmdWwgZnVuY3Rpb25zIGZyb20gcW9zLXRl
c3QuYyB0byBhIHNlcGFyYXRlIG9iamVjdA0KICogdXNlIHN0cnVjdCBvZiBmdW5jdGlvbiBwb2lu
dGVycyBmb3IgYWRkX2Z1enpfdGFyZ2V0KCksIGluc3RlYWQgb2YNCiAgIGFyZ3VtZW50cw0KICog
bW92ZSByYW1maWxlIHRvIG1pZ3JhdGlvbi9xZW11LWZpbGUNCiAqIHJld3JpdGUgZm9yay1iYXNl
ZCBmdXp6ZXIgcGVuZGluZyBwYXRjaCB0byBsaWJmdXp6ZXINCiAqIHBhc3MgY2hlY2stcGF0Y2gN
Cg0KDQpBbGV4YW5kZXIgQnVsZWtvdiAoMjApOg0KICBzb2Z0bW11OiBzcGxpdCBvZmYgdmwuYzpt
YWluKCkgaW50byBtYWluLmMNCiAgbW9kdWxlOiBjaGVjayBtb2R1bGUgd2Fzbid0IGFscmVhZHkg
aW5pdGlhbGl6ZWQNCiAgZnV6ejogYWRkIEZVWlpfVEFSR0VUIG1vZHVsZSB0eXBlDQogIHF0ZXN0
OiBhZGQgcXRlc3Rfc2VydmVyX3NlbmQgYWJzdHJhY3Rpb24NCiAgbGlicXRlc3Q6IGFkZCBhIGxh
eWVyIG9mIGFic3RyYWN0aW9uIHRvIHNlbmQvcmVjdg0KICBsaWJxdGVzdDogbWFrZSBidWZ3cml0
ZSByZWx5IG9uIHRoZSBUcmFuc3BvcnRPcHMNCiAgcXRlc3Q6IGFkZCBpbi1wcm9jZXNzIGluY29t
aW5nIGNvbW1hbmQgaGFuZGxlcg0KICBsaWJxb3M6IHJlbmFtZSBpMmNfc2VuZCBhbmQgaTJjX3Jl
Y3YNCiAgbGlicW9zOiBzcGxpdCBxb3MtdGVzdCBhbmQgbGlicW9zIG1ha2VmaWxlIHZhcnMNCiAg
bGlicW9zOiBtb3ZlIHVzZWZ1bCBxb3MtdGVzdCBmdW5jcyB0byBxb3NfZXh0ZXJuYWwNCiAgZnV6
ejogYWRkIGZ1enplciBza2VsZXRvbg0KICBleGVjOiBrZWVwIHJhbSBibG9jayBhY3Jvc3MgZm9y
ayB3aGVuIHVzaW5nIHF0ZXN0DQogIGZ1eno6IHN1cHBvcnQgZm9yIGZvcmstYmFzZWQgZnV6emlu
Zy4NCiAgZnV6ejogYWRkIHN1cHBvcnQgZm9yIHFvcy1hc3Npc3RlZCBmdXp6IHRhcmdldHMNCiAg
ZnV6ejogYWRkIHRhcmdldC9mdXp6IG1ha2VmaWxlIHJ1bGVzDQogIGZ1eno6IGFkZCBjb25maWd1
cmUgZmxhZyAtLWVuYWJsZS1mdXp6aW5nDQogIGZ1eno6IGFkZCBpNDQwZnggZnV6eiB0YXJnZXRz
DQogIGZ1eno6IGFkZCB2aXJ0aW8tbmV0IGZ1enogdGFyZ2V0DQogIGZ1eno6IGFkZCB2aXJ0aW8t
c2NzaSBmdXp6IHRhcmdldA0KICBmdXp6OiBhZGQgZG9jdW1lbnRhdGlvbiB0byBkb2NzL2RldmVs
Lw0KDQogTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTYgKy0NCiBNYWtl
ZmlsZS5vYmpzICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQogTWFrZWZpbGUudGFyZ2V0
ICAgICAgICAgICAgICAgICAgICAgfCAgMTggKystDQogY29uZmlndXJlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMzkgKysrKysNCiBkb2NzL2RldmVsL2Z1enppbmcudHh0ICAgICAgICAg
ICAgICB8IDExNiArKysrKysrKysrKysrKw0KIGV4ZWMuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDEyICstDQogaW5jbHVkZS9xZW11L21vZHVsZS5oICAgICAgICAgICAgICAgfCAg
IDQgKy0NCiBpbmNsdWRlL3N5c2VtdS9xdGVzdC5oICAgICAgICAgICAgICB8ICAgNCArDQogaW5j
bHVkZS9zeXNlbXUvc3lzZW11LmggICAgICAgICAgICAgfCAgIDQgKw0KIG1haW4uYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDUzICsrKysrKysNCiBxdGVzdC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAzMSArKystDQogdGVzdHMvcXRlc3QvTWFrZWZpbGUuaW5jbHVk
ZSAgICAgICAgfCAgNzIgKysrKy0tLS0tDQogdGVzdHMvcXRlc3QvZnV6ei9NYWtlZmlsZS5pbmNs
dWRlICAgfCAgMTggKysrDQogdGVzdHMvcXRlc3QvZnV6ei9mb3JrX2Z1enouYyAgICAgICAgfCAg
NTUgKysrKysrKw0KIHRlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmggICAgICAgIHwgIDIzICsr
Kw0KIHRlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmxkICAgICAgIHwgIDM3ICsrKysrDQogdGVz
dHMvcXRlc3QvZnV6ei9mdXp6LmMgICAgICAgICAgICAgfCAxNzkgKysrKysrKysrKysrKysrKysr
KysrKw0KIHRlc3RzL3F0ZXN0L2Z1enovZnV6ei5oICAgICAgICAgICAgIHwgIDk1ICsrKysrKysr
KysrKw0KIHRlc3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1enouYyAgICAgIHwgMTc4ICsrKysrKysr
KysrKysrKysrKysrKw0KIHRlc3RzL3F0ZXN0L2Z1enovcW9zX2Z1enouYyAgICAgICAgIHwgMjI5
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiB0ZXN0cy9xdGVzdC9mdXp6L3Fvc19mdXp6
LmggICAgICAgICB8ICAzMyArKysrDQogdGVzdHMvcXRlc3QvZnV6ei92aXJ0aW9fbmV0X2Z1enou
YyAgfCAxOTAgKysrKysrKysrKysrKysrKysrKysrKysNCiB0ZXN0cy9xdGVzdC9mdXp6L3ZpcnRp
b19zY3NpX2Z1enouYyB8IDIwMCArKysrKysrKysrKysrKysrKysrKysrKysNCiB0ZXN0cy9xdGVz
dC9saWJxb3MvaTJjLmMgICAgICAgICAgICB8ICAxMCArLQ0KIHRlc3RzL3F0ZXN0L2xpYnFvcy9p
MmMuaCAgICAgICAgICAgIHwgICA0ICstDQogdGVzdHMvcXRlc3QvbGlicW9zL3Fvc19leHRlcm5h
bC5jICAgfCAxNjggKysrKysrKysrKysrKysrKysrKysNCiB0ZXN0cy9xdGVzdC9saWJxb3MvcW9z
X2V4dGVybmFsLmggICB8ICAyOCArKysrDQogdGVzdHMvcXRlc3QvbGlicXRlc3QuYyAgICAgICAg
ICAgICAgfCAxMTkgKysrKysrKysrKysrKy0tDQogdGVzdHMvcXRlc3QvbGlicXRlc3QuaCAgICAg
ICAgICAgICAgfCAgIDQgKw0KIHRlc3RzL3F0ZXN0L3BjYTk1NTItdGVzdC5jICAgICAgICAgIHwg
IDEwICstDQogdGVzdHMvcXRlc3QvcW9zLXRlc3QuYyAgICAgICAgICAgICAgfCAxMzIgKy0tLS0t
LS0tLS0tLS0tLQ0KIHV0aWwvbW9kdWxlLmMgICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsN
CiB2bC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzOCArKy0tLQ0KIDMzIGZp
bGVzIGNoYW5nZWQsIDE5MDQgaW5zZXJ0aW9ucygrKSwgMjI0IGRlbGV0aW9ucygtKQ0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkb2NzL2RldmVsL2Z1enppbmcudHh0DQogY3JlYXRlIG1vZGUgMTAwNjQ0
IG1haW4uYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9mdXp6L01ha2VmaWxlLmlu
Y2x1ZGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvZnV6ei9mb3JrX2Z1enouYw0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9mdXp6L2ZvcmtfZnV6ei5oDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmxkDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IHRlc3RzL3F0ZXN0L2Z1enovZnV6ei5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Rz
L3F0ZXN0L2Z1enovZnV6ei5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2Z1enov
aTQ0MGZ4X2Z1enouYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9mdXp6L3Fvc19m
dXp6LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvZnV6ei9xb3NfZnV6ei5oDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2Z1enovdmlydGlvX25ldF9mdXp6LmMNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvZnV6ei92aXJ0aW9fc2NzaV9mdXp6LmMNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvbGlicW9zL3Fvc19leHRlcm5hbC5jDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2xpYnFvcy9xb3NfZXh0ZXJuYWwuaA0KDQotLSAN
CjIuMjMuMA0KDQo=

