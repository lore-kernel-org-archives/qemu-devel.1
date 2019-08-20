Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC8C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E25822DBF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dxR7usyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E25822DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05vI-0004Ms-AN
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i05sw-0003EI-CN
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i05sv-0001aL-4e
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:17:22 -0400
Received: from mail-eopbgr140118.outbound.protection.outlook.com
 ([40.107.14.118]:61509 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i05su-0001Yh-RS
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:17:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0fQr2L1kj3diXCWb/JHFD9fpPfzPslelJzq32dWqtRFbaO4MNj4Fy7S038lIS537bbjz3TnGRTwDpWtlRU1SIg5mJxfnhJVQ8oQ45YPd/Hd+2b+Uv9TWhcR9NP20wRtwCFDF+yOUC014qE9olDcab3vHjrjhnM+2hzh9La7QIKV+E5pXvVdXRFFigu/I2Y84DU0+ryRg81zqnvKWVz5O56cD1kyQSKPTuvYXivVMLO8XEMef+vS7THm7HcY3etH7dBeiO+pJ9pEdSXb7mfLgtRUnLeJnd61pbhIl7g//YAs5CC5UKTmwlKs289MS/h37JZXWT1pKoZbYXmUeUtx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1VNGX1ZPBb/qaxcWnPYyV0ISP4FaXKrQNI8c2i8bfA=;
 b=YkJNT7lmUOZEU4RqzrBqWmtpOYTbafwYUiliSVbraLjC0bGyQSfBacbtod0B77BtbNqdwPvpTnLF3ff/JqItpy8cU1WwItiSYGixqIcWsKkPMINPLwPGdwIOkhlToIPFQqJI+2E/JuAb+VIAMcJooW7S5jmVtG3jdOHWXY29z74dMBwUrMIv6CGaC1gPLY2+Xf/6FvrTXHV4hCaPO3hs6o571Y3RFNeyDWNPdshpbaIaLIeyANdj+tIAqRozd+q9NYnJP4qv2odAavxfkIaI9S08q13yD6Z+2hlEtQ5MOw6Ua6Os9YlX23vjbmXqEm+ts5gAtmHf8OxVZttaz62wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1VNGX1ZPBb/qaxcWnPYyV0ISP4FaXKrQNI8c2i8bfA=;
 b=dxR7usyoH57RLFsmATdqOoTc8FW9LT6nqm1iz92dVDD5E5ko3ovP+GvlcQoPTg6fKSGVS2TrW3hrgKfRfZvMqcSSI3euyRHTPYJ9LPJr2oWVTijthyEIY3KNnZ/O/jxTbGHKMdfkNajjkJvyjqRDoXmh3q0UYubCN+17is8jc9w=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3567.eurprd08.prod.outlook.com (20.177.61.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 15:17:18 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 15:17:18 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3] make check-unit: use after free in test-opts-visitor
Thread-Index: AQHVS6+yW1O0+uQoyUezalsyE4hvLacEPVWA
Date: Tue, 20 Aug 2019 15:17:18 +0000
Message-ID: <145da1b2-4a72-ee7e-515c-00b5f84ca8e6@virtuozzo.com>
References: <1565024586-387112-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1565024586-387112-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0072.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::43) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 981a0a9d-63b2-4728-93d9-08d725817db5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3567; 
x-ms-traffictypediagnostic: VI1PR08MB3567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB35679C668363A309E329F026F4AB0@VI1PR08MB3567.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(39850400004)(396003)(189003)(199004)(6436002)(6486002)(66066001)(5640700003)(6512007)(107886003)(25786009)(4326008)(6246003)(8936002)(14454004)(3846002)(6116002)(31696002)(44832011)(186003)(71200400001)(36756003)(66946007)(66446008)(64756008)(66556008)(66476007)(256004)(11346002)(2616005)(7736002)(446003)(486006)(476003)(305945005)(86362001)(2906002)(76176011)(31686004)(386003)(6506007)(53546011)(102836004)(26005)(99286004)(52116002)(71190400001)(2501003)(54906003)(478600001)(229853002)(53936002)(81156014)(2351001)(5660300002)(6916009)(8676002)(316002)(81166006)(20703003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3567;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8TTVsJ+DnX98Wu47nkOPet4rFaHY9BgKXd97I9kYUKqxAnrk4DWpqQoMSTCiYB/RfLO3E0tJqkpsHtEJiF0G1Sp9BzcC8d1gtXT+u/+EK/SJOhOmkaIJcqJElRhXRafIRivH7WfCD2Hr4Du8cT64BIVIpzPwFO/nSvTXgVyd/10ngm9Bg8dtokrATrPztnleoq9vtEf2ApI85tPpBgLyDa8YNCfTszgLUrBviZtcYe6juYPp11uJ++JVBY5/r3YtXAZ0lI7Qawr1VeMbvBjLkiMn0BKPby1AdCiEahKNuQJpUZ/bHtgpok8dkcBH4EOus/SPYlRcDmTbzTRDh6Bk/VMerz+lUgkSU25xxIewAo+IrY4mV7JwA68G+fVA4tPzJyp5n8tv+oyTNe9Q6k8iTaIZOBMT/4m6SYQOd8zw1js=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D2AF03F1A0EBE429C4F90EEB3861C46@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981a0a9d-63b2-4728-93d9-08d725817db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 15:17:18.7984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uimKYjbxiTDcflqqeUGLbIngcI76bR3iYUrKc2tkaLMUCRvE6meODs+ldjg/EMZgpi+fvNV3YSUvIuDedaHyIfkG4SqhzB4CPtxxxhbzt8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3567
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.118
Subject: Re: [Qemu-devel] [PATCH v3] make check-unit: use after free in
 test-opts-visitor
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
Cc: Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UElOR0lORy4uLg0KDQpPbiAwNS8wOC8yMDE5IDIwOjAzLCBBbmRyZXkgU2hpbmtldmljaCB3cm90
ZToNCj4gSW4gdGhlIHN0cnVjdCBPcHRzVmlzaXRvciwgdGhlICdyZXBlYXRlZF9vcHRzJyBtZW1i
ZXIgcG9pbnRzIHRvIGEgbGlzdA0KPiBpbiB0aGUgJ3VucHJvY2Vzc2VkX29wdHMnIGhhc2ggdGFi
bGUgYWZ0ZXIgdGhlIGxpc3QgaGFzIGJlZW4gZGVzdHJveWVkLg0KPiBBIHN1YnNlcXVlbnQgY2Fs
bCB0byB2aXNpdF90eXBlX2ludCgpIHJlZmVyZW5jZXMgdGhlIGRlbGV0ZWQgbGlzdC4NCj4gSXQg
cmVzdWx0cyBpbiB1c2UtYWZ0ZXItZnJlZSBpc3N1ZSByZXByb2R1Y2VkIGJ5IHJ1bm5pbmcgdGhl
IHRlc3QgY2FzZQ0KPiB1bmRlciB0aGUgVmFsZ3JpbmQ6IHZhbGdyaW5kIHRlc3RzL3Rlc3Qtb3B0
cy12aXNpdG9yLg0KPiBBIG5ldyBtb2RlIExpc3RNb2RlOjpMTV9UUkFWRVJTRUQgaXMgZGVjbGFy
ZWQgdG8gbWFyayB0aGUgbGlzdA0KPiB0cmF2ZXJzYWwgY29tcGxldGVkLg0KPiANCj4gU3VnZ2Vz
dGVkLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29t
Pg0KPiAtLS0NCj4gDQo+IHYzOg0KPiAgIDAxOiBUaGUgY29tbWVudCBvZiB0aGUgcGF0Y2ggaGVh
ZGVyIHdhcyBhbWVuZGVkLg0KPiAgIDAyOiBUaGUgY2hhbmdlIGluIHNwYWNpbmcgb2YgJ0xpc3RN
b2RlJyBjb21tZW50IGJsb2NrcyB3YXMgcm9sbGVkIGJhY2suDQo+ICAgMDM6IFRoZSAncmVwZWF0
ZWRfb3B0cycgaW4gb3B0c19lbmRfbGlzdCgpIGlzIG5vdyByZXNldCB1bmNvbmRpdGlvbmFsbHkN
Cj4gICAgICAgYXMgaXQgd2FzLg0KPiAgIDA0OiBUaGUgJ25hbWUnIGluIHRoZSBlcnJvcl9zZXRn
KCkgd2FzIHJlbW92ZWQgYXMgdGhlIHBvaW50ZXIgdG8gdGhlIGxpc3QNCj4gICAgICAgbmFtZSBj
YW4gYmUgbnVsbCAoc3VnZ2VzdGVkIGJ5IE1hcmt1cykuDQo+IA0KPiAgIHFhcGkvb3B0cy12aXNp
dG9yLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Fh
cGkvb3B0cy12aXNpdG9yLmMgYi9xYXBpL29wdHMtdmlzaXRvci5jDQo+IGluZGV4IDMyNGIxOTcu
LjVmZTAyNzYgMTAwNjQ0DQo+IC0tLSBhL3FhcGkvb3B0cy12aXNpdG9yLmMNCj4gKysrIGIvcWFw
aS9vcHRzLXZpc2l0b3IuYw0KPiBAQCAtMjQsNyArMjQsOCBAQCBlbnVtIExpc3RNb2RlDQo+ICAg
ew0KPiAgICAgICBMTV9OT05FLCAgICAgICAgICAgICAvKiBub3QgdHJhdmVyc2luZyBhIGxpc3Qg
b2YgcmVwZWF0ZWQgb3B0aW9ucyAqLw0KPiAgIA0KPiAtICAgIExNX0lOX1BST0dSRVNTLCAgICAg
IC8qIG9wdHNfbmV4dF9saXN0KCkgcmVhZHkgdG8gYmUgY2FsbGVkLg0KPiArICAgIExNX0lOX1BS
T0dSRVNTLCAgICAgIC8qDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICogb3B0c19uZXh0
X2xpc3QoKSByZWFkeSB0byBiZSBjYWxsZWQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIEdlbmVyYXRpbmcgdGhlIG5leHQg
bGlzdCBsaW5rIHdpbGwgY29uc3VtZSB0aGUgbW9zdA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKiByZWNlbnRseSBwYXJzZWQgUWVtdU9wdCBpbnN0YW5jZSBvZiB0aGUgcmVwZWF0ZWQN
Cj4gQEAgLTM2LDcgKzM3LDggQEAgZW51bSBMaXN0TW9kZQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKiBMTV9VTlNJR05FRF9JTlRFUlZBTC4NCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICovDQo+ICAgDQo+IC0gICAgTE1fU0lHTkVEX0lOVEVSVkFMLCAgLyogb3B0c19uZXh0
X2xpc3QoKSBoYXMgYmVlbiBjYWxsZWQuDQo+ICsgICAgTE1fU0lHTkVEX0lOVEVSVkFMLCAgLyoN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgKiBvcHRzX25leHRfbGlzdCgpIGhhcyBiZWVu
IGNhbGxlZC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICoNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICogR2VuZXJhdGluZyB0aGUgbmV4dCBsaXN0IGxpbmsgd2lsbCBjb25z
dW1lIHRoZSBtb3N0DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIHJlY2VudGx5IHN0
b3JlZCBlbGVtZW50IGZyb20gdGhlIHNpZ25lZCBpbnRlcnZhbCwNCj4gQEAgLTQ4LDcgKzUwLDE0
IEBAIGVudW0gTGlzdE1vZGUNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICogbmV4dCBl
bGVtZW50IG9mIHRoZSBzaWduZWQgaW50ZXJ2YWwuDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAqLw0KPiAgIA0KPiAtICAgIExNX1VOU0lHTkVEX0lOVEVSVkFMIC8qIFNhbWUgYXMgYWJv
dmUsIG9ubHkgZm9yIGFuIHVuc2lnbmVkIGludGVydmFsLiAqLw0KPiArICAgIExNX1VOU0lHTkVE
X0lOVEVSVkFMLCAvKiBTYW1lIGFzIGFib3ZlLCBvbmx5IGZvciBhbiB1bnNpZ25lZCBpbnRlcnZh
bC4gKi8NCj4gKw0KPiArICAgIExNX1RSQVZFUlNFRCAgICAgICAgICAvKg0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiBvcHRzX25leHRfbGlzdCgpIGhhcyBiZWVuIGNhbGxlZC4NCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICogTm8gbW9yZSBRZW11T3B0IGluc3RhbmNlIGluIHRoZSBsaXN0Lg0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiBUaGUgdHJhdmVyc2FsIGhhcyBiZWVuIGNvbXBsZXRlZC4NCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ICAgfTsNCj4gICANCj4gICB0eXBlZGVm
IGVudW0gTGlzdE1vZGUgTGlzdE1vZGU7DQo+IEBAIC0yMzgsNiArMjQ3LDggQEAgb3B0c19uZXh0
X2xpc3QoVmlzaXRvciAqdiwgR2VuZXJpY0xpc3QgKnRhaWwsIHNpemVfdCBzaXplKQ0KPiAgICAg
ICBPcHRzVmlzaXRvciAqb3YgPSB0b19vdih2KTsNCj4gICANCj4gICAgICAgc3dpdGNoIChvdi0+
bGlzdF9tb2RlKSB7DQo+ICsgICAgY2FzZSBMTV9UUkFWRVJTRUQ6DQo+ICsgICAgICAgIHJldHVy
biBOVUxMOw0KPiAgICAgICBjYXNlIExNX1NJR05FRF9JTlRFUlZBTDoNCj4gICAgICAgY2FzZSBM
TV9VTlNJR05FRF9JTlRFUlZBTDoNCj4gICAgICAgICAgIGlmIChvdi0+bGlzdF9tb2RlID09IExN
X1NJR05FRF9JTlRFUlZBTCkgew0KPiBAQCAtMjU4LDYgKzI2OSw4IEBAIG9wdHNfbmV4dF9saXN0
KFZpc2l0b3IgKnYsIEdlbmVyaWNMaXN0ICp0YWlsLCBzaXplX3Qgc2l6ZSkNCj4gICAgICAgICAg
IG9wdCA9IGdfcXVldWVfcG9wX2hlYWQob3YtPnJlcGVhdGVkX29wdHMpOw0KPiAgICAgICAgICAg
aWYgKGdfcXVldWVfaXNfZW1wdHkob3YtPnJlcGVhdGVkX29wdHMpKSB7DQo+ICAgICAgICAgICAg
ICAgZ19oYXNoX3RhYmxlX3JlbW92ZShvdi0+dW5wcm9jZXNzZWRfb3B0cywgb3B0LT5uYW1lKTsN
Cj4gKyAgICAgICAgICAgIG92LT5yZXBlYXRlZF9vcHRzID0gTlVMTDsNCj4gKyAgICAgICAgICAg
IG92LT5saXN0X21vZGUgPSBMTV9UUkFWRVJTRUQ7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIE5V
TEw7DQo+ICAgICAgICAgICB9DQo+ICAgICAgICAgICBicmVhazsNCj4gQEAgLTI4OSw3ICszMDIs
OCBAQCBvcHRzX2VuZF9saXN0KFZpc2l0b3IgKnYsIHZvaWQgKipvYmopDQo+ICAgDQo+ICAgICAg
IGFzc2VydChvdi0+bGlzdF9tb2RlID09IExNX0lOX1BST0dSRVNTIHx8DQo+ICAgICAgICAgICAg
ICBvdi0+bGlzdF9tb2RlID09IExNX1NJR05FRF9JTlRFUlZBTCB8fA0KPiAtICAgICAgICAgICBv
di0+bGlzdF9tb2RlID09IExNX1VOU0lHTkVEX0lOVEVSVkFMKTsNCj4gKyAgICAgICAgICAgb3Yt
Pmxpc3RfbW9kZSA9PSBMTV9VTlNJR05FRF9JTlRFUlZBTCB8fA0KPiArICAgICAgICAgICBvdi0+
bGlzdF9tb2RlID09IExNX1RSQVZFUlNFRCk7DQo+ICAgICAgIG92LT5yZXBlYXRlZF9vcHRzID0g
TlVMTDsNCj4gICAgICAgb3YtPmxpc3RfbW9kZSA9IExNX05PTkU7DQo+ICAgfQ0KPiBAQCAtMzA2
LDYgKzMyMCwxMCBAQCBsb29rdXBfc2NhbGFyKGNvbnN0IE9wdHNWaXNpdG9yICpvdiwgY29uc3Qg
Y2hhciAqbmFtZSwgRXJyb3IgKiplcnJwKQ0KPiAgICAgICAgICAgbGlzdCA9IGxvb2t1cF9kaXN0
aW5jdChvdiwgbmFtZSwgZXJycCk7DQo+ICAgICAgICAgICByZXR1cm4gbGlzdCA/IGdfcXVldWVf
cGVla190YWlsKGxpc3QpIDogTlVMTDsNCj4gICAgICAgfQ0KPiArICAgIGlmIChvdi0+bGlzdF9t
b2RlID09IExNX1RSQVZFUlNFRCkgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJGZXdl
ciBsaXN0IGVsZW1lbnRzIHRoYW4gZXhwZWN0ZWQiKTsNCj4gKyAgICAgICAgcmV0dXJuIE5VTEw7
DQo+ICsgICAgfQ0KPiAgICAgICBhc3NlcnQob3YtPmxpc3RfbW9kZSA9PSBMTV9JTl9QUk9HUkVT
Uyk7DQo+ICAgICAgIHJldHVybiBnX3F1ZXVlX3BlZWtfaGVhZChvdi0+cmVwZWF0ZWRfb3B0cyk7
DQo+ICAgfQ0KPiANCg0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtl
dmljaA0K

