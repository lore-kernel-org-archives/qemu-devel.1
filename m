Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD88C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273D321881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tRG75Ht2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273D321881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9vZ-0000Ve-CB
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iA9uf-0008T5-I8
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iA9ue-0006U6-Fh
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:36:45 -0400
Received: from mail-db3eur04on0729.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::729]:39430
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iA9ub-0006SM-Vc; Tue, 17 Sep 2019 05:36:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzcHHM3g1yTWAnzdO6VgVbJVyJtOsYxYFsCtK9gO0tANOAIoaUwhVfjiTJX0Sxv827c6VhG20Mj4nOCgzAu4egxUr7Mdlyz7G1z4z3DETG9q9lGz0mjlEOFCMbxdeZ498zCLw3PqfPeHFornZPFZi0mjpMhrqZc2tGttSZIZDznNxIeyCu3bMFNQ9XchAQns4wZSeARiw1G+RZqqBg9/ttgLv7zmOcgqwa8e9VKPDy4Rf7GwarnMXA+GA90mOS0PV8rhSYwTtZb7nTaD+CSQehf6xiuaZK5EqgGSlqZNmr1Mw8bvFG7wBkB9Fi746S6HNOjeKtR6lUudnePzQ1KL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhLWIqDVL36InOedgpZpwATcXiRYn8KLfbsYHMEKC38=;
 b=dCKpeAKIqPzPBpQd5aEOgnZdPrZmRtpvQxgs4D/A7tDkiLHOh7l52PgcrNsWftGsb+z69lOJly6B0OdfQpXfqo5MeA2n2z69Qo3HrFXR5nNGbZKXL5h9rzme2U9F4sqLD1N0Z9EvHDITpmOfhIoWrvSfhYG9Q4PDPr9kKkkUSNyX910ItYXLa8r2dIn5w9zWBFz1zCcuXGA6FJAY4rhlVi91h2dr0umcaoq+Ko0NFe5ZuYVbhG4taPM3BAvHXA1S9CGvl7bwvNvM9PI0stE4ACtU/4pGOXdu1e/vW0wPAR7469sTSrYWXpQxqkGXoOc+gQMWwpIjEVeekgdPqu/xcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhLWIqDVL36InOedgpZpwATcXiRYn8KLfbsYHMEKC38=;
 b=tRG75Ht2IIz0vtAhrEOzQuelQO1Z7uSn3mQtHUFbjCaSmP7x6jG+JZwKg9G9Lk0H6AV7FMGZVea8Ac3cjMvCmp8thDP7VVpgARJsUHieUqr9nVRqgZbrXCafb4JCvl+O3HHxWGXU67GQOXyAHzlgepsd1dgZ+gPBntZPl8Dz28A=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4043.eurprd08.prod.outlook.com (20.179.10.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Tue, 17 Sep 2019 09:36:39 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 09:36:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v4 2/4] iotest 258: use script_main
Thread-Index: AQHVaQAHRwxGkIXbLU2VWAx0iWjaDqcvpMwA
Date: Tue, 17 Sep 2019 09:36:38 +0000
Message-ID: <93cbccd7-f8eb-7d94-4fba-4192dc1d9bba@virtuozzo.com>
References: <20190912001633.11372-1-jsnow@redhat.com>
 <20190912001633.11372-3-jsnow@redhat.com>
