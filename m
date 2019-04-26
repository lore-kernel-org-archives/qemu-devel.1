Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517BBC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 21:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0983C2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 21:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Pzc1UIfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0983C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52003 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK86A-0008PV-SJ
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 17:09:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1hK85J-00083b-4l
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1hK85H-0000tm-9W
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:08:40 -0400
Received: from mail-eopbgr740048.outbound.protection.outlook.com
	([40.107.74.48]:19646
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Thomas.Lendacky@amd.com>)
	id 1hK85G-0000s7-QW
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=x6IbCDi9DaGPusr7n0OwkTdCUh1E6qbRs5bX9NwVhlg=;
	b=Pzc1UIfrDUoOA5NBFosc7fZmS2YgvAlieL1NazDnqKgTejIBAgiUh5x8eX1Z/7iERedxwpun8E/GlQzIzFDHDbvlXX9S/kItSfdFVh6tS2RpQgT0ZUzSvHaWKrPZSv5jiNte8sMfgwWFYVFWKN8hXXVXJTijeWr8eH2WumbuO50=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3482.namprd12.prod.outlook.com (20.178.199.13) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Fri, 26 Apr 2019 21:08:36 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::c96d:c1dd:fd7a:ffd6]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::c96d:c1dd:fd7a:ffd6%4]) with mapi id 15.20.1835.010;
	Fri, 26 Apr 2019 21:08:36 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 04/10] KVM: SVM: Add support for
	KVM_SEV_RECEIVE_START command
