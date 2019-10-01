Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EA9C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58462133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="btHiwEkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58462133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFEK9-0007we-Cq
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFEHo-0006KQ-RM
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFEHn-0004qw-7H
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:17:36 -0400
Received: from mail-am5eur02on0710.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::710]:10758
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFEHm-0004q8-VE; Tue, 01 Oct 2019 05:17:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/JzNrfFguircZpmk8MOPD47IYLvht9fRG7eILndrnaOM8Wahd4anYJDmorNeapwzKu0qFbIzfRhyfDzhN5TXA/hWh2nOJwabBpcOV5rTI/AEWFVTVMtHduVbcJ72prpH71oAceBh/nD/EbM3dxpNMgA8DmmXJcSofMCTu8VvR0MUOfbIqKIcmhBeoTYYcgW7gKN2ZwU/X8Sa6lTx6c3b6b0jiYtjp7C6hnNHxjjllMIwMdZxht2Fva4qxk8+iFkYZGfE5vsxoM7b1V9lBySCyiF8cpqe6dezEXzHoRaSkbSNtYfvqGW/Yz3SI9c9+tMjM+SN4+w8Fm7/iSOZOK8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQzQqCEf1LDmZ3jaeq2ZWGG/J+o41rMSko9sYdnOTqE=;
 b=VUMLxnzZcTj63ww0M95Qq8m2b35zeiDPI/NhOGR++OOrYyJpMymOPRb0yo9itsrvPLHQoMpyPA/IT3Hw4Ur+LiNLiz3LxFUOJ+3a+7OU8uRuCE9DNBGSsUfYA5QIxDtandY4l/NtwCCLlYu4Z+kMGdkRXq+IxWIiWs+3rZR70mcrqh0j1RxdHCLY4fDIukuKqcgGCEHjzSLn3fXwaIWtY2Dim4wIxnjA7K8k3/3gh4Ba01uwi4rFQo6NPMBy6wJxjHfUI6bvK62rFoDzmd4VyV5j6Nzg/19UE2WEYWpE2t3ICrDhVty8JmWu15AeYA1ADSP3G7i4yWwZbGJa5mSIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQzQqCEf1LDmZ3jaeq2ZWGG/J+o41rMSko9sYdnOTqE=;
 b=btHiwEkYGD7ECmNWOZOhEuN5mS4DsfG08CvCVSRhlBRjnQktmv6MUrX/9UVruSEMpSbNU4hut5YuFu6Z94hz73WEZuljBkZroWvY6tIePL7mrRX0uRIiHyydvHq5iqlUtCQUOnD8NCw1iROq1RqvdC0OLRwHMMZk5+GWXXVVr6o=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4060.eurprd08.prod.outlook.com (20.179.9.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 09:17:31 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 09:17:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdFgj4A
Date: Tue, 1 Oct 2019 09:17:31 +0000
Message-ID: <ffd337d8-31f1-0515-ce1a-15a8fcfff75d@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
In-Reply-To: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0222.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::22) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001121728714
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52559734-4c9c-462d-8d9d-08d746502ff9
x-ms-traffictypediagnostic: DB8PR08MB4060:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB4060327EA28162F6F1258E1EC19D0@DB8PR08MB4060.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(396003)(376002)(346002)(136003)(39850400004)(366004)(199004)(189003)(31696002)(2906002)(8936002)(6116002)(5024004)(4326008)(186003)(25786009)(3846002)(31686004)(86362001)(7736002)(36756003)(5660300002)(305945005)(66066001)(81166006)(8676002)(81156014)(6916009)(486006)(316002)(2616005)(66476007)(66946007)(6486002)(229853002)(11346002)(446003)(64756008)(256004)(478600001)(6246003)(66556008)(476003)(6306002)(26005)(99286004)(52116002)(102836004)(386003)(6506007)(54906003)(6512007)(66446008)(71200400001)(71190400001)(14454004)(76176011)(6436002)(966005)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4060;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgjCTqMFe42Yxz4m75bTPwCJGMN4j0TWP2DWWPvnfAD2YgxFA7OIKxZxBBLmQo51kfWRaA1uN05ipFGgME/u+qSlLRcIRzY9Q3dY4CajFngLn64Jy1P7VhcZ1Ugs3UEZWWg+qB3hinrC802SmKMiRkJjyMCMb9PNwd+8rsSFS7TJ9m7mv6wnQziJT0emc+xzII3bCEQ+GkTmphilEY8e7VrxcsAwpXWh4gJceh4MAF7z1ca7GSm/gghCir1dquA2L5AWSGG+d+gy3p1ctMC0gAbU76+wc+yxCwF+OuKW9QlheBcbwqvuZf9e/r87c66dKcnGhz+L8DKIhP+rb18Pv/a/+Po17BCWna2VQT1GX5e41W3JXw4kePtkBGCsdA+EtxEHqU+4dAJsp8+rtwVm8Ce0+r5sz+DM90jLqHdfph/gfPBeAORAlrDhDfqyp98hd3+kFJJVKrnxwdnykrdH9w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6CF9F388EB3104082338DADBBD839AC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52559734-4c9c-462d-8d9d-08d746502ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 09:17:31.3597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nb7w+TBFYBcgwU1+LYmVLcf2QFuxsRNJHHbK1KaM7mwfXr9d1MthZdtHvbidgpbKbNeV6pUNNGc8hAs8PZN4I8M6TS97muGfEdqNt2MbTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4060
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::710
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAzOjA5LCBKb2huIFNub3cgd3JvdGU6DQo+IEhpIGZvbGtzLCBJIGlkZW50aWZp
ZWQgYSBwcm9ibGVtIHdpdGggdGhlIG1pZ3JhdGlvbiBjb2RlIHRoYXQgUmVkIEhhdCBRRQ0KPiBm
b3VuZCBhbmQgdGhvdWdodCB5b3UnZCBsaWtlIHRvIHNlZSBpdDoNCj4gDQo+IGh0dHBzOi8vYnVn
emlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTY1MjQyNCNjMjANCj4gDQo+IFZlcnks
IHZlcnkgYnJpZWZseTogZHJpdmUtbWlycm9yIGluc2VydHMgYSBmaWx0ZXIgbm9kZSB0aGF0IGNo
YW5nZXMgd2hhdA0KPiBiZHJ2X2dldF9kZXZpY2Vfb3Jfbm9kZV9uYW1lKCkgcmV0dXJucywgd2hp
Y2ggY2F1c2VzIGEgbWlncmF0aW9uIHByb2JsZW0uDQo+IA0KPiANCj4gSWdub3JhbnQgcXVlc3Rp
b24gIzE6IENhbiB3ZSBtdWx0aS1wYXJlbnQgdGhlIGZpbHRlciBub2RlIGFuZA0KPiBzb3VyY2Ut
bm9kZT8gSXQgbG9va3MgbGlrZSBhdCB0aGUgbW9tZW50IGJvdGggY29uc2lkZXIgdGhlaXIgb25s
eSBwYXJlbnQNCj4gdG8gYmUgdGhlIGJsb2NrLWpvYiBhbmQgZG9uJ3QgaGF2ZSBhIGxpbmsgYmFj
ayB0byB0aGVpciBwYXJlbnRzIG90aGVyd2lzZS4NCj4gDQo+IA0KPiBPdGhlcndpc2U6IEkgaGF2
ZSBhIGxvdCBvZiBjbG91ZHkgaWRlYXMgb24gaG93IHRvIHNvbHZlIHRoaXMsIGJ1dA0KPiB1bHRp
bWF0ZWx5IHdoYXQgd2Ugd2FudCBpcyB0byBiZSBhYmxlIHRvIGZpbmQgdGhlICJhZGRyZXNzYWJs
ZSIgbmFtZSBmb3INCj4gdGhlIG5vZGUgdGhlIGJpdG1hcCBpcyBhdHRhY2hlZCB0bywgd2hpY2gg
d291bGQgYmUgdGhlIG5hbWUgb2YgdGhlIGZpcnN0DQo+IGFuY2VzdG9yIG5vZGUgdGhhdCBpc24n
dCBhIGZpbHRlci4gKE9SLCB0aGUgbmFtZSBvZiB0aGUgYmxvY2stYmFja2VuZA0KPiBhYm92ZSB0
aGF0IG5vZGUuKQ0KPiANCj4gQSBzaW1wbGUgd2F5IHRvIGRvIHRoaXMgbWlnaHQgYmUgYSAiY2hp
bGRfdW5maWx0ZXJlZCIgQmRydkNoaWxkIHJvbGUNCj4gdGhhdCBzaW1wbHkgYnlwYXNzZXMgdGhl
IGZpbHRlciB0aGF0IHdhcyBpbnNlcnRlZCBhbmQgc2VydmVzIG5vIHJlYWwNCj4gcHVycG9zZSBv
dGhlciB0aGFuIHRvIGFsbG93IHRoZSBjaGlsZCB0byBoYXZlIGEgcGFyZW50IGxpbmsgYW5kIGZp
bmQgd2hvDQo+IGl0J3MgIiIicmVhbCIiIiBwYXJlbnQgaXMuDQo+IA0KPiBCZWNhdXNlIG9mIGZs
dXNoaW5nLCByZW9wZW4sIHN5bmMsIGRyYWluICZjICZjICZjIEknbSBub3Qgc3VyZSBob3cNCj4g
ZmVhc2libGUgdGhpcyBxdWljayBpZGVhIG1pZ2h0IGJlLCB0aG91Z2guDQo+IA0KPiANCj4gLSBD
b3JvbGxhcnkgZml4ICMxOiBjYWxsIGVycm9yX3NldGcgaWYgdGhlIGJpdG1hcCBub2RlIG5hbWUg
dGhhdCdzIGFib3V0DQo+IHRvIGdvIG92ZXIgdGhlIHdpcmUgaXMgYW4gYXV0b2dlbmVyYXRlZCBu
b2RlOiB0aGlzIGlzIG5ldmVyIGNvcnJlY3QhDQo+IA0KPiAoV2h5IG5vdD8gYmVjYXVzZSB0aGUg
dGFyZ2V0IGlzIGluY2FwYWJsZSBvZiBtYXRjaGluZyB0aGUgbm9kZS1uYW1lDQo+IGJlY2F1c2Ug
dGhleSBhcmUgcmFuZG9tbHkgZ2VuZXJhdGVkIEFORCB5b3UgY2Fubm90IHNwZWNpZnkgbm9kZS1u
YW1lcw0KPiB3aXRoICMgcHJlZml4ZXMgYXMgdGhleSBhcmUgZXNwZWNpYWxseSByZXNlcnZlZCEN
Cj4gDQo+IChUaGlzIHJhaXNlcyBhIHJlbGF0ZWQgcHJvYmxlbTogaWYgeW91IGV4cGxpY2l0bHkg
YWRkIGJpdG1hcHMgdG8gbm9kZXMNCj4gd2l0aCBhdXRvZ2VuZXJhdGVkIG5hbWVzLCB5b3Ugd2ls
bCBiZSB1bmFibGUgdG8gbWlncmF0ZSB0aGVtLikpDQo+IA0KDQpSZWxhdGVkIHByb2JsZW06DQoN
CiMgY2QgdGVzdHMvcWVtdS1pb3Rlc3RzOyBnaXQgZ3JlcCAtaWwgbWlncmF0aW9uID8/PyB8IHhh
cmdzIGdpdCBncmVwIC1pbCBtaXJyb3IgfCB4YXJncyBnaXQgZ3JlcCAtaWwgYml0bWFwIHwgd2Mg
LWwNCjANCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

