Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75619C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD1620872
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T5Di94ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD1620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXjkE-0003Zq-DS
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 05:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXjj7-0002el-CK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXjj2-0005de-4Z
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:30:17 -0500
Received: from mail-eopbgr20103.outbound.protection.outlook.com
 ([40.107.2.103]:38627 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXjj1-0005bi-9r; Thu, 21 Nov 2019 05:30:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7NknohP4UX1+rVnolzmzUrltTob4rK86UDn+9nzo0GS0WSN3ZezSacFGrhulmlUQ8pyZOFDJSCjMYyGf/JkeZIgMPB/HZtWEoyTGi2qcgEwMCbfjFz7h63e82QtCRSIlL2YAWDqIQquYVWVevLNoKn+g7XKDg4ZJKEju1zb+71RfHj9c4pcDfIg7yznbvTbt7hR6IRlq7WL2Xh1OnwsrddiMNMo6QI+MRWcj+5/1Eg6AxGhxrJqZGaw+iXPkplOI3yq6qlRX8m2IMO0TbxD6l2A0WZrHkOEOiuwIZf+evj8hYUXQ85Ks/8zrss2eNWTVEQdsa6BHoJ0MqxMWnN1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8PBJI2trWaQCEAlkKG9hKZIPjEH4t272inKcTOCI0o=;
 b=M2VezoS9w+wQYPidKSRF3SE0lSB9TK0pNSLaPxRP3KZmlP3hS3QH08P6W+z4t1jvQwjQYwovs/hNsHeFfyhKwmCxnTjFEVPkJhKCM221KyEgfKMAasAy0Es8Rblp31wkzJcLJLNvq5jofGDa+LPoqFi1b9y1b63cNrxOlFEilcYYHbUYNHlWchcu5c2AAFFOzadru+VPlCWywQqlPYogCs7Hy9SIqrOoXbJMm/0F1/NLIPH9tzYuAMbesyKhi1RejKhMHnAFyndKW1hNHiQLC58p0AOzbjWiZKCwTFzsmPRkUars5h3RfNNat2jVfr/IXtsIRAP/vxO1E//TpV6MOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8PBJI2trWaQCEAlkKG9hKZIPjEH4t272inKcTOCI0o=;
 b=T5Di94axYsqShJit50/ffBIm7UbYZmeR24EcyZQ3Nt39SqPVkKxjTNanHRjFVQVHc4jckFY5ZCdhuZYC02/88t3avJ3U0nT89BH8z6UcjEl02PZYkHRKetmNffbfLfem9CshbM0CGDfLCMiq8I3jLixU6C+OLMJfC76g02UtC24=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4691.eurprd08.prod.outlook.com (10.255.98.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 10:30:08 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 10:30:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 6/6] iotests: Test committing to short backing file
Thread-Topic: [PATCH v2 6/6] iotests: Test committing to short backing file
Thread-Index: AQHVn9KxRltA7uNPbUqM02ssz4EKHKeVn5cA///ODAA=
Date: Thu, 21 Nov 2019 10:30:08 +0000
Message-ID: <f502ca13-0840-cb06-150a-cbf605a6c1ff@virtuozzo.com>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-7-kwolf@redhat.com>
 <832ab7bc-07a2-bbe0-a567-71d416f8c1d3@virtuozzo.com>
In-Reply-To: <832ab7bc-07a2-bbe0-a567-71d416f8c1d3@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0054.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::25) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191121133006716
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f462b42e-2958-481d-462b-08d76e6dc7fb
x-ms-traffictypediagnostic: AM6PR08MB4691:
x-microsoft-antispam-prvs: <AM6PR08MB4691A3EF2E41B896435EDA75C14E0@AM6PR08MB4691.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39830400003)(199004)(189003)(11346002)(4744005)(2616005)(71200400001)(26005)(6506007)(76176011)(71190400001)(5660300002)(25786009)(186003)(4326008)(386003)(102836004)(52116002)(6512007)(66066001)(6246003)(8936002)(446003)(256004)(14444005)(66446008)(66946007)(31686004)(86362001)(3846002)(66476007)(6116002)(2906002)(7736002)(81156014)(478600001)(6486002)(31696002)(305945005)(81166006)(6436002)(54906003)(229853002)(110136005)(8676002)(2501003)(99286004)(316002)(64756008)(36756003)(14454004)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4691;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e43LLsS1upnjsBa9Wt+mmbn/ZWKgFpDgy8gN70jb7uiUvfW+mtb/lSzDLBL6U4r3UUXNsVrJW14tveduHABZAou7qTSpnK2fqV1LwWdZoGM2BcSrJmwcPesq2hMtQ2hkSBx6AC7gmUJKZ100uRGRBQittwZp7je6u+SWRrt/sChz/T8xmZvFgUWAFHSXtP3j29YNOHzjRIpISlurKkcJzjK2skfTxO/iHyZyk3zw+6uQk692/HCbeBCr8vg/L2FxhsWlpX6L3aPGJs6TUaPsilH/6q6GFv20FESYkETjlRksc10LvKF7IH39hDKYdjre2kmBzi3a25L7Ft/cwr6HYIj3Ef4nKIqkCp130zf7jS9u0d3vTYXygfklaqXpW/iwNl1S/CP+nr+XeewC20us3OVO6d8HtIZ9LLCTRwxOrhUZ7nVGpvm2+lERgO0n/fuE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E97E1336C3D99C4EB54A1B1B0D10C613@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f462b42e-2958-481d-462b-08d76e6dc7fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 10:30:08.3377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t39DBDk/G2HxiVO+f7+aHCv7AXzjv1Hfv8tn90evAzIac5h8tZmuMp7WJU7LLgDYmy9d5zMtWBs2bgsyUeGkuaO8NEAyoOX9rKC8sXckLuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4691
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.103
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

21.11.2019 13:28, Vladimir Sementsov-Ogievskiy wrote:
> 20.11.2019 21:45, Kevin Wolf wrote:
>> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
>=20
> Hmm, allocating 7G will break tests on small disks, for example,
> on my 2G tmpfs.
>=20
> So, we probably should
> detect "+qemu-img: Failed to resize underlying file: Could not write zero=
s for preallocation: No space left on device"
> errors and skip test. (better skip testcases, but it's not possible for t=
ext-comparing tests :(
>=20
>=20

Or could you just use smaller disks for resize? What is the purpose of such=
 a big size?

--=20
Best regards,
Vladimir

