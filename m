Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF4CC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496DD23A45
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OweDiyNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496DD23A45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzzWI-00050b-WC
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 04:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hzzV2-0003XQ-CL
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hzzV0-0005r3-OE
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:28:15 -0400
Received: from mail-db5eur03on0724.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::724]:29924
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hzzV0-0005qN-9X; Tue, 20 Aug 2019 04:28:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m84FtYhrVkgxlhJz3cdqDjLaZIVj0UlRchoCmkGO2ybKES0v4OWrJFvyS2LMB0aFM70WlvHHvO9C3F2jMUCTevDRVU5RYuSXbnctGIFgwl3U5U8vCimWAYaByVTLsK1ie7YhFmM6At8xMU2HIoaoM9U8v8rzMiAh71CgCR9SEpcGgzWj32NWBVZwp5bWJUReYJcR+7CZdRTDEQb/66bORFw7YVsXjBM56cOCLT+CRUSlRTurlxqjbeaWwxkP8jl9mPbvoxBFVk1uNJGE3VMoHdm8oSalk6csvweaBeKX6dHIjdWm350h7WiWJNJn25LszKiZsgShOFPZupDs+vMmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YULwUoinDkVqT2XJ6AxgzQ5NoWpoJIC1Dh7BUNBwT/0=;
 b=hNOVK0NvHW657s7xD5neXMwkEajBlmbfSvu0DVE/ctoI9LKiQ92KtVdsQ/gJesZiSdPv1jzmCHHJwy+VTncOdI8xfkADZatEGkvovsAR3jMruBUbPtWvo2G+oVbw7Pc15ws38WMscDErXKPzhcUMTgjZN31ndlEMP0CdVCEHfhKrOoooHRgdJU2dJgpXgJXfsk4P1Od+e8yLxmniH/jTBSrgop95DeTDOxzfyE1CWDNzoWfwT+xyn1nO4wbdvgf8CuRfLOyXYyYQ7YmEs7hVi7AeBR3T3o2oOa1lWxPHNZCJoj0NPBcKzer9sEH3hUMrcAMTFtqiHirMoP/zf/sy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YULwUoinDkVqT2XJ6AxgzQ5NoWpoJIC1Dh7BUNBwT/0=;
 b=OweDiyNkS62qMp+W8D6YYp8BuXBzQ9HLWMSUw5Ii2ThLtYcN11XYT3iCdHxYQVJUjY74i8/6owZY2I4BlJB6kcnX91mB8nn3nbF1CgtAQ3bwzw3Aa6PiT51+H7sMxaE2O2ROdoqZ1vFyXss05N/7pUQhszlW0WSPK/GOIaKlW8c=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 08:28:09 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 08:28:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 0/4] backup: fix skipping unallocated clusters
Thread-Index: AQHVUq6iWmNqeubX60mrcacy86ei+6b63ImAgANK9oCABZWFAA==
Date: Tue, 20 Aug 2019 08:28:09 +0000
Message-ID: <10b53c20-0974-eab1-d4a4-a1d00003eb8e@virtuozzo.com>
References: <a018756a-fa67-49fb-a7db-622267b7d4e5@email.android.com>
 <18cda58f-c7d2-3e6c-0bf0-c2b98acd66e7@redhat.com>
