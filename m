Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63865C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A3C2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R1zKgPjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A3C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he3YC-0001OK-0q
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 16:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56824)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1he2Zh-0004gO-JD
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 15:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1he2Zf-0000cj-7z
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 15:18:20 -0400
Received: from mail-eopbgr820079.outbound.protection.outlook.com
 ([40.107.82.79]:55539 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1he2Zd-0000cI-0b
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 15:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suR3vIpR2MAng/ZLvAGVHPBJ5O757B+AoQWyeHlSQps=;
 b=R1zKgPjXNb9dhJdXaUufUGM/ntfqQTn1IqS4Vkt9qQpD15C5nn0/3wEwDIEFFc93of7fd3m8p6U28VFsYTXs/JYnmGmgQi1tCJGmXdv7CgmrHhGUKrA+QQ+W79Zr1O9z6qVFYOFFrrEg/dyLly9avX8t1NeJsKndoWCaiuWQf+U=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2746.namprd12.prod.outlook.com (20.176.118.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Thu, 20 Jun 2019 19:18:10 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::b9c1:b235:fff3:dba2]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::b9c1:b235:fff3:dba2%6]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 19:18:10 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [RFC PATCH v1 08/12] target.json: add
 migrate-set-sev-info command
Thread-Index: AQHVJ5JxxSpSr3fdPkCv1Ymp5YKU2qak6W2AgAABNwA=
Date: Thu, 20 Jun 2019 19:18:10 +0000
Message-ID: <8d743a07-9561-4b8f-89e0-3322356f630e@amd.com>
References: <20190620180247.8825-1-brijesh.singh@amd.com>
 <20190620180247.8825-9-brijesh.singh@amd.com>
 <7bade677-369a-74a5-206d-700626354028@redhat.com>
