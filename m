Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ACCC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB6D2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="irAhoaoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB6D2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFr3-0005X1-1m
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAFkW-0000RN-MZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAFkV-0007UL-Hf
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:50:40 -0400
Received: from mail-eopbgr00122.outbound.protection.outlook.com
 ([40.107.0.122]:42757 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iAFkV-0007Tz-B3; Tue, 17 Sep 2019 11:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtxmgMdQjpOaUdj7shUPWgTxQDhtZ1vj5VfFtvEswlCuzvyHAnvsvhkF8Vqt8Z60s1OJIQvZiRZnwA/t2wFThLATxAaMN5tZjGNMjv+pAHIXugD0SO68jkcfoU3Kn7nk5CXdiBvH1aZbIpf2ekKEBekX5Du0ldupKIp/U06ZNuccGwKc4ITFSVQcFKd7Rscp3t4proZ8LqMTXc0ZTZq/AnWgDd0aty3YM02p9wG3aplgLqqqyVT6G8dghjcKgEg1gE4tfbFK98jwLkTx3ra/is9JiYxzu7SGvpN1kVKLKaxib0XzYrKYK+bWGIr5Frha/+O5t1VDISx5RbwUJyR+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGyfQDsW64xfg3nyTW0Ed/7quI8fLeyYEQlqrcurhZ8=;
 b=SDrltFTijL+o+2oWPESTiNYcjExG/SJE7G6XvLHNiAGOCQzNcpBqyylsFqma4ZkeDYIMIUi6Eene6gZNXAaqQ3+1IacNQ/XQRfkdrE2Wb/BWchUne/r1lWRpLw+2hKm8Ssxd6RKgYjbxqhk16x+En2T9655MapIFCvudrnJ8LSBFByPM59+1NmKN7DSrXM7q3jeBO3HDjApGP6PjVHH++isKLibtjXtmcQMqXp8RCUdFv8JESJUYiYcGaXVpBV6EqSnF1ib0zO7Ig3GmRjyfk23wimaY1BPx4qnwujaKpA4C9x5tZDbUkKDJ8VLliFg5xNgvnpPO7rOhhH9mDphH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGyfQDsW64xfg3nyTW0Ed/7quI8fLeyYEQlqrcurhZ8=;
 b=irAhoaoAnqYntItAO/FzIGYP6Fj3SFK772gIwSWLp2ydSn8AdIeS2F+TKDpDEClgW7gOONnCDPXxTs3o2jgLdBo2O2XoNwIQsKyWuz7ak/0linB5qIzoC5Agwx+4RYnc2bG8Ra358IBujiua3skk9USZPJynAmcOoQ5KHChncdg=
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com (10.175.33.138) by
 HE1PR0802MB2299.eurprd08.prod.outlook.com (10.172.125.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Tue, 17 Sep 2019 15:50:36 +0000
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10]) by HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10%6]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:50:36 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 7/7] iotests: Cache supported_formats()
Thread-Index: AQHVbTku1OAxQlhf90ScyQk+93qxLKcwBNUA
Date: Tue, 17 Sep 2019 15:50:36 +0000
Message-ID: <8036da01-4019-0ae9-bb68-dac7a9bfd8b9@virtuozzo.com>
References: <20190917092004.999-1-mreitz@redhat.com>
 <20190917092004.999-8-mreitz@redhat.com>
