Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15BDC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAEE207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LmQobKmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAEE207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPVp-0005QB-1j
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iCPTy-0003jx-3s
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iCPTw-0004vE-6S
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:38:29 -0400
Received: from mail-eopbgr710048.outbound.protection.outlook.com
 ([40.107.71.48]:51728 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iCPTs-0004rm-AV
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:38:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0/pen72sPbSWu2kFpeRt2OlDBmEPk3RcQrFi9fD5RfTRF0gwe3+i+sRfbSgTulZrFYHFWoJDzpPvhX7Fh1eV/J+eC3zVezwEJiXS8OQBK4Zi8pr83xHVpbHdmm6SrpbPdFBiWCw9JaA9Jz9XMUgmshCqAjFAKxiPO+P7iXA5NTWCxrvzo9ZT5twRZzVwDflqM03FIbRUCRG3BRnorWhuQVNBwo5kdruHItGV6FsloYSvnMO9LoE2Vnuzs2ilBpE/8RnxUQWyLxUv9WSxR6LeQdecpJEUELnBuHWCtHIPoaD7EhwnEjWod6Iam7f/CrSxZSABrV3Cz4zIoBaGrtM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbsfud+15H0zzYTwHGSR5uGBqWbE/N0Mi6pXLrAGLmo=;
 b=B3KpB4M6mxOGh2CCZgjV0fx7BqWDGHsqtXysF+y7TJGhhHiQ0omnkELeIFKiu0i+T0cG1+0xNldDo+Z3eBrWPSq5xQm4KajWGCrLYurAf2u4JivJoNZRQhpuu5KaMy13J+mYibI24w6Kv0mlYN9U28/+vnChgfW1apcmw3UFIpCH5YnHZyyjO7cHWdBp9FrvFny1SYzP4ZoiAvHtKxmUZlpNILdKjKTZO+fSZZV728kJobNRNCeknV1O3iW5XvK/TD4vnRRCDIJKggWwnjidaxasgX6Z0rCMCgofqeSKtqLQMd7BVP9RiH5pUEHJyIiXkKHvpElyO5QjcY3tIlXHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbsfud+15H0zzYTwHGSR5uGBqWbE/N0Mi6pXLrAGLmo=;
 b=LmQobKmPjn13OzzJL3F5h7+Epk91m1JOXFhe7escT29SlkMZmLY3RdfZ/65Zah5bbkStRfRjbpdVL+gjbmtUSlKfKZOiq/ovCS+PjMGpF9631AB6L5Y+XaLeIyz6zDBm8DNYGO3EOQrSLZL+xxDOM820EEpW5CMyDNhak7ojRfo=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1676.namprd12.prod.outlook.com (10.172.36.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 23 Sep 2019 14:38:20 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 14:38:20 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 2 PATCH 06/16] hw/core: Add core complex id in X86CPU
 topology
Thread-Topic: [RFC 2 PATCH 06/16] hw/core: Add core complex id in X86CPU
 topology
Thread-Index: AQHVZOcAvXBgYAx8v0mIeU+F8XEfTKc3vl2AgAGw6IA=
Date: Mon, 23 Sep 2019 14:38:19 +0000
Message-ID: <53e5413e-cd92-d826-d0ca-c05fcc765b93@amd.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779713686.21957.6192568272184346850.stgit@localhost.localdomain>
 <20190922084003-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190922084003-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0148.namprd05.prod.outlook.com
 (2603:10b6:803:2c::26) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61980645-472a-42b9-f9c2-08d74033ad8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DM5PR12MB1676; 
x-ms-traffictypediagnostic: DM5PR12MB1676:
x-microsoft-antispam-prvs: <DM5PR12MB1676BDDD1B81F50C2F38493195850@DM5PR12MB1676.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(189003)(199004)(446003)(14444005)(256004)(186003)(14454004)(52116002)(316002)(6506007)(386003)(76176011)(53546011)(81156014)(81166006)(229853002)(8676002)(6916009)(99286004)(8936002)(31696002)(31686004)(6246003)(102836004)(71190400001)(86362001)(71200400001)(54906003)(476003)(6512007)(6436002)(6486002)(486006)(26005)(2616005)(2906002)(25786009)(7736002)(305945005)(66066001)(4326008)(66556008)(36756003)(478600001)(11346002)(66946007)(66476007)(3846002)(66446008)(64756008)(6116002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1676;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b33sLko7RC4IeoCRwPngksd2Jm9o9WhzYga9az4c/p3PEld3VZEz9Gu6Kao9haCsuNCAgMqbItDGnMM+pNegrs9QnJmuu/VYz9eQwkOBSYqq3fjY1FKI1udD0XXuPa6K7co/eLBEnP45EFpssoRJZJXpCicMNVpf0VLRYqcvNwogXVGuCLZ2+O3YXa+uu4uPm0gaVZQ1RP65ptMhRhKo97N5y8q35IQlw6QuN4TLwqEgE8MEbyC4pU5zJPvJquWq+FnIXMA2h7hjCBuT5CLGhemKxQnFZ/Mi6KoWpCg2lW7Tc+sZgOY9vYnPuDHe3uepSluLrN7DYszqe5RMgzEeNfsVx9MqXxb9jcEnI/hPznsXUCf82Af9uLWCKZqM8Go5M7823uZTlkXzQ51XVrxH8zzjC+8n6vcdUfVavrT8JUI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E16D433923BD841B7904F5F0275F9F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61980645-472a-42b9-f9c2-08d74033ad8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 14:38:20.0217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pqt8EPUiRzWBGT3vg2CfD6v9npiyMG8SN1gf3w7AQc5FxW0kYzwspir0xQ28d1lt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1676
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.48
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDkvMjIvMTkgNzo0OCBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiBPbiBG
cmksIFNlcCAwNiwgMjAxOSBhdCAwNzoxMjoxOFBNICswMDAwLCBNb2dlciwgQmFidSB3cm90ZToN
Cj4+IEludHJvZHVjZSBjcHUgY29yZSBjb21wbGV4IGlkKGNjeF9pZCkgaW4geDg2Q1BVIHRvcG9s
b2d5Lg0KPj4gRWFjaCBDQ1ggY2FuIGhhdmUgdXB0byA0IGNvcmVzIGFuZCBzaGFyZSBzYW1lIEwz
IGNhY2hlLg0KPj4gVGhpcyBpbmZvcm1hdGlvbiBpcyByZXF1aXJlZCB0byBidWlsZCB0aGUgdG9w
b2xvZ3kgaW4NCj4+IG5ldyBhcHljIG1vZGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQmFidSBN
b2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KPj4gLS0tDQo+PiAgaHcvY29yZS9tYWNoaW5lLWht
cC1jbWRzLmMgfCAgICAzICsrKw0KPj4gIGh3L2NvcmUvbWFjaGluZS5jICAgICAgICAgIHwgICAx
MyArKysrKysrKysrKysrDQo+PiAgaHcvaTM4Ni9wYy5jICAgICAgICAgICAgICAgfCAgIDEwICsr
KysrKysrKysNCj4+ICBpbmNsdWRlL2h3L2kzODYvdG9wb2xvZ3kuaCB8ICAgIDEgKw0KPj4gIHFh
cGkvbWFjaGluZS5qc29uICAgICAgICAgIHwgICAgNCArKystDQo+PiAgdGFyZ2V0L2kzODYvY3B1
LmMgICAgICAgICAgfCAgICAyICsrDQo+PiAgdGFyZ2V0L2kzODYvY3B1LmggICAgICAgICAgfCAg
ICAxICsNCj4+ICA3IGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9tYWNoaW5lLWhtcC1jbWRzLmMgYi9ody9j
b3JlL21hY2hpbmUtaG1wLWNtZHMuYw0KPj4gaW5kZXggMWY2NmJkYTM0Ni4uNmM1MzQ3NzlhZiAx
MDA2NDQNCj4+IC0tLSBhL2h3L2NvcmUvbWFjaGluZS1obXAtY21kcy5jDQo+PiArKysgYi9ody9j
b3JlL21hY2hpbmUtaG1wLWNtZHMuYw0KPj4gQEAgLTg5LDYgKzg5LDkgQEAgdm9pZCBobXBfaG90
cGx1Z2dhYmxlX2NwdXMoTW9uaXRvciAqbW9uLCBjb25zdCBRRGljdCAqcWRpY3QpDQo+PiAgICAg
ICAgICBpZiAoYy0+aGFzX2RpZV9pZCkgew0KPj4gICAgICAgICAgICAgIG1vbml0b3JfcHJpbnRm
KG1vbiwgIiAgICBkaWUtaWQ6IFwiJSIgUFJJdTY0ICJcIlxuIiwgYy0+ZGllX2lkKTsNCj4+ICAg
ICAgICAgIH0NCj4+ICsgICAgICAgIGlmIChjLT5oYXNfY2N4X2lkKSB7DQo+PiArICAgICAgICAg
ICAgbW9uaXRvcl9wcmludGYobW9uLCAiICAgIGNjeC1pZDogXCIlIiBQUkl1NjQgIlwiXG4iLCBj
LT5jY3hfaWQpOw0KPj4gKyAgICAgICAgfQ0KPj4gICAgICAgICAgaWYgKGMtPmhhc19jb3JlX2lk
KSB7DQo+PiAgICAgICAgICAgICAgbW9uaXRvcl9wcmludGYobW9uLCAiICAgIGNvcmUtaWQ6IFwi
JSIgUFJJdTY0ICJcIlxuIiwgYy0+Y29yZV9pZCk7DQo+PiAgICAgICAgICB9DQo+PiBkaWZmIC0t
Z2l0IGEvaHcvY29yZS9tYWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYw0KPj4gaW5kZXggNDAz
NGI3ZTkwMy4uOWE4NTg2Y2YzMCAxMDA2NDQNCj4+IC0tLSBhL2h3L2NvcmUvbWFjaGluZS5jDQo+
PiArKysgYi9ody9jb3JlL21hY2hpbmUuYw0KPj4gQEAgLTY5NCw2ICs2OTQsMTEgQEAgdm9pZCBt
YWNoaW5lX3NldF9jcHVfbnVtYV9ub2RlKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwNCj4+ICAgICAg
ICAgICAgICByZXR1cm47DQo+PiAgICAgICAgICB9DQo+PiAgDQo+PiArICAgICAgICBpZiAocHJv
cHMtPmhhc19jY3hfaWQgJiYgIXNsb3QtPnByb3BzLmhhc19jY3hfaWQpIHsNCj4+ICsgICAgICAg
ICAgICBlcnJvcl9zZXRnKGVycnAsICJjY3gtaWQgaXMgbm90IHN1cHBvcnRlZCIpOw0KPj4gKyAg
ICAgICAgICAgIHJldHVybjsNCj4+ICsgICAgICAgIH0NCj4+ICsNCj4+ICAgICAgICAgIC8qIHNr
aXAgc2xvdHMgd2l0aCBleHBsaWNpdCBtaXNtYXRjaCAqLw0KPj4gICAgICAgICAgaWYgKHByb3Bz
LT5oYXNfdGhyZWFkX2lkICYmIHByb3BzLT50aHJlYWRfaWQgIT0gc2xvdC0+cHJvcHMudGhyZWFk
X2lkKSB7DQo+PiAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gQEAgLTcwNyw2ICs3MTIs
MTAgQEAgdm9pZCBtYWNoaW5lX3NldF9jcHVfbnVtYV9ub2RlKE1hY2hpbmVTdGF0ZSAqbWFjaGlu
ZSwNCj4+ICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+PiAgICAgICAgICB9DQo+PiAgDQo+
PiArICAgICAgICBpZiAocHJvcHMtPmhhc19jY3hfaWQgJiYgcHJvcHMtPmNjeF9pZCAhPSBzbG90
LT5wcm9wcy5jY3hfaWQpIHsNCj4+ICsgICAgICAgICAgICAgICAgY29udGludWU7DQo+PiArICAg
ICAgICB9DQo+PiArDQo+PiAgICAgICAgICBpZiAocHJvcHMtPmhhc19zb2NrZXRfaWQgJiYgcHJv
cHMtPnNvY2tldF9pZCAhPSBzbG90LT5wcm9wcy5zb2NrZXRfaWQpIHsNCj4+ICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+PiAgICAgICAgICB9DQo+PiBAQCAtMTA0MSw2ICsxMDUwLDEwIEBA
IHN0YXRpYyBjaGFyICpjcHVfc2xvdF90b19zdHJpbmcoY29uc3QgQ1BVQXJjaElkICpjcHUpDQo+
PiAgICAgIGlmIChjcHUtPnByb3BzLmhhc19kaWVfaWQpIHsNCj4+ICAgICAgICAgIGdfc3RyaW5n
X2FwcGVuZF9wcmludGYocywgImRpZS1pZDogJSJQUklkNjQsIGNwdS0+cHJvcHMuZGllX2lkKTsN
Cj4+ICAgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAoY3B1LT5wcm9wcy5oYXNfY2N4X2lkKSB7DQo+
PiArICAgICAgICBnX3N0cmluZ19hcHBlbmRfcHJpbnRmKHMsICJjY3gtaWQ6ICUiUFJJZDY0LCBj
cHUtPnByb3BzLmNjeF9pZCk7DQo+PiArICAgIH0NCj4+ICAgICAgaWYgKGNwdS0+cHJvcHMuaGFz
X2NvcmVfaWQpIHsNCj4+ICAgICAgICAgIGlmIChzLT5sZW4pIHsNCj4+ICAgICAgICAgICAgICBn
X3N0cmluZ19hcHBlbmRfcHJpbnRmKHMsICIsICIpOw0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYv
cGMuYyBiL2h3L2kzODYvcGMuYw0KPj4gaW5kZXggOWUxYzNmOWY1Ny4uZjcxMzg5YWQ5ZiAxMDA2
NDQNCj4+IC0tLSBhL2h3L2kzODYvcGMuYw0KPj4gKysrIGIvaHcvaTM4Ni9wYy5jDQo+PiBAQCAt
MjQ0NCw2ICsyNDQ0LDcgQEAgc3RhdGljIHZvaWQgcGNfY3B1X3ByZV9wbHVnKEhvdHBsdWdIYW5k
bGVyICpob3RwbHVnX2RldiwNCj4+ICANCj4+ICAgICAgICAgIHRvcG9faWRzLnBrZ19pZCA9IGNw
dS0+c29ja2V0X2lkOw0KPj4gICAgICAgICAgdG9wb19pZHMuZGllX2lkID0gY3B1LT5kaWVfaWQ7
DQo+PiArICAgICAgICB0b3BvX2lkcy5jY3hfaWQgPSBjcHUtPmNjeF9pZDsNCj4+ICAgICAgICAg
IHRvcG9faWRzLmNvcmVfaWQgPSBjcHUtPmNvcmVfaWQ7DQo+PiAgICAgICAgICB0b3BvX2lkcy5z
bXRfaWQgPSBjcHUtPnRocmVhZF9pZDsNCj4+ICAgICAgICAgIGNwdS0+YXBpY19pZCA9IGFwaWNp
ZF9mcm9tX3RvcG9faWRzKCZ0b3BvX2luZm8sICZ0b3BvX2lkcyk7DQo+PiBAQCAtMjQ4OSw2ICsy
NDkwLDEzIEBAIHN0YXRpYyB2b2lkIHBjX2NwdV9wcmVfcGx1ZyhIb3RwbHVnSGFuZGxlciAqaG90
cGx1Z19kZXYsDQo+PiAgICAgIH0NCj4+ICAgICAgY3B1LT5kaWVfaWQgPSB0b3BvX2lkcy5kaWVf
aWQ7DQo+PiAgDQo+PiArICAgIGlmIChjcHUtPmNjeF9pZCAhPSAtMSAmJiBjcHUtPmNjeF9pZCAh
PSB0b3BvX2lkcy5jY3hfaWQpIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgInByb3Bl
cnR5IGNjeC1pZDogJXUgZG9lc24ndCBtYXRjaCBzZXQgYXBpYy1pZDoiDQo+PiArICAgICAgICAg
ICAgIiAweCV4IChjY3gtaWQ6ICV1KSIsIGNwdS0+Y2N4X2lkLCBjcHUtPmFwaWNfaWQsIHRvcG9f
aWRzLmNjeF9pZCk7DQo+PiArICAgICAgICByZXR1cm47DQo+PiArICAgIH0NCj4+ICsgICAgY3B1
LT5jY3hfaWQgPSB0b3BvX2lkcy5jY3hfaWQ7DQo+PiArDQo+PiAgICAgIGlmIChjcHUtPmNvcmVf
aWQgIT0gLTEgJiYgY3B1LT5jb3JlX2lkICE9IHRvcG9faWRzLmNvcmVfaWQpIHsNCj4+ICAgICAg
ICAgIGVycm9yX3NldGcoZXJycCwgInByb3BlcnR5IGNvcmUtaWQ6ICV1IGRvZXNuJ3QgbWF0Y2gg
c2V0IGFwaWMtaWQ6Ig0KPj4gICAgICAgICAgICAgICIgMHgleCAoY29yZS1pZDogJXUpIiwgY3B1
LT5jb3JlX2lkLCBjcHUtPmFwaWNfaWQsIHRvcG9faWRzLmNvcmVfaWQpOw0KPj4gQEAgLTI4OTYs
NiArMjkwNCw4IEBAIHN0YXRpYyBjb25zdCBDUFVBcmNoSWRMaXN0ICpwY19wb3NzaWJsZV9jcHVf
YXJjaF9pZHMoTWFjaGluZVN0YXRlICptcykNCj4+ICAgICAgICAgIG1zLT5wb3NzaWJsZV9jcHVz
LT5jcHVzW2ldLnByb3BzLnNvY2tldF9pZCA9IHRvcG9faWRzLnBrZ19pZDsNCj4+ICAgICAgICAg
IG1zLT5wb3NzaWJsZV9jcHVzLT5jcHVzW2ldLnByb3BzLmhhc19kaWVfaWQgPSB0cnVlOw0KPj4g
ICAgICAgICAgbXMtPnBvc3NpYmxlX2NwdXMtPmNwdXNbaV0ucHJvcHMuZGllX2lkID0gdG9wb19p
ZHMuZGllX2lkOw0KPj4gKyAgICAgICAgbXMtPnBvc3NpYmxlX2NwdXMtPmNwdXNbaV0ucHJvcHMu
aGFzX2NjeF9pZCA9IHRydWU7DQo+PiArICAgICAgICBtcy0+cG9zc2libGVfY3B1cy0+Y3B1c1tp
XS5wcm9wcy5jY3hfaWQgPSB0b3BvX2lkcy5jY3hfaWQ7DQo+PiAgICAgICAgICBtcy0+cG9zc2li
bGVfY3B1cy0+Y3B1c1tpXS5wcm9wcy5oYXNfY29yZV9pZCA9IHRydWU7DQo+PiAgICAgICAgICBt
cy0+cG9zc2libGVfY3B1cy0+Y3B1c1tpXS5wcm9wcy5jb3JlX2lkID0gdG9wb19pZHMuY29yZV9p
ZDsNCj4+ICAgICAgICAgIG1zLT5wb3NzaWJsZV9jcHVzLT5jcHVzW2ldLnByb3BzLmhhc190aHJl
YWRfaWQgPSB0cnVlOw0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni90b3BvbG9neS5o
IGIvaW5jbHVkZS9ody9pMzg2L3RvcG9sb2d5LmgNCj4+IGluZGV4IGZiMTA4NjNhNjYuLjVhNjFk
NTNmMDUgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvdG9wb2xvZ3kuaA0KPj4gKysr
IGIvaW5jbHVkZS9ody9pMzg2L3RvcG9sb2d5LmgNCj4+IEBAIC0xNzAsNiArMTcwLDcgQEAgc3Rh
dGljIGlubGluZSB2b2lkIHg4Nl90b3BvX2lkc19mcm9tX2FwaWNpZChhcGljX2lkX3QgYXBpY2lk
LA0KPj4gICAgICAgICAgICAgIChhcGljaWQgPj4gYXBpY2lkX2RpZV9vZmZzZXQobnJfY29yZXMs
IG5yX3RocmVhZHMpKSAmDQo+PiAgICAgICAgICAgICAgfigweEZGRkZGRkZGVUwgPDwgYXBpY2lk
X2RpZV93aWR0aChucl9kaWVzKSk7DQo+PiAgICAgIHRvcG9faWRzLT5wa2dfaWQgPSBhcGljaWQg
Pj4gYXBpY2lkX3BrZ19vZmZzZXQobnJfZGllcywgbnJfY29yZXMsIG5yX3RocmVhZHMpOw0KPj4g
KyAgICB0b3BvX2lkcy0+Y2N4X2lkID0gMDsNCj4+ICB9DQo+PiAgDQo+PiAgLyogTWFrZSBBUElD
IElEIGZvciB0aGUgQ1BVICdjcHVfaW5kZXgnDQo+PiBkaWZmIC0tZ2l0IGEvcWFwaS9tYWNoaW5l
Lmpzb24gYi9xYXBpL21hY2hpbmUuanNvbg0KPj4gaW5kZXggNmRiOGE3ZTJlYy4uYmI3NjI3ZTY5
OCAxMDA2NDQNCj4+IC0tLSBhL3FhcGkvbWFjaGluZS5qc29uDQo+PiArKysgYi9xYXBpL21hY2hp
bmUuanNvbg0KPj4gQEAgLTU5Nyw5ICs1OTcsMTAgQEANCj4+ICAjIEBub2RlLWlkOiBOVU1BIG5v
ZGUgSUQgdGhlIENQVSBiZWxvbmdzIHRvDQo+PiAgIyBAc29ja2V0LWlkOiBzb2NrZXQgbnVtYmVy
IHdpdGhpbiBub2RlL2JvYXJkIHRoZSBDUFUgYmVsb25ncyB0bw0KPj4gICMgQGRpZS1pZDogZGll
IG51bWJlciB3aXRoaW4gbm9kZS9ib2FyZCB0aGUgQ1BVIGJlbG9uZ3MgdG8gKFNpbmNlIDQuMSkN
Cj4+ICsjIEBjY3gtaWQ6IGNvcmUgY29tcGxleCBudW1iZXIgd2l0aGluIG5vZGUvYm9hcmQgdGhl
IENQVSBiZWxvbmdzIHRvIChTaW5jZSA0LjEpDQo+IA0KPiBDYW4gd2UgY29tZSB1cCB3aXRoIGEg
bm9uLUFNRCBzcGVjaWZpYyBuYW1lPw0KPiBFLmcuIHdvdWxkICJsYXN0IGxldmVsIGNhY2hlIiBi
ZSBjb3JyZWN0IGZvciBBTUQ/DQo+IEJldHRlciBpZGVhcz8NCg0KWWVzLiBMYXN0IGxldmVsIGNh
Y2hlIChvciBsbGNfaWQpIHNob3VsZCB3b3JrLiBXaWxsIGNoYW5nZSBpdCBuZXh0DQpyZXZpc2lv
bi4gVGhhbmtzDQoNCj4gDQo+PiAgIyBAY29yZS1pZDogY29yZSBudW1iZXIgd2l0aGluIGRpZSB0
aGUgQ1BVIGJlbG9uZ3MgdG8jIEB0aHJlYWQtaWQ6IHRocmVhZCBudW1iZXIgd2l0aGluIGNvcmUg
dGhlIENQVSBiZWxvbmdzIHRvDQo+PiAgIw0KPj4gLSMgTm90ZTogY3VycmVudGx5IHRoZXJlIGFy
ZSA1IHByb3BlcnRpZXMgdGhhdCBjb3VsZCBiZSBwcmVzZW50DQo+PiArIyBOb3RlOiBjdXJyZW50
bHkgdGhlcmUgYXJlIDYgcHJvcGVydGllcyB0aGF0IGNvdWxkIGJlIHByZXNlbnQNCj4+ICAjIGJ1
dCBtYW5hZ2VtZW50IHNob3VsZCBiZSBwcmVwYXJlZCB0byBwYXNzIHRocm91Z2ggb3RoZXINCj4+
ICAjIHByb3BlcnRpZXMgd2l0aCBkZXZpY2VfYWRkIGNvbW1hbmQgdG8gYWxsb3cgZm9yIGZ1dHVy
ZQ0KPj4gICMgaW50ZXJmYWNlIGV4dGVuc2lvbi4gVGhpcyBhbHNvIHJlcXVpcmVzIHRoZSBmaWxl
ZCBuYW1lcyB0byBiZSBrZXB0IGluDQo+PiBAQCAtNjExLDYgKzYxMiw3IEBADQo+PiAgICAnZGF0
YSc6IHsgJypub2RlLWlkJzogJ2ludCcsDQo+PiAgICAgICAgICAgICAgJypzb2NrZXQtaWQnOiAn
aW50JywNCj4+ICAgICAgICAgICAgICAnKmRpZS1pZCc6ICdpbnQnLA0KPj4gKyAgICAgICAgICAg
ICcqY2N4LWlkJzogJ2ludCcsDQo+PiAgICAgICAgICAgICAgJypjb3JlLWlkJzogJ2ludCcsDQo+
PiAgICAgICAgICAgICAgJyp0aHJlYWQtaWQnOiAnaW50Jw0KPj4gICAgfQ0KPj4gZGlmZiAtLWdp
dCBhL3RhcmdldC9pMzg2L2NwdS5jIGIvdGFyZ2V0L2kzODYvY3B1LmMNCj4+IGluZGV4IDZkN2Y5
YjZiOGIuLmNhMDJiYzIxZWMgMTAwNjQ0DQo+PiAtLS0gYS90YXJnZXQvaTM4Ni9jcHUuYw0KPj4g
KysrIGIvdGFyZ2V0L2kzODYvY3B1LmMNCj4+IEBAIC01ODExLDEyICs1ODExLDE0IEBAIHN0YXRp
YyBQcm9wZXJ0eSB4ODZfY3B1X3Byb3BlcnRpZXNbXSA9IHsNCj4+ICAgICAgREVGSU5FX1BST1Bf
SU5UMzIoInRocmVhZC1pZCIsIFg4NkNQVSwgdGhyZWFkX2lkLCAwKSwNCj4+ICAgICAgREVGSU5F
X1BST1BfSU5UMzIoImNvcmUtaWQiLCBYODZDUFUsIGNvcmVfaWQsIDApLA0KPj4gICAgICBERUZJ
TkVfUFJPUF9JTlQzMigiZGllLWlkIiwgWDg2Q1BVLCBkaWVfaWQsIDApLA0KPj4gKyAgICBERUZJ
TkVfUFJPUF9JTlQzMigiY2N4LWlkIiwgWDg2Q1BVLCBjY3hfaWQsIDApLA0KPj4gICAgICBERUZJ
TkVfUFJPUF9JTlQzMigic29ja2V0LWlkIiwgWDg2Q1BVLCBzb2NrZXRfaWQsIDApLA0KPj4gICNl
bHNlDQo+PiAgICAgIERFRklORV9QUk9QX1VJTlQzMigiYXBpYy1pZCIsIFg4NkNQVSwgYXBpY19p
ZCwgVU5BU1NJR05FRF9BUElDX0lEKSwNCj4+ICAgICAgREVGSU5FX1BST1BfSU5UMzIoInRocmVh
ZC1pZCIsIFg4NkNQVSwgdGhyZWFkX2lkLCAtMSksDQo+PiAgICAgIERFRklORV9QUk9QX0lOVDMy
KCJjb3JlLWlkIiwgWDg2Q1BVLCBjb3JlX2lkLCAtMSksDQo+PiAgICAgIERFRklORV9QUk9QX0lO
VDMyKCJkaWUtaWQiLCBYODZDUFUsIGRpZV9pZCwgLTEpLA0KPj4gKyAgICBERUZJTkVfUFJPUF9J
TlQzMigiY2N4LWlkIiwgWDg2Q1BVLCBjY3hfaWQsIC0xKSwNCj4+ICAgICAgREVGSU5FX1BST1Bf
SU5UMzIoInNvY2tldC1pZCIsIFg4NkNQVSwgc29ja2V0X2lkLCAtMSksDQo+PiAgI2VuZGlmDQo+
PiAgICAgIERFRklORV9QUk9QX0lOVDMyKCJub2RlLWlkIiwgWDg2Q1BVLCBub2RlX2lkLCBDUFVf
VU5TRVRfTlVNQV9OT0RFX0lEKSwNCj4+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9jcHUuaCBi
L3RhcmdldC9pMzg2L2NwdS5oDQo+PiBpbmRleCA4YjNkYzU1MzNlLi5kYjk0MGNkYjJhIDEwMDY0
NA0KPj4gLS0tIGEvdGFyZ2V0L2kzODYvY3B1LmgNCj4+ICsrKyBiL3RhcmdldC9pMzg2L2NwdS5o
DQo+PiBAQCAtMTUwOCw2ICsxNTA4LDcgQEAgc3RydWN0IFg4NkNQVSB7DQo+PiAgICAgIGludDMy
X3Qgbm9kZV9pZDsgLyogTlVNQSBub2RlIHRoaXMgQ1BVIGJlbG9uZ3MgdG8gKi8NCj4+ICAgICAg
aW50MzJfdCBzb2NrZXRfaWQ7DQo+PiAgICAgIGludDMyX3QgZGllX2lkOw0KPj4gKyAgICBpbnQz
Ml90IGNjeF9pZDsNCj4+ICAgICAgaW50MzJfdCBjb3JlX2lkOw0KPj4gICAgICBpbnQzMl90IHRo
cmVhZF9pZDsNCj4+ICANCj4+DQo=

