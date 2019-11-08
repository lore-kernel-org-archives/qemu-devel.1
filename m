Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9371CC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 07:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1122178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 07:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nqmhKArF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1122178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSywW-0007e6-GU
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 02:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iSyvb-00075E-Ai
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 02:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iSyva-0002Kd-4P
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 02:43:31 -0500
Received: from mail-eopbgr80120.outbound.protection.outlook.com
 ([40.107.8.120]:48770 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iSyvV-0002B9-QF; Fri, 08 Nov 2019 02:43:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUlW3aD0Npb/13JwLjVYCIE/o/IWdZ98YO4S4Hz8aXo6nV/GQqkRqzPmeRL/F6sc5+eLulV20OLhENNRqEZbCQz5FZ6tSUN21uLXIf8LkhT2TiyVRoNY1mBRloaidgfz3FGbkHbciDUMUDb+TuesnKMK+xOGPFpd2jqjpEJYlLmkKGhUe4lf7icz6GkxD2U97M64lbKQtlU8+o+c5jd9dh5qginO7OL5NkouxwODU6k0NhxobEB6ijeOOTLbgfBvQq/rwzGP6cf14cHEoJBQ3toJULCpfFj3f+jtWNQsIGrdFPilrozy1p29Ods8sSXB4agiAFRcrrE+s8S6+fc8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hauTAmgWKjbaSIRffpE85cTUSEfnqAj+bs9IEtSU4rk=;
 b=iilwYCMWHrtTRdK08TgNbqEN4dLqDL/4bFLWJCLzL7sVcrSXCN/Odn2eTzlN8BSurQVWdS1h3Vq1FKpmsQ5z2KNg2hbgGXx6pqmwYVMP2qeBqatGoS85jRTBXXNzyEc+C3l5vhd5Y4saG7djTUdyGf7Qh42hX+EgaQ8fIOopPMphm2+FmDPqnEOj3IZuuIxGumduv2ugQ565+gkFfU9TqmvnaarYTDVZ1pSmsuRj/ygqrvWbfBTicGRHRkyNVQpdcHky80DpZMB3tNRGALhXU+RBNWF4w8haRt6E0ptQBs4SbjhHDYO93lPlTJC048qskDFrOhtVr4wLg1Q6WxWq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hauTAmgWKjbaSIRffpE85cTUSEfnqAj+bs9IEtSU4rk=;
 b=nqmhKArF642clPeJA10hM0BNQIpHBSsa2Q2uPiECJ37/ltQtnw/E9czCeehUfKy3Qa+PjNlgv6Mseze8zu3TERw1D9im972P9KncuUlIYce25ut8eF9o1IMDLWLBSTooaoPueYhWjGieI4MTkeOO4+Kckm9D34dj+wo3ZYpMBRM=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3506.eurprd08.prod.outlook.com (20.177.109.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Fri, 8 Nov 2019 07:43:22 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa%4]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 07:43:22 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Denis Lunev <den@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: make seg_max virtqueue size dependent
Thread-Topic: [PATCH v1 2/4] virtio: make seg_max virtqueue size dependent
Thread-Index: AQHVk/Q0QdV+LHyEBU6JOvppcJBmgqd9DZyAgADeWQCAAB3xAIAC3pAA
Date: Fri, 8 Nov 2019 07:43:22 +0000
Message-ID: <6204623b-2448-8362-0434-d96372d30b65@virtuozzo.com>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-3-dplotnikov@virtuozzo.com>
 <20191105155033-mutt-send-email-mst@kernel.org>
 <c32d94d1-a216-dd9e-e0cf-dee2730169e4@virtuozzo.com>
 <20191106065142-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191106065142-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:7:66::12) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.138.10.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81866e4b-cb46-42a8-0b1e-08d7641f5489
