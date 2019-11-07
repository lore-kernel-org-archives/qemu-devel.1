Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F4AC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9022178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=here.com header.i=@here.com header.b="IWqvUjlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9022178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=here.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSfFg-0002bG-Rd
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 05:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.bonnans@here.com>) id 1iSfEl-0001tR-Ld
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.bonnans@here.com>) id 1iSfEj-0005lC-GG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:41:58 -0500
Received: from mail-eopbgr70132.outbound.protection.outlook.com
 ([40.107.7.132]:48470 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent.bonnans@here.com>)
 id 1iSfEj-0005cG-1J; Thu, 07 Nov 2019 05:41:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2Z1bSAjobUsZzuCMxgJccaiQsyw6PDUwwzAr4dWDkNoJIUTIG4tZ7niD0LCoYAbdv0rbxHlvfMUiqLPDrJuHrwPhAm7wLBjdZ4umCQ1g5+2flwhKtznG9BMj1vu13yhwFkUrnTh7SQFbNm/B1tlL2Bp28JGSnSQ01T7+OFiYL3X5luzisHgcFvwjK7LM/4F5m5OrM+/p0DAFyAk2nz37ftND2pGDGdNU+4b4ThCp5LrCmoVQIA8KguDCfW0PRhy26++zmf/D0dWQrMw4PdnBCxwfv0XnZKgq8PprsBi1Tz2QxaQH8xWnSD/ZA+o47CLKuPRBs7tFbX7YRkC2Oybsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQuWuDGCA1yC1fG3tvEW3QfKCz6TrQtiBhFRLFVml1E=;
 b=WhwhUhGCGGuL58YkqbUQ4kyu9RBvufPTU1mDLFDwWiD1E4t/t/Cf34dI3gTNBHBtFNKjogryfSEbLPkRE22BEY7+EoN10ID0CveC7SOkbKrL1lpEYFqK33XhVa4gwBbAXtNNH+tbT16TDHfoBx2m2A7pZyRQx2iZtA1YC//iooo0szAzbqJz62FqQ91gtU4zc7emAnu/IXZeQjIjELQODJFNm/pWx2f8FjVanXDc+0oH7oCdm4+p1UDBqfcnASiKlRNagSja9RoQnb2yNO/I5Ba3Fsi5bw17hsbrIQcPVovuKnOTGJdytDp2E5odBLgYzo0FKmfWUjujyjDlxIrijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=here.com; dmarc=pass action=none header.from=here.com;
 dkim=pass header.d=here.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=here.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQuWuDGCA1yC1fG3tvEW3QfKCz6TrQtiBhFRLFVml1E=;
 b=IWqvUjlLizgnUCjBvfP3kHhrFeY1AfUR9/duSG+PVj+usd1aw+bC0YD6QL5oASoBETOka0DPfzqLw7MfHP33fyW0WjI8hWgW73+RrKLBZzVw1Zpo33uOvjcpey+45DRzMOxB+Wnlwd/eoNF+cDiI4V5X/0rRkaxOsO0g+ds0KTA=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3138.eurprd04.prod.outlook.com (10.167.170.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 10:41:53 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::8ce8:9eaf:3916:4bc9]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::8ce8:9eaf:3916:4bc9%6]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 10:41:53 +0000
From: "Bonnans, Laurent" <laurent.bonnans@here.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 11/16] hw/arm/raspi: Use -smp cores=<N> option to
 restrict enabled cores
Thread-Topic: [PATCH v3 11/16] hw/arm/raspi: Use -smp cores=<N> option to
 restrict enabled cores
Thread-Index: AQHVhteXkTVRZwI30EKFSoYgoiDcEKd/ojwA
Date: Thu, 7 Nov 2019 10:41:52 +0000
Message-ID: <ab9cdba2-1655-ea43-abe7-59220664bfa6@here.com>
References: <20191019234715.25750-1-f4bug@amsat.org>
 <20191019234715.25750-12-f4bug@amsat.org>
