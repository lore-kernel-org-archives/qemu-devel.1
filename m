Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B196C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA85A20578
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K/xH02wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA85A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05wY-0005BB-QE
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i05u6-0003q1-Qh
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i05u3-00036X-TY
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:18:34 -0400
Received: from mail-eopbgr40096.outbound.protection.outlook.com
 ([40.107.4.96]:25656 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i05u3-000355-FQ; Tue, 20 Aug 2019 11:18:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUmn/KSzOzCsyHfN/jk3j/eaRj44mbmI5Z1y41Fovf0Zdks7XyB1wBmXNAh/X7ABomhZAP9A63gw1fpOSoAkKxBVeJ0YkfqmT5riuEzUZJoabLWvSsx3moKFxcA1RqQV4K4OysT31cp48WiDUhrvCovnAJNtesdKQuxdLZ2KZ4c1zGpQibCRHC/NNOhIPZorDX6l0SE+j4uwbhkIXXIwD50O7B2NmAFm0B/2g+GyQgKGGpq+uRVYON0gVVqjhQWQkhRpBnyv9uc/JgvziMBpbgb84FwG2RX+Z3pSf2yJt8Co4ReMzdH0GM1Bxkb5Do6CxCrsvfA4wZWKeTPpFHjJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0nD7ENkk7BYbjbADjbQA55a7sVAiK9Yq6LpPJzBNzI=;
 b=X2Lu93UCwhOXgGI7C6jTnNQmZ7BukWdU7aegJFLupOj/wV0spSvMvCCUkittV8jIrCI3c66ATZppqELBBHyV3kbn97c+FA77MbN/9s2N1gSulXPCGZWYkl5+2jLv7jxtJAt2R2HTbZf5F/WbMte8T+zXEsC1RwqPd+aLVYL5l6MT6aqDpKCoB1uxvgMk2baW9Lu5EqJ7y4/QnHTJV94MzMJc2vENRHqKW6vCiMmBHkez7J17NKdXulmYBznYAlogwc/zxsnygECCgo4IfB9CvwmF8ziGh5GpFGuRaFau5GGsq1n9oiRJ0fM59vjzAQhvt+rcAXzJXX2cdVCneOZxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0nD7ENkk7BYbjbADjbQA55a7sVAiK9Yq6LpPJzBNzI=;
 b=K/xH02wx3kCEW9X69q0bwrz3JKEgwC+ABRBoy4/P3x7AvRYnk984sQ2LJtX5b4SEKqST9CLIIKIMiFOfhWFY/llhqSI1JuF4m6vwwmUcP+7rKKFchmti0P+aar51BgbgDw7+JBmDdDVuehNSYLHLULsUxvf1YipZKSJk/Bt0bDg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5180.eurprd08.prod.outlook.com (10.255.18.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 15:18:28 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 15:18:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 3/7] block/io: handle alignment and max_transfer for
 copy_range
Thread-Index: AQHVT7JLEJmDbxZ0Ek2qZnsi2Q0W06b3mpAAgAybEgA=
Date: Tue, 20 Aug 2019 15:18:28 +0000
Message-ID: <88155279-77f5-ebce-7938-a7bca354f2b0@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-4-vsementsov@virtuozzo.com>
 <519a80e3-3cec-d37c-9131-52cac0e0e4b6@redhat.com>
In-Reply-To: <519a80e3-3cec-d37c-9131-52cac0e0e4b6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0146.eurprd06.prod.outlook.com
 (2603:10a6:7:16::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190820181826281
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e14cc151-ec7f-4f28-5298-08d72581a73a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5180; 
x-ms-traffictypediagnostic: DB8PR08MB5180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB51808681D820B50B56E87679C1AB0@DB8PR08MB5180.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(376002)(136003)(39840400004)(366004)(199004)(189003)(51444003)(6506007)(2501003)(102836004)(386003)(53546011)(26005)(52116002)(14444005)(186003)(2906002)(256004)(446003)(31686004)(11346002)(2616005)(476003)(86362001)(486006)(110136005)(54906003)(316002)(76176011)(31696002)(71190400001)(71200400001)(478600001)(4744005)(36756003)(66066001)(3846002)(6116002)(14454004)(25786009)(66446008)(64756008)(66556008)(66476007)(66946007)(53936002)(6486002)(107886003)(6246003)(4326008)(229853002)(8676002)(81166006)(81156014)(99286004)(8936002)(5660300002)(305945005)(6512007)(6436002)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5180;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q34pi/hLAm7XRQXQ/JJHPSzH1JPwLGBMCwm4vEfmPBGH/CBtIbjsmxA6BVRmyx+Y5xER7TP1uPXgtqyAQlNBB+n6H075GS+Nz2pNo3u3U8liYKQmQoiLIPkf5Z2iKb130p2sLfoeodjBh7jJD8+CQ0ekH4OHZMF1YZzjyrJ3DZ/REUbPKrYCHnck8IBLKaVBrGQNGBsd3wNRMURq09KJNjQhgZ3vrzYBwa+GFNPk8u4ErED9InIU5uM0te/6U4rseNsHWIJj0SozJJBKefFqUi5z4Kcch3kxE97dpflU8wY/KgQWYHOuVWLY/V5+GuUiZmRq3amjF/b9ufSPrQly1Ybf1G32O+OajrvQnTxBGsVD5TUhRZpaIYnkDp6R1qTQRUiW7eLknfNScBEm2Lc9a2Y7OfRKm8b/ajOk81ku5hw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99E5BCF2BA00704D81A5CAD96FBB65BE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14cc151-ec7f-4f28-5298-08d72581a73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 15:18:28.5442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eozzj+XEUbbc+9KhzHlfnAjOYVNWW1N/UpNiemyCs7zAsJdw4JEjI31kY2ZC4AvdDX4So6yzIBtrRqR2rnCCKEs90rwAmCUJzUDJvhw+WaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5180
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.96
Subject: Re: [Qemu-devel] [PATCH v3 3/7] block/io: handle alignment and
 max_transfer for copy_range
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDguMjAxOSAxNzo0OCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMC4wOC4xOSAyMTozMSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IGNvcHlfcmFuZ2UgaWdub3Jl
cyB0aGVzZSBsaW1pdGF0aW9ucywgbGV0J3MgaW1wcm92ZSBpdC4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5j
b20+DQo+PiAtLS0NCj4+ICAgYmxvY2svaW8uYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gUmV2aWV3ZWQtYnk6IE1heCBSZWl0eiA8bXJlaXR6
QHJlZGhhdC5jb20+DQo+IA0KDQpIbW0uIE5vdyBJIHRoaW5rIHRoYXQgbmV4dCBwYXRjaCBpcyBh
cmd1YWJsZSwgYW5kIEkgc3RpbGwgZG9uJ3Qgc2VlIHRydWUgd2F5IG9mDQpvcmdhbml6aW5nIGxp
bWl0YXRpb24gb2YgcmVxdWVzdCBsZW5ndGggYW5kIG1lbW9yeSBhbGxvY2F0aW9uIGluIGNvbmp1
bmN0aW9uIHdpdGgNCmFzeW5jIHJlcXVlc3RzIGluIGJhY2t1cC4NCg0KU28sIEknbGwgc2VuZCBu
ZXh0IHZlcnNpb24gb2YgImltcHJvdmVtZW50cyIgd2l0aG91dCB0aGlzICh0aGVyZSBhcmUgYWxy
ZWFkeSBlbm91Z2gNCnNpbXBsZXIgcGF0Y2hlcykuDQoNCkFuZCB0aGlzIHBhdGNoIGJlY29tZXMg
c29tZXRoaW5nIHNlcGFyYXRlLiBEbyB5b3UgdGhpbmsgd2UgbmVlZCBpdCBhbnl3YXk/IElmIHll
cywNCnBsZWFzZSBxdWV1ZSBpdCBpbiBzZXBhcmF0ZS4gSXQgbWF5IGJlIGJldHRlciB0byByZXR1
cm4gRU5PVFNVUCBvbiB0b28gYmlnIHJlcXVlc3RzDQp0b28sIHRvIGtlZXAgc2ltcGxlciBjb2Rl
IGFuZCBtYWtlIGNhbGxlcnMgb3B0aW1pemUgdGhlaXIgY29weWluZyBsb29wcyBieSB0aGVtc2Vs
dmVzLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

