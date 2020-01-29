Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E4DC35240
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431BA20720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="zOzjr8BG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431BA20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg0Z-0000xZ-ED
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzV-0007j9-ET
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzT-0001qa-IM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:16 -0500
Received: from mail-mw2nam10on2091.outbound.protection.outlook.com
 ([40.107.94.91]:22496 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzT-0001pW-83
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJCusPI3tdpAQTnFFNbh/BbTIT+P3oaJ/cqLUbpJN3IsrYTiPnc5muZuOkWr500mt+TZodt97/POZuaHMz1cNXu6WlT3V2Q5ClDhUz9COKVI5cP3c3YllxBB0/Tfk4ehs7q82Q6Qf70FgiFNDMvIqo35eqZtI79c77n5UkUF3rzXVyrkIX6bu3o6KGgpYajWg9D6dEet2MEJqbOwTUAq78VFEjxPA7/uLG6fj3S+gr0zB7hua1J7KNv+4vf73GJQF58cdvBz4qKmMXDbyRdEI71L6H6XDxqSCFVklcUeTSXEk/WJsRHC2S3LmcMRarKOq9YC6qS8E8O4A+QcMa8KWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE8rbnNKUm3xcxX4f44aVvF2XQ3YhiWAvkXfKrclWuc=;
 b=i0Ax48PSPi+rHhRev7pguYWYahFtx9flEAg8XHzSOiREm2AGM8x6zmhWEyoKaeBvOSXrAsUGbVqTZE3pHOYwhcd/4oegHKQS9+ZRb3ioF/ExUFOZCJjBccKHNl5zqLy9wspbOkjhVoo0dXCehxDTVNeIRSkzsnPsXt7TZA06dVpkZoPFq8YhxY3v2ppEYsFEnrzhiG9hoolKZwpsLOHSbDtGDK7o6rQaRK3XkawiYksEMM58SfzcmXbA0cLhRmIdvme0AoKIafYIs8buqkqyfZ470fn6Uy3hR2L50KvkDDzJ2CJ2/BbaWBvbHG43LR7lLwpwnaMMtt6VmaGdT1DKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE8rbnNKUm3xcxX4f44aVvF2XQ3YhiWAvkXfKrclWuc=;
 b=zOzjr8BGAcIz5A7pyabYHdf8Vtnoi0xtztJUIbwL2ngPW74hbVdeKAa/tQvg9Yhz4RlQBMr6ImbmbCiIuo4bG/Y+OwKY9sqAP5lAf3ztcsRa4idGb7CXcrj0km+H5dadMzGV8QpnBs2xT/E9mlId+uWduxT6Ji6BnAmz7QdLtOo=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:11 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:11 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:10 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 00/21] Add virtual device fuzzing support
