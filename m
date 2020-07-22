Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FD7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD9D20717
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OCUUMnd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD9D20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9kS-0006BC-8u
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jy9jp-0005lj-Rn
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:04:30 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com
 ([40.107.244.79]:27456 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jy9jm-0003lE-ST
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:04:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSbsrLDXjQ+ofy9UOvyxpE7tfow8Xgfyd2E/rwaKS7IbFKu2egsD7YUt2wr1z+sEaLmyFHApQJCcHFKSu0VcEV9gZzMo3PHOYJQlSRpAEyR5nMOAdk38VIWNT23111ROEpSqs9wnqXOQDhaSILwHagRhz1XNj7X2kd3XG2360NR/zP/E6s47FJ53zgH4pgc0ZZyFDJpfPbSM8ybL94wmJTMpXpUKAeE4Du07Hw8Rh7mZ+tZ8iH28u58pab/CHTxL+dckzySm1gnZiI/fLwwUGf6AbSPwhg+5Sg15pmEB91kfKbzeoiBnsJmI7Ay0NQBN0etEAbcn1kAG5TG4r56LWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMw0h7g6uRXDGLp0crfXA1BNCJWyuYppDYP66WVq6lU=;
 b=ZUn3KIGuVxUFZjQZiCj68KItS9frIyRRExZsAFNaE5BgVX5mdmrVbXEKi895KC41gemjgxt30+RfnB81wSFQ3OarFI/HGxkJ2YNKlQN/1xBjsuKj1xb0LCqJech0jy+VqQbDzC74gHFqy+IzV8YQM1OG7jFZ+UrSW4qV/w+mLcd20fC31MzX34t1nmWc7C8nLw896HKOacwA41vXiCPMdpi8zHV01lvD1944Nj9Ta76VUHSWGJZlk7A5QdTtp0mw1jrdj/megJUfbjt96TyvjjCiJ3LgrRVcMWom/CdY7zHc+R4ODDL59tsg2kjASNKPIlmEmD38AgBmqmw4ehW/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMw0h7g6uRXDGLp0crfXA1BNCJWyuYppDYP66WVq6lU=;
 b=OCUUMnd5GkKxFsw7b61eksOFqNl84JCKhK0ZyuMLgzgDoRhSjVDr1g52WJT5tc6keRlF5ks8v8FYzj6ZbKCqa1rzRwdyib+MFsYdSLH/eOY7h8f/k4hqCAOcFOHQMCSQpMc4sIK12/pAVZHERWBX7dYUIkgbJlLDHFpgUNhLkQM=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB7041.namprd02.prod.outlook.com (2603:10b6:a03:237::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 07:49:19 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828%3]) with mapi id 15.20.3216.020; Wed, 22 Jul 2020
 07:49:19 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Markus
 Armbruster <armbru@redhat.com>
Subject: RE: [PATCH v2 2/3] usb/hcd-xhci: Move qemu-xhci device to
 hcd-xhci-pci.c
Thread-Topic: [PATCH v2 2/3] usb/hcd-xhci: Move qemu-xhci device to
 hcd-xhci-pci.c
Thread-Index: AQHWSseXs5W1CCwXt0udqNJ08afgVqjo/J0AgCdFE0CAAAJVAIADEWCw
Date: Wed, 22 Jul 2020 07:49:18 +0000
Message-ID: <BY5PR02MB6772EAC0125218AD9E09FC97CA790@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-3-git-send-email-sai.pavan.boddu@xilinx.com>
 <87zh8rzi0e.fsf@dusky.pond.sub.org>
 <d8e247a3-5b50-0889-2522-37f2d486fdf9@redhat.com>
 <BY5PR02MB677295286C4193236973EC0ECA7B0@BY5PR02MB6772.namprd02.prod.outlook.com>
 <b3d4924f-5259-3f55-a52c-9693c532d40b@redhat.com>
