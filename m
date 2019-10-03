Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A879C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E9C20679
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eBB2HTlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E9C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG2ir-0008Bf-0D
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 11:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2eG-00059X-5Q
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2e8-00081j-O7
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:04:06 -0400
Received: from mail-ve1eur03on071e.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::71e]:39047
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG2e7-0007xc-Oq; Thu, 03 Oct 2019 11:04:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jsgm5KDnoErYhgD20SBIYd42JPI+1nWMD2WBVwLxm8EOn11fIvyW7mK5Ogrj3qe7+JpwrL9CMnUDYzsv/O6hYTgX/WJbgsQ8TNQTK6DwvrrzepHXka15KA0reo/qv0ADzcSXt4rKtAVVyxLSRmQe1PcInNJuIOIzIkROE4YvoUkwumbcgZ6yu2TJj4nwnNkCA1AQHfXCAAfK4014oGtHDsIW+pLXSCbX3lAi+43ZBD1BltyCR9qGDvNvv6UELy0fr47iVXbDk8wt47vnbRiyaw9WUPd8kJLT5WCSnLQ58YwUcseNc0ACKuahad1f8WsLPWDdj2b1S+2vhO+5j3+Eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoWJNQLUZvyaU5NGcXeF+VZ+LaNDadakoOw+Mc5NWPM=;
 b=g7HQQjcNOsuICIr64L9E29r5uH9sGYtyJJyvRfWmoSVLee0TaTzdi/1wvtrM/4qSYaKzoj+3ScIVoUI7kWDl8+6QXyWPPJHcA+/7a+FqBxgJcgq709lz7IfIFhogzUyRvpf3goepwr6Qnebh9xRZ33LJUZGHA4VvD89EPNAjyenJpxRShS/2YY3C4HXpRe3f/KjSZMjkjp6m4i0lccA9qs4Np4qCyZg79k6KvP09zGFCiwjdisV8MZlJVIxsJNpNXFpkf5dbO8AHaov6U4yF+XHwKfzeNjqtoy6ORhYKdZf0YKDY1AKE8ichL/z8hbnZ4e6K1f26hxWkk4M6D5yv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoWJNQLUZvyaU5NGcXeF+VZ+LaNDadakoOw+Mc5NWPM=;
 b=eBB2HTlI5b6L2NIr19bordn8YZvywmb8EM1zn+hT0HyNulxpyp5ftXsAxijcy3ZXwx5euDSlp3nb2FBh3/P6XKDLi/INVsktJcr6bKG2oQPrsvx4BkwVAIa+dtALHWJmTubSvdv3iweZ0Thu2dy0w+gGk8/D9xkhXtA95HCy4jA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5402.eurprd08.prod.outlook.com (52.133.241.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 15:03:53 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 15:03:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 01/67] iotests.py: Read $IMGOPTS
Thread-Topic: [PATCH 01/67] iotests.py: Read $IMGOPTS
Thread-Index: AQHVeJG1z28GWtBMO0uFaVhyXaBVUadGWqSAgAKrvwA=
Date: Thu, 3 Oct 2019 15:03:53 +0000
Message-ID: <77ff69c3-cd38-876f-e16d-611017f57e49@virtuozzo.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
 <20191001194715.2796-2-mreitz@redhat.com>
 <c3feccfd-b967-3ee8-dc0c-9f48fc849741@redhat.com>
