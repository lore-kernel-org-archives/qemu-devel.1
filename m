Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCFAC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 21:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF17120724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 21:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF17120724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFOyU-0001bj-3Q
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 17:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <brogers@suse.com>) id 1jFOwo-0000Qt-GZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 17:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brogers@suse.com>) id 1jFOwl-0004jK-RY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 17:12:53 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:34151)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <brogers@suse.com>)
 id 1jFOwl-0004iO-K7; Fri, 20 Mar 2020 17:12:51 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY
 m4a0073g.houston.softwaregrp.com WITH ESMTP; 
 Fri, 20 Mar 2020 21:10:24 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 20 Mar 2020 21:10:47 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 20 Mar 2020 21:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqazxpMpToIG1ggyhGTuzeicRhDjsmeB7jQHqhonNoYv+tO9MuHdxG1jdTs1FP+Dd+dYBP/2ArzWwkkZPWqn1f4vcz6gcedT5nb70jkb1puYw00QgDcIhlQA0fcjrA0Ms59XH5E9t2Qjz81pt+Oeks9Q0i/kGzQRb1DmPdgHrQBgGl/VMgcEUDoyWpGgHV1yuAU8ljniGNbJJ095aJZaZ0VblfTJD7puyer5Ts6jRnz37qlARKVZbL4iLHJnMxn37li8uzEV03l+FZgTG+QIID3jGoRXYOouwAq3zUPXD7KAeZqeKYxeMaURNYDZnZQM4hMYS/0a3932HG26LljYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqzJUp9aDC4oddbaqHBxpiDu0tjXeOJPwsAVxbw+4uE=;
 b=iayOZkahAHIZxX26AvQ4mY0BSbC/n+vtKqrbRAdba3JobAVB6Zb2v++YsBt7DW9/GjwopC2Aq/oug4Gms78o0Gbeg25ncvv935lKiJPgeS1sWdIMgM0YbXkRH+x7DVWlLtn7ygOlRd7EoIVAJ7/hLp0+xvQw3cLt/IUJ3ahBpHoKU+rmGbInuoig7PuZUJhPqACVIm3dtNIUuX5q1VWTnir8SYk7gRvZSSPUvFxDOrpP1kmHmxN0sxs2I6qMs9me24P/q8YWS2V4/2He83qVt99mKT/xuYmX0GXfm93hCbsagBa24StukXtLqQUujb82Hs6ab2ByN2eJ2q3RAxQ2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from SA0PR18MB3630.namprd18.prod.outlook.com (2603:10b6:806:9c::21)
 by SA0PR18MB3662.namprd18.prod.outlook.com (2603:10b6:806:9e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 21:10:46 +0000
Received: from SA0PR18MB3630.namprd18.prod.outlook.com
 ([fe80::2807:28a7:757f:b75b]) by SA0PR18MB3630.namprd18.prod.outlook.com
 ([fe80::2807:28a7:757f:b75b%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 21:10:46 +0000
From: Bruce Rogers <brogers@suse.com>
To: "frankja@linux.ibm.com" <frankja@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v11 03/16] s390x: protvirt: Support unpack facility
Thread-Topic: [PATCH v11 03/16] s390x: protvirt: Support unpack facility
Thread-Index: AQHV/fEo0XwgzpGftkOTyPe0t+wQ9KhR/CYA
Date: Fri, 20 Mar 2020 21:10:45 +0000
Message-ID: <85df56f2bc703e38a19150f51c9a6501dffefd16.camel@suse.com>
References: <20200319131921.2367-1-frankja@linux.ibm.com>
 <20200319131921.2367-4-frankja@linux.ibm.com>
In-Reply-To: <20200319131921.2367-4-frankja@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brogers@suse.com; 
x-originating-ip: [63.248.144.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcbaeaeb-9d37-406f-6425-08d7cd132863
x-ms-traffictypediagnostic: SA0PR18MB3662:
x-microsoft-antispam-prvs: <SA0PR18MB3662A90BD1EECD4C1E4F4493D9F50@SA0PR18MB3662.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(199004)(316002)(86362001)(81166006)(8676002)(66946007)(81156014)(4326008)(76116006)(2906002)(6486002)(54906003)(71200400001)(110136005)(6512007)(36756003)(66476007)(66556008)(2616005)(64756008)(26005)(478600001)(186003)(8936002)(66446008)(6506007)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SA0PR18MB3662;
 H:SA0PR18MB3630.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zr8y/ukF/8h2EyLLqn8SoKFRsa4vct2N5fh09FS+ZE8mi2TmL3JoJbhwB6pFRpqzLLmTEPiVJ4muDRr2un4Cum+Tw0+Fj/J/RIrdXHFbNFvdzSEqgoWxu2WPfkPi6ugKd3AzrsOysbzFW/3O93+R74uvj3vj+FIAUCINgMb/f8zBbkEtlv0LARb8A3V8EE0D8KlgL/34y/o+9nbhIlAba0/bEWo0/BvTK2jr2WI8+Fi1wWiFeIQUx+EHyy6uTJSz9PzB2sffBTIHk9o+/q/IWenOQLzB5HRvo3OcKRm7SXop4CIJlJMeIa/4ul4bbNSVASEMc76J6VD2H1XNmuOEAnmimxDMn2iiDdCg7NC/KM1CzCNMNwP8ShHhDWfBYdabpQJmL/z7z2lAfvyv5RevE0PQdsHMfuUiNYgnU+pnkZr2K6XMOY7dbI02+XCpcWT5
x-ms-exchange-antispam-messagedata: EEtp9fRUj/3fg2Amxubf5w7jy/KJgxeo9JakrqCHMWqi0sw71UmeoR8k0cvSyxeiRyae+9o66DS0FeqGj3wNvSrH53ow7bUGsX6FFnhK3JPJbfxFEQiSK9i1j1r+M1xQpgJRMm4nhdLPt6V0QAr5Kg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C5293CAA98A0E4886B65E85497CD5F7@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbaeaeb-9d37-406f-6425-08d7cd132863
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 21:10:46.0037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOqqp2ZQ7qEfWkV1IdTrEXcxPaX/Rk7vHg91USFveGK2T9x5YFhJfPw1PMIpYBOOSiEInUulhm43JL0ycmdQVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3662
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.2.131
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
Cc: "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>, "david@redhat.com" <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDIwLTAzLTE5IGF0IDA5OjE5IC0wNDAwLCBKYW5vc2NoIEZyYW5rIHdyb3RlOg0K
PiBUaGUgdW5wYWNrIGZhY2lsaXR5IHByb3ZpZGVzIHRoZSBtZWFucyB0byBzZXR1cCBhIHByb3Rl
Y3RlZCBndWVzdC4gQQ0KPiBwcm90ZWN0ZWQgZ3Vlc3QgY2Fubm90IGJlIGludHJvc3BlY3RlZCBi
eSB0aGUgaHlwZXJ2aXNvciBvciBhbnkNCj4gdXNlci9hZG1pbmlzdHJhdG9yIG9mIHRoZSBtYWNo
aW5lIGl0IGlzIHJ1bm5pbmcgb24uDQo+IA0KPiBQcm90ZWN0ZWQgZ3Vlc3RzIGFyZSBlbmNyeXB0
ZWQgYXQgcmVzdCBhbmQgbmVlZCBhIHNwZWNpYWwgYm9vdA0KPiBtZWNoYW5pc20gdmlhIGRpYWcz
MDggc3ViY29kZSA4IGFuZCAxMC4NCj4gDQo+IENvZGUgOCBzZXRzIHRoZSBQViBzcGVjaWZpYyBJ
UExCIHdoaWNoIGlzIHJldGFpbmVkIHNlcGFyYXRlbHkgZnJvbQ0KPiB0aG9zZSBzZXQgdmlhIGNv
ZGUgNS4NCj4gDQo+IENvZGUgMTAgaXMgdXNlZCB0byB1bnBhY2sgdGhlIFZNIGludG8gcHJvdGVj
dGVkIG1lbW9yeSwgdmVyaWZ5IGl0cw0KPiBpbnRlZ3JpdHkgYW5kIHN0YXJ0IGl0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSmFub3NjaCBGcmFuayA8ZnJhbmtqYUBsaW51eC5pYm0uY29tPg0KPiBD
by1kZXZlbG9wZWQtYnk6IENocmlzdGlhbiBCb3JudHJhZWdlciA8Ym9ybnRyYWVnZXJAZGUuaWJt
LmNvbT4NCj4gW0NoYW5nZXMNCj4gdG8gbWFjaGluZV0NCj4gUmV2aWV3ZWQtYnk6IERhdmlkIEhp
bGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogQ2xhdWRpbyBJbWJy
ZW5kYSA8aW1icmVuZGFAbGludXguaWJtLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IENvcm5lbGlhIEh1
Y2sgPGNvaHVja0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAyICsNCj4gIGh3L3MzOTB4L01ha2VmaWxlLm9ianMgICAgICAgICAg
ICAgIHwgICAxICsNCj4gIGh3L3MzOTB4L2lwbC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDU5
ICsrKysrKysrKysrKystDQo+ICBody9zMzkweC9pcGwuaCAgICAgICAgICAgICAgICAgICAgICB8
ICA5MSArKysrKysrKysrKysrKysrKysrKy0NCj4gIGh3L3MzOTB4L3B2LmMgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDk4ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ICBody9zMzkweC9zMzkw
LXZpcnRpby1jY3cuYyAgICAgICAgICB8IDExOQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+ICBpbmNsdWRlL2h3L3MzOTB4L3B2LmggICAgICAgICAgICAgICB8ICA1NSArKysrKysr
KysrKysrDQo+ICBpbmNsdWRlL2h3L3MzOTB4L3MzOTAtdmlydGlvLWNjdy5oICB8ICAgMSArDQo+
ICB0YXJnZXQvczM5MHgvY3B1LmMgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICB0YXJnZXQv
czM5MHgvY3B1X2ZlYXR1cmVzX2RlZi5pbmMuaCB8ICAgMSArDQo+ICB0YXJnZXQvczM5MHgvZGlh
Zy5jICAgICAgICAgICAgICAgICB8ICAzOSArKysrKysrKy0NCj4gIHRhcmdldC9zMzkweC9rdm0t
c3R1Yi5jICAgICAgICAgICAgIHwgICA1ICsrDQo+ICB0YXJnZXQvczM5MHgva3ZtLmMgICAgICAg
ICAgICAgICAgICB8ICAgNSArKw0KPiAgdGFyZ2V0L3MzOTB4L2t2bV9zMzkweC5oICAgICAgICAg
ICAgfCAgIDEgKw0KPiAgMTQgZmlsZXMgY2hhbmdlZCwgNDY4IGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3MzOTB4L3B2LmMNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L3MzOTB4L3B2LmgNCj4gDQo+IGRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IGRmYmQ1YjBjNWRlOTA3NGMuLmY0ZTA5
MjEzZjk0NWE3MTYgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlO
RVJTDQo+IEBAIC0zOTEsNiArMzkxLDggQEAgRjogdGFyZ2V0L3MzOTB4L21hY2hpbmUuYw0KPiAg
RjogdGFyZ2V0L3MzOTB4L3NpZ3AuYw0KPiAgRjogdGFyZ2V0L3MzOTB4L2NwdV9mZWF0dXJlcyou
W2NoXQ0KPiAgRjogdGFyZ2V0L3MzOTB4L2NwdV9tb2RlbHMuW2NoXQ0KPiArRjogaHcvczM5MHgv
cHYuYw0KPiArRjogaW5jbHVkZS9ody9zMzkweC9wdi5oDQo+ICBGOiBody9pbnRjL3MzOTBfZmxp
Yy5jDQo+ICBGOiBody9pbnRjL3MzOTBfZmxpY19rdm0uYw0KPiAgRjogaW5jbHVkZS9ody9zMzkw
eC9zMzkwX2ZsaWMuaA0KPiBkaWZmIC0tZ2l0IGEvaHcvczM5MHgvTWFrZWZpbGUub2JqcyBiL2h3
L3MzOTB4L01ha2VmaWxlLm9ianMNCj4gaW5kZXggZTAyZWQ4MGI2ODI5YTUxMS4uYTQ2YTFjNzg5
NGUwZjYxMiAxMDA2NDQNCj4gLS0tIGEvaHcvczM5MHgvTWFrZWZpbGUub2Jqcw0KPiArKysgYi9o
dy9zMzkweC9NYWtlZmlsZS5vYmpzDQo+IEBAIC0zMSw2ICszMSw3IEBAIG9iai15ICs9IHRvZC1x
ZW11Lm8NCj4gIG9iai0kKENPTkZJR19LVk0pICs9IHRvZC1rdm0ubw0KPiAgb2JqLSQoQ09ORklH
X0tWTSkgKz0gczM5MC1za2V5cy1rdm0ubw0KPiAgb2JqLSQoQ09ORklHX0tWTSkgKz0gczM5MC1z
dGF0dHJpYi1rdm0ubw0KPiArb2JqLSQoQ09ORklHX0tWTSkgKz0gcHYubw0KPiAgb2JqLXkgKz0g
czM5MC1jY3cubw0KPiAgb2JqLXkgKz0gYXAtZGV2aWNlLm8NCj4gIG9iai15ICs9IGFwLWJyaWRn
ZS5vDQo+IGRpZmYgLS1naXQgYS9ody9zMzkweC9pcGwuYyBiL2h3L3MzOTB4L2lwbC5jDQo+IGlu
ZGV4IGI4MTk0MmUxZTZmOTAwMmUuLjZlMjFjZDQ1M2I1MWI0ZmYgMTAwNjQ0DQo+IC0tLSBhL2h3
L3MzOTB4L2lwbC5jDQo+ICsrKyBiL2h3L3MzOTB4L2lwbC5jDQo+IEBAIC0xLDEwICsxLDExIEBA
DQo+ICAvKg0KPiAgICogYm9vdGxvYWRlciBzdXBwb3J0DQo+ICAgKg0KPiAtICogQ29weXJpZ2h0
IElCTSwgQ29ycC4gMjAxMg0KPiArICogQ29weXJpZ2h0IElCTSwgQ29ycC4gMjAxMiwgMjAyMA0K
PiAgICoNCj4gICAqIEF1dGhvcnM6DQo+ICAgKiAgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIDxib3Ju
dHJhZWdlckBkZS5pYm0uY29tPg0KPiArICogIEphbm9zY2ggRnJhbmsgPGZyYW5ramFAbGludXgu
aWJtLmNvbT4NCj4gICAqDQo+ICAgKiBUaGlzIHdvcmsgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZSBHTlUgR1BMLCB2ZXJzaW9uIDINCj4gb3IgKGF0IHlvdXINCj4gICAqIG9wdGlv
bikgYW55IGxhdGVyIHZlcnNpb24uICBTZWUgdGhlIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxl
dmVsIA0KPiBkaXJlY3RvcnkuDQo+IEBAIC0yNyw2ICsyOCw3IEBADQo+ICAjaW5jbHVkZSAiaHcv
czM5MHgvdmZpby1jY3cuaCINCj4gICNpbmNsdWRlICJody9zMzkweC9jc3MuaCINCj4gICNpbmNs
dWRlICJody9zMzkweC9lYmNkaWMuaCINCj4gKyNpbmNsdWRlICJody9zMzkweC9wdi5oIg0KPiAg
I2luY2x1ZGUgImlwbC5oIg0KPiAgI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+ICAj
aW5jbHVkZSAicWVtdS9jb25maWctZmlsZS5oIg0KPiBAQCAtNTY2LDEyICs1NjgsMzEgQEAgdm9p
ZCBzMzkwX2lwbF91cGRhdGVfZGlhZzMwOChJcGxQYXJhbWV0ZXJCbG9jaw0KPiAqaXBsYikNCj4g
IHsNCj4gICAgICBTMzkwSVBMU3RhdGUgKmlwbCA9IGdldF9pcGxfZGV2aWNlKCk7DQo+ICANCj4g
LSAgICBpcGwtPmlwbGIgPSAqaXBsYjsNCj4gLSAgICBpcGwtPmlwbGJfdmFsaWQgPSB0cnVlOw0K
PiArICAgIC8qDQo+ICsgICAgICogVGhlIElQTEIgc2V0IGFuZCByZXRyaWV2ZWQgYnkgc3ViY29k
ZXMgOC85IGlzIGNvbXBsZXRlbHkNCj4gKyAgICAgKiBzZXBhcmF0ZSBmcm9tIHRoZSBvbmUgbWFu
YWdlZCB2aWEgc3ViY29kZXMgNS82Lg0KPiArICAgICAqLw0KPiArICAgIGlmIChpcGxiLT5wYnQg
PT0gUzM5MF9JUExfVFlQRV9QVikgew0KPiArICAgICAgICBpcGwtPmlwbGJfcHYgPSAqaXBsYjsN
Cj4gKyAgICAgICAgaXBsLT5pcGxiX3ZhbGlkX3B2ID0gdHJ1ZTsNCj4gKyAgICB9IGVsc2Ugew0K
PiArICAgICAgICBpcGwtPmlwbGIgPSAqaXBsYjsNCj4gKyAgICAgICAgaXBsLT5pcGxiX3ZhbGlk
ID0gdHJ1ZTsNCj4gKyAgICB9DQo+ICAgICAgaXBsLT5uZXRib290ID0gaXNfdmlydGlvX25ldF9k
ZXZpY2UoaXBsYik7DQo+ICAgICAgdXBkYXRlX21hY2hpbmVfaXBsX3Byb3BlcnRpZXMoaXBsYik7
DQo+ICB9DQo+ICANCj4gK0lwbFBhcmFtZXRlckJsb2NrICpzMzkwX2lwbF9nZXRfaXBsYl9wdih2
b2lkKQ0KPiArew0KPiArICAgIFMzOTBJUExTdGF0ZSAqaXBsID0gZ2V0X2lwbF9kZXZpY2UoKTsN
Cj4gKw0KPiArICAgIGlmICghaXBsLT5pcGxiX3ZhbGlkX3B2KSB7DQo+ICsgICAgICAgIHJldHVy
biBOVUxMOw0KPiArICAgIH0NCj4gKyAgICByZXR1cm4gJmlwbC0+aXBsYl9wdjsNCj4gK30NCj4g
Kw0KPiAgSXBsUGFyYW1ldGVyQmxvY2sgKnMzOTBfaXBsX2dldF9pcGxiKHZvaWQpDQo+ICB7DQo+
ICAgICAgUzM5MElQTFN0YXRlICppcGwgPSBnZXRfaXBsX2RldmljZSgpOw0KPiBAQCAtNjYwLDYg
KzY4MSwzOCBAQCBzdGF0aWMgdm9pZCBzMzkwX2lwbF9wcmVwYXJlX3FpcGwoUzM5MENQVSAqY3B1
KQ0KPiAgICAgIGNwdV9waHlzaWNhbF9tZW1vcnlfdW5tYXAoYWRkciwgbGVuLCAxLCBsZW4pOw0K
PiAgfQ0KPiAgDQo+ICtpbnQgczM5MF9pcGxfcHJlcGFyZV9wdl9oZWFkZXIodm9pZCkNCj4gK3sN
Cj4gKyAgICBJcGxQYXJhbWV0ZXJCbG9jayAqaXBpYiA9IHMzOTBfaXBsX2dldF9pcGxiX3B2KCk7
DQo+ICsgICAgSVBMQmxvY2tQViAqaXBpYl9wdiA9ICZpcGliLT5wdjsNCj4gKyAgICB2b2lkICpo
ZHIgPSBnX21hbGxvYyhpcGliX3B2LT5wdl9oZWFkZXJfbGVuKTsNCj4gKyAgICBpbnQgcmM7DQo+
ICsNCj4gKyAgICBjcHVfcGh5c2ljYWxfbWVtb3J5X3JlYWQoaXBpYl9wdi0+cHZfaGVhZGVyX2Fk
ZHIsIGhkciwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXBpYl9wdi0+cHZfaGVh
ZGVyX2xlbik7DQo+ICsgICAgcmMgPSBzMzkwX3B2X3NldF9zZWNfcGFybXMoKHVpbnQ2NF90KWhk
ciwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpcGliX3B2LT5wdl9oZWFkZXJf
bGVuKTsNCg0KVGhpcyBjYXVzZXMgYSBjb21waWxlciBpc3N1ZSB3aGVuIGJ1aWxkaW5nIGZvciAz
MiBiaXQgeDg2IGFzIGZvbGxvd3M6DQoNCi9ob21lL2FidWlsZC9ycG1idWlsZC9CVUlMRC9xZW11
LTQuMi4wL2h3L3MzOTB4L2lwbC5jOiBJbiBmdW5jdGlvbg0KJ3MzOTBfaXBsX3ByZXBhcmVfcHZf
aGVhZGVyJzoNCi9ob21lL2FidWlsZC9ycG1idWlsZC9CVUlMRC9xZW11LTQuMi4wL2h3L3MzOTB4
L2lwbC5jOjY1OTozMjogZXJyb3I6DQpjYXN0IGZyb20gcG9pbnRlciB0byBpbnRlZ2VyIG9mIGRp
ZmZlcmVudCBzaXplIFstV2Vycm9yPXBvaW50ZXItdG8taW50LQ0KY2FzdF0NCiAgNjU5IHwgICAg
IHJjID0gczM5MF9wdl9zZXRfc2VjX3Bhcm1zKCh1aW50NjRfdCloZHIsDQogICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeDQoNCg0KLSBCcnVjZQ0K

