Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE582C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 21:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8222F206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 21:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iwPYqhX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8222F206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52058 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK89l-0002Xd-Qn
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 17:13:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1hK88a-0001rE-76
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1hK88Y-0004WU-MD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:12:03 -0400
Received: from mail-eopbgr730081.outbound.protection.outlook.com
	([40.107.73.81]:46880
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Thomas.Lendacky@amd.com>)
	id 1hK88V-0004VJ-KJ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=3eiHN5vU4ApixEap82J3OH211kAttmhpZ71YDXInc/Q=;
	b=iwPYqhX4RUnHSvQtKGD5awu+S+0EWMzRnuMG/mb6QMi6nlaPkvdXlTFuEmLORC7YmIbLfAEkNJ5G0VwohfVdHMFvPKKeOTAsBeYUfvsZbeP949i/iqX+x0jLk5+xkwJNZSAP05xCojEj1PB8OCWXjYhpiV0teHKild7ExvOojcQ=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3179.namprd12.prod.outlook.com (20.179.104.210) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Fri, 26 Apr 2019 21:11:54 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::c96d:c1dd:fd7a:ffd6]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::c96d:c1dd:fd7a:ffd6%4]) with mapi id 15.20.1835.010;
	Fri, 26 Apr 2019 21:11:54 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 06/10] KVM: SVM: Add KVM_SEV_RECEIVE_FINISH command
