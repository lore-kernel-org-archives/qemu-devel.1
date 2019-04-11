Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F08C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F182146F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Vchv0jfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F182146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53567 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEez2-0008Qk-Ej
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 15:03:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEext-0007ro-0J
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEexs-0007x6-1k
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:02:24 -0400
Received: from mail-eopbgr680052.outbound.protection.outlook.com
	([40.107.68.52]:53638
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hEexr-0007wo-MZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=j3XSALj1ZI2w8+Q0JRunqhvk8HFbX4TBKACblW05umo=;
	b=Vchv0jfkYGwcXIc4kFFbZaS2M3KMN5ZEt24gyrbuWqfJ1TQFzzAFM6PhWYdXS+2IeYO0UTziqvzq8cxHF7DabOj05M1aA/0Ybg6fJQk60wyR3JV+fWbPs+uHPGJqFRnbJNnEOSoxTg//FTqkTHc174kaauffry5W32eb4AtLkNA=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2939.namprd12.prod.outlook.com (20.179.104.77) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.14; Thu, 11 Apr 2019 19:02:21 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9d54:69c5:d057:80de]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9d54:69c5:d057:80de%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 19:02:21 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: Laszlo Ersek <lersek@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
	field to 'query-sev-capabilities'
Thread-Index: AQHU8JBbMl53pn0tMEuZJLOOksDkdaY3QrAAgAAOSIA=
Date: Thu, 11 Apr 2019 19:02:21 +0000
Message-ID: <7d449ae2-6762-97c2-4930-358f34f3ef4b@amd.com>
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
In-Reply-To: <61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0024.namprd04.prod.outlook.com
	(2603:10b6:803:21::34) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2be3ed7e-ba3a-425d-101f-08d6beb039f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2939; 
x-ms-traffictypediagnostic: DM6PR12MB2939:
x-microsoft-antispam-prvs: <DM6PR12MB29396A705C07445BBB8D9313E52F0@DM6PR12MB2939.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(2501003)(6506007)(256004)(53936002)(14454004)(81166006)(8676002)(71190400001)(6246003)(53546011)(386003)(106356001)(14444005)(81156014)(102836004)(68736007)(105586002)(31696002)(8936002)(66066001)(486006)(446003)(5660300002)(31686004)(11346002)(476003)(71200400001)(4326008)(97736004)(99286004)(2616005)(2906002)(478600001)(7736002)(305945005)(6486002)(229853002)(6436002)(52116002)(110136005)(36756003)(186003)(6512007)(26005)(316002)(86362001)(25786009)(6116002)(54906003)(76176011)(3846002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2939;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: seIc1w5+Qrb3kiUIvFbh+mFCSYrREfh31VAsUS6OnBhHt8m+NxRUHeno4IsNOtJR85+vk+RFvkrj16DOqsmnB+rbevF7ixRv8OcsdhhKSmvLml1b1/tf+DCJ+rGqatNx21E/3XHr03jmN0zFIELdiGFapC375fY6FkQj2RknVgkpTpwYIuy6NhRNXuiZeo7wI6QE5kamAVY0nsWF6Gye4ABmMksJv6id7ss/pZy+A8D7Si6uhifQ3f3olnK00wUX/dlH7yq0tsImhrQKEPM56ZYMHQzFzjA5jX34js2Lz6+065t1tmV30GyCQYyaNZl/O4bDSDtzVhyQaIYNdWDz/9pleePCQMiwuOHAEclDWGNkBeOT6rzeuAkaAQQpIyHKfb3KgTTt2DBrkQSYSKVsptNctakm7bTnWGvYqtiKUlw=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <05F7BBE3B9FD39438A1BB8145543B6B6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be3ed7e-ba3a-425d-101f-08d6beb039f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 19:02:21.8175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.52
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, Markus Armbruster <armbru@redhat.com>,
	Erik Skultety <eskultet@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411190221.lu_D-5EMpvJrgY3CGR7gUMgOg_xp_QxN8RpflHibw1A@z>

DQoNCk9uIDQvMTEvMTkgMToxMCBQTSwgTGFzemxvIEVyc2VrIHdyb3RlOg0KPiBPbiAwNC8xMS8x
OSAxOTo1OSwgU2luZ2gsIEJyaWplc2ggd3JvdGU6DQo+PiBUaGVyZSBhcmUgbGltaXRlZCBudW1i
ZXJzIG9mIHRoZSBTRVYgZ3Vlc3RzIHRoYXQgY2FuIGJlIHJ1biBjb25jdXJyZW50bHkuDQo+PiBB
IG1hbmFnZW1lbnQgYXBwbGljYXRpb25zIG1heSBuZWVkIHRvIGtub3cgdGhpcyBsaW1pdCBzbyB0
aGF0IGl0IGNhbiBwbGFjZQ0KPj4gU0VWIFZNcyBvbiBob3N0cyB3aGljaCBoYXZlIHN1aXRhYmxl
IHJlc291cmNlcyBhdmFpbGFibGUuDQo+Pg0KPj4gQ3VycmVudGx5LCB0aGlzIGxpbWl0IGlzIG5v
dCBleHBvc2VkIHRvIHRoZSBhcHBsaWNhdGlvbi4gQWRkIGEgbmV3DQo+PiAnc2V2LW1heC1ndWVz
dCcgZmllbGQgaW4gdGhlIHF1ZXJ5LXNldi1jYXBhYmlsaXRpZXMgdG8gcHJvdmlkZSB0aGlzDQo+
PiBpbmZvcm1hdGlvbi4NCj4+DQo+PiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT4NCj4+IENjOiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+PiBD
YzogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+PiBDYzogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4+IENjOiBMYXN6bG8gRXJzZWsgPGxlcnNla0By
ZWRoYXQuY29tPg0KPj4gQ2M6IEVyaWsgU2t1bHRldHkgPGVza3VsdGV0QHJlZGhhdC5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQo+
PiAtLS0NCj4+ICAgcWFwaS90YXJnZXQuanNvbiAgfCA2ICsrKystLQ0KPj4gICB0YXJnZXQvaTM4
Ni9zZXYuYyB8IDYgKysrKy0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9xYXBpL3RhcmdldC5qc29uIGIv
cWFwaS90YXJnZXQuanNvbg0KPj4gaW5kZXggMWQ0ZDU0YjYwMC4uYjQ1MTIxZDMwYiAxMDA2NDQN
Cj4+IC0tLSBhL3FhcGkvdGFyZ2V0Lmpzb24NCj4+ICsrKyBiL3FhcGkvdGFyZ2V0Lmpzb24NCj4+
IEBAIC0xODMsNyArMTgzLDggQEANCj4+ICAgICAnZGF0YSc6IHsgJ3BkaCc6ICdzdHInLA0KPj4g
ICAgICAgICAgICAgICAnY2VydC1jaGFpbic6ICdzdHInLA0KPj4gICAgICAgICAgICAgICAnY2Jp
dHBvcyc6ICdpbnQnLA0KPj4gLSAgICAgICAgICAgICdyZWR1Y2VkLXBoeXMtYml0cyc6ICdpbnQn
fSwNCj4+ICsgICAgICAgICAgICAncmVkdWNlZC1waHlzLWJpdHMnOiAnaW50JywNCj4+ICsgICAg
ICAgICAgICAnc2V2LW1heC1ndWVzdHMnOiAnaW50J30sDQo+IA0KPiBXb3VsZCBpdCBiZSB1c2Vm
dWwgdG8gbWFrZSB0aGlzIG5ldyBmaWVsZCBvcHRpb25hbD8gRS5nLiBpZiBpdCB3YXMNCj4gbWlz
c2luZywgbGlidmlydGQgY291bGQgYXNzdW1lICJubyBsaW1pdCIuDQo+IA0KDQpJIGFtIG5vdCBz
dXJlIGlmIHdlIG5lZWQgdG8gbWFrZSB0aGlzIGZpZWxkIG9wdGlvbmFsIC0gbWFpbmx5IGJlY2F1
c2UNCmluIFNFViBjb250ZXh0IGhhcmR3YXJlIHdpbGwgYWx3YXlzIGhhdmUgc29tZSBsaW1pdHMg
KGF0IGxlYXN0IGluDQpmb3Jlc2VlYWJsZSBmdXR1cmUpLiBUaGUgYXJjaGl0ZWN0dXJlIHByb3Zp
ZGVzIHVzIGEgQ1BVSUQgdG8gcXVlcnkNCnRoaXMgY2FwYWJpbGl0aWVzIHNvIEkgYW0gYXNzdW1p
bmcgdGhhdCBmdXR1cmUgQ1BVcyB3aWxsIHBvcHVsYXRlDQpzb21lIHZhbHVlcyBpbiBpdC4NCg0K
PiBBZ2Fpbiwgbm90IHN1cmUgaWYgdGhhdCdzIHVzZWZ1bCwgYnV0IGl0J3Mgbm90IGhhcmQgdG8g
aW50cm9kdWNlIHRoZQ0KPiBmaWVsZCBhcyBvcHRpb25hbCBub3cuIFJlbW92aW5nIG1hbmRhdG9y
eSBmaWVsZHMgbGF0ZXIgaXMgaW1wb3NzaWJsZS4NCj4gDQoNCg==

