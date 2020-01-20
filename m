Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F2CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EC221835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D/AgoYGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EC221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itasV-00067L-L0
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itaqq-00058c-UM
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itaqp-00049L-GJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:28:36 -0500
Received: from mail-vi1eur04on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::714]:58754
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itaqp-00048Y-8W; Mon, 20 Jan 2020 12:28:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwVOiwlg8RV4mEEUekFaBJUeOsRgk4zQEikNtGXWwbvvkN0AQR2J1KWNoI/ZTL67FKjEJRztFXDUYVa4sDBdGqoehTJg1hf5uQ/jeDuILrXuPRiOCKjuKbMS1ll6+wg/XrNUGWILDLG9Qrq7FhRbODu0vNc2TTTdula1ERgG1wobYOxDBJEt4lGsf7r7QTDC6J5xcL70fbbl6U5Wr8t32Qw2guDnT4EzK0oz3dwZekfEEqK4gHUXvOSWS9PIfspSChX0PDGQO5iZ2Z+71Th9UUy7pVVB5WqokmePo2nYWC00eG5kNNC8DkpgJj6uwjK/yMh9KUWr4GaNEYFJ03x2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiX/A4Yjl7XbfMHEOwAhuZpxtU+3HMdy09U/X6tWZ5E=;
 b=kkGayAESJ3Y2UGPhY93v/GCtAud0MRUDfELkZLyAL3fpVNsTykTIVKVhzf0FlCSKz66BEFYmvPFyF2RPy1asefIbCLO1T1XVvQzX9HknkotlLzPFsEx5e4LUMDEcq6XmfH8m5Ql3iCxgXHJY1nbh4cSnVSJtxnBENbopHQojfjKTT6u5shargzqtbL1pfGTkcuAlcCac6ZJy+SWz4+HpY+LQw+89p98hWWyXpJcCHlljzK0F8Ch9i0FRjWxXvrb2TulA98IN7dOwjYntdvF7cMn+7yFc0Vp2ODxnuWIN/pz2ih5SQ9J84FPGg5Xa/Owrfq1DZPfac2Y8f9WexHyylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiX/A4Yjl7XbfMHEOwAhuZpxtU+3HMdy09U/X6tWZ5E=;
 b=D/AgoYGWy4KOlOyBOlrZFr27rY24kvSMPn36qK+WUlXn2Cm3BtcRtSHfogic2GzvozBNHx9mHC00pnblXOmtcqoiBiudM8AcJdV/F1BprJdQWYGcZi/m3vjTAmRpm5bhh0+NC/TDEHuvt6lo7+RG202QFHgiMJvueCOdHw/eL3w=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3191.eurprd08.prod.outlook.com (52.135.161.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 17:28:32 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 17:28:32 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Mon, 20 Jan 2020 17:28:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 04/10] hbitmap: drop meta bitmaps as they are unused
Thread-Topic: [PATCH v3 04/10] hbitmap: drop meta bitmaps as they are unused
Thread-Index: AQHVtlOfjJFz1HLGS0Gzm2LfZzDgPKfzmLyAgACH1YD//9p+AIAABloA
Date: Mon, 20 Jan 2020 17:28:32 +0000
Message-ID: <3b4f3ef4-adc7-1fda-44cc-b16b497cb110@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-5-vsementsov@virtuozzo.com>
 <a42037d5-0d62-d916-a814-ba755b6ad9a4@redhat.com>
 <e6d654fb-7c04-c709-6b2a-3801ae1008d6@virtuozzo.com>
 <0cf94b1f-e7cb-081a-34ab-63a7d9ba80ce@redhat.com>
