Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BF6C43215
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906DB206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PnLpm+K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906DB206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6zO-0002u4-PL
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 07:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ic6ti-0001nV-Ga
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ic6tY-0002lX-28
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:03:13 -0500
Received: from mail-eopbgr60136.outbound.protection.outlook.com
 ([40.107.6.136]:58694 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ic6tX-0002N5-1Y; Tue, 03 Dec 2019 07:03:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3IWOomxBoC+ZCxO/EjMxMVOQyFUyhKUSzqEA4Dmk8uGM7XWjBeMdODTsHHX1U56yETpU07Ry5cw04NNsnaMLZrKyHEwjtZpiCiw7eIGpBYNqrh6kPWKNieTaV2/DJLdoJ7/Qmoheue2Dd1kj5DhI9NqZPMqgkpd42489Ywj3o0Hy8vMgb4DGxZkBhFNWiphUEYZvtukTWSqdf7HPiFp3eQejbO0RbRalUOmC5EuZ5JZNPKy1ph2gDeHniXR6TJwSfAfncdhhirduRpSOOThndFFWZ0IiDRE4d0B7VMkioX1dtZ2hjTisgEEOOii7K/Qw8OGMTMI3SxyoC82h65Fmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbVL7d1iL2/Hfef3l27oT5XlQry14OTkTbx7vqNgtLY=;
 b=I/7VcaL3t3OHVmrcfYCNLF251vFkGGEs5DkJgvugqiro2GWiWYu914FafNviNUOIqb6GDqlD2eRkzRt0shVYKZYO9TI+haBPFhQhCMUjE9mB9IQz85+PkEhSYTyzuGpH4RZh1K7IQEJ/75SgNVe9MNRd6+8CUW507V2C7LYvUcQ/937KoVLr7JuDl6LsfsQ4bB0wDhKpcuN1SUZWq/VXHQQT/hbgA5iiQIVXqBsYSAf77CTKWjU3IMuWbpbgLjUaETtExl2l6ZXvyjTzAjOkm2wnylpYA2iB9m12+AcXcJzP3pl1qF9DxamFAMB3slTQ0perAtNchaBVNRs5um8wFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbVL7d1iL2/Hfef3l27oT5XlQry14OTkTbx7vqNgtLY=;
 b=PnLpm+K+/BkHsyQosx6iu1eGd8Wq5wIZCm0HXfLFUjHXFQUrFRF73gEUK4fJqAfdiLoWlLULIqVI4a9zIX7XxNngXbO/J90AciYG+JfkN0A0MFbcipDGpooBo/iV6HcMpiqKmPLPeRTBfuIt253b6Xi7xoPM3NKKVIARjJpyoXw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4801.eurprd08.prod.outlook.com (10.255.96.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:03:00 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 12:03:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 17/23] iotests: Use skip_if_unsupported
 decorator in 041
Thread-Topic: [PATCH for-5.0 v2 17/23] iotests: Use skip_if_unsupported
 decorator in 041
Thread-Index: AQHVmKmI4onup1WXjUi3guzKLabinaeoceEA
Date: Tue, 3 Dec 2019 12:03:00 +0000
Message-ID: <7a83953d-7d31-324b-e209-5d4e08086440@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-18-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-18-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0176.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::24) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191203150258844
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8937b076-42e6-4ea1-a92a-08d777e8be53
x-ms-traffictypediagnostic: AM6PR08MB4801:
x-microsoft-antispam-prvs: <AM6PR08MB4801BF52DFBC212DAE671180C1420@AM6PR08MB4801.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:459;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39840400004)(136003)(366004)(396003)(199004)(189003)(478600001)(7736002)(305945005)(186003)(26005)(31686004)(386003)(102836004)(6506007)(4326008)(76176011)(52116002)(66446008)(66476007)(14454004)(66556008)(99286004)(25786009)(256004)(64756008)(2501003)(66946007)(558084003)(110136005)(54906003)(316002)(36756003)(81166006)(5660300002)(6486002)(6246003)(71190400001)(81156014)(31696002)(8936002)(229853002)(6512007)(11346002)(3846002)(446003)(8676002)(6116002)(6436002)(86362001)(71200400001)(2616005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4801;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DeAnfEnaXA15USV9jGUlODMub5foJQ80vuSo2GN3aDQPmZKyoX2OxaNC9zQvJmicNA0LPr8GAf6EIv01YANIDwDIbxlQl/uZHwwfkYtV+WG5D6Yt5iq3hiOO9B3dYxCGNhNVOaV/aA7KcmwhUJuxWr7FpE6/M1F62GPyzW26dDIbrtVJOHvHkR//2QIiaBRRmUqvPgTuzIWRn6Dc/wDMTJG99AJNKjqAdYP7oYrvNYIZlc1lD0pIEvxwxPhnnzkFWZH7qH0gCHKlfuqnqlNJGhR049t0APEKCFHkd91KWV2PQWxnBLcydB1KzlTQK4nNWwB3X7Vnqs/vkg3PAAb7yZDXok7B6/96bzQUTLt3yhJrSydSmyazTMXmxuV7N/FJkCod2Tk+6UdcSpc0Us3ZSqCULU8Z3iDySiYmOnTOI+SkqGnuua2JH8aGO+8VGTS4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <245F7CFAE604764EADD85AA0C784CE7E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8937b076-42e6-4ea1-a92a-08d777e8be53
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:03:00.7045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: as78aOwQVrh3EXNtWH0i23LwOaJMPA45psatev5UFeY/AfegIqhBzO7gNZ7S7Hsr1PK8hSe5Va4AG4C2a+eJomnKKUXN5rqyb/YmhD7f3BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4801
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.136
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
> We can use this decorator above TestRepairQuorum.setUp() to skip all
> quorum tests with a single line.
>=20
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