In-Reply-To: <20190917092004.999-8-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0013.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::23)
 To HE1PR0802MB2460.eurprd08.prod.outlook.com
 (2603:10a6:3:dd::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 071faf65-7da6-42fb-9eec-08d73b86c7c5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:HE1PR0802MB2299; 
x-ms-traffictypediagnostic: HE1PR0802MB2299:
x-microsoft-antispam-prvs: <HE1PR0802MB2299A70644EBB04AC846E25DF48F0@HE1PR0802MB2299.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39850400004)(366004)(136003)(396003)(199004)(189003)(486006)(7736002)(229853002)(31696002)(66446008)(6116002)(4326008)(6512007)(66476007)(3846002)(25786009)(26005)(102836004)(76176011)(71200400001)(256004)(2906002)(53546011)(6506007)(386003)(71190400001)(52116002)(6246003)(305945005)(6486002)(66556008)(6436002)(186003)(86362001)(99286004)(5660300002)(36756003)(2501003)(476003)(446003)(2616005)(54906003)(110136005)(31686004)(66066001)(64756008)(66946007)(478600001)(44832011)(81166006)(8676002)(81156014)(14454004)(316002)(11346002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2299;
 H:HE1PR0802MB2460.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: grtk1FM5ltdZ3qmLeeq8t7+u6NdC8wvHTAASBFmO2MiB9xwowJWBdaMwAKemqIY66uVHKe7OM8dZmoLi3Nt1OCcT7VbNCOeAdBtQogO6SZ6mr4FJGHqUbEPGrU9BIwHZwFAI7S5MaKK1dCwaAR53DJe2j6SePvcqvLIty8ucgQ9BlkRqbB+4G09CqvavvkzUmQs4TmYZVwkqSYICyfjOiz0Z6ptw/aDIcQm0lI7q8eqcJ1OTfCua+Dzwn45E1oXTAMeGkiT/u/1fuv+GNNwvl504GJfHWA68+R2ILmCl+Yx/zHt9CFdwbSymzALSAhAWp/gpYAjXgHIIaoMb1DXm8P7Mkq4E15s3jOfRsO61vIMrKTd7tAZoKLfZ5r+2QwBQqa/GB4GfS7tHyvEhzLubyGDUBJlf1tNDStz7N6hYAzI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD46D5F7BECA884CBB9AD518533A314B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071faf65-7da6-42fb-9eec-08d73b86c7c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:50:36.2877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YtmrssqwIrhgMoMHU6d3RUyxsmrY1xA7Wk2h1qc9UuyFETEz+kSkXTJbAgH6mAflEsNes/PANx/HZhu1MvFYMhCgsruKEes7XdGZmpSJjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2299
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.122
Subject: Re: [Qemu-devel] [PATCH v4 7/7] iotests: Cache supported_formats()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTcvMDkvMjAxOSAxMjoyMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBN
YXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogSm9obiBTbm93IDxq
c25vd0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5w
eSB8IDE0ICsrKysrKysrKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
L2lvdGVzdHMucHkgYi90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0KPiBpbmRleCBhNDI3
MDJiNmI5Li5iMzAwNDRlMWNjIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90
ZXN0cy5weQ0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0KPiBAQCAtODg1
LDkgKzg4NSwxNyBAQCBkZWYgcWVtdV9waXBlKCphcmdzKToNCj4gICBkZWYgc3VwcG9ydGVkX2Zv
cm1hdHMocmVhZF9vbmx5PUZhbHNlKToNCj4gICAgICAgJycnU2V0ICdyZWFkX29ubHknIHRvIFRy
dWUgdG8gY2hlY2sgcm8td2hpdGVsaXN0DQo+ICAgICAgICAgIE90aGVyd2lzZSwgcnctd2hpdGVs
aXN0IGlzIGNoZWNrZWQnJycNCj4gLSAgICBmb3JtYXRfbWVzc2FnZSA9IHFlbXVfcGlwZSgiLWRy
aXZlIiwgImZvcm1hdD1oZWxwIikNCj4gLSAgICBsaW5lID0gMSBpZiByZWFkX29ubHkgZWxzZSAw
DQo+IC0gICAgcmV0dXJuIGZvcm1hdF9tZXNzYWdlLnNwbGl0bGluZXMoKVtsaW5lXS5zcGxpdCgi
OiIpWzFdLnNwbGl0KCkNCj4gKw0KPiArICAgIGlmIG5vdCBoYXNhdHRyKHN1cHBvcnRlZF9mb3Jt
YXRzLCAiZm9ybWF0cyIpOg0KPiArICAgICAgICBzdXBwb3J0ZWRfZm9ybWF0cy5mb3JtYXRzID0g
e30NCj4gKw0KPiArICAgIGlmIHJlYWRfb25seSBub3QgaW4gc3VwcG9ydGVkX2Zvcm1hdHMuZm9y
bWF0czoNCj4gKyAgICAgICAgZm9ybWF0X21lc3NhZ2UgPSBxZW11X3BpcGUoIi1kcml2ZSIsICJm
b3JtYXQ9aGVscCIpDQo+ICsgICAgICAgIGxpbmUgPSAxIGlmIHJlYWRfb25seSBlbHNlIDANCj4g
KyAgICAgICAgc3VwcG9ydGVkX2Zvcm1hdHMuZm9ybWF0c1tyZWFkX29ubHldID0gXA0KPiArICAg
ICAgICAgICAgZm9ybWF0X21lc3NhZ2Uuc3BsaXRsaW5lcygpW2xpbmVdLnNwbGl0KCI6IilbMV0u
c3BsaXQoKQ0KPiArDQo+ICsgICAgcmV0dXJuIHN1cHBvcnRlZF9mb3JtYXRzLmZvcm1hdHNbcmVh
ZF9vbmx5XQ0KPiAgIA0KPiAgIGRlZiBza2lwX2lmX3Vuc3VwcG9ydGVkKHJlcXVpcmVkX2Zvcm1h
dHM9W10sIHJlYWRfb25seT1GYWxzZSk6DQo+ICAgICAgICcnJ1NraXAgVGVzdCBEZWNvcmF0b3IN
Cj4gDQoNClJldmlld2VkLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hA
dmlydHVvenpvLmNvbT4NCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5r
ZXZpY2gNCg==

