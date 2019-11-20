Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA10C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A776D20714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EmtVKYLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A776D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSMX-0008LS-Hm
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXSEO-00038G-Dm
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXSEN-0002AS-42
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:49:24 -0500
Received: from mail-am5eur02on0716.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::716]:53159
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXSEM-0002AI-DJ; Wed, 20 Nov 2019 10:49:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOeEBp02T7QQqwZcpQpnO+8R8TnGN83tZeI28zjBjWC8YcoGMhX1xRPxbSsBsKbN5HJKE7HSxv9zOJ7qvhz3EBciaj6kbq03KCN1iGWiUblv9TqPJNiCPGkJJ0UqGqN+qLb4XBUKpouNcmVlpBQQyGKzMXemYpEZYLQLoFTz1jHvakVizKs3cM5ci38UPRq5I4Wog6d9nm1cAeRNDmUS2SN2da+MCbISQ7UevLSrxN5vQuqqnH/S/0BlK8hqWFRatcbKEMI5noQ2G7LxAvZ9eYJbym/UC/z9znXBaRgqhvfbJKxT6uNz8cgh/8SoySG9WDXHYTRYvbbzBPm7yCrhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FewzLXCq5H9cLmKnv2ARiXhRTBG+17HetSyAynqR5uE=;
 b=hIIXbsG38HVha6gbiFM10pPKJs5zfrejWP2Fzd5KNZbczti5Gw1BxrqiLnK3t6usr+dD9so6JbVA8ByzLaCYGAMgEh8KRYELry9gWaBRgW0m5DdU+ygYKNWzd4JTpfrrKJ6GUttdoKPZIygXMdWiE33PQrvIPD+iSuxQQ+xyGO1FbWQEL8TZwuGYZV2mWgvqAOe1yitC4DuK9xAmenaKA8pRYsmnyp1RQB7PnZuggE06J/JO12cCeOJsaxXpJ3Pjp6fStHMgDTHvEZZYMynt7fDCBmHIs+/RRQLH8o9xLLCjjR7K2qCa0Lvn7jCficUkuGOpHLkvtwPrN1It17lfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FewzLXCq5H9cLmKnv2ARiXhRTBG+17HetSyAynqR5uE=;
 b=EmtVKYLk5/yaqNMkrd6MXzyHmGl9tzumA54TQz/PQ+YAqhrGv6ScEjTQQGZlyiC6+HGOEwqyn63BIR3oV0kWcfzqf7aCVqqpowGgYYMWdN3F/XWxHawnq464b8ohthNaJ24h7XIoxjhNh7qdy7IT+aaE2lMQGytGFqTxnVJsguk=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3398.eurprd08.prod.outlook.com (20.177.115.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 15:49:19 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 15:49:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-4.2? 0/6] block: Fix resize (extending) of short
 overlays
Thread-Topic: [PATCH for-4.2? 0/6] block: Fix resize (extending) of short
 overlays
Thread-Index: AQHVn6tV94AsXTPMCkWMUmvbsutwsKeUNMqA
Date: Wed, 20 Nov 2019 15:49:19 +0000
Message-ID: <404fa5f5-0b5a-8a62-78bb-8ba414ab3973@virtuozzo.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-1-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::14) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120184917574
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb5d0471-73ca-4566-5ecc-08d76dd134ac
x-ms-traffictypediagnostic: AM6PR08MB3398:
x-microsoft-antispam-prvs: <AM6PR08MB3398AE89016BA180275B6D9FC14F0@AM6PR08MB3398.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(346002)(366004)(136003)(376002)(199004)(189003)(256004)(6512007)(7736002)(478600001)(316002)(86362001)(8936002)(52116002)(2906002)(229853002)(6486002)(3846002)(6116002)(102836004)(386003)(6506007)(186003)(476003)(26005)(486006)(71190400001)(71200400001)(76176011)(2616005)(446003)(11346002)(36756003)(66066001)(4326008)(31686004)(110136005)(54906003)(31696002)(81166006)(66946007)(6436002)(14454004)(6246003)(5660300002)(25786009)(305945005)(64756008)(66446008)(66556008)(99286004)(2501003)(66476007)(81156014)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3398;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPzyuOBvW0so1NOicFXcyxs5+FB9y/d40mZ8zyuhnS0slBukFP9SZFY2gKiPeTJi4kZtTpFu5mX5Gn4+LtiqgfqNjMC319/PA46soHGtN/PInxprxVbTMjcWY34KoJT1lX0OTZUOgKxsnm9gk0anXrV46BFw6RCo9KRn7ND070mmWP4QlXE2Rba0lRM8WPx4W10BRP4iqUYnUdCamegSMKYW5aGylmf4aTft9xf8XcN23YlRxwVwpPSROdrKzCIpo29tH44hW9WMsP1vVmx5wFtrtgFgI+dODZ/9BKBbmOUiwevz2I9G1VOM4mDUS1I9gz3ZWNbMl+Uv3YJBleyG9sAa17ljqKVOOjTO+MR9PkN70iwvxXZWBlzFZPburj+cADedDN6Eu3NwnQnyzhseaCleH7LsiyEQKq+oOhpeYfM3b2uuDlTKvxrRo0LGtUze
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <95ED1A28CFE8374288155F7EF15D9E3F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5d0471-73ca-4566-5ecc-08d76dd134ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 15:49:19.7977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEmBzSdjFQuvejVcsPYX1HCbLWokyO/+BtBwjZcDqKuOrPb9TRwiA3DzkpG7eSgDFlNgSgmZLkD1bewo82t4GvLGk3RyQ9RXIb4nd8t4dGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3398
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::716
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
> Consider the following scenario where the overlay is shorter than its
> backing file:
>=20
>      base.qcow2:     AAAAAAAA
>      overlay.qcow2:  BBBB
>=20
> When resizing (extending) overlay.qcow2, the new blocks should not stay
> unallocated and make the additional As from base.qcow2 visible like
> before this series, but zeros should be read.
>=20
> A similar case happens with the various variants of a commit job when an
> intermediate file is short (- for unallocated):
>=20
>      base.qcow2:     A-A-AAAA
>      mid.qcow2:      BB-B
>      top.qcow2:      C--C--C-
>=20
> After commit top.qcow2 to mid.qcow2, the following happens:
>=20
>      mid.qcow2:      CB-C00C0 (correct result)
>      mid.qcow2:      CB-C--C- (before this fix)
>=20
> Without the fix, blocks that previously read as zeros on top.qcow2
> suddenly turn into A.

Note, that committing to base should still be broken after these series,
and is fixed in my "[PATCH 0/4] fix & merge block_status_above and is_alloc=
ated_above".

I think, I'll post a 5/4 patch, to add this case to your new test.

>=20
> Kevin Wolf (6):
>    block: bdrv_co_do_pwrite_zeroes: 64 bit 'bytes' parameter
>    block: truncate: Don't make backing file data visible
>    iotests: Add qemu_io_log()
>    iotests: Fix timeout in run_job()
>    iotests: Support job-complete in run_job()
>    iotests: Test committing to short backing file
>=20
>   block/io.c                    |  31 ++++++-
>   tests/qemu-iotests/274        | 131 +++++++++++++++++++++++++++++
>   tests/qemu-iotests/274.out    | 150 ++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group      |   1 +
>   tests/qemu-iotests/iotests.py |  11 ++-
>   5 files changed, 319 insertions(+), 5 deletions(-)
>   create mode 100755 tests/qemu-iotests/274
>   create mode 100644 tests/qemu-iotests/274.out
>=20


--=20
Best regards,
Vladimir

