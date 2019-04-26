Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C14C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 21:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C161A2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 21:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fHiFiUG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C161A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52052 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK88v-0001sv-1c
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 17:12:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1hK87e-0001GW-3g
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1hK87c-0003sI-N5
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:11:06 -0400
Received: from mail-eopbgr700075.outbound.protection.outlook.com
	([40.107.70.75]:62167
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Thomas.Lendacky@amd.com>)
	id 1hK87c-0003qW-Fg
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=v3pUFI77tkoNy2HKuRbfnwH+Kxnq3t9AGRyIIyd7av0=;
	b=fHiFiUG4F0GOpaJRBSoikFz5ODdzx1L3o4dN2OuO0faKzhL2qJ8enVH+HR18p9kGio6f35NPVuAsNHGoZ9oUFkrLp88AJzQbzwzrXK4AR3P7cC2P6+XmQt2FfOARwV+IfkDRzjp1sf7CXCa+kWKV5u764M+ks7fwhUCd/BrXLaU=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3338.namprd12.prod.outlook.com (20.178.31.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Fri, 26 Apr 2019 21:11:01 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::c96d:c1dd:fd7a:ffd6]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::c96d:c1dd:fd7a:ffd6%4]) with mapi id 15.20.1835.010;
	Fri, 26 Apr 2019 21:11:01 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 05/10] KVM: SVM: Add KVM_SEV_RECEIVE_UPDATE_DATA
	command
Thread-Index: AQHU+rgxgHGwhAv2SkiSr2QS6WQbcqZO86aA
Date: Fri, 26 Apr 2019 21:11:01 +0000
Message-ID: <ebbf27ef-9ccc-2777-1fd2-dba3da4b822c@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-6-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-6-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0030.namprd02.prod.outlook.com
	(2603:10b6:803:2e::16) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b140b62-ec9d-4d96-85f1-08d6ca8baf77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3338; 
x-ms-traffictypediagnostic: DM6PR12MB3338:
x-microsoft-antispam-prvs: <DM6PR12MB333858805E2C55CCE616D91FEC3E0@DM6PR12MB3338.namprd12.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(979002)(39850400004)(346002)(396003)(376002)(366004)(136003)(189003)(199004)(486006)(6512007)(386003)(26005)(6246003)(53546011)(316002)(476003)(2501003)(110136005)(6506007)(53936002)(71190400001)(73956011)(6116002)(76176011)(3846002)(66556008)(66446008)(66946007)(31686004)(66476007)(25786009)(54906003)(81156014)(97736004)(102836004)(8676002)(81166006)(64756008)(186003)(8936002)(52116002)(478600001)(2616005)(72206003)(11346002)(71200400001)(2906002)(256004)(68736007)(66066001)(6486002)(14444005)(99286004)(5660300002)(14454004)(66574012)(31696002)(4326008)(86362001)(446003)(229853002)(7416002)(36756003)(305945005)(7736002)(6436002)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3338;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xeX4rf2Y+aSZgQ4GeZvOJKqbrkoceNr4FVoxLErcez+XWw4I0ta0ZMBQLkezHNTZyv8IrwZh6pqSbn8imnlK8obpstDcA7IfDY0fcsZtp7AzbBpNS6asZlghtqcvm7XoBnOkhA40efQePElUSFMUwnvFVnCiCjF/2T8uALfKYOLKjozbrfP5LjNEWEl0XTj6dmJQpvorMdwcInZpHP/1/2zAbM4vgREkYH+ILwIFjtn2SrHOP2LYfArCY/wXC9SooATX83XUhQMYU7OjKeQMzTI12LLl9lKbBgYc810xwFE3B/FKvbjU99aYmH/bSPdbi9VoP1o8+GtIZeABrg93BSJmI+69KSFitcaYw3bR7rz7/nR8JPpQlQCQYH3+JaD/8b3xO+M3sZtwoD6ya8QOppJL7b+tw2hrCaVG9x/83gA=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <2D552EA847A8B742A7B574F63C616975@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b140b62-ec9d-4d96-85f1-08d6ca8baf77
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 21:11:01.5186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3338
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.75
Subject: Re: [Qemu-devel] [RFC PATCH v1 05/10] KVM: SVM: Add
 KVM_SEV_RECEIVE_UPDATE_DATA command
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
Cc: =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426211101.03kBuoiMgRJa9xOAXLUOni_J7AgnElr6iNrfiaIrlSE@z>