In-Reply-To: <20191019234715.25750-12-f4bug@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurent.bonnans@here.com; 
x-originating-ip: [131.228.216.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49e0c20b-4d6f-402f-b4fe-08d7636f1a6f
x-ms-traffictypediagnostic: AM5PR04MB3138:|AM5PR04MB3138:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB313825B0117F73D3E361F63B85780@AM5PR04MB3138.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:114;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(346002)(366004)(39850400004)(376002)(136003)(199004)(189003)(51914003)(66446008)(6436002)(7736002)(31686004)(66476007)(66556008)(64756008)(478600001)(7416002)(6512007)(486006)(25786009)(76176011)(4326008)(66066001)(305945005)(6246003)(5660300002)(229853002)(36756003)(86362001)(54906003)(110136005)(76116006)(91956017)(99286004)(31696002)(81166006)(476003)(11346002)(6506007)(446003)(3846002)(8936002)(81156014)(26005)(53546011)(8676002)(14454004)(14444005)(256004)(102836004)(71200400001)(71190400001)(316002)(6486002)(66946007)(6116002)(2501003)(186003)(2616005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM5PR04MB3138;
 H:AM5PR04MB3299.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: here.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWvA7c4rWvEzci/Z6G3RfwZlrr55PKn0fFpOUfyF/Xc3GYnfyqm9iEQAE8mDDY6HE4cF/rf9P9iF+ypPBLgWPYPKzqv13w3n7skroczFZDuCE1O/aKSoaxIqXrWTBktxm1N5bg/X6mI/e+QJGWDLS5OcD1XoqUZ36gfctIscuBlE0fwQTtTjwpzIQsykYSn7ee7vlGyRGvPqtxPzStYJlYOozQ+8SYfk66J5B5GtBynkxfiA5MPAQLfcPE6s4ghBHKS7E+i74mZn2Aun4Ko/b2yFbX6oK9c8b4OEDGMKoxV32zyREkvUsY9zeM1PWTUr1MiOIfEbc/4tY9twAnf/V/5VdMqf/pf+DDmwfKcwO2d1b5biw67IIT9vlodaFvNVd4XCB4P/EO4QSYsmo/N3ED3xPp7rOfN+UvHnzkRh/Z52CmXQuveYudE4mD4mM+Uy
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC4EE5EB6AFEFE41AB258F96C9EEA9AA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e0c20b-4d6f-402f-b4fe-08d7636f1a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 10:41:53.0233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXW4YGJsXTsrV6XV1Wnk/M4UBhp/I3L9F86Mgu0wsl6mE0h8pNfq9RooiPN5GGuBmpH8/9jTsJs0sfbRL6eSUXpf9vyvdeaZvBUpF1pCJ0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3138
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.132
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Pete Batard <pete@akeo.ie>, "Xiang, Cheng" <ext-cheng.xiang@here.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTAvMjAvMTkgMTo0NyBBTSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFRo
ZSBhYnN0cmFjdCBUWVBFX0JDTTI4M1ggZGV2aWNlIHByb3ZpZGVzIGEgJ2VuYWJsZWQtY3B1cycg
cHJvcGVydHkNCj4gdG8gcmVzdHJpY3QgdGhlIG51bWJlciBvZiBjb3JlcyBwb3dlcmVkIG9uIHJl
c2V0LiBUaGlzIGJlY2F1c2Ugb24NCj4gcmVhbCBoYXJkd2FyZSB0aGUgR1BVIGlzIHJlc3BvbnNp
YmxlIG9mIHN0YXJ0aW5nIHRoZSBjb3JlcyBhbmQga2VlcA0KPiB0aGVtIHNwaW5uaW5nIHVudGls
IHRoZSBMaW51eCBrZXJuZWwgaXMgcmVhZHkgdG8gdXNlIHRoZW0uDQo+IFdoZW4gdXNpbmcgdGhl
IC1rZXJuZWwgcGFyYW1lbnRlciwgUUVNVSBkb2VzIHRoaXMgYnkgaW5zdGFsbGluZyB0aGUNCj4g
J3Jhc3BpX3NtcGJvb3QnIGNvZGUgd2hlbiBhcm1fYm9vdF9pbmZvOjp3cml0ZV9ib2FyZF9zZXR1
cCgpIGlzDQo+IGNhbGxlZC4gVGhpcyBpcyBhIHNwZWNpYWwgZmVhdHVyZSB0byBoZWxwIHRoZSBM
aW51eCBrZXJuZWwsIGFuZCBjYW4NCj4gb25seSBiZSB1c2VkIHdpdGggYSBMaW51eCBrZXJuZWwu
DQo+DQo+IEV2ZW4gaWYgbG9hZGVkIHdpdGggdGhlIC1rZXJuZWwgb3B0aW9uLCBVLWJvb3QgaXMg
bm90IExpbnV4LCB0aHVzDQo+IGlzIG5vdCByZWNvZ25pemVkIGFzIGl0IGFuZCB0aGUgcmFzcGlf
c21wYm9vdCBjb2RlIGlzIG5vdCBpbnN0YWxsZWQuDQo+DQo+IFVwb24gaW50cm9kdWN0aW9uIG9m
IHRoaXMgbWFjaGluZSBpbiBjb21taXQgMWRmN2QxZjkzMDMsIHRoZSAtc21wIDxOPg0KPiBvcHRp
b24gYWxsb3dkIHRvIGxpbWl0IHRoZSBudW1iZXIgb2YgY29yZXMgcG93ZXJlZCBvbiByZXNldC4N
Cj4gVW5mb3J0dW5hdGVseSBsYXRlciBjb21taXQgNzI2NDk2MTkzNDEgYWRkZWQgYSBjaGVjayB3
aGljaCBtYWRlIHRoaXMNCj4gZmVhdHVyZSB1bnVzYWJsZToNCj4NCj4gICAgJCBxZW11LXN5c3Rl
bS1hYXJjaDY0IC1NIHJhc3BpMyAtc21wIDENCj4gICAgcWVtdS1zeXN0ZW0tYWFyY2g2NDogSW52
YWxpZCBTTVAgQ1BVcyAxLiBUaGUgbWluIENQVXMgc3VwcG9ydGVkIGJ5IG1hY2hpbmUgJ3Jhc3Bp
MycgaXMgNA0KPg0KPiBGb3J0dW5hdGVseSwgdGhlIC1zbXAgb3B0aW9uIGFsbG93IHZhcmlvdXMg
a2luZCBvZiBDUFUgdG9wb2xvZ3k6DQo+DQo+ICAgIC1zbXAgW2NwdXM9XW5bLG1heGNwdXM9Y3B1
c11bLGNvcmVzPWNvcmVzXVssdGhyZWFkcz10aHJlYWRzXVssZGllcz1kaWVzXVssc29ja2V0cz1z
b2NrZXRzXQ0KPiAgICAgICAgICAgICBzZXQgdGhlIG51bWJlciBvZiBDUFVzIHRvICduJyBbZGVm
YXVsdD0xXQ0KPiAgICAgICAgICAgICBtYXhjcHVzPSBtYXhpbXVtIG51bWJlciBvZiB0b3RhbCBj
cHVzLCBpbmNsdWRpbmcNCj4gICAgICAgICAgICAgb2ZmbGluZSBDUFVzIGZvciBob3RwbHVnLCBl
dGMNCj4gICAgICAgICAgICAgY29yZXM9IG51bWJlciBvZiBDUFUgY29yZXMgb24gb25lIHNvY2tl
dCAoZm9yIFBDLCBpdCdzIG9uIG9uZSBkaWUpDQo+ICAgICAgICAgICAgIHRocmVhZHM9IG51bWJl
ciBvZiB0aHJlYWRzIG9uIG9uZSBDUFUgY29yZQ0KPiAgICAgICAgICAgICBkaWVzPSBudW1iZXIg
b2YgQ1BVIGRpZXMgb24gb25lIHNvY2tldCAoZm9yIFBDIG9ubHkpDQo+ICAgICAgICAgICAgIHNv
Y2tldHM9IG51bWJlciBvZiBkaXNjcmV0ZSBzb2NrZXRzIGluIHRoZSBzeXN0ZW0NCj4NCj4gTGV0
J3MgdXNlIHRoZSAnY29yZXMnIGFyZ3VtZW50IHRvIHNwZWNpZnkgdGhlIG51bWJlciBvZiBjb3Jl
cyBwb3dlcmVkDQo+IGF0IHJlc2V0IHRvIHJlc3RvcmUgdGhpcyBmZWF0dXJlLCBhbmQgYWxsb3cg
dG8gYm9vdCBVLWJvb3QuDQo+DQo+IFdlIGNhbiBub3cgcnVuIFUtYm9vdCB1c2luZzoNCj4NCj4g
ICAgJCBxZW11LXN5c3RlbS1hYXJjaDY0IC1NIHJhc3BpMyAtc21wIDQsY29yZXM9MSAuLi4NCj4N
Cj4gUmVwb3J0ZWQtYnk6IExhdXJlbnQgQm9ubmFucyA8bGF1cmVudC5ib25uYW5zQGhlcmUuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8ZjRidWdAYW1zYXQu
b3JnPg0KPiAtLS0NCj4gICBody9hcm0vcmFzcGkuYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9o
dy9hcm0vcmFzcGkuYyBiL2h3L2FybS9yYXNwaS5jDQo+IGluZGV4IDU2OWQ4NWMxMWEuLjQ1ZDNm
OTFmOTUgMTAwNjQ0DQo+IC0tLSBhL2h3L2FybS9yYXNwaS5jDQo+ICsrKyBiL2h3L2FybS9yYXNw
aS5jDQo+IEBAIC0xOTAsOCArMTkwLDggQEAgc3RhdGljIHZvaWQgcmFzcGlfaW5pdChNYWNoaW5l
U3RhdGUgKm1hY2hpbmUsIGludCB2ZXJzaW9uKQ0KPiAgICAgICAvKiBTZXR1cCB0aGUgU09DICov
DQo+ICAgICAgIG9iamVjdF9wcm9wZXJ0eV9hZGRfY29uc3RfbGluayhPQkpFQ1QoJnMtPnNvYyks
ICJyYW0iLCBPQkpFQ1QoJnMtPnJhbSksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmZXJyb3JfYWJvcnQpOw0KPiAtICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfaW50KE9C
SkVDVCgmcy0+c29jKSwgbWFjaGluZS0+c21wLmNwdXMsICJlbmFibGVkLWNwdXMiLA0KPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ICsgICAgb2JqZWN0X3By
b3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5zb2MpLCBtYWNoaW5lLT5zbXAuY29yZXMsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgImVuYWJsZWQtY3B1cyIsICZlcnJvcl9hYm9ydCk7
DQo+ICAgICAgIGludCBib2FyZF9yZXYgPSB2ZXJzaW9uID09IDMgPyAweGEwMjA4MiA6IDB4YTIx
MDQxOw0KPiAgICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2ludChPQkpFQ1QoJnMtPnNvYyksIGJv
YXJkX3JldiwgImJvYXJkLXJldiIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZl
cnJvcl9hYm9ydCk7DQoNCkhpIFBoaWwsDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNoLCBJIGZpbmFs
bHkgZ290IHRoZSBjaGFuY2UgdG8gbWFrZSBzb21lIHRlc3RzIChzb3JyeSANCmFib3V0IHRoZSBk
ZWxheSkuDQoNClVzaW5nIHRoZSBwcm9wb3NlZCAtc21wIG9wdGlvbnMgaW5kZWVkIGhlbHBzIHRv
IHJ1biB1LWJvb3QgZWxmcyANCmRpcmVjdGx5LiBIb3dldmVyLCB0aGUgY29yZXMgZmFpbCB0byBz
dGFydCB3aGVuIHN3aXRjaGluZyB0byBsaW51eCANCih0ZXN0ZWQgb24gcmFzcGkyKToNCg0KWyAw
LjA3MTAzMF0gc21wOiBCcmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAuLi4NClsgMS4xNTc4NzZd
IENQVTE6IGZhaWxlZCB0byBjb21lIG9ubGluZQ0KWyAyLjIxOTg5OV0gQ1BVMjogZmFpbGVkIHRv
IGNvbWUgb25saW5lDQpbIDMuMjg1NDEyXSBDUFUzOiBmYWlsZWQgdG8gY29tZSBvbmxpbmUNClsg
My4yODYxMzddIHNtcDogQnJvdWdodCB1cCAxIG5vZGUsIDEgQ1BVDQpbIDMuMjg2NzY2XSBTTVA6
IFRvdGFsIG9mIDEgcHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDEyNS4wMCBCb2dvTUlQUykuDQpbIDMu
Mjg3NDQyXSBDUFU6IEFsbCBDUFUocykgc3RhcnRlZCBpbiBTVkMgbW9kZS4NCg0KVGhlIGJlaGF2
aW9yIHBlcnNpc3QgZXZlbiB3aXRob3V0IHVzaW5nIHRoZSBvcHRpb24gb24gdGhlIGNvbW1hbmQg
bGluZS4NClRoZSBub3JtYWwgYmVoYXZpb3IgaXMgcmVzdG9yZWQgaWYgSSB1c2UgIi1zbXAgNCwg
Y29yZXM9NCINCg0KR3JlZXRpbmdzLA0KDQpMYXVyZW50DQo=

