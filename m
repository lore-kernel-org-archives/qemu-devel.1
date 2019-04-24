Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E5C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 21:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BB120811
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 21:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rUaQIBUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BB120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47639 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJPfq-0006RB-6q
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 17:43:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJPeE-00056u-SA
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 17:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJPVT-0003Bc-9a
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 17:32:44 -0400
Received: from mail-eopbgr810085.outbound.protection.outlook.com
	([40.107.81.85]:2416
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJPVS-0003AP-Tg
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 17:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Q0qbdc2MkYIB/BGZJhOG1+y161iGdo+ILHAlWdVZiSU=;
	b=rUaQIBUWDm4Ukh4FghJJTid0nsreThDNvbKTDoOLjXTvpfmGgh3cUNKYFkZDNyzdpRVD+Y1awBZ8kw9ecXtaavXzrpmkG9UFBzwV3LKuQVxh8dM6v8O0yQdbTnkbM3MbMDtcJeOfO7tcrAYRhlw5bJ5+IkLnOefezsXZxHIKZm4=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2651.namprd12.prod.outlook.com (20.176.116.24) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.18; Wed, 24 Apr 2019 21:32:39 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 21:32:39 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: Steve Rutherford <srutherford@google.com>
Thread-Topic: [RFC PATCH v1 00/10] Add AMD SEV guest live migration support
Thread-Index: AQHU+rgpwai7tJB3uUaULXjJMShjVaZLrqMAgAAmZAA=
Date: Wed, 24 Apr 2019 21:32:39 +0000
Message-ID: <eee5e112-89bd-331b-6875-34c0712de4cb@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<CABayD+eYsqT49-Smp0a9OGRt2or_L7LNKHpe-iraM62XzGq5_g@mail.gmail.com>
In-Reply-To: <CABayD+eYsqT49-Smp0a9OGRt2or_L7LNKHpe-iraM62XzGq5_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0125.namprd05.prod.outlook.com
	(2603:10b6:803:42::42) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eaa54622-bd62-4599-153c-08d6c8fc6013
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2651; 
x-ms-traffictypediagnostic: DM6PR12MB2651:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR12MB26518F94CE1389ACD51A3A9CE53C0@DM6PR12MB2651.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(366004)(136003)(39860400002)(346002)(189003)(199004)(7736002)(25786009)(478600001)(26005)(86362001)(31696002)(186003)(6246003)(3846002)(6916009)(6116002)(99286004)(6436002)(305945005)(76176011)(4326008)(6486002)(53936002)(229853002)(102836004)(256004)(14444005)(81156014)(81166006)(68736007)(8676002)(71190400001)(386003)(53546011)(66066001)(2906002)(6512007)(14454004)(36756003)(31686004)(11346002)(2616005)(52116002)(476003)(97736004)(7416002)(66446008)(54906003)(486006)(316002)(446003)(5660300002)(64756008)(966005)(66946007)(66556008)(66476007)(6306002)(8936002)(73956011)(66574012)(6506007)(71200400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2651;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cr61WHLL3zDHP8oh8yYthVXqdIZcPjV07phBcic0OzufkzoFFTTJmk5yCB/1kTixZePpowcSP8v79f60X1mlwlcWwMgtv6smEigfcewtD3bhxbQtpR0chUj0OZMXfsZr5LfVus08kdvipTUSZSWOEfmJ3oo5zu8OwJTX8u/uaB5bHSX9tX7TEt12tGOF9pxn+/tTNJgYM2Ta+njn/Cxg64Rbx2QpPWVwJ3YaGDFpx5y9fGt3k0KSXETBv5khO7SKCYJyumjhWXzpvzlTbuVvkZKEKsv0C74vvZn3cOlBMJrfnmBAyskoiD3EDMbzGST6tQxHw7wTtXd1f9CY9DovMSZWaoAnSWNSJXSt4ZpWQlF3FVzX78Ffsih5kgsSTMJ6BoiAwy5yI1MsmEj8BMGiB4QZyhjZgjx8gJNlzOQVo8s=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <D3669A442693E444A3F42BFE1337BDDB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa54622-bd62-4599-153c-08d6c8fc6013
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 21:32:39.2413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2651
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.85
Subject: Re: [Qemu-devel] [RFC PATCH v1 00/10] Add AMD SEV guest live
 migration support
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
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424213239.L26HY5nY24FBqlx3w8gj7ZAcFwpZ_GMPB1wJ-MXr1K4@z>

DQoNCk9uIDQvMjQvMTkgMjoxNSBQTSwgU3RldmUgUnV0aGVyZm9yZCB3cm90ZToNCj4gT24gV2Vk
LCBBcHIgMjQsIDIwMTkgYXQgOToxMCBBTSBTaW5naCwgQnJpamVzaCA8YnJpamVzaC5zaW5naEBh
bWQuY29tPiB3cm90ZToNCj4+DQo+PiBUaGUgc2VyaWVzIGFkZCBzdXBwb3J0IGZvciBBTUQgU0VW
IGd1ZXN0IGxpdmUgbWlncmF0aW9uIGNvbW1hbmRzLiBUbyBwcm90ZWN0IHRoZQ0KPj4gY29uZmlk
ZW50aWFsaXR5IG9mIGFuIFNFViBwcm90ZWN0ZWQgZ3Vlc3QgbWVtb3J5IHdoaWxlIGluIHRyYW5z
aXQgd2UgbmVlZCB0bw0KPj4gdXNlIHRoZSBTRVYgY29tbWFuZHMgZGVmaW5lZCBpbiBTRVYgQVBJ
IHNwZWMgWzFdLg0KPj4NCj4+IFNFViBndWVzdCBWTXMgaGF2ZSB0aGUgY29uY2VwdCBvZiBwcml2
YXRlIGFuZCBzaGFyZWQgbWVtb3J5LiBQcml2YXRlIG1lbW9yeQ0KPj4gaXMgZW5jcnlwdGVkIHdp
dGggdGhlIGd1ZXN0LXNwZWNpZmljIGtleSwgd2hpbGUgc2hhcmVkIG1lbW9yeSBtYXkgYmUgZW5j
cnlwdGVkDQo+PiB3aXRoIGh5cGVydmlzb3Iga2V5LiBUaGUgY29tbWFuZHMgcHJvdmlkZWQgYnkg
dGhlIFNFViBGVyBhcmUgbWVhbnQgdG8gYmUgdXNlZA0KPj4gZm9yIHRoZSBwcml2YXRlIG1lbW9y
eSBvbmx5LiBUaGUgcGF0Y2ggc2VyaWVzIGludHJvZHVjZXMgYSBuZXcgaHlwZXJjYWxsLg0KPj4g
VGhlIGd1ZXN0IE9TIGNhbiB1c2UgdGhpcyBoeXBlcmNhbGwgdG8gbm90aWZ5IHRoZSBwYWdlIGVu
Y3J5cHRpb24gc3RhdHVzLg0KPj4gSWYgdGhlIHBhZ2UgaXMgZW5jcnlwdGVkIHdpdGggZ3Vlc3Qg
c3BlY2lmaWMta2V5IHRoZW4gd2UgdXNlIFNFViBjb21tYW5kIGR1cmluZw0KPj4gdGhlIG1pZ3Jh
dGlvbi4gSWYgcGFnZSBpcyBub3QgZW5jcnlwdGVkIHRoZW4gZmFsbGJhY2sgdG8gZGVmYXVsdC4N
Cj4+DQo+PiBUaGUgcGF0Y2ggYWRkcyBhIG5ldyBpb2N0bCBLVk1fR0VUX1BBR0VfRU5DX0JJVE1B
UC4gVGhlIGlvY3RsIGNhbiBiZSB1c2VkDQo+PiBieSB0aGUgcWVtdSB0byBnZXQgdGhlIHBhZ2Ug
ZW5jcnlwdGVkIGJpdG1hcC4gUWVtdSBjYW4gY29uc3VsdCB0aGlzIGJpdG1hcA0KPj4gZHVyaW5n
IHRoZSBtaWdyYXRpb24gdG8ga25vdyB3aGV0aGVyIHRoZSBwYWdlIGlzIGVuY3J5cHRlZC4NCj4+
DQo+PiBbMV0gaHR0cHM6Ly9kZXZlbG9wZXIuYW1kLmNvbS93cC1jb250ZW50L3Jlc291cmNlcy81
NTc2Ni5QREYNCj4+DQo+PiBUaGUgc2VyaWVzIGlzIHRlc3RlZCB3aXRoIHRoZSBRZW11LCBJIGFt
IGluIHByb2Nlc3Mgb2YgY2xlYW5pbmcNCj4+IHVwIHRoZSBRZW11IGNvZGUgYW5kIHdpbGwgc3Vi
bWl0IHNvb24uDQo+Pg0KPj4gV2hpbGUgaW1wbGVtZW50aW5nIHRoZSBtaWdyYXRpb24gSSBzdHVt
YmxlZCBvbiB0aGUgZm9sbG93IHF1ZXN0aW9uOg0KPj4NCj4+IC0gU2luY2UgdGhlcmUgaXMgYSBn
dWVzdCBPUyBjaGFuZ2VzIHJlcXVpcmVkIHRvIHN1cHBvcnQgdGhlIG1pZ3JhdGlvbiwNCj4+ICAg
IHNvIGhvdyBkbyB3ZSBrbm93IHdoZXRoZXIgZ3Vlc3QgT1MgaXMgdXBkYXRlZD8gU2hvdWxkIHdl
IGV4dGVuZCBLVk0NCj4+ICAgIGNhcGFiaWxpdGllcy9mZWF0dXJlIGJpdHMgdG8gY2hlY2sgdGhp
cz8NCj4+DQo+PiBUT0RPOg0KPj4gICAtIGFkZCBhbiBpb2N0bCB0byBidWlsZCBlbmNyeXB0aW9u
IGJpdG1hcC4gVGhlIGVuY3J5cHRpb24gYml0bWFwIGlzIGJ1aWx0IGR1cmluZw0KPj4gICAgIHRo
ZSBndWVzdCBib290dXAvZXhlY3V0aW9uLiBXZSBzaG91bGQgcHJvdmlkZSBhbiBpb2N0bCBzbyB0
aGF0IGRlc3RpbmF0aW9uDQo+PiAgICAgY2FuIGJ1aWxkIHRoZSBiaXRtYXAgYXMgaXQgcmVjZWl2
ZXMgdGhlIHBhZ2VzLg0KPj4gICAtIHJlc2V0IHRoZSBiaXRtYXAgb24gZ3Vlc3QgcmVib290Lg0K
Pj4NCj4+IFRoZSBjb21wbGV0ZSB0cmVlIHdpdGggcGF0Y2ggaXMgYXZhaWxhYmxlIGF0Og0KPj4g
aHR0cHM6Ly9naXRodWIuY29tL2NvZG9tYW5pYS9rdm0vdHJlZS9zZXYtbWlncmF0aW9uLXJmYy12
MQ0KPj4NCj4+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4+IENj
OiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4NCj4+IENjOiAiSC4gUGV0ZXIgQW52aW4i
IDxocGFAenl0b3IuY29tPg0KPj4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5j
b20+DQo+PiBDYzogIlJhZGltIEtyxI1tw6HFmSIgPHJrcmNtYXJAcmVkaGF0LmNvbT4NCj4+IENj
OiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4NCj4+IENjOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQHN1c2UuZGU+DQo+PiBDYzogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNv
bT4NCj4+IENjOiB4ODZAa2VybmVsLm9yZw0KPj4gQ2M6IGt2bUB2Z2VyLmtlcm5lbC5vcmcNCj4+
IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+Pg0KPj4gQnJpamVzaCBTaW5naCAo
MTApOg0KPj4gICAgS1ZNOiBTVk06IEFkZCBLVk1fU0VWIFNFTkRfU1RBUlQgY29tbWFuZA0KPj4g
ICAgS1ZNOiBTVk06IEFkZCBLVk1fU0VORF9VUERBVEVfREFUQSBjb21tYW5kDQo+PiAgICBLVk06
IFNWTTogQWRkIEtWTV9TRVZfU0VORF9GSU5JU0ggY29tbWFuZA0KPj4gICAgS1ZNOiBTVk06IEFk
ZCBzdXBwb3J0IGZvciBLVk1fU0VWX1JFQ0VJVkVfU1RBUlQgY29tbWFuZA0KPj4gICAgS1ZNOiBT
Vk06IEFkZCBLVk1fU0VWX1JFQ0VJVkVfVVBEQVRFX0RBVEEgY29tbWFuZA0KPj4gICAgS1ZNOiBT
Vk06IEFkZCBLVk1fU0VWX1JFQ0VJVkVfRklOSVNIIGNvbW1hbmQNCj4+ICAgIEtWTTogeDg2OiBB
ZGQgQU1EIFNFViBzcGVjaWZpYyBIeXBlcmNhbGwzDQo+PiAgICBLVk06IFg4NjogSW50cm9kdWNl
IEtWTV9IQ19QQUdFX0VOQ19TVEFUVVMgaHlwZXJjYWxsDQo+PiAgICBLVk06IHg4NjogSW50cm9k
dWNlIEtWTV9HRVRfUEFHRV9FTkNfQklUTUFQIGlvY3RsDQo+PiAgICBtbTogeDg2OiBJbnZva2Ug
aHlwZXJjYWxsIHdoZW4gcGFnZSBlbmNyeXB0aW9uIHN0YXR1cyBpcyBjaGFuZ2VkDQo+Pg0KPj4g
ICAuLi4vdmlydHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJzdCAgICAgfCAxMTYgKysr
Kw0KPj4gICBEb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL2h5cGVyY2FsbHMudHh0ICAgICAgfCAg
MTQgKw0KPj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oICAgICAgICAgICAgICAg
fCAgIDMgKw0KPj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5oICAgICAgICAgICAg
ICAgfCAgMTIgKw0KPj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oICAgICAg
ICAgICAgfCAgIDMgKw0KPj4gICBhcmNoL3g4Ni9rdm0vc3ZtLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCA1NjAgKysrKysrKysrKysrKysrKystDQo+PiAgIGFyY2gveDg2L2t2bS92bXgv
dm14LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgIGFyY2gveDg2L2t2bS94
ODYuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNyArDQo+PiAgIGFyY2gveDg2L21t
L21lbV9lbmNyeXB0LmMgICAgICAgICAgICAgICAgICAgICB8ICA0NSArLQ0KPj4gICBhcmNoL3g4
Ni9tbS9wYWdlYXR0ci5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTUgKw0KPj4gICBpbmNs
dWRlL3VhcGkvbGludXgva3ZtLmggICAgICAgICAgICAgICAgICAgICAgfCAgNTEgKysNCj4+ICAg
aW5jbHVkZS91YXBpL2xpbnV4L2t2bV9wYXJhLmggICAgICAgICAgICAgICAgIHwgICAxICsNCj4+
ICAgMTIgZmlsZXMgY2hhbmdlZCwgODM0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gLS0NCj4+IDIuMTcuMQ0KPj4NCj4gDQo+IFdoYXQncyB0aGUgYmFjay1vZi10aGUtZW52
ZWxvcGUgbWFyZ2luYWwgY29zdCBvZiB0cmFuc2ZlcnJpbmcgYSAxNmtCDQo+IHJlZ2lvbiBmcm9t
IG9uZSBob3N0IHRvIGFub3RoZXI/IEknbSBpbnRlcmVzdGVkIGluIHdoYXQgdGhlIGVuZCB0byBl
bmQNCj4gbWlncmF0aW9uIHBlcmYgY2hhbmdlcyBsb29rIGxpa2UgZm9yIHRoaXMuIElmIHlvdSBo
YXZlIG1lYXN1cmVkDQo+IG1pZ3JhdGlvbiBwZXJmLCBJJ20gaW50ZXJlc3RlZCBpbiB0aGF0IGFs
c28uDQo+IA0KDQpJIGhhdmUgbm90IGRvbmUgYSBjb21wbGV0ZSBwZXJmb3JtYW5jZSBhbmFseXNp
cyB5ZXQhIEZyb20gdGhlIHFlbXUNClFNUCBwcm9tcHQgKHF1ZXJ5LW1pZ3JhdGlvbikgSSBhbSBn
ZXR0aW5nIH44bWJwcyB0aHJvdWdocHV0IGZyb20NCm9uZSBob3N0IHRvIGFub3RoZXIgKHRoaXMg
aXMgd2l0aCA0a2IgcmVnaW9ucykuIEkgaGF2ZSBiZWVuIHRvbGQNCnRoYXQgaW5jcmVhc2luZyB0
aGUgdHJhbnNmZXIgc2l6ZSBmcm9tIDRrYiAtPiAxNmtiIG1heSBub3QgZ2l2ZSBhDQpodWdlIHBl
cmZvcm1hbmNlIGdhaW4gYmVjYXVzZSBhdCBGVyBsZXZlbCB0aGV5IHN0aWxsIG9wZXJhdGluZw0K
b24gNGtiIGJsb2Nrcy4gVGhlcmUgaXMgcG9zc2liaWxpdHkgdGhhdCBmdXR1cmUgRlcgdXBkYXRl
cyBtYXkNCmdpdmUgYSBiaXQgYmV0dGVyIHBlcmZvcm1hbmNlIG9uIDE2a2Igc2l6ZS4NCg0KLUJy
aWplc2gNCg==

