Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DD3C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9EC21897
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GHTMX2XA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9EC21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAaKc-000126-Iy
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 09:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAaJW-0000NE-7d
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAaJV-0007gq-7M
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:48:10 -0400
Received: from mail-eopbgr30132.outbound.protection.outlook.com
 ([40.107.3.132]:57033 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAaJR-0007ei-C8; Wed, 18 Sep 2019 09:48:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mfy74YA54zT5Jf+BdPB0EupfAs3DaRaHc8LUkL+CGK46/T6e6kN6R0bGU8Zj2EPnJrmiXwZQUuB2Am3FbaInxaVXPouN4M3+wZOBvs4M4ONHhP66Kn1wBZI4dN78wp5HB7ZT5GvsimCQIlXvPMCxKAx2vfKtP6yJREIkbiQx2ZNP93f5AbQQ9d2N74qcPFSpyGhSfNRLPZfEQlkwoSrxSTN1bnQMZizQDhbtxnatI2QDlkTKiScNWy88SvfJzNqTiUq5L/m3dJMOMMAjHPdL3eUDVX4bnAWMNeKt4zGf94QdqtpiE0EDjXsPjNa/WfIAMjy334Hae7WoAdTDhQKQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9EJ4v+yZ0G9gEoEN0kKMN23B3NBF7LPQKJhzlWMt3k=;
 b=g1AyuM1HlYMAdkMidooNqj+F3PiaLRr/8C7hgTqRO+TgJapPS6o2Uhp9oJk67o767Vx443QTbheEs4aIGZfbbnAmarBdh8+gQtEYeNFDjRYdBGeGpG6SwTXm0dG6DIdAgmSW+3/TThzkul0GZxVxKOB2Py4Dpk7sJXA+ipJKf1KM0KYGwGVDuwVAYJTpHaaTBFg39JUC1ZnpJRfTolGfkzkG7xoN6zdXJrPF2sE5L6lOn8zQxMUMyuf7Ci2/oo6R3JQxNK5GqD+y6G4/BenSt3qxeGWZTfipXHQRojDHi3+Gq1L9uQ9EZEpEM6UNgTKi07Q7xnWqfPpByk4BW+fz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9EJ4v+yZ0G9gEoEN0kKMN23B3NBF7LPQKJhzlWMt3k=;
 b=GHTMX2XAsnOUEY+oZlSUa3B5Qkf+p/71gZ5O9ULtoTcQGOSII6p35NMrSAyyxjiInfbgY5qwzGpcWP1ByY7vimLZjhA3HlMV9viMWiM7Mkco6hxXFawlvQg+SvC8ONrrIlEknOaZGA0K76gYWHAfZxnJIDqrcNNESx4rKm+13mA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5131.eurprd08.prod.outlook.com (10.255.4.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Wed, 18 Sep 2019 13:48:02 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 13:48:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v5 2/5] iotests: add script_initialize
Thread-Index: AQHVbbLPb9y8jz459EKjJK8Tisflsqcxc/gA
Date: Wed, 18 Sep 2019 13:48:02 +0000
Message-ID: <6c264a4e-2abd-2ada-4d49-89b0cc73a635@virtuozzo.com>
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-3-jsnow@redhat.com>
In-Reply-To: <20190917234549.22910-3-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0027.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::13) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190918164800100
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef7bba03-f710-41cd-1b8e-08d73c3ed2f1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5131; 
x-ms-traffictypediagnostic: DB8PR08MB5131:
x-microsoft-antispam-prvs: <DB8PR08MB513153EDC300911B0032828CC18E0@DB8PR08MB5131.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(376002)(346002)(39850400004)(189003)(199004)(6506007)(6512007)(81156014)(99286004)(14454004)(8676002)(478600001)(7736002)(81166006)(6436002)(4326008)(6486002)(31696002)(25786009)(2906002)(71200400001)(3846002)(66476007)(305945005)(8936002)(6116002)(86362001)(71190400001)(229853002)(36756003)(66556008)(64756008)(66946007)(66446008)(386003)(5660300002)(52116002)(2616005)(2501003)(446003)(316002)(76176011)(476003)(102836004)(26005)(4744005)(256004)(14444005)(186003)(66066001)(110136005)(54906003)(31686004)(486006)(6246003)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5131;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0rceSnVGxpUbzpgZi/8Og9sEU/c6ZQ8uilw5yzgPndNJ6RgG49UXeNR4rd52mz8scQlGKVD2WgohqRMcDjCh2c10U+jYGyBLOV+3E9YOuLCvnC7e1RpS6JMIlT2DOhzAHNDwAQ9FIZdW5JgLFkwYPmPAHYvo+NB0exTlFwNa4jWCLOdLiKymgPWAL/6n6FiM2VL7iXfC/hkNUMfeAD5xhJ75TARkOKNKmIjnPxHx30z+cbQC0XHjlHQPKi9AlvMN5m/GDXp91sTJGkI9A4vY3nydBSYM7FWGxw+koB6D6SyJsZQLxiRNIj5PFgQRw+OLzhUTZU80dU5TC5lljtSZBW6rYI9RjPLyy0FEdc8IvkTX8EHPx84gWUVxkoLURlbYTRpUx4JHQKapsNLNEtZONwwTLbcAXh79r/NhZux0FdQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <744B9F9F8D052942A9EA02D4D52D4D45@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7bba03-f710-41cd-1b8e-08d73c3ed2f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 13:48:02.2621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4InaTa1+e1dPJ8j9uKcbhAZzIQKnOnxMkEl9w05CtHbRAIEl6HAfFygsvfTNhS0c5ZIMcLcp1AYKK7EwOEdA1b5kb5xHXwH4SNp/SLUKWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5131
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.132
Subject: Re: [Qemu-devel] [PATCH v5 2/5] iotests: add script_initialize
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDkuMjAxOSAyOjQ1LCBKb2huIFNub3cgd3JvdGU6DQo+IExpa2Ugc2NyaXB0X21haW4sIGJ1
dCBkb2Vzbid0IHJlcXVpcmUgYSBzaW5nbGUgcG9pbnQgb2YgZW50cnkuDQo+IFJlcGxhY2UgYWxs
IGV4aXN0aW5nIGluaXRpYWxpemF0aW9uIHNlY3Rpb25zIHdpdGggdGhpcyBkcm9wLWluIHJlcGxh
Y2VtZW50Lg0KPiANCj4gVGhpcyBicmluZ3MgZGVidWcgc3VwcG9ydCB0byBhbGwgZXhpc3Rpbmcg
c2NyaXB0LXN0eWxlIGlvdGVzdHMuDQo+IA0KPiBBbnkgc3BlY2lmaWNhdGlvbiBmb3Igc3VwcG9y
dGVkX29zZXM9WydsaW51eCddIHdhcyBkcm9wcGVkIGFzIGV4cGxhaW5lZA0KPiBpbiB0aGUgcHJl
dmlvdXMgY29tbWl0LCBiZWNhdXNlIHRoZXJlIHdhcyBuZXZlciBhbnkgcmVhc29uIHRvIGxpbWl0
IHB5dGhvbg0KPiB0ZXN0cyB0byBsaW51eC1vbmx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9o
biBTbm93PGpzbm93QHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K

