Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E3BC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 21:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C52D206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 21:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nhTGBGUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C52D206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK8aT-0003zs-Kf
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 17:40:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1hK8ZM-0003M0-Rg
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1hK8ZK-0000uK-Vb
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:39:44 -0400
Received: from mail-eopbgr710077.outbound.protection.outlook.com
	([40.107.71.77]:35488
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Thomas.Lendacky@amd.com>)
	id 1hK8ZI-0000pj-4t
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jlFSi9f2KoESxviQ8K5xnv/fMfxokrLyKsyFBQ0QQPA=;
	b=nhTGBGUambt8GQUXdFIzkDTlfWaOGIVWEcMiFowDmQicEWtC/7HKjv0lJNmcp/uS6DWmCg1bWIWKZqQ9lnCzRYSJFJwh22oxo5e9xeN+mnE2W/xfWcFa5wfbeuqj41sJhED7EsTGzzYLUC3xeUezVeXHdy/g2kjgY6tb1guTdf4=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3337.namprd12.prod.outlook.com (20.178.31.207) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Fri, 26 Apr 2019 21:39:36 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::c96d:c1dd:fd7a:ffd6]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::c96d:c1dd:fd7a:ffd6%4]) with mapi id 15.20.1835.010;
	Fri, 26 Apr 2019 21:39:36 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 08/10] KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS
	hypercall
Thread-Index: AQHU+rgz0mso5ntZo0mIXYBwLViZgKZO+6MA
Date: Fri, 26 Apr 2019 21:39:36 +0000
Message-ID: <d31531fe-f01c-817b-06e5-f06b5968b266@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-9-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-9-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0055.namprd05.prod.outlook.com
	(2603:10b6:803:41::32) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdcf5f4c-ffde-4dde-48bd-08d6ca8fad9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3337; 
