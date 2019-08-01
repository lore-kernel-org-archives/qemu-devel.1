Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47991C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F19A2080C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gHCf2Ioe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F19A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFPn-0006fO-Cm
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53848)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htFOx-0006AP-NZ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htFOw-00081U-PM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:02:07 -0400
Received: from mail-eopbgr130110.outbound.protection.outlook.com
 ([40.107.13.110]:8674 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htFOw-0007xo-HT; Thu, 01 Aug 2019 14:02:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+v7f7w3QfhVzghuerXPiDXOsmkzBkjzyrf7S+6b1mJpjE0UKCJnfi6DDo8g/oWsWDNmnoF29KfNj9ZY7P6BcGRbvHaU+o1KLT0ryR55BFitsOUi2/Uf11E+zcPvAuOoSHHfC6e7JvfV8zBvgP3aBYlj/5T3hh9eAYFZTvWRc/I2kkKYTzgU33WTe9FS2ve2oIu4Al06o9lIG721gSiRwnuqKdwihi47WeOVIURlJ2E3B7aIiMz0D6wzUSjX7tf21QZeaz2rxtpFxY2sI6OzB0WhfzqUiT2SOwG2/N2MLuUhZFUHCcGyWjSnBBVwpk0S+Dh8xyJ5xTDVRFp1E6CM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOE/Dcul0G5h/yJ67l7gjpjsgQ/GtQQ6Cov8YwFDXkI=;
 b=QLTncuacITFZeByNINQAk2lu/V+NbNxxbZLUNgcQ+Gii9aml3UuPddnOUDr9q48hFhyxSrv5cizRc49jnkX37TZAZi+ZGRQT9fP+vPNsvsEV13FGfj4q9U7yhdU+wTdwNkfybzQZAA0btfdPvNZ/bMlhGcLqVyfK7l+UZcrYXd+cSKlUTz71MhYN4IrMynHfPD68cJEJqI0czcSrk1kVadzJ2QNESy1Bvh6oXpHumPJ4JSka1gRA1AxL4lnyz8xVsj7loOOQrU67FQtWNMaOVV8d4cRNFCz6QMDWg3wKvYEsGGhwBi3HmjzkWA3pdajKTKFkqAOjb2UoVbWAntQMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOE/Dcul0G5h/yJ67l7gjpjsgQ/GtQQ6Cov8YwFDXkI=;
 b=gHCf2Ioe/uulwOMogZoRl5afXwM0osj+IQ2pUCXof275gUYslaBuN67ClQ7ev+Xrz6MTFuve6x1R8p2290foXSz3+78ESoCQ3ylRJCemfpFwgzdLi1iV2NaFNbu5Z2DrYQvkevg9TPCvBjUkucEXVnfsfROZOAbJeQqFprUhhnY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4090.eurprd08.prod.outlook.com (20.179.10.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Thu, 1 Aug 2019 18:02:01 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 18:02:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 for-4.1 2/2] iotests: Test backup job with two guest
 writes
Thread-Index: AQHVSJALgoq4bZr3nE6lb2YxC2D7qKbmlUsA
Date: Thu, 1 Aug 2019 18:02:00 +0000
Message-ID: <db2f9966-6475-1dd6-9765-bd3690efb99b@virtuozzo.com>
References: <20190801173900.23851-1-mreitz@redhat.com>
 <20190801173900.23851-3-mreitz@redhat.com>
In-Reply-To: <20190801173900.23851-3-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0047.eurprd09.prod.outlook.com
 (2603:10a6:3:45::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190801210158205
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1418c779-3a34-49ec-5eb6-08d716aa5a0a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4090; 
x-ms-traffictypediagnostic: DB8PR08MB4090:
x-microsoft-antispam-prvs: <DB8PR08MB409090537F818D6F52594CE3C1DE0@DB8PR08MB4090.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(366004)(396003)(39850400004)(376002)(189003)(199004)(68736007)(478600001)(305945005)(66066001)(71190400001)(186003)(26005)(4326008)(5660300002)(8936002)(25786009)(7736002)(81156014)(66446008)(71200400001)(14454004)(2906002)(81166006)(8676002)(4744005)(31686004)(6246003)(66946007)(66556008)(66476007)(2501003)(64756008)(53936002)(2616005)(476003)(102836004)(3846002)(386003)(6506007)(6116002)(99286004)(76176011)(6512007)(11346002)(446003)(52116002)(36756003)(86362001)(31696002)(229853002)(256004)(6486002)(54906003)(110136005)(316002)(486006)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4090;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TEIoNFsY61s+xYhYIUpExC/oICFfvwhUFvIfu8C5TfnBlsiXjYdmjYfqh4aNaT9UWNGB99M6SnwzeC7QuVEdgO4QuYUf2p15KG0B7plFd0/mJRre5GINnsPDYDTR+RzAdqrhTRJKrXEVZemEhGSoWG19SpsxJnYxGMUORE8wHXVxuAYhD4h9WcOLd+JZBWpo1Xm1gptBnkytKmHTexIhz07xBI5BwhDtSMauIXR1qk7xS48Z2UqOmmWVdHHJ1yLFge8hwG0Fm+gUw1PylFqoU7pLNKId+KZm05z7dIcWtDuqkhM2FpT5xbvE9Dd1sggwUSAGjYqjBpKVEwW7M/1vkgwcMmLhHYR+pJwx6I96Fz7fqoLuLlz/BVjZZWVMTNnU/mvInvTQRDC4bJeCC78admlwGy2Qw8fdTLRLMLrsioM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E293385CF070E34EB06166E5BFB08543@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1418c779-3a34-49ec-5eb6-08d716aa5a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 18:02:00.8816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4090
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.110
Subject: Re: [Qemu-devel] [PATCH v2 for-4.1 2/2] iotests: Test backup job
 with two guest writes
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAyMDozOSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBQZXJmb3JtIHR3byBndWVzdCB3
cml0ZXMgdG8gbm90IHlldCBiYWNrZWQgdXAgYXJlYXMgb2YgYW4gaW1hZ2UsIHdoZXJlDQo+IHRo
ZSBmb3JtZXIgdG91Y2hlcyBhbiBpbm5lciBhcmVhIG9mIHRoZSBsYXR0ZXIuDQo+IA0KPiBCZWZv
cmUgSEVBRF4sIGNvcHkgb2ZmbG9hZGluZyBicm9rZSB0aGlzIGluIHR3byB3YXlzOg0KPiAoMSkg
VGhlIHRhcmdldCBpbWFnZSBkaWZmZXJzIGZyb20gdGhlIHJlZmVyZW5jZSBpbWFnZSAod2hhdCB0
aGUgc291cmNlDQo+ICAgICAgd2FzIHdoZW4gdGhlIGJhY2t1cCBzdGFydGVkKS4NCj4gKDIpIEJ1
dCB5b3Ugd2lsbCBub3Qgc2VlIHRoYXQgaW4gdGhlIGZhaWxpbmcgb3V0cHV0LCBiZWNhdXNlIHRo
ZSBqb2INCj4gICAgICBvZmZzZXQgaXMgcmVwb3J0ZWQgYXMgYmVpbmcgZ3JlYXRlciB0aGFuIHRo
ZSBqb2IgbGVuZ3RoLiAgVGhpcyBpcw0KPiAgICAgIGJlY2F1c2Ugb25lIGNsdXN0ZXIgaXMgY29w
aWVkIHR3aWNlLCBhbmQgdGh1cyBhY2NvdW50ZWQgZm9yIHR3aWNlLA0KPiAgICAgIGJ1dCBvZiBj
b3Vyc2UgdGhlIGpvYiBsZW5ndGggZG9lcyBub3QgaW5jcmVhc2UuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KDQoNClJldmlld2VkLWJ5OiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQpUZXN0
ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpv
LmNvbT4NCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

