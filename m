Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A78C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949B5206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mWcMSVwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949B5206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5nWL-0006a3-Ic
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 04:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i5nVU-00064d-5C
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i5nVR-0001Wf-JY
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:52:43 -0400
Received: from mail-eopbgr20109.outbound.protection.outlook.com
 ([40.107.2.109]:51105 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i5nVQ-0001Vh-OM; Thu, 05 Sep 2019 04:52:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P76SNsN0BJkDuG6sFNb5akEPvEiPD3FoL74q4uTT1zUiNORHWQz2AoGMFUZUZ6Pf754XbtHS9aK8so8UN+JZ0DP4qIo1AhSVPQzTXBH/eUoWk6b/A5+j57TeLIEZwkNWy2Gm1OHzdXA00CD0ZLqHs8FwZdyp4OXtPexgtGxMxeTr8tUa2AhHFfB+Lrck7TA+iJEB7vfkvXo/vr7TgEaFv4grO7fifs7ZWQkzmnBaWtuhJnRLrRyWP2dGn4l0ekmwbgDs+6Z9WyRRQ0Fe5psaWyFmzC86XwQN9Hyo89ZFlZy/1C0D2aBsJuwIOktZQ9y36jDUWPhZtLW5ai4TYwPvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JHs0taa9h48BQ+6qmSP2rBxr56WsHmjp97jWDyoApY=;
 b=YXgUaYyCpp6SbCw1JVEH3OZ7rIACqyfvQ63t98NxY8iT0Dh5yeCNCMpx9/XGMYG3i8I9QNebxnUsfMaiKq+svwIVNlb/rlg6tV+/X5vpvnUbBqNa0vJPucX2+BXJqotf0RCB9AaLlX58ds4mqdS6KYkFI2fLYTNWrCUVdzaSMu085voUh1j1isaQyYty99zOqMwf6HHbKPy74EaQem6Pzwggy6vZ8tTHhB9DnqlxgExMnMHtinCiB9TwUPH9YKV0jZOcmkcnj2I5ILtT0CWDL2ZMWxnOhUw6czsAymCvmx4+Oa4QTUUa7YIdIVCHm26ptBrsBUKGTxY19a3B+wFNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JHs0taa9h48BQ+6qmSP2rBxr56WsHmjp97jWDyoApY=;
 b=mWcMSVwVX02dso1oAZlzQPYMXofuFIFTwrQraoPHrZt6LPlZQa82er8gcCrAHxHzO8pDImO0ZK8z3pJXUhtLUN3E/vPI5arXxbBfZnL/T8IEQK4du9sFoqooLPyJLUvRrTL0WSxJ3HfINc9jkTJdA3s5ZcGJDBCkoczSj6Sroeo=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4145.eurprd08.prod.outlook.com (20.178.203.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 5 Sep 2019 08:52:37 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31%5]) with mapi id 15.20.2241.014; Thu, 5 Sep 2019
 08:52:37 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 3/3] qcow2: add zstd cluster compression
Thread-Index: AQHVYzruEZDsZDoirUyQ0IuQtSHLpKccyBEA
Date: Thu, 5 Sep 2019 08:52:37 +0000
Message-ID: <180075f5-2b55-22dd-e95a-5224e1d5dfef@virtuozzo.com>
References: <20190904152915.30755-1-dplotnikov@virtuozzo.com>
 <20190904152915.30755-4-dplotnikov@virtuozzo.com>
 <2ff3dc82-ea8c-10a8-fb4c-8081abc3775e@redhat.com>