x-ms-traffictypediagnostic: DM6PR12MB3337:
x-microsoft-antispam-prvs: <DM6PR12MB333719D0A527272048E5B33DEC3E0@DM6PR12MB3337.namprd12.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(396003)(39850400004)(376002)(136003)(366004)(189003)(199004)(81156014)(68736007)(110136005)(76176011)(71200400001)(25786009)(71190400001)(66066001)(36756003)(72206003)(6246003)(31696002)(54906003)(6436002)(11346002)(486006)(446003)(99286004)(2616005)(6506007)(386003)(102836004)(14454004)(316002)(8676002)(8936002)(476003)(2501003)(53546011)(478600001)(81166006)(186003)(31686004)(97736004)(7736002)(6486002)(229853002)(86362001)(5660300002)(7416002)(66556008)(6512007)(6116002)(305945005)(26005)(3846002)(2906002)(64756008)(66946007)(66446008)(66574012)(14444005)(73956011)(256004)(66476007)(4326008)(53936002)(52116002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3337;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wE5tlV6hvk2XdBk3sko6b4Nm9A/S39a86o8zDQ5Vf4u4IKmtisd61Poi5M5ElZZ45nKWGgx1xaCRZxLoAxZyxLvzN1ymXytC6nPtrsm3t0ngFS4lJPnibJQFlGJ9wdGZrmCgskxDZLi4S9/x3OtScW8VtVuk5WqHZNSh8UAx6dtlXU+Qtwg6OO2H0Em0SMFAcJXAzsx/DDIvuXTaMrjnhYmn9HQQBG3wqqRLe6dPNvqi4Jt6ZOp1kDquc3j8qG6nhkR3+ia0O9DtdmlFe6u7PLINBqWK8qhYt98X+ME12zrNtIl2uf6iSaU6mH/l0l3xuDvZ536pVznPsFCSTprxgkg0DjNc/XvqEb7Ob+/q5A5EuHEEauu94XKcetGWi3euPomJmLUFkzorZk+YVowK8a+0LH8u1c8pXAdji2BHlcg=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <BD0F63044699C745A07EE41258567021@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcf5f4c-ffde-4dde-48bd-08d6ca8fad9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 21:39:36.4470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3337
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.77
Subject: Re: [Qemu-devel] [RFC PATCH v1 08/10] KVM: X86: Introduce
 KVM_HC_PAGE_ENC_STATUS hypercall
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
Message-ID: <20190426213936.OVkY5UzheB5Q36mUMtlscNXRXLjn5-aCBXtB_r-IKo0@z>

T24gNC8yNC8xOSAxMToxMCBBTSwgU2luZ2gsIEJyaWplc2ggd3JvdGU6DQo+IFRoZSBoeXBlcmNh
bGwgY2FuIGJlIHVzZWQgYnkgdGhlIFNFViBndWVzdCB0byBub3RpZnkgdGhlIHBhZ2UgZW5jcnlw
dGlvbg0KDQpUaGlzIGh5ZXJjYWxsIGlzIHVzZWQgYnkgdGhlIFNFViBndWVzdCB0byBub3RpZnkg
YSBjaGFuZ2UgaW4gdGhlIHBhZ2UuLi4NCg0KPiBzdGF0dXMgdG8gdGhlIGh5cGVydmlzb3IuIFRo
ZSBoeXBlcmNhbGwgc2hvdWxkIGJlIGludm9rZWQgb25seSB3aGVuDQo+IHRoZSBlbmNyeXB0aW9u
IGF0dHJpYnV0ZSBpcyBjaGFuZ2VkIGZyb20gZW5jcnlwdGVkIC0+IGRlY3J5cHRlZCBhbmQgdmlj
ZQ0KPiB2ZXJzYS4gQnkgZGVmYXVsdCBhbGwgdGhlIGd1ZXN0IHBhZ2VzIHNob3VsZCBiZSBjb25z
aWRlcmVkIGVuY3J5cHRlZC4NCg0KQnkgZGVmYXVsdCBhbGwgZ3Vlc3QgcGFnZSBhcmUgY29uc2lk
ZXJlZA0KDQo+IA0KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+
IENjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4NCj4gQ2M6ICJILiBQZXRlciBBbnZp
biIgPGhwYUB6eXRvci5jb20+DQo+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQu
Y29tPg0KPiBDYzogIlJhZGltIEtyxI1tw6HFmSIgPHJrcmNtYXJAcmVkaGF0LmNvbT4NCj4gQ2M6
IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPg0KPiBDYzogQm9yaXNsYXYgUGV0a292IDxi
cEBzdXNlLmRlPg0KPiBDYzogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4N
Cj4gQ2M6IHg4NkBrZXJuZWwub3JnDQo+IENjOiBrdm1Admdlci5rZXJuZWwub3JnDQo+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEJyaWplc2ggU2lu
Z2ggPGJyaWplc2guc2luZ2hAYW1kLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3ZpcnR1
YWwva3ZtL2h5cGVyY2FsbHMudHh0IHwgMTQgKysrKysNCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNt
L2t2bV9ob3N0LmggICAgICAgICAgfCAgMiArDQo+ICBhcmNoL3g4Ni9rdm0vc3ZtLmMgICAgICAg
ICAgICAgICAgICAgICAgIHwgNjkgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL3g4
Ni9rdm0vdm14L3ZteC5jICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KPiAgYXJjaC94ODYva3Zt
L3g4Ni5jICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICsrDQo+ICBpbmNsdWRlL3VhcGkvbGlu
dXgva3ZtX3BhcmEuaCAgICAgICAgICAgIHwgIDEgKw0KPiAgNiBmaWxlcyBjaGFuZ2VkLCA5MiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2
bS9oeXBlcmNhbGxzLnR4dCBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vaHlwZXJjYWxscy50
eHQNCj4gaW5kZXggZGEyNGMxMzhjOGQxLi5lY2Q0NGU0ODg2NzkgMTAwNjQ0DQo+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vdmlydHVhbC9rdm0vaHlwZXJjYWxscy50eHQNCj4gKysrIGIvRG9jdW1lbnRh
dGlvbi92aXJ0dWFsL2t2bS9oeXBlcmNhbGxzLnR4dA0KPiBAQCAtMTQxLDMgKzE0MSwxNyBAQCBh
MCBjb3JyZXNwb25kcyB0byB0aGUgQVBJQyBJRCBpbiB0aGUgdGhpcmQgYXJndW1lbnQgKGEyKSwg
Yml0IDENCj4gIGNvcnJlc3BvbmRzIHRvIHRoZSBBUElDIElEIGEyKzEsIGFuZCBzbyBvbi4NCj4g
IA0KPiAgUmV0dXJucyB0aGUgbnVtYmVyIG9mIENQVXMgdG8gd2hpY2ggdGhlIElQSXMgd2VyZSBk
ZWxpdmVyZWQgc3VjY2Vzc2Z1bGx5Lg0KPiArDQo+ICs3LiBLVk1fSENfUEFHRV9FTkNfU1RBVFVT
DQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICtBcmNoaXRlY3R1cmU6IHg4Ng0KPiAr
U3RhdHVzOiBhY3RpdmUNCj4gK1B1cnBvc2U6IE5vdGlmeSB0aGUgZW5jcnlwdGlvbiBzdGF0dXMg
Y2hhbmdlcyBpbiBndWVzdCBwYWdlIHRhYmxlIChTRVYgZ3Vlc3QpDQo+ICsNCj4gK2EwOiB0aGUg
Z3Vlc3QgcGh5c2ljYWwgYWRkcmVzcyBvZiB0aGUgc3RhcnQgcGFnZQ0KPiArYTE6IHRoZSBudW1i
ZXIgb2YgcGFnZXMNCj4gK2EyOiBzZXQgb3IgY2xlYXIgdGhlIGVuY3J5cHRpb24gYXR0cmlidXRl
DQoNCmEyOiBlbmNyeXB0aW9uIGF0dHJpYnV0ZQ0KDQo+ICsNCj4gKyAgIFdoZXJlOg0KPiArCSog
MTogRW5jcnlwdGlvbiBhdHRyaWJ1dGUgaXMgc2V0DQo+ICsJKiAwOiBFbmNyeXB0aW9uIGF0dHJp
YnV0ZSBpcyBjbGVhcmVkDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1f
aG9zdC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KPiBpbmRleCBhOWQwM2Fm
MzQwMzAuLmFkYjBjYTAzNWI5NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
a3ZtX2hvc3QuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQo+IEBA
IC0xMTk2LDYgKzExOTYsOCBAQCBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgew0KPiAgCXVpbnQxNl90ICgq
bmVzdGVkX2dldF9ldm1jc192ZXJzaW9uKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOw0KPiAgDQo+
ICAJYm9vbCAoKm5lZWRfZW11bGF0aW9uX29uX3BhZ2VfZmF1bHQpKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSk7DQo+ICsJaW50ICgqcGFnZV9lbmNfc3RhdHVzX2hjKShzdHJ1Y3Qga3ZtICprdm0sIHVu
c2lnbmVkIGxvbmcgZ3BhLA0KPiArCQkJCSAgdW5zaWduZWQgbG9uZyBzeiwgdW5zaWduZWQgbG9u
ZyBtb2RlKTsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBrdm1fYXJjaF9hc3luY19wZiB7DQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCj4gaW5k
ZXggNzRiNTdhYjc0MmFkLi5mMDI0ZjIwOGIwNTIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2
bS9zdm0uYw0KPiArKysgYi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCj4gQEAgLTEzOCw2ICsxMzgsOCBA
QCBzdHJ1Y3Qga3ZtX3Nldl9pbmZvIHsNCj4gIAlpbnQgZmQ7CQkJLyogU0VWIGRldmljZSBmZCAq
Lw0KPiAgCXVuc2lnbmVkIGxvbmcgcGFnZXNfbG9ja2VkOyAvKiBOdW1iZXIgb2YgcGFnZXMgbG9j
a2VkICovDQo+ICAJc3RydWN0IGxpc3RfaGVhZCByZWdpb25zX2xpc3Q7ICAvKiBMaXN0IG9mIHJl
Z2lzdGVyZWQgcmVnaW9ucyAqLw0KPiArCXVuc2lnbmVkIGxvbmcgKnBhZ2VfZW5jX2JtYXA7DQo+
ICsJdW5zaWduZWQgbG9uZyBwYWdlX2VuY19ibWFwX3NpemU7DQo+ICB9Ow0KPiAgDQo+ICBzdHJ1
Y3Qga3ZtX3N2bSB7DQo+IEBAIC0xOTExLDYgKzE5MTMsOCBAQCBzdGF0aWMgdm9pZCBzZXZfdm1f
ZGVzdHJveShzdHJ1Y3Qga3ZtICprdm0pDQo+ICANCj4gIAlzZXZfdW5iaW5kX2FzaWQoa3ZtLCBz
ZXYtPmhhbmRsZSk7DQo+ICAJc2V2X2FzaWRfZnJlZShrdm0pOw0KPiArDQo+ICsJa3ZmcmVlKHNl
di0+cGFnZV9lbmNfYm1hcCk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIGF2aWNfdm1fZGVz
dHJveShzdHJ1Y3Qga3ZtICprdm0pDQo+IEBAIC03MzcwLDYgKzczNzQsNjkgQEAgc3RhdGljIGlu
dCBzZXZfcmVjZWl2ZV9maW5pc2goc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9jbWQg
KmFyZ3ApDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBzZXZfcmVz
aXplX3BhZ2VfZW5jX2JpdG1hcChzdHJ1Y3Qga3ZtICprdm0sIHVuc2lnbmVkIGxvbmcgbmV3X3Np
emUpDQo+ICt7DQo+ICsJc3RydWN0IGt2bV9zZXZfaW5mbyAqc2V2ID0gJnRvX2t2bV9zdm0oa3Zt
KS0+c2V2X2luZm87DQo+ICsJdW5zaWduZWQgbG9uZyAqbWFwOw0KPiArCXVuc2lnbmVkIGxvbmcg
c3o7DQo+ICsNCj4gKwlpZiAoc2V2LT5wYWdlX2VuY19ibWFwX3NpemUgPj0gbmV3X3NpemUpDQo+
ICsJCXJldHVybiAwOw0KPiArDQo+ICsJc3ogPSBBTElHTihuZXdfc2l6ZSwgQklUU19QRVJfTE9O
RykgLyA4Ow0KPiArDQo+ICsJaWYgKHN6ID4gUEFHRV9TSVpFKQ0KPiArCQltYXAgPSB2bWFsbG9j
KHN6KTsNCj4gKwllbHNlDQo+ICsJCW1hcCA9IGttYWxsb2Moc3osIEdGUF9LRVJORUwpOw0KDQpB
bnkgcmVhc29uIHRoaXMgY2FuJ3QgYWx3YXlzIGJlIHZtYWxsb2MoKT8NCg0KPiArDQo+ICsJaWYg
KCFtYXApIHsNCj4gKwkJcHJfZXJyX29uY2UoIkZhaWxlZCB0byBhbGxvY2F0ZSBkZWNyeXB0ZWQg
Yml0bWFwIHNpemUgJWx4XG4iLCBzeik7DQo+ICsJCXJldHVybiAxOw0KDQpTaG91bGQgdGhpcyBi
ZSAtRU5PTUVNPw0KDQo+ICsJfQ0KPiArDQo+ICsJLyogbWFyayB0aGUgcGFnZSBlbmNyeXB0ZWQg
KGJ5IGRlZmF1bHQpICovDQo+ICsJbWVtc2V0KG1hcCwgMHhmZiwgc3opOw0KPiArDQo+ICsJYml0
bWFwX2NvcHkobWFwLCBzZXYtPnBhZ2VfZW5jX2JtYXAsIHNldi0+cGFnZV9lbmNfYm1hcF9zaXpl
KTsNCj4gKwlrdmZyZWUoc2V2LT5wYWdlX2VuY19ibWFwKTsNCj4gKw0KPiArCXNldi0+cGFnZV9l
bmNfYm1hcCA9IG1hcDsNCj4gKwlzZXYtPnBhZ2VfZW5jX2JtYXBfc2l6ZSA9IG5ld19zaXplOw0K
PiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgc3ZtX3BhZ2VfZW5j
X3N0YXR1c19oYyhzdHJ1Y3Qga3ZtICprdm0sIHVuc2lnbmVkIGxvbmcgZ3BhLA0KPiArCQkJCSAg
dW5zaWduZWQgbG9uZyBucGFnZXMsIHVuc2lnbmVkIGxvbmcgZW5jKQ0KPiArew0KPiArCXN0cnVj
dCBrdm1fc2V2X2luZm8gKnNldiA9ICZ0b19rdm1fc3ZtKGt2bSktPnNldl9pbmZvOw0KPiArCWdm
bl90IGdmbl9zdGFydCwgZ2ZuX2VuZDsNCj4gKwlpbnQgcjsNCg0KaW50IHJldDsgPyAgInIiIGF0
IGZpcnN0IGNvbmZ1c2VkIG1lLg0KDQo+ICsNCj4gKwlpZiAoIW5wYWdlcykNCj4gKwkJcmV0dXJu
IDA7DQo+ICsNCj4gKwlnZm5fc3RhcnQgPSBncGFfdG9fZ2ZuKGdwYSk7DQo+ICsJZ2ZuX2VuZCA9
IGdmbl9zdGFydCArIG5wYWdlczsNCj4gKw0KPiArCW11dGV4X2xvY2soJmt2bS0+bG9jayk7DQo+
ICsNCj4gKwlyID0gMTsNCj4gKwlpZiAoc2V2X3Jlc2l6ZV9wYWdlX2VuY19iaXRtYXAoa3ZtLCBn
Zm5fZW5kKSkNCg0KcmV0ID0gc2V2X3Jlc2l6ZV8uLi4NCmlmIChyZXQpDQoNCj4gKwkJZ290byB1
bmxvY2s7DQo+ICsNCj4gKwlpZiAoZW5jKQ0KPiArCQlfX2JpdG1hcF9zZXQoc2V2LT5wYWdlX2Vu
Y19ibWFwLCBnZm5fc3RhcnQsIGdmbl9lbmQgLSBnZm5fc3RhcnQpOw0KPiArCWVsc2UNCj4gKwkJ
X19iaXRtYXBfY2xlYXIoc2V2LT5wYWdlX2VuY19ibWFwLCBnZm5fc3RhcnQsIGdmbl9lbmQgLSBn
Zm5fc3RhcnQpOw0KPiArDQo+ICsJciA9IDA7DQoNCklmIHlvdSBkbyB0aGUgYWJvdmUsIHRoaXMg
aXMgbm90IG5lZWRlZC4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gK3VubG9jazoNCj4gKwltdXRleF91
bmxvY2soJmt2bS0+bG9jayk7DQo+ICsJcmV0dXJuIHI7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBp
bnQgc3ZtX21lbV9lbmNfb3Aoc3RydWN0IGt2bSAqa3ZtLCB2b2lkIF9fdXNlciAqYXJncCkNCj4g
IHsNCj4gIAlzdHJ1Y3Qga3ZtX3Nldl9jbWQgc2V2X2NtZDsNCj4gQEAgLTc3MTEsNiArNzc3OCw4
IEBAIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgc3ZtX3g4Nl9vcHMgX19yb19hZnRlcl9pbml0
ID0gew0KPiAgCS5uZXN0ZWRfZ2V0X2V2bWNzX3ZlcnNpb24gPSBuZXN0ZWRfZ2V0X2V2bWNzX3Zl
cnNpb24sDQo+ICANCj4gIAkubmVlZF9lbXVsYXRpb25fb25fcGFnZV9mYXVsdCA9IHN2bV9uZWVk
X2VtdWxhdGlvbl9vbl9wYWdlX2ZhdWx0LA0KPiArDQo+ICsJLnBhZ2VfZW5jX3N0YXR1c19oYyA9
IHN2bV9wYWdlX2VuY19zdGF0dXNfaGMNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBpbnQgX19pbml0
IHN2bV9pbml0KHZvaWQpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jIGIv
YXJjaC94ODYva3ZtL3ZteC92bXguYw0KPiBpbmRleCBiNGU3ZDY0NTI3NWEuLjljODE0ZTU2MGUw
ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL3ZteC92bXguYw0KPiArKysgYi9hcmNoL3g4
Ni9rdm0vdm14L3ZteC5jDQo+IEBAIC03NzMxLDYgKzc3MzEsNyBAQCBzdGF0aWMgc3RydWN0IGt2
bV94ODZfb3BzIHZteF94ODZfb3BzIF9fcm9fYWZ0ZXJfaW5pdCA9IHsNCj4gIAkuZ2V0X3ZtY3Mx
Ml9wYWdlcyA9IE5VTEwsDQo+ICAJLm5lc3RlZF9lbmFibGVfZXZtY3MgPSBOVUxMLA0KPiAgCS5u
ZWVkX2VtdWxhdGlvbl9vbl9wYWdlX2ZhdWx0ID0gdm14X25lZWRfZW11bGF0aW9uX29uX3BhZ2Vf
ZmF1bHQsDQo+ICsJLnBhZ2VfZW5jX3N0YXR1c19oYyA9IE5VTEwsDQo+ICB9Ow0KPiAgDQo+ICBz
dGF0aWMgdm9pZCB2bXhfY2xlYW51cF9sMWRfZmx1c2godm9pZCkNCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2t2bS94ODYuYyBiL2FyY2gveDg2L2t2bS94ODYuYw0KPiBpbmRleCBhMGQxZmM4MGFj
NWEuLmRlYTY0NGJlNTk5MiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jDQo+ICsr
KyBiL2FyY2gveDg2L2t2bS94ODYuYw0KPiBAQCAtNzE0MSw2ICs3MTQxLDExIEBAIGludCBrdm1f
ZW11bGF0ZV9oeXBlcmNhbGwoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiAgCWNhc2UgS1ZNX0hD
X1NFTkRfSVBJOg0KPiAgCQlyZXQgPSBrdm1fcHZfc2VuZF9pcGkodmNwdS0+a3ZtLCBhMCwgYTEs
IGEyLCBhMywgb3BfNjRfYml0KTsNCj4gIAkJYnJlYWs7DQo+ICsJY2FzZSBLVk1fSENfUEFHRV9F
TkNfU1RBVFVTOg0KPiArCQlyZXQgPSAtS1ZNX0VOT1NZUzsNCj4gKwkJaWYgKGt2bV94ODZfb3Bz
LT5wYWdlX2VuY19zdGF0dXNfaGMpDQo+ICsJCQlyZXQgPSBrdm1feDg2X29wcy0+cGFnZV9lbmNf
c3RhdHVzX2hjKHZjcHUtPmt2bSwgYTAsIGExLCBhMik7DQo+ICsJCWJyZWFrOw0KPiAgCWRlZmF1
bHQ6DQo+ICAJCXJldCA9IC1LVk1fRU5PU1lTOw0KPiAgCQlicmVhazsNCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvdWFwaS9saW51eC9rdm1fcGFyYS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bV9w
YXJhLmgNCj4gaW5kZXggNmMwY2U0OTkzMWU1Li4zZGM5ZTU3OWY0ZjkgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvdWFwaS9saW51eC9rdm1fcGFyYS5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51
eC9rdm1fcGFyYS5oDQo+IEBAIC0yOCw2ICsyOCw3IEBADQo+ICAjZGVmaW5lIEtWTV9IQ19NSVBT
X0NPTlNPTEVfT1VUUFVUCTgNCj4gICNkZWZpbmUgS1ZNX0hDX0NMT0NLX1BBSVJJTkcJCTkNCj4g
ICNkZWZpbmUgS1ZNX0hDX1NFTkRfSVBJCQkxMA0KPiArI2RlZmluZSBLVk1fSENfUEFHRV9FTkNf
U1RBVFVTCQkxMQ0KPiAgDQo+ICAvKg0KPiAgICogaHlwZXJjYWxscyB1c2UgYXJjaGl0ZWN0dXJl
IHNwZWNpZmljDQo+IA0K