In-Reply-To: <0cf94b1f-e7cb-081a-34ab-63a7d9ba80ce@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120202830896
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a4a471d-98b9-4f21-7985-08d79dce2c36
x-ms-traffictypediagnostic: AM6PR08MB3191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3191A3AB2572E7AAAA8C2EF4C1320@AM6PR08MB3191.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39840400004)(136003)(366004)(396003)(199004)(189003)(66446008)(64756008)(66556008)(66476007)(6486002)(66946007)(5660300002)(110136005)(54906003)(16576012)(53546011)(31686004)(478600001)(86362001)(16526019)(52116002)(186003)(26005)(107886003)(31696002)(71200400001)(4326008)(316002)(956004)(2616005)(36756003)(81156014)(2906002)(8936002)(8676002)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3191;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84uN7yclM3zMeN+dbZ4YKXnAnTcf3i8lJ3NRf1MWW9B+819bPPd5ZEAjoDpGQXnjuL5I1q4+mmLeUe4o7ZePlkdPy3bNzysK1UOTyQZXnD1LjPyRnHmHoAxZOSNzpNFjDyYFKghAcx70igNf0Uz7ummKfdq95iHUaS7y32AKLG4JCrD5Kol5mvbgg6UUVTJa24VsmKyvrKmPwQTO7k+XW7qJjAfmVHwQnnYwv+X2y79TeIC9pdpwSCtqdVd9AZBoeokOfswVr2TMZIq9Wm95GslaHZkc6YPYpvTuQR65emWFyZ00PtueJUzUTlZ5FxGpuJVY3JE3T4i0EPjEv0arAF8m2+1SnaXJl42EewH2EqROpngX2vl/27Eh6Tm8W5egPyfQqAQVreqyzyWtlQ8E7ChyQHxEdKJWSoBwGI7sS8kAYftAA3VNJub/vJCaGyHi
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <CF0C020ABA0EE745B0000BC148342148@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4a471d-98b9-4f21-7985-08d79dce2c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 17:28:32.7855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PykxfV0na/VnuQ3LaO1Hf6ukvsDfgNtM4j2ZPyo7CgLxpazOkaHhGeIt1Is/dTCaLRh6jqqBcf0APYXxlTAZHx3pMuQqVsldqGE6Rh1m8dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3191
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::714
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.01.2020 20:05, Max Reitz wrote:
> On 20.01.20 17:20, Vladimir Sementsov-Ogievskiy wrote:
>> 20.01.2020 14:13, Max Reitz wrote:
>>> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    include/qemu/hbitmap.h |  21 --------
>>>>    tests/test-hbitmap.c   | 115 --------------------------------------=
---
>>>>    util/hbitmap.c         |  16 ------
>>>>    3 files changed, 152 deletions(-)
>>>
>>> Er, hrm, well.
>>>
>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>
>>> git log me the only commits that touched anything to the regard of
>>> '*create_meta*' were the ones that introduced it and your commit that
>>> dropped it.
>>>
>>> Soo, er, well, okay.  Why did we introduce these again?  (I suppose I
>>> should know since they have my S-o-b on them.  But I actually don=92t.)
>>>
>>> Max
>>>
>>
>> I'm a bit not follow what you mean. I can just note, that dirty-bitmap.c
>> part of meta bitmaps was recently removed, and hbitmap.c part I forgot t=
o
>> remove...
>=20
> Yes, but who used that dirty-bitmap.c interface?  As far as I can tell,
> nobody.

Yes, as far as I know, nobody and never.

>=20
>> Meta bitmaps were intended to control live migration of bitmaps and to
>> implement something like partial sync of bitmaps (write to qcow2 only
>> changed part of bitmap), but migration implemented in other way
>> (postcopy) and the second thing was not implemented.
>=20
> OK.  I was wondering why they were implemented without ever having been
> used (as far as I can tell).
>=20

It was too optimistic preparatory series.

(I can never finally understand, series - who a they or what is it?
  Plural or singular? They were too optimistic series? Sounds weird..
  And if one series is series, than what about several serieses?
  OK, let's say, it was too optimistic preparatory patch set :)


--=20
Best regards,
Vladimir

