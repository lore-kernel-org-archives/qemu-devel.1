Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DC6C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC25214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M98I4xci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC25214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzndW-0007MD-AT
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 15:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1hznc4-00062o-2x
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1hznc2-0003Lg-HK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:46:44 -0400
Received: from mail-eopbgr30131.outbound.protection.outlook.com
 ([40.107.3.131]:44558 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1hznby-0003Fn-FW; Mon, 19 Aug 2019 15:46:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPYGxEH3IsM/k4zZdmLUgZMGrZ0klIKFNXJlt7GGyHCVA+VST4FPk2tBtyGJhHBB4XcGS1FLfrnSvMntX+a6bYd0etg6goNlnu4x2xRlj5nTlhRxhc4WBsZ2LhPESYcVAC5ndLtrFXgSB5JJ1eK4jZduUGWPd9xFc8m7eW45Yuth0RPE24YZrSPF+3rzdOBkygJndEEx7VXRamtVA14yeO4ZCFwK3zPzaynMVDxXBJTVcRZfCHVlycexu35drlRls3T52m/OycwF1iJLVLnWdcrN/CXeQHQud1Ovy2NN+MLTzG+4fdPlC75Hj2uYg/OJWtcwG9op3kcPYHm3Ax6l3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/xkcJvYW5J1P3IVN0b+dQ/d7v9RUY1JI6YA+SdSGFY=;
 b=JzLHh5ug+lhlDtg/0UOP8vTXfcGTjVlSNwUq5QpAELAkCei5hXZ7bUFr1AKsLfW3Hc7j7yFC5AGyUBefii39YvK81VBTocP8RDF5TnQlBx8lqMjaP8+nx4Iu/h71twhBc7jr605+wJj/aL2HZEbqQw5+++DLHSp6jiFe+AdKdno1ZXaA2VvmMbbYlHt8MmQxu2CkksBTtgVtgjvXbYFZxnzbog2cHzETLGAwIoHwlTKn3igrbG2JvQ/vt1D0FcKdbeoGrdks/uwjG+9pDWY2j72HhfnlVCKw6kH04fqYX1X6Dffv6+PO8HCZsn3tQUIv66gLjns4cYYROkC23St1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/xkcJvYW5J1P3IVN0b+dQ/d7v9RUY1JI6YA+SdSGFY=;
 b=M98I4xcimFaavsF9MC+0mNqBwsEh7GsFPEC6nWxTsvV0tgqe203OHNVPNcRbdlVjWD1zzpx7MEBABBoa+HWxaZnOCXUVSvCNwM/zZCH4qatT+Il3P6ewBwp08WbMcDZYpoA4BcvV3Qjx/i2meK0l6nRp/3O3SRoHTcUCZa/tTOk=
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) by
 DBBPR08MB4281.eurprd08.prod.outlook.com (20.179.41.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 19:46:33 +0000
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::c1aa:9c2d:d6b8:b0d]) by DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::c1aa:9c2d:d6b8:b0d%7]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 19:46:33 +0000
From: "Denis V. Lunev" <den@openvz.org>
To: Eric Blake <eblake@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
Thread-Index: AQHU67tBNfVtWsWTSEqO4ep6MEFcGKcAPJoAgAAB6wCAAAIFgIADdZIA
Date: Mon, 19 Aug 2019 19:46:33 +0000
Message-ID: <a7cfd04b-5185-e13c-2ced-7e689de05247@openvz.org>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1677e835-39a1-4af3-8f4f-e1600021a2ee@redhat.com>
 <fa4f4405-5a51-c7ec-f712-95e40ef6dd41@redhat.com>
 <5dc0231e-6fbc-3efc-8cc7-ff953651d0e9@redhat.com>
