Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B11C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00872080C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f01+gd+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00872080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd8cj-0000Wo-TV
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 03:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hd8b2-0008C5-MI
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hd8az-0007ys-KV
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:31:59 -0400
Received: from mail-eopbgr130133.outbound.protection.outlook.com
 ([40.107.13.133]:4106 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hd8ap-0007qh-FW; Tue, 18 Jun 2019 03:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmH0VMzt2ScwuAaGYjJ4wXa+TEcfMPLU4WnV00m/ntg=;
 b=f01+gd+OBD6LYxoALClF4+fEwAwnAT+1D0AbmTY35if9CHfF0DYnQGyUBRacKC1YOkFb5z0SdZMwcXxxVVqeegtefRAM7FV4zf0Lu7Fzf+qsmkviraR6KDuSNlVNRiCvmnOL2WL0i2LJbuo2NR3p+6avuauIci5slpbJmaJdmiE=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4695.eurprd08.prod.outlook.com (10.255.79.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Tue, 18 Jun 2019 07:31:42 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 07:31:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH 0/4] qapi: block-dirty-bitmap-remove
 transaction action
Thread-Index: AQHVGgPy0pH+2tKaiUKYa9aZeS7UJaaQy/WAgA8B/ICAAEpjgIABA2EA
Date: Tue, 18 Jun 2019 07:31:42 +0000
Message-ID: <4672fcf1-8998-698f-9ae7-af00b39b7322@virtuozzo.com>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
 <54598cf4-a326-5385-2d86-d2dd43f26f47@redhat.com>
 <125166e6-2983-aaa8-2dad-14c5c7081fd8@virtuozzo.com>
 <20190617160319.GL7397@linux.fritz.box>
In-Reply-To: <20190617160319.GL7397@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0088.eurprd07.prod.outlook.com
 (2603:10a6:3:64::32) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618103140026
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a78e3bc1-4d6d-4625-2344-08d6f3bf0279
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4695; 
x-ms-traffictypediagnostic: DBBPR08MB4695:
x-microsoft-antispam-prvs: <DBBPR08MB4695448A64168BCC7355B764C1EA0@DBBPR08MB4695.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(346002)(396003)(136003)(366004)(189003)(199004)(53754006)(52116002)(5660300002)(68736007)(107886003)(6506007)(6246003)(76176011)(81166006)(81156014)(2906002)(53546011)(73956011)(66066001)(102836004)(386003)(476003)(2616005)(66476007)(478600001)(6916009)(256004)(64756008)(25786009)(3846002)(7736002)(6116002)(66946007)(186003)(446003)(71200400001)(71190400001)(486006)(66446008)(66556008)(11346002)(53936002)(26005)(54906003)(99286004)(8676002)(4326008)(316002)(6486002)(229853002)(6436002)(8936002)(36756003)(6512007)(31686004)(86362001)(14454004)(31696002)(305945005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4695;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZqmUVykB5uBAEJ/wjCmAj7xIHJOlyhJhuiPrLtlpa/djqZCUFtiV3kNutqMwoAf6iIi80k6UI9Vqq8ix3tAs7CWaa6u9kwb87tduiSFlKL81mZcuh0wMWJXKBbXkJPYRavLIIoTDdhhH/Qnsr5ClxWkQcqUAACQO907//os48DVbDe4QwNY4A/8tUUaYEqvRxkWlnDGOShDnBSqN9AlFd0qcwf/Am8D1Z062VpEYaSirUqA/8cviTiOa2T0J8dW2qo5VrjPooJYlrdtlUC9u9wBn3x1AB+4cRDsyExd3h1st8B/HqZWADKy8hymySmxTkPqi837pnQyad5pu8M899VQerEEbKMjl0OHBfh9x4OZMpms4Vx2z4KxGekPiUKpy3RxmPHN/y9+AlWuf3qHc/j60biS4BfA0u9hP07s5nv8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7F6C3CCB00C1743963CFE58C7642E2A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78e3bc1-4d6d-4625-2344-08d6f3bf0279
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 07:31:42.8118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4695
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.133
Subject: Re: [Qemu-devel] [PATCH 0/4] qapi: block-dirty-bitmap-remove
 transaction action
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTcuMDYuMjAxOSAxOTowMywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTcuMDYuMjAxOSB1bSAx
MzozNyBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDA4
LjA2LjIwMTkgMToyNiwgSm9obiBTbm93IHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiA2LzMvMTkg
ODowMCBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gSGkgYWxs
IQ0KPj4+Pg0KPj4+PiBIZXJlIGlzIGJsb2NrLWRpcnR5LWJpdG1hcC1yZW1vdmUgdHJhbnNhY3Rp
b24gYWN0aW9uLg0KPj4+Pg0KPj4+PiBJdCBpcyB1c2VkIHRvIGRvIHRyYW5zYWN0aW9uYWwgbW92
ZW1lbnQgb2YgdGhlIGJpdG1hcCAod2hpY2ggaXMNCj4+Pj4gcG9zc2libGUgaW4gY29uanVuY3Rp
b24gd2l0aCBtZXJnZSBjb21tYW5kKS4gVHJhbnNhY3Rpb25hbCBiaXRtYXANCj4+Pj4gbW92ZW1l
bnQgaXMgbmVlZGVkIGluIHNjZW5hcmlvcyB3aXRoIGV4dGVybmFsIHNuYXBzaG90LCB3aGVuIHdl
IGRvbid0DQo+Pj4+IHdhbnQgdG8gbGVhdmUgY29weSBvZiB0aGUgYml0bWFwIGluIHRoZSBiYXNl
IGltYWdlLg0KPj4+Pg0KPj4+DQo+Pj4gT2gsIGludGVyZXN0aW5nLiBJIHNlZSB3aHkgeW91IHdh
bnQgdGhpcyBub3cuIE9LLCBsZXQncyBkbyBpdC4NCj4+Pg0KPj4NCj4+DQo+PiBIaSBKb2huIQ0K
Pj4NCj4+IEhtbSwgY291bGQgeW91IHN0YWdlIGl0LCBvciBzaG91bGQgSSBmaXggc29tZXRoaW5n
PyBTZWVtcyBJJ3ZlIGFuc3dlcmVkIGFsbCBxdWVzdGlvbnMuDQo+PiBXZSBuZWVkIHRoaXMgZm9y
IG91ciBuZWFyZXN0IHJlbGVhc2UgYW5kIHdhbnRpbmcgdG8gYXZvaWQgeC12ei0gcHJlZml4ZXMg
aW4gdGhlIEFQSSwNCj4+IEknZCBiZSB2ZXJ5IGdyYXRlZnVsIGlmIHdlIG1lcmdlIGl0IHNvb24u
DQo+IA0KPiBJIGhvcGUgeW91IHdvbid0IGhhdmUgdG8gZG8gdGhpcywgYnV0IGluIGFueSBjYXNl
IHgtdnotIGlzbid0IHRoZSByaWdodA0KPiBwcmVmaXguIFBsZWFzZSByZWFkIHNlY3Rpb24gJzYu
IERvd25zdHJlYW0gZXh0ZW5zaW9uIG9mIFFNUCcgaW4NCj4gZG9jcy9pbnRlcm9wL3FtcC1zcGVj
LnR4dCBiZWZvcmUgYWRkaW5nIHlvdXIgb3duIGV4dGVuc2lvbnMuDQo+IA0KPiBBY2NvcmRpbmcg
dG8gdGhlIHNwZWMsIHlvdXIgcHJlZml4IHdvdWxkIGJlIHNvbWV0aGluZyBsaWtlDQo+IF9fY29t
LnZpcnR1b3p6by0uLi4NCj4gDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgdG8gdGhhdCwgSSB0aG91
Z2h0IGFib3V0IHRoaXMgc29tZSB0aW1lIGFnbyB3aGVuIHNhdyBSZWQgSGF0IHByZWZpeGVzLi4N
ClN0aWxsIHgtdnotIGlzIGEgbG90IGJldHRlciB0aGFuIG5vdGhpbmcgYW5kIG1vc3QgcHJvYmFi
bHkgd2lsbCBub3QgaW50ZXJzZWN0IHdpdGggZnV0dXJlDQp0aGluZ3MuIEhvd2V2ZXIsIHdlJ2xs
IG1vdmUgdG8gY29ycmVjdCBwcmVmaXhlcyBvZiBjb3Vyc2UuDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

