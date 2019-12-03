Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE31CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 15:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A85C2073C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 15:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lQL9uRnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A85C2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic9p6-0001vC-Np
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 10:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ic9M5-0008Js-KS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ic9Lw-00080Z-S3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:40:40 -0500
Received: from mail-db5eur03on0719.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::719]:58859
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ic9Lu-0007Y3-5j; Tue, 03 Dec 2019 09:40:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liKB2cqbNGHjH1SuMyZ9WmfqDfmx2lK4iOy+6sotmkmlIuMT0FkzLmcr/gi+oMgXxsHkGkjcxudY1WJ2X1/8C8KnHhdBfGI9tPKCn5C1WvOOhx/jPQW1k0pXJ+vCFFljl8YkWl8ACYo8mxIsRPmvaMevygq9g+wS6XR61nvToSOtzKBSlqNm236ncMveL+I/IcXertYjHwv541eFNxQnTkbZM5neM8mMtA5hiSs9y5pMLcYN5cnLHAjADnPtOVIbfNB/xJKSAmfu9gu0TNUgJzEnbo+OQxQku3o6nhuD78jIqVbXNZku3yrBpsRuFsoPvNb5EXYIYVJkabd77rBaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jkjzv0Bttnp9q/WC1d1okM9TGo2WcrT+2RX7MXARveo=;
 b=moGRg4F2fdkmSbcNyj4JevCAlq+BSN2oW5Wj+LJOesuols8etKbPl3C599b1+Sv01SpvOiWTDv7v+zMUzGkU6673uhTOJwakPXku1Gaa7OPyQSV2imi+bi6hxld1qeTrW3jmyXcpp3yG3vcoOnHlwmH/y6Bfi5UIW5vWjXVkfCj3kaVoksSk3+2+Ail+Dhoyy66p6ssM7esD0etqQyIA3eWZanGEEufMEZWTiXQlvYQj5zKz6wPkrkAbJNT/H1M2SQOrOP7B0Asax9h0ho51nuuYJbVnjkxTvRho2cn6fO9keCLRdxDg6lu25JAvUkiUt6G30URgAmSOn7rd/yiC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jkjzv0Bttnp9q/WC1d1okM9TGo2WcrT+2RX7MXARveo=;
 b=lQL9uRnAAFyz2W2eLGsAp5rdM0ehqItepbjO88ZM0JZHyyAPFwDg5sotyGEwFY2ek8ksRN3NutHtdyOlPRryylO267cf84Ag6uQcGCJ2ElPgiLoeWddg/Yjf8vgHNqOfY28EH14PxbVijNiAuu13aXIFoLQsFVDO0Y/TWDAo2Fg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3143.eurprd08.prod.outlook.com (52.135.163.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 14:40:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 14:40:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 21/23] iotests: Add tests for invalid Quorum
 @replaces
Thread-Topic: [PATCH for-5.0 v2 21/23] iotests: Add tests for invalid Quorum
 @replaces
Thread-Index: AQHVmKmQJNC8FFlkeUyVupPQdogsOaeond4A
Date: Tue, 3 Dec 2019 14:40:26 +0000
Message-ID: <6f457f17-2073-540a-386d-60fe78587151@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-22-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-22-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0047.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::33) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191203174024244
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ff9f0db-affc-4cc2-f782-08d777febc3f
x-ms-traffictypediagnostic: AM6PR08MB3143:
x-microsoft-antispam-prvs: <AM6PR08MB314386BB1250299D2F5F6599C1420@AM6PR08MB3143.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39850400004)(346002)(376002)(366004)(199004)(189003)(110136005)(5660300002)(316002)(6246003)(31696002)(54906003)(6512007)(71200400001)(36756003)(71190400001)(7736002)(99286004)(186003)(26005)(305945005)(6116002)(25786009)(102836004)(31686004)(256004)(3846002)(446003)(6486002)(66476007)(229853002)(2616005)(52116002)(76176011)(64756008)(2906002)(66556008)(66446008)(8676002)(8936002)(2501003)(14454004)(478600001)(558084003)(81166006)(6436002)(11346002)(4326008)(66946007)(81156014)(386003)(86362001)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3143;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DobUoEnEn8wyx08E2c1jks4pY3w98Ae/vs7agn0ZI3/9FkWeyVrsgNlm4i/8FTFetJZisAysv/DLbBEaL72FlQ2VGMzn7/L+9eqanaqnUpUKlDoltHEGbowMCSnhqTQoESHxfpq8NI/q/BaG8GDDi25F1v0oqHTX6PHKREweN5HAl+591hPKX/i/bKdz7dr0XYT975+i8XE7M/QlZW0c1GrWW7wnssBxlVCnCGngj4XRjxPrj8l+wna2PSHLdgCpmhyTX9MXQFQbsaSe5Zwmx343uAcpwD1DH2+bjCPTehlrOou7JqbLHpLN9lLds0HKzisW3w2PVYQCRR+tLKmw1oI8M0La5ro4300xHQqzJnAdbruMCkC3nQcpRPqBflV/jOhN8E0OxVXlGzHRGM/WSGkp/Svg3fieS+9tfsREILXnrK5Vi08zetTyWLUZqtoM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <015C843E7B2EF54BA9DE53F9DC31E822@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff9f0db-affc-4cc2-f782-08d777febc3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 14:40:26.1710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yH0XdDNsG8nGnxNBJ5YiMX1ovGiDuvhPrLxAvKGmfcSLFdCHnWu/AB9P1mVHGdcuvdB4vKidHfP+Uc2ji8lm+D9g+mlbrsnyk+0l0pcmm1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3143
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::719
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.11.2019 19:02, Max Reitz wrote:
> Add two tests to see that you cannot replace a Quorum child with the
> mirror job while the child is in use by a different parent.
>=20
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