In-Reply-To: <5dc0231e-6fbc-3efc-8cc7-ff953651d0e9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR07CA0078.eurprd07.prod.outlook.com
 (2603:10a6:207:6::12) To DBBPR08MB4250.eurprd08.prod.outlook.com
 (2603:10a6:10:c2::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [87.26.82.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6043e186-2ffe-4c67-cdec-08d724ddf022
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4281; 
x-ms-traffictypediagnostic: DBBPR08MB4281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR08MB4281B26CE7EAFABE46008B3AB6A80@DBBPR08MB4281.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39840400004)(346002)(396003)(136003)(366004)(199004)(189003)(2616005)(476003)(54906003)(66066001)(316002)(446003)(25786009)(66556008)(14454004)(11346002)(110136005)(8936002)(486006)(3846002)(6116002)(5660300002)(66476007)(64756008)(66446008)(76176011)(8676002)(81156014)(6512007)(31696002)(6436002)(52116002)(36756003)(2201001)(14444005)(2906002)(256004)(26005)(229853002)(71200400001)(6506007)(71190400001)(6486002)(478600001)(386003)(53546011)(81166006)(102836004)(66946007)(4744005)(42882007)(99286004)(186003)(31686004)(7736002)(4326008)(305945005)(2501003)(53936002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4281;
 H:DBBPR08MB4250.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: do8LTftxoVkZrMhj0yeul4p8PzzaiDRqiZg1AN16/iRUS/lozehvU9Y+yPp+tlEZ+U8FV+gLCciIH3cArrw4bhpqYRqljYUsmVpTpIdKVm7BhFdmMtbgZPBDuWmxVD35yNnoFezgnUQlaTV9Z6ncv0yRvvCNqo6Iiasx6i210M/FnKuaTReuioU4gcZ80o24G/cQ1Bi0+wo2isuz5e0BBEC16wMB2uGpJCfYFNMEKx0KzN3/aLgujxc3mMnatW/Bi91L+bcmL6/54EXWKrlPlBEIod9T6zD1IsSYN6TKgaau07MvW/Lix6uuZlfSEV0QOicUyogiC9OM23LVev9P6YUrRGK+mktAx6ti/yugvGRA3y4VXFIm/Pw8n9caooM7grJ4973YHqDoSAlAlSW7CJAQDoL9iFgcYZzk91xz6pI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D471170A7188594F862314A1F61D8D95@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 6043e186-2ffe-4c67-cdec-08d724ddf022
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 19:46:33.3148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/cYQ0OOdyH9BVeoekdwFrzjSHZ84MlXydsEuqThMK6YN2o+CljnmXws7txYGmSSwRmDH/oXiFm3X+uVRDb6Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4281
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.131
Subject: Re: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gOC8xNy8xOSA1OjU2IFBNLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBPbiA4LzE3LzE5IDk6NDkg
QU0sIEVyaWMgQmxha2Ugd3JvdGU6DQo+DQo+Pj4gVGhpcyBjaGFuZ2UgaXMgYSByZWdyZXNzaW9u
IG9mIHNvcnRzLiAgTm93LCB5b3UgYXJlIHVuY29uZGl0aW9uYWxseQ0KPj4+IGF0dGVtcHRpbmcg
dGhlIGZhbGxiYWNrIGZvciBBTEwgZmFpbHVyZXMgKHN1Y2ggYXMgRUlPKSBhbmQgZm9yIGFsbA0K
Pj4+IGRyaXZlcnMsIGV2ZW4gd2hlbiB0aGF0IHdhcyBub3QgcHJldmlvdXNseSBhdHRlbXB0ZWQg
YW5kIGluY3JlYXNlcyB0aGUNCj4+PiB0cmFmZmljLiAgSSB0aGluayB3ZSBzaG91bGQgcmV2ZXJ0
IHRoaXMgcGF0Y2ggYW5kIGluc3RlYWQgZml4IHRoZQ0KPj4+IGZhbGxvY2F0ZSgpIHBhdGggdG8g
Y29udmVydCB3aGF0ZXZlciBBQ1RVQUwgZXJybm8geW91IGdvdCBmcm9tIHVuYWxpZ25lZA0KPj4+
IGZhbGxvY2F0ZSBmYWlsdXJlIGludG8gRU5PVFNVUCAodGhhdCBpcywganVzdCB0aGUgZmlsZS1w
b3NpeC5jIGxvY2F0aW9uDQo+Pj4gdGhhdCBmYWlsZWQpLCB3aGlsZSBsZWF2aW5nIGFsbCBvdGhl
ciBlcnJvcnMgYXMgaW1tZWRpYXRlbHkgZmF0YWwuDQo+IE9yIGV2ZW4gYmV0dGVyLCBmaXggdGhl
IGNhbGwgc2l0ZSBvZiBmYWxsb2NhdGUoKSB0byBza2lwIGF0dGVtcHRpbmcgYW4NCj4gdW5hbGln
bmVkIGZhbGxvY2F0ZSgpLCBhbmQganVzdCBkaXJlY3RseSByZXR1cm4gRU5PVFNVUCwgcmF0aGVy
IHRoYW4NCj4gdHJ5aW5nIHRvIGRpYWdub3NlIEVJTlZBTCBhZnRlciB0aGUgZmFjdC4NCj4NCk5v
IHdheS4gU2luZ2xlIEVOT1RTVVAgd2lsbCB0dXJuIG9mZiBmYWxsb2NhdGUoKSBzdXBwb3J0IG9u
IGNhbGxlciBzaWRlDQp3aGlsZQ0KYWxpZ25lZCAoOTkuOTklIG9mIGNhbGxzKSB3b3JrcyBub3Jt
YWxseS4NCg0KRGVuDQo=

