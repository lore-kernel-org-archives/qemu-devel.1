Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD32C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9790B20720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="BGUx0p7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9790B20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg0Y-0000ya-Mp
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzW-0007jC-0C
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzU-0001sg-R8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:17 -0500
Received: from mail-mw2nam10on2091.outbound.protection.outlook.com
 ([40.107.94.91]:22496 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzU-0001pW-KV
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fi3VyuZZp+cVBDqsxi3SEPnpY0QVIRNFuEh4hv64T1ZVVnrvi7rBc6We1l/BcB2TUUkxGNVvihNbkzJkduIaiQ/OQJCbr6smBXKWrRI5adTUL4AlPiBCjJL2KI+Ikd+KiG8L1v/Q7dZep+HjuQKSvW8mZAow/rw2XvY0rxjZ/Az5X6397Bo86OYKfd2vl4ycsKSR1mfOHAyENTsz4f8mP3V5xOQIMJOtv63RQ04PYNxJyBEgryho0ksj7lIWQbBXAWgisWeqMbSJZfcqQuEsXTI/YmY/I6xokm4cRfZVeJiFl+F09o0UWITLdJXQCJzl0Yv3K6FeZnx2oKbn0T+qwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns3uR7r40f3Hn5it1jv0Pcc2ZA1fNyAHsn2M9Jhx4kw=;
 b=mgsEMa/egjp02WTgxN7KzsBLsrKvG194rpwNyB7iWs+Z79ZZzk1NWBRB2Mcyf2EhVL4xyw7ME3F+aXaghmTESY/vlOt1/z/la/6VO00L1hJqbju0d5ZQBbQld4/IAfK92HexIOPKVC1OPZgyn6+msZWakY4d1JVpNqqhFzTeiIA1L7I3tORll9dYzpxxVEIVKW1NeycxYc0PZioN7zFGA9gU9ZHorIN9I4MuceSbfxUyKG55CSQnoB2vdcVrv3irCOq4xrEq5usKN+8DkM5GxwkTznWjdF06XsWG6bhbfu6iOKM8tjVBYWMeDLTXQbk4r0BXkOYoA/PA1hfQfRcSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns3uR7r40f3Hn5it1jv0Pcc2ZA1fNyAHsn2M9Jhx4kw=;
 b=BGUx0p7bCsZP2N4VC2nnbFNZACLf1yLMDnVzdBIHl5UxkLrZIKXb95/EZA31coA6T2ldj75TGe9wxsMGc4mAb4sp3mDbHZJLv/k0yaTL1jzj1cYUM9GeAGyiZD8YAabFQcQUtSTP2ba5Fl+wlcmnXCcvauXtflmk//UK8LxRbEk=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:13 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:13 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:12 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 02/21] module: check module wasn't already initialized
Thread-Topic: [PATCH v8 02/21] module: check module wasn't already initialized
Thread-Index: AQHV1mW8J29kvaHeSk+VZKIhILv1WQ==
Date: Wed, 29 Jan 2020 05:34:12 +0000
Message-ID: <20200129053357.27454-3-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: a2f5d0ca-cc29-4126-50dc-08d7a47cdf46
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4206D72DA009B4E0913399DEBA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
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
x-microsoft-antispam-message-info: NUKPfaURe8Biowh0iNUXdThEatfbrJCix76w80quDXcn4KA5tWCf7p1VP8Ba/+hpEeP4EPa6ruXQmTQb+odg1AFSuQiNvKeg2Izt7whCEP4klAGkFdhMrH3TLp411mea3OGV1Wp2KDrwAfMoJJ9UadhdQK2cuDsWDXxmxL9Vepzn0fPO0InHOKkY+dbtsaKgR6g/5xFlZfRyjcmLKh5br2kiEfsatR2g6fIB/pLcmwMcMxoZn5a9T8PU8+SZNwSdzSuJmNYDmbdNEPaIviKQIaXG3MWfRKLGW92sX0PmPcCt7F/51foGiRso38SZcTMLhQzESXgXV5vzAUHs4nHsQCeJRWr+9XQyhO0a2HUAAUMrAlQ9A/uP0Jwh1IBT16sGCiEesghmD4pvaGPjC+b41jE8xK/uZmas7EqMC0x7/O1gT1PZnaPe6C1LcEuYrY8z
x-ms-exchange-antispam-messagedata: x+O7V+JjuLrqcKHTa63bE2ZBTr6zFp8C/za5DVJ3yme6L8azopqaO/FEoMvQ19EA0EIxlUwbGk16ntYd2s+HmsbIQx8qAdnGrEng0T6rN2e04MEAQtKndJb9VcB7hBCEUvDvIdZ54ArpYH6fk1oK1w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <35B4B29C345D354A84E701E190FF5EDF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f5d0ca-cc29-4126-50dc-08d7a47cdf46
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:12.7210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYW3xQqo/F2gZzie5hKjGT7SnDotbq4Pb1JcvT3npujtUnb4VtEIr9dg9mYTuM6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.91
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
Cc: "Bulekov,
 Alexander" <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHZpcnR1YWwtZGV2aWNlIGZ1enplciBtdXN0IGluaXRpYWxpemUgUU9NLCBwcmlvciB0byBy
dW5uaW5nDQp2bDpxZW11X2luaXQsIHNvIHRoYXQgaXQgY2FuIHVzZSB0aGUgcW9zX2dyYXBoIHRv
IGlkZW50aWZ5IHRoZSBhcmd1bWVudHMNCnJlcXVpcmVkIHRvIGluaXRpYWxpemUgYSBndWVzdCBm
b3IgbGlicW9zLWFzc2lzdGVkIGZ1enppbmcuIFRoaXMgY2hhbmdlDQpwcmV2ZW50cyBlcnJvcnMg
d2hlbiB2bDpxZW11X2luaXQgdHJpZXMgdG8gKHJlKWluaXRpYWxpemUgdGhlIHByZXZpb3VzbHkN
CmluaXRpYWxpemVkIFFPTSBtb2R1bGUuDQoNClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBCdWxl
a292IDxhbHhuZHJAYnUuZWR1Pg0KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFu
aGFAcmVkaGF0LmNvbT4NClJldmlld2VkLWJ5OiBEYXJyZW4gS2VubnkgPGRhcnJlbi5rZW5ueUBv
cmFjbGUuY29tPg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
cmVkaGF0LmNvbT4NCi0tLQ0KIHV0aWwvbW9kdWxlLmMgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS91dGlsL21vZHVsZS5jIGIvdXRp
bC9tb2R1bGUuYw0KaW5kZXggOGM1MzE1YTdhMy4uMjM2YTdiYjUyYSAxMDA2NDQNCi0tLSBhL3V0
aWwvbW9kdWxlLmMNCisrKyBiL3V0aWwvbW9kdWxlLmMNCkBAIC0zMCw2ICszMCw3IEBAIHR5cGVk
ZWYgc3RydWN0IE1vZHVsZUVudHJ5DQogdHlwZWRlZiBRVEFJTFFfSEVBRCgsIE1vZHVsZUVudHJ5
KSBNb2R1bGVUeXBlTGlzdDsNCiANCiBzdGF0aWMgTW9kdWxlVHlwZUxpc3QgaW5pdF90eXBlX2xp
c3RbTU9EVUxFX0lOSVRfTUFYXTsNCitzdGF0aWMgYm9vbCBtb2R1bGVzX2luaXRfZG9uZVtNT0RV
TEVfSU5JVF9NQVhdOw0KIA0KIHN0YXRpYyBNb2R1bGVUeXBlTGlzdCBkc29faW5pdF9saXN0Ow0K
IA0KQEAgLTkxLDExICs5MiwxNyBAQCB2b2lkIG1vZHVsZV9jYWxsX2luaXQobW9kdWxlX2luaXRf
dHlwZSB0eXBlKQ0KICAgICBNb2R1bGVUeXBlTGlzdCAqbDsNCiAgICAgTW9kdWxlRW50cnkgKmU7
DQogDQorICAgIGlmIChtb2R1bGVzX2luaXRfZG9uZVt0eXBlXSkgew0KKyAgICAgICAgcmV0dXJu
Ow0KKyAgICB9DQorDQogICAgIGwgPSBmaW5kX3R5cGUodHlwZSk7DQogDQogICAgIFFUQUlMUV9G
T1JFQUNIKGUsIGwsIG5vZGUpIHsNCiAgICAgICAgIGUtPmluaXQoKTsNCiAgICAgfQ0KKw0KKyAg
ICBtb2R1bGVzX2luaXRfZG9uZVt0eXBlXSA9IHRydWU7DQogfQ0KIA0KICNpZmRlZiBDT05GSUdf
TU9EVUxFUw0KLS0gDQoyLjIzLjANCg0K