In-Reply-To: <20190912001633.11372-3-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0064.eurprd04.prod.outlook.com
 (2603:10a6:3:19::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190917123636787
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0d9b130-b4c1-4d5a-a85c-08d73b528a24
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4043; 
x-ms-traffictypediagnostic: DB8PR08MB4043:
x-microsoft-antispam-prvs: <DB8PR08MB40430C671FA32059CB89B360C18F0@DB8PR08MB4043.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(376002)(136003)(39850400004)(199004)(189003)(256004)(14444005)(76176011)(4326008)(8676002)(6436002)(81166006)(305945005)(6246003)(386003)(2501003)(316002)(6506007)(8936002)(11346002)(186003)(6512007)(14454004)(6486002)(99286004)(2616005)(229853002)(446003)(54906003)(2906002)(476003)(81156014)(3846002)(52116002)(26005)(36756003)(486006)(66446008)(7736002)(66946007)(31696002)(31686004)(66556008)(102836004)(64756008)(6116002)(478600001)(86362001)(110136005)(25786009)(5660300002)(71200400001)(66066001)(71190400001)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4043;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XhUAkPUBgphqMPTPrkIrpOjWdbKxL0HDNEYo31Peocnxrj3cD7kei2MQPRX2R6FkLOD37NdDu42rC0Z/N0mxlfs9/Zi/GFZgkBiZiQhWxi27WSQDtktNmYV7SW+YaFYqZ3Tyo1dNqmWDfPQAsrhbxTISQ7k2HVaJ16D3Q7wYAPH7IwZmpN6MuIKHJ5riuZxQF9kvwCzeVuu2PPCwmFfxLxf8Q34Ab1c//gsJd5Oc4N7tybno/4RGTKb+uzKvfauMANbUikitzwu3LVjU7Gt1BVbvaHFJ+YoNxMEmLHof/RmSG9G+1w+D87CXT77QELUNfwehRKDHRIuVGtiOj5/D8A9r/3bMU+/1o5nErZbb0uuS3gfuAInG/9IyesLTR+K/5RQqdtCZfoYyr7z7VmyzJWHXfXztTSdnjU2WsnCQxKg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <97F545D7CF36DE47A917440A82F6618A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d9b130-b4c1-4d5a-a85c-08d73b528a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 09:36:38.9371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAyZfoLIcr3SD/QkXP7tDOvQVS3GZ8Kn0twLf6lGnoO/lHmiRqr4lUABK38546g2jzYzpbkwAriK9ZPy4sU+ZnZAVAhMdBWAtbWLEeAvPTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4043
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0c::729
Subject: Re: [Qemu-devel] [PATCH v4 2/4] iotest 258: use script_main
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDkuMjAxOSAzOjE2LCBKb2huIFNub3cgd3JvdGU6DQo+IFNpbmNlIHRoaXMgb25lIGlzIG5p
Y2VseSBmYWN0b3JlZCB0byB1c2UgYSBzaW5nbGUgZW50cnkgcG9pbnQsDQo+IHVzZSBzY3JpcHRf
bWFpbiB0byBydW4gdGhlIHRlc3RzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxq
c25vd0ByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIHRlc3RzL3FlbXUt
aW90ZXN0cy8yNTggfCA4ICsrLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVz
dHMvMjU4IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1OA0KPiBpbmRleCBiODRjZjAyMjU0Li4xMzcy
NTIyYzdhIDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjU4DQo+ICsrKyBiL3Rl
c3RzL3FlbXUtaW90ZXN0cy8yNTgNCj4gQEAgLTIzLDExICsyMyw2IEBAIGltcG9ydCBpb3Rlc3Rz
DQo+ICAgZnJvbSBpb3Rlc3RzIGltcG9ydCBsb2csIHFlbXVfaW1nLCBxZW11X2lvX3NpbGVudCwg
XA0KPiAgICAgICAgICAgZmlsdGVyX3FtcF90ZXN0ZmlsZXMsIGZpbHRlcl9xbXBfaW1nZm10DQo+
ICAgDQo+IC0jIE5lZWQgYmFja2luZyBmaWxlIGFuZCBjaGFuZ2UtYmFja2luZy1maWxlIHN1cHBv
cnQNCj4gLWlvdGVzdHMudmVyaWZ5X2ltYWdlX2Zvcm1hdChzdXBwb3J0ZWRfZm10cz1bJ3Fjb3cy
JywgJ3FlZCddKQ0KPiAtaW90ZXN0cy52ZXJpZnlfcGxhdGZvcm0oWydsaW51eCddKQ0KPiAtDQo+
IC0NCj4gICAjIFJldHVybnMgYSBub2RlIGZvciBibG9ja2Rldi1hZGQNCj4gICBkZWYgbm9kZShu
b2RlX25hbWUsIHBhdGgsIGJhY2tpbmc9Tm9uZSwgZm10PU5vbmUsIHRocm90dGxlPU5vbmUpOg0K
PiAgICAgICBpZiBmbXQgaXMgTm9uZToNCj4gQEAgLTE2MCw0ICsxNTUsNSBAQCBkZWYgbWFpbigp
Og0KPiAgICAgICB0ZXN0X2NvbmN1cnJlbnRfZmluaXNoKEZhbHNlKQ0KPiAgIA0KPiAgIGlmIF9f
bmFtZV9fID09ICdfX21haW5fXyc6DQo+IC0gICAgbWFpbigpDQo+ICsgICAgIyBOZWVkIGJhY2tp
bmcgZmlsZSBhbmQgY2hhbmdlLWJhY2tpbmctZmlsZSBzdXBwb3J0DQo+ICsgICAgaW90ZXN0cy5z
Y3JpcHRfbWFpbihtYWluLCBzdXBwb3J0ZWRfZm10cz1bJ3Fjb3cyJywgJ3FlZCddKQ0KPiANCg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

