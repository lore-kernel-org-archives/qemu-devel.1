Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA77C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A012076A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="JDnEPdu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A012076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkogv-0000js-Ra
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jkog3-0008VS-8r
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:57:27 -0400
Received: from mail-db8eur05on2133.outbound.protection.outlook.com
 ([40.107.20.133]:64257 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jkog0-0007CD-9m
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:57:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF9W5VLYeIinhWdC4HEIFs7xbRuqjnUdLxmEEZNfcFv01WLM4fPGboB4XakTsZLdIAUX/coqaCYgBW1oAJxWDCEHfPOCES2AR6ZVoiJO+VXfRMDV7whPgkv6wQ4OeTf7q935B9d5z37sP45FfH6ZpceTnacGZ1YRnvpgorvwUEL/3VZV4tKlQQYnTInJqB4yEbh6lxQqMyHQE0+SkzP7OzXtuLl/GYa+Eh0os6Ts5ghZtsFSj7w3H+5Htmj/6ZkYRimiIIjhHyWw3I6xDLfulRGVNWT5DA3MAkiL5U94kd+Gv5dAdFUqXLQBx8LOiSD8tmvaRhc1agRsJcfMeNl7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFCNRknYFkSXwhT0Pfb39btp0MJUlRihzV9O0wwZ0I4=;
 b=niC2/MtXWH9gI3v3j2sGvnV8vQFma77/RKn3Ku/hQ6n1q0ocysKjgkpMZL2gFHnwxZpCM4da9En2bZ6dN5ioJoDxAXSN0RGg9Igkqf2hYwt3FdzUVnhw/UJKJu1mkT7me1CeMNu1XjUedy4u2Q3SxhYGAV1w0Wkgk3K+xaXh8UAL3VpqOGiX2Gu+wBVFVdSCNnxZVWSbUH9jmK8bBEk6XlA6Kj2c3wJRAwkBtpgCVD/RDxCf+3fWaD2hzue2q0rqxkxyhXoAj6nHZONYldxLKN+g9Hsrg8j4HJG0ofgj3dZbSbj3GAbIaCqHq610DnOBHqbgnntGRMmkJUY1nqyXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFCNRknYFkSXwhT0Pfb39btp0MJUlRihzV9O0wwZ0I4=;
 b=JDnEPdu0Pov/h7zfBoSA8FJ+hWjJgtkv1Gm2GN2+WbrKXW89+MGHQDSetumB+xcONOUS6cCwQTijWJjTuOz3kYNDnryZSnmgGA0fUu8//W/Rw++NStn6ocPcDpeCYOM7mlWzuTPydaUpC+tl6PGc4bXsmDy3+mGhP70cycELGoE=
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5573.eurprd03.prod.outlook.com (2603:10a6:20b:f4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 12:42:18 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 12:42:18 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 6/6] linux-user: Add strace support for printing
 arguments of fallocate()
Thread-Topic: [PATCH v3 6/6] linux-user: Add strace support for printing
 arguments of fallocate()
Thread-Index: AQHWQAgpz5V+i9b4dEeawYoFi7ySKKjZmHoAgAAMRAA=
Date: Mon, 15 Jun 2020 12:42:18 +0000
Message-ID: <ed7ffa8d-955d-a5d8-f59d-2b8d61c37361@syrmia.com>
References: <20200611155109.3648-1-filip.bozuta@syrmia.com>
 <20200611155109.3648-7-filip.bozuta@syrmia.com>
 <e5e4e427-f6ef-1460-fccf-1dad5b09ff47@vivier.eu>
In-Reply-To: <e5e4e427-f6ef-1460-fccf-1dad5b09ff47@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: vivier.eu; dkim=none (message not signed)
 header.d=none;vivier.eu; dmarc=none action=none header.from=syrmia.com;
x-originating-ip: [46.240.135.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a22e3a0-cd9e-459f-aa23-08d811298a83
x-ms-traffictypediagnostic: AM6PR03MB5573:
x-microsoft-antispam-prvs: <AM6PR03MB5573AECA8F20C0E787E29312EB9C0@AM6PR03MB5573.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SU97XTx53FkH/TotADnJYteOIgkotgZCKqAi3L2uU7RQPl0y2Dazr98u32D4l2ltZo5lXR0xjW/wXTfzzD2YJ9T/7KrYgA9HSgsHtnsjpoo/9BB36lOPIKCEdxc3QkhTR8YtyLGK6Uqba38daXDBBBzoJT8J6U7ipXs/eu7S4/toDhuJQdVLBn+FgRDDjnSXEvf2bPCoz+S9FBpHs7dlQPeFW/4AaajTwXEy3pK3pBsZBXIagt80i/k/TzI4oUwE64UTTgm/STWUeoXFBGewyuuGhR3L0mWw5yipTlXooeHM0S/BcSP1hqRI82YZbGgdHdfydn/WiKucQ4nzUC/CU+Gmu21vYxtCTMbtkRmDWLgDEtXCswlYRdUQ5GncWCl6x8BNpDJZFCHm44VKhZs/LkGxPY+eyxvHB8GeyivoOhDcoBsbk3b+f8OnlTm0k++i8JQrsjxQVfZnIbUVYrqGUogzhsPNcv/e981Dzpd0sFg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(39830400003)(346002)(366004)(136003)(396003)(8936002)(186003)(5660300002)(6486002)(66574014)(31696002)(966005)(86362001)(508600001)(26005)(6512007)(316002)(6506007)(8676002)(110136005)(2906002)(83380400001)(31686004)(36756003)(2616005)(66946007)(66556008)(66476007)(76116006)(71200400001)(66446008)(64756008)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uNk0gjKWhN54+a1zzUDNbDIeu2P/iqHoviyWrJ3LT+/HBTrJNgD3KZCJOuXnpn3jYuHjgudk7ZtiQqPyHMuTres5wvUBLZTJtWrAlc5nUBX/1IGM4XdXxyq8z+Ib6uR+HJO2v4DoJNySaw3I2MCdxiEfJNS19xNgrQncKGoPzaLlh7cC79P9w9w/u3buM6LBAnJZjzZuRB3krRu5a1FS0Uae4py3yc0VHYaSgWjBJbWJlGcxWYNCSSYMIwEi4E73beajcJ8U8MmFNVzq2lo3nWKbSMNCWLszoFANwbJDKU+AIUCh/2wszTwtaj57fyJtmdTxV8yvbEyI+Fhg+gVhkgAzE2/4tclj1SR4Zpqm4DajjPJTnEUmh6iYMoms2EbWN+znAwYeTTrv5H261Yd50BfJCsSCSm3vOnCZsXFzxKkbhb6U9tKoqxOTxbcvZta9reNXub+0sGfLIOEo+eIPLo4RptQkxNg/FCDXCvsgpH9NTlBnyJX/qqsv6dqaRZoG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D805836B00FCD04487FAC3CA07DF22B1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a22e3a0-cd9e-459f-aa23-08d811298a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 12:42:18.6651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8s1/nKLIKhTZCE+mW2lqbdFE9QgQld0UvedVBBwKfMHjQB35yJCSR2mKqJ3nKhIgCSpu4oj31uRAka/MxPxWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5573
Received-SPF: pass client-ip=40.107.20.133;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:57:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTUuNi4yMC4gMTM6NTgsIExhdXJlbnQgVml2aWVyIHdyb3RlOg0KPiBMZSAxMS8wNi8yMDIw
IMOgIDE3OjUxLCBGaWxpcCBCb3p1dGEgYSDDqWNyaXTCoDoNCj4+IEZyb206IEZpbGlwIEJvenV0
YSA8RmlsaXAuQm96dXRhQHN5cm1pYS5jb20+DQo+Pg0KPj4gVGhpcyBwYXRjaCBpbXBsZW1lbnRz
IHN0cmFjZSBhcmd1bWVudCBwcmludGluZyBmdW5jdGlvbmFsaXR5IGZvciBmb2xsb3dpbmcgc3lz
Y2FsbDoNCj4+DQo+PiAgICAgICpmYWxsb2NhdGUgLSBtYW5pcHVsYXRlIGZpbGUgc3BhY2UNCj4+
DQo+PiAgICAgICAgICBpbnQgZmFsbG9jYXRlKGludCBmZCwgaW50IG1vZGUsIG9mZl90IG9mZnNl
dCwgb2ZmX3QgbGVuKQ0KPj4gICAgICAgICAgbWFuIHBhZ2U6IGh0dHBzOi8vd3d3Lm1hbjcub3Jn
L2xpbnV4L21hbi1wYWdlcy9tYW4yL2ZhbGxvY2F0ZS4yLmh0bWwNCj4+DQo+PiBJbXBsZW1lbnRh
dGlvbiBub3RlczoNCj4+DQo+PiAgICAgIFRoaXMgc3lzY2FsbCdzIHNlY29uZCBhcmd1bWVudCAi
bW9kZSIgaXMgY29tcG9zZWQgb2YgcHJlZGVmaW5lZCB2YWx1ZXMNCj4+ICAgICAgd2hpY2ggcmVw
cmVzZW50IGZsYWdzIHRoYXQgZGV0ZXJtaW5lIHRoZSB0eXBlIG9mIG9wZXJhdGlvbiB0aGF0IGlz
DQo+PiAgICAgIHRvIGJlIHBlcmZvcm1lZCBvbiB0aGUgZmlsZSBzcGFjZS4gRm9yIHRoYXQgcmVh
c29uLCBhIHByaW50aW5nDQo+PiAgICAgIGZ1bmN0aW9uICJwcmludF9mYWxsb2NhdGUiIHdhcyBz
dGF0ZWQgaW4gZmlsZSAic3RyYWNlLmxpc3QiLiBUaGlzIHByaW50aW5nDQo+PiAgICAgIGZ1bmN0
aW9uIHVzZXMgYW4gYWxyZWFkeSBleGlzdGluZyBmdW5jdGlvbiAicHJpbnRfZmxhZ3MoKSIgdG8g
cHJpbnQgZmxhZ3Mgb2YNCj4+ICAgICAgdGhlICJtb2RlIiBhcmd1bWVudC4gVGhlc2UgZmxhZ3Mg
YXJlIHN0YXRlZCBpbnNpZGUgYW4gYXJyYXkgImZhbGxvY19mbGFncyINCj4+ICAgICAgdGhhdCBj
b250YWlucyB2YWx1ZXMgb2YgdHlwZSAic3RydWN0IGZsYWdzIi4gVGhlc2UgdmFsdWVzIGFyZSBp
bnN0YW50aWF0ZWQNCj4+ICAgICAgdXNpbmcgYW4gZXhpc3RpbmcgbWFjcm8gIkZMQUdfR0VORVJJ
QygpIi4gTW9zdCBvZiB0aGVzZSBmbGFncyBhcmUgZGVmaW5lZA0KPj4gICAgICBhZnRlciBrZXJu
ZWwgdmVyc2lvbiAzLjAgd2hpY2ggaXMgd2h5IHRoZXkgYXJlIGVud3JhcHBlZCBpbiBhbiAjaWZk
ZWYNCj4+ICAgICAgZGlyZWN0aXZlLg0KPj4gICAgICBUaGUgc3lzY2FsbCdzIHRoaXJkIGFudCBm
b3VydGggYXJndW1lbnQgYXJlIG9mIHR5cGUgIm9mZl90IiB3aGljaCBjYW4NCj4+ICAgICAgY2F1
c2UgdmFyaWF0aW9ucyBiZXR3ZWVuIDMyLzY0LWJpdCBhcmNoaXRlY3R1cmVzLiBUbyBoYW5kbGUg
dGhpcyB2YXJpYXRpb24sDQo+PiAgICAgIGZ1bmN0aW9uICJ0YXJnZXRfb2Zmc2V0NjQoKSIgd2Fz
IGNvcGllZCBmcm9tIGZpbGUgInN0cmFjZS5jIiBhbmQgdXNlZCBpbg0KPj4gICAgICAicHJpbnRf
ZmFsbG9jYXRlIiB0byBwcmludCAib2ZmX3QiIGFyZ3VtZW50cyBmb3IgMzItYml0IGFyY2hpdGVj
dHVyZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRmlsaXAgQm96dXRhIDxGaWxpcC5Cb3p1dGFA
c3lybWlhLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBMYXVyZW50IFZpdmllciA8bGF1cmVudEB2aXZp
ZXIuZXU+DQo+PiAtLS0NCj4+ICAgbGludXgtdXNlci9xZW11LmggICAgICB8IDE2ICsrKysrKysr
KysrKysrKysNCj4+ICAgbGludXgtdXNlci9zdHJhY2UuYyAgICB8IDQwICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgbGludXgtdXNlci9zdHJhY2UubGlzdCB8
ICAyICstDQo+PiAgIGxpbnV4LXVzZXIvc3lzY2FsbC5jICAgfCAxNiAtLS0tLS0tLS0tLS0tLS0t
DQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvcWVtdS5oIGIvbGludXgtdXNlci9xZW11
LmgNCj4+IGluZGV4IDhmOTM4YjgxMDUuLmJlNjczOTFiYTQgMTAwNjQ0DQo+PiAtLS0gYS9saW51
eC11c2VyL3FlbXUuaA0KPj4gKysrIGIvbGludXgtdXNlci9xZW11LmgNCj4+IEBAIC02NzAsNiAr
NjcwLDIyIEBAIHN0YXRpYyBpbmxpbmUgaW50IGlzX2Vycm9yKGFiaV9sb25nIHJldCkNCj4+ICAg
ICAgIHJldHVybiAoYWJpX3Vsb25nKXJldCA+PSAoYWJpX3Vsb25nKSgtNDA5Nik7DQo+PiAgIH0N
Cj4+ICAgDQo+PiArI2lmIFRBUkdFVF9BQklfQklUUyA9PSAzMg0KPj4gK3N0YXRpYyBpbmxpbmUg
dWludDY0X3QgdGFyZ2V0X29mZnNldDY0KHVpbnQzMl90IHdvcmQwLCB1aW50MzJfdCB3b3JkMSkN
Cj4+ICt7DQo+PiArI2lmZGVmIFRBUkdFVF9XT1JEU19CSUdFTkRJQU4NCj4+ICsgICAgcmV0dXJu
ICgodWludDY0X3Qpd29yZDAgPDwgMzIpIHwgd29yZDE7DQo+PiArI2Vsc2UNCj4+ICsgICAgcmV0
dXJuICgodWludDY0X3Qpd29yZDEgPDwgMzIpIHwgd29yZDA7DQo+PiArI2VuZGlmDQo+PiArfQ0K
Pj4gKyNlbHNlIC8qIFRBUkdFVF9BQklfQklUUyA9PSAzMiAqLw0KPj4gK3N0YXRpYyBpbmxpbmUg
dWludDY0X3QgdGFyZ2V0X29mZnNldDY0KHVpbnQ2NF90IHdvcmQwLCB1aW50NjRfdCB3b3JkMSkN
Cj4+ICt7DQo+PiArICAgIHJldHVybiB3b3JkMDsNCj4+ICt9DQo+PiArI2VuZGlmIC8qIFRBUkdF
VF9BQklfQklUUyAhPSAzMiAqLw0KPj4gKw0KPj4gICAvKioNCj4+ICAgICogcHJlZXhpdF9jbGVh
bnVwOiBob3VzZWtlZXBpbmcgYmVmb3JlIHRoZSBndWVzdCBleGl0cw0KPj4gICAgKg0KPj4gZGlm
ZiAtLWdpdCBhL2xpbnV4LXVzZXIvc3RyYWNlLmMgYi9saW51eC11c2VyL3N0cmFjZS5jDQo+PiBp
bmRleCA0MGMxN2Y3YWJlLi41ZjM3MDI1NmUzIDEwMDY0NA0KPj4gLS0tIGEvbGludXgtdXNlci9z
dHJhY2UuYw0KPj4gKysrIGIvbGludXgtdXNlci9zdHJhY2UuYw0KPj4gQEAgLTExNDQsNiArMTE0
NCwyNiBAQCBVTlVTRUQgc3RhdGljIHN0cnVjdCBmbGFncyBzdGF0eF9tYXNrW10gPSB7DQo+PiAg
ICAgICBGTEFHX0VORCwNCj4+ICAgfTsNCj4+ICAgDQo+PiArVU5VU0VEIHN0YXRpYyBzdHJ1Y3Qg
ZmxhZ3MgZmFsbG9jX2ZsYWdzW10gPSB7DQo+PiArICAgIEZMQUdfR0VORVJJQyhGQUxMT0NfRkxf
S0VFUF9TSVpFKSwNCj4+ICsgICAgRkxBR19HRU5FUklDKEZBTExPQ19GTF9QVU5DSF9IT0xFKSwN
Cj4+ICsjaWZkZWYgRkFMTE9DX0ZMX05PX0hJREVfU1RBTEUNCj4+ICsgICAgRkxBR19HRU5FUklD
KEZBTExPQ19GTF9OT19ISURFX1NUQUxFKSwNCj4+ICsjZW5kaWYNCj4+ICsjaWZkZWYgRkFMTE9D
X0ZMX0NPTExBUFNFX1JBTkdFDQo+PiArICAgIEZMQUdfR0VORVJJQyhGQUxMT0NfRkxfQ09MTEFQ
U0VfUkFOR0UpLA0KPj4gKyNlbmRpZg0KPj4gKyNpZmRlZiBGQUxMT0NfRkxfWkVST19SQU5HRQ0K
Pj4gKyAgICBGTEFHX0dFTkVSSUMoRkFMTE9DX0ZMX1pFUk9fUkFOR0UpLA0KPj4gKyNlbmRpZg0K
Pj4gKyNpZmRlZiBGQUxMT0NfRkxfSU5TRVJUX1JBTkdFDQo+PiArICAgIEZMQUdfR0VORVJJQyhG
QUxMT0NfRkxfSU5TRVJUX1JBTkdFKSwNCj4+ICsjZW5kaWYNCj4+ICsjaWZkZWYgRkFMTE9DX0ZM
X1VOU0hBUkVfUkFOR0UNCj4+ICsgICAgRkxBR19HRU5FUklDKEZBTExPQ19GTF9VTlNIQVJFX1JB
TkdFKSwNCj4+ICsjZW5kaWYNCj4+ICt9Ow0KPj4gKw0KPj4gICAvKg0KPj4gICAgKiBwcmludF94
eHggdXRpbGl0eSBmdW5jdGlvbnMuICBUaGVzZSBhcmUgdXNlZCB0byBwcmludCBzeXNjYWxsDQo+
PiAgICAqIHBhcmFtZXRlcnMgaW4gY2VydGFpbiBmb3JtYXQuICBBbGwgb2YgdGhlc2UgaGF2ZSBw
YXJhbWV0ZXINCj4+IEBAIC0xNTYxLDYgKzE1ODEsMjYgQEAgcHJpbnRfZmFjY2Vzc2F0KGNvbnN0
IHN0cnVjdCBzeXNjYWxsbmFtZSAqbmFtZSwNCj4+ICAgfQ0KPj4gICAjZW5kaWYNCj4+ICAgDQo+
PiArI2lmZGVmIFRBUkdFVF9OUl9mYWxsb2NhdGUNCj4+ICtzdGF0aWMgdm9pZA0KPj4gK3ByaW50
X2ZhbGxvY2F0ZShjb25zdCBzdHJ1Y3Qgc3lzY2FsbG5hbWUgKm5hbWUsDQo+PiArICAgIGFiaV9s
b25nIGFyZzAsIGFiaV9sb25nIGFyZzEsIGFiaV9sb25nIGFyZzIsDQo+PiArICAgIGFiaV9sb25n
IGFyZzMsIGFiaV9sb25nIGFyZzQsIGFiaV9sb25nIGFyZzUpDQo+PiArew0KPj4gKyAgICBwcmlu
dF9zeXNjYWxsX3Byb2xvZ3VlKG5hbWUpOw0KPj4gKyAgICBwcmludF9yYXdfcGFyYW0oIiVkIiwg
YXJnMCwgMCk7DQo+PiArICAgIHByaW50X2ZsYWdzKGZhbGxvY19mbGFncywgYXJnMSwgMCk7DQo+
PiArI2lmIFRBUkdFVF9BQklfQklUUyA9PSAzMg0KPj4gKyAgICBwcmludF9yYXdfcGFyYW0oIiVs
ZCIsIHRhcmdldF9vZmZzZXQ2NChhcmcyLCBhcmczKSwgMCk7DQo+PiArICAgIHByaW50X3Jhd19w
YXJhbSgiJWxkIiwgdGFyZ2V0X29mZnNldDY0KGFyZzQsIGFyZzUpLCAxKTsNCj4+ICsjZWxzZQ0K
Pj4gKyAgICBwcmludF9yYXdfcGFyYW0oIiVsZCIsIGFyZzIsIDApOw0KPj4gKyAgICBwcmludF9y
YXdfcGFyYW0oIiVsZCIsIGFyZzMsIDEpOw0KPj4gKyNlbmRpZg0KPj4NCj4gWW91IGhhdmUgcmVt
b3ZlZCB0aGUgUFJJdTY0IGFuZCBUQVJHRVRfQUJJX0ZNVF9sZCBmcm9tIHRoZSB2Mi4gU28gbXkN
Cj4gUmV2aWV3ZWQtYnkgaXMgbm90IHJlbGV2YW50IGZvciB0aGUgdjMuDQoNCkkgYW0gc29ycnku
IFNvbWV0aGluZyB3ZW4ndCB3cm9uZyAobm90IHN1cmUgd2hhdC4uLikgd2hlbiBJIHVzZWQgZ2l0
IA0KcmViYXNlIGFuZCBpdCByZW1vdmVkIHNvbWUgY2hhbmdlcyBmcm9tIHYyDQoNCihpbmNsdWRp
bmcgdGhlIG9uZXMgd2l0aCByZW1vdmV4YXR0ciwgbHJlbW92ZXhhdHRyLCBmcmVtb3ZleGF0dHIp
DQoNClRoaXMgd2FzIGFuIGlycmVzcG9uc2libGUgbWlzdGFrZSBieSBteSBwYXJ0IGFuZCBJIHdp
bGwgb2YgY291cnNlIA0KY29ycmVjdCB0aGlzIGluIHY0IGFuZCBtYWtlIHN1cmUgdG8gdGhvcm91
Z2hseSBjaGVjayBteQ0KDQpwYXRjaGVzIGJlZm9yZSBzZW5kaW5nIHRoZW0gc28gdGhhdCB0aGlz
IGRvZXNuJ3QgaGFwcGVuIGFnYWluLg0KDQpKdXN0IHdhbnRlZCB0byBsZXQgeW91IGtub3cgdGhh
dCBJIGRpZG4ndCBkbyB0aGlzIG9uIHB1cnBvc2UuDQoNCj4NCj4gVGhhbmtzLA0KPiBMYXVyZW50
DQoNCg0K

