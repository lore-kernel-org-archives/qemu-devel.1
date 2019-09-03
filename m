Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5C1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0D421881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RnCSyWSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0D421881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i53qE-0001qP-7I
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 04:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i53pJ-00013j-ON
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i53pG-0007V3-Sv
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:06:08 -0400
Received: from mail-ve1eur01on0707.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::707]:4262
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i53pF-0007U2-Tk; Tue, 03 Sep 2019 04:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI3X28WOngzgzsPeUmRh14vO0eYxrHDrwtMdpu1S0CW0miukjbguN6nvkHqe+/arhOOYfF5CognwoerZtKiO/9gxzFr8X4Qo7Gi7xcnXfFpEUbo9bFBctSZTUsTCMmwYwZinEqlOdKqkvC1Qd9gop8SnBOEVWVUeqGRGgfSZzPh/llnnOc6KBGEchtkXVVYfv0tQh+H90g2Gk/hcr0kDgG3faO5mxsMk7ambsPD2n7uCB2/1FO/k4Jjbve57rPvcxU/GlqfdZ6VCBYQgjY1r9c81SIdMdKooBW8laZUdVxqvXeX1WoU+AqmVMEt85bF0TI5FI6QP2ARJt3jqII4lUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE5itl6HL2vMq+vUA6JyKdp07BFbmGcT7kKSJx5g7mk=;
 b=ZwSb0r8BWAhDEPlVkV+8OvgOEUorwOy7emLD2wAkOig3HRMGNFLC/iy8LtPKf4z0E3LZ8VHigxEURIuaeka2QyLrLDC0SIFsksIsEQZCP42M3wcIeX5P5eZTNYGfUr9WuSGQ8lZu8I68v87WKGO13JECcNz7ZcidkKDLB6hgkttNOoPYNqTMDjfOAFqZg1b3RW0/jkCk8RHqgjDZVuWIBXpLF2lPd8fhX/OTkoxtUp02zCRYg49w6JTD9MAqcG5l+QIDiTLAE6WCTAuAKuCA+4tkrw3Kp5YxfwZpxv3XditIwKZYOdapQvGvOOSQ1gLkuxHig/cyeq8Imb7EtVmjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE5itl6HL2vMq+vUA6JyKdp07BFbmGcT7kKSJx5g7mk=;
 b=RnCSyWSJtvQkUJir6afUoRG6Wa1489EMPY9H5AWQccIvmX+Ph4GmYBQqAj/GY6NjxM8jnNcGIPHgnvG0vQffI6WN7nZJZT3S/iVzHT08SYHKZrwE6XL0gVqbbiaUKQdXDN1V35zK663GsYJTnEbXmh7ksptSEyybSqAxEamvBQM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4153.eurprd08.prod.outlook.com (20.179.8.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Tue, 3 Sep 2019 08:06:01 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 08:06:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v9 13/13] block/backup: use backup-top instead of write
 notifiers
Thread-Index: AQHVXCk/wJbqnlynKkmIxHlXivZ53acQ+3eAgAFx+oCABjLAgIABBFIA
Date: Tue, 3 Sep 2019 08:06:01 +0000
Message-ID: <9efd8378-2e19-b3f4-e449-0d46719baebb@virtuozzo.com>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-14-vsementsov@virtuozzo.com>
 <bcfb962a-0ca1-7f3f-1db4-5098c66a08da@redhat.com>
 <0a166308-7492-7489-be60-50e150beebc1@virtuozzo.com>
 <d0235117-87f7-2e8d-83e9-4678b5e4f1bb@redhat.com>
