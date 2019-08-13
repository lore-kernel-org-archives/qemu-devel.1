Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0597DC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 08:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C295320679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 08:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iI85YNhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C295320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxSM8-0005DU-1Z
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 04:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45332)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxSLZ-0004hn-Mt
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 04:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxSLY-00056a-L6
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 04:40:01 -0400
Received: from mail-eopbgr50138.outbound.protection.outlook.com
 ([40.107.5.138]:48462 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxSLY-000567-3l; Tue, 13 Aug 2019 04:40:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHwfQ210UtrqNLIq0/yk9KKllVyPsP7Ukq+fM35N6ahiPNiqMEMdGdcRxfiorLdR6C6AdDilPUZtJkDpliny2gZwdBnh34ID2+Zuy2ZnvhUfSHwlTc1kz2Cw0lM8QwDbHNOHOgMYBLNDwdNWjtVvYEme5rTNnA+zWWt4UTz6H/8XDVwiwGcmPH3408/cTJ18ZgOVkJAGA2HDHuSKiyGLHnp7MNmUdf9WhIjXJP6WzARrS4brvso4ee+6+Mfp3mfbwD37nsyjb7CFadhuuAdMRfvU1Ngffka199KrtyIMeO8nsy2hovdDfOAhn1PxJMtMgzmfbaaxC/bYzw9oaD0WoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvns3zVtMyZX/fXa/SUG1nibiTOV5CqUCKLnK4MmYgw=;
 b=fvsMO74/PoW602JeYyo0N547FxG0rPF3xssoqUyU5F9bnKj5Lw8whe+cIsWj+D3fdt2AZAK9+94ddiSJpwGRf5GmUjJwt1YNxIFohuswF7e1XJLSBUuyhuiP++p/vLqyShroClQma7PmpS2x3SNN06pieA+SkLRWFhgx1bRBPL4sir2TUX8hnH5t4+WvInufmuSgnKspNF9sojmnD3XlkPgtaotBV/+n9c6MseRSXvabsOyVArmsLAEDikEec9Kx6X6OJ8v9hN0EoWSl896HDxYtZ+ErnJtTRYgSnH3eu9hkBiCg6sDx2t9p3VFhcYZMpFZA71nY/4O3VbiJGNmkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvns3zVtMyZX/fXa/SUG1nibiTOV5CqUCKLnK4MmYgw=;
 b=iI85YNhGZcDn4lZM16Mi3uF7tkDf+ugMR+Q1+q4+FKMGaGvODO17ZnH7doBto5xwrGvNi6oQIk+zjokbRHGYDlnaC6E7WXdsN9lV9z5a5TyVYDftL7mw30eaeI2I77Tb1FiHKrJoFWQsSAvD7yPDJO9lP9k8tAQ4pzzyJIYrm9w=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4042.eurprd08.prod.outlook.com (20.179.9.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Tue, 13 Aug 2019 08:39:57 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 08:39:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 0/2] deal with BDRV_BLOCK_RAW
Thread-Index: AQHVUTlscGMEUismPEagfLbq4nW+tab36tGAgAABHQCAANb8gA==
Date: Tue, 13 Aug 2019 08:39:57 +0000
Message-ID: <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
In-Reply-To: <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::16) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813113955547
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 707e1ba4-2fcf-4dd8-9a46-08d71fc9d24d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4042; 
x-ms-traffictypediagnostic: DB8PR08MB4042:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4042AA4C925917D0090EE5C3C1D20@DB8PR08MB4042.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39850400004)(396003)(136003)(53754006)(199004)(189003)(53936002)(71200400001)(71190400001)(66946007)(386003)(6506007)(66556008)(64756008)(66446008)(66476007)(2501003)(52116002)(186003)(102836004)(53546011)(76176011)(316002)(26005)(305945005)(3846002)(4326008)(6116002)(107886003)(6246003)(14444005)(256004)(5660300002)(476003)(478600001)(81166006)(7736002)(99286004)(2616005)(81156014)(2906002)(446003)(25786009)(11346002)(966005)(6306002)(6512007)(31686004)(8676002)(14454004)(229853002)(6486002)(31696002)(110136005)(86362001)(36756003)(8936002)(54906003)(66066001)(486006)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4042;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KppTbfRFKa22bGo1l3yxuZaKM3qPIJy4MLJemrVi/0c07bY88hP0b/rJJZkbCH8mSx6mDZTjyUYtT2m6+QWoJbuxvIEtUSYH6A3aIDCpuN2U8/LJLdXxJMBAdMUmJisqzMpmnZ4WKCABub42NlL/+o72qJhPaFsjFfNMkDUn68MDhoFqsahtiWbzD4Ok8G+IyG9n+zfRLmS1cZUCZUBggNlYjAvv3ed5KsXiOtiYahYberzgzumqsH+3bWg61C9D+tqFC4BOGeExoVlwVWgtykmWLE3vf3uTUC+enlkINp9Bax1uKKtb9PRgKOkj3bccquhMMBWMcxHRPlh/udsUWNyIbp6cq0DcNPd8Edi5HZLdhHk025fGnu6bf82gkxjim0KWfn7xthBiK0wLKSWvcXrnuLTCPDQafURjQAgLqV4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <986685DE185A3A4A95A78E34715B5ECC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707e1ba4-2fcf-4dd8-9a46-08d71fc9d24d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 08:39:57.5924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkeIuwzuKH2Xb+NpZyKv2XfVM+GNy9LyVsl3yB46PgupH/NkUv4KCeY4DYkX1v1ZuzT3NO2azgInqUTe+JY/o2BhLlGk0emhEaxDSE0L/Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4042
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.138
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDguMjAxOSAyMjo1MCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMi4wOC4xOSAyMTo0Niwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMTIuMDguMTkgMjA6MTEsIFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gSGkgYWxsIQ0KPj4+DQo+Pj4gSSdtIG5vdCBzdXJlLCBp
cyBpdCBhIGJ1ZyBvciBhIGZlYXR1cmUsIGJ1dCB1c2luZyBxY293MiB1bmRlciByYXcgaXMNCj4+
PiBicm9rZW4uIEl0IHNob3VsZCBiZSBlaXRoZXIgZml4ZWQgbGlrZSBJIHByb3Bvc2UgKGJ5IE1h
eCdzIHN1Z2dlc3Rpb24pDQo+Pj4gb3Igc29tZWhvdyBmb3JiaWRkZW4gKGp1c3QgZm9yYmlkIGJh
Y2tpbmctZmlsZSBzdXBwb3J0aW5nIG5vZGUgdG8gYmUNCj4+PiBmaWxlIGNoaWxkIG9mIHJhdy1m
b3JtYXQgbm9kZSkuDQo+Pg0KPj4gSSBhZ3JlZSwgSSB0aGluayBvbmx5IGZpbHRlcnMgc2hvdWxk
IHJldHVybiBCRFJWX0JMT0NLX1JBVy4NCj4+DQo+PiAoQW5kIG5vdCBldmVuIHRoZW0sIHRoZXkg
c2hvdWxkIGp1c3QgYmUgaGFuZGxlZCB0cmFuc3BhcmVudGx5IGJ5DQo+PiBiZHJ2X2NvX2Jsb2Nr
X3N0YXR1cygpLiAgQnV0IHRoYXTigJlzIHNvbWV0aGluZyBmb3IgbGF0ZXIuKQ0KPj4NCj4+PiBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICgyKToNCj4+PiAgICBibG9jay9yYXctZm9ybWF0
OiBzd2l0Y2ggdG8gQkRSVl9CTE9DS19EQVRBIHdpdGggQkRSVl9CTE9DS19SRUNVUlNFDQo+Pj4g
ICAgaW90ZXN0czogdGVzdCBtaXJyb3JpbmcgcWNvdzIgdW5kZXIgcmF3IGZvcm1hdA0KPj4+DQo+
Pj4gICBibG9jay9yYXctZm9ybWF0LmMgICAgICAgICB8ICAyICstDQo+Pj4gICB0ZXN0cy9xZW11
LWlvdGVzdHMvMjYzICAgICB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+Pj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjYzLm91dCB8IDEyICsrKysrKysrKysNCj4+
PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgIHwgIDEgKw0KPj4+ICAgNCBmaWxlcyBjaGFu
Z2VkLCA2MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4gICBjcmVhdGUgbW9kZSAx
MDA3NTUgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2Mw0KPj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRl
c3RzL3FlbXUtaW90ZXN0cy8yNjMub3V0DQo+Pg0KPj4gVGhhbmtzLCBhcHBsaWVkIHRvIG15IGJs
b2NrLW5leHQgYnJhbmNoOg0KPj4NCj4+IGh0dHBzOi8vZ2l0LnhhbmNsaWMubW9lL1hhbkNsaWMv
cWVtdS9jb21taXRzL2JyYW5jaC9ibG9jay1uZXh0DQo+IA0KPiBPb3BzLCBtYXliZSBub3QuICAy
MjEgbmVlZHMgdG8gYmUgYWRqdXN0ZWQuDQo+IA0KDQoNCkhtbSB5ZXMsIEkgZm9yZ2V0IHRvIHJ1
biB0ZXN0cy4uIEFyZWFzIHdoaWNoIHdlcmUgemVybyBiZWNvbWVzIGRhdGF8emVybywgaXQNCmRv
bid0IGxvb2sgZ29vZC4NCg0KU28sIGl0J3Mgbm90IHF1aXRlIHJpZ2h0IHRvIHJlcG9ydCBEQVRB
IHwgUkVDVVJTRSwgd2UgYWN0dWFsbHkgc2hvdWxkIHJlcG9ydA0KREFUQV9PUl9aRVJPIHwgUkVD
VVJTRSwgd2hpY2ggaXMgYWN0dWFsbHkgQUxMT0NBVEVEIHwgUkVDVVJTRSwgYXMgb3RoZXJ3aXNl
DQpEQVRBIHdpbGwgYmUgc2V0IGluIGZpbmFsIHJlc3VsdCAoZ2VuZXJpYyBsYXllciBtdXN0IG5v
dCBkcm9wIGl0LCBvYnZpb3VzbHkpLg0KDQpBTExPQ0FURUQgbmV2ZXIgcmV0dXJuZWQgYnkgZHJp
dmVycyBidXQgc2VlbXMgaXQgc2hvdWxkIGJlLiBJJ2xsIHRoaW5rIGEgYml0IGFuZA0KcmVzZW5k
IHNvbWV0aGluZyBuZXcuDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

