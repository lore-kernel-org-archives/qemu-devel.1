Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B9C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087DF20842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rqrDDarQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087DF20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFeDd-0008SE-6B
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFeCs-000812-Fw
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFeCq-00060S-TA
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:58:14 -0400
Received: from mail-eopbgr140132.outbound.protection.outlook.com
 ([40.107.14.132]:24352 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFeCq-0005zY-6q
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:58:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQpSJK0cAfTScyVhc9OW3bUQQCO0QTuVChYJMmcAjFBhqIj9s6e3OuCqWQrK4cuQ8XFRL0oHgDt49Rkw8xHafC8mlIpKZaCJDzgrNp70MhUR6B89mdX/A8zKhj9WxRgtyG2ISDv30R07X8Y8zPlhwZ/1bfIq4cAtvVfYrJx/MGa1lUgB+rl68F7pHtwuOulWm1mnVD8SmHj+1BA/eFqP12AlnqZ6Ll1IviDODf1I/lowkJlIGuk1KbDbTUFrzpoTwvFhFYksOB7HK+QomJM+cGEhvXU1EOVJse4paUmjuhBUAq1HpurYSCD7kk/Q6Cy65BdmE3SXD53xi4NGszCxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6SXV4MFD9GTTtykN8FgwQcz3X/vq+8082+HycpuGRQ=;
 b=f5YisHAJKch1sdq7tHM6ZGKYSYcnJFeMg9HfTRmMIcQcTN62YaRQ1HF+cwL5fCpByOeQaPBympUGbUHrz1Tu2fYluTgFyxGuaEzm9Iu6eIvVZfvR63f8vCOHBnKFR0HIZ6VMktpEkNhUecj4iAu66UX8dlNeZ0wgHNHXlkez+YEStRD8CGWSWxH5iEFhaMs4/hZRVRHqnBrACZSeh0hTjQZ4w6G1CPLfqcYx+jrzWb3XJ6Dzo27PcNadldTiWAIhWMDDpyamzovrEBMt5puL+N13tPnRYMXGvNNCaoSRA8DAe9oPWfqJaMmDcGER2a2kVGJYgc1uWPGLlJGz4xnFTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6SXV4MFD9GTTtykN8FgwQcz3X/vq+8082+HycpuGRQ=;
 b=rqrDDarQ6eIEpKs5qrW6NxZbOE2fRV/m/IcrTS8PA1xUCCihbtbBwGtWNrdT3XMta5LQh7vIkQlHObo9t8GAFxtB0CT/Xu80u93jG28EDbzAJboStvjbgBN92oQ17TWH9TUBNe3+FYTZyEJzPfLPSyuknFDeAzNXcFCp1sKMuO0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5402.eurprd08.prod.outlook.com (52.133.241.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 12:58:09 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 12:58:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 21/31] virtio-9p: Fix error_append_hint/error_prepend
 usage
Thread-Topic: [PATCH v4 21/31] virtio-9p: Fix error_append_hint/error_prepend
 usage
Thread-Index: AQHVeHBjsJBaOkT9y0K+qBVLhCi+pKdHFAcAgAA9KQA=
Date: Wed, 2 Oct 2019 12:58:08 +0000
Message-ID: <6413b323-2b2b-b5b5-3a19-46330bca0140@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-22-vsementsov@virtuozzo.com>
 <20191002111912.647a4470@bahia.lan>
In-Reply-To: <20191002111912.647a4470@bahia.lan>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0043.eurprd09.prod.outlook.com
 (2603:10a6:7:15::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191002155806695
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 200b84f4-6b81-4fc7-c33c-08d747382c9e
x-ms-traffictypediagnostic: DB8PR08MB5402:
x-microsoft-antispam-prvs: <DB8PR08MB5402A131662DB59A90CB00EFC19C0@DB8PR08MB5402.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39850400004)(376002)(366004)(136003)(52314003)(199004)(189003)(186003)(316002)(446003)(6506007)(52116002)(99286004)(102836004)(26005)(386003)(6436002)(14454004)(36756003)(66556008)(6512007)(76176011)(31686004)(86362001)(31696002)(229853002)(25786009)(478600001)(5660300002)(6246003)(476003)(4326008)(11346002)(486006)(2616005)(66446008)(66476007)(6916009)(3846002)(7736002)(8936002)(6116002)(64756008)(305945005)(71200400001)(71190400001)(66066001)(66946007)(6486002)(81156014)(8676002)(81166006)(2906002)(14444005)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5402;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OqKe8lqsTvRVvjyAJXcKXC7ZdAF3iVqfq2yeYmnBvWSP6EoVBgoO7wjBoGGaq2bjzP89IDUyQQAF7gf9xxsCEVUE/ORWmkOmKcQxi6MlHfLtbk4sGeCaFW0qbR+YEPzDW5r1kA24LWDU8QNGqFHt6mh8axG+RQfkvdc4xyUpMK1hA0xILHGDEQBND/v0nLPk5DZfI/m8GltkoX7BkIg1eydqPuDp/iNUTOzLgHRdbyLe5A7+ITvLDMpGe9psDF4+/zrhmrcpGB4Av7AFzWa5dsb/Q6iOCiGra/Z4VibAdmhMRE5HHaFVFMpXtPc0V9V3I8WBT/98fpNwmLgYVWqvUIWq3H07NBe5Ur8N5j8W9ZsCudmaKplNXnbNLVbHhiryBpGqiT8bdDQpaC49px/Tie8i/OZ29BOZ9Pt2gIBf3VY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B680E163C06D644BE75D6F1C381577F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200b84f4-6b81-4fc7-c33c-08d747382c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 12:58:08.9718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3uY3IzwaBI9khQRjKLRDPFEtXV9rXNHUeUVusuyTMG53gdmKTPceij4eAB8aBtEEV6peVzqB8Ue9SFP7rFd8BuIydZygGvza+Cv2hTZQ6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5402
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.132
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMTAuMjAxOSAxMjoxOSwgR3JlZyBLdXJ6IHdyb3RlOg0KPiBPbiBUdWUsICAxIE9jdCAyMDE5
IDE4OjUzOjA5ICswMzAwDQo+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6DQo+IA0KPj4gSWYgd2Ugd2FudCB0byBhZGQgc29tZSBp
bmZvIHRvIGVycnAgKGJ5IGVycm9yX3ByZXBlbmQoKSBvcg0KPj4gZXJyb3JfYXBwZW5kX2hpbnQo
KSksIHdlIG11c3QgdXNlIHRoZSBFUlJQX0FVVE9fUFJPUEFHQVRFIG1hY3JvLg0KPj4gT3RoZXJ3
aXNlLCB0aGlzIGluZm8gd2lsbCBub3QgYmUgYWRkZWQgd2hlbiBlcnJwID09ICZmYXRhbF9lcnIN
Cj4+ICh0aGUgcHJvZ3JhbSB3aWxsIGV4aXQgcHJpb3IgdG8gdGhlIGVycm9yX2FwcGVuZF9oaW50
KCkgb3INCj4+IGVycm9yX3ByZXBlbmQoKSBjYWxsKS4gIEZpeCBzdWNoIGNhc2VzLg0KPj4NCj4g
DQo+IFdlbGwuLi4gdGhpcyBwYXRjaCBkb2Vzbid0IHJlYWxseSBmaXggYW55dGhpbmcgYmVjYXVz
ZS4uLg0KDQpJJ20gc3VyZSBpdCBmaXhlcy4gQnV0IGl0IGFsc28gYnJlYWtzIHNvbWUgdGhpbmdz
IHlvdSBtZW50aW9uIGJlbG93Li4NCg0KPiANCj4+IFRoaXMgY29tbWl0ICh0b2dldGhlciB3aXRo
IGl0cyBuZWlnaGJvcnMpIHdhcyBnZW5lcmF0ZWQgYnkNCj4+DQo+PiBnaXQgZ3JlcCAtbCAnZXJy
b3JfXChhcHBlbmRfaGludFx8cHJlcGVuZFwpKGVycnAnIHwgd2hpbGUgcmVhZCBmOyBkbyBcDQo+
PiBzcGF0Y2ggLS1zcC1maWxlIHNjcmlwdHMvY29jY2luZWxsZS9maXgtZXJyb3ItYWRkLWluZm8u
Y29jY2kgXA0KPj4gLS1pbi1wbGFjZSAkZjsgZG9uZQ0KPj4NCj4+IGFuZCB0aGVuDQo+Pg0KPj4g
Li9weXRob24vY29tbWl0LXBlci1zdWJzeXN0ZW0ucHkgTUFJTlRBSU5FUlMgIiQoPCBhdXRvLW1z
ZykiDQo+Pg0KPj4gKGF1dG8tbXNnIHdhcyBhIGZpbGUgd2l0aCB0aGlzIGNvbW1pdCBtZXNzYWdl
KQ0KPj4NCj4+IGFuZCB0aGVuIGJ5IGhhbmQsIGZvciBub3QgbWFpbnRhaW5lZCBjaGFuZ2VkIGZp
bGVzOg0KPj4NCj4+IGdpdCBjb21taXQgLW0gIjxTVUItU1lTVEVNPjogJCg8IGF1dG8tbXNnKSIg
PEZJTEVTPg0KPj4NCj4+IFN0aWxsLCBmb3IgYmFja3BvcnRpbmcgaXQgbWF5IGJlIG1vcmUgY29t
Zm9ydGFibGUgdG8gdXNlIG9ubHkgdGhlIGZpcnN0DQo+PiBjb21tYW5kIGFuZCB0aGVuIGRvIG9u
ZSBodWdlIGNvbW1pdC4NCj4+DQo+PiBSZXBvcnRlZC1ieTogR3JlZyBLdXJ6IDxncm91Z0BrYW9k
Lm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBody85cGZzLzlwLWxvY2FsLmMg
fCAxICsNCj4+ICAgaHcvOXBmcy85cC1wcm94eS5jIHwgMSArDQo+PiAgIGh3LzlwZnMvOXAuYyAg
ICAgICB8IDEgKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ody85cGZzLzlwLWxvY2FsLmMgYi9ody85cGZzLzlwLWxvY2FsLmMNCj4+
IGluZGV4IDA4ZTY3M2E3OWMuLmZjY2JmNzU4YmQgMTAwNjQ0DQo+PiAtLS0gYS9ody85cGZzLzlw
LWxvY2FsLmMNCj4+ICsrKyBiL2h3LzlwZnMvOXAtbG9jYWwuYw0KPj4gQEAgLTE0NzEsNiArMTQ3
MSw3IEBAIHN0YXRpYyB2b2lkIGxvY2FsX2NsZWFudXAoRnNDb250ZXh0ICpjdHgpDQo+PiAgIA0K
Pj4gICBzdGF0aWMgdm9pZCBlcnJvcl9hcHBlbmRfc2VjdXJpdHlfbW9kZWxfaGludChFcnJvciAq
KmVycnApDQo+PiAgIHsNCj4+ICsgICAgRVJSUF9BVVRPX1BST1BBR0FURSgpOw0KPj4gICAgICAg
ZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwgIlZhbGlkIG9wdGlvbnMgYXJlOiBzZWN1cml0eV9tb2Rl
bD0iDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAiW3Bhc3N0aHJvdWdofG1hcHBlZC14YXR0
cnxtYXBwZWQtZmlsZXxub25lXVxuIik7DQo+PiAgIH0NCj4gDQo+IFRoaXMgZnVuY3Rpb24gZG9l
c24ndCBuZWVkIGF1dG8gcHJvcGFnYXRpb24gaW4gdGhlIGZpcnN0IHBsYWNlLiBJdCBpcw0KPiBz
aW1wbHkgYSB3cmFwcGVyIGFyb3VuZCBlcnJvcl9hcHBlbmRfaGludCgpLiBFUlJQX0FVVE9fUFJP
UEFHQVRFKCkNCj4gc2hvdWxkIGdvIHRvIHRoZSBjYWxsZXIgbG9jYWxfcGFyc2Vfb3B0cygpLg0K
DQpIbW0sIHRoYXQncyBiYWQuIFNvLCBhY3R1YWxseSBpdCdzIG9uZSBtb3JlIGVycnAgSU4gcGFy
YW1ldGVyLg0KDQo+IA0KPiBBbHNvIHNvbWUgZXh0cmEgY2FyZSBpcyBuZWVkZWQgdGhlcmUgdG8g
aGFuZGxlIHBhcnQgWzMuXSBvZiB0aGUNCj4gY2xlYW51cC4gSSB1bmRlcnN0YW5kIHRoaXMgaXMg
b3V0IG9mIHRoZSBzY29wZSBvZiB0aGF0IHNlcmllcywNCj4gYnV0IEknZCByYXRoZXIgc2VlIGFs
bCBvZiB0aGlzIGZpeGVkIGluIHRoZSBzYW1lIHBhdGNoLg0KPiANCj4+IGRpZmYgLS1naXQgYS9o
dy85cGZzLzlwLXByb3h5LmMgYi9ody85cGZzLzlwLXByb3h5LmMNCj4+IGluZGV4IDU3YThjMWM4
MDguLjkyOTFjOGVmYTIgMTAwNjQ0DQo+PiAtLS0gYS9ody85cGZzLzlwLXByb3h5LmMNCj4+ICsr
KyBiL2h3LzlwZnMvOXAtcHJveHkuYw0KPj4gQEAgLTExMTYsNiArMTExNiw3IEBAIHN0YXRpYyBp
bnQgY29ubmVjdF9uYW1lZHNvY2tldChjb25zdCBjaGFyICpwYXRoLCBFcnJvciAqKmVycnApDQo+
PiAgIA0KPj4gICBzdGF0aWMgdm9pZCBlcnJvcl9hcHBlbmRfc29ja2V0X3NvY2tmZF9oaW50KEVy
cm9yICoqZXJycCkNCj4+ICAgew0KPj4gKyAgICBFUlJQX0FVVE9fUFJPUEFHQVRFKCk7DQo+PiAg
ICAgICBlcnJvcl9hcHBlbmRfaGludChlcnJwLCAiRWl0aGVyIHNwZWNpZnkgc29ja2V0PS9zb21l
L3BhdGggd2hlcmUgL3NvbWUvcGF0aCINCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICIgcG9p
bnRzIHRvIGEgbGlzdGVuaW5nIEFGX1VOSVggc29ja2V0IG9yIHNvY2tfZmQ9ZmQiDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAiIHdoZXJlIGZkIGlzIGEgZmlsZSBkZXNjcmlwdG9yIHRvIGEg
Y29ubmVjdGVkIEFGX1VOSVgiDQo+IA0KPiBTYW1lIGhlcmUuIEVSUlBfQVVUT19QUk9QQUdBVEUo
KSBzaG91bGQgZ28gdG8gcHJveHlfcGFyc2Vfb3B0cygpLg0KDQphbmQgdGhpcyBvbmUuDQoNCj4g
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvOXBmcy85cC5jIGIvaHcvOXBmcy85cC5jDQo+PiBpbmRleCBj
Y2UyMzY2MjE5Li4xZGYyNzQ5ZTAzIDEwMDY0NA0KPj4gLS0tIGEvaHcvOXBmcy85cC5jDQo+PiAr
KysgYi9ody85cGZzLzlwLmMNCj4+IEBAIC0zNTUyLDYgKzM1NTIsNyBAQCB2b2lkIHBkdV9zdWJt
aXQoVjlmc1BEVSAqcGR1LCBQOU1zZ0hlYWRlciAqaGRyKQ0KPj4gICBpbnQgdjlmc19kZXZpY2Vf
cmVhbGl6ZV9jb21tb24oVjlmc1N0YXRlICpzLCBjb25zdCBWOWZzVHJhbnNwb3J0ICp0LA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gICB7DQo+
PiArICAgIEVSUlBfQVVUT19QUk9QQUdBVEUoKTsNCj4gDQo+IFRoaXMgaXMgY29ycmVjdCBzaW5j
ZSB0aGlzIGZ1bmN0aW9uIGNhbGxzIGVycm9yX3ByZXBlbmQoKSBidXQgSSB0aGluaw0KPiBlcnJw
IGlzIG5ldmVyICZlcnJvcl9mYXRhbCBvciAmZXJyb3JfYWJvcnQgb24gdGhlIHJlYWxpemUgcGF0
aC4gQW55d2F5LA0KPiBiZXR0ZXIgc2FmZSB0aGFuIHNvcnJ5Lg0KPiANCj4+ICAgICAgIGludCBp
LCBsZW47DQo+PiAgICAgICBzdHJ1Y3Qgc3RhdCBzdGF0Ow0KPj4gICAgICAgRnNEcml2ZXJFbnRy
eSAqZnNlOw0KPiANCj4gUGxlYXNlIGRyb3AgdGhpcyBwYXRjaCBmcm9tIHlvdXIgc2VyaWVzIGFu
ZCBJJ2xsIGRvIHRoZSBjaGFuZ2Ugb25jZQ0KPiBFUlJQX0FVVE9fUFJPUEFHQVRFKCkgZ2V0cyBt
ZXJnZWQuDQo+IA0KPiBHcmVhdCB0aGFua3MgZm9yIHlvdXIgdGltZSBpbiBmaW5kaW5nIGEgY2xl
dmVyIHdheSB0byBkZWFsIHdpdGggZXJyb3INCj4gcHJvcGFnYXRpb24uIDopDQo+IA0KDQpIbW0s
IGFjdHVhbCBxdWVzdGlvbiBpczogaG93IG1hbnkgb3RoZXIgZXJycCBJTiBwYXJhbWV0ZXJzIEkn
dmUgYnJva2VuIGluDQp0aGVzZSBzZXJpZXM/DQoNCkkgY2FuJ3Qgc2ltcGx5IGRyb3Agb25lIHBh
dGNoIGZyb20gYXRvbWF0aWNhbGx5IGdlbmVyZWF0ZWQgc2VyaWVzOiBob3cgcGVvcGxlDQp3aWxs
IGJhY2twb3J0IGl0IHRoYW4sIG9yIHVuZGVyc3RhbmQgaG93IHRvIGJhY2twb3J0IG90aGVyIGNy
b3NzaW5nIHRoaW5ncz8NCg0KQWN0dWFsbHksIGZvciB0aGUgY2FzZXMgeW91IG1lYW4sIEVSUlBf
QVVUT19QUk9QQUdBVEUgaXMgbm8tb3AsIGFzIGl0IHVzZXMgb3JpZ2luYWwNCmVycnAgaWYgaXQn
cyBub3QgTlVMTCBhbmQgZG9uJ3QgcG9pbnQgdG8gZXJyb3JfZmF0YWwuDQoNClNvLCBub3RoaW5n
IGlzIGJyb2tlbiBoZXJlLCBtYXkgYmUgd2UgY2FuIHByb2NlZWQgYXMgaXM/IEJ1dCBJIGFncmVl
LCBpdCBsb29rcyBzdHJhbmdlLg0KDQpFcmljLCB3aGF0IGRvIHlvdSB0aGluaz8NCg0KSSB0cmll
ZCB0byBjaGFuZ2UgY29jY2kgc2NyaXB0IHRvDQoNCiAgIEBydWxlMEANCiAgIC8vIEFkZCBpbnZv
Y2F0aW9uIHRvIGVycnAtZnVuY3Rpb25zDQp+IGlkZW50aWZpZXIgZm4sIGZuMjsNCiAgIEBADQoN
CiAgICBmbiguLi4sIEVycm9yICoqZXJycCwgLi4uKQ0KICAgIHsNCiAgICsgICBFUlJQX0FVVE9f
UFJPUEFHQVRFKCk7DQogICAgICAgPCsuLi4NCisgICAgIGZuMiguLi4sIGVycnAsIC4uLikNCisg
ICAgIC4uLg0KICAgKA0KICAgICAgIGVycm9yX2FwcGVuZF9oaW50KGVycnAsIC4uLik7DQogICB8
DQogICAgICAgZXJyb3JfcHJlcGVuZChlcnJwLCAuLi4pOw0KICAgKQ0KICAgICAgIC4uLis+DQog
ICAgfQ0KDQoNCmJ1dCBpdCBzdHVicyBvbiBody92ZmlvL3BjaS5jLi4uIGFuZCBpdCBza2lwcyBh
IGxvdCBvZiB2YWxpZCBjYXNlcywgc28gaXQncyB3cm9uZy4NCg0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

