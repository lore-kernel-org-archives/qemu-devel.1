Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC61C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27685206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kfn6s7A3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27685206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47941 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK1sL-0007gD-3z
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 10:30:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hK1r6-0006jv-VU
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hK1r5-0001q8-Ah
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:29:36 -0400
Received: from mail-eopbgr740050.outbound.protection.outlook.com
	([40.107.74.50]:8783
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hK1r4-0001my-Tf
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=f88uWAoHTJkrjKNmdhxPYd/rgg0mPjIeWxMtKzjLInU=;
	b=kfn6s7A3Jw8JV7kjtOblklN1tM/RacVgV7sah+FEBLv4f6QU8R8eZPztxZDrh6+ALO68Xn9DBySkvdxqLfcpSdPaoPtviHuY6VYbO4hD1MRueckykim99SWyF2vcHljEvWsaV5RWuwkaof8fVtQKlnhNBc5JhVbOUhUZ8CKNEJo=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2796.namprd12.prod.outlook.com (20.176.118.97) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Fri, 26 Apr 2019 14:29:31 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Fri, 26 Apr 2019 14:29:31 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: Borislav Petkov <bp@alien8.de>
Thread-Topic: [RFC PATCH v1 01/10] KVM: SVM: Add KVM_SEV SEND_START command
Thread-Index: AQHU+rgqsjyUQYD5ekOPbYup8IOCm6ZOfjkAgAAFPwA=
Date: Fri, 26 Apr 2019 14:29:31 +0000
Message-ID: <e6f8da38-b8dd-a9c5-a358-5f33b6ea7b37@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-2-brijesh.singh@amd.com>
	<20190426141042.GF4608@zn.tnic>
In-Reply-To: <20190426141042.GF4608@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0043.namprd12.prod.outlook.com
	(2603:10b6:802:20::14) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3de64b89-393b-46c0-8d96-08d6ca539881
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2796; 
x-ms-traffictypediagnostic: DM6PR12MB2796:
x-microsoft-antispam-prvs: <DM6PR12MB2796043091B5A4C185FA213AE53E0@DM6PR12MB2796.namprd12.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(979002)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(31686004)(486006)(71190400001)(71200400001)(7736002)(8936002)(478600001)(81156014)(81166006)(3846002)(52116002)(76176011)(99286004)(66066001)(6436002)(2616005)(86362001)(476003)(8676002)(7416002)(31696002)(68736007)(14454004)(6246003)(446003)(5660300002)(66574012)(11346002)(102836004)(66446008)(97736004)(66476007)(64756008)(256004)(25786009)(316002)(53936002)(6486002)(54906003)(2906002)(73956011)(386003)(6506007)(6116002)(36756003)(6916009)(53546011)(229853002)(4326008)(186003)(66946007)(6512007)(26005)(66556008)(305945005)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2796;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VG/kt7nSXbEUawN8OM/X9tyg6MyaX1oFlnnpf/M2pX9H+3M1kbR9PfmFZm3Mulqza78Wp5HsgTVfquc7VHoi7s8EGMa1B1AaP88jT4LPRfaIJMamoqEtFfrgIkb7LbyLruM2phPa2CXttae8ORSdSf0fu54lwv3KzjUFtO6cYgNtr+0KM1jfogJNj+VclcLMOGUJnKkWoynsgUuRNuEztq8n/Vj82zFHDUkjyMjXZ2xkFHqIhXqne0SCCxzjnVqGfahA/YM1iNVpJGhfpSWHCCEL3udGWQeboUYXBfd06y87Nm4Ih6OzNkKTgFzu9fWa1mDeysBZUXihTIWw4Yxcu1WxKKQoSogaLVnpom895GAzniCCxhiIKQHZLN0jVhQt4pS2Elb8LgnoqZZSfv2Di4fmMyFaJjuxi9gPFQXT/x8=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <BF03126AFAC825448748D3CC146E7950@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de64b89-393b-46c0-8d96-08d6ca539881
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 14:29:31.2229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.50
Subject: Re: [Qemu-devel] [RFC PATCH v1 01/10] KVM: SVM: Add KVM_SEV
 SEND_START command
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	=?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "H.
	Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426142931.EN8Nmk1TFewAJwVwQrJthNUizoCY6huVccrCweN-87M@z>

DQoNCk9uIDQvMjYvMTkgOToxMCBBTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBXZWQs
IEFwciAyNCwgMjAxOSBhdCAwNDowOTo1OVBNICswMDAwLCBTaW5naCwgQnJpamVzaCB3cm90ZToN
Cj4+IFRoZSBjb21tYW5kIGlzIHVzZWQgdG8gY3JlYXRlIGFuIG91dGdvaW5nIFNFViBndWVzdCBl
bmNyeXB0aW9uIGNvbnRleHQuDQo+Pg0KPj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51
dHJvbml4LmRlPg0KPj4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0KPj4gQ2M6
ICJILiBQZXRlciBBbnZpbiIgPGhwYUB6eXRvci5jb20+DQo+PiBDYzogUGFvbG8gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4+IENjOiAiUmFkaW0gS3LEjW3DocWZIiA8cmtyY21hckBy
ZWRoYXQuY29tPg0KPj4gQ2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPg0KPj4gQ2M6
IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4NCj4+IENjOiBUb20gTGVuZGFja3kgPHRob21h
cy5sZW5kYWNreUBhbWQuY29tPg0KPj4gQ2M6IHg4NkBrZXJuZWwub3JnDQo+PiBDYzoga3ZtQHZn
ZXIua2VybmVsLm9yZw0KPj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+IFNp
Z25lZC1vZmYtYnk6IEJyaWplc2ggU2luZ2ggPGJyaWplc2guc2luZ2hAYW1kLmNvbT4NCj4+IC0t
LQ0KPj4gICAuLi4vdmlydHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJzdCAgICAgfCAg
MjQgKysrKysNCj4+ICAgYXJjaC94ODYva3ZtL3N2bS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgMTAxICsrKysrKysrKysrKysrKysrKw0KPj4gICBpbmNsdWRlL3VhcGkvbGludXgva3Zt
LmggICAgICAgICAgICAgICAgICAgICAgfCAgMTIgKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwg
MTM3IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0
dWFsL2t2bS9hbWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0IGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFs
L2t2bS9hbWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0DQo+PiBpbmRleCA2NTliYmMwOTNiNTIuLjM0
MGFjNGY4NzMyMSAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYW1k
LW1lbW9yeS1lbmNyeXB0aW9uLnJzdA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2
bS9hbWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0DQo+PiBAQCAtMjM4LDYgKzIzOCwzMCBAQCBSZXR1
cm5zOiAwIG9uIHN1Y2Nlc3MsIC1uZWdhdGl2ZSBvbiBlcnJvcg0KPj4gICAgICAgICAgICAgICAg
ICAgX191MzIgdHJhbnNfbGVuOw0KPj4gICAgICAgICAgIH07DQo+PiAgIA0KPj4gKzEwLiBLVk1f
U0VWX1NFTkRfU1RBUlQNCj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiArDQo+PiArVGhl
IEtWTV9TRVZfU0VORF9TVEFSVCBjb21tYW5kIGNhbiBiZSB1c2VkIGJ5IHRoZSBoeXBlcnZpc29y
IHRvIGNyZWF0ZSBhbg0KPj4gK291dGdvaW5nIGd1ZXN0IGVuY3J5cHRpb24gY29udGV4dC4NCj4+
ICsNCj4+ICtQYXJhbWV0ZXJzIChpbik6IHN0cnVjdCBrdm1fc2V2X3NlbmRfc3RhcnQNCj4+ICsN
Cj4+ICtSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIC1uZWdhdGl2ZSBvbiBlcnJvcg0KPj4gKw0KPj4g
Kzo6DQo+PiArICAgICAgICBzdHJ1Y3Qga3ZtX3Nldl9zZW5kX3N0YXJ0IHsNCj4+ICsgICAgICAg
ICAgICAgICAgX191MzIgcG9saWN5OyAgICAgICAgICAgICAgICAgLyogZ3Vlc3QgcG9saWN5ICov
DQo+PiArDQo+PiArICAgICAgICAgICAgICAgIF9fdTY0IHBkaF9jZXJ0X3VhZGRyOyAgICAgICAg
IC8qIHBsYXRmb3JtIERpZmZpZS1IZWxsbWFuIGNlcnRpZmljYXRlICovDQo+PiArICAgICAgICAg
ICAgICAgIF9fdTMyIHBkaF9jZXJ0X2xlbjsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICAgX191
NjQgcGxhdF9jZXJ0X3VhZGRyOyAgICAgICAgLyogcGxhdGZvcm0gY2VydGlmaWNhdGUgY2hhaW4g
Ki8NCj4+ICsgICAgICAgICAgICAgICAgX191MzIgcGxhdF9jZXJ0X2xlbjsNCj4+ICsNCj4+ICsg
ICAgICAgICAgICAgICAgX191NjQgYW1kX2NlcnRfdWFkZHI7ICAgICAgICAgLyogQU1EIGNlcnRp
ZmljYXRlICovDQo+PiArICAgICAgICAgICAgICAgIF9fdTMyIGFtZF9jZXJ0X2xlbjsNCj4gDQo+
ICAgICAgICAgIF9fdTY0IHNlc3Npb25fdWFkZHI7DQo+ICAgICAgICAgIF9fdTMyIHNlc3Npb25f
bGVuOw0KPiANCj4gdG9vLCByaWdodD8NCg0KDQpBaCBnb29kIGNhdGNoLCBJIHdpbGwgZml4IGlu
IG5leHQgcmV2LiB0aGFua3MNCg0KDQo+IA0KPj4gKyAgICAgICAgfTsNCj4+ICsNCj4+ICAgUmVm
ZXJlbmNlcw0KPj4gICA9PT09PT09PT09DQo+PiAgIA0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2t2bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KPj4gaW5kZXggNDA2YjU1OGFiZmVmLi40
YzJhMjI1YmE1NDYgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCj4+ICsrKyBi
L2FyY2gveDg2L2t2bS9zdm0uYw0KPj4gQEAgLTY5NTUsNiArNjk1NSwxMDQgQEAgc3RhdGljIGlu
dCBzZXZfbGF1bmNoX3NlY3JldChzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1fc2V2X2NtZCAq
YXJncCkNCj4+ICAgCXJldHVybiByZXQ7DQo+PiAgIH0NCj4+ICAgDQo+PiArc3RhdGljIGludCBz
ZXZfc2VuZF9zdGFydChzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1fc2V2X2NtZCAqYXJncCkN
Cj4+ICt7DQo+PiArCXN0cnVjdCBrdm1fc2V2X2luZm8gKnNldiA9ICZ0b19rdm1fc3ZtKGt2bSkt
PnNldl9pbmZvOw0KPj4gKwl2b2lkICphbWRfY2VydCA9IE5VTEwsICpzZXNzaW9uX2RhdGEgPSBO
VUxMOw0KPj4gKwl2b2lkICpwZGhfY2VydCA9IE5VTEwsICpwbGF0X2NlcnQgPSBOVUxMOw0KPj4g
KwlzdHJ1Y3Qgc2V2X2RhdGFfc2VuZF9zdGFydCAqZGF0YSA9IE5VTEw7DQo+PiArCXN0cnVjdCBr
dm1fc2V2X3NlbmRfc3RhcnQgcGFyYW1zOw0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlpZiAo
IXNldl9ndWVzdChrdm0pKQ0KPj4gKwkJcmV0dXJuIC1FTk9UVFk7DQo+PiArDQo+PiArCWlmIChj
b3B5X2Zyb21fdXNlcigmcGFyYW1zLCAodm9pZCBfX3VzZXIgKikodWludHB0cl90KWFyZ3AtPmRh
dGEsDQo+PiArCQkJCXNpemVvZihzdHJ1Y3Qga3ZtX3Nldl9zZW5kX3N0YXJ0KSkpDQo+PiArCQly
ZXR1cm4gLUVGQVVMVDsNCj4+ICsNCj4+ICsJZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKCpkYXRhKSwg
R0ZQX0tFUk5FTCk7DQo+PiArCWlmICghZGF0YSkNCj4+ICsJCXJldHVybiAtRU5PTUVNOw0KPj4g
Kw0KPj4gKwkvKiB1c2Vyc3BhY2Ugd2FudHMgdG8gcXVlcnkgdGhlIHNlc3Npb24gbGVuZ3RoICov
DQo+PiArCWlmICghcGFyYW1zLnNlc3Npb25fbGVuKQ0KPj4gKwkJZ290byBjbWQ7DQo+PiArDQo+
PiArCWlmICghcGFyYW1zLnBkaF9jZXJ0X3VhZGRyIHx8ICFwYXJhbXMucGRoX2NlcnRfbGVuIHx8
DQo+PiArCSAgICAhcGFyYW1zLnNlc3Npb25fdWFkZHIpDQo+PiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4+ICsNCj4+ICsJLyogY29weSB0aGUgY2VydGlmaWNhdGUgYmxvYnMgZnJvbSB1c2Vyc3BhY2Ug
Ki8NCj4+ICsJcGRoX2NlcnQgPSBwc3BfY29weV91c2VyX2Jsb2IocGFyYW1zLnBkaF9jZXJ0X3Vh
ZGRyLCBwYXJhbXMucGRoX2NlcnRfbGVuKTsNCj4+ICsJaWYgKElTX0VSUihwZGhfY2VydCkpIHsN
Cj4+ICsJCXJldCA9IFBUUl9FUlIocGRoX2NlcnQpOw0KPj4gKwkJZ290byBlX2ZyZWU7DQo+PiAr
CX0NCj4+ICsNCj4+ICsJZGF0YS0+cGRoX2NlcnRfYWRkcmVzcyA9IF9fcHNwX3BhKHBkaF9jZXJ0
KTsNCj4+ICsJZGF0YS0+cGRoX2NlcnRfbGVuID0gcGFyYW1zLnBkaF9jZXJ0X2xlbjsNCj4+ICsN
Cj4+ICsJcGxhdF9jZXJ0ID0gcHNwX2NvcHlfdXNlcl9ibG9iKHBhcmFtcy5wbGF0X2NlcnRfdWFk
ZHIsIHBhcmFtcy5wbGF0X2NlcnRfbGVuKTsNCj4+ICsJaWYgKElTX0VSUihwbGF0X2NlcnQpKSB7
DQo+PiArCQlyZXQgPSBQVFJfRVJSKHBsYXRfY2VydCk7DQo+PiArCQlnb3RvIGVfZnJlZV9wZGg7
DQo+PiArCX0NCj4+ICsNCj4+ICsJZGF0YS0+cGxhdF9jZXJ0X2FkZHJlc3MgPSBfX3BzcF9wYShw
bGF0X2NlcnQpOw0KPj4gKwlkYXRhLT5wbGF0X2NlcnRfbGVuID0gcGFyYW1zLnBsYXRfY2VydF9s
ZW47DQo+PiArDQo+PiArCWFtZF9jZXJ0ID0gcHNwX2NvcHlfdXNlcl9ibG9iKHBhcmFtcy5hbWRf
Y2VydF91YWRkciwgcGFyYW1zLmFtZF9jZXJ0X2xlbik7DQo+PiArCWlmIChJU19FUlIoYW1kX2Nl
cnQpKSB7DQo+PiArCQlyZXQgPSBQVFJfRVJSKGFtZF9jZXJ0KTsNCj4+ICsJCWdvdG8gZV9mcmVl
X3BsYXRfY2VydDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlkYXRhLT5hbWRfY2VydF9hZGRyZXNzID0g
X19wc3BfcGEoYW1kX2NlcnQpOw0KPj4gKwlkYXRhLT5hbWRfY2VydF9sZW4gPSBwYXJhbXMuYW1k
X2NlcnRfbGVuOw0KPj4gKw0KPj4gKwlyZXQgPSAtRU5PTUVNOw0KPj4gKwlzZXNzaW9uX2RhdGEg
PSBrbWFsbG9jKHBhcmFtcy5zZXNzaW9uX2xlbiwgR0ZQX0tFUk5FTCk7DQo+IA0KPiBJZiB0aGUg
dXNlciBpcyBzdXBwb3NlZCB0byBxdWVyeSB0aGUgc2Vzc2lvbiBsZW5ndGggZmlyc3QsIHlvdSBj
b3VsZA0KPiBzYXZlIGl0IGluIGEgZ2xvYmFsIHZhcmlhYmxlIHBlcmhhcHMgYW5kIHVzZSB0aGF0
IHZhbHVlIGluc3RlYWQgb2YNCj4gdHJ1c3RpbmcgdGhlIHVzZXIgdG8gZ2l2ZSB5b3UgdGhlIGNv
cnJlY3Qgb25lIGluIHBhcmFtcy5zZXNzaW9uX2xlbiBmb3INCj4gdGhlIGFsbG9jYXRpb24uLi4N
Cj4gDQoNClllcyB0aGF0J3MgZG9hYmxlIGJ1dCBJIGFtIGFmcmFpZCB0aGF0IGNhY2hpbmcgdGhl
IHZhbHVlIG1heSBsZWFkIHVzIHRvDQp3cm9uZyBwYXRoIGFuZCBhbHNvIGRpdmVyZ2VuY2UgZnJv
bSB0aGUgU0VWIEFQSSBzcGVjLiBUaGUgc3BlYyBzYXlzIHRoZQ0KcmV0dXJuZWQgbGVuZ3RoIGlz
IGEgbWluaW11bSBsZW5ndGggYnV0IGl0cyBwb3NzaWJsZSB0aGF0IGNhbGxlciBjYW4NCmdpdmUg
YSBiaWdnZXIgYnVmZmVyIGFuZCBGVyB3aWxsIHN0aWxsIHdvcmsgd2l0aCBpdC4NCg0KDQo+PiAr
CWlmICghc2Vzc2lvbl9kYXRhKQ0KPj4gKwkJZ290byBlX2ZyZWVfYW1kX2NlcnQ7DQo+PiArDQo+
PiArCWRhdGEtPnNlc3Npb25fYWRkcmVzcyA9IF9fcHNwX3BhKHNlc3Npb25fZGF0YSk7DQo+PiAr
CWRhdGEtPnNlc3Npb25fbGVuID0gcGFyYW1zLnNlc3Npb25fbGVuOw0KPj4gK2NtZDoNCj4+ICsJ
ZGF0YS0+aGFuZGxlID0gc2V2LT5oYW5kbGU7DQo+PiArCXJldCA9IHNldl9pc3N1ZV9jbWQoa3Zt
LCBTRVZfQ01EX1NFTkRfU1RBUlQsIGRhdGEsICZhcmdwLT5lcnJvcik7DQo+PiArDQo+PiArCS8q
IGlmIHdlIHF1ZXJpZWQgdGhlIHNlc3Npb24gbGVuZ3RoLCBGVyByZXNwb25kZWQgd2l0aCBleHBl
Y3RlZCBkYXRhICovDQo+IA0KPiA8LS0tIC4uLiBoZXJlIHlvdSBoYXZlIHRoZSBzZXNzaW9uIGxl
bmd0aCBmcm9tIHRoZSBmdy4NCj4gDQo=