In-Reply-To: <b3d4924f-5259-3f55-a52c-9693c532d40b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [183.83.78.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f18d888e-4c29-4fd7-2e02-08d82e13bd71
x-ms-traffictypediagnostic: BY5PR02MB7041:
x-microsoft-antispam-prvs: <BY5PR02MB704129D8517921066DCC4E36CA790@BY5PR02MB7041.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XXi80TTz0fdeIe+w4QtDZR+H//l1xQHHdOPG6OHUOz8D9Z+pOBhvWyG5L3A1eS4ChDfXoyif4e4U/DOAyw9nfnKl7hyImoCjTLvBsf4vbu71D7PpxNZ60qF4CL4SmdPoXkz7XC26IjCbVfS8JD1g9kKj8xALHqzTGUCWkVq2ERgdBWD9xOlFznmO2jdIcoWCxLlpMvDNhTXdLmIgblfBuXfW/UjQnJo/S45HXVBE7EsHWZ0tTl+5l6NK30Peo3AyI/X/IWyiVHaJ31NXqd7Fldslj8EnhS/QAGAWHpSz+VTSEfqhRS4HNbgT1hXCgYvhwapiyLIS9SW8wGma3Dcuhl9Ffuv6zAqH8ZWtZG+Chfu9vjA2/J9qkj/CiZbNcwHoSFz0RdO3/fhME5nYG7ha+X6/LAO1YMZ6TVCne3YbG3/dwbn0aLuaUIvc7gw2QFi1xVlOJupPDoZVdBxvcMZWRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(366004)(376002)(346002)(39860400002)(136003)(76116006)(66946007)(6506007)(53546011)(86362001)(66556008)(7416002)(5660300002)(52536014)(4326008)(186003)(8676002)(478600001)(2906002)(71200400001)(26005)(9686003)(66476007)(110136005)(316002)(33656002)(55016002)(7696005)(54906003)(66446008)(8936002)(966005)(83380400001)(64756008)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wa29mkNBZQ1kvM0TssOQRsw6qHA71f6GQxsCi7Ba2kb0OOCLRa8JAQqe9vqF9HLhDJ//kHxv0yAtFb4G3os0e1KkSN51JJr2AlxEl5u+w/gc6hM7zuNh0hiKRhp7zTvMDEpqbso+pHOyJRAiImJMCk3B5pbcQma+xkR8yRIo5gt4+gjpS8XneKEkNkg8/Ik15mYDll7odHNdQWQrcgik5zpBSqSqXpHkVgJjYVIBAsjrJLtfOoRNnr8Tmw+C1dTMynA1VT6w0DkEWCdIJWkgSqDqUcMR+FAAPJZYJEFlj89UqIVPYf9V/2OiaWdzS3ciq+LiTR8W/YsD6wAGeTWDUq5hBqXXGAqMj5U3ohleGwETYwX4C9aIz0oBV48XYazKNBlOjs5m81vk6zU15rVkcbZzBv+0AvUAQSBR9mr6FsIlbsDf+GUip4xSF0p4HmToeAzu9T+Oq6oGacqYViPo8Kybr/wn8Sfdy1g8WhNlY58=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18d888e-4c29-4fd7-2e02-08d82e13bd71
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:49:18.9168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7QKM36AL9zBPxn8n8rcAT54N2P3/ohf/y5W1DayTTgYuebxsL1vrH4xrxTY57VhOuOB3RKuPHF+BdEdCYIABfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7041
Received-SPF: pass client-ip=40.107.244.79; envelope-from=saipava@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 04:04:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?utf-8?B?J01hcmMtQW5kcsOpIEx1cmVhdSc=?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgVGhvbWFzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRob21h
cyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMjAsIDIwMjAg
MTozNyBQTQ0KPiBUbzogU2FpIFBhdmFuIEJvZGR1IDxzYWlwYXZhQHhpbGlueC5jb20+OyBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqQ0KPiA8cGhpbG1kQHJlZGhhdC5jb20+OyBNYXJrdXMgQXJtYnJ1
c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+IENjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVk
aGF0LmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IEVk
dWFyZG8gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT47DQo+IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPjsNCj4gJ01h
cmMtQW5kcsOpIEx1cmVhdScgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT47IFlpbmcgRmFu
Zw0KPiA8ZmFuZ3lpbmcxQGh1YXdlaS5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRo
YXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvM10gdXNiL2hjZC14aGNpOiBNb3Zl
IHFlbXUteGhjaSBkZXZpY2UgdG8gaGNkLQ0KPiB4aGNpLXBjaS5jDQo+IA0KPiBPbiAyMC8wNy8y
MDIwIDEwLjAwLCBTYWkgUGF2YW4gQm9kZHUgd3JvdGU6DQo+ID4gSEkgUGhpbGlwcGUsDQo+ID4N
Cj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgSnVu
ZSAyNSwgMjAyMCAxOjQ4IFBNDQo+ID4+IFRvOiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJl
ZGhhdC5jb20+OyBTYWkgUGF2YW4gQm9kZHUNCj4gPj4gPHNhaXBhdmFAeGlsaW54LmNvbT47IFRo
b21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KPiA+PiBDYzogR2VyZCBIb2ZmbWFubiA8a3Jh
eGVsQHJlZGhhdC5jb20+OyBQZXRlciBNYXlkZWxsDQo+ID4+IDxwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc+OyBFZHVhcmRvIEhhYmtvc3QgPGVoYWJrb3N0QHJlZGhhdC5jb20+Ow0KPiA+PiBxZW11
LWRldmVsQG5vbmdudS5vcmc7IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2Rj
LmNvbT47DQo+ID4+ICdNYXJjLUFuZHLDqSBMdXJlYXUnIDxtYXJjYW5kcmUubHVyZWF1QHJlZGhh
dC5jb20+OyBZaW5nIEZhbmcNCj4gPj4gPGZhbmd5aW5nMUBodWF3ZWkuY29tPjsgUGFvbG8gQm9u
emluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAy
LzNdIHVzYi9oY2QteGhjaTogTW92ZSBxZW11LXhoY2kgZGV2aWNlIHRvDQo+ID4+IGhjZC0geGhj
aS1wY2kuYw0KPiA+Pg0KPiA+PiBPbiA2LzI1LzIwIDEwOjA2IEFNLCBNYXJrdXMgQXJtYnJ1c3Rl
ciB3cm90ZToNCj4gPj4+IFNhaSBQYXZhbiBCb2RkdSA8c2FpLnBhdmFuLmJvZGR1QHhpbGlueC5j
b20+IHdyaXRlczoNCj4gPj4+DQo+ID4+Pj4gTW92ZSBwY2kgc3BlY2lmaWMgZGV2aWNlcyB0byBu
ZXcgZmlsZS4gVGhpcyBzZXQgdGhlIGVudmlyb25tZW50IHRvDQo+ID4+Pj4gbW92ZSBhbGwgcGNp
IHNwZWNpZmljIGhvb2tzIGluIGhjZC14aGNpLmMgdG8gaGNkLXhoY2ktcGNpLmMuDQo+ID4+Pj4N
Cj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBTYWkgUGF2YW4gQm9kZHUgPHNhaS5wYXZhbi5ib2RkdUB4
aWxpbnguY29tPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICBody91c2IvaGNkLXhoY2ktcGNpLmMgfCA2
NA0KPiA+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPj4+PiAgaHcvdXNiL2hjZC14aGNpLmMgICAgIHwgMzIgKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gPj4+PiAgaHcvdXNiL2hjZC14aGNpLmggICAgIHwgIDIgKysNCj4gPj4+PiAg
MyBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkgIGNyZWF0
ZSBtb2RlDQo+ID4+Pj4gMTAwNjQ0IGh3L3VzYi9oY2QteGhjaS1wY2kuYw0KPiA+Pj4+DQo+ID4+
Pj4gZGlmZiAtLWdpdCBhL2h3L3VzYi9oY2QteGhjaS1wY2kuYyBiL2h3L3VzYi9oY2QteGhjaS1w
Y2kuYyBuZXcgZmlsZQ0KPiA+Pj4+IG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAuLjI2YWY2ODMN
Cj4gPj4+PiAtLS0gL2Rldi9udWxsDQo+ID4+Pj4gKysrIGIvaHcvdXNiL2hjZC14aGNpLXBjaS5j
DQo+ID4+Pj4gQEAgLTAsMCArMSw2NCBAQA0KPiA+Pj4+ICsvKg0KPiA+Pj4+ICsgKiBVU0IgeEhD
SSBjb250cm9sbGVyIHdpdGggUENJIHN5c3RlbSBidXMgZW11bGF0aW9uDQo+ID4+Pg0KPiA+Pj4g
U2NyYXRjaCAic3lzdGVtIi4NCj4gPj4+DQo+ID4+Pj4gKyAqDQo+ID4+Pj4gKyAqIENvcHlyaWdo
dCAoYykgMjAxMSBTZWN1cmlmb3Jlc3QNCj4gPj4+PiArICogRGF0ZTogMjAxMS0wNS0xMSA7ICBB
dXRob3I6IEhlY3RvciBNYXJ0aW4NCj4gPj4+PiArIDxoZWN0b3JAbWFyY2Fuc29mdC5jb20+DQo+
ID4+Pg0KPiA+Pj4gTGV0J3MgdXNlIHRoZSBvcHBvcnR1bml0eSB0byBkcm9wIHRoZSAiRGF0ZTog
IiBwYXJ0LCBiZWNhdXNlIHdlDQo+ID4+PiBkb24ndCBoYXZlIGl0IGFueXdoZXJlIGVsc2UuDQo+
ID4+DQo+ID4+IEdvb2Qgb3Bwb3J0dW5pdHkgdG8gc3VnZ2VzdCB0aGUgU1BEWCB0YWdzIGFnYWlu
IDpQDQo+ID4+DQo+ID4+IC8qDQo+ID4+ICAqIFNQRFgtRmlsZUNvcHlyaWdodFRleHQ6IDIwMTEg
U2VjdXJpZm9yZXN0DQo+ID4+ICAqIFNQRFgtRmlsZUNvbnRyaWJ1dG9yOiBIZWN0b3IgTWFydGlu
IDxoZWN0b3JAbWFyY2Fuc29mdC5jb20+DQo+ID4+ICAqIFNQRFgtRmlsZUNvcHlyaWdodFRleHQ6
IDIwMjAgWGlsaW54IEluYy4NCj4gPj4gICogU1BEWC1GaWxlQ29udHJpYnV0b3I6IFNhaSBQYXZh
biBCb2RkdSA8c2FpLnBhdmFuLmJvZGR1QHhpbGlueC5jb20+DQo+ID4+ICAqIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICAqLw0KPiA+IFtTYWkgUGF2YW4gQm9kZHVd
IEkgd291bGQgaW5jbHVkZSB0aGlzIGluIFY0LCBGb3Jnb3QgdGhlbSBpbiBWMy4NCj4gPg0KPiA+
IFRoYW5rcywNCj4gPiBTYWkgUGF2YW4NCj4gPj4NCj4gPj4gaHR0cHM6Ly9zcGR4Lm9yZy9yZGYv
b250b2xvZ3kvc3BkeC0yLTAtDQo+ID4+IHJjL2RhdGFwcm9wZXJ0aWVzL2ZpbGVDb250cmlidXRv
cl9fXy0xNjM1NzE3MTcyLmh0bWwNCj4gPj4NCj4gPj4+DQo+ID4+Pj4gKyAqIEJhc2VkIG9uIHVz
Yi1vaGNpLmMsIGVtdWxhdGVzIFJlbmVzYXMgTkVDIFVTQiAzLjANCj4gPj4+PiArICogRGF0ZTog
MjAyMC0wMy0wMTsgQXV0aG9yOiBTYWkgUGF2YW4gQm9kZHUNCj4gPj4+PiArIDxzYWkucGF2YW4u
Ym9kZHVAeGlsaW54LmNvbT4NCj4gPj4+DQo+ID4+PiBBbmQgbm8gbmV3ICJEYXRlOiAiIHBhcnRz
LCBwbGVhc2UuDQo+ID4+Pg0KPiA+Pj4+ICsgKiBNb3ZlZCB0aGUgcGNpIHNwZWNpZmljIGNvbnRl
bnQgZm9yIGhjZC14aGNpLmMgdG8gaGNkLXhoY2ktcGNpLmMNCj4gPj4+PiArICoNCj4gPj4+PiAr
ICogVGhpcyBsaWJyYXJ5IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0
IGFuZC9vcg0KPiA+Pj4+ICsgKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
TGVzc2VyIEdlbmVyYWwgUHVibGljDQo+ID4+Pj4gKyAqIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5
IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlcg0KPiA+Pj4+ICsgKiB2ZXJzaW9u
IDIgb2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
DQo+IA0KPiBBbmQgd2hpbGUgeW91J3JlIGF0IGl0OiBUaGVyZSB3YXMgbmV2ZXIgYSAidmVyc2lv
biAyIiBvZiB0aGUgTGVzc2VyIEdQTC4NCj4gSW4gdmVyc2lvbiAyLjAsIGl0IHdhcyBzdGlsbCBj
YWxsZWQgIkxpYnJhcnkiIEdQTC4gU28gaXQgaXMgcXVpdGUgbGlrZWx5IHRoYXQgdmVyc2lvbg0K
PiAyLjEgaXMgbWVhbnQgaGVyZSBpbnN0ZWFkLg0KW1NhaSBQYXZhbiBCb2RkdV0gSSBoYXZlIGxl
c3Mga25vd2xlZGdlIGhlcmUuIEJ1dCBpbmRlZWQgSSBkb27igJl0IGZpbmQgTEdQTCAyLjAgaHR0
cHM6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy9saWNlbnNlcy5odG1sI0xpY2Vuc2VVUkxzDQoNCkJU
VywgSSBzdGlsbCBzZWUgb3VyIHJlcG9zaXRvcnkgdXNlIGNvbWJpbmF0aW9uIG9mIEdQTCBhbmQg
TEdQTC4gSXMgdGhlcmUgYW55IGdlbmVyYWwgcnVsZSB0byBmb2xsb3cgYXQgaGlnaCBsZXZlbC4N
Cg0KUmVnYXJkcywNClNhaSBQYXZhbg0KPiANCj4gIFRob21hcw0KDQo=

