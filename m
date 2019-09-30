Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D2C388F3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F550216F4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l73O0Fvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F550216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEt0g-00040A-Eb
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 06:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iEsz0-0002rR-RL
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iEsyz-0006kd-48
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:32:46 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com
 ([40.107.15.109]:35342 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iEsyy-0006j8-Fj; Mon, 30 Sep 2019 06:32:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKXLTey51nMYWqyIaxKW3bsg+oZRuZBgg6mE5p7miNQghCiqdlLH4EHoi/Dv3Sbx/ux3K/GZE3BMdLT+JtJQWpnpgAjXXuJ+b7aMM8TUPr5CNyjeinMPW/cL2XOn8NNclQZ0abZS1abNtDqD1Dv4czjfDQoJUGz7vc5Ts3O6yTXcBydH/e41MfL6T7gI0bC47Ged7mFv2NKFpZKQzyhui8aRJ0Xhd6vfVvwkxD9TQljbj4oTgsFL6a7fe1GfpqL8RzcyhhqOC0vt1Fm3ylai84bqwmUq4qASox6rmOBOPW/JJpKkNJnEoN1n8v9Cdv1RFCDXQ5kaPKIK8ox2ExZadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er1fwvCNXwLxNLx3fIHZCgqv4sK2OrfhjYPa7R+G7Fc=;
 b=jdJnKhARXfsRosAkkQduAiphTVFR0tMfrSNKryAijwB6ErY+hqNrmi0n/+Fd1Xjy43av1irmFPtzWegpjNLRH9Oso/PbgVBiF3LLQlH8+XytbBuRZTt49yYNOpx7khOeUlk1d9p2LfMVztRGk1JGDpmIS3Pse04hjuPB3d0bFYuX6jkz6R8/meYECuFxCQcm8nPnP84qa1DcXoYNuoY/M68vVzyUZqQFXrRIp50lPlJFjHT5oCnGupMecpfaZlpwpXFCxKbTGwsOgXy/O3SIZCwNS3T6RXGXruzJ8UesuxYA08fNSyYVmLUa2qdVAbkt3SOkV73WtzHMzmsdoSxWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er1fwvCNXwLxNLx3fIHZCgqv4sK2OrfhjYPa7R+G7Fc=;
 b=l73O0Fvpi1YlV3ynKHvqV6iQfClGXbdmdl0FFLfG9ivvKqcHnLsIvMgyWt3L0h1OqWXATudNO0l3JSmKv9TJoN2IvjDJunUFygOUV0TyX6Xh/wi9ZMmgr+RymBBhBA8H7l/7bJIC1JvYhrZfGnPSIm5GHnwQN7XRweC2miCWPKk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5098.eurprd08.prod.outlook.com (10.255.19.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 10:32:41 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 10:32:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 0/9] qcow2-bitmaps: rewrite reopening logic
Thread-Topic: [PATCH v5 0/9] qcow2-bitmaps: rewrite reopening logic
Thread-Index: AQHVdS539DFcmcYDx0KivWDdiGO0b6dALlWAgAPcEAA=
Date: Mon, 30 Sep 2019 10:32:41 +0000
Message-ID: <6226708b-fc89-724a-e828-1aea7ef7e94b@virtuozzo.com>
References: <20190927122355.7344-1-vsementsov@virtuozzo.com>
 <133c9c4d-9ad2-f813-eab8-8ddb8dffbce5@redhat.com>
In-Reply-To: <133c9c4d-9ad2-f813-eab8-8ddb8dffbce5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0086.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190930133238461
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9a3c370-fa89-415a-1213-08d745918576
x-ms-traffictypediagnostic: DB8PR08MB5098:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5098E7B306AC6A73F15B63ACC1820@DB8PR08MB5098.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(39840400004)(366004)(396003)(346002)(189003)(199004)(53754006)(26005)(99286004)(229853002)(86362001)(2616005)(316002)(305945005)(5660300002)(7736002)(54906003)(102836004)(110136005)(66946007)(8936002)(3846002)(81156014)(6116002)(966005)(81166006)(186003)(256004)(2906002)(478600001)(8676002)(31696002)(66066001)(52116002)(6486002)(11346002)(4326008)(53546011)(446003)(486006)(6506007)(6306002)(36756003)(31686004)(71200400001)(386003)(76176011)(107886003)(476003)(66476007)(66556008)(64756008)(66446008)(14444005)(14454004)(2501003)(6436002)(6512007)(25786009)(6246003)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5098;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RV3Z0Vb0bq3ESvv/TN41aS2HB+RDWDUBq1RJyOMeGzR7gSH6eySek+hiRWRLeVggQA75uGqnwu2htNpw3BSSGPw/nWLzowo4vwAGuhwqC8wOW67luJW7ReiVMygAK61CrL5oNNkqFINl2YjFDmDTC6Flpvdz8Av0u+dMmE3BlsUtopWDRHdPGkhqe7T+TxZz01ypLbUtIlmopoNRWvi/+MpXgK/Hy3Cx+gQAd+DD/sJbGK0wZe+NqyKKATNQvr+qBavqWpcMSltkuZ96N3LDKQG+gDEn0s8DKc3YhgUMgM229XCOOCDhfLDhgIVQ5c5bq9LpT8EXlXASucEdgrMt5p2Z7jz7py7v1sY2w3/rt+4X7i1uaMWTAwmh4BoULND2CfjWqnUxJ/IfTvKTcGoEYRwcKdtVLEhI3Wt9bbRRnlbyCA5L9/zEpXLkoKP8zmgevYXv/CYfWJHg4W8EsWFNOw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5604CD88FFD9C48934EA7503BC199E4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a3c370-fa89-415a-1213-08d745918576
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 10:32:41.2139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/pabpXG+sc6eJg5vxm0uJh2CcYnoxEZibgXqvd6SOWYRD5AnnYsoHN3Cf6AXYCWmLYSaTy2e3EvfY3pK2qz3XlmaJ5miRbq/+qmys2kTuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5098
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.109
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDkuMjAxOSAyOjM2LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gOS8yNy8xOSA4
OjIzIEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gSGkgYWxsIQ0K
Pj4NCj4+IEJpdG1hcHMgcmVvcGVuaW5nIGlzIGJ1Z2d5LCByZW9wZW5pbmctcncganVzdCBub3Qg
d29ya2luZyBhdCBhbGwgYW5kDQo+PiByZW9wZW5pbmctcm8gbWF5IGxlYWQgdG8gcHJvZHVjaW5n
IGJyb2tlbiBpbmNyZW1lbnRhbA0KPj4gYmFja3VwIGlmIHdlIGRvIHRlbXBvcmFyeSBzbmFwc2hv
dCBpbiBhIG1lYW50aW1lLg0KPj4NCj4+IHY1Og0KPj4gMDE6IC0gYWRkIE1heCdzIHItYg0KPj4g
ICAgICAtIGZpeCBzL1FTSU1QTEVfSU5JVC9RVEFJTFFfSU5JVC8gaW4gYSBjb21tZW50DQo+PiAw
MjogLSBhZGQgTWF4J3MgYW5kIEpvaG4ncyBhLWINCj4+IDAzOiAtIGltcHJvdmUgdGVzdCB0byBj
aGVjayBiaXRtYXAgaGFzaGVzIGluIG1vcmUgc2FmZSB3YXkNCj4+IDA3OiAtIGRyb3Agd3Jvbmcg
c3RhdGVtZW50IGZyb20gY29tbWl0IG1lc3NhZ2UNCj4+ICAgICAgLSBsb2cgZXZlbnRzIGJ5IGhh
bmQNCj4+IDA4OiAtIGRyb3AgJ3RoZScgZnJvbSBjb21tZW50DQo+PiAgICAgIC0gYWRkIENvcnJ1
cHRpb24gaW4gY2FzZSBvZiBleGlzdGVudCBJTl9VU0Ugb24gUk8tPlJXIHJlb3Blbg0KPj4gMDk6
IC0gYWRkIE1heCdzIGEtYiBhbmQgSm9obidzIHItYg0KPj4NCj4+IHY0OiBEcm9wIGNvbXBsaWNh
dGVkIHNvbHV0aW9uIGFyb3VuZCByZW9wZW5pbmcgbG9naWMgW0tldmluXSwgZml4DQo+PiAgICAg
IHRoZSBleGlzdGluZyBidWcgaW4gYSBzaW1wbGVzdCB3YXkNCj4+DQo+PiBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5ICg5KToNCj4+ICAgIGJsb2NrOiBzd2l0Y2ggcmVvcGVuIHF1ZXVlIGZy
b20gUVNJTVBMRVEgdG8gUVRBSUxRDQo+PiAgICBibG9jazogcmV2ZXJzZSBvcmRlciBmb3IgcmVv
cGVuIGNvbW1pdHMNCj4+ICAgIGlvdGVzdHM6IGFkZCB0ZXN0LWNhc2UgdG8gMTY1IHRvIHRlc3Qg
cmVvcGVuaW5nIHFjb3cyIGJpdG1hcHMgdG8gUlcNCj4+ICAgIGJsb2NrL3Fjb3cyLWJpdG1hcDog
Z2V0IHJpZCBvZiBiZHJ2X2hhc19jaGFuZ2VkX3BlcnNpc3RlbnRfYml0bWFwcw0KPj4gICAgYmxv
Y2svcWNvdzItYml0bWFwOiBkcm9wIHFjb3cyX3Jlb3Blbl9iaXRtYXBzX3J3X2hpbnQoKQ0KPj4g
ICAgYmxvY2svcWNvdzItYml0bWFwOiBkbyBub3QgcmVtb3ZlIGJpdG1hcHMgb24gcmVvcGVuLXJv
DQo+PiAgICBpb3Rlc3RzOiBhZGQgdGVzdCAyNjAgdG8gY2hlY2sgYml0bWFwIGxpZmUgYWZ0ZXIg
c25hcHNob3QgKyBjb21taXQNCj4+ICAgIGJsb2NrL3Fjb3cyLWJpdG1hcDogZml4IGFuZCBpbXBy
b3ZlIHFjb3cyX3Jlb3Blbl9iaXRtYXBzX3J3DQo+PiAgICBxY293Mi1iaXRtYXA6IG1vdmUgYml0
bWFwIHJlb3Blbi1ydyBjb2RlIHRvIHFjb3cyX3Jlb3Blbl9jb21taXQNCj4+DQo+PiAgIGJsb2Nr
L3Fjb3cyLmggICAgICAgICAgICAgICAgfCAgIDUgKy0NCj4+ICAgaW5jbHVkZS9ibG9jay9ibG9j
ay5oICAgICAgICB8ICAgMiArLQ0KPj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oICAgIHwg
ICA2IC0tDQo+PiAgIGluY2x1ZGUvYmxvY2svZGlydHktYml0bWFwLmggfCAgIDEgLQ0KPj4gICBi
bG9jay5jICAgICAgICAgICAgICAgICAgICAgIHwgIDUzICsrKysrLS0tLS0tDQo+PiAgIGJsb2Nr
L2RpcnR5LWJpdG1hcC5jICAgICAgICAgfCAgMTIgLS0tDQo+PiAgIGJsb2NrL3Fjb3cyLWJpdG1h
cC5jICAgICAgICAgfCAxNjQgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4+
ICAgYmxvY2svcWNvdzIuYyAgICAgICAgICAgICAgICB8ICAxNyArKystDQo+PiAgIHRlc3RzL3Fl
bXUtaW90ZXN0cy8xNjUgICAgICAgfCAgNTcgKysrKysrKysrKystDQo+PiAgIHRlc3RzL3FlbXUt
aW90ZXN0cy8xNjUub3V0ICAgfCAgIDQgKy0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2MCAg
ICAgICB8ICA4OSArKysrKysrKysrKysrKysrKysrDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8y
NjAub3V0ICAgfCAgNTIgKysrKysrKysrKysNCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3Vw
ICAgICB8ICAgMSArDQo+PiAgIDEzIGZpbGVzIGNoYW5nZWQsIDM0MyBpbnNlcnRpb25zKCspLCAx
MjAgZGVsZXRpb25zKC0pDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVz
dHMvMjYwDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjYwLm91
dA0KPj4NCj4gDQo+IFByb3Zpc2lvbmFsbHkgc3RhZ2VkLCBwZW5kaW5nIGZlZWRiYWNrIGZyb20g
S2V2aW4uDQo+IA0KPiBTb21lIG1pbm9yIHJlYmFzZSBjb25mbGljdHMgYWdhaW5zdCB0aGUgY3Vy
cmVudCBiaXRtYXBzIGJyYW5jaDoNCj4gDQo+IDAxMi8xNzpbLS0tLV0gWy1DXSAnYmxvY2svcWNv
dzItYml0bWFwOiBnZXQgcmlkIG9mDQo+IGJkcnZfaGFzX2NoYW5nZWRfcGVyc2lzdGVudF9iaXRt
YXBzJw0KPiAwMTQvMTc6WzAwMDRdIFtGQ10gJ2Jsb2NrL3Fjb3cyLWJpdG1hcDogZG8gbm90IHJl
bW92ZSBiaXRtYXBzIG9uIHJlb3Blbi1ybycNCj4gMDE3LzE3OlstLS0tXSBbLUNdICdxY293Mi1i
aXRtYXA6IG1vdmUgYml0bWFwIHJlb3Blbi1ydyBjb2RlIHRvDQo+IHFjb3cyX3Jlb3Blbl9jb21t
aXQnDQo+IA0KPiANCj4gMTI6IGp1c3QgY29udGV4dCBhZ2FpbnN0IGNoYW5nZWQgX2ZpcnN0IGFu
ZCBfbmV4dCBwcm90b3R5cGVzLg0KPiAxNDogdGhlIHNpZ25hdHVyZSBvZiBiZHJ2X3JlbGVhc2Vf
ZGlydHlfYml0bWFwIGhhcyBjaGFuZ2VkLCB3aGljaCBpbmN1cnMNCj4gYSBjaGFuZ2UgaW4gdGhl
IHJlZmFjdG9yLg0KPiAxNzogYmRydl9jYW5fc3RvcmUuLi4gaGFzIGNoYW5nZWQgdG8gYmRydl9j
b19jYW5fc3RvcmUuLi4NCj4gICAgICBTYW1lIGZvciBiZHJ2X3JlbW92ZV9wZXJzaXN0ZW50Lg0K
PiANCj4gDQo+IFRoYW5rcywgYXBwbGllZCB0byBteSBiaXRtYXBzIHRyZWU6DQo+IA0KPiBodHRw
czovL2dpdGh1Yi5jb20vam5zbm93L3FlbXUvY29tbWl0cy9iaXRtYXBzDQo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9qbnNub3cvcWVtdS5naXQNCj4gDQoNCg0KVGhhbmtzIGEgbG90IQ0KDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