Thread-Index: AQHU+rgxBUfeGnSfxkKEDtf+zVQ4NKZO894A
Date: Fri, 26 Apr 2019 21:11:54 +0000
Message-ID: <a136f78e-e9b2-0203-4b4f-84c5db8ccd55@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-7-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-7-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0040.namprd02.prod.outlook.com
	(2603:10b6:803:2e::26) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf7b89fa-150b-4294-b566-08d6ca8bcf0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3179; 
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-microsoft-antispam-prvs: <DM6PR12MB3179F4D38684E677A62C9CF4EC3E0@DM6PR12MB3179.namprd12.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(366004)(136003)(376002)(39850400004)(396003)(189003)(199004)(110136005)(25786009)(54906003)(66066001)(102836004)(316002)(186003)(6506007)(3846002)(6116002)(6246003)(4326008)(66574012)(8676002)(7416002)(81156014)(81166006)(386003)(53546011)(26005)(53936002)(97736004)(8936002)(14444005)(256004)(7736002)(72206003)(99286004)(478600001)(66446008)(64756008)(66476007)(66556008)(71190400001)(71200400001)(6486002)(73956011)(6436002)(5660300002)(76176011)(11346002)(2501003)(2906002)(66946007)(229853002)(52116002)(36756003)(2616005)(14454004)(31686004)(6512007)(476003)(31696002)(305945005)(68736007)(486006)(86362001)(446003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3179;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kGtBL6RdFA0Jrk9Ywsb5I7GWYjTmybDCPvc2FBIYHWASDo1nLKE7g+gdDMOHK0GMxM6f0FvQ6jAlpvZMhurtFoSyCJnuvwSdsJ794JMzj4vPU9QPDNt/H0rxAwge0aQUwOKPuAVKUFrjVOkEeN31yeZTMHKV+tk7KChH68TB0TmU3lxwO69modAhMvfJuMMtZBNqE0AYQ3+B5z6z1agL/k+Gn/7DH8a0QVxyVsAruv3vogVRCHf9LkbFTaXAkTe0ELrNWcA+Fk5IN7nUrMWe0V8c6dgMIksN+faBG1GOOdiZ5/YZRmadJk1hEuV5oid82Wp8+Zwaxa9ymh3M3VkeXOQ319sFuKaDwTnG80K5WhWCg+hxviBXgsC4+zREv8t24psr/zusk92lBWQDdrfItqKe2+GhhsF70woraWNDHV8=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <96D7A046947CF544875D79D7107826E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7b89fa-150b-4294-b566-08d6ca8bcf0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 21:11:54.5127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.81
Subject: Re: [Qemu-devel] [RFC PATCH v1 06/10] KVM: SVM: Add
 KVM_SEV_RECEIVE_FINISH command
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
Message-ID: <20190426211154.-VZQD1G_sxIfWSG9Yba8xNL4Gz1yGa8CfVMskPHxAeY@z>

T24gNC8yNC8xOSAxMToxMCBBTSwgU2luZ2gsIEJyaWplc2ggd3JvdGU6DQo+IFRoZSBjb21tYW5k
IGZpbmFsaXplIHRoZSBndWVzdCByZWNlaXZpbmcgcHJvY2VzcyBhbmQgbWFrZSB0aGUgU0VWIGd1
ZXN0DQo+IHJlYWR5IGZvciB0aGUgZXhlY3V0aW9uLg0KPiANCj4gQ2M6IFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5j
b20+DQo+IENjOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiBDYzogUGFvbG8g
Qm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gQ2M6ICJSYWRpbSBLcsSNbcOhxZkiIDxy
a3JjbWFyQHJlZGhhdC5jb20+DQo+IENjOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4N
Cj4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4NCj4gQ2M6IFRvbSBMZW5kYWNreSA8
dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQo+IENjOiB4ODZAa2VybmVsLm9yZw0KPiBDYzoga3Zt
QHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
aWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQo+IC0t
LQ0KPiAgLi4uL3ZpcnR1YWwva3ZtL2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QgICAgIHwgIDgg
KysrKysrKw0KPiAgYXJjaC94ODYva3ZtL3N2bS5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMjMgKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hbWQt
bWVtb3J5LWVuY3J5cHRpb24ucnN0IGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hbWQtbWVt
b3J5LWVuY3J5cHRpb24ucnN0DQo+IGluZGV4IGI5YzNkYzAyZjM0NC4uNzJjNDVmOTNhYmQ3IDEw
MDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL2FtZC1tZW1vcnktZW5jcnlw
dGlvbi5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hbWQtbWVtb3J5LWVu
Y3J5cHRpb24ucnN0DQo+IEBAIC0zNDYsNiArMzQ2LDE0IEBAIFJldHVybnM6IDAgb24gc3VjY2Vz
cywgLW5lZ2F0aXZlIG9uIGVycm9yDQo+ICAgICAgICAgICAgICAgICAgX191MzIgdHJhbnNfbGVu
Ow0KPiAgICAgICAgICB9Ow0KPiAgDQo+ICsxNS4gS1ZNX1NFVl9SRUNFSVZFX0ZJTklTSA0KPiAr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICsNCj4gK0FmdGVyIGNvbXBsZXRpb24gb2YgdGhl
IG1pZ3JhdGlvbiBmbG93LCB0aGUgS1ZNX1NFVl9SRUNFSVZFX0ZJTklTSCBjb21tYW5kIGNhbiBi
ZQ0KPiAraXNzdWVkIGJ5IHRoZSBoeXBlcnZpc29yIHRvIG1ha2UgdGhlIGd1ZXN0IHJlYWR5IGZv
ciB0aGUgZXhlY3V0aW9uLg0KDQpmb3IgZXhlY3V0aW9uLg0KDQpUaGFua3MsDQpUb20NCg0KPiAr
DQo+ICtSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIC1uZWdhdGl2ZSBvbiBlcnJvcg0KPiArDQo+ICBS
ZWZlcmVuY2VzDQo+ICA9PT09PT09PT09DQo+ICANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2
bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KPiBpbmRleCBjODFjYWMwOWM1YWYuLjc0YjU3
YWI3NDJhZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL3N2bS5jDQo+ICsrKyBiL2FyY2gv
eDg2L2t2bS9zdm0uYw0KPiBAQCAtNzM1MCw2ICs3MzUwLDI2IEBAIHN0YXRpYyBpbnQgc2V2X3Jl
Y2VpdmVfdXBkYXRlX2RhdGEoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9jbWQgKmFy
Z3ApDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBzZXZfcmVjZWl2
ZV9maW5pc2goc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9jbWQgKmFyZ3ApDQo+ICt7
DQo+ICsJc3RydWN0IGt2bV9zZXZfaW5mbyAqc2V2ID0gJnRvX2t2bV9zdm0oa3ZtKS0+c2V2X2lu
Zm87DQo+ICsJc3RydWN0IHNldl9kYXRhX3JlY2VpdmVfZmluaXNoICpkYXRhOw0KPiArCWludCBy
ZXQ7DQo+ICsNCj4gKwlpZiAoIXNldl9ndWVzdChrdm0pKQ0KPiArCQlyZXR1cm4gLUVOT1RUWTsN
Cj4gKw0KPiArCWRhdGEgPSBremFsbG9jKHNpemVvZigqZGF0YSksIEdGUF9LRVJORUwpOw0KPiAr
CWlmICghZGF0YSkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwlkYXRhLT5oYW5kbGUg
PSBzZXYtPmhhbmRsZTsNCj4gKwlyZXQgPSBzZXZfaXNzdWVfY21kKGt2bSwgU0VWX0NNRF9SRUNF
SVZFX0ZJTklTSCwgZGF0YSwgJmFyZ3AtPmVycm9yKTsNCj4gKw0KPiArCWtmcmVlKGRhdGEpOw0K
PiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgc3ZtX21lbV9lbmNfb3Ao
c3RydWN0IGt2bSAqa3ZtLCB2b2lkIF9fdXNlciAqYXJncCkNCj4gIHsNCj4gIAlzdHJ1Y3Qga3Zt
X3Nldl9jbWQgc2V2X2NtZDsNCj4gQEAgLTc0MDYsNiArNzQyNiw5IEBAIHN0YXRpYyBpbnQgc3Zt
X21lbV9lbmNfb3Aoc3RydWN0IGt2bSAqa3ZtLCB2b2lkIF9fdXNlciAqYXJncCkNCj4gIAljYXNl
IEtWTV9TRVZfUkVDRUlWRV9VUERBVEVfREFUQToNCj4gIAkJciA9IHNldl9yZWNlaXZlX3VwZGF0
ZV9kYXRhKGt2bSwgJnNldl9jbWQpOw0KPiAgCQlicmVhazsNCj4gKwljYXNlIEtWTV9TRVZfUkVD
RUlWRV9GSU5JU0g6DQo+ICsJCXIgPSBzZXZfcmVjZWl2ZV9maW5pc2goa3ZtLCAmc2V2X2NtZCk7
DQo+ICsJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+ICAJCXIgPSAtRUlOVkFMOw0KPiAgCQlnb3Rv
IG91dDsNCj4gDQo=

