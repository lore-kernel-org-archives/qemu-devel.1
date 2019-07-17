Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40246C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F192173B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T+GcKPGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F192173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hneS9-0005yn-Q2
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 03:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58111)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hneRy-0005UI-GR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hneRx-00054b-Gj
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:34:06 -0400
Received: from mail-eopbgr150118.outbound.protection.outlook.com
 ([40.107.15.118]:17728 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hneRu-00051c-TQ; Wed, 17 Jul 2019 03:34:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSSC0JD7ZfYaAEEbNP0jErnr+zYoO76h+Cb/1Nm88X/x8S47itlwqJ9u4RWAsjpLmPgKW7bV5n/j+9y33xhd/VcIqMEhwVYGgvmP0xVIy7C7MYwlRLF0c/t9Mc7nmbVDHe0WscK6iB1lOylJwQaF8/zDuVMaKMbA35HLl2GUWApiTD3StxYfiN+UqFbJ67ED4JGqVKIhBfWHsu65472yuSXKoBLmya0u6fOgyi5B41OVujntIv6YGQNYYnVBnQQfiMxPZ6MU/Chi1B6tD6JZL2pna7eIWQIsYRudoSnO1u4oi/OmOdjwbbN41tI5t/0cDPO40XYMGQjeR6KlBq1yRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz/Je8Ko4OdV6RSBqwmCrrHOPhKY2SfcsyVSwKS1gGQ=;
 b=TRh7Gv+FAjEdTaru3kTanYgLhT2ECkbKBSQdaThEi0Cz228Urzr9Bazqdq0DTdwNla8x/ibGxwKj7PtnIkxQ0TFr92n0lLKNlmwPkmBtw0GWFmttl7qyLgEoN9Vaa2K6481kcR+X7oKwoGItX4JvWUxVeXXxhIpnd7AGycbcwEPgTc+G8cQ9rKHZ8vBkMnNP5NsufuPtWtUcs3vK82Zdm3+B80dCzHl1kFMWTr5PXeDzPksv8UH0cyg1GZlP6Si4LtVCWNSibKRKsiwWJVTqHF0/HgKEFfCYguOFgXaNsvYafUHxQqYEqrqcDMW6W2vpTFCdq9LsgiOxjyyYwIdx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz/Je8Ko4OdV6RSBqwmCrrHOPhKY2SfcsyVSwKS1gGQ=;
 b=T+GcKPGMYt6F3AJ27MPDcl2f6SO2/yy2evJ31eBMsrRKG6lAg+sLcOzS6ecAmu1j6Ehqgk7CebXdKlcnPXuHamkV9++7QVEzWTxItEvXoBAYDHKbi7q7jkW/t/KqCV3cdYwgzF9hYSaZwQb+83xiRUy92qiqZ1layPphOHjl1Bg=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3133.eurprd08.prod.outlook.com (52.133.15.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 07:33:58 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 07:33:58 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH] iotests: Set read-zeroes on in null block driver for
 Valgrind
Thread-Index: AQHVOyeDKzj2w2G5ZEeVUW0/KbfJmKbNGloAgAFTUgA=
Date: Wed, 17 Jul 2019 07:33:58 +0000
Message-ID: <f21deadb-06cc-a3e1-dd79-02f8f14838ba@virtuozzo.com>
References: <1563206879-396579-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190716111928.GA7297@linux.fritz.box>
In-Reply-To: <20190716111928.GA7297@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0100.eurprd02.prod.outlook.com
 (2603:10a6:7:29::29) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 241eb4c3-f151-4efb-8a5a-08d70a892175
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3133; 
x-ms-traffictypediagnostic: VI1PR08MB3133:
x-microsoft-antispam-prvs: <VI1PR08MB313327ADDA7B95641F940B75F4C90@VI1PR08MB3133.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(44832011)(6486002)(68736007)(54906003)(6116002)(99286004)(31686004)(8936002)(81166006)(316002)(81156014)(66066001)(25786009)(478600001)(6436002)(86362001)(5660300002)(4326008)(2616005)(476003)(3846002)(386003)(71190400001)(76176011)(36756003)(6506007)(53546011)(102836004)(52116002)(486006)(2906002)(31696002)(53936002)(6512007)(26005)(107886003)(8676002)(66946007)(305945005)(4744005)(186003)(11346002)(7736002)(256004)(229853002)(66446008)(71200400001)(64756008)(6246003)(66556008)(66476007)(446003)(6916009)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3133;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5tNFP9GenqdcLw1KRL6FopKnWoZBnMzKB0BzM0pD+ws1LdALGxuorusp9JHUiDw6n2HIO1sh/m6otrwSu31pJt75mkahFoZesEKq+7pArk77tQmsZlsThAtAI0jaxe5ysn6i/pDvY1ugogq9ZIYtked0ChRdzpSVpU5S/jzc0GX5mXV7tf6UV2kY8eDJraA/08iU2U70NZP/QaYyygmeG5RlMxRYvZBVNdNEyEJKRo72pcn8SeM1rrbQC2uSFDb16VJ7spjTTmTLy6REITEa894g6TwbqYjt78BjYhCHNnr9NmD02boEPP8xK3H8Qq5cQlpLMYIAMxq9VK9AYofWZpyE+esKpX2o1OfpkrY5Zcy25EDWgcpM3CRjuZ7RRVU/6lebgkT28HIXjCY+BxOirxH89kXlbEMHpFhfGB3BLfI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <048287CBD4872F4097E1D219B41D6FC3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241eb4c3-f151-4efb-8a5a-08d70a892175
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 07:33:58.6681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3133
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.118
Subject: Re: [Qemu-devel] [PATCH] iotests: Set read-zeroes on in null block
 driver for Valgrind
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE2LzA3LzIwMTkgMTQ6MTksIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDE1LjA3LjIw
MTkgdW0gMTg6MDcgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4gVGhlIFZh
bGdyaW5kIHRvb2wgcmVwb3J0cyBhYm91dCB0aGUgdW5pbml0aWFsaXNlZCBidWZmZXIgJ2J1ZicN
Cj4+IGluc3RhbnRpYXRlZCBvbiB0aGUgc3RhY2sgb2YgdGhlIGZ1bmN0aW9uIGd1ZXNzX2Rpc2tf
bGNocygpLg0KPj4gUGFzcyAncmVhZC16ZXJvZXM9b24nIHRvIHRoZSBudWxsIGJsb2NrIGRyaXZl
ciB0byBtYWtlIGl0IGRldGVybWluaXN0aWMuDQo+PiBUaGUgb3V0cHV0IG9mIHRoZSB0ZXN0cyAw
NTEsIDE4NiBhbmQgMjI3IG5vdyBpbmNsdWRlcyB0aGUgcGFyYW1ldGVyDQo+PiAncmVhZC16ZXJv
ZXMnLiBTbywgdGhlIGJlbmNobWFyayBvdXRwdXQgZmlsZXMgYXJlIGJlaW5nIGNoYW5nZWQgdG9v
Lg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0
dW96em8uY29tPg0KPiANCj4gVGhhbmtzLCBhcHBsaWVkIHRvIHRoZSBibG9jayBicmFuY2guDQo+
IA0KPiBLZXZpbg0KPiANCg0KVGhhbmsgeW91IEtldmluIQ0KDQpBbmRyZXkNCi0tIA0KV2l0aCB0
aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