x-ms-traffictypediagnostic: AM0PR08MB3506:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3506CD9D243F1BA472150CECCF7B0@AM0PR08MB3506.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(376002)(346002)(39840400004)(136003)(189003)(199004)(478600001)(36756003)(14454004)(229853002)(99286004)(52116002)(7736002)(31696002)(256004)(6116002)(31686004)(4326008)(25786009)(3846002)(6636002)(2906002)(8936002)(14444005)(186003)(26005)(316002)(66066001)(54906003)(86362001)(66556008)(76176011)(476003)(305945005)(6486002)(71190400001)(81156014)(66946007)(6506007)(66476007)(110136005)(64756008)(53546011)(66446008)(71200400001)(102836004)(386003)(5660300002)(81166006)(446003)(6246003)(6512007)(486006)(6436002)(2616005)(8676002)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3506;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/hffrpMd+L3JK0r+RfbPFKnGGWHaCupEg8lXMofRtlk+esMEb8pLv1V1DIzwZOO/lrMngbWwWYsHZs0k0TFtqM5f1NUePCh8SiEW5fqS2GH8kEa3hVUfHNB6ErFWquxU34mG+bPMx7BwqWDp9s7I+tHwPCVR2MtZcvtSBe/9eWNa7Du1hUbWOHA5fpsJ2H7JSa4t521FzXqi+e5W6U4w9X4dUZZP6gW6k14RW9ootS1fH2wiCKeU2cabfvf33cactrSFMrPqkUn8rGhfkwoN/Z/ySIymk0+KYTS8qUtc8cmmOjHPp0TxH2WrYRcCvRUfM6yL9qL676cIK55X0eAATKSs98iTrui8AqMv6KKwX/b6u9FT8G7LkAD9hvE8uGUbj6DWbwa3R+TzL0wFG1oyj/OQjR1ONvTntgZA73n1Nly0PAnsSwZHG1Vd13mU1+f
Content-Type: text/plain; charset="utf-8"
Content-ID: <14E7C17E54902748B980466216B6A251@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81866e4b-cb46-42a8-0b1e-08d7641f5489
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 07:43:22.3114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6OOiOZzqpzyPP2WDkvNmE5RPGmlVKS19gq6rm64SslRlK9P4bG79XBTP9i59ISSlmJloq7kisj7wsIjxbn+zvxLLWbipew1F3j+RuFfMcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3506
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.120
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIDFzdCBwYXRjaCBmcm9tIHRoZSBzZXJpZXMgc2VlbXMgdG8gYmUgdXNlbGVzcy4gVGhlIHBh
dGNoIGV4dGVuZGluZyANCnF1ZXVlIGxlbmd0aCBieSBhZGRpbmcgbWFjaGluZSB0eXBlIG1heSBi
cmVhayB2bS1zIHdoaWNoIHVzZSBzZWFiaW9zIA0Kd2l0aCBtYXggcXVldWUgc2l6ZSA9IDEyOC4N
Cg0KTG9va3MgbGlrZSBvbmx5IHRoaXMgcGF0Y2ggZG9lc24ndCBicmVhayBhbnl0aGluZyBhbmQg
aGVscHMgdG8gZXhwcmVzcyANCnF1ZXVlIHNpemUgYW5kIHNlZyBtYXggZGVwZW5kZW5jeSAodGhl
IHNwZWNpZmljYXRpb24gY29uc3RyYWludCkgDQpleHBsaWNpdGx5LiBTbywgSSB3b3VsZCBsaWtl
IHRvIHJlLXNlbmQgdGhpcyBwYXRjaCBhcyBhIHN0YW5kYWxvbmUgb25lIA0KYW5kIHNlbmQgb3Ro
ZXIgcGF0Y2hlcyBpbmNsdWRpbmcgdGhlIHRlc3QgbGF0ZXIsIHdoZW4gd2UgYWxsIGFncmVlIG9u
IA0KaG93IGV4YWN0bHkgdG8gZGVhbCB3aXRoIGlzc3VlcyBwb3N0ZWQgaW4gdGhlIHRocmVhZC4N
Cg0KQW55IG9iamVjdGlvbnMgYXJlIHdlbGNvbWUuDQoNCkRlbmlzDQoNCk9uIDA2LjExLjIwMTkg
MTQ6NTQsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gT24gV2VkLCBOb3YgMDYsIDIwMTkg
YXQgMTA6MDc6MDJBTSArMDAwMCwgRGVuaXMgTHVuZXYgd3JvdGU6DQo+PiBPbiAxMS81LzE5IDk6
NTEgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4+PiBPbiBUdWUsIE5vdiAwNSwgMjAx
OSBhdCAwNzoxMTowM1BNICswMzAwLCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+Pj4+IHNlZ19t
YXggaGFzIGEgcmVzdHJpY3Rpb24gdG8gYmUgbGVzcyBvciBlcXVhbCB0byB2aXJ0cXVldWUgc2l6
ZQ0KPj4+PiBhY2NvcmRpbmcgdG8gVmlydGlvIDEuMCBzcGVjaWZpY2F0aW9uDQo+Pj4+DQo+Pj4+
IEFsdGhvdWdoIHNlZ19tYXggY2FuJ3QgYmUgc2V0IGRpcmVjdGx5LCBpdCdzIHdvcnRoIHRvIGV4
cHJlc3MgdGhpcw0KPj4+PiBkZXBlbmRhbmN5IGRpcmVjdGx5IGluIHRoZSBjb2RlIGZvciBzYW5p
dHkgcHVycG9zZS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogRGVuaXMgUGxvdG5pa292IDxk
cGxvdG5pa292QHZpcnR1b3p6by5jb20+DQo+Pj4gVGhpcyBpcyBndWVzdCB2aXNpYmxlIHNvIG5l
ZWRzIHRvIGJlIG1hY2hpbmUgdHlwZSBkZXBlbmRlbnQsIHJpZ2h0Pw0KPj4gd2UgaGF2ZSBkaXNj
dXNzZWQgdGhpcyB2ZXJiYWxseSB3aXRoIFN0ZWZhbiBhbmQgdGhpbmsgdGhhdA0KPj4gdGhlcmUg
aXMgbm8gbmVlZCB0byBhZGQgdGhhdCB0byB0aGUgbWFjaGluZSB0eXBlIGFzOg0KPj4NCj4+IC0g
b3JpZ2luYWwgZGVmYXVsdCB3YXMgMTI2LCB3aGljaCBtYXRjaGVzIDEyOCBhcyBxdWV1ZQ0KPj4g
IMKgIGxlbmd0aCBpbiBvbGQgbWFjaGluZSB0eXBlcw0KPj4gLSBxdWV1ZSBsZW5ndGggPiAxMjgg
aXMgbm90IG9ic2VydmVkIGluIHRoZSBmaWVsZCBhcw0KPj4gIMKgIFNlYUJpb3MgaGFzIHF1aXJr
IHRoYXQgYXNzZXJ0cw0KPiBXZWxsIHRoYXQncyBqdXN0IHRoZSBTZWFCaW9zIHZpcnRpbyBkcml2
ZXIuIE5vdCBldmVyeW9uZSdzIHVzaW5nIHRoYXQgdG8NCj4gZHJpdmUgdGhlaXIgZGV2aWNlcy4N
Cj4NCj4+IC0gaWYgcXVldWUgbGVuZ3RoIHdpbGwgYmUgc2V0IHRvIHNvbWV0aGluZyA8IDEyOCAt
IGxpbnV4DQo+PiAgwqAgZ3Vlc3Qgd2lsbCBjcmFzaA0KPiBBZ2FpbiB0aGF0J3MganVzdCBvbmUg
Z3Vlc3QgZHJpdmVyLiBOb3QgZXZlcnlvbmUgaXMgdXNpbmcgdGhhdCBlaXRoZXIuDQo+DQo+DQo+
PiBJZiB3ZSByZWFsbHkgbmVlZCB0byBwcmVzZXJ2ZSBvcmlnaW5hbCBfX2J1Z2d5X18gYmVoYXZp
b3IgLQ0KPj4gd2UgY2FuIGFkZCBib29sZWFuIHByb3BlcnR5LCBwbHMgbGV0IHVzIGtub3cuDQo+
Pg0KPj4gRGVuDQo+IExvb2tzIGxpa2Ugc29tZSBkcml2ZXJzIGFyZSBidWdneSBidXQgSSdtIG5v
dCBzdXJlIGl0J3MNCj4gdGhlIHNhbWUgYXMgc2F5aW5nIHRoZSBiZWhhdmlvciBpcyBidWdneS4N
Cj4gU28geWVzLCBJJ2Qgc2F5IGl0J3MgcHJlZmVyYWJsZSB0byBiZSBjb21wYXRpYmxlLg0KPg0K
Pg0KPj4+PiAtLS0NCj4+Pj4gICBody9ibG9jay92aXJ0aW8tYmxrLmMgfCAyICstDQo+Pj4+ICAg
aHcvc2NzaS92aXJ0aW8tc2NzaS5jIHwgMiArLQ0KPj4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcv
YmxvY2svdmlydGlvLWJsay5jIGIvaHcvYmxvY2svdmlydGlvLWJsay5jDQo+Pj4+IGluZGV4IDA2
ZTU3YTRkMzkuLjIxNTMwMzA0Y2YgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2Jsb2NrL3ZpcnRpby1i
bGsuYw0KPj4+PiArKysgYi9ody9ibG9jay92aXJ0aW8tYmxrLmMNCj4+Pj4gQEAgLTkwMyw3ICs5
MDMsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fYmxrX3VwZGF0ZV9jb25maWcoVmlydElPRGV2aWNl
ICp2ZGV2LCB1aW50OF90ICpjb25maWcpDQo+Pj4+ICAgICAgIGJsa19nZXRfZ2VvbWV0cnkocy0+
YmxrLCAmY2FwYWNpdHkpOw0KPj4+PiAgICAgICBtZW1zZXQoJmJsa2NmZywgMCwgc2l6ZW9mKGJs
a2NmZykpOw0KPj4+PiAgICAgICB2aXJ0aW9fc3RxX3AodmRldiwgJmJsa2NmZy5jYXBhY2l0eSwg
Y2FwYWNpdHkpOw0KPj4+PiAtICAgIHZpcnRpb19zdGxfcCh2ZGV2LCAmYmxrY2ZnLnNlZ19tYXgs
IDEyOCAtIDIpOw0KPj4+PiArICAgIHZpcnRpb19zdGxfcCh2ZGV2LCAmYmxrY2ZnLnNlZ19tYXgs
IHMtPmNvbmYucXVldWVfc2l6ZSAtIDIpOw0KPj4+PiAgICAgICB2aXJ0aW9fc3R3X3AodmRldiwg
JmJsa2NmZy5nZW9tZXRyeS5jeWxpbmRlcnMsIGNvbmYtPmN5bHMpOw0KPj4+PiAgICAgICB2aXJ0
aW9fc3RsX3AodmRldiwgJmJsa2NmZy5ibGtfc2l6ZSwgYmxrX3NpemUpOw0KPj4+PiAgICAgICB2
aXJ0aW9fc3R3X3AodmRldiwgJmJsa2NmZy5taW5faW9fc2l6ZSwgY29uZi0+bWluX2lvX3NpemUg
LyBibGtfc2l6ZSk7DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9zY3NpL3ZpcnRpby1zY3NpLmMgYi9o
dy9zY3NpL3ZpcnRpby1zY3NpLmMNCj4+Pj4gaW5kZXggODM5ZjEyMDI1Ni4uZjdlNTUzM2NkNSAx
MDA2NDQNCj4+Pj4gLS0tIGEvaHcvc2NzaS92aXJ0aW8tc2NzaS5jDQo+Pj4+ICsrKyBiL2h3L3Nj
c2kvdmlydGlvLXNjc2kuYw0KPj4+PiBAQCAtNjUwLDcgKzY1MCw3IEBAIHN0YXRpYyB2b2lkIHZp
cnRpb19zY3NpX2dldF9jb25maWcoVmlydElPRGV2aWNlICp2ZGV2LA0KPj4+PiAgICAgICBWaXJ0
SU9TQ1NJQ29tbW9uICpzID0gVklSVElPX1NDU0lfQ09NTU9OKHZkZXYpOw0KPj4+PiAgIA0KPj4+
PiAgICAgICB2aXJ0aW9fc3RsX3AodmRldiwgJnNjc2ljb25mLT5udW1fcXVldWVzLCBzLT5jb25m
Lm51bV9xdWV1ZXMpOw0KPj4+PiAtICAgIHZpcnRpb19zdGxfcCh2ZGV2LCAmc2NzaWNvbmYtPnNl
Z19tYXgsIDEyOCAtIDIpOw0KPj4+PiArICAgIHZpcnRpb19zdGxfcCh2ZGV2LCAmc2NzaWNvbmYt
PnNlZ19tYXgsIHMtPmNvbmYudmlydHF1ZXVlX3NpemUgLSAyKTsNCj4+Pj4gICAgICAgdmlydGlv
X3N0bF9wKHZkZXYsICZzY3NpY29uZi0+bWF4X3NlY3RvcnMsIHMtPmNvbmYubWF4X3NlY3RvcnMp
Ow0KPj4+PiAgICAgICB2aXJ0aW9fc3RsX3AodmRldiwgJnNjc2ljb25mLT5jbWRfcGVyX2x1biwg
cy0+Y29uZi5jbWRfcGVyX2x1bik7DQo+Pj4+ICAgICAgIHZpcnRpb19zdGxfcCh2ZGV2LCAmc2Nz
aWNvbmYtPmV2ZW50X2luZm9fc2l6ZSwgc2l6ZW9mKFZpcnRJT1NDU0lFdmVudCkpOw0KPj4+PiAt
LSANCj4+Pj4gMi4xNy4wDQo=