In-Reply-To: <2ff3dc82-ea8c-10a8-fb4c-8081abc3775e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-originating-ip: [31.180.210.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 403efa88-50ec-459c-bd6e-08d731de6707
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4145; 
x-ms-traffictypediagnostic: AM0PR08MB4145:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB41455F5D1F534568F2201F28CFBB0@AM0PR08MB4145.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(305945005)(8676002)(7736002)(25786009)(2906002)(229853002)(99286004)(486006)(76176011)(2616005)(2501003)(19273905006)(446003)(11346002)(6512007)(316002)(53936002)(54906003)(31686004)(53376002)(6246003)(66476007)(66556008)(64756008)(66446008)(4326008)(66946007)(5660300002)(110136005)(81166006)(81156014)(76116006)(26005)(2201001)(256004)(14444005)(71200400001)(36756003)(186003)(3846002)(66066001)(6506007)(53546011)(102836004)(71190400001)(6116002)(8936002)(6486002)(478600001)(476003)(86362001)(14454004)(31696002)(6306002)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4145;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X6V27tdqr+txOMXQa35a3MQLYk5aW1VhQgsImYCgueILyuarYPEpiFVyqX3dBXxDiN30WO57TKr3o114stlrjjNKq/f/hfYSgys2+6HIREFPRIVAyTzMR9ELggPr9ZNZHpFNxPDgpO6BgDB7NvsXlcnfu+g9WtMNR4Gf7qnuFJbpeMCPFWS9x8nVD1nuRkfQcycHeKkpgKwzC0YR4KJVMBLwkN6p0ER/3MAy13YtymWEF1x6TmL9ANT3qXtXbOzjlNUPUOcJA8OcteqKo9dQ72hSfxQ0YThfiRvGNmVNLMJbI2z5hinfvcMnK9RCMICcJMaseJpdqJwMMNxZzy6AcV2taAMIeP6/Dk9E0HTiFIrysy3d9N0sBnGF5REuQ1lnkwF/hZS0PhXIyUA5qD0krgYA8L5EJHlleywtLJIpPJ4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EB07B0629BD604E8D84511016A17231@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403efa88-50ec-459c-bd6e-08d731de6707
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 08:52:37.3068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12PjdrbaytNxzyWsdtrjthm3c87hiLfvJJdp/4pkcOkiiM2R3PkNc/3LnAqYFRlWIsatWkpSBQWGtGly7zf2nkaiTaP1mHUNQaFMK1N6S+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.109
Subject: Re: [Qemu-devel] [PATCH v5 3/3] qcow2: add zstd cluster compression
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMDQuMDkuMjAxOSAxOTowNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS80LzE5IDEwOjI5
IEFNLCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+PiB6c3RkIHNpZ25pZmljYW50bHkgcmVkdWNl
cyBjbHVzdGVyIGNvbXByZXNzaW9uIHRpbWUuDQo+PiBJdCBwcm92aWRlcyBiZXR0ZXIgY29tcHJl
c3Npb24gcGVyZm9ybWFuY2UgbWFpbnRhaW5pbmcNCj4+IHRoZSBzYW1lIGxldmVsIG9mIGNvbXBy
ZXNzaW9uIHJhdGlvIGluIGNvbXBhcmlzb24gd2l0aA0KPj4gemxpYiwgd2hpY2gsIGF0IHRoZSBt
b21lbnQsIGhhcyBiZWVuIHRoZSBvbmx5IGNvbXByZXNzaW9uDQo+PiBtZXRob2QgYXZhaWxhYmxl
Lg0KPj4NCj4+IFRoZSBwZXJmb3JtYW5jZSB0ZXN0IHJlc3VsdHM6DQo+PiBUZXN0IGNvbXByZXNz
ZXMgYW5kIGRlY29tcHJlc3NlcyBxZW11IHFjb3cyIGltYWdlIHdpdGgganVzdA0KPj4gaW5zdGFs
bGVkIHJoZWwtNy42IGd1ZXN0Lg0KPj4gSW1hZ2UgY2x1c3RlciBzaXplOiA2NEsuIEltYWdlIG9u
IGRpc2sgc2l6ZTogMi4yRw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IERlbmlzIFBsb3RuaWtvdiA8
ZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiArc3RhdGljIHNzaXplX3QgcWNv
dzJfenN0ZF9jb21wcmVzcyh2b2lkICpkZXN0LCBzaXplX3QgZGVzdF9zaXplLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3Qgc3Jj
X3NpemUpDQo+PiArew0KPj4gKyAgICBzc2l6ZV90IHJldDsNCj4+ICsgICAgdWludDMyX3QgKmNf
c2l6ZSA9IGRlc3Q7DQo+IFBvdGVudGlhbGx5IHVuYWxpZ25lZCBwb2ludGVyLi4uDQo+DQo+PiAr
ICAgIC8qIHN0ZWFsIHNvbWUgYnl0ZXMgdG8gc3RvcmUgY29tcHJlc3NlZCBjaHVuayBzaXplICov
DQo+PiArICAgIGNoYXIgKmRfYnVmID0gKChjaGFyICopIGRlc3QpICsgc2l6ZW9mKCpjX3NpemUp
Ow0KPj4gKw0KPj4gKyAgICAvKiBzYW5pdHkgY2hlY2sgdGhhdCB3ZSBjYW4gc3RvcmUgdGhlIGNv
bXByZXNzZWQgZGF0YSBsZW5ndGggKi8NCj4+ICsgICAgaWYgKGRlc3Rfc2l6ZSA8IHNpemVvZigq
Y19zaXplKSkgew0KPj4gKyAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICsgICAgZGVzdF9zaXplIC09IHNpemVvZigqY19zaXplKTsNCj4+ICsNCj4+ICsgICAgcmV0
ID0gWlNURF9jb21wcmVzcyhkX2J1ZiwgZGVzdF9zaXplLCBzcmMsIHNyY19zaXplLCA1KTsNCj4+
ICsNCj4+ICsgICAgaWYgKFpTVERfaXNFcnJvcihyZXQpKSB7DQo+PiArICAgICAgICBpZiAoWlNU
RF9nZXRFcnJvckNvZGUocmV0KSA9PSBaU1REX2Vycm9yX2RzdFNpemVfdG9vU21hbGwpIHsNCj4+
ICsgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+ICsgICAgICAgIH0gZWxzZSB7DQo+PiAr
ICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+PiArICAgICAgICB9DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICsgICAgLyogc3RvcmUgdGhlIGNvbXByZXNzZWQgY2h1bmsgc2l6ZSBpbiB0aGUgdmVyeSBi
ZWdpbm5pbmcgb2YgdGhlIGJ1ZmZlciAqLw0KPj4gKyAgICAqY19zaXplID0gY3B1X3RvX2JlMzIo
cmV0KTsNCj4gLi4uYW5kIHlvdSBhcmUgc3RvcmluZyBpbnRvIGl0LiAgWW91IGFyZSB1c2luZyB0
aGUgd3JvbmcgY29udmVyc2lvbg0KPiBmdW5jdGlvbjsgeW91IHdhbnQgc3RsX2JlX3AoZGVzdCwg
cmV0KSBvciBzaW1pbGFyLg0KPg0KPj4gK3N0YXRpYyBzc2l6ZV90IHFjb3cyX3pzdGRfZGVjb21w
cmVzcyh2b2lkICpkZXN0LCBzaXplX3QgZGVzdF9zaXplLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBzcmNfc2l6ZSkNCj4+
ICt7DQo+PiArICAgIHNzaXplX3QgcmV0Ow0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiB6c3RkIGRl
Y29tcHJlc3Mgd2FudHMgdG8ga25vdyB0aGUgZXhhY3QgbGVuZ3RoIG9mIHRoZSBkYXRhDQo+PiAr
ICAgICAqIGZvciB0aGF0IHB1cnBvc2UsIG9uIHRoZSBjb21wcmVzc2lvbiB0aGUgbGVuZ3RoIGlz
IHN0b3JlZCBpbg0KPiBzL2RhdGEgZm9yL2RhdGEuIEZvci8NCj4gcy9vbiB0aGUgY29tcHJlc3Np
b24vb24gY29tcHJlc3Npb24sLw0KPg0KPj4gKyAgICAgKiB0aGUgdmVyeSBiZWdpbm5pbmcgb2Yg
dGhlIGNvbXByZXNzZWQgYnVmZmVyDQo+PiArICAgICAqLw0KPj4gKyAgICB1aW50MzJfdCBzX3Np
emU7DQo+PiArICAgIGNvbnN0IGNoYXIgKnNfYnVmID0gKChjb25zdCBjaGFyICopIHNyYykgKyBz
aXplb2Yoc19zaXplKTsNCj4+ICsNCj4+ICsgICAgLyogc2FuaXR5IGNoZWNrIHRoYXQgd2UgY2Fu
IHJlYWQgdGhlIGNvbnRlbnQgbGVuZ3RoICovDQo+PiArICAgIGlmIChzcmNfc2l6ZSA8IHNpemVv
ZihzX3NpemUpKSB7DQo+IFNob3VsZCB0aGlzIHVzZSA8PT8gIEFmdGVyIGFsbCwgSSBzZXJpb3Vz
bHkgZG91YnQgeW91IGNhbiBnZXQgYSAwLWJ5dGUNCj4gY29tcHJlc3Npb24gc3RyZWFtLg0KPg0K
Pj4gKyAgICAgICAgcmV0dXJuIC1FSU87DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgc19zaXpl
ID0gYmUzMl90b19jcHUoKihjb25zdCB1aW50MzJfdCAqKSBzcmMpOw0KPiBBcyB3cml0dGVuLCB0
aGlzIGxvb2tzIGxpa2UgeW91IG1heSBiZSBkZXJlZmVyZW5jaW5nIGFuIHVuYWxpZ25lZA0KPiBw
b2ludGVyLiAgSXQgc28gaGFwcGVucyB0aGF0IGJlMzJfdG9fY3B1KCkgYXBwbGllcyAmIHRvIHlv
dXIgKiB0byBnZXQNCj4gYmFjayBhdCB0aGUgcmF3IHBvaW50ZXIsIGFuZCB0aGVuIGlzIGNhcmVm
dWwgdG8gaGFuZGxlIHVuYWxpZ25lZA0KPiBwb2ludGVycywgc28gaXQgd29ya3M7IGJ1dCBpdCB3
b3VsZCBsb29rIGEgbG90IG5pY2VyIGFzIG1lcmVseToNCj4NCj4gc19zaXplID0gYmUzMl90b19j
cHUoc3JjKTsNCj4NCj4+ICsNCj4+ICsgICAgLyogc2FuaXR5IGNoZWNrIHRoYXQgdGhlIGJ1ZmZl
ciBpcyBiaWcgZW5vdWdoIHRvIHJlYWQgdGhlIGNvbnRlbnQgKi8NCj4+ICsgICAgaWYgKHNyY19z
aXplIC0gc2l6ZW9mKHNfc2l6ZSkgPCBzX3NpemUpIHsNCj4gV2h5IDwgYW5kIG5vdCAhPT8gIEFz
IHdyaXR0ZW4sIHlvdSBhcmUgc2lsZW50bHkgaWdub3JpbmcgdHJhaWxpbmcNCj4gZ2FyYmFnZSwg
aW5zdGVhZCBvZiB0cmVhdGluZyBpdCBhcyBhIGNsaWVudCB0aGF0IGRpZCBub3Qgd3JpdGUgdGhl
IGRhdGENCj4gY29ycmVjdGx5Lg0KDQpidXQgc3JjX3NpemUgKDUxMikgbWlnaHQgYmUgYmlnZ2Vy
IHRoYW4gdGhlIGNvbnRlbnQgb2YgdGhlIGNvbXByZXNzZWQgDQpkYXRhLCBkb24ndCBpdD8NCg0K
RGVuaXMNCg0KPg0KPj4gKysrIGIvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KPj4gQEAgLTE4MSw2
ICsxODEsNyBAQCBpbiB0aGUgZGVzY3JpcHRpb24gb2YgYSBmaWVsZC4NCj4+ICAgICAgICAgICAg
ICAgICAgICAgICBtdXN0IGJlIHNldC4NCj4+ICAgICAgICAgICAgICAgICAgICAgICBBdmFpbGFi
bGUgY29tcHJlc3Npb24gdHlwZSB2YWx1ZXM6DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
IDA6IHpsaWIgPGh0dHBzOi8vd3d3LnpsaWIubmV0Lz4gKGRlZmF1bHQpDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgMTogenN0ZCA8aHR0cDovL2dpdGh1Yi5jb20vZmFjZWJvb2svenN0ZD4N
Cj4gQXQgdGhpcyBwb2ludCwgdGhpcyBsaXN0aW5nIGlzIGFsbW9zdCByZWR1bmRhbnQgd2l0aCB0
aGUgbW9yZS1kZXRhaWxlZA0KPiBoZWFkZXIgYmVsb3cuICBNYXliZSBpdCBpcyB3b3J0aCBqdXN0
IGZvcndhcmQgcmVmZXJlbmNpbmcgdGhhdCBzZWN0aW9uDQo+IGZvciBhIGxpc3Rpbmcgb2YgdmFs
aWQgdmFsdWVzLCBhbmQgdGhlbiBtZW50aW9uaW5nIHRoZSB2YWx1ZXMgMCBhbmQgMSBpbg0KPiB0
aGF0IHNlY3Rpb24/DQo+DQo+PiAgIA0KPj4gICBEaXJlY3RseSBhZnRlciB0aGUgaW1hZ2UgaGVh
ZGVyLCBvcHRpb25hbCBzZWN0aW9ucyBjYWxsZWQgaGVhZGVyIGV4dGVuc2lvbnMgY2FuDQo+PiAg
IGJlIHN0b3JlZC4gRWFjaCBleHRlbnNpb24gaGFzIGEgc3RydWN0dXJlIGxpa2UgdGhlIGZvbGxv
d2luZzoNCj4+IEBAIC01MzYsNiArNTM3LDkgQEAgQ29tcHJlc3NlZCBDbHVzdGVycyBEZXNjcmlw
dG9yICh4ID0gNjIgLSAoY2x1c3Rlcl9iaXRzIC0gOCkpOg0KPj4gICAgICAgICAgICAgICAgICAg
ICAgIEFub3RoZXIgY29tcHJlc3NlZCBjbHVzdGVyIG1heSBtYXAgdG8gdGhlIHRhaWwgb2YgdGhl
IGZpbmFsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgc2VjdG9yIHVzZWQgYnkgdGhpcyBjb21w
cmVzc2VkIGNsdXN0ZXIuDQo+PiAgIA0KPj4gKyAgICAgICAgICAgICAgICAgICAgVGhlIGxheW91
dCBvZiB0aGUgY29tcHJlc3NlZCBkYXRhIGRlcGVuZHMgb24gdGhlIGNvbXByZXNzaW9uDQo+PiAr
ICAgICAgICAgICAgICAgICAgICB0eXBlIHVzZWQgZm9yIHRoZSBpbWFnZSAoc2VlIGNvbXByZXNz
ZWQgY2x1c3RlciBsYXlvdXQpLg0KPj4gKw0KPj4gICBJZiBhIGNsdXN0ZXIgaXMgdW5hbGxvY2F0
ZWQsIHJlYWQgcmVxdWVzdHMgc2hhbGwgcmVhZCB0aGUgZGF0YSBmcm9tIHRoZSBiYWNraW5nDQo+
PiAgIGZpbGUgKGV4Y2VwdCBpZiBiaXQgMCBpbiB0aGUgU3RhbmRhcmQgQ2x1c3RlciBEZXNjcmlw
dG9yIGlzIHNldCkuIElmIHRoZXJlIGlzDQo+PiAgIG5vIGJhY2tpbmcgZmlsZSBvciB0aGUgYmFj
a2luZyBmaWxlIGlzIHNtYWxsZXIgdGhhbiB0aGUgaW1hZ2UsIHRoZXkgc2hhbGwgcmVhZA0KPj4g
QEAgLTc4OCwzICs3OTIsMTkgQEAgSW4gdGhlIGltYWdlIGZpbGUgdGhlICdlbmFibGVkJyBzdGF0
ZSBpcyByZWZsZWN0ZWQgYnkgdGhlICdhdXRvJyBmbGFnLiBJZiB0aGlzDQo+PiAgIGZsYWcgaXMg
c2V0LCB0aGUgc29mdHdhcmUgbXVzdCBjb25zaWRlciB0aGUgYml0bWFwIGFzICdlbmFibGVkJyBh
bmQgc3RhcnQNCj4+ICAgdHJhY2tpbmcgdmlydHVhbCBkaXNrIGNoYW5nZXMgdG8gdGhpcyBiaXRt
YXAgZnJvbSB0aGUgZmlyc3Qgd3JpdGUgdG8gdGhlDQo+PiAgIHZpcnR1YWwgZGlzay4gSWYgdGhp
cyBmbGFnIGlzIG5vdCBzZXQgdGhlbiB0aGUgYml0bWFwIGlzIGRpc2FibGVkLg0KPj4gKw0KPj4g
Kz09PSBDb21wcmVzc2VkIGNsdXN0ZXIgbGF5b3V0ID09PQ0KPiBBcyB3cml0dGVuLCB5b3UgaGF2
ZSBtYWRlIHRoaXMgYSBjaGlsZCB0byAnPT0gQml0bWFwcyA9PScgKGFuZCBzaWJsaW5nDQo+IHRv
ICc9PT0gRGlydHkgdHJhY2tpbmcgYml0bWFwcyA9PT0nKTsgdGhhdCBmZWVscyB3cm9uZy4gIEkg
d291bGQgcGxhY2UNCj4gdGhpcyBzdWJzZWN0aW9uIGJlbG9uZyB1bmRlciAnPT0gQ2x1c3RlciBt
YXBwaW5nID09JyByaWdodCBhZnRlciB0aGUNCj4gJ0NvbXByZXNzZWQgQ2x1c3RlcnMgRGVzY3Jp
cHRvcicuDQo+DQo+PiArDQo+PiArVGhlIGNvbXByZXNzZWQgY2x1c3RlciBkYXRhIG1heSBoYXZl
IGEgZGlmZmVyZW50IGxheW91dCBkZXBlbmRpbmcgb24gdGhlDQo+PiArY29tcHJlc3Npb24gdHlw
ZSB1c2VkIGZvciB0aGUgaW1hZ2UsIGFuZCBzdG9yZSBzcGVjaWZpYyBkYXRhIGZvciB0aGUgcGFy
dGljdWxhcg0KPj4gK2NvbXByZXNzaW9uIHR5cGUuDQo+PiArDQo+PiArQ29tcHJlc3NlZCBkYXRh
IGxheW91dCBmb3IgdGhlIGF2YWlsYWJsZSBjb21wcmVzc2lvbiB0eXBlczoNCj4gV29yZHk7IG1h
eWJlOg0KPg0KPiBUaGUgY29tcHJlc3NlZCBjbHVzdGVyIGRhdGEgaGFzIGEgbGF5b3V0IGRlcGVu
ZGluZyBvbiB0aGUgY29tcHJlc3Npb24NCj4gdHlwZSB1c2VkIGZvciB0aGUgaW1hZ2UsIGFzIGZv
bGxvd3M6DQo+DQo+PiArKHggPSBkYXRhX3NwYWNlX2xlbmd0aCAtIDEpDQo+PiArDQo+PiArICAg
IHpsaWIgPGh0dHA6Ly96bGliLm5ldC8+Og0KPj4gKyAgICAgICAgQnl0ZSAgMCAtICB4OiAgICAg
dGhlIGNvbXByZXNzZWQgZGF0YSBjb250ZW50DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICBhbGwgdGhlIHNwYWNlIHByb3ZpZGVkIHVzZWQgZm9yIGNvbXByZXNzZWQgZGF0YQ0KPiBXb3J0
aCBhIG1lbnRpb24gdGhhdCB0aGlzIGlzIGNvbXByZXNzaW9uIHR5cGUgMD8NCj4NCj4+ICsgICAg
enN0ZCA8aHR0cDovL2dpdGh1Yi5jb20vZmFjZWJvb2svenN0ZD46DQo+PiArICAgICAgICBCeXRl
ICAwIC0gIDM6ICAgICB0aGUgbGVuZ3RoIG9mIGNvbXByZXNzZWQgZGF0YSBpbiBieXRlcw0KPj4g
KyAgICAgICAgICAgICAgNCAtICB4OiAgICAgdGhlIGNvbXByZXNzZWQgZGF0YSBjb250ZW50DQo+
IFdvcnRoIGEgbWVudGlvbiB0aGF0IHRoaXMgaXMgY29tcHJlc3Npb24gdHlwZSAxPw0KPg0KPj4g
ZGlmZiAtLWdpdCBhL3FhcGkvYmxvY2stY29yZS5qc29uIGIvcWFwaS9ibG9jay1jb3JlLmpzb24N
Cj4+IGluZGV4IDJjMDAyY2E2YTkuLjllNDU4ZDViNDAgMTAwNjQ0DQo+PiAtLS0gYS9xYXBpL2Js
b2NrLWNvcmUuanNvbg0KPj4gKysrIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IEBAIC00Mjgz
LDExICs0MjgzLDEyIEBADQo+PiAgICMgQ29tcHJlc3Npb24gdHlwZSB1c2VkIGluIHFjb3cyIGlt
YWdlIGZpbGUNCj4+ICAgIw0KPj4gICAjIEB6bGliOiAgemxpYiBjb21wcmVzc2lvbiwgc2VlIDxo
dHRwOi8vemxpYi5uZXQvPg0KPj4gKyMgQHpzdGQ6ICB6c3RkIGNvbXByZXNzaW9uLCBzZWUgPGh0
dHA6Ly9naXRodWIuY29tL2ZhY2Vib29rL3pzdGQ+DQo+PiAgICMNCj4+ICAgIyBTaW5jZTogNC4y
DQo+PiAgICMjDQo+PiAgIHsgJ2VudW0nOiAnUWNvdzJDb21wcmVzc2lvblR5cGUnLA0KPj4gLSAg
J2RhdGEnOiBbICd6bGliJyBdIH0NCj4+ICsgICdkYXRhJzogWyAnemxpYicsIHsgJ25hbWUnOiAn
enN0ZCcsICdpZic6ICdkZWZpbmVkKENPTkZJR19aU1REKScgfSBdIH0NCj4+ICAgDQo+PiAgICMj
DQo+PiAgICMgQEJsb2NrZGV2Q3JlYXRlT3B0aW9uc1Fjb3cyOg0KPj4NCg0K

