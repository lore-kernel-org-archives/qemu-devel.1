Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856EFC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E6D229F3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="If9s3mBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E6D229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqDzT-0004HT-IW
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 05:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqDzC-0003Kf-Ie
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqDzB-00042L-LU
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:55:02 -0400
Received: from mail-eopbgr150100.outbound.protection.outlook.com
 ([40.107.15.100]:30980 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqDzB-00040w-Fw; Wed, 24 Jul 2019 05:55:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyexYFQP3moPboMbf0x7+X6TnriG7Po7HdosRDykOLKv3g4OFaBe+FQPm3yF5cH+Ba4W1I1Bk7jf4ksxCsp1E/PEYz0WiqrfPLuLbRQDWk8LnGdiKB3nyXV6UjPI40ijzJEl7TYCpJcNg8ax1Mc/yeWc6J3ziWq6od6y+Kyd3JiyclQScVpgS8RPa9FoIb1kgpY+KIw3ePiQVhTs8F1+Sjm92HPiSVmD+lWAF7NbkYb4BHgN8fWBQkKxP0VMndcJezOswVI9zFp5ZWtfTzzlucboGQ3LqzpkTIFlMbJTbAnzvwv8RZZg5wO1leROlE65Q1eGZJfZxR4QG/uMN89EfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mITCX6qOR2bsL+MSob4dPTxIyvBADQV7GfAIxPyws/s=;
 b=NDgCjChxRLSWAisy+MLqfs22KofNSlYAa3h/QV576w+3ULNvk3azWUCB2XbGqYIwD/7xSkk6Mq6UjV2p3m5L40Bv5o2zmyXK4c15KlQhGUVc8pT2A25MZIczvGyp5JfdrGk62Dg23QdGRhwj8b123KwgAEgPK4Zf/EVKgfW6CHfA0f/NxUlADh4cR6qduY61RdVT3OKyL3crgep4AE75nlBaDtbeFshzLWvdQeYXe+6FTzA5vUyo80CMIwoc4CbKGtzooGHymGsdE8kfk5H9ZC4DHGLE7QAw3+XEqEoElP+bEa1eZRht4hnxi3uHlStcEm0uwIVfOhdNpe8/hcNyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mITCX6qOR2bsL+MSob4dPTxIyvBADQV7GfAIxPyws/s=;
 b=If9s3mBHioZN5iSEaTfA3PCUNUa80jZLtzn1NlrrC9czh4ahN/WRd6hqs2XdDjf9tNeTieHde+ouSsQbkjhHKdtv9jdJuwVBKee29l5HrDlRZLx/K744Fsgdl9YvAfWxecBYycVAmSkilZtBy1eB1Jra7SW8drYjzI5uf3uP+bk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3931.eurprd08.prod.outlook.com (20.179.10.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 24 Jul 2019 09:54:59 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Wed, 24 Jul 2019
 09:54:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 34/42] block: Inline bdrv_co_block_status_from_*()
Thread-Index: AQHVIWvNU3OcdFzxRk6Av7EEdf3CnKamKrAAgDOeK4A=
Date: Wed, 24 Jul 2019 09:54:59 +0000
Message-ID: <da6c5fb8-ab76-2922-a692-16e2f0e27c8f@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-35-mreitz@redhat.com>
 <d0b25d0a-960a-7401-bc68-c155eb62e640@virtuozzo.com>
In-Reply-To: <d0b25d0a-960a-7401-bc68-c155eb62e640@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0045.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::31) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190724125457704
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1846a28d-bf6e-4049-200c-08d7101cfda4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3931; 
x-ms-traffictypediagnostic: DB8PR08MB3931:
x-microsoft-antispam-prvs: <DB8PR08MB3931F2BCF4600ABD28E34505C1C60@DB8PR08MB3931.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(346002)(366004)(136003)(199004)(189003)(478600001)(446003)(11346002)(26005)(14454004)(229853002)(316002)(8676002)(2616005)(5660300002)(256004)(2501003)(6116002)(486006)(6486002)(25786009)(110136005)(3846002)(31696002)(305945005)(6512007)(54906003)(6436002)(7736002)(99286004)(476003)(68736007)(4744005)(53936002)(4326008)(66476007)(31686004)(66446008)(66556008)(6246003)(86362001)(81166006)(36756003)(81156014)(76176011)(2906002)(8936002)(102836004)(52116002)(186003)(64756008)(71190400001)(66946007)(71200400001)(66066001)(386003)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3931;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lWHTC54Wbc9UG+p1fgZihoDtAGliRMjvuoqzsEMoVPYZS7iNQEXIV9NJ3xyudo52VI+l+dbQg0anRb5UNwPmlY6iKcobO0VXIBuGG4ldpmT86OH6hqAWGbYMo/3brqmT5IxGlbjrwyqu61tWTQfevmSUdh7pLkZKvIbvHBzR50u1CFAuQQDsrFXHbvUyTu+eTGMFVIU6M54bLMwS/VvSsRrDC57+bDsVF4PLL9xPzZYqCw0ayLsqgz4H9A2hB9sAxLtEzQBaxUQBB1dAzmN0GsnE4MobcTMZLXuNc+ieXt6Qiwi5lQtIjMp464MN26LQFZW0pXKzypzkpovWcsI2fPiz9jjwlrXddawdobQJHlMx0+mKLq8o5CjYijcDp8ZImbJXeKm5zE+j+aKS2/GuM7UkhML+7uwKBCY6EYPWVzk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AD702F249B9C140A719BD2993D32361@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1846a28d-bf6e-4049-200c-08d7101cfda4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 09:54:59.8346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3931
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.100
Subject: Re: [Qemu-devel] [PATCH v5 34/42] block: Inline
 bdrv_co_block_status_from_*()
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

MjEuMDYuMjAxOSAxNjozOSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+PiBXaXRoIGJkcnZfZmlsdGVyZWRf
cndfYnMoKSwgd2UgY2FuIGVhc2lseSBoYW5kbGUgdGhpcyBkZWZhdWx0IGZpbHRlcg0KPj4gYmVo
YXZpb3IgaW4gYmRydl9jb19ibG9ja19zdGF0dXMoKS4NCj4+DQo+PiBibGtkZWJ1ZyB3YW50cyB0
byBoYXZlIGFuIGFkZGl0aW9uYWwgYXNzZXJ0aW9uLCBzbyBpdCBrZWVwcyBpdHMgb3duDQo+PiBp
bXBsZW1lbnRhdGlvbiwgZXhjZXB0IGJkcnZfY29fYmxvY2tfc3RhdHVzX2Zyb21fZmlsZSgpIG5l
ZWRzIHRvIGJlDQo+PiBpbmxpbmVkIHRoZXJlLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogRXJpYyBC
bGFrZTxlYmxha2VAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0ejxtcmVp
dHpAcmVkaGF0LmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dp
ZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IA0KDQpTdHJhbmdlLCBJIGhhdmUg
dGhpcyBtYWlsIGF1dG9tYXRpY2FsbHkgcmV0dXJuZWQgYmFjay4gRGlkIHlvdSByZWNlaXZlIGl0
Pw0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