Thread-Index: AQHU+rgw/4wFeIGwtk6QbE0NhgP/+qZO8voA
Date: Fri, 26 Apr 2019 21:08:36 +0000
Message-ID: <69ccf6be-26d5-8766-b9b1-c18221902386@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-5-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-5-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0092.namprd12.prod.outlook.com
	(2603:10b6:802:21::27) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c92e850e-87e1-46cb-112a-08d6ca8b5910
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3482; 
x-ms-traffictypediagnostic: DM6PR12MB3482:
x-microsoft-antispam-prvs: <DM6PR12MB3482EE242F95E41D2DCA92F9EC3E0@DM6PR12MB3482.namprd12.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(7736002)(6436002)(86362001)(446003)(25786009)(36756003)(486006)(52116002)(6116002)(99286004)(8676002)(81166006)(305945005)(8936002)(76176011)(81156014)(102836004)(14444005)(11346002)(256004)(2501003)(3846002)(2616005)(476003)(14454004)(53546011)(6506007)(386003)(6246003)(478600001)(64756008)(73956011)(66574012)(186003)(5660300002)(66946007)(229853002)(66556008)(66476007)(66446008)(4326008)(26005)(71190400001)(72206003)(6512007)(31686004)(54906003)(110136005)(31696002)(68736007)(6486002)(7416002)(97736004)(316002)(2906002)(71200400001)(66066001)(53936002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3482;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aAgG7Wlr6wbdmAukd112c3u+/koCHMms4YAl6qzw7WB31gjEjwJbGhgmh8IHY4ZyQt5qqOhEYLTEz072jG03lQ5I9jARk4yIpf9VSE8FlHfamc1cjNsJR/k4SUPJ1al33VRbrBpEBVSYZnIA3iJcNsl3jKZmUrchqvJgGZgmYSA3VU5KyAjacWOp/9y0yo+xl59ymetY4BITQ6I6Ml+wk4AEtq86w7MjFopzVvcmOqaQ4/Nyns43yTOk6ZOV4pxA/qFm65a0dCxloyYlczCdScO8XGPWdR6shq1c3/D80ovyC125vCatTxsI55IH8tu3FjTCmrXTIlU3qdjhh4Hn8l405kiErK4V60jMKIapEUeOhDInPwlhVspiAYz2yCPZe1vTEEAFfYooWytp5oBlaj+DVHpKH9pASBNBryAZI/4=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <53FEE1F74FBC2A4FBBE5B4BB15D16687@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92e850e-87e1-46cb-112a-08d6ca8b5910
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 21:08:36.5205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3482
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.48
Subject: Re: [Qemu-devel] [RFC PATCH v1 04/10] KVM: SVM: Add support for
 KVM_SEV_RECEIVE_START command
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
Message-ID: <20190426210836.jUG5TKVPFLPGT6pLrOGpEOXrHUGQIzMXhLmmsGq1kw4@z>

T24gNC8yNC8xOSAxMToxMCBBTSwgU2luZ2gsIEJyaWplc2ggd3JvdGU6DQo+IFRoZSBjb21tYW5k
IGlzIHVzZWQgdG8gY3JlYXRlIGVuY3J5cHRpb24gY29udGV4dCBmb3IgdGhlIGluY29taW5nDQoN
CmNyZWF0ZSB0aGUgZW5jcnlwdGlvbiBjb250ZXh0IGZvciBhbiBpbmNvbWluZw0KDQo+IFNFViBn
dWVzdC4gVGhlIGVuY3J5cHRpb24gY29udGV4dCBjYW4gYmUgbGF0ZXIgdW51c2VkIGJ5IHRoZSBo
eXBlcnZpc29yDQoNCmNhbiBiZSBsYXRlciB1c2VkIGJ5DQoNCj4gdG8gaW1wb3J0IHRoZSBpbmNv
bWluZyBkYXRhIGludG8gdGhlIFNFViBndWVzdCBtZW1vcnkgc3BhY2UuDQo+IA0KPiBDYzogVGhv
bWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENjOiBJbmdvIE1vbG5hciA8bWlu
Z29AcmVkaGF0LmNvbT4NCj4gQ2M6ICJILiBQZXRlciBBbnZpbiIgPGhwYUB6eXRvci5jb20+DQo+
IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiBDYzogIlJhZGltIEty
xI1tw6HFmSIgPHJrcmNtYXJAcmVkaGF0LmNvbT4NCj4gQ2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4
Ynl0ZXMub3JnPg0KPiBDYzogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KPiBDYzogVG9t
IExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCj4gQ2M6IHg4NkBrZXJuZWwub3Jn
DQo+IENjOiBrdm1Admdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEJyaWplc2ggU2luZ2ggPGJyaWplc2guc2luZ2hAYW1k
LmNvbT4NCj4gLS0tDQo+ICAuLi4vdmlydHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJz
dCAgICAgfCAyOSArKysrKysrDQo+ICBhcmNoL3g4Ni9rdm0vc3ZtLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCA4MCArKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL3VhcGkvbGlu
dXgva3ZtLmggICAgICAgICAgICAgICAgICAgICAgfCAgOSArKysNCj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMTE4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3Zp
cnR1YWwva3ZtL2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QgYi9Eb2N1bWVudGF0aW9uL3ZpcnR1
YWwva3ZtL2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QNCj4gaW5kZXggMDA2ODMyMjU2YWUzLi5h
Y2RmZjI0NTQ2NDkgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYW1k
LW1lbW9yeS1lbmNyeXB0aW9uLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3Zt
L2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QNCj4gQEAgLTI5Myw2ICsyOTMsMzUgQEAgaXNzdWVk
IGJ5IHRoZSBoeXBlcnZpc29yIHRvIGRlbGV0ZSB0aGUgZW5jcnlwdGlvbiBjb250ZXh0Lg0KPiAg
DQo+ICBSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIC1uZWdhdGl2ZSBvbiBlcnJvcg0KPiAgDQo+ICsx
My4gS1ZNX1NFVl9SRUNFSVZFX1NUQVJUDQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
Kw0KPiArVGhlIEtWTV9TRVZfUkVDRUlWRV9TVEFSVCBjb21tYW5kIGlzIHVzZWQgZm9yIGNyZWF0
aW5nIHRoZSBtZW1vcnkgZW5jcnlwdGlvbg0KPiArY29udGV4dCBmb3IgYW4gaW5jb21pbmcgU0VW
IGd1ZXN0LiBUbyBjcmVhdGUgdGhlIGVuY3J5cHRpb24gY29udGV4dCwgdXNlciBtdXN0DQoNCnRo
ZSB1c2VyIG11c3QNCg0KVGhhbmtzLA0KVG9tDQoNCj4gK3Byb3ZpZGUgYSBndWVzdCBwb2xpY3ks
IHRoZSBwbGF0Zm9ybSBwdWJsaWMgRGlmZmllLUhlbGxtYW4gKFBESCkga2V5IGFuZCBzZXNzaW9u
DQo+ICtpbmZvcm1hdGlvbi4NCj4gKw0KPiArUGFyYW1ldGVyczogc3RydWN0ICBrdm1fc2V2X3Jl
Y2VpdmVfc3RhcnQgKGluL291dCkNCj4gKw0KPiArUmV0dXJuczogMCBvbiBzdWNjZXNzLCAtbmVn
YXRpdmUgb24gZXJyb3INCj4gKw0KPiArOjoNCj4gKw0KPiArICAgICAgICBzdHJ1Y3Qga3ZtX3Nl
dl9yZWNlaXZlX3N0YXJ0IHsNCj4gKyAgICAgICAgICAgICAgICBfX3UzMiBoYW5kbGU7ICAgICAg
ICAgICAvKiBpZiB6ZXJvIHRoZW4gZmlybXdhcmUgY3JlYXRlcyBhIG5ldyBoYW5kbGUgKi8NCj4g
KyAgICAgICAgICAgICAgICBfX3UzMiBwb2xpY3k7ICAgICAgICAgICAvKiBndWVzdCdzIHBvbGlj
eSAqLw0KPiArDQo+ICsgICAgICAgICAgICAgICAgX191NjQgcGRoX3VhZGRyOyAgICAgICAgIC8q
IHVzZXJzcGFjZSBhZGRyZXNzIHBvaW50aW5nIHRvIHRoZSBQREgga2V5ICovDQo+ICsgICAgICAg
ICAgICAgICAgX191MzIgZGhfbGVuOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgX191NjQgc2Vz
c2lvbl9hZGRyOyAgICAgLyogdXNlcnNwYWNlIGFkZHJlc3Mgd2hpY2ggcG9pbnRzIHRvIHRoZSBn
dWVzdCBzZXNzaW9uIGluZm9ybWF0aW9uICovDQo+ICsgICAgICAgICAgICAgICAgX191MzIgc2Vz
c2lvbl9sZW47DQo+ICsgICAgICAgIH07DQo+ICsNCj4gK09uIHN1Y2Nlc3MsIHRoZSAnaGFuZGxl
JyBmaWVsZCBjb250YWlucyBhIG5ldyBoYW5kbGUgYW5kIG9uIGVycm9yLCBhIG5lZ2F0aXZlIHZh
bHVlLg0KPiArDQo+ICtGb3IgbW9yZSBkZXRhaWxzLCBzZWUgU0VWIHNwZWMgU2VjdGlvbiA2LjEy
Lg0KPiArDQo+ICBSZWZlcmVuY2VzDQo+ICA9PT09PT09PT09DQo+ICANCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2t2bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KPiBpbmRleCAyNjNmM2M3
ZGVhZTcuLmE3ZGNmMTliYWVmYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL3N2bS5jDQo+
ICsrKyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KPiBAQCAtNzE5Miw2ICs3MTkyLDgzIEBAIHN0YXRp
YyBpbnQgc2V2X3NlbmRfZmluaXNoKHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0IGt2bV9zZXZfY21k
ICphcmdwKQ0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgc2V2X3Jl
Y2VpdmVfc3RhcnQoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9jbWQgKmFyZ3ApDQo+
ICt7DQo+ICsJc3RydWN0IGt2bV9zZXZfaW5mbyAqc2V2ID0gJnRvX2t2bV9zdm0oa3ZtKS0+c2V2
X2luZm87DQo+ICsJc3RydWN0IHNldl9kYXRhX3JlY2VpdmVfc3RhcnQgKnN0YXJ0Ow0KPiArCXN0
cnVjdCBrdm1fc2V2X3JlY2VpdmVfc3RhcnQgcGFyYW1zOw0KPiArCWludCAqZXJyb3IgPSAmYXJn
cC0+ZXJyb3I7DQo+ICsJdm9pZCAqc2Vzc2lvbl9kYXRhID0gTlVMTDsNCj4gKwl2b2lkICpwZGhf
ZGF0YSA9IE5VTEw7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWlmICghc2V2X2d1ZXN0KGt2bSkp
DQo+ICsJCXJldHVybiAtRU5PVFRZOw0KPiArDQo+ICsJLyogR2V0IHBhcmFtZXRlciBmcm9tIHRo
ZSB1c2VyICovDQo+ICsJaWYgKGNvcHlfZnJvbV91c2VyKCZwYXJhbXMsICh2b2lkIF9fdXNlciAq
KSh1aW50cHRyX3QpYXJncC0+ZGF0YSwNCj4gKwkJCXNpemVvZihzdHJ1Y3Qga3ZtX3Nldl9yZWNl
aXZlX3N0YXJ0KSkpDQo+ICsJCXJldHVybiAtRUZBVUxUOw0KPiArDQo+ICsJaWYgKCFwYXJhbXMu
cGRoX3VhZGRyIHx8ICFwYXJhbXMucGRoX2xlbiB8fA0KPiArCSAgICAhcGFyYW1zLnNlc3Npb25f
dWFkZHIgfHwgIXBhcmFtcy5zZXNzaW9uX2xlbikNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsN
Cj4gKwlzdGFydCA9IGt6YWxsb2Moc2l6ZW9mKCpzdGFydCksIEdGUF9LRVJORUwpOw0KPiArCWlm
ICghc3RhcnQpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJc3RhcnQtPmhhbmRsZSA9
IHBhcmFtcy5oYW5kbGU7DQo+ICsJc3RhcnQtPnBvbGljeSA9IHBhcmFtcy5wb2xpY3k7DQo+ICsN
Cj4gKwlwZGhfZGF0YSA9IHBzcF9jb3B5X3VzZXJfYmxvYihwYXJhbXMucGRoX3VhZGRyLCBwYXJh
bXMucGRoX2xlbik7DQo+ICsJaWYgKElTX0VSUihwZGhfZGF0YSkpIHsNCj4gKwkJcmV0ID0gUFRS
X0VSUihwZGhfZGF0YSk7DQo+ICsJCWdvdG8gZV9mcmVlOw0KPiArCX0NCj4gKw0KPiArCXN0YXJ0
LT5wZGhfY2VydF9hZGRyZXNzID0gX19wc3BfcGEocGRoX2RhdGEpOw0KPiArCXN0YXJ0LT5wZGhf
Y2VydF9sZW4gPSBwYXJhbXMucGRoX2xlbjsNCj4gKw0KPiArCXNlc3Npb25fZGF0YSA9IHBzcF9j
b3B5X3VzZXJfYmxvYihwYXJhbXMuc2Vzc2lvbl91YWRkciwgcGFyYW1zLnNlc3Npb25fbGVuKTsN
Cj4gKwlpZiAoSVNfRVJSKHNlc3Npb25fZGF0YSkpIHsNCj4gKwkJcmV0ID0gUFRSX0VSUihzZXNz
aW9uX2RhdGEpOw0KPiArCQlnb3RvIGVfZnJlZV9wZGg7DQo+ICsJfQ0KPiArDQo+ICsJc3RhcnQt
PnNlc3Npb25fYWRkcmVzcyA9IF9fcHNwX3BhKHNlc3Npb25fZGF0YSk7DQo+ICsJc3RhcnQtPnNl
c3Npb25fbGVuID0gcGFyYW1zLnNlc3Npb25fbGVuOw0KPiArDQo+ICsJLyogY3JlYXRlIG1lbW9y
eSBlbmNyeXB0aW9uIGNvbnRleHQgKi8NCj4gKwlyZXQgPSBfX3Nldl9pc3N1ZV9jbWQoYXJncC0+
c2V2X2ZkLCBTRVZfQ01EX1JFQ0VJVkVfU1RBUlQsIHN0YXJ0LCBlcnJvcik7DQo+ICsJaWYgKHJl
dCkNCj4gKwkJZ290byBlX2ZyZWVfc2Vzc2lvbjsNCj4gKw0KPiArCS8qIEJpbmQgQVNJRCB0byB0
aGlzIGd1ZXN0ICovDQo+ICsJcmV0ID0gc2V2X2JpbmRfYXNpZChrdm0sIHN0YXJ0LT5oYW5kbGUs
IGVycm9yKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGVfZnJlZV9zZXNzaW9uOw0KPiArDQo+
ICsJcGFyYW1zLmhhbmRsZSA9IHN0YXJ0LT5oYW5kbGU7DQo+ICsJaWYgKGNvcHlfdG9fdXNlcigo
dm9pZCBfX3VzZXIgKikodWludHB0cl90KWFyZ3AtPmRhdGEsDQo+ICsJCQkgJnBhcmFtcywgc2l6
ZW9mKHN0cnVjdCBrdm1fc2V2X3JlY2VpdmVfc3RhcnQpKSkgew0KPiArCQlyZXQgPSAtRUZBVUxU
Ow0KPiArCQlzZXZfdW5iaW5kX2FzaWQoa3ZtLCBzdGFydC0+aGFuZGxlKTsNCj4gKwkJZ290byBl
X2ZyZWVfc2Vzc2lvbjsNCj4gKwl9DQo+ICsNCj4gKwlzZXYtPmhhbmRsZSA9IHN0YXJ0LT5oYW5k
bGU7DQo+ICsJc2V2LT5mZCA9IGFyZ3AtPnNldl9mZDsNCj4gKw0KPiArZV9mcmVlX3Nlc3Npb246
DQo+ICsJa2ZyZWUoc2Vzc2lvbl9kYXRhKTsNCj4gK2VfZnJlZV9wZGg6DQo+ICsJa2ZyZWUocGRo
X2RhdGEpOw0KPiArZV9mcmVlOg0KPiArCWtmcmVlKHN0YXJ0KTsNCj4gKwlyZXR1cm4gcmV0Ow0K
PiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IHN2bV9tZW1fZW5jX29wKHN0cnVjdCBrdm0gKmt2bSwg
dm9pZCBfX3VzZXIgKmFyZ3ApDQo+ICB7DQo+ICAJc3RydWN0IGt2bV9zZXZfY21kIHNldl9jbWQ7
DQo+IEBAIC03MjQyLDYgKzczMTksOSBAQCBzdGF0aWMgaW50IHN2bV9tZW1fZW5jX29wKHN0cnVj
dCBrdm0gKmt2bSwgdm9pZCBfX3VzZXIgKmFyZ3ApDQo+ICAJY2FzZSBLVk1fU0VWX1NFTkRfRklO
SVNIOg0KPiAgCQlyID0gc2V2X3NlbmRfZmluaXNoKGt2bSwgJnNldl9jbWQpOw0KPiAgCQlicmVh
azsNCj4gKwljYXNlIEtWTV9TRVZfUkVDRUlWRV9TVEFSVDoNCj4gKwkJciA9IHNldl9yZWNlaXZl
X3N0YXJ0KGt2bSwgJnNldl9jbWQpOw0KPiArCQlicmVhazsNCj4gIAlkZWZhdWx0Og0KPiAgCQly
ID0gLUVJTlZBTDsNCj4gIAkJZ290byBvdXQ7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkv
bGludXgva3ZtLmggYi9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgNCj4gaW5kZXggMGJlZTkxYmJh
MzI5Li5mZWU3NWJmMWZkOTAgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9rdm0u
aA0KPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgNCj4gQEAgLTE1NDEsNiArMTU0MSwx
NSBAQCBzdHJ1Y3Qga3ZtX3Nldl9zZW5kX3VwZGF0ZV9kYXRhIHsNCj4gIAlfX3UzMiB0cmFuc19s
ZW47DQo+ICB9Ow0KPiAgDQo+ICtzdHJ1Y3Qga3ZtX3Nldl9yZWNlaXZlX3N0YXJ0IHsNCj4gKwlf
X3UzMiBoYW5kbGU7DQo+ICsJX191MzIgcG9saWN5Ow0KPiArCV9fdTY0IHBkaF91YWRkcjsNCj4g
KwlfX3UzMiBwZGhfbGVuOw0KPiArCV9fdTY0IHNlc3Npb25fdWFkZHI7DQo+ICsJX191MzIgc2Vz
c2lvbl9sZW47DQo+ICt9Ow0KPiArDQo+ICAjZGVmaW5lIEtWTV9ERVZfQVNTSUdOX0VOQUJMRV9J
T01NVQkoMSA8PCAwKQ0KPiAgI2RlZmluZSBLVk1fREVWX0FTU0lHTl9QQ0lfMl8zCQkoMSA8PCAx
KQ0KPiAgI2RlZmluZSBLVk1fREVWX0FTU0lHTl9NQVNLX0lOVFgJKDEgPDwgMikNCj4gDQo=

