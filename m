Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101CFC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4AE20674
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="imRdZZNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4AE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSbk-0002iZ-MF
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXSZ2-0000nw-7d
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXSZ0-00082v-Qj
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:10:43 -0500
Received: from mail-eopbgr10133.outbound.protection.outlook.com
 ([40.107.1.133]:2433 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXSYz-00081S-UM; Wed, 20 Nov 2019 11:10:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1OkGbnWwEf7ZjkJT4r9P0UM8WYAejcyWI9xhO573yfxCa/zCjSOX4XDxSvTpqX4ptc/2XPqDgdYvSq22srHhYNVRus9V1jEIOTXzq0bjofd81qUzui2pnqUnnxdKW6drO5nMMk3zxb2azfUTz7UL5rHP7hGJ9fr4NzcjfTjA1qok0i6UKGFCzRIl78rvBIiJVFguQxnM84EJwHpQlSwSnwWeqnLfenfkY3n9dWeDPoo/YcdNzY+udoBrjy2v52Ga18lo0JIqZKkkTYfsTUTeA+qachw7ZrlccOxaS89JUY9+prcaxPL8sXsZYogTv4H8axl8pijWh3dK+/XFIZ47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwir7wBLt1NKLx/To4d05H9DK1xKEohjEfFcmg7b9kA=;
 b=D6nVpw0FmsGYy4oaDFM28TdcBV4psJu6Al/QFyX7sF8VlF0AnTxup7DYh1+cTr0NK004hoy4LSAhjBCWcLu/BybaJsjlZklPkZb3iyeprc9TDCYT8yZApEpvjRPQHu7GNejWg4PqMw8xsMYwm2l7Y/Y7ou1evom6uWgPx2xsLGNkO+7QL9o35+kYJA2aF4GTmvz/EK0bENg6v3y7Jy5xlcwUkeUzBpozs0CDhOCe5Gt5U8WWn6QvweuQg8y30IcYsBAPQrm1DYui2yR38N5MMWuoVZFzINS9cSlB5zTSd4Z0spf4uFWt3KQLM/8IbuZDFPlRUm1QWkM6zum2DJG9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwir7wBLt1NKLx/To4d05H9DK1xKEohjEfFcmg7b9kA=;
 b=imRdZZNVgsU/b4KrimYyKlHb5JvujXUPfHBqaXzYo+WD/3sNh32Q18yRldPTmgp/E9WtM6RwEzQtE12pHXlc/U8Ws+8qFlMYdi3xpDW1/spE5HP1sWfWmie5PWi0xEZ8mvXE+j27xJl4lzNmoV7UAgHN18ZFUwMSK6QtkWfVadc=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4117.eurprd08.prod.outlook.com (20.179.1.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 16:10:39 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 16:10:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 6/6] iotests: Test committing to short backing file
Thread-Topic: [PATCH 6/6] iotests: Test committing to short backing file
Thread-Index: AQHVn6tcQgTd8h0BOUCr2B20a33R1qeUOr8A
Date: Wed, 20 Nov 2019 16:10:39 +0000
Message-ID: <88406f3b-efdb-61d9-1fd7-36a661573f59@virtuozzo.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-7-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-7-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0264.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::16) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120191036609
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 471095fa-f3a1-4028-150e-08d76dd42f56
x-ms-traffictypediagnostic: AM6PR08MB4117:
x-microsoft-antispam-prvs: <AM6PR08MB41175B27DBA70E25D2F16B1EC14F0@AM6PR08MB4117.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39850400004)(199004)(189003)(478600001)(486006)(52116002)(11346002)(2616005)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(186003)(476003)(305945005)(102836004)(26005)(66066001)(5660300002)(7736002)(76176011)(446003)(6486002)(229853002)(31696002)(8676002)(81156014)(81166006)(6436002)(8936002)(6246003)(6512007)(36756003)(558084003)(386003)(6506007)(14454004)(4326008)(71190400001)(71200400001)(99286004)(6116002)(3846002)(316002)(31686004)(256004)(54906003)(2501003)(110136005)(25786009)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4117;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23fW4V6VqQO2LB1FRLR2+EZWzUcNNHCbl6CvcJku5y1NpyFOkGikp8Garn35HeUxF4S/6ej0NWv7XnuzeUvqjGaBpEg/AUxq+OB3BsPM4ALo4CENXen8Y/PhjbHDVC8RcUx7pDkkhYxxXnxPky/ei9+LsWqBx4tprVHCsp/uJzhy6aNP09cvo/pjxVkqInr60je69XNM2cHxXwBR2w15r1GaaREJ3f14hww3f01TEZQQQpNtHLq4TaXO55xWzUK7P7+7MwQpD/B1TMK5ngY1F4+xL2bNISAl4l+KWUJo1f8lrPaYbvF/WPqPKf9styFUAN05Dx0X37YGMzyjjSxniuTX9EOrIEEJEb5pZJX6mHtJOptVWfE+hWbAkFf2LYob9nfqx9u4DS1bQt8/Mz80yI40izT23h6Ljl5OyL/5tJKcfE8QTo2Mg+6tCKQB68VL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <EA1D8606B4B3294B821EF3D643429F29@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471095fa-f3a1-4028-150e-08d76dd42f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 16:10:39.2838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZk9GSdpN7w6mmO5+MrHKR6pWFuRcVZQ1jw+iF5/olS+unfmqdXQI21SglUzWKi2eNgeh1enHpffhldZUgJmAX8A7Yzd3CbmdJMagvcw5Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4117
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.133
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.11.2019 17:03, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