In-Reply-To: <d0235117-87f7-2e8d-83e9-4678b5e4f1bb@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0027.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::16) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190903110558379
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4a52e40-004e-42a1-c6d6-08d730458f3e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4153; 
x-ms-traffictypediagnostic: DB8PR08MB4153:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4153DF9BEB7228A5402B6C73C1B90@DB8PR08MB4153.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(376002)(346002)(136003)(396003)(366004)(39840400004)(52314003)(189003)(199004)(99286004)(66446008)(6436002)(66556008)(66476007)(64756008)(53936002)(107886003)(66946007)(25786009)(6246003)(6512007)(31686004)(4326008)(31696002)(86362001)(2906002)(6486002)(3846002)(6116002)(36756003)(186003)(305945005)(26005)(76176011)(8936002)(229853002)(110136005)(7416002)(81166006)(81156014)(8676002)(102836004)(53546011)(6506007)(386003)(2501003)(71200400001)(11346002)(446003)(486006)(476003)(2616005)(71190400001)(14444005)(5660300002)(256004)(66066001)(14454004)(478600001)(7736002)(52116002)(54906003)(316002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4153;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yfqGAS2TYweXBkTyjHr/7w1ARBNQRqwzdddYPuXwcYq3ZbasCtUI6p/6UYnw7V33tq22Q1leZKOE+jkwYwlz2eDQy3O0bqfUbNQOkt4kEo3QYkN9p0UgrFBeCgXP/G0JCd3nl5MvAvqL2e2Vm7TkiExiv7TNwvmJymHeFFfKCTZxTH8rvDI14WBREGZ+h10coH1fgR4sytsXvyF+h4v7ae+5CFQb9Owc7atOFJ+FPdjs/zkQp7QjUf+WMOIlsa6m4QF9TehUxNikfFJtN83Akvtq+lXCjYs7Q9EIq4oNbxXrbAamB5dB18JoZDaagUB/glx1jLLEOhXHNztcN7HTjubqcEwNkWCaUChBSbEKaaUHKAFMvKxSZzxgch+lv+QL0AkaCjozrnU9xCs55cwIKkD8aAjRyJDo0ROWCMzE+rs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80415802AD74D3408564CE3314ACEBA0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a52e40-004e-42a1-c6d6-08d730458f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 08:06:01.2859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGGOA7LoVCK5K0+PiVwMqpfauYyNGFtEcNLPrHXuKV5V3Z3ggwRseo3tppvfGeJyUBYWQpn4thGDkLDmMjOGG2BD49rXBJFNP3H3I+Wr3ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4153
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::707
Subject: Re: [Qemu-devel] [PATCH v9 13/13] block/backup: use backup-top
 instead of write notifiers
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
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMDkuMjAxOSAxOTozNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4wOC4xOSAxNjo1NSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDI4LjA4LjIwMTkgMjI6NTAs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyNi4wOC4xOSAxODoxMywgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gRHJvcCB3cml0ZSBub3RpZmllcnMgYW5kIHVzZSBm
aWx0ZXIgbm9kZSBpbnN0ZWFkLg0KPj4+Pg0KPj4+PiA9IENoYW5nZXMgPQ0KPj4+Pg0KPj4+PiAx
LiBhZGQgZmlsdGVyLW5vZGUtbmFtZSBhcmd1bWVudCBmb3IgYmFja3VwIHFtcCBhcGkuIFdlIGhh
dmUgdG8gZG8gaXQNCj4+Pj4gaW4gdGhpcyBjb21taXQsIGFzIDI1NyBuZWVkcyB0byBiZSBmaXhl
ZC4NCj4+Pg0KPj4+IEkgZmVlbCBhIGJpdCBiYWQgYWJvdXQgaXQgbm90IGJlaW5nIGFuIGltcGxp
Y2l0IG5vZGUuICBCdXQgSSBrbm93IHlvdQ0KPj4+IGRvbuKAmXQgbGlrZSB0aGVtLCB0aGV54oCZ
cmUgcHJvYmFibHkganVzdCBicm9rZW4gYWx0b2dldGhlciBhbmQgYmVjYXVzZQ0KPj4+IGxpYnZp
cnQgZG9lc27igJl0IHVzZSBiYWNrdXAgKHlldCksIHByb2JhYmx5IG5vYm9keSBjYXJlcy4NCj4+
Pg0KPj4+PiAyLiB0aGVyZSBubyBtb3ZlIHdyaXRlIG5vdGlmaWVycyBoZXJlLCBzbyBpc193cml0
ZV9ub3RpZmllciBwYXJhbWV0ZXINCj4+Pg0KPj4+IHMvdGhlcmUvdGhlcmUgYXJlLywgSSBzdXBw
b3NlPw0KPj4+DQo+Pj4+IGlzIGRyb3BwZWQgZnJvbSBibG9jay1jb3B5IHBhdGhzLg0KPj4+Pg0K
Pj4+PiAzLiBJbnRlcnNlY3RpbmcgcmVxdWVzdHMgaGFuZGxpbmcgY2hhbmdlZCwgbm93IHN5bmNo
cm9uaXphdGlvbiBiZXR3ZWVuDQo+Pj4+IGJhY2t1cC10b3AsIGJhY2t1cCBhbmQgZ3Vlc3Qgd3Jp
dGVzIGFyZSBhbGwgZG9uZSBpbiBibG9jay9ibG9jay1jb3B5LmMNCj4+Pj4gYW5kIHdvcmtzIGFz
IGZvbGxvd3M6DQo+Pj4+DQo+Pj4+IE9uIGNvcHkgb3BlcmF0aW9uLCB3ZSB3b3JrIG9ubHkgd2l0
aCBkaXJ0eSBhcmVhcy4gSWYgYml0cyBhcmUgZGlydHkgaXQNCj4+Pj4gbWVhbnMgdGhhdCB0aGVy
ZSBhcmUgbm8gcmVxdWVzdHMgaW50ZXJzZWN0aW5nIHdpdGggdGhpcyBhcmVhLiBXZSBjbGVhcg0K
Pj4+PiBkaXJ0eSBiaXRzIGFuZCB0YWtlIGJkcnYgcmFuZ2UgbG9jayAoYmRydl9jb190cnlfbG9j
aykgb24gdGhpcyBhcmVhIHRvDQo+Pj4+IHByZXZlbnQgZnVydGhlciBvcGVyYXRpb25zIGZyb20g
aW50ZXJhY3Rpb24gd2l0aCBndWVzdCAob25seSB3aXRoDQo+Pj4+IGd1ZXN0LCBhcyBuZWl0aGVy
IGJhY2t1cCBub3IgYmFja3VwLXRvcCB3aWxsIHRvdWNoIG5vbi1kaXJ0eSBhcmVhKS4gSWYNCj4+
Pj4gY29weS1vcGVyYXRpb24gZmFpbGVkIHdlIHNldCBkaXJ0eSBiaXRzIGJhY2sgdG9nZXRoZXIg
d2l0aCByZWxlYXNpbmcNCj4+Pj4gdGhlIGxvY2suDQo+Pj4+DQo+Pj4+IFRoZSBhY3R1YWwgZGlm
ZmVyZW5jZSB3aXRoIG9sZCBzY2hlbWUgaXMgdGhhdCBvbiBndWVzdCB3cml0ZXMgd2UNCj4+Pj4g
ZG9uJ3QgbG9jayB0aGUgd2hvbGUgcmVnaW9uIGJ1dCBvbmx5IGRpcnR5LXBhcnRzLCBhbmQgdG8g
YmUgbW9yZQ0KPj4+PiBwcmVjaXNlOiBvbmx5IGRpcnR5LXBhcnQgd2UgYXJlIGN1cnJlbnRseSBv
cGVyYXRlIG9uLiBJbiBvbGQgc2NoZW1lDQo+Pj4+IGd1ZXN0IHdyaXRlIHRvIG5vbi1kaXJ0eSBh
cmVhICh3aGljaCBtYXkgYmUgc2FmZWx5IGlnbm9yZWQgYnkgYmFja3VwKQ0KPj4+PiBtYXkgd2Fp
dCBmb3IgaW50ZXJzZWN0aW5nIHJlcXVlc3QsIHRvdWNoaW5nIHNvbWUgb3RoZXIgYXJlYSB3aGlj
aCBpcw0KPj4+PiBkaXJ0eS4NCj4+Pj4NCj4+Pj4gNC4gVG8gc3luYyB3aXRoIGluLWZsaWdodCBy
ZXF1ZXN0cyBhdCBqb2IgZmluaXNoIHdlIG5vdyBoYXZlIGRyYWluZWQNCj4+Pj4gcmVtb3Zpbmcg
b2YgdGhlIGZpbHRlciwgd2UgZG9uJ3QgbmVlZCBydy1sb2NrLg0KPj4+Pg0KPj4+PiA9IE5vdGVz
ID0NCj4+Pj4NCj4+Pj4gTm90ZSB0aGUgY29uc2VxdWVuY2Ugb2YgdGhyZWUgb2JqZWN0cyBhcHBl
YXJpbmc6IGJhY2t1cC10b3AsIGJhY2t1cCBqb2INCj4+Pj4gYW5kIGJsb2NrLWNvcHktc3RhdGU6
DQo+Pj4+DQo+Pj4+IDEuIFdlIHdhbnQgdG8gaW5zZXJ0IGJhY2t1cC10b3AgYmVmb3JlIGpvYiBj
cmVhdGlvbiwgdG8gYmVoYXZlIHNpbWlsYXINCj4+Pj4gd2l0aCBtaXJyb3IgYW5kIGNvbW1pdCwg
d2hlcmUgam9iIGlzIHN0YXJ0ZWQgdXBvbiBmaWx0ZXIuDQo+Pj4+DQo+Pj4+IDIuIFdlIGFsc28g
aGF2ZSB0byBjcmVhdGUgYmxvY2stY29weS1zdGF0ZSBhZnRlciBmaWx0ZXIgaW5qZWN0aW9uLCBh
cw0KPj4+PiB3ZSBkb24ndCB3YW50IGl0J3Mgc291cmNlIGNoaWxkIGJlIHJlcGxhY2VkIGJ5IGZp
dGxlci4gSW5zdGVhZCB3ZSB3YW50DQo+Pj4NCj4+PiBzL2l0J3MvaXRzLywgcy9maWx0ZXIvZmls
dGVyLyAoYWx0aG91Z2gg4oCcZml0bGVy4oCdIGRvZXMgaGF2ZSBhbiBhbXVzaW5nDQo+Pj4gcmlu
ZyB0byBpdCkNCj4+Pg0KPj4+PiB0byBrZWVwIEJDUy5zb3VyY2UgdG8gYmUgcmVhbCBzb3VyY2Ug
bm9kZSwgYXMgd2Ugd2FudCB0byB1c2UNCj4+Pj4gYmRydl9jb190cnlfbG9jayBpbiBDQlcgb3Bl
cmF0aW9ucyBhbmQgaXQgY2FuJ3QgYmUgdXNlZCBvbiBmaWx0ZXIsIGFzDQo+Pj4+IG9uIGZpbHRl
ciB3ZSBhbHJlYWR5IGhhdmUgaW4tZmxpZ2h0ICh3cml0ZSkgcmVxdWVzdCBmcm9tIHVwcGVyIGxh
eWVyLg0KPj4+DQo+Pj4gUmVhc29uYWJsZSwgZXZlbiBtb3JlIHNvIGFzIEkgc3VwcG9zZSBCQ1Mu
c291cmNlIHNob3VsZCBldmVudHVhbGx5IGJlIGENCj4+PiBCZHJ2Q2hpbGQgb2YgYmFja3VwLXRv
cC4NCj4+Pg0KPj4+IFdoYXQgbG9va3Mgd3JvbmcgaXMgdGhhdCB0aGUgc3luY19iaXRtYXAgaXMg
Y3JlYXRlZCBvbiB0aGUgc291cmNlICjigJxic+KAnQ0KPj4+IGluIGJhY2t1cF9qb2JfY3JlYXRl
KCkpLCBidXQgYmFja3VwX2NsZWFudXBfc3luY19iaXRtYXAoKSBzdGlsbCBhc3N1bWVzDQo+Pj4g
aXQgaXMgb24gYmxrX2JzKGpvYi0+Y29tbW9uLmJsaykgKHdoaWNoIGlzIG5vIGxvbmdlciB0cnVl
KS4NCj4+Pg0KPj4+PiBTbywgd2UgZmlyc3RseSBjcmVhdGUgaW5qZWN0IGJhY2t1cC10b3AsIHRo
ZW4gY3JlYXRlIGpvYiBhbmQgQkNTLiBCQ1MNCj4+Pj4gaXMgdGhlIGxhdGVzdCBqdXN0IHRvIG5v
dCBjcmVhdGUgZXh0cmEgdmFyaWFibGUgZm9yIGl0LiBGaW5hbGx5IHdlIHNldA0KPj4+PiBiY3Mg
Zm9yIGJhY2t1cC10b3AgZmlsdGVyLg0KPj4+Pg0KPj4+PiA9IElvdGVzdCBjaGFuZ2VzID0NCj4+
Pj4NCj4+Pj4gNTY6IG9wLWJsb2NrZXIgZG9lc24ndCBzaG90IG5vdywgYXMgd2Ugc2V0IGl0IG9u
IHNvdXJjZSwgYnV0IHRoZW4gY2hlY2sNCj4+Pg0KPj4+IHMvc2hvdC9zaG93Lz8NCj4+Pg0KPj4+
PiBvbiBmaWx0ZXIsIHdoZW4gdHJ5aW5nIHRvIHN0YXJ0IHNlY29uZCBiYWNrdXAsIHNvIGVycm9y
IGNhdWdodCBpbg0KPj4+PiB0ZXN0X2Rpc21pc3NfY29sbGlzaW9uIGlzIGNoYW5nZWQuIEl0J3Mg
T0sgYW55d2F5LCBhcyB0aGlzIHRlc3QtY2FzZQ0KPj4+PiBzZWVtcyB0byB0ZXN0IHRoYXQgYWZ0
ZXIgc29tZSBjb2xsaXNpb24gd2UgY2FuIGRpc21pc3MgZmlyc3Qgam9iIGFuZA0KPj4+PiBzdWNj
ZXNzZnVsbHkgc3RhcnQgdGhlIHNlY29uZCBvbmUuIFNvLCB0aGUgY2hhbmdlIGlzIHRoYXQgY29s
bGlzaW9uIGlzDQo+Pj4+IGNoYW5nZWQgZnJvbSBvcC1ibG9ja2VyIHRvIGZpbGUtcG9zaXggbG9j
a3MuDQo+Pj4NCj4+PiBXZWxsLCBidXQgdGhlIG9wIGJsb2NrZXIgYmVsb25ncyB0byB0aGUgc291
cmNlLCB3aGljaCBzaG91bGQgYmUgY292ZXJlZA0KPj4+IGJ5IGludGVybmFsIHBlcm1pc3Npb25z
LiAgVGhlIGZhY3QgdGhhdCBpdCBub3cgc2hvd3MgdXAgYXMgYSBmaWxlLXBvc2l4DQo+Pj4gZXJy
b3IgdGh1cyBzaG93cyB0aGF0IHRoZSBjb25mbGljdCBhbHNvIG1vdmVzIGZyb20gdGhlIHNvdXJj
ZSB0byB0aGUNCj4+PiB0YXJnZXQuICBJdOKAmXMgT0sgYmVjYXVzZSB3ZSBhY3R1YWxseSBkb27i
gJl0IGhhdmUgYSBjb25mbGljdCBvbiB0aGUgc291cmNlLg0KPj4+DQo+Pj4gQnV0IEkgd29uZGVy
IHdoZXRoZXIgaXQgd291bGQgYmUgYmV0dGVyIGZvciB0ZXN0X2Rpc21pc3NfY29sbGlzaW9uKCkg
dG8NCj4+PiBkbyBhIGJsb2NrZGV2LWJhY2t1cCBpbnN0ZWFkIHdoZXJlIHdlIGNhbiBzZWUgdGhl
IGNvbGxpc2lvbiBvbiB0aGUgdGFyZ2V0Lg0KPj4+DQo+Pj4gSG0uICBPbiBzZWNvbmQgdGhvdWdo
dCwgd2h5IGRvIHdlIGV2ZW4gZ2V0IGEgY29uZmxpY3Qgb24gdGhlIHRhcmdldD8NCj4+PiBibG9j
ay1jb3B5IGRvZXMgc2hhcmUgdGhlIFdSSVRFIHBlcm1pc3Npb24gZm9yIGl0Li4uDQo+Pg0KPj4g
Tm90IHN1cmUsIGJ1dCBhc3N1bWUgdGhhdCB0aGlzIGlzIGJlY2F1c2UgaW4gZmlsZS1wb3NpeC5j
IGluIHJhd19jb19jcmVhdGUNCj4+IHdlIGRvIHdhbnQgUkVTSVpFIHBlcm0uDQo+Pg0KPj4gSSBj
YW4gaW5zdGVhZCBtb3ZlIHRoaXMgdGVzdCB0byB1c2Ugc3BlY2lmaWVkIGpvYi1pZCwgdG8gbW92
ZSB0aGUgY29sbGlzaW9uDQo+PiB0byAiam9iLWlkIGFscmVhZHkgZXhpc3RzIiBlcnJvci4gSXMg
aXQgYmV0dGVyPw0KPiANCj4gSXTigJlzIHByb2JhYmx5IHRoZSBvbmx5IHRoaW5nIHRoYXQgYWN0
dWFsbHkgbWFrZXMgc2Vuc2UuDQo+IA0KPj4gSSdtIGFmcmFpZCB0aGF0IHBvc2l4IGxvY2tzIHdp
bGwgbm90IHdvcmsgaWYgZGlzYWJsZSB0aGVtIGluIGNvbmZpZy4NCj4gDQo+IFllcyAob3IgaWYg
dGhlIGVudmlyb25tZW50IGRvZXNu4oCZdCBzdXBwb3J0IHRoZW0pOyB3aGljaCBpcyB3aHkgSQ0K
PiBzdWdnZXN0ZWQgdXNpbmcgYmxvY2tkZXYtYmFja3VwLiAgKEJ1dCB0aGF0IHdvdWxkIGhhdmUg
dGhlIHNhbWUgcHJvYmxlbQ0KPiBvZiDigJxXaGVyZSBkb2VzIHRoZSBwZXJtaXNzaW9uIGNvbmZs
aWN0IGV2ZW4gY29tZSBmcm9tIGFuZCBpcyBpdA0KPiBpbmV2aXRhYmxlP+KAnSkNCj4gDQo+IFsu
Li5dDQo+IA0KPj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxvY2stY29weS5jIGIvYmxvY2svYmxv
Y2stY29weS5jDQo+Pj4+IGluZGV4IDY4MjhjNDZiYTAuLmYzMTAyZWMzZmYgMTAwNjQ0DQo+Pj4+
IC0tLSBhL2Jsb2NrL2Jsb2NrLWNvcHkuYw0KPj4+PiArKysgYi9ibG9jay9ibG9jay1jb3B5LmMN
Cj4+Pj4gQEAgLTk4LDI3ICs5OCwzMiBAQCBmYWlsOg0KPj4+PiAgICAgKiBlcnJvciBvY2N1cnJl
ZCwgcmV0dXJuIGEgbmVnYXRpdmUgZXJyb3IgbnVtYmVyDQo+Pj4+ICAgICAqLw0KPj4+PiAgICBz
dGF0aWMgaW50IGNvcm91dGluZV9mbiBibG9ja19jb3B5X3dpdGhfYm91bmNlX2J1ZmZlcigNCj4+
Pj4gLSAgICAgICAgQmxvY2tDb3B5U3RhdGUgKnMsIGludDY0X3Qgc3RhcnQsIGludDY0X3QgZW5k
LCBib29sIGlzX3dyaXRlX25vdGlmaWVyLA0KPj4+PiArICAgICAgICBCbG9ja0NvcHlTdGF0ZSAq
cywgaW50NjRfdCBzdGFydCwgaW50NjRfdCBlbmQsDQo+Pj4+ICAgICAgICAgICAgYm9vbCAqZXJy
b3JfaXNfcmVhZCwgdm9pZCAqKmJvdW5jZV9idWZmZXIpDQo+Pj4+ICAgIHsNCj4+Pj4gICAgICAg
IGludCByZXQ7DQo+Pj4+IC0gICAgaW50IG5ieXRlczsNCj4+Pj4gLSAgICBpbnQgcmVhZF9mbGFn
cyA9IGlzX3dyaXRlX25vdGlmaWVyID8gQkRSVl9SRVFfTk9fU0VSSUFMSVNJTkcgOiAwOw0KPj4+
PiArICAgIGludCBuYnl0ZXMgPSBNSU4ocy0+Y2x1c3Rlcl9zaXplLCBzLT5sZW4gLSBzdGFydCk7
DQo+Pj4+ICsgICAgdm9pZCAqbG9jayA9IGJkcnZfY29fdHJ5X2xvY2soYmxrX2JzKHMtPnNvdXJj
ZSksIHN0YXJ0LCBuYnl0ZXMpOw0KPj4+PiArDQo+Pj4+ICsgICAgLyoNCj4+Pj4gKyAgICAgKiBG
dW5jdGlvbiBtdXN0IGJlIGNhbGxlZCBvbmx5IG9uIGZ1bGwtZGlydHkgcmVnaW9uLCBzbyBub2Jv
ZHkgdG91Y2hpbmcgb3INCj4+Pj4gKyAgICAgKiB0b3VjaGVkIHRoZXNlIGJ5dGVzLiBUaGVyZWZv
cmUsIHdlIG11c3Qgc3VjY2Vzc2Z1bGx5IGdldCBsb2NrLg0KPj4+DQo+Pj4gV2hpY2ggaXMgT0sg
YmVjYXVzZSBiYWNrdXAtdG9wIGRvZXMgbm90IHNoYXJlIHRoZSBXUklURSBwZXJtaXNzaW9uLiAg
QnV0DQo+Pj4gaXQgaXMgb3JnYW5pemVkIGEgYml0IHdlaXJkbHksIGJlY2F1c2UgaXTigJlzIGFj
dHVhbGx5IGJsb2NrLWNvcHkgaGVyZQ0KPj4+IHRoYXQgcmVsaWVzIG9uIHRoZSBXUklURSBwZXJt
aXNzaW9uIG5vdCB0byBiZSBzaGFyZWQ7IHdoaWNoIGl0IGl0c2VsZg0KPj4+IGNhbm5vdCBkbyBi
ZWNhdXNlIGJhY2t1cC10b3AgbmVlZHMgaXQuDQo+Pj4NCj4+PiBUaGlzIG9mIGNvdXJzZSByZXN1
bHRzIGZyb20gdGhlIGZhY3QgdGhhdCBiYWNrdXAtdG9wIGFuZCBibG9jay1jb3B5DQo+Pj4gc2hv
dWxkIHJlYWxseSB1c2UgdGhlIHNhbWUgb2JqZWN0IHRvIGFjY2VzcyB0aGUgc291cmNlLCBuYW1l
bHkgdGhlDQo+Pj4gYmFja2luZyBCZHJ2Q2hpbGQgb2YgYmFja3VwLXRvcC4NCj4+Pg0KPj4+IE1h
eWJlIHRoZXJlIHNob3VsZCBiZSBhIGNvbW1lbnQgc29tZXdoZXJlIHRoYXQgcG9pbnRzIHRoaXMg
b3V0Pw0KPj4NCj4+IEJ1dCBJIHdhbnRlZCBibG9jay1jb3B5IG5vdCB0byBiZSBkaXJlY3RseSBj
b25uZWN0ZWQgdG8gYmFja3VwLXRvcC4NCj4gDQo+IEJ1dCBpdCBkb2VzbuKAmXQgcmVhbGx5IHdv
cmsuICBUaGVyZeKAmXMgYW4gb2JzY3VyZSBjb250cmFjdCB0aGF0IGFscmVhZHkNCj4gYmluZHMg
YmxvY2stY29weSB0byBiYWNrdXAtdG9wLg0KPiANCj4+IEkgdGhpbmsgYWN0dWFsbHkgd2UgcmVs
eSBvbiB0aGUgZmFjdCB0aGF0IHVzZXIgb2YgYmxvY2stY29weSgpIGd1YXJhbnRlZXMgdGhhdA0K
Pj4gbm9ib2R5IGlzIHRvdWNoaW5nIGRpcnR5IGFyZWFzIChleGNlcHQgYmxvY2tfY29weSkuIEFu
ZCB3aXRoIGJhY2t1cCwgdGhpcyBpcyBkb25lIGJ5DQo+PiBiYWNrdXAtdG9wIGZpbHRlci4gSSds
bCBhZGQgYSBjb21tZW50IG9uIHRoaXMuDQo+IA0KPiBZZXMsIHRoYXTigJlzIHRoZSBjb250cmFj
dC4gIEFuZCBpdOKAmXMgd2VpcmQsIGJlY2F1c2UgYmxvY2stY29weSBoYXMgaXRzDQo+IG93biBC
Qiwgc28gaWYgaXQgZG9lc27igJl0IHdhbnQgYW55b25lIHRvIHdyaXRlDQoNCmRvZXNuJ3Qgd2Fu
dCBhbnlvbmUgdG8gd3JpdGUgdG8gZGlydHkgYXJlYXMsIGFuZCB3ZSBkb24ndCBoYXZlIHN1Y2gg
b3B0aW9uIGluIHRoZSBwZXJtaXNzaW9uDQpzeXN0ZW0uLi4NCg0KPiB0byB0aGUgc291cmNlIG91
dHNpZGUgb2YNCj4gaXRzIGNvbnRyb2wsIGl0IHNob3VsZCBqdXN0IHVuc2hhcmUgdGhlIFdSSVRF
IHBlcm1pc3Npb24g4oCTIGJ1dCBpdCBjYW5ub3QNCj4gZG8gdGhhdCwgYmVjYXVzZSBpdHMgdXNl
ciBuZWVkcyBXUklURSBhY2Nlc3MsIGFuZCBzbyBpdCBpbXBsaWNpdGx5DQo+IHJlbGllcyBvbiB0
aGF0IHVzZXIgdG8gdGhlbiB1bnNoYXJlIFdSSVRFLg0KPiANCj4gSWYgYm90aCB1c2VkIHRoZSBz
YW1lIHNpbmdsZSBCZHJ2Q2hpbGQsIGl0IHdvdWxkIGJlIGNsZWFyDQo+IA0KPiAoMSkgd2h5IHRo
ZSBCZHJ2Q2hpbGQgYmVsb25ncyB0byBibG9jay1jb3B54oCZcyB1c2VyIChiZWNhdXNlIGJsb2Nr
LWNvcHnigJlzDQo+IHVzZXIgd291bGQgbmVlZCB0byBvd24gYSBub2RlIHRoYXQgdGhlbiBoYXMg
dGhpcyBCZHJ2Q2hpbGQpLA0KPiANCj4gKDIpIHdoeSBibG9jay1jb3B5IGRvZXMgbm90IHVuc2hh
cmUgdGhlIFdSSVRFIHBlcm1pc3Npb24gKGl0IGNhbm5vdCwNCj4gYmVjYXVzZSBpdCBkb2VzbuKA
mXQgY3JlYXRlIHRoZSBCZHJ2Q2hpbGQpLA0KPiANCj4gKDMpIGhvdyBibG9jay1jb3B5IGNvdWxk
IGV4cGxpY2l0bHkgZW5zdXJlIHRoYXQgV1JJVEUgaXMgdW5zaGFyZWQgKGJ5DQo+IGFzc2VydGlu
ZyAhKGNoaWxkLT5zaGFyZWRfcGVybSAmIFdSSVRFKSkuDQo+IA0KPiANCj4gSeKAmW0gbm90IHNh
eWluZyB0aGF0IHdlIG5lZWQgdG8gYWJhbmRvbiBoYXZpbmcgQkJzIHJpZ2h0IG5vdywgYnV0IEkg
dGhpbmsNCj4gdGhlcmUgYXJlIGEgY291cGxlIG9mIGNhc2VzIHdoaWNoIHNob3cgd2h5IEkgc2F5
IGl04oCZcyB1Z2xpZXIgdGhhbiB1c2luZw0KPiBCZHJ2Q2hpbGRyZW4gaW5zdGVhZC4NCj4gDQoN
Ck9LLiBJJ2QgcHJlZmVyIHRvIG1vdmUgYmxvY2stY29weSB0byBCZHJ2Q2hpbGRyZW4gYXMgZm9s
bG93LXVwLCBpZiB5b3UgZG9uJ3QgbWluZC4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=