In-Reply-To: <7bade677-369a-74a5-206d-700626354028@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:3:101::20) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 327b7c1a-0786-414a-cd40-08d6f5b4086b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2746; 
x-ms-traffictypediagnostic: DM6PR12MB2746:
x-microsoft-antispam-prvs: <DM6PR12MB27469A0E7EDAB20CD413A0DAE5E40@DM6PR12MB2746.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(366004)(396003)(39860400002)(376002)(199004)(189003)(486006)(229853002)(81156014)(81166006)(6486002)(478600001)(11346002)(446003)(31686004)(54906003)(8936002)(2501003)(110136005)(4326008)(53936002)(186003)(66066001)(8676002)(6246003)(14454004)(25786009)(7736002)(6512007)(6436002)(316002)(305945005)(99286004)(66446008)(64756008)(66476007)(36756003)(66556008)(66946007)(102836004)(71190400001)(52116002)(73956011)(53546011)(71200400001)(6506007)(76176011)(386003)(476003)(14444005)(256004)(31696002)(68736007)(2906002)(26005)(2616005)(3846002)(86362001)(6116002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2746;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fYOWHfnu3a68XBw51M9+m/+NmBsxYBusIIjkOOPHQlshbkEOdPP7Xnjf3csoNst28n70KNu/aGH3sL14vjQoeVq8BZcDjnrRYPOm9YmML15YofdEtKo688Fb/V80lsAwcXOP6QT6NQPM0vQuynAWO9iKxBIYGq4xidPz8p3Nicq1rpnK2c++FFGXz7FrtlYeCHFENgeg367kAkO5aPjbBRXQ9mYGArrAlnkQ9uAPOfgut1ptLWdQklWHIDl14XOQxVgCcbt7IpZtoWxGIwURhJwdENAwWo0irPNIxArGnqsTluTm8LXE8AIg362AT2IF50mMo7hs8tAZAEDEE+E5lQTKiJZ5P7xapfkX4TiWaZ+p1IfdMdHkukh/Jtu9WXTatMbTCnU3zf3bnLqPrBkcYEpaxG26/Jv76SaRKbbrlck=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E52CE6588423D0428541204F416FF1D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327b7c1a-0786-414a-cd40-08d6f5b4086b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 19:18:10.6053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.79
Subject: Re: [Qemu-devel] [RFC PATCH v1 08/12] target.json: add
 migrate-set-sev-info command
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
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDYvMjAvMTkgMjoxMyBQTSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNi8yMC8xOSAx
OjAzIFBNLCBTaW5naCwgQnJpamVzaCB3cm90ZToNCj4+IFRoZSBjb21tYW5kIGNhbiBiZSB1c2Vk
IGJ5IHRoZSBoeXBlcnZpc29yIHRvIHNwZWNpZnkgdGhlIHRhcmdldCBQbGF0Zm9ybQ0KPj4gRGlm
ZmllLUhlbGxtYW4ga2V5IChQREgpIGFuZCBjZXJ0aWZpY2F0ZSBjaGFpbiBiZWZvcmUgc3RhcnRp
bmcgdGhlIFNFVg0KPj4gZ3Vlc3QgbWlncmF0aW9uLiBUaGUgdmFsdWVzIHBhc3NlZCB0aHJvdWdo
IHRoZSBjb21tYW5kIHdpbGwgYmUgdXNlZCB3aGlsZQ0KPj4gY3JlYXRpbmcgdGhlIG91dGdvaW5n
IGVuY3J5cHRpb24gY29udGV4dC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNpbmdo
IDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgcWFwaS90YXJnZXQuanNvbiAg
ICAgICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPj4gICB0YXJnZXQvaTM4Ni9tb25pdG9yLmMg
IHwgMTAgKysrKysrKysrKw0KPj4gICB0YXJnZXQvaTM4Ni9zZXYtc3R1Yi5jIHwgIDUgKysrKysN
Cj4+ICAgdGFyZ2V0L2kzODYvc2V2LmMgICAgICB8IDExICsrKysrKysrKysrDQo+PiAgIHRhcmdl
dC9pMzg2L3Nldl9pMzg2LmggfCAgOSArKysrKysrKy0NCj4+ICAgNSBmaWxlcyBjaGFuZ2VkLCA1
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPiANCj4+ICsrKyBiL3FhcGkvdGFy
Z2V0Lmpzb24NCj4+IEBAIC01MTIsMyArNTEyLDIxIEBADQo+PiAgICMjDQo+PiAgIHsgJ2NvbW1h
bmQnOiAncXVlcnktY3B1LWRlZmluaXRpb25zJywgJ3JldHVybnMnOiBbJ0NwdURlZmluaXRpb25J
bmZvJ10sDQo+PiAgICAgJ2lmJzogJ2RlZmluZWQoVEFSR0VUX1BQQykgfHwgZGVmaW5lZChUQVJH
RVRfQVJNKSB8fCBkZWZpbmVkKFRBUkdFVF9JMzg2KSB8fCBkZWZpbmVkKFRBUkdFVF9TMzkwWCkg
fHwgZGVmaW5lZChUQVJHRVRfTUlQUyknIH0NCj4+ICsNCj4+ICsjIw0KPj4gKyMgQG1pZ3JhdGUt
c2V0LXNldi1pbmZvOg0KPj4gKyMNCj4+ICsjIFRoZSBjb21tYW5kIGlzIHVzZWQgdG8gcHJvdmlk
ZSB0aGUgdGFyZ2V0IGhvc3QgaW5mb3JtYXRpb24gdXNlZCBkdXJpbmcgdGhlDQo+PiArIyBTRVYg
Z3Vlc3QuDQo+PiArIw0KPj4gKyMgQHBkaCB0aGUgdGFyZ2V0IGhvc3QgcGxhdGZvcm0gZGlmZmll
LWhlbGxtYW4ga2V5IGVuY29kZWQgaW4gYmFzZTY0DQo+PiArIw0KPj4gKyMgQHBsYXQtY2VydCB0
aGUgdGFyZ2V0IGhvc3QgcGxhdGZvcm0gY2VydGlmaWNhdGUgY2hhaW4gZW5jb2RlZCBpbiBiYXNl
NjQNCj4+ICsjDQo+PiArIyBAYW1kLWNlcnQgQU1EIGNlcnRpZmljYXRlIGNoYWluIHdoaWNoIGlu
Y2x1ZGUgQVNLIGFuZCBPQ0EgZW5jb2RlZCBpbiBiYXNlNjQNCj4+ICsjDQo+PiArIyBTaW5jZSA0
LjMNCj4gDQo+IFRoZSBuZXh0IHJlbGVhc2UgaXMgNC4xLCB0aGVuIGxpa2VseSA0LjIgbmVhciB0
aGUgZW5kIG9mIHRoZSBjYWxlbmRhcg0KPiB5ZWFyLCB0aGVuIDUuMCBpbiAyMDIwLiBUaGVyZSBp
cyBubyBwbGFubmVkIDQuMyByZWxlYXNlLiAgQXJlIHlvdSB0cnlpbmcNCj4gdG8gZ2V0IHRoaXMg
aW4gNC4xPw0KDQoNCkFoLCBJIHdhcyBtZWFuaW5nIHRvIHR5cGUgNC4yIGFuZCBub3QgNC4zLiBU
aGUgc2VyaWVzIGhhcyBkZXBlbmRlbmN5IG9uDQprZXJuZWwgcGF0Y2hlcywgbXkgYmVzdCBlZmZv
cnQgaXQgdG8gZ2V0IGl0IHJlYWR5IGZvciA0LjIgbWVyZ2UNCndpbmRvdy4NCg==

