Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00439C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 00:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79B82067D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 00:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79B82067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy41c-0005rs-S7
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 20:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <BROGERS@suse.com>) id 1hy40m-0005Rq-Js
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 20:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1hy40j-0002oi-IC
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 20:53:02 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:57882)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1hy40h-0002mB-BE
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 20:52:59 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY
 m4a0039g.houston.softwaregrp.com WITH ESMTP; 
 Thu, 15 Aug 2019 00:52:43 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 15 Aug 2019 00:50:00 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 15 Aug 2019 00:50:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pa8779bqitgZVRhORCSmp0zZiF3dO77swTrtl4iWLYm4vNt6ALwD5J6ZrC5svb85Dh7OPbsmoTTJh4lPDEsWmU1kDmaykqScj72JwklbYKXil15LGFXlcAK/q2fUkHgfUhlHU9Od7Uy5OatPla9pcyMKB/rE7T6P7Tw4K8aA1z1kmg4Xt3aCH/1+o/MPUgKIvFviFJSAZL4AFTJJE3VdeglqlOvuyrwg0puMHni0vPQF3QEXoc56iI2US5nrrMjE6j4l8xIH1pOK8Nk4HhUv5aBH0Wg4u4OGclG61xTI8TYJJO7uCDMm7rwOJvfsm4A0nqOZwLXzlfqcuZe1GLy4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTWzyvGyN/065mN23dhwAxHshB6OQVeepSwFNZu1K1E=;
 b=KcekBdg83qW/+tuwJ38pVZaEmlWao3bzlwoXHBv9VjBt4rq+Mf5ZZvmJKqVaYuck+og9fNCM121iZDf4HPxfqrhkkUQf/JxYEPLQ8fZwVfPozLAjm+kkKfghkvQeZ2OjANQEhPCKX8hY7tTjJhmWRpy2/maL/q1JksmjJ2KigzbtQeudrLPlfxHfp143cDxd4pDfnQng/XJRIoNVLhw45FyJo/u+S9SpG9zunq6OL6SumBvhWPAv2czIab1cyLafMyqbknqcZP+J6wIIGcr6GlQqs51STSw4Z8oeYktZu1YVhBIDrV47ciZ4SM6VbA/dYVuOvvUAvL+Gd1FJj0M81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3096.namprd18.prod.outlook.com (10.255.155.222) by
 CH2PR18MB3287.namprd18.prod.outlook.com (52.132.247.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Thu, 15 Aug 2019 00:49:58 +0000
Received: from CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::54ad:4562:f961:5610]) by CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::54ad:4562:f961:5610%3]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 00:49:58 +0000
From: Bruce Rogers <BROGERS@suse.com>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: current QEMU can't start pc-q35-2.12  SEV guest
Thread-Index: AQHVUwNccBcqwdRS4UOs8Xi34penKg==
Date: Thu, 15 Aug 2019 00:49:58 +0000
Message-ID: <89368c9df9e960ead712227ac8dd3e1793c164b0.camel@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=BROGERS@suse.com; 
x-originating-ip: [63.248.144.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ee1f55d-5cd8-435a-2729-08d7211a7f84
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CH2PR18MB3287; 
x-ms-traffictypediagnostic: CH2PR18MB3287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB3287B9360CFD776ED096303FD9AC0@CH2PR18MB3287.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(199004)(189003)(14454004)(5660300002)(478600001)(3846002)(2501003)(6116002)(99286004)(53936002)(6436002)(4326008)(36756003)(86362001)(110136005)(2201001)(91956017)(71200400001)(64756008)(66066001)(6486002)(476003)(66446008)(8936002)(76116006)(25786009)(118296001)(66946007)(486006)(2906002)(66556008)(316002)(66476007)(71190400001)(6512007)(6506007)(8676002)(7736002)(81166006)(186003)(26005)(305945005)(102836004)(107886003)(81156014)(2616005)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR18MB3287;
 H:CH2PR18MB3096.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6AHbairO8yotJA9EF1Dazr6mjRs/Y2jyCMxrhCb5jPucEtyFCQR/Pha1FXO8u9/oblX3FLxrrpARVJzvcF3PiDWc+W++C3DIcWR6/+jvtEE6pzmk/g5BPYL+2638l7u1hx12bUuFQKkg/0NqXitFxy/7vZ3tbQyO5tLmkZuyOyNxCGOT5LYK+lE69i5m3qQHmkAf4WY8qPxaHR6pesJZGoLmE3EFNQFZ+PQqsrh+nSqBLzIlUADFnJHK1VEph3ViknTsOc0B1pVLkHlLwtNirOaZewZq2p7MKey2IcdT2fR5+yGL2RYQ18xf50qIrQbb5zKUxJsSppt2nhie0eqWwvJ9NpQg5n33UEC4imdjLyA75Lkp0Wjeqf4+2neSJcxVLWyoVBBI+621AHcWhWongGXvi2OYUhhgC2ybkT7G570=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74EFDA7D16439E4B802BB1B05E469DE9@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee1f55d-5cd8-435a-2729-08d7211a7f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 00:49:58.7008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4Wl/AHRh7KH5x+1cHIOdkb8+hsbbcBotVMwdU7VuMD5znX+oz1kRamqgn/sVG+629Mt+yXyj4SO3YBCoRBuSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3287
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 15.124.2.85
Subject: [Qemu-devel] current QEMU can't start pc-q35-2.12  SEV guest
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
Cc: Liang Yan <LYan@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksDQoNCkkgcmFuIGludG8gYSBjYXNlIHdoZXJlIGEgZ3Vlc3Qgb24gYSBTRVYgY2FwYWJsZSBo
b3N0LCB3aGljaCB3YXMNCmVuYWJsZWQgdG8gdXNlIFNFViBhbmQgdXNpbmcgYW4gb2xkZXIgbWFj
aGluZSB0eXBlIHdhcyBubyBsb25nZXIgYWJsZQ0KdG8gcnVuIHdoZW4gdGhlIFFFTVUgdmVyc2lv
biBoYWQgYmVlbiB1cGRhdGVkLg0KDQpTcGVjaWZpY2FsbHksIHdoZW4gdGhlIGd1ZXN0IHdhcyBp
bnN0YWxsZWQgYW5kIHJ1bm5pbmcgdW5kZXIgYSB2Mi4xMg0KUUVNVSwgc2V0IHVwIGZvciBTRVYg
KG9rIGl0IHdhcyB2Mi4xMSB3aXRoIFNFViBzdXBwb3J0IGJhY2twb3J0ZWQsIGJ1dA0KdGhlIGRl
dGFpbHMgc3RpbGwgYXBwbHkpLCB1c2luZyBhIGNvbW1hbmQgbGluZSBzdWNoIGFzIGZvbGxvd3M6
DQoNCnFlbXUtc3lzdGVtLXg4Nl82NCAtY3B1IEVQWUMtSUJSUyBcDQotbWFjaGluZSBwYy1xMzUt
Mi4xMixhY2NlbD1rdm0sbWVtb3J5LWVuY3J5cHRpb249c2V2MCBcDQotb2JqZWN0IHNldi1ndWVz
dCxpZD1zZXYwLC4uLg0KDQpUaGUgZ3Vlc3QgcmFuIGZpbmUsIHVzaW5nIFNFViBtZW1vcnkgZW5y
eXB0aW9uLg0KDQpMYXRlciB0aGUgdmVyc2lvbiBvZiBRRU1VIHdhcyB1cGRhdGVkIHRvIHYzLjEu
MCwgYW5kIHRoZSBzYW1lIGd1ZXN0IG5vdw0KaHVuZyBhdCBib290LCB3aGVuIHVzaW5nIHRoZSBl
eGFjdCBzYW1lIGNvbW1hbmQgbGluZS4gKEN1cnJlbnQgUUVNVQ0Kc3RpbGwgaGFzIHRoZSBzYW1l
IHByb2JsZW0uKQ0KDQpVcG9uIGludmVzdGlnYXRpb24sIEkgZmluZCB0aGF0IHRoZSBoYW5kbGlu
ZyBvZiB4bGV2ZWwgaW4NCnRhcmdldC9pMzg2L2NwdS5jIHJlbGllcyBpbmNsdWRlcyBhbiBleHBs
aWNpdCBkZXRlY3Rpb24gb2YgU0VWIGJlaW5nDQplbmFibGVkIGFuZCBzZXRzIHRoZSBjcHVpZF9t
aW5feGxldmVsIGluIHRoZSBDUFVYODZTdGF0ZSBzdHJ1Y3R1cmUgdG8NCjB4ODAwMDAwMUYgYXMg
dGhlIHJlcXVpcmVkIG1pbmltdW0gZm9yIFNFViBzdXBwb3J0LiBUaGlzIG5vcm1hbGx5IGlzDQp1
c2VkIHRvIHNldCB0aGUgeGxldmVsIHRoZSBndWVzdCBzZWVzLCBhbGxvd2luZyBpdCB0byB1c2Ug
U0VWLg0KDQpUaGUgY29tcGF0IHNldHRpbmdzIGZvciB0aGUgdjIuMTIgbWFjaGluZSB0eXBlIGlu
Y2x1ZGUgYW4geGxldmVsIHZhbHVlDQphc3NvY2lhdGVkIHdpdGggaXQgKDB4ODAwMDAwMEEpLiBV
bmZvcnR1bmF0ZWx5IHRoZSBwcm9jZXNzaW5nIG9mIHRoZQ0KY29tcGF0IHNldHRpbmdzIGdldHMg
Y29uZmxhdGVkIHdpdGggdGhlIGxvZ2ljIG9mIGhhbmRsaW5nIGEgdXNlcg0KZXhwbGljaXRseSBz
cGVjaWZ5aW5nIGFuIHhsZXZlbCBvbiB0aGUgY29tbWFuZCBsaW5lLCB3aGljaCBpcyB0cmVhdGVk
DQphcyBhbiAib3ZlcnJpZGUiIGNvbmRpdGlvbiwgb3ZlcnJpZGluZyB0aGUgb3RoZXIgeGxldmVs
IHNlbGVjdGlvbnMNCndoaWNoIHdvdWxkIG90aGVyd2lzZSBiZSBkb25lIGluIHRoZSBRRU1VIGNw
dSBjb2RlLg0KDQpTbywgaW4gdGhlIHNjZW5hcmlvIEkgZGVzY3JpYmUgYWJvdmUsIHRoZSBvcmln
aW5hbCwgd29ya2luZyBjYXNlIHdvdWxkDQpwcm92aWRlIGFuIGNwdWlkIHhsZXZlbCB2YWx1ZSBv
ZiAweDgwMDAwMDFGIHRvIHRoZSBndWVzdCAoY29ycmVjdCksIGFuZA0KdGhlIGZhaWxpbmcgY2Fz
ZSBlbmRzIHVwIHByb3ZpZGluZyB0aGUgdmFsdWUgMHg4MDAwMDAwQSAoaW5jb3JyZWN0KS4NCg0K
SXQgc2VlbXMgdG8gbWUgdGhhdCB0aGUgaGFuZGxpbmcgb2YgdGhlIGNvbXBhdCBzZXR0aW5ncyBh
bmQgdGhlDQpleHBsaWNpdCB4bGV2ZWwgc2V0dGluZyBieSB0aGUgdXNlciBzaG91bGQgYmUgcHJv
Y2Vzc2VkIHNlcGFyYXRlbHksIGJ1dA0KSSBkb24ndCBzZWUgaG93IHRvIGRvIHRoYXQgZWFzaWx5
Lg0KDQpIb3cgc2hvdWxkIHRoaXMgcHJvYmxlbSBiZSByZXNvbHZlZD8NCg0KSW4gbXkgY2FzZSwg
SSd2ZSBhZGRlZCB0byB0aGUgY29kZSB3aGljaCBpcyBmb3IgY2hlY2tpbmcgYSB1c2VyDQpwcm92
aWRlZCB4bGV2ZWwgdmFsdWUsIHRoZSBjaGVjayBhZ2FpbiBmb3Igc2V2X2VuYWJsZWQoKSwgYW5k
IGlmIHRoYXQncw0KdGhlIGNhc2UsIEkgc3RpbGwgYXBwbHkgdGhlIGNwdWlkX21pbl94bGV2ZWwg
dmFsdWUuIFRoaXMgd29ya3MgZm9yIHRoZQ0KdGltZSBiZWluZywgYnV0IGRvZXNuJ3Qgc2VlbSB0
byBiZSB0aGUgcmlnaHQgc29sdXRpb24uDQoNCkxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIGhlbHAg
d2l0aCB0aGlzIGlzc3VlLg0KDQpUaGFua3MsDQoNCkJydWNlDQo=