Thread-Topic: [PATCH v8 00/21] Add virtual device fuzzing support
Thread-Index: AQHV1mW7NwDRzZjdg02Reyy5lPfySw==
Date: Wed, 29 Jan 2020 05:34:11 +0000
Message-ID: <20200129053357.27454-1-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: ccecd3f5-03bd-44d3-9cdb-08d7a47cde52
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB42069490E18E7DBA429BF12DBA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
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
x-microsoft-antispam-message-info: XlfE5zHT2orCnx9Bd/CQLuLi4pcXfMGCeRRxn+W/2YdRweO99OzcwHjxQPeLkWJp1PQIblCzxsWNlT/yoFhSY5DbRa0T7g1FA3vk+wsDwScOXqxYgOkmaHhCukDKHMCD67Mno6dauh9y6gp7r4mJY2Uf09WnUT7QSE8Pj12/ReHmDJLPjtMJrrzMBb4s4JJ8TGCFNU9LNK3ICZCK6Qnh1HH5A2RQH7X4nJasO0KCxIOdWMmzbhwHnSGPDOyvYxMgLHptFo+cTPQ/FvF6VGzllSzDRD0Fu0hWUMrqJCFQ86Yd8/s88zMfYE+GQuX31j3BfqRc3JuudjfQ7jSiQ5K1kayGjVYDpU98DvnaphC2Sh8Ha1ugdgaP4D5cfvZcMPpzbR/LhEaB/T9QaOBPwv3sBaPcI6U9EeQMs+xQRLjJOsBzJfHAEnG1IUwKacxroIMm
x-ms-exchange-antispam-messagedata: kDnPu5J0txzfbeXZwN+ug0FVAxOiruKUTCpqeaMV5yCFHroR1ylavAJj6wdQSNKZMHVhiBbWycFEBexlongz/yNjZMFrZElIG7rm5uwQhwfHqcQqEIbsj1WUSMFNZEVnIGRD+hYvF15o28cY9zk8Bg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDE8381F3901B445B096CE0245B8DEA0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ccecd3f5-03bd-44d3-9cdb-08d7a47cde52
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:11.1399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDCbKuf/DPdUluooSSPsKXeo7768Dj1FVV9GLmo3dzwI7qyyRZy0mZjMq/cG7n4n
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
bmQgY2FuIG1ha2UgdXNlIG9mDQp0aGUgbGlicW9zIGFic3RyYWN0aW9ucy4NCg0KVjg6DQogKiBT
bWFsbCBmaXhlcyB0byB0aGUgdmlydGlvLW5ldC4NCiAqIEtlZXAgcmN1X2F0Zm9yayB3aGVuIG5v
dCB1c2luZyBxdGVzdC4NCg0KVjc6DQogKiB2aXJ0aW8tbmV0OiBhZGQgdmlydGlvLW5ldC1jaGVj
ay11c2VkIHdoaWNoIHdhaXRzIGZvciBpbnB1dHMgb24NCiB0aGUgdHgvY3RybCB2cSBieSB3YXRj
aGluZyB0aGUgdXNlZCB2cmluZy4NCiAqIHZpcnRpby1uZXQ6IGFkZCB2aXJ0aW8tbmV0LXNvY2tl
dCB3aGljaCB1c2VzIHRoZSBzb2NrZXQgYmFja2VuZCBhbmQgY2FuDQogZXhlcmNpc2UgdGhlIHJ4
IGNvbXBvbmVudHMgb2YgdmlydGlvLW5ldC4NCiAqIHZpcnRpby1uZXQ6IGFkZCB2aXJ0aW8tbmV0
LXNsaXJwIHdoaWNoIHVzZXMgdGhlIHVzZXIgYmFja2VuZCBhbmQgZXhlcmNpc2VzDQogc2xpcnAu
IFRoaXMgbWF5IGxlYWQgdG8gcmVhbCB0cmFmZmljIGVtaXR0ZWQgYnkgcWVtdSBzbyBpdCBpcyBi
ZXN0IHRvDQogcnVuIGluIGFuIGlzb2xhdGVkIG5ldHdvcmsgZW52aXJvbm1lbnQuDQogKiBidWls
ZCBzaG91bGQgc3VjY2VlZCBhZnRlciBlYWNoIGNvbW1pdA0KDQpWNS9WNjoNCiAqIGFkZGVkIHZp
cnRpby1zY3NpIGZ1enplcg0KICogYWRkIHN1cHBvcnQgZm9yIHVzaW5nIGZvcmstYmFzZWQgZnV6
emVycyB3aXRoIG11bHRpcGxlIGxpYmZ1enplcg0KICAgd29ya2Vycw0KICogbWlzYyBmaXhlcyBh
ZGRyZXNzaW5nIFY0IGNvbW1lbnRzDQogKiBjbGVhbnVwIGluLXByb2Nlc3MgaGFuZGxlcnMvZ2xv
YmFscyBpbiBsaWJxdGVzdC5jDQogKiBzbWFsbCBmaXhlcyB0byBmb3JrLWJhc2VkIGZ1enppbmcg
YW5kIHN1cHBvcnQgZm9yIG11bHRpcGxlIHdvcmtlcnMNCiAqIGNoYW5nZXMgdG8gdGhlIHZpcnRp
by1uZXQgZnV6emVyIHRvIGtpY2sgYWZ0ZXIgZWFjaCB2cSBhZGQNCg0KVjQ6DQogKiBhZGQvdHJh
bnNmZXIgbGljZW5zZSBoZWFkZXJzIHRvIG5ldyBmaWxlcw0KICogcmVzdHJ1Y3R1cmUgdGhlIGFk
ZGVkIFFUZXN0Q2xpZW50VHJhbnNwb3J0T3BzIHN0cnVjdA0KICogcmVzdHJ1Y3R1cmUgdGhlIEZ1
enpUYXJnZXQgc3RydWN0IGFuZCBmdXp6ZXIgc2tlbGV0b24NCiAqIGZvcmstYmFzZWQgZnV6emVy
IG5vdyBkaXJlY3RseSBtbWFwcyBzaG0gb3ZlciB0aGUgY292ZXJhZ2UgYml0bWFwcw0KICogZml4
ZXMgdG8gaTQ0MCBhbmQgdmlydGlvLW5ldCBmdXp6IHRhcmdldHMNCiAqIHVuZG8gdGhlIGNoYW5n
ZXMgdG8gcXRlc3RfbWVtd3JpdGUNCiAqIHBvc3NpYmxlIHRvIGJ1aWxkIC9mdXp6IGFuZCAvYWxs
IGluIHRoZSBzYW1lIGJ1aWxkLWRpcg0KICogbWlzYyBmaXhlcyB0byBhZGRyZXNzIFYzIGNvbW1l
bnRzDQoNClYzOg0KICogcmViYXNlZCBvbnRvIHY0LjEuMCsNCiAqIGFkZCB0aGUgZnV6emVyIGFz
IGEgbmV3IGJ1aWxkLXRhcmdldCB0eXBlIGluIHRoZSBidWlsZC1zeXN0ZW0NCiAqIGFkZCBpbmRp
cmVjdGlvbiB0byBxdGVzdCBjbGllbnQvc2VydmVyIGNvbW11bmljYXRpb24gZnVuY3Rpb25zDQog
KiByZW1vdmUgcmFtZmlsZSBhbmQgc25hcHNob3QtYmFzZWQgZnV6emluZyBzdXBwb3J0DQogKiBh
ZGQgaTQ0MGZ4IGZ1enotdGFyZ2V0IGFzIGEgcmVmZXJlbmNlIGZvciBkZXZlbG9wZXJzLg0KICog
YWRkIGxpbmtlci1zY3JpcHQgdG8gYXNzaXN0IHdpdGggZm9yay1iYXNlZCBmdXp6ZXINCg0KVjI6
DQogKiBzcGxpdCBvZmYgY2hhbmdlcyB0byBxb3MgdmlydGlvLW5ldCBhbmQgcXRlc3Qgc2VydmVy
IHRvIG90aGVyIHBhdGNoZXMNCiAqIG1vdmUgdmw6bWFpbiBpbml0aWFsaXphdGlvbiBpbnRvIG5l
dyBmdW5jOiBxZW11X2luaXQNCiAqIG1vdmVkIHVzZWZ1bCBmdW5jdGlvbnMgZnJvbSBxb3MtdGVz
dC5jIHRvIGEgc2VwYXJhdGUgb2JqZWN0DQogKiB1c2Ugc3RydWN0IG9mIGZ1bmN0aW9uIHBvaW50
ZXJzIGZvciBhZGRfZnV6el90YXJnZXQoKSwgaW5zdGVhZCBvZg0KICAgYXJndW1lbnRzDQogKiBt
b3ZlIHJhbWZpbGUgdG8gbWlncmF0aW9uL3FlbXUtZmlsZQ0KICogcmV3cml0ZSBmb3JrLWJhc2Vk
IGZ1enplciBwZW5kaW5nIHBhdGNoIHRvIGxpYmZ1enplcg0KICogcGFzcyBjaGVjay1wYXRjaA0K
DQpBbGV4YW5kZXIgQnVsZWtvdiAoMjEpOg0KICBzb2Z0bW11OiBzcGxpdCBvZmYgdmwuYzptYWlu
KCkgaW50byBtYWluLmMNCiAgbW9kdWxlOiBjaGVjayBtb2R1bGUgd2Fzbid0IGFscmVhZHkgaW5p
dGlhbGl6ZWQNCiAgZnV6ejogYWRkIEZVWlpfVEFSR0VUIG1vZHVsZSB0eXBlDQogIHF0ZXN0OiBh
ZGQgcXRlc3Rfc2VydmVyX3NlbmQgYWJzdHJhY3Rpb24NCiAgbGlicXRlc3Q6IGFkZCBhIGxheWVy
IG9mIGFic3RyYWN0aW9uIHRvIHNlbmQvcmVjdg0KICBsaWJxdGVzdDogbWFrZSBidWZ3cml0ZSBy
ZWx5IG9uIHRoZSBUcmFuc3BvcnRPcHMNCiAgcXRlc3Q6IGFkZCBpbi1wcm9jZXNzIGluY29taW5n
IGNvbW1hbmQgaGFuZGxlcg0KICBsaWJxb3M6IHJlbmFtZSBpMmNfc2VuZCBhbmQgaTJjX3JlY3YN
CiAgbGlicW9zOiBzcGxpdCBxb3MtdGVzdCBhbmQgbGlicW9zIG1ha2VmaWxlIHZhcnMNCiAgbGli
cW9zOiBtb3ZlIHVzZWZ1bCBxb3MtdGVzdCBmdW5jcyB0byBxb3NfZXh0ZXJuYWwNCiAgZnV6ejog
YWRkIGZ1enplciBza2VsZXRvbg0KICBleGVjOiBrZWVwIHJhbSBibG9jayBhY3Jvc3MgZm9yayB3
aGVuIHVzaW5nIHF0ZXN0DQogIG1haW46IGtlZXAgcmN1X2F0Zm9yayBjYWxsYmFjayBlbmFibGVk
IGZvciBxdGVzdA0KICBmdXp6OiBzdXBwb3J0IGZvciBmb3JrLWJhc2VkIGZ1enppbmcuDQogIGZ1
eno6IGFkZCBzdXBwb3J0IGZvciBxb3MtYXNzaXN0ZWQgZnV6eiB0YXJnZXRzDQogIGZ1eno6IGFk
ZCB0YXJnZXQvZnV6eiBtYWtlZmlsZSBydWxlcw0KICBmdXp6OiBhZGQgY29uZmlndXJlIGZsYWcg
LS1lbmFibGUtZnV6emluZw0KICBmdXp6OiBhZGQgaTQ0MGZ4IGZ1enogdGFyZ2V0cw0KICBmdXp6
OiBhZGQgdmlydGlvLW5ldCBmdXp6IHRhcmdldA0KICBmdXp6OiBhZGQgdmlydGlvLXNjc2kgZnV6
eiB0YXJnZXQNCiAgZnV6ejogYWRkIGRvY3VtZW50YXRpb24gdG8gZG9jcy9kZXZlbC8NCg0KIE1h
a2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICstDQogTWFrZWZpbGUub2Jq
cyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KIE1ha2VmaWxlLnRhcmdldCAgICAgICAg
ICAgICAgICAgICAgIHwgIDE4ICsrLQ0KIGNvbmZpZ3VyZSAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDM5ICsrKysrDQogZG9jcy9kZXZlbC9mdXp6aW5nLnR4dCAgICAgICAgICAgICAgfCAx
MTYgKysrKysrKysrKysrKysNCiBleGVjLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAxMiArLQ0KIGluY2x1ZGUvcWVtdS9tb2R1bGUuaCAgICAgICAgICAgICAgIHwgICA0ICstDQog
aW5jbHVkZS9zeXNlbXUvcXRlc3QuaCAgICAgICAgICAgICAgfCAgIDQgKw0KIGluY2x1ZGUvc3lz
ZW11L3N5c2VtdS5oICAgICAgICAgICAgIHwgICA0ICsNCiBtYWluLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICA1MyArKysrKysrDQogcXRlc3QuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMzEgKysrLQ0KIHRlc3RzL3F0ZXN0L01ha2VmaWxlLmluY2x1ZGUgICAgICAg
IHwgIDcyICsrKystLS0tLQ0KIHRlc3RzL3F0ZXN0L2Z1enovTWFrZWZpbGUuaW5jbHVkZSAgIHwg
IDE4ICsrKw0KIHRlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmMgICAgICAgIHwgIDU1ICsrKysr
KysNCiB0ZXN0cy9xdGVzdC9mdXp6L2ZvcmtfZnV6ei5oICAgICAgICB8ICAyMyArKysNCiB0ZXN0
cy9xdGVzdC9mdXp6L2ZvcmtfZnV6ei5sZCAgICAgICB8ICAzNyArKysrKw0KIHRlc3RzL3F0ZXN0
L2Z1enovZnV6ei5jICAgICAgICAgICAgIHwgMTc5ICsrKysrKysrKysrKysrKysrKysrKysNCiB0
ZXN0cy9xdGVzdC9mdXp6L2Z1enouaCAgICAgICAgICAgICB8ICA5NSArKysrKysrKysrKysNCiB0
ZXN0cy9xdGVzdC9mdXp6L2k0NDBmeF9mdXp6LmMgICAgICB8IDE3OCArKysrKysrKysrKysrKysr
KysrKysNCiB0ZXN0cy9xdGVzdC9mdXp6L3Fvc19mdXp6LmMgICAgICAgICB8IDIyOSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQogdGVzdHMvcXRlc3QvZnV6ei9xb3NfZnV6ei5oICAgICAg
ICAgfCAgMzMgKysrKw0KIHRlc3RzL3F0ZXN0L2Z1enovdmlydGlvX25ldF9mdXp6LmMgIHwgMTk1
ICsrKysrKysrKysrKysrKysrKysrKysrDQogdGVzdHMvcXRlc3QvZnV6ei92aXJ0aW9fc2NzaV9m
dXp6LmMgfCAyMDAgKysrKysrKysrKysrKysrKysrKysrKysrDQogdGVzdHMvcXRlc3QvbGlicW9z
L2kyYy5jICAgICAgICAgICAgfCAgMTAgKy0NCiB0ZXN0cy9xdGVzdC9saWJxb3MvaTJjLmggICAg
ICAgICAgICB8ICAgNCArLQ0KIHRlc3RzL3F0ZXN0L2xpYnFvcy9xb3NfZXh0ZXJuYWwuYyAgIHwg
MTY4ICsrKysrKysrKysrKysrKysrKysrDQogdGVzdHMvcXRlc3QvbGlicW9zL3Fvc19leHRlcm5h
bC5oICAgfCAgMjggKysrKw0KIHRlc3RzL3F0ZXN0L2xpYnF0ZXN0LmMgICAgICAgICAgICAgIHwg
MTE5ICsrKysrKysrKysrKystLQ0KIHRlc3RzL3F0ZXN0L2xpYnF0ZXN0LmggICAgICAgICAgICAg
IHwgICA0ICsNCiB0ZXN0cy9xdGVzdC9wY2E5NTUyLXRlc3QuYyAgICAgICAgICB8ICAxMCArLQ0K
IHRlc3RzL3F0ZXN0L3Fvcy10ZXN0LmMgICAgICAgICAgICAgIHwgMTMyICstLS0tLS0tLS0tLS0t
LS0NCiB1dGlsL21vZHVsZS5jICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQogdmwuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDUgKysrLS0tDQogMzMgZmlsZXMgY2hh
bmdlZCwgMTkxNiBpbnNlcnRpb25zKCspLCAyMjQgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRvY3MvZGV2ZWwvZnV6emluZy50eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgbWFpbi5j
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2Z1enovTWFrZWZpbGUuaW5jbHVkZQ0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9mdXp6L2ZvcmtfZnV6ei5jDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmgNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdHMvcXRlc3QvZnV6ei9mb3JrX2Z1enoubGQNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdHMvcXRlc3QvZnV6ei9mdXp6LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3Qv
ZnV6ei9mdXp6LmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvZnV6ei9pNDQwZnhf
ZnV6ei5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2Z1enovcW9zX2Z1enouYw0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9mdXp6L3Fvc19mdXp6LmgNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvZnV6ei92aXJ0aW9fbmV0X2Z1enouYw0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9mdXp6L3ZpcnRpb19zY3NpX2Z1enouYw0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9saWJxb3MvcW9zX2V4dGVybmFsLmMNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGVzdHMvcXRlc3QvbGlicW9zL3Fvc19leHRlcm5hbC5oDQoNCi0tIA0KMi4yMy4w
DQoNCg==