T24gNC8yNC8xOSAxMToxMCBBTSwgU2luZ2gsIEJyaWplc2ggd3JvdGU6DQo+IFRoZSBjb21tYW5k
IGlzIHVzZWQgZm9yIGNvcHlpbmcgdGhlIGluY29taW5nIGJ1ZmZlciBpbnRvIHRoZQ0KPiBTRVYg
Z3Vlc3QgbWVtb3J5IHNwYWNlLg0KPiANCj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51
dHJvbml4LmRlPg0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQo+IENjOiAi
SC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiBDYzogUGFvbG8gQm9uemluaSA8cGJv
bnppbmlAcmVkaGF0LmNvbT4NCj4gQ2M6ICJSYWRpbSBLcsSNbcOhxZkiIDxya3JjbWFyQHJlZGhh
dC5jb20+DQo+IENjOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4NCj4gQ2M6IEJvcmlz
bGF2IFBldGtvdiA8YnBAc3VzZS5kZT4NCj4gQ2M6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRh
Y2t5QGFtZC5jb20+DQo+IENjOiB4ODZAa2VybmVsLm9yZw0KPiBDYzoga3ZtQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQo+IC0tLQ0KPiAgLi4uL3Zp
cnR1YWwva3ZtL2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QgICAgIHwgMjQgKysrKysrDQo+ICBh
cmNoL3g4Ni9rdm0vc3ZtLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA4NCArKysrKysr
KysrKysrKysrKysrDQo+ICBpbmNsdWRlL3VhcGkvbGludXgva3ZtLmggICAgICAgICAgICAgICAg
ICAgICAgfCAgOSArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMTcgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNy
eXB0aW9uLnJzdCBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0
aW9uLnJzdA0KPiBpbmRleCBhY2RmZjI0NTQ2NDkuLmI5YzNkYzAyZjM0NCAxMDA2NDQNCj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hbWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0DQo+
ICsrKyBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJz
dA0KPiBAQCAtMzIyLDYgKzMyMiwzMCBAQCBPbiBzdWNjZXNzLCB0aGUgJ2hhbmRsZScgZmllbGQg
Y29udGFpbnMgYSBuZXcgaGFuZGxlIGFuZCBvbiBlcnJvciwgYSBuZWdhdGl2ZSB2YQ0KPiAgDQo+
ICBGb3IgbW9yZSBkZXRhaWxzLCBzZWUgU0VWIHNwZWMgU2VjdGlvbiA2LjEyLg0KPiAgDQo+ICsx
NC4gS1ZNX1NFVl9SRUNFSVZFX1VQREFURV9EQVRBDQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICsNCj4gK1RoZSBLVk1fU0VWX1JFQ0VJVkVfVVBEQVRFX0RBVEEgY29tbWFuZCBj
YW4gYmUgdXNlZCBieSB0aGUgaHlwZXJ2aXNvciB0byBjb3B5DQo+ICt0aGUgaW5jb21pbmcgYnVm
ZmVycyBpbnRvIHRoZSBndWVzdCBtZW1vcnkgcmVnaW9uIHdpdGggZW5jcnlwdGlvbiBjb250ZXh0
DQo+ICtjcmVhdGVkIGR1cmluZyB0aGUgS1ZNX1NFVl9SRUNFSVZFX1NUQVJULg0KPiArDQo+ICtQ
YXJhbWV0ZXJzIChpbik6IHN0cnVjdCBrdm1fc2V2X3JlY2VpdmVfdXBkYXRlX2RhdGENCj4gKw0K
PiArUmV0dXJuczogMCBvbiBzdWNjZXNzLCAtbmVnYXRpdmUgb24gZXJyb3INCj4gKw0KPiArOjoN
Cj4gKw0KPiArICAgICAgICBzdHJ1Y3Qga3ZtX3Nldl9sYXVuY2hfcmVjZWl2ZV91cGRhdGVfZGF0
YSB7DQo+ICsgICAgICAgICAgICAgICAgX191NjQgaGRyX3VhZGRyOyAgICAgICAgLyogdXNlcnNw
YWNlIGFkZHJlc3MgY29udGFpbmluZyB0aGUgcGFja2V0IGhlYWRlciAqLw0KPiArICAgICAgICAg
ICAgICAgIF9fdTMyIGhkcl9sZW47DQo+ICsNCj4gKyAgICAgICAgICAgICAgICBfX3U2NCBndWVz
dF91YWRkcjsgICAgICAvKiB0aGUgZGVzdGluYXRpb24gZ3Vlc3QgbWVtb3J5IHJlZ2lvbiAqLw0K
PiArICAgICAgICAgICAgICAgIF9fdTMyIGd1ZXN0X2xlbjsNCj4gKw0KPiArICAgICAgICAgICAg
ICAgIF9fdTY0IHRyYW5zX3VhZGRyOyAgICAgIC8qIHRoZSBpbmNvbWluZyBidWZmZXIgbWVtb3J5
IHJlZ2lvbiAgKi8NCj4gKyAgICAgICAgICAgICAgICBfX3UzMiB0cmFuc19sZW47DQo+ICsgICAg
ICAgIH07DQo+ICsNCj4gIFJlZmVyZW5jZXMNCj4gID09PT09PT09PT0NCj4gIA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2bS5jDQo+IGluZGV4IGE3
ZGNmMTliYWVmYi4uYzgxY2FjMDljNWFmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0vc3Zt
LmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL3N2bS5jDQo+IEBAIC03MjY5LDYgKzcyNjksODcgQEAg
c3RhdGljIGludCBzZXZfcmVjZWl2ZV9zdGFydChzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1f
c2V2X2NtZCAqYXJncCkNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW50
IHNldl9yZWNlaXZlX3VwZGF0ZV9kYXRhKHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0IGt2bV9zZXZf
Y21kICphcmdwKQ0KPiArew0KPiArCXN0cnVjdCBrdm1fc2V2X2luZm8gKnNldiA9ICZ0b19rdm1f
c3ZtKGt2bSktPnNldl9pbmZvOw0KPiArCXN0cnVjdCBrdm1fc2V2X3JlY2VpdmVfdXBkYXRlX2Rh
dGEgcGFyYW1zOw0KPiArCXN0cnVjdCBzZXZfZGF0YV9yZWNlaXZlX3VwZGF0ZV9kYXRhICpkYXRh
Ow0KPiArCXZvaWQgKmhkciA9IE5VTEwsICp0cmFucyA9IE5VTEw7DQo+ICsJc3RydWN0IHBhZ2Ug
KipndWVzdF9wYWdlOw0KPiArCXVuc2lnbmVkIGxvbmcgbjsNCj4gKwlpbnQgcmV0LCBvZmZzZXQ7
DQo+ICsNCj4gKwlpZiAoIXNldl9ndWVzdChrdm0pKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4g
Kw0KPiArCWlmIChjb3B5X2Zyb21fdXNlcigmcGFyYW1zLCAodm9pZCBfX3VzZXIgKikodWludHB0
cl90KWFyZ3AtPmRhdGEsDQo+ICsJCQlzaXplb2Yoc3RydWN0IGt2bV9zZXZfcmVjZWl2ZV91cGRh
dGVfZGF0YSkpKQ0KPiArCQlyZXR1cm4gLUVGQVVMVDsNCj4gKw0KPiArCWlmICghcGFyYW1zLmhk
cl91YWRkciB8fCAhcGFyYW1zLmhkcl9sZW4gfHwNCj4gKwkgICAgIXBhcmFtcy5ndWVzdF91YWRk
ciB8fCAhcGFyYW1zLmd1ZXN0X2xlbiB8fA0KPiArCSAgICAhcGFyYW1zLnRyYW5zX3VhZGRyIHx8
ICFwYXJhbXMudHJhbnNfbGVuKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCS8qIENo
ZWNrIGlmIHdlIGFyZSBjcm9zc2luZyB0aGUgcGFnZSBib3VuZHJ5ICovDQo+ICsJb2Zmc2V0ID0g
cGFyYW1zLmd1ZXN0X3VhZGRyICYgKFBBR0VfU0laRSAtIDEpOw0KPiArCWlmICgocGFyYW1zLmd1
ZXN0X2xlbiArIG9mZnNldCA+IFBBR0VfU0laRSkpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiAr
DQo+ICsJZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKCpkYXRhKSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYg
KCFkYXRhKQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCWhkciA9IHBzcF9jb3B5X3Vz
ZXJfYmxvYihwYXJhbXMuaGRyX3VhZGRyLCBwYXJhbXMuaGRyX2xlbik7DQo+ICsJaWYgKElTX0VS
UihoZHIpKSB7DQo+ICsJCXJldCA9IFBUUl9FUlIoaGRyKTsNCj4gKwkJZ290byBlX2ZyZWU7DQo+
ICsJfQ0KPiArDQo+ICsJZGF0YS0+aGRyX2FkZHJlc3MgPSBfX3BzcF9wYShoZHIpOw0KPiArCWRh
dGEtPmhkcl9sZW4gPSBwYXJhbXMuaGRyX2xlbjsNCj4gKw0KPiArCXRyYW5zID0gcHNwX2NvcHlf
dXNlcl9ibG9iKHBhcmFtcy50cmFuc191YWRkciwgcGFyYW1zLnRyYW5zX2xlbik7DQo+ICsJaWYg
KElTX0VSUih0cmFucykpIHsNCj4gKwkJcmV0ID0gUFRSX0VSUih0cmFucyk7DQo+ICsJCWdvdG8g
ZV9mcmVlOw0KPiArCX0NCj4gKw0KPiArCWRhdGEtPnRyYW5zX2FkZHJlc3MgPSBfX3BzcF9wYSh0
cmFucyk7DQo+ICsJZGF0YS0+dHJhbnNfbGVuID0gcGFyYW1zLnRyYW5zX2xlbjsNCj4gKw0KPiAr
CS8qIFBpbiBndWVzdCBtZW1vcnkgKi8NCj4gKwlyZXQgPSAtRUZBVUxUOw0KPiArCWd1ZXN0X3Bh
Z2UgPSBzZXZfcGluX21lbW9yeShrdm0sIHBhcmFtcy5ndWVzdF91YWRkciAmIFBBR0VfTUFTSywN
Cj4gKwkJCQkgICAgUEFHRV9TSVpFLCAmbiwgMCk7DQo+ICsJaWYgKCFndWVzdF9wYWdlKQ0KPiAr
CQlnb3RvIGVfZnJlZTsNCj4gKw0KPiArCWRhdGEtPmd1ZXN0X2FkZHJlc3MgPSBfX3NtZV9wYWdl
X3BhKGd1ZXN0X3BhZ2VbMF0pICsgb2Zmc2V0Ow0KDQpTYW1lIGNvbW1lbnQgaGVyZSBhcyBpbiBw
YXRjaCAwMi4gTm8gbmVlZCB0byB1c2UgdGhlIF9fc21lIHZlcnNpb24gaWYNCnlvdSdyZSBnb2lu
ZyB0byB1bmNvbmRpdGlvbmFsbHkgc2V0IGl0IGJlbG93Lg0KDQpUaGFua3MsDQpUb20NCg0KPiAr
CWRhdGEtPmd1ZXN0X2xlbiA9IHBhcmFtcy5ndWVzdF9sZW47DQo+ICsNCj4gKwkvKg0KPiArCSAq
IFRoZSBSRUNFSVZFX1VQREFURV9EQVRBIGNvbW1hbmQgcmVxdWlyZXMgQy1iaXQgdG8gYmUgYWx3
YXlzIHNldC4NCj4gKwkgKiBUaGUgX19zbWVfcGFnZV9wYSgpIHRha2VzIGNhcmUgb2Ygc2V0dGlu
ZyB0aGUgQy1iaXQgb25seSB3aGVuIFNNRQ0KPiArCSAqIGlzIGVuYWJsZWQgb24gdGhlIGhvc3Qu
IEJ1dCB3ZSBuZWVkIHRvIHNldCB0aGUgQy1iaXQgcmVnYXJsZXNzIG9mDQo+ICsJICogdGhlIFNN
RSBzdGF0ZS4NCj4gKwkgKi8NCj4gKwlkYXRhLT5ndWVzdF9hZGRyZXNzIHw9IG1lX21hc2s7DQo+
ICsNCj4gKwkvKiBmbHVzaCB0aGUgY2FjaGVzIHRvIGVuc3VyZSB0aGF0IERSQU0gaGFzIHJlY2Vu
dCBjb250ZW50cyAqLw0KPiArCXNldl9jbGZsdXNoX3BhZ2VzKGd1ZXN0X3BhZ2UsIG4pOw0KPiAr
DQo+ICsJZGF0YS0+aGFuZGxlID0gc2V2LT5oYW5kbGU7DQo+ICsJcmV0ID0gc2V2X2lzc3VlX2Nt
ZChrdm0sIFNFVl9DTURfUkVDRUlWRV9VUERBVEVfREFUQSwgZGF0YSwgJmFyZ3AtPmVycm9yKTsN
Cj4gKw0KPiArCXNldl91bnBpbl9tZW1vcnkoa3ZtLCBndWVzdF9wYWdlLCBuKTsNCj4gK2VfZnJl
ZToNCj4gKwlrZnJlZShkYXRhKTsNCj4gKwlrZnJlZShoZHIpOw0KPiArCWtmcmVlKHRyYW5zKTsN
Cj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IHN2bV9tZW1fZW5jX29w
KHN0cnVjdCBrdm0gKmt2bSwgdm9pZCBfX3VzZXIgKmFyZ3ApDQo+ICB7DQo+ICAJc3RydWN0IGt2
bV9zZXZfY21kIHNldl9jbWQ7DQo+IEBAIC03MzIyLDYgKzc0MDMsOSBAQCBzdGF0aWMgaW50IHN2
bV9tZW1fZW5jX29wKHN0cnVjdCBrdm0gKmt2bSwgdm9pZCBfX3VzZXIgKmFyZ3ApDQo+ICAJY2Fz
ZSBLVk1fU0VWX1JFQ0VJVkVfU1RBUlQ6DQo+ICAJCXIgPSBzZXZfcmVjZWl2ZV9zdGFydChrdm0s
ICZzZXZfY21kKTsNCj4gIAkJYnJlYWs7DQo+ICsJY2FzZSBLVk1fU0VWX1JFQ0VJVkVfVVBEQVRF
X0RBVEE6DQo+ICsJCXIgPSBzZXZfcmVjZWl2ZV91cGRhdGVfZGF0YShrdm0sICZzZXZfY21kKTsN
Cj4gKwkJYnJlYWs7DQo+ICAJZGVmYXVsdDoNCj4gIAkJciA9IC1FSU5WQUw7DQo+ICAJCWdvdG8g
b3V0Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bS5oIGIvaW5jbHVkZS91
YXBpL2xpbnV4L2t2bS5oDQo+IGluZGV4IGZlZTc1YmYxZmQ5MC4uMDdlMDU4YTNlYzExIDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgNCj4gKysrIGIvaW5jbHVkZS91YXBp
L2xpbnV4L2t2bS5oDQo+IEBAIC0xNTUwLDYgKzE1NTAsMTUgQEAgc3RydWN0IGt2bV9zZXZfcmVj
ZWl2ZV9zdGFydCB7DQo+ICAJX191MzIgc2Vzc2lvbl9sZW47DQo+ICB9Ow0KPiAgDQo+ICtzdHJ1
Y3Qga3ZtX3Nldl9yZWNlaXZlX3VwZGF0ZV9kYXRhIHsNCj4gKwlfX3U2NCBoZHJfdWFkZHI7DQo+
ICsJX191MzIgaGRyX2xlbjsNCj4gKwlfX3U2NCBndWVzdF91YWRkcjsNCj4gKwlfX3UzMiBndWVz
dF9sZW47DQo+ICsJX191NjQgdHJhbnNfdWFkZHI7DQo+ICsJX191MzIgdHJhbnNfbGVuOw0KPiAr
fTsNCj4gKw0KPiAgI2RlZmluZSBLVk1fREVWX0FTU0lHTl9FTkFCTEVfSU9NTVUJKDEgPDwgMCkN
Cj4gICNkZWZpbmUgS1ZNX0RFVl9BU1NJR05fUENJXzJfMwkJKDEgPDwgMSkNCj4gICNkZWZpbmUg
S1ZNX0RFVl9BU1NJR05fTUFTS19JTlRYCSgxIDw8IDIpDQo+IA0K

