Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FAAC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 20:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAC72083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 20:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAC72083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyMLL-0004CT-59
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 16:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <BROGERS@suse.com>) id 1hyMKW-0003l9-GX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1hyMKT-0005w7-1P
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:26:39 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:33333)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1hyMKR-0005vE-Qb
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:26:36 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.191) BY
 m9a0003g.houston.softwaregrp.com WITH ESMTP; 
 Thu, 15 Aug 2019 20:26:01 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 15 Aug 2019 20:11:18 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 15 Aug 2019 20:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYw9bdr6+dzH1Fcw10/6Hq9dlVrbY9NwOP8VhRn5BnDIuUBqyZq9g949adKiwRG2wjCqy2RKhdiw4wzwKY+mY6WPZR7A829Qi7t9XNU8oLP96cEEO25YejycOfcCqCF18gvN+Ur6gEDRFFzZ3jPqrNZ+tI+TZ4IeZgJfpevpMwf6vgzDvjRakweLhmbXKmnX3AJtg0J0wwATgFQ75BW8RWQmxPKn3gQJvaqbMPZFMWw+ddsm4MjVovntnnmEoxbi2i2jo3InbWsma8+M1b1XcatJNj6f73NVO1MsBclsoxddjMdFh1xkSnQUAouDH0NRsKi2BMXceorK5HOlxfL5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHZmKgKYWH9PH8wagXnr2UQmwH/b6SjtaShL6iPFc24=;
 b=PxJ/M/M7vJuhbJjt/lmUyMIjsSFAHR89O7TsbiYxlbtpqxhVyzetoVs2sydlhaLqPu0O8hUqRvK3bleLRTzG0UJawjSKctmx850JfwLcRcO70mv0npifv/yExt7Y/f/0pSrzfcmTA+azsy715H7nhgyE32ZEsO+7qydTNBo1izhzP50ckM2VNaARe2ZACsVQhuBb1YV+nqG4nMWjyKPCYDbzO7XAwfy/bcUoX3nko/U/wvbbIFj0JWQqJVs8YvFeL/MhuQd5AUeQMu2AHa2pjs+Nw2VTu304oDAECTiY2ePKOEyTXmuUjqFdCa636LYiz/8Al4PapjzqCH8T0yEQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3096.namprd18.prod.outlook.com (10.255.155.222) by
 CH2PR18MB3221.namprd18.prod.outlook.com (52.132.246.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 15 Aug 2019 20:11:16 +0000
Received: from CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::54ad:4562:f961:5610]) by CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::54ad:4562:f961:5610%3]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 20:11:16 +0000
From: Bruce Rogers <BROGERS@suse.com>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>
Thread-Topic: current QEMU can't start pc-q35-2.12  SEV guest
Thread-Index: AQHVUwNccBcqwdRS4UOs8Xi34penKqb8jNEygAAYVQA=
Date: Thu, 15 Aug 2019 20:11:15 +0000
Message-ID: <50215bc14541bf5f7c60531e2be1b6d637c700d0.camel@suse.com>
References: <89368c9df9e960ead712227ac8dd3e1793c164b0.camel@suse.com>
 <20190815184351.GX3908@habkost.net>
