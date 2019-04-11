Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B19C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEA820818
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GpooRmN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEA820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEeIO-0004dg-2h
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 14:19:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEeHR-0004Ek-04
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEeHP-0004bU-0A
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:18:32 -0400
Received: from mail-eopbgr730063.outbound.protection.outlook.com
	([40.107.73.63]:3046
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hEeHM-0004WJ-0a
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=/xdNKks9bLwoXzFIonfPzk/msVbDTyZxouXTIW1hi5w=;
	b=GpooRmN1n5NOoeam22wtg0gh1gr0XNrryAR0gAfPV5Zo++wLiBbpC6oDRLEzsna5uzj6YcVc5EIrtZEtNrLhP2LY3bKEd309/jksBIW5rQUIEDoVkuFu+EwONa5TbvTF4nGtjil1OjVk1EUOrpuorfX+StqqNpvc09FtQStiDdU=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB3467.namprd12.prod.outlook.com (20.178.199.10) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.14; Thu, 11 Apr 2019 18:18:17 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9d54:69c5:d057:80de]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9d54:69c5:d057:80de%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 18:18:17 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Thread-Topic: [PATCH] target/i386: sev: add 'sev-max-guests' field to
	'query-sev-capabilities'
Thread-Index: AQHU8JBbMl53pn0tMEuZJLOOksDkdaY3QRoAgAADoAA=
Date: Thu, 11 Apr 2019 18:18:17 +0000
Message-ID: <41de8328-90c8-ce9a-b952-7694d2aa86c3@amd.com>
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<20190411180516.GJ3641@redhat.com>
In-Reply-To: <20190411180516.GJ3641@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0006.namprd02.prod.outlook.com
	(2603:10b6:803:2b::16) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09d47edc-1d4b-4cdf-4b3a-08d6beaa119d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3467; 
x-ms-traffictypediagnostic: DM6PR12MB3467:
x-microsoft-antispam-prvs: <DM6PR12MB3467C88D643403DFC6240DFFE52F0@DM6PR12MB3467.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(396003)(346002)(136003)(39860400002)(376002)(189003)(199004)(97736004)(14454004)(102836004)(2906002)(31686004)(99286004)(8676002)(486006)(54906003)(8936002)(6512007)(81166006)(316002)(81156014)(86362001)(52116002)(68736007)(71190400001)(53936002)(31696002)(26005)(6486002)(186003)(6436002)(71200400001)(14444005)(106356001)(66066001)(305945005)(256004)(36756003)(4326008)(11346002)(229853002)(6246003)(5660300002)(446003)(478600001)(76176011)(3846002)(6916009)(7736002)(6116002)(6506007)(105586002)(53546011)(386003)(2616005)(25786009)(476003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3467;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9sWIMOgkYUB+9FAZ2rybvp7nZPiHfLq6v+5mNVQyJdNihKJeU2eDMduYCUX9qDb8tFZ7alO2KToy4OGcuGjihZpFnmmThN05E/yVaQaNLrTxha7ljDcwyVTorJlO3ZqE0CrxpAgh0wLC+nHipNmO6czY045BG4hYM04ALANDUzS4Mfwz2S7p5EdWT7O+4+Tmaa1M8L0Cj64UkCVeMDv9Nw2VxkrhFSZi4k2XDkfRHQtoYCwImhQDTn1wNmycIR2kkQYbL3KXwe2zIq1U7iaXj6VKgjx/lck6VSgIuOfUf9nEEzLksPKsmIt2IRGgnlSlTXybF7gaYGyWtR7eG1s2c3eLT4pLtG8P4chInLQJixpoP8xpFNoS1RpZAgRRPWQHqP2Cym6eklXx3swjNEP4UZg69e3DZWLo+c9xMopVpec=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <5F6D71DAF4BE41428A0F9E85FD05F770@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d47edc-1d4b-4cdf-4b3a-08d6beaa119d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 18:18:17.1494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3467
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.63
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>,
	Erik Skultety <eskultet@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411181817.UtjvHZcb5S-bepZsdX4D487tVYmc52tM81IAhAJNnCg@z>

DQoNCk9uIDQvMTEvMTkgMTowNSBQTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24g
VGh1LCBBcHIgMTEsIDIwMTkgYXQgMDU6NTk6NTBQTSArMDAwMCwgU2luZ2gsIEJyaWplc2ggd3Jv
dGU6DQo+PiBUaGVyZSBhcmUgbGltaXRlZCBudW1iZXJzIG9mIHRoZSBTRVYgZ3Vlc3RzIHRoYXQg
Y2FuIGJlIHJ1biBjb25jdXJyZW50bHkuDQo+PiBBIG1hbmFnZW1lbnQgYXBwbGljYXRpb25zIG1h
eSBuZWVkIHRvIGtub3cgdGhpcyBsaW1pdCBzbyB0aGF0IGl0IGNhbiBwbGFjZQ0KPj4gU0VWIFZN
cyBvbiBob3N0cyB3aGljaCBoYXZlIHN1aXRhYmxlIHJlc291cmNlcyBhdmFpbGFibGUuDQo+Pg0K
Pj4gQ3VycmVudGx5LCB0aGlzIGxpbWl0IGlzIG5vdCBleHBvc2VkIHRvIHRoZSBhcHBsaWNhdGlv
bi4gQWRkIGEgbmV3DQo+PiAnc2V2LW1heC1ndWVzdCcgZmllbGQgaW4gdGhlIHF1ZXJ5LXNldi1j
YXBhYmlsaXRpZXMgdG8gcHJvdmlkZSB0aGlzDQo+PiBpbmZvcm1hdGlvbi4NCj4+DQo+PiBDYzog
UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4+IENjOiBNYXJrdXMgQXJtYnJ1
c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+PiBDYzogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhh
dC5jb20+DQo+PiBDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4N
Cj4+IENjOiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPg0KPj4gQ2M6IEVyaWsgU2t1
bHRldHkgPGVza3VsdGV0QHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNp
bmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgcWFwaS90YXJnZXQuanNv
biAgfCA2ICsrKystLQ0KPj4gICB0YXJnZXQvaTM4Ni9zZXYuYyB8IDYgKysrKy0tDQo+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9xYXBpL3RhcmdldC5qc29uIGIvcWFwaS90YXJnZXQuanNvbg0KPj4gaW5kZXgg
MWQ0ZDU0YjYwMC4uYjQ1MTIxZDMwYiAxMDA2NDQNCj4+IC0tLSBhL3FhcGkvdGFyZ2V0Lmpzb24N
Cj4+ICsrKyBiL3FhcGkvdGFyZ2V0Lmpzb24NCj4+IEBAIC0xODMsNyArMTgzLDggQEANCj4gDQo+
IEEgZmV3IGxpbmVzIGFib3ZlIGhlcmUgeW91IG5lZWQgdG8gZG9jdW1lbnQgdGhlIG5ldyBmaWVs
ZA0KPiB3aXRoIChzaW5jZSA0LjEpIGFubm90YXRpb24uDQo+IA0KDQpub3RlZC4gdGhhbmtzDQo=

