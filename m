Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27653C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53A520578
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O/ZAEm0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53A520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BEK-00084w-HX
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i1B8H-00014B-4e
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i1B8G-0006p5-AT
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:05:41 -0400
Received: from mail-he1eur04on070e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::70e]:14260
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i1B8C-0006mR-LF; Fri, 23 Aug 2019 11:05:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Thx4tbBY2iH1vzkyh7yQgF1qFpaP6gZadxmlWqeP7KbZuS+eIFFArocsu1EQMTnfagbmYTulVv6LPZTV5fp/ubvBICdTOhjJiuEhHzZ1RfzA+5QdzBCoRcqCszw7xmOxClEI+8pnNteHa1lRl9qa8ChP6ajAElvtJBEgn/9K9P1JRwJZMJMedUcuydPBfEyGAoj4z2vxlzEyJfidegLNj4RN3Gdtb6TGbguJDvpIPNJjgtplDkiuwnLP0jLE/dvfOzrqsXKnRMDFdz0G2iT4ObLQYwW5Ei3Pl4nnPvlUVgMgejWhfLCPK7ipdroTVYnyAFEgAwXYfZHd8erpEiRG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs10yTQqe3mVFz/YRDYXZr7vs+j1B4zPDoxF8K41b+A=;
 b=XEn/uyoDxenmkdHTgEBGyYbvO4SkxeAYSflDgjuSy/HBwCkZR0kXeFy3b5EOsK6YIwhQc1kE1bEL8hqCAVjVYgf3AUfRMyqzAdCPYuCA/F1AW9pbof+oJI4iYsOjOCWjsy2zBCyJ1dJjFBCJO+WYe0bFLOMjR0tCmendLnCcJUyI+LFvsxdFNRnZ/bTqVj6epuydFG418D90W7xaM+Zo7IN6j2MYxUU7d+g+9Egf/NgSY+RG4+toga0WLkaUjpDoDNoVu+xEyUCN3pR5S6xb/BOqavtTwJ+nad8Moa8rkjEVa9aLDkSPJxaQhwHAaMOf+35ZeB3oitQTRn1aVsResw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs10yTQqe3mVFz/YRDYXZr7vs+j1B4zPDoxF8K41b+A=;
 b=O/ZAEm0qzde3vaufdSHtuRZoQTxuyfzStk0tQHnKmixrNK7Fhmbx5nxSi66fByJlNUPS/22162FMjN8xAGdUCXAo2XwNPq7c+1P/CW5uXLvCHi13q315Zk3iVnor0w08RmmfRdm8GPas2q/7n7bg2YqEGT34G17dGW1R+8AG+to=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5033.eurprd08.prod.outlook.com (10.255.17.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 15:05:32 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 15:05:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "nbd@other.debian.org"
 <nbd@other.debian.org>, "libguestfs@redhat.com" <libguestfs@redhat.com>
Thread-Topic: [Qemu-devel] cross-project patches: Add NBD Fast Zero support
Thread-Index: AQHVWb+6QvwHE28+MUauWUhIkXuSiKcI1OeA
Date: Fri, 23 Aug 2019 15:05:32 +0000
Message-ID: <89042b51-42c8-27b3-f742-894c0a62119a@virtuozzo.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
In-Reply-To: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0022.eurprd03.prod.outlook.com
 (2603:10a6:3:76::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190823180529760
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe319ae2-526c-43ed-05ec-08d727db57bf
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5033; 
x-ms-traffictypediagnostic: DB8PR08MB5033:
x-microsoft-antispam-prvs: <DB8PR08MB5033A462C0B9386583A39D30C1A40@DB8PR08MB5033.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39850400004)(189003)(199004)(66946007)(386003)(31686004)(2616005)(53936002)(446003)(6436002)(6116002)(3846002)(11346002)(25786009)(102836004)(4744005)(7736002)(6506007)(478600001)(66446008)(64756008)(316002)(229853002)(66476007)(66556008)(66066001)(6486002)(2906002)(6512007)(486006)(26005)(36756003)(186003)(476003)(6246003)(2201001)(31696002)(305945005)(256004)(14454004)(99286004)(86362001)(81156014)(8936002)(71200400001)(71190400001)(8676002)(52116002)(81166006)(5660300002)(76176011)(110136005)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5033;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v/ZpbUNUvyifNLwNGOWgU1eNil59HbchHxEqwsQiFwlNf1QSv7pPHUiBl/Ap1WHOdO7eYuLHnlYbRf7o9SDQxAblwoaCYG1lgcnjJUCYMLsb8FP8aABKkjRAlY550U2BLYcj/jmpFKk3U7kQSQklulIWmQWfWubeX7LZlyuS+NzVgDh8x7adaD0g7ZSRIcqg8//SPWAp1Mo7vfpVAYN1BbNN94xlpGHYTb74FxUbWiqrqJfrdo9u6rlRWA3SvEBhlvY0yWhq3eOemLOd9cFavwPAhR/eJv5DFvmc2q8jO9WNMCS1KEq3DgQh3KIROoqFizaN+AA6hGekk9Hqs84niAr5WmIqSg6+iKXIEQoUnhE9Jgj2Ln3wgOahKUL8fH+lLwmbIEJEUmIkLtk6ToalpFfjmYctqjZ79Nr9FMW16NM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C929FB1C131FE47A0A60CA5E59504B9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe319ae2-526c-43ed-05ec-08d727db57bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 15:05:32.1583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TF9bIycHjViJwrYkO/hDesB3dvQBpHD1Iv25U/xBQzLEybN02tVUIBLMFzl+cFc6Q+wWhjeGl+UXyFqcaqeraWsr7U6tSPX3V+PCAdEs6IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5033
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::70e
Subject: Re: [Qemu-devel] cross-project patches: Add NBD Fast Zero support
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMDguMjAxOSAxNzozMCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gVGhpcyBpcyBhIGNvdmVyIGxl
dHRlciB0byBhIHNlcmllcyBvZiBwYXRjaGVzIGJlaW5nIHByb3Bvc2VkIGluIHRhbmRlbQ0KPiB0
byBmb3VyIGRpZmZlcmVudCBwcm9qZWN0czoNCg0KSSBhbHdheXMga25ldyB5b3Ugd2VyZSBncmVh
dCwgYnV0IHRoYXQgYnJlYWtzIGFsbCB0aGUgcmVjb3Jkcw0KDQo+IC0gbmJkOiBEb2N1bWVudCBh
IG5ldyBOQkRfQ01EX0ZMQUdfRkFTVF9aRVJPIGNvbW1hbmQgZmxhZw0KPiAtIHFlbXU6IEltcGxl
bWVudCB0aGUgZmxhZyBmb3IgYm90aCBjbGllbnRzIGFuZCBzZXJ2ZXINCj4gLSBsaWJuYmQ6IElt
cGxlbWVudCB0aGUgZmxhZyBmb3IgY2xpZW50cw0KPiAtIG5iZGtpdDogSW1wbGVtZW50IHRoZSBm
bGFnIGZvciBzZXJ2ZXJzLCBpbmNsdWRpbmcgdGhlIG5iZCBwYXNzdGhyb3VnaA0KPiBjbGllbnQN
Cj4gDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