In-Reply-To: <18cda58f-c7d2-3e6c-0bf0-c2b98acd66e7@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:7:66::22) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190820112806889
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 851a65a7-120a-4305-b47e-08d725485526
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4010; 
x-ms-traffictypediagnostic: DB8PR08MB4010:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4010BB3C4E0AC45B8D83131FC1AB0@DB8PR08MB4010.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:64;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(53754006)(71190400001)(256004)(71200400001)(8676002)(6436002)(31696002)(186003)(8936002)(53546011)(6506007)(386003)(86362001)(966005)(6512007)(26005)(2501003)(107886003)(6246003)(478600001)(476003)(486006)(305945005)(31686004)(81166006)(446003)(229853002)(14454004)(2616005)(11346002)(66066001)(52116002)(5660300002)(66476007)(66446008)(4326008)(66946007)(53936002)(6486002)(81156014)(66556008)(64756008)(7736002)(316002)(54906003)(110136005)(36756003)(76176011)(102836004)(6306002)(25786009)(99286004)(4744005)(2906002)(3846002)(6116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4010;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kScQAt1zoQfgL6Ojlt7XkPJhdDn6x5svRGXhdttFx1WubW8QR0w9YwPBs0LZMT7Bo81nQ6zDb6e+BOSF8AZJMXuX612LsH3whF4RzMjVAnYrPauWM1HhuD+Tp3xKFcAwwAlUM6uwvasKKBOScizHCv+XRtStf2pp9r8YxTIZBdcrdiabS819YIupVIi2YXzWeCbhWKY75fPIqYtCfuQNV2Im+GKUet6PlYin9x3EQfn2qeuuqL+rc7FbBXqIjAJ/m3hlh0NWdyxJ3hPS/GqJ0Co1OQ0gphn22sSDXTkOqT57uwKPNjgPCfM0E8uNX+d5StxCFyTEaKnjXIaLnDP10gl50zdkpXKd185NVRylmCkhM/uUnHTIWOtdZ7aM49dzW9hf4ueq+1y02JzfgpYhZZwUD8Pv/38EoyeHvQdfeJA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEB7B7DBEE042C4A87B0A23DABD801C8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851a65a7-120a-4305-b47e-08d725485526
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 08:28:09.4779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AzfAEwg8Yuo327f4LHUOSAl/D6yUCR3EpqKnbQ2TDdItoHSFhDtZx6VioqyrOVqj5zXVkRQ7lewSkUfV7vr8/q/AY8YnP0CfVXkMfh0L5Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4010
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::724
Subject: Re: [Qemu-devel] [PATCH 0/4] backup: fix skipping unallocated
 clusters
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

MTYuMDguMjAxOSAyMjoxMSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDgvMTQvMTkg
MTI6NTQgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pg0KPj4NCj4+
IDE0INCw0LLQsy4gMjAxOSDQsy4gMTc6NDMg0L/QvtC70YzQt9C+0LLQsNGC0LXQu9GMIFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkNCj4+IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+INC9
0LDQv9C40YHQsNC7Og0KPj4NCj4+ICAgICAgSGkgYWxsIQ0KPj4NCj4+ICAgICAgVGhlcmUgaXMg
YSBidWcgaW4gbm90IHlldCBtZXJnZWQgcGF0Y2gNCj4+ICAgICAgImJsb2NrL2JhY2t1cDogdGVh
Y2ggVE9QIHRvIG5ldmVyIGNvcHkgdW5hbGxvY2F0ZWQgcmVnaW9ucyINCj4+ICAgICAgaW4gaHR0
cHM6Ly9naXRodWIuY29tL2puc25vdy9xZW11IGJpdG1hcHMuIDA0IGZpeGVzIGl0LiBTbywgSSBw
cm9wb3NlDQo+PiAgICAgIHRvIHB1dCAwMS0wMyBzb21ld2hlcmUgYmVmb3JlDQo+PiAgICAgICJi
bG9jay9iYWNrdXA6IHRlYWNoIFRPUCB0byBuZXZlciBjb3B5IHVuYWxsb2NhdGVkIHJlZ2lvbnMi
DQo+PiAgICAgIGFuZCBzcXVhc2ggMDQgaW50byAiYmxvY2svYmFja3VwOiB0ZWFjaCBUT1AgdG8g
bmV2ZXIgY29weQ0KPj4gICAgICB1bmFsbG9jYXRlZCByZWdpb25zIg0KPj4NCj4+DQo+PiBIbW0s
IGRvbid0IGJvdGhlciB3aXRoIGl0LiBTaW1wbGVyIGlzIGZpeCB0aGUgYnVnIGluIHlvdXIgY29t
bWl0IGJ5IGp1c3QNCj4+IHVzZSBza2lwX2J5dGVzIHZhcmlhYmxlIHdoZW4gaW5pdGlhbGl6aW5n
IGRpcnR5X2VuZC4NCj4+DQo+IA0KPiBPSywganVzdCB1c2UgTWF4J3MgZml4IGluc3RlYWQgb2Yg
dGhpcyBlbnRpcmUgNCBwYXRjaCBzZXJpZXM/DQo+IA0KPiAtLWpzDQo+IA0KDQpZZXMsIEkgdGhp
bmsgaXQncyBPSw0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