In-Reply-To: <20190815184351.GX3908@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=BROGERS@suse.com; 
x-originating-ip: [63.248.144.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02fefabb-7f99-4f39-a23a-08d721bcba60
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CH2PR18MB3221; 
x-ms-traffictypediagnostic: CH2PR18MB3221:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB322124672D58E44576277CFCD9AC0@CH2PR18MB3221.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(199004)(189003)(71200400001)(2501003)(118296001)(71190400001)(14454004)(256004)(53936002)(76176011)(4326008)(6246003)(54906003)(107886003)(8936002)(99286004)(478600001)(316002)(25786009)(81166006)(81156014)(1730700003)(8676002)(2351001)(66066001)(36756003)(6916009)(305945005)(6512007)(5640700003)(6436002)(7736002)(229853002)(2906002)(86362001)(5660300002)(6116002)(3846002)(76116006)(91956017)(66556008)(66476007)(66946007)(64756008)(102836004)(6506007)(186003)(26005)(11346002)(66446008)(476003)(486006)(2616005)(6486002)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR18MB3221;
 H:CH2PR18MB3096.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VJvbsUF6o42uoQyJbO+BRCN4SEfM4OOCUs5yuf3kKQYEmGVxIG/OMHakGBi3QORKCHFQW2N1hIXpkvpZfbhbg1Xnw0soyLtvIY4yOxy1kO/mWibGjRtYP7MthYYEsxo7GExBtafTXCH2eZhzDHWhXlknEBtJSE1zoWIkY+SM9kKswRZDzJ46yqZKB6OkIuz3CnvPYkR2ICgXXGUoqLyDngGNdAPtCZcCLEBEgnjgv5Tk3KCRHOzIVverNdkXTeXcOmO8jC2kCcn/uSwqCaSFdAALV8sNX2T8RavvLvvU0qL9cfYuaSwC0+GrXSRg8+nk5bnYmYFGC7YRPTVxKqkn5uyTl4BOzLMGxFTWKwvR5Jb5afMqzlcQgPUDW+U0Ueo3tmjHG9AfcZFEgDqd2wmGGXGqKM/JqHpXP/jOKoPFYDU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB0466D9F442874586073C6951E14E74@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fefabb-7f99-4f39-a23a-08d721bcba60
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 20:11:15.7060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zLLVOoUNR72spYVmL1o0sVWxYsz5/9iVOL+zU9l/0mhv6yz/zXbj+fgggU7lGSaNV5F14jp2m8zZx9+tx66ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3221
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 15.124.64.68
Subject: Re: [Qemu-devel] current QEMU can't start pc-q35-2.12  SEV guest
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
Cc: Liang Yan <LYan@suse.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDE5LTA4LTE1IGF0IDE1OjQzIC0wMzAwLCBFZHVhcmRvIEhhYmtvc3Qgd3JvdGU6
DQo+IE9uIFRodSwgQXVnIDE1LCAyMDE5IGF0IDEyOjQ5OjU4QU0gKzAwMDAsIEJydWNlIFJvZ2Vy
cyB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBJIHJhbiBpbnRvIGEgY2FzZSB3aGVyZSBhIGd1
ZXN0IG9uIGEgU0VWIGNhcGFibGUgaG9zdCwgd2hpY2ggd2FzDQo+ID4gZW5hYmxlZCB0byB1c2Ug
U0VWIGFuZCB1c2luZyBhbiBvbGRlciBtYWNoaW5lIHR5cGUgd2FzIG5vIGxvbmdlcg0KPiA+IGFi
bGUNCj4gPiB0byBydW4gd2hlbiB0aGUgUUVNVSB2ZXJzaW9uIGhhZCBiZWVuIHVwZGF0ZWQuDQo+
ID4gDQo+ID4gU3BlY2lmaWNhbGx5LCB3aGVuIHRoZSBndWVzdCB3YXMgaW5zdGFsbGVkIGFuZCBy
dW5uaW5nIHVuZGVyIGENCj4gPiB2Mi4xMg0KPiA+IFFFTVUsIHNldCB1cCBmb3IgU0VWIChvayBp
dCB3YXMgdjIuMTEgd2l0aCBTRVYgc3VwcG9ydCBiYWNrcG9ydGVkLA0KPiA+IGJ1dA0KPiA+IHRo
ZSBkZXRhaWxzIHN0aWxsIGFwcGx5KSwgdXNpbmcgYSBjb21tYW5kIGxpbmUgc3VjaCBhcyBmb2xs
b3dzOg0KPiA+IA0KPiA+IHFlbXUtc3lzdGVtLXg4Nl82NCAtY3B1IEVQWUMtSUJSUyBcDQo+ID4g
LW1hY2hpbmUgcGMtcTM1LTIuMTIsYWNjZWw9a3ZtLG1lbW9yeS1lbmNyeXB0aW9uPXNldjAgXA0K
PiA+IC1vYmplY3Qgc2V2LWd1ZXN0LGlkPXNldjAsLi4uDQo+ID4gDQo+ID4gVGhlIGd1ZXN0IHJh
biBmaW5lLCB1c2luZyBTRVYgbWVtb3J5IGVucnlwdGlvbi4NCj4gPiANCj4gPiBMYXRlciB0aGUg
dmVyc2lvbiBvZiBRRU1VIHdhcyB1cGRhdGVkIHRvIHYzLjEuMCwgYW5kIHRoZSBzYW1lIGd1ZXN0
DQo+ID4gbm93DQo+ID4gaHVuZyBhdCBib290LCB3aGVuIHVzaW5nIHRoZSBleGFjdCBzYW1lIGNv
bW1hbmQgbGluZS4gKEN1cnJlbnQgUUVNVQ0KPiA+IHN0aWxsIGhhcyB0aGUgc2FtZSBwcm9ibGVt
LikNCj4gPiANCj4gPiBVcG9uIGludmVzdGlnYXRpb24sIEkgZmluZCB0aGF0IHRoZSBoYW5kbGlu
ZyBvZiB4bGV2ZWwgaW4NCj4gPiB0YXJnZXQvaTM4Ni9jcHUuYyByZWxpZXMgaW5jbHVkZXMgYW4g
ZXhwbGljaXQgZGV0ZWN0aW9uIG9mIFNFVg0KPiA+IGJlaW5nDQo+ID4gZW5hYmxlZCBhbmQgc2V0
cyB0aGUgY3B1aWRfbWluX3hsZXZlbCBpbiB0aGUgQ1BVWDg2U3RhdGUgc3RydWN0dXJlDQo+ID4g
dG8NCj4gPiAweDgwMDAwMDFGIGFzIHRoZSByZXF1aXJlZCBtaW5pbXVtIGZvciBTRVYgc3VwcG9y
dC4gVGhpcyBub3JtYWxseQ0KPiA+IGlzDQo+ID4gdXNlZCB0byBzZXQgdGhlIHhsZXZlbCB0aGUg
Z3Vlc3Qgc2VlcywgYWxsb3dpbmcgaXQgdG8gdXNlIFNFVi4NCj4gPiANCj4gPiBUaGUgY29tcGF0
IHNldHRpbmdzIGZvciB0aGUgdjIuMTIgbWFjaGluZSB0eXBlIGluY2x1ZGUgYW4geGxldmVsDQo+
ID4gdmFsdWUNCj4gPiBhc3NvY2lhdGVkIHdpdGggaXQgKDB4ODAwMDAwMEEpLiBVbmZvcnR1bmF0
ZWx5IHRoZSBwcm9jZXNzaW5nIG9mDQo+ID4gdGhlDQo+ID4gY29tcGF0IHNldHRpbmdzIGdldHMg
Y29uZmxhdGVkIHdpdGggdGhlIGxvZ2ljIG9mIGhhbmRsaW5nIGEgdXNlcg0KPiA+IGV4cGxpY2l0
bHkgc3BlY2lmeWluZyBhbiB4bGV2ZWwgb24gdGhlIGNvbW1hbmQgbGluZSwgd2hpY2ggaXMNCj4g
PiB0cmVhdGVkDQo+ID4gYXMgYW4gIm92ZXJyaWRlIiBjb25kaXRpb24sIG92ZXJyaWRpbmcgdGhl
IG90aGVyIHhsZXZlbCBzZWxlY3Rpb25zDQo+ID4gd2hpY2ggd291bGQgb3RoZXJ3aXNlIGJlIGRv
bmUgaW4gdGhlIFFFTVUgY3B1IGNvZGUuDQo+ID4gDQo+ID4gU28sIGluIHRoZSBzY2VuYXJpbyBJ
IGRlc2NyaWJlIGFib3ZlLCB0aGUgb3JpZ2luYWwsIHdvcmtpbmcgY2FzZQ0KPiA+IHdvdWxkDQo+
ID4gcHJvdmlkZSBhbiBjcHVpZCB4bGV2ZWwgdmFsdWUgb2YgMHg4MDAwMDAxRiB0byB0aGUgZ3Vl
c3QgKGNvcnJlY3QpLA0KPiA+IGFuZA0KPiA+IHRoZSBmYWlsaW5nIGNhc2UgZW5kcyB1cCBwcm92
aWRpbmcgdGhlIHZhbHVlIDB4ODAwMDAwMEENCj4gPiAoaW5jb3JyZWN0KS4NCj4gPiANCj4gPiBJ
dCBzZWVtcyB0byBtZSB0aGF0IHRoZSBoYW5kbGluZyBvZiB0aGUgY29tcGF0IHNldHRpbmdzIGFu
ZCB0aGUNCj4gPiBleHBsaWNpdCB4bGV2ZWwgc2V0dGluZyBieSB0aGUgdXNlciBzaG91bGQgYmUg
cHJvY2Vzc2VkIHNlcGFyYXRlbHksDQo+ID4gYnV0DQo+ID4gSSBkb24ndCBzZWUgaG93IHRvIGRv
IHRoYXQgZWFzaWx5Lg0KPiA+IA0KPiA+IEhvdyBzaG91bGQgdGhpcyBwcm9ibGVtIGJlIHJlc29s
dmVkPw0KPiA+IA0KPiA+IEluIG15IGNhc2UsIEkndmUgYWRkZWQgdG8gdGhlIGNvZGUgd2hpY2gg
aXMgZm9yIGNoZWNraW5nIGEgdXNlcg0KPiA+IHByb3ZpZGVkIHhsZXZlbCB2YWx1ZSwgdGhlIGNo
ZWNrIGFnYWluIGZvciBzZXZfZW5hYmxlZCgpLCBhbmQgaWYNCj4gPiB0aGF0J3MNCj4gPiB0aGUg
Y2FzZSwgSSBzdGlsbCBhcHBseSB0aGUgY3B1aWRfbWluX3hsZXZlbCB2YWx1ZS4gVGhpcyB3b3Jr
cyBmb3INCj4gPiB0aGUNCj4gPiB0aW1lIGJlaW5nLCBidXQgZG9lc24ndCBzZWVtIHRvIGJlIHRo
ZSByaWdodCBzb2x1dGlvbi4NCj4gPiANCj4gDQo+IEkgYmVsaWV2ZSB0aGlzIGlzIG15IGZhdWx0
LiAgT24gY29tbWl0IGUwMDUxNjQ3NWMyNyAoImkzODY6DQo+IEVuYWJsZSBUT1BPRVhUIGZlYXR1
cmUgb24gQU1EIEVQWUMgQ1BVIiksIEkgaGFkIGFkZGVkDQo+IHhsZXZlbD0weDgwMDAwMDBBIGNv
bXBhdCBlbnRyaWVzLCBidXQgdGhleSB3ZXJlIHN1cHBvc2VkIHRvIGJlDQo+IG1pbi14bGV2ZWw9
MHg4MDAwMDAwQS4NCj4gDQo+IERvZXMgdGhpcyBwYXRjaCBzb2x2ZSB0aGUgcHJvYmxlbT8NCj4g
DQo+IC0tLQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvcGMuYyBiL2h3L2kzODYvcGMuYw0K
PiBpbmRleCA1NDljNDM3MDUwLi4xMWQ1YTNjZDNhIDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2L3Bj
LmMNCj4gKysrIGIvaHcvaTM4Ni9wYy5jDQo+IEBAIC0xNTQsOCArMTU0LDggQEAgY29uc3Qgc2l6
ZV90IHBjX2NvbXBhdF8zXzBfbGVuID0NCj4gR19OX0VMRU1FTlRTKHBjX2NvbXBhdF8zXzApOw0K
PiAgR2xvYmFsUHJvcGVydHkgcGNfY29tcGF0XzJfMTJbXSA9IHsNCj4gICAgICB7IFRZUEVfWDg2
X0NQVSwgImxlZ2FjeS1jYWNoZSIsICJvbiIgfSwNCj4gICAgICB7IFRZUEVfWDg2X0NQVSwgInRv
cG9leHQiLCAib2ZmIiB9LA0KPiAtICAgIHsgIkVQWUMtIiBUWVBFX1g4Nl9DUFUsICJ4bGV2ZWwi
LCAiMHg4MDAwMDAwYSIgfSwNCj4gLSAgICB7ICJFUFlDLUlCUEItIiBUWVBFX1g4Nl9DUFUsICJ4
bGV2ZWwiLCAiMHg4MDAwMDAwYSIgfSwNCj4gKyAgICB7ICJFUFlDLSIgVFlQRV9YODZfQ1BVLCAi
bWluLXhsZXZlbCIsICIweDgwMDAwMDBhIiB9LA0KPiArICAgIHsgIkVQWUMtSUJQQi0iIFRZUEVf
WDg2X0NQVSwgIm1pbi14bGV2ZWwiLCAiMHg4MDAwMDAwYSIgfSwNCj4gIH07DQo+ICBjb25zdCBz
aXplX3QgcGNfY29tcGF0XzJfMTJfbGVuID0gR19OX0VMRU1FTlRTKHBjX2NvbXBhdF8yXzEyKTsN
Cj4gIA0KPiANCg0KWWVzIHRoYXQgZG9lcyB0aGUgdHJpY2suDQoNCk15IGFuYWx5c2lzIHdhcyBh
IGJpdCBvZmYgdGhlIG1hcmsuIFRoaXMgbWFrZXMgbW9yZSBzZW5zZSB0aGFuIHdoYXQgSQ0Kd2Fz
IGRvaW5nLg0KDQpUaGFua3MhDQoNCkJydWNlDQo=