In-Reply-To: <c3feccfd-b967-3ee8-dc0c-9f48fc849741@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:7:67::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191003180350705
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6206d041-b719-45a9-7a34-08d74812e7db
x-ms-traffictypediagnostic: DB8PR08MB5402:
x-microsoft-antispam-prvs: <DB8PR08MB5402A569BFE5CDF9BF4131E3C19F0@DB8PR08MB5402.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39840400004)(376002)(136003)(346002)(189003)(199004)(110136005)(66446008)(186003)(446003)(26005)(52116002)(99286004)(102836004)(6506007)(6436002)(14454004)(36756003)(66556008)(6512007)(76176011)(386003)(53546011)(31686004)(31696002)(25786009)(256004)(86362001)(478600001)(5660300002)(6246003)(476003)(2616005)(486006)(4326008)(11346002)(6116002)(7736002)(8936002)(3846002)(316002)(2501003)(54906003)(305945005)(71200400001)(66066001)(66946007)(6486002)(71190400001)(8676002)(81166006)(2906002)(81156014)(64756008)(229853002)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5402;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7SOC1pPDI62LLXFK7FdiBCklAUB6/RekSi/uj5AZp+FuQ2/HL/QyOpI6KZuKLmT5n7UZ1/W4vjLXxH0RTtBbPuATikoLkqTaTLYwFlBjPDaQuDvDSUEnMSoD3T0BqDnZ4e68/U+4oADj8yr0pd/qWFrnwpKO3fzvLraVE3Aoeez43AUBXjPmoyxT/wwH8CIf7mW1/GxooQ+m9KUunpFN/fIyZDOfu0DwFEIE5mj3RggGqEZnjaSK/1LvsR9NdwdPz6bOikcpeIHq3Z/Ti2ih71bcPm6HSbhGqsCTJreS7p1Is5hyrUGroMIWGJNTc58mq1XfijF/SPMzJaGmv4VyFWBaE+e9Mp7BcFsOKjDUat4RcgDRb+CmxpBO1OFTVYYEK2Fm59QqqfHvN3TaV+hIAEJvL3wP17xQHwFzc1/7Wc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A32C9B87B27F84394B3C45297078EC9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6206d041-b719-45a9-7a34-08d74812e7db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 15:03:53.4197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJdXLiJLvDBcsv6YIU+94uKdXEgdNv+L5f8+S/+ySItA1yfCthh0WldTESVTZ6Z2ImequIAiy0RnTbwnvenTMvvkHG5xORHlIDch3vwLCu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5402
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::71e
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMTAuMjAxOSAxOjE2LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gMTAvMS8xOSAz
OjQ2IFBNLCBNYXggUmVpdHogd3JvdGU6DQo+PiBXZSBkbyBub3QgZG8gYW55dGhpbmcgd2l0aCB5
ZXQsIGJ1dCB0aGlzIGlzIHRoZSBmaXJzdCBzdGVwLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1h
eCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rl
c3RzL2lvdGVzdHMucHkgfCA2ICsrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5
IGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4+IGluZGV4IDFjNWZjZTNlOWUuLjcw
MzA5MDA4MDcgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0K
Pj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4+IEBAIC02OSw2ICs2OSwx
MiBAQCBvdXRwdXRfZGlyID0gb3MuZW52aXJvbi5nZXQoJ09VVFBVVF9ESVInLCAnLicpDQo+PiAg
IGNhY2hlbW9kZSA9IG9zLmVudmlyb24uZ2V0KCdDQUNIRU1PREUnKQ0KPj4gICBxZW11X2RlZmF1
bHRfbWFjaGluZSA9IG9zLmVudmlyb24uZ2V0KCdRRU1VX0RFRkFVTFRfTUFDSElORScpDQo+PiAg
IA0KPj4gK2ltZ29wdHMgPSBvcy5lbnZpcm9uLmdldCgnSU1HT1BUUycsICcnKQ0KPj4gK2lmIGxl
bihpbWdvcHRzKSA9PSAwOg0KPj4gKyAgICBpbWdvcHRzID0gW10NCj4+ICtlbHNlOg0KPj4gKyAg
ICBpbWdvcHRzID0gaW1nb3B0cy5zcGxpdCgnLCcpDQo+PiArDQo+IA0KPiBTb21ldGltZXMgSSB0
aGluayBhYm91dCB0aGUgdHlwZSBvZiBwZXJzb24gSSdkIGxpa2UgdG8gbWVldCwgYW5kIEkgYXNr
DQo+IG15c2VsZiBpZiBpdCdzIHRoZSB0eXBlIG9mIHBlcnNvbiB3aG8gd291bGQgcXVvdGUgcGVw
OCwgb3Igc2F5IHRoaW5ncw0KPiBsaWtlICJpZGlvbWF0aWMgcHl0aG9uIiBpbiBhIGNvZGUgcmV2
aWV3IHdoZW4gdGhlIGV4aXN0aW5nIGZvcm0gaGFzIG5vDQo+IHRlY2huaWNhbCBwcm9ibGVtIHdo
YXRzb2V2ZXIuDQo+IA0KPiBJIHdvbmRlciB3aGF0IHR5cGUgb2YgcGVyc29uIEkgYW0uDQo+IA0K
PiBXZWxsLCBxdWVzdGlvbnMgZm9yIGFub3RoZXIgZGF5Lg0KDQpIb3BlIHlvdSBkb24ndCBzYXkg
YWJvdXQgcXVvdGluZywgYXMgcGVwOCAiZG9lcyBub3QgbWFrZSBhIHJlY29tbWVuZGF0aW9uIGZv
ciB0aGlzIi4NCg0KPiANCj4+ICAgc29ja2V0X3NjbV9oZWxwZXIgPSBvcy5lbnZpcm9uLmdldCgn
U09DS0VUX1NDTV9IRUxQRVInLCAnc29ja2V0X3NjbV9oZWxwZXInKQ0KPj4gICANCj4+ICAgbHVr
c19kZWZhdWx0X3NlY3JldF9vYmplY3QgPSAnc2VjcmV0LGlkPWtleXNlYzAsZGF0YT0nICsgXA0K
Pj4NCj4gDQo+IFJldmlld2VkLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+DQo+IA0K
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

