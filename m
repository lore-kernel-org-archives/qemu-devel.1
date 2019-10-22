Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C82CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D96521783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TR7nJPnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D96521783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuAf-0006fQ-Fh
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iMu8s-0005UU-15
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iMu8q-0004FT-35
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:24:05 -0400
Received: from mail-eopbgr30111.outbound.protection.outlook.com
 ([40.107.3.111]:41985 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iMu8p-00048C-CP; Tue, 22 Oct 2019 09:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg/2V11kXOcnxtNI35DSiLT8muccwj2kheKvEq/MB+OEhzZfZ40JjdHMfGrqsvkjGl/h/1a2WtRWU+brM/fEOgABaT1KJ1u2AA71jBTRsLAFiSLAjPwBQlVggSgTzGE+Ycx/uTzBMX1lOUaKuR4A2qytULiaIhFPNUjmWStIBdYycVlPhcfxRusN5LVMEqjHI2Wxr7dcmI3rTK8acjPISC7tRIYVdgBrVIzEPgk7y2dnBjZzQlry4Rd7UF7RRVmzA6B4LpjYBD1hC6b7dNw7nduMOpdC5vYAI6nooRx9iE3uqfK2TdYl+irdg6+QMNfP6HDV6R8fEr6HCwMZvQH3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rwEg666dqLMp6s5CDyV0sjRbAqSc5NZnr6h3iqrli0=;
 b=RELkSZRPE3PuHw9ZIT+gftOvAXO5X4FCsAroC2fevZUMQPP/cTF5V7TadDMtXtXukIRfuRgZKpLiW8F7WP7FxM9G3cfZ4Fx2/36QXRJBkkaSOMe4i+HiL1g1Nvibz7WcHsud8eTd0H/ywZTcWldgdHCqULhdb6SAjVX7aDIfJ5JNH+CFKmPm+6U9EIfjTtwewPIEKdgxoTWJdbvWp+pNQGgiHZtowdrVwao75WULngOmdUnqnqkraUX1KNqOvSFhmMssyviZiaNhmduSjgWnKVRbBNX3Batsb1pO5nIeGPx39Yi67y6+Rq1YFWvknjTtVZJn7rbjYMB/aZTzuCPAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rwEg666dqLMp6s5CDyV0sjRbAqSc5NZnr6h3iqrli0=;
 b=TR7nJPnLuvqUUunKh+OW9BaSKsZqxXR2Xi7dRkwOuKVkgcm3Bs1FuiDwnmQ1uwKy/SVYLUcYQT+mAzlGx3wVadVRhyWS7hj5796mH0UrA0y0BLcQ8hSAj5kCQfppMWV3lUfEVVnsOssyI5OWoBZW0Em/0GsSL+Lqauc0uSZ4XFU=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3812.eurprd08.prod.outlook.com (20.178.21.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Tue, 22 Oct 2019 13:24:00 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::cb5:43e:b23f:9618]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::cb5:43e:b23f:9618%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 13:24:00 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Thread-Topic: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Thread-Index: AQHVhaz+7x8iUD8wDUy+y9mCSVwunqdgfsuAgARfzQCAAadPgIAAHi4AgAAG2ACAAAGjgA==
Date: Tue, 22 Oct 2019 13:24:00 +0000
Message-ID: <e135e69f-72ab-2865-6646-12a8c83d082b@virtuozzo.com>
References: <20191018120950.26849-1-dplotnikov@virtuozzo.com>
 <2b6cc2fe-5269-71ab-9f0b-1ab36d4dc050@redhat.com>
 <f5d689f6-4b23-8314-f92a-294ffcb6721b@virtuozzo.com>
 <bd5e9f28-d11b-982d-d2be-53b16186eeaa@redhat.com>
 <12dab583-cc5e-f790-a77b-b0476f2aa1d1@virtuozzo.com>
 <f012a789-bd2a-11fc-141c-ba6e9e256687@redhat.com>
In-Reply-To: <f012a789-bd2a-11fc-141c-ba6e9e256687@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0050.eurprd04.prod.outlook.com
 (2603:10a6:3:19::18) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.34.161.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dc5152f-d4b9-42f6-7846-08d756f31973
x-ms-traffictypediagnostic: AM0PR08MB3812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB381248B29B2F3820F519BA94CF680@AM0PR08MB3812.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(136003)(376002)(39840400004)(346002)(51914003)(199004)(189003)(2616005)(476003)(99286004)(81166006)(4326008)(6486002)(6512007)(6246003)(186003)(6506007)(71200400001)(71190400001)(386003)(53546011)(6436002)(11346002)(52116002)(446003)(8936002)(107886003)(26005)(229853002)(102836004)(81156014)(8676002)(76176011)(256004)(486006)(14444005)(5024004)(2501003)(66476007)(25786009)(54906003)(66556008)(86362001)(305945005)(64756008)(3846002)(66946007)(66446008)(110136005)(36756003)(316002)(478600001)(5660300002)(14454004)(66066001)(31696002)(2906002)(6116002)(31686004)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3812;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rhl/x0jQUSBCOGDjJ6/gT/AOzYrlZ2usoaf7B7SDKoHaKzY3mB+B4ICHf2Wv2aCncK+Qlo4c7ahQFFaNBpW0yz5e/LgRBXgpFFJzN6ZkTAZtbVTcgag6Na+3UPNEzCPYqSesoOWBuhPzD+RTu0eOTTA9BPYOwIJF28mE50WWjV9sWNyGjpvECD5VQvpaQgsZNDA71Gu+11zOvo59MJtAjC/AviDiFWuNEDvt8eO6MxG9QsyVN0I3ccjpf7UDeMLecRdMHn0AilCSeNoOnxc+CBQSXXQNbXuQW9vHame3AhgFYH3l2V0ufMnnOp7jnyMozoAYiLcaacg2fXShDf/sbuxmIgopuGft+RAcN6H+1N2ZcPV3z3QnFL1vBbSe2/CoCxQxz7wlMmu1IUFSZpEMPaPK4lbMHn0WbAoqoapsbWSEW149/z2KUFivzmfZzlqd
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A79FC1A64F45144B5C2DAEA589E5F9F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc5152f-d4b9-42f6-7846-08d756f31973
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 13:24:00.4811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +K8BRXpADXtK1LKISkPsqzgDkUBJtpJn15biBt5ql+x/1gFIu22etgzoYTcUrGr8+OJhwRRVKzSHWXIJNHhqmCKQ8kOHtD2gCNp6IDk6rWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3812
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.111
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiAyMi4xMC4yMDE5IDE2OjE4LCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDIyLjEwLjE5IDE0
OjUzLCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+PiBPbiAyMi4xMC4yMDE5IDE0OjA1LCBNYXgg
UmVpdHogd3JvdGU6DQo+Pj4gT24gMjEuMTAuMTkgMDg6NTAsIERlbmlzIFBsb3RuaWtvdiB3cm90
ZToNCj4+Pj4gT24gMTguMTAuMjAxOSAxODowMiwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+Pj4gT24g
MTguMTAuMTkgMTQ6MDksIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4+Pj4+PiBUaGUgbW9kaWZp
Y2F0aW9uIGlzIHVzZWZ1bCB0byB3b3JrYXJvdW5kIGV4Y2x1c2l2ZSBmaWxlIGFjY2VzcyByZXN0
cmljdGlvbnMsDQo+Pj4+Pj4gZS5nLiB0byBpbXBsZW1lbnQgVk0gbWlncmF0aW9uIHdpdGggc2hh
cmVkIGRpc2sgc3RvcmVkIG9uIGEgc3RvcmFnZSB3aXRoDQo+Pj4+Pj4gdGhlIGV4Y2x1c2l2ZSBm
aWxlIG9wZW5pbmcgbW9kZWw6IGEgZGVzdGluYXRpb24gVk0gaXMgc3RhcnRlZCB3YWl0aW5nIGZv
cg0KPj4+Pj4+IGluY29tbWluZyBtaWdyYXRpb24gd2l0aCBhIGZha2UgaW1hZ2UgZHJpdmUsIGFu
ZCBsYXRlciwgb24gdGhlIGxhc3QgbWlncmF0aW9uDQo+Pj4+Pj4gcGhhc2UsIHRoZSBmYWtlIGlt
YWdlIGZpbGUgaXMgcmVwbGFjZWQgd2l0aCB0aGUgcmVhbCBvbmUuDQo+Pj4+Pj4NCj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBEZW5pcyBQbG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpvLmNvbT4N
Cj4+Pj4+IElzbuKAmXQgdGhpcyB3aGF0IHdlIHdvdWxkIHdhbnQgdG8gdXNlIHJlb3BlbiBmb3I/
DQo+Pj4+Pg0KPj4+Pj4gTWF4DQo+Pj4+IENvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IGlz
ICJ1c2UgcmVvcGVuIj8NCj4+PiBJIHdhcyB0aGlua2luZyBvZiB1c2luZyAoeC0pYmxvY2tkZXYt
cmVvcGVuIHRvIGNoYW5nZSB0aGUgZmlsZSB0aGF0IGlzDQo+Pj4gdXNlZCBieSB0aGUgZm9ybWF0
IG5vZGUgKGUuZy4gZnJvbSBhIG51bGwtY28gbm9kZSB0byBhIHJlYWwgZmlsZSk7IG9yIHRvDQo+
Pj4gY2hhbmdlIHRoZSBmaWxlbmFtZSBvZiB0aGUgcHJvdG9jb2wgbm9kZS4NCj4+Pg0KPj4+IEtl
dmluIGhhcyBwb2ludGVkIG91dCAob24gSVJDKSB0aGF0IHRoaXMgd2lsbCBub3QgYWxsb3cgeW91
IHRvIGNoYW5nZQ0KPj4+IHRoZSBub2RlIHRoYXQgaXMgZGlyZWN0bHkgYXR0YWNoZWQgdG8gdGhl
IGRldmljZS4gIFdoaWxlIEkgZG9u4oCZdCBrbm93DQo+Pj4gd2hldGhlciB0aGF04oCZcyByZWFs
bHkgbmVjZXNzYXJ5IGluIHRoaXMgY2FzZSwgaWYgaXQgd2VyZSBpbmRlZWQNCj4+PiBuZWNlc3Nh
cnksIEnigJlkIHByZWZlciBhIG1ldGhvZCB0byBjaGFuZ2UgYSBndWVzdCBkZXZpY2XigJlzIEBk
cml2ZSBvcHRpb24NCj4+PiBiZWNhdXNlIHRoYXQgc2VlbXMgbW9yZSBuYXR1cmFsIHRvIG1lLg0K
Pj4+DQo+Pj4gSW4gY29udHJhc3QsIHRoZSBhcHByb2FjaCB0YWtlbiBpbiB0aGlzIHBhdGNoIHNl
ZW1zIG5vdCBxdWl0ZSByaWdodCB0bw0KPj4+IG1lLCBiZWNhdXNlIGl0IG92ZXJsb2FkcyB0aGUg
d2hvbGUgYmxvY2tkZXYtY2hhbmdlLW1lZGl1bSBjb21tYW5kIHdpdGggYQ0KPj4+IGNvbXBsZXRl
bHkgbmV3IGFuZCBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb24gYmFzZWQgb24gd2hldGhlciB0aGVy
ZeKAmXMgYQ0KPj4+IHJlbW92YWJsZSBtZWRpdW0gb3Igbm90LiAgSWYgdGhlIGltcGxlbWVudGF0
aW9uIGlzIHNvIGRpZmZlcmVudCAoYW5kIHRoZQ0KPj4+IGludGVyZmFjZSBpcywgdG9vLCBiZWNh
dXNlIGluIG9uZSBwYXRoIHlvdSBtdXN0IGdpdmUgQG1lZGl1bSB3aGVyZWFzIHRoZQ0KPj4+IG90
aGVyIGRvZXNu4oCZdCBldmFsdWF0ZSBpdCBhdCBhbGwpLCBpdCBzaG91bGQgYmUgYSBuZXcgY29t
bWFuZC4NCj4+Pg0KPj4+IEkgZG9u4oCZdCBrbm93IHdoZXRoZXIgd2UgbmVlZCBhIG5ldyBjb21t
YW5kIGF0IGFsbCwgdGhvdWdoLiAgT24gdGhlIG5vZGUNCj4+PiBsZXZlbCwgd2UgaGF2ZSAoeC0p
YmxvY2tkZXYtcmVvcGVuLiAgU28gYXNzdW1pbmcgd2UgbmVlZCBzb21ldGhpbmcgdG8NCj4+PiBj
aGFuZ2UgdGhlIGxpbmsgYmV0d2VlbiB0aGUgZ3Vlc3QgZGV2aWNlIGFuZCB0aGUgYmxvY2sgbGF5
ZXIsIEkgd29uZGVyDQo+Pj4gd2hldGhlciB0aGVyZSBpc27igJl0IHNvbWV0aGluZyBzaW1pbGFy
OyBzcGVjaWZpY2FsbHksIEnigJlkIHByZWZlcg0KPj4+IHNvbWV0aGluZyB0byBzaW1wbHkgY2hh
bmdlIHRoZSBkZXZpY2XigJlzIEBkcml2ZSBvcHRpb24uDQo+Pj4NCj4+PiBLZXZpbiBoYXMgcG9p
bnRlZCBvdXQgKG9uIElSQyBhZ2FpbikgdGhhdCB0aGVyZSBpcyBpbmRlZWQgb25lIHN1Y2gNCj4+
PiBjb21tYW5kLCBhbmQgdGhhdOKAmXMgcW9tLXNldC4gIFVuZm9ydHVuYXRlbHksIHRoaXMgaXMg
d2hhdCBoYXBwZW5zIGlmIHlvdQ0KPj4+IHRyeSB0byB1c2UgaXQgZm9yIEBkcml2ZToNCj4+Pg0K
Pj4+IHsiZXJyb3IiOiB7ImNsYXNzIjogIkdlbmVyaWNFcnJvciIsICJkZXNjIjogIkF0dGVtcHQg
dG8gc2V0IHByb3BlcnR5DQo+Pj4gJ2RyaXZlJyBvbiBhbm9ueW1vdXMgZGV2aWNlICh0eXBlICd2
aXJ0aW8tYmxrLWRldmljZScpIGFmdGVyIGl0IHdhcw0KPj4+IHJlYWxpemVkIn19DQo+Pj4NCj4+
PiBIb3dldmVyLCBLZXZpbiBoYXMgY2xhaW1lZCBpdCB3b3VsZCBiZSB0ZWNobmljYWxseSBwb3Nz
aWJsZSB0byBtYWtlIGFuDQo+Pj4gZXhjZXB0aW9uIGZvciBAZHJpdmUuICBNYXliZSB0aGlzIGlz
IHdvcnRoIGludmVzdGlnYXRpbmc/DQo+PiBJcyB0aGVyZSBhbnkgZ3Vlc3MgaG93IGNvbXBsZXgg
aXQgbWlnaHQgYmU/IEluIHRoZSBjYXNlIGlmIGl0J3MgcXVpdGUNCj4+IGNvbXBsZXggbWF5IGJl
IGl0J3Mgd29ydGggdG8gbWFrZSB0aGUgc2VwYXJhdGUgY29tbWFuZD8NCj4gSSBjYW4gdHJhbnNs
YXRlIHRoZSBjaGF0IGxvZyBmb3IgeW91Og0KPg0KPiA8a2V2aW4+IEluIHRoZW9yeSB0aGF04oCZ
cyBjYWxsZWQgcW9tLXNldA0KPiA8a2V2aW4+IEhvd2V2ZXIsIEkgYmVsaWV2ZSBpdCBkb2VzbuKA
mXQgc3VwcG9ydCBxZGV2IHByb3BlcnRpZXMNCj4gPGtldmluPiBIbSwgYnV0IHRoYXQgY291bGQg
YmUgY2hhbmdlZCBzcGVjaWZpY2FsbHkgZm9yIHRoZSBkcml2ZSBwcm9wZXJ0eQ0KPiA8a2V2aW4+
IHFkZXYga2VlcHMgY29uZnVzaW5nIG1lLiAgRHJpdmUgaXNu4oCZdCBzdXBwb3NlZCB0byBjYWxs
DQo+IHFkZXZfcHJvcF9zZXRfYWZ0ZXJfcmVhbGl6ZSgpLCBidXQgdGhlIGVycm9yIG1lc3NhZ2Xi
gJlzIHN0aWxsIHRoZXJlLg0KPiBXaGVyZSBpcyB0aGF0IGhpZGRlbiBjYWxsLi4uPw0KPiA8a2V2
aW4+IEFoLCBzZXRfcG9pbnRlcigpIGRvZXMNCj4gPGtldmluPiBZZXMsIHRoZW4gaXQgc2hvdWxk
IGJlIHBvc3NpYmxlIHRvIG1ha2UgdGhhdCB3b3JrIHJhdGhlciBsb2NhbGx5DQo+DQo+IEFuZCB0
aGF0IHRvb2sgaGltIGFib3V0IDEwIG1pbnV0ZXMuDQo+DQo+IFNvIEkgc3VwcG9zZSBpdCB3b3Vs
ZCBiZSB0byBjaGVjayBpbiBzZXRfZHJpdmUoKSBhbmQNCj4gc2V0X2RyaXZlX2lvdGhyZWFkKCkg
d2hldGhlciB0aGUgZGV2aWNlIGlzIGFscmVhZHkgcmVhbGl6ZWQsIGFuZCBpZiBzbywNCj4gZGl2
ZXJ0IGl0IHRvIHNvbWUgb3RoZXIgZnVuY3Rpb24gdGhhdCBkb2VzIHRoZSBydW50aW1lIGNoYW5n
ZT8NCm9rLCB0aGF0IG1pZ2h0IGJlIGEgZ29vZCBzdGFydGluZyBwb2ludCBmb3IgbWUuIFRoYW5r
cy4NCj4NCj4gKE5vIGlkZWEgaG93IHRoZSBxZGV2IG1haW50YWluZXJzIHRoaW5rIGFib3V0IGRv
aW5nIHRoYXQgaW4gc2V0X2RyaXZlKCkNCj4gYW5kIHNldF9kcml2ZV9pb3RocmVhZCgpLCB0aG91
Z2gpDQo+DQo+Pj4gKEFzIGZvciBibG9ja2Rldi1jaGFuZ2UtbWVkaXVtLCBhcyBJ4oCZdmUgc2Fp
ZCwgSSBkb27igJl0IHJlYWxseSB0aGluayB0aGlzDQo+Pj4gZml0cyB0aGVyZS4gIEZ1cnRoZXJt
b3JlLCBibG9ja2Rldi1jaGFuZ2UtbWVkaXVtIGlzIGtpbmQgb2YgYSBsZWdhY3kNCj4+PiBjb21t
YW5kIGJlY2F1c2UgSSB0aGluayBldmVyeSBjb21tYW5kIGJ1dCBibG9ja2Rldi1hZGQgdGhhdCBk
b2VzIGENCj4+PiBiZHJ2X29wZW4oKSBraW5kIG9mIGlzIGEgbGVnYWN5IGNvbW1hbmQuDQo+PiBP
dXQgb2YgY3VyaW9zaXR5LCBjb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gd2h5IGl0J3MgZGVjaWRl
ZCB0byBiZSBzbz8NCj4gQmVjYXVzZSB3ZSBoYXZlIGJsb2NrZGV2LWFkZCwgd2hpY2ggc3VwcG9y
dHMgYWxsIGJsb2NrIGRldmljZSBvcHRpb25zDQo+IHRoZXJlIGFyZSBhbmQgc28gb24uICBibG9j
a2Rldi1jaGFuZ2UtbWVkaXVtICh3aGljaCBpcyBiYXNpY2FsbHkganVzdCBhDQo+IG1vcmUgcmln
aWQg4oCcY2hhbmdl4oCdKSBvbmx5IGdldHMgZmlsZW5hbWUsIHdoaWNoIGlzbuKAmXQgYXMgZXhw
cmVzc2l2ZS4NCj4NCj4gV2UgZ2VuZXJhbGx5IHdhbnQgdXNlcnMgdG8gYWRkIG5ldyBub2RlcyB3
aXRoIGJsb2NrZGV2LWFkZCBhbmQgbGV0IGFsbA0KPiBvdGhlciBjb21tYW5kcyBvbmx5IHRha2Ug
bm9kZS1uYW1lcy4NCj4NCj4gKFRoZXJl4oCZcyBhbHNvIHRoZSBmYWN0IHRoYXQgaGlzdG9yaWNh
bGx5IHdl4oCZdmUgdXNlZCBmaWxlbmFtZXMgdG8NCj4gaWRlbnRpZnkgQmxvY2tEcml2ZXJTdGF0
ZXMsIGJ1dCB0aGF0IGRvZXNu4oCZdCB3b3JrIHNvIHdlbGwuICBUaHVzIEkgdGhpbmsNCj4gd2Ug
c2hvdWxkIGdldCBhd2F5IGZyb20gdXNpbmcgZmlsZW5hbWVzIGFzIG11Y2ggYXMgd2UgY2FuIHNv
IHBlb3BsZQ0KPiBkb27igJl0IHVzZSB0aGVtIGZvciBpZGVudGlmaWNhdGlvbiBhZ2Fpbi4pDQo+
DQo+IE1heA0KDQpUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbiwgTWF4IQ0KDQpEZW5pcw0KDQo+
DQo=

