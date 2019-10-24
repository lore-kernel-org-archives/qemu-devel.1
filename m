Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BEDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570F320663
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570F320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhA1-0002NP-OS
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <BROGERS@suse.com>) id 1iNgYk-0000RG-8O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1iNgYh-0007HE-0O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:06:00 -0400
Received: from m9a0001g.houston.softwaregrp.com ([15.124.64.66]:53151)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1iNgYg-00079t-QI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:05:58 -0400
Received: FROM m9a0001g.houston.softwaregrp.com (15.121.0.191) BY
 m9a0001g.houston.softwaregrp.com WITH ESMTP; 
 Thu, 24 Oct 2019 17:05:12 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 24 Oct 2019 16:58:30 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 24 Oct 2019 16:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np1OL267kPUxL/VhNGy3Fqrtvef5xc7L7y9x0z3vjQKwOz2H9UIyDrHBGfLMiAj7Zhz/Eamof+3u3YqGd4G/J98wZy72SJR/bzwUl9cvH173csYW3cAyFDneqkuysgPwSN6PGyFWCl0ZHiHl28zvSXv8AOJ8isjhiWecYQMNhh8xjCyjVpFRJzJumbDLyRBTs2v+d6I8lRGQSla0ZT/2qJB2FqAr+87q8BrQuepfZfUQfC1CruYR6ITgOsmS4+gj1rWT1XRnGOKYCLXM3Ai9/MsioCC6FzncEIPzuEkY0ZevDSxyB9xIpFLWCJ5dM/8tagP7rIpvuec50zNTUU/tqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUmSjlz9Ypyg8yqcWh7GBF1Pm9ZFtd+FuNE8X1MbVJg=;
 b=G1RNJiKi1GwX80G4wptNUnAjZnaszEcFxn5Vj/g5MB9uCGMwRaEBu73fExu0w6WS1285e9XkWqoyPU4DfK3JhWuVp7vuGELLiZOq3MV57O7NJBWO1igN64IOV2fE/jUJwC5aHQ9hxVp4IWmX95uzxUBsYqGYBWIda/ktdIKjULUk+BYAZJFtMPO8cpPjVcgV6er08eVilues6jZXwdL9seaFaHGWNXSmECMFogQuXKCvIVwKszbb+rvi97PgR/9oLKNbdYSEYgrUnaMAev4FyDBnsfH5Q9GL/ZK+6wqvGsPDb0BOumpFyV+r+Vy5ELNhaHxAK9nq7DEEiqhczx18kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DM6PR18MB3098.namprd18.prod.outlook.com (10.255.76.27) by
 DM6PR18MB2363.namprd18.prod.outlook.com (20.179.71.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 16:58:28 +0000
Received: from DM6PR18MB3098.namprd18.prod.outlook.com
 ([fe80::a8e4:1c30:1300:226a]) by DM6PR18MB3098.namprd18.prod.outlook.com
 ([fe80::a8e4:1c30:1300:226a%3]) with mapi id 15.20.2387.021; Thu, 24 Oct 2019
 16:58:28 +0000
From: Bruce Rogers <BROGERS@suse.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "cathy.zhang@intel.com"
 <cathy.zhang@intel.com>
Subject: Re: [Resend PATCH 3/3] i386: Add new CPU model Cooperlake
Thread-Topic: [Resend PATCH 3/3] i386: Add new CPU model Cooperlake
Thread-Index: AQHViKwscuW931on8USLJe+MArUTzKdqBymA
Date: Thu, 24 Oct 2019 16:58:28 +0000
Message-ID: <90b0d32431df459f8961bd7f515c0fdfab2dc0aa.camel@suse.com>
References: <1571729728-23284-1-git-send-email-cathy.zhang@intel.com>
 <1571729728-23284-4-git-send-email-cathy.zhang@intel.com>
In-Reply-To: <1571729728-23284-4-git-send-email-cathy.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=BROGERS@suse.com; 
x-originating-ip: [137.65.185.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24f3ce24-07b8-49d6-28ee-08d758a3646d
x-ms-traffictypediagnostic: DM6PR18MB2363:
x-microsoft-antispam-prvs: <DM6PR18MB23630CACEA08E03BE803EFECD96A0@DM6PR18MB2363.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(199004)(189003)(25786009)(66946007)(99286004)(71200400001)(14454004)(256004)(478600001)(486006)(81156014)(8676002)(7736002)(36756003)(305945005)(229853002)(71190400001)(81166006)(8936002)(6486002)(476003)(6246003)(6436002)(5660300002)(6512007)(11346002)(2616005)(4326008)(110136005)(76176011)(86362001)(26005)(102836004)(186003)(6506007)(446003)(118296001)(66066001)(316002)(2906002)(76116006)(91956017)(66446008)(64756008)(66476007)(66556008)(6116002)(3846002)(4001150100001)(2501003)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR18MB2363;
 H:DM6PR18MB3098.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4oUIDSN00IALN003kXu+8X8eDiBNUnEYWda0JL6awoCykCQABbFGpNVNDhkpX1LZh5JmKLrruJIMJ8Sg/7AnU+jRpVUGfNpYsEjg71yPKpy3wBMkh+JHVmaMKrjL62L/LUPXtMYoYfrlY1VtbIyEfChNJnRrcW1drW7K0FNZNB9U7sEWjkqmyWp+lTq/5JWlvXbNvGsh9EXv9hYGrFdWVE0/+bv48uvtRByxhGhzE/Y6Akzilza5bxtpjJZWdz/P8BWDxjXYjOKhgzZgLTiVVf6Y30y6gQ1gB0Dv0a5vdK5Tqq19ouVEmX+r5DTi+7lGf07mFHbRHlFz4da17Ubh6ouWpuh2/YrbwaPavj+T114vf1E6QVHF+LHRAnx7DE18iFfeBsSGCdjOqZQEXa2k6VNlF+07BHXGvtzy9Kl4/bpJudprodbgeLdKfrVwruOI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E31497934EBE594599950EE9AE52645E@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f3ce24-07b8-49d6-28ee-08d758a3646d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 16:58:28.3453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2jtwP/jhfFp54SZKtKxb4eHizRDpNpdTRJuJodiL70ajK+QakJSDD5vGa2l7+fwGW3nakZ7EwuV3UnL9frAIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2363
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.64.66
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVHVlLCAyMDE5LTEwLTIyIGF0IDE1OjM1ICswODAwLCBDYXRoeSBaaGFuZyB3cm90ZToNCj4g
Q29vcGVyIExha2UgaXMgaW50ZWwncyBzdWNjZXNzb3IgdG8gQ2FzY2FkZSBMYWtlLCB0aGUgbmV3
DQo+IENQVSBtb2RlbCBpbmhlcml0cyBmZWF0dXJlcyBmcm9tIENhc2NhZGVsYWtlLVNlcnZlciwg
d2hpbGUNCj4gYWRkIG9uZSBwbGF0Zm9ybSBhc3NvY2lhdGVkIG5ldyBmZWF0dXJlOiBBVlg1MTJf
QkYxNi4gTWVhbndoaWxlLA0KPiBhZGQgU1RJQlAgZm9yIHNwZWN1bGF0aXZlIGV4ZWN1dGlvbi4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IENhdGh5IFpoYW5nIDxjYXRoeS56aGFuZ0BpbnRlbC5jb20+
DQo+IFJldmlld2VkLWJ5OiBYaWFveWFvIExpIDx4aWFveWFvLmxpQGludGVsLmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IFRhbyBYdSA8dGFvMy54dUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgdGFyZ2V0L2kz
ODYvY3B1LmMgfCA2MA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2NwdS5jIGIvdGFyZ2V0L2kzODYvY3B1LmMNCj4g
aW5kZXggNDRmMWJiZC4uNjMwYTE5MCAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2kzODYvY3B1LmMN
Cj4gKysrIGIvdGFyZ2V0L2kzODYvY3B1LmMNCj4gQEAgLTI2MTIsNiArMjYxMiw2NiBAQCBzdGF0
aWMgWDg2Q1BVRGVmaW5pdGlvbiBidWlsdGluX3g4Nl9kZWZzW10gPSB7DQo+ICAgICAgICAgIH0N
Cj4gICAgICB9LA0KPiAgICAgIHsNCj4gKyAgICAgICAgLm5hbWUgPSAiQ29vcGVybGFrZSIsDQo+
ICsgICAgICAgIC5sZXZlbCA9IDB4ZCwNCj4gKyAgICAgICAgLnZlbmRvciA9IENQVUlEX1ZFTkRP
Ul9JTlRFTCwNCj4gKyAgICAgICAgLmZhbWlseSA9IDYsDQo+ICsgICAgICAgIC5tb2RlbCA9IDg1
LA0KPiArICAgICAgICAuc3RlcHBpbmcgPSAxMCwNCj4gKyAgICAgICAgLmZlYXR1cmVzW0ZFQVRf
MV9FRFhdID0NCj4gKyAgICAgICAgICAgIENQVUlEX1ZNRSB8IENQVUlEX1NTRTIgfCBDUFVJRF9T
U0UgfCBDUFVJRF9GWFNSIHwNCj4gQ1BVSURfTU1YIHwNCj4gKyAgICAgICAgICAgIENQVUlEX0NM
RkxVU0ggfCBDUFVJRF9QU0UzNiB8IENQVUlEX1BBVCB8IENQVUlEX0NNT1YgfA0KPiBDUFVJRF9N
Q0EgfA0KPiArICAgICAgICAgICAgQ1BVSURfUEdFIHwgQ1BVSURfTVRSUiB8IENQVUlEX1NFUCB8
IENQVUlEX0FQSUMgfA0KPiBDUFVJRF9DWDggfA0KPiArICAgICAgICAgICAgQ1BVSURfTUNFIHwg
Q1BVSURfUEFFIHwgQ1BVSURfTVNSIHwgQ1BVSURfVFNDIHwNCj4gQ1BVSURfUFNFIHwNCj4gKyAg
ICAgICAgICAgIENQVUlEX0RFIHwgQ1BVSURfRlA4NywNCj4gKyAgICAgICAgLmZlYXR1cmVzW0ZF
QVRfMV9FQ1hdID0NCj4gKyAgICAgICAgICAgIENQVUlEX0VYVF9BVlggfCBDUFVJRF9FWFRfWFNB
VkUgfCBDUFVJRF9FWFRfQUVTIHwNCj4gKyAgICAgICAgICAgIENQVUlEX0VYVF9QT1BDTlQgfCBD
UFVJRF9FWFRfWDJBUElDIHwgQ1BVSURfRVhUX1NTRTQyIHwNCj4gKyAgICAgICAgICAgIENQVUlE
X0VYVF9TU0U0MSB8IENQVUlEX0VYVF9DWDE2IHwgQ1BVSURfRVhUX1NTU0UzIHwNCj4gKyAgICAg
ICAgICAgIENQVUlEX0VYVF9QQ0xNVUxRRFEgfCBDUFVJRF9FWFRfU1NFMyB8DQo+ICsgICAgICAg
ICAgICBDUFVJRF9FWFRfVFNDX0RFQURMSU5FX1RJTUVSIHwgQ1BVSURfRVhUX0ZNQSB8DQo+IENQ
VUlEX0VYVF9NT1ZCRSB8DQo+ICsgICAgICAgICAgICBDUFVJRF9FWFRfUENJRCB8IENQVUlEX0VY
VF9GMTZDIHwgQ1BVSURfRVhUX1JEUkFORCwNCj4gKyAgICAgICAgLmZlYXR1cmVzW0ZFQVRfODAw
MF8wMDAxX0VEWF0gPQ0KPiArICAgICAgICAgICAgQ1BVSURfRVhUMl9MTSB8IENQVUlEX0VYVDJf
UERQRTFHQiB8IENQVUlEX0VYVDJfUkRUU0NQIHwNCj4gKyAgICAgICAgICAgIENQVUlEX0VYVDJf
TlggfCBDUFVJRF9FWFQyX1NZU0NBTEwsDQo+ICsgICAgICAgIC5mZWF0dXJlc1tGRUFUXzgwMDBf
MDAwMV9FQ1hdID0NCj4gKyAgICAgICAgICAgIENQVUlEX0VYVDNfQUJNIHwgQ1BVSURfRVhUM19M
QUhGX0xNIHwNCj4gQ1BVSURfRVhUM18zRE5PV1BSRUZFVENILA0KPiArICAgICAgICAuZmVhdHVy
ZXNbRkVBVF83XzBfRUJYXSA9DQo+ICsgICAgICAgICAgICBDUFVJRF83XzBfRUJYX0ZTR1NCQVNF
IHwgQ1BVSURfN18wX0VCWF9CTUkxIHwNCj4gKyAgICAgICAgICAgIENQVUlEXzdfMF9FQlhfSExF
IHwgQ1BVSURfN18wX0VCWF9BVlgyIHwNCj4gQ1BVSURfN18wX0VCWF9TTUVQIHwNCj4gKyAgICAg
ICAgICAgIENQVUlEXzdfMF9FQlhfQk1JMiB8IENQVUlEXzdfMF9FQlhfRVJNUyB8DQo+IENQVUlE
XzdfMF9FQlhfSU5WUENJRCB8DQo+ICsgICAgICAgICAgICBDUFVJRF83XzBfRUJYX1JUTSB8IENQ
VUlEXzdfMF9FQlhfUkRTRUVEIHwNCj4gQ1BVSURfN18wX0VCWF9BRFggfA0KPiArICAgICAgICAg
ICAgQ1BVSURfN18wX0VCWF9TTUFQIHwgQ1BVSURfN18wX0VCWF9DTFdCIHwNCj4gKyAgICAgICAg
ICAgIENQVUlEXzdfMF9FQlhfQVZYNTEyRiB8IENQVUlEXzdfMF9FQlhfQVZYNTEyRFEgfA0KPiAr
ICAgICAgICAgICAgQ1BVSURfN18wX0VCWF9BVlg1MTJCVyB8IENQVUlEXzdfMF9FQlhfQVZYNTEy
Q0QgfA0KPiArICAgICAgICAgICAgQ1BVSURfN18wX0VCWF9BVlg1MTJWTCB8IENQVUlEXzdfMF9F
QlhfQ0xGTFVTSE9QVCwNCj4gKyAgICAgICAgLmZlYXR1cmVzW0ZFQVRfN18wX0VDWF0gPQ0KPiAr
ICAgICAgICAgICAgQ1BVSURfN18wX0VDWF9QS1UgfA0KPiArICAgICAgICAgICAgQ1BVSURfN18w
X0VDWF9BVlg1MTJWTk5JLA0KPiArICAgICAgICAuZmVhdHVyZXNbRkVBVF83XzBfRURYXSA9DQo+
ICsgICAgICAgICAgICBDUFVJRF83XzBfRURYX1NQRUNfQ1RSTCB8IENQVUlEXzdfMF9FRFhfU1RJ
QlAgfA0KPiArICAgICAgICAgICAgQ1BVSURfN18wX0VEWF9TUEVDX0NUUkxfU1NCRCB8DQo+IENQ
VUlEXzdfMF9FRFhfQVJDSF9DQVBBQklMSVRJRVMsDQo+ICsgICAgICAgIC5mZWF0dXJlc1tGRUFU
X0FSQ0hfQ0FQQUJJTElUSUVTXSA9DQo+ICsgICAgICAgICAgICBNU1JfQVJDSF9DQVBfUkRDTF9O
TyB8IE1TUl9BUkNIX0NBUF9JQlJTX0FMTCB8DQo+ICsgICAgICAgICAgICBNU1JfQVJDSF9DQVBf
U0tJUF9MMURGTF9WTUVOVFJZIHwgTVNSX0FSQ0hfQ0FQX01EU19OTywNCj4gKyAgICAgICAgLmZl
YXR1cmVzW0ZFQVRfN18xX0VBWF0gPQ0KPiArICAgICAgICAgICAgQ1BVSURfN18xX0VBWF9BVlg1
MTJfQkYxNiwNCj4gKyAgICAgICAgLyoNCj4gKyAgICAgICAgICogTWlzc2luZzogWFNBVkVTIChu
b3Qgc3VwcG9ydGVkIGJ5IHNvbWUgTGludXggdmVyc2lvbnMsDQo+ICsgICAgICAgICAqIGluY2x1
ZGluZyB2NC4xIHRvIHY0LjEyKS4NCj4gKyAgICAgICAgICogS1ZNIGRvZXNuJ3QgeWV0IGV4cG9z
ZSBhbnkgWFNBVkVTIHN0YXRlIHNhdmUgY29tcG9uZW50LA0KPiArICAgICAgICAgKiBhbmQgdGhl
IG9ubHkgb25lIGRlZmluZWQgaW4gU2t5bGFrZSAocHJvY2Vzc29yIHRyYWNpbmcpDQo+ICsgICAg
ICAgICAqIHByb2JhYmx5IHdpbGwgYmxvY2sgbWlncmF0aW9uIGFueXdheS4NCj4gKyAgICAgICAg
ICovDQo+ICsgICAgICAgIC5mZWF0dXJlc1tGRUFUX1hTQVZFXSA9DQo+ICsgICAgICAgICAgICBD
UFVJRF9YU0FWRV9YU0FWRU9QVCB8IENQVUlEX1hTQVZFX1hTQVZFQyB8DQo+ICsgICAgICAgICAg
ICBDUFVJRF9YU0FWRV9YR0VUQlYxLA0KPiArICAgICAgICAuZmVhdHVyZXNbRkVBVF82X0VBWF0g
PQ0KPiArICAgICAgICAgICAgQ1BVSURfNl9FQVhfQVJBVCwNCj4gKyAgICAgICAgLnhsZXZlbCA9
IDB4ODAwMDAwMDgsDQo+ICsgICAgICAgIC5tb2RlbF9pZCA9ICJJbnRlbCBYZW9uIFByb2Nlc3Nv
ciAoQ29vcGVybGFrZSkiLA0KPiArICAgIH0sDQo+ICsgICAgew0KPiAgICAgICAgICAubmFtZSA9
ICJJY2VsYWtlLUNsaWVudCIsDQo+ICAgICAgICAgIC5sZXZlbCA9IDB4ZCwNCj4gICAgICAgICAg
LnZlbmRvciA9IENQVUlEX1ZFTkRPUl9JTlRFTCwNCg0KTG9va3MgZmluZSB0byBtZS4NCg0KUmV2
aWV3ZWQtYnk6IEJydWNlIFJvZ2VycyA8YnJvZ2Vyc0BzdXNlLmNvbT4NCg0KLSBCcnVjZQ0K

