Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7BBC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F53B2051A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jGWwWlNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F53B2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM78b-000437-EM
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73G-0007kD-E5
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73E-0005xA-Ox
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:18 -0400
Received: from mail-ve1eur01on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::705]:64128
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jM738-0005tu-VX; Wed, 08 Apr 2020 05:31:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aj/LKvQ1bydCMKYy93NEermDAagElxw+gNLP34td6BccHvCM0VWzSOYTSjP5wxLQXsIySO1jQOvk3OHgyFYp7wNjqkdlivDZK60GmNxmTER9pDXjKlS2AH/sWdzb1qEKYUykhEIBXyx7W/mziel8PPUjh9S4t+GWNiiBSULH6dYi/cfOLFEt2Jd4wiPxU+Uayxj9JRxJHTNXY2qvZOq0D8x0Flg/4AnYvtz/Q+uHhgGj9Io0IGGwsqZccXTt9cGAw/GyauBLK2l5ZIJtOESulMuUQGq4xVT0GaV6dtwIVfKhVQyE9aX046AAiB/z62Dmn93YfKulCDE/MftXrSlj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a660XIwgSsX4kDUlTvtZircu8JIdnsB8mMoFok6TuHo=;
 b=gkskBgxsm81lNkpdGkHdpjRbdppAA179n1EEs5lDxqLo2ocqqnkQ1u8xW0CQY2m0CWdvc5VgrPekyNM5pru6FEECJjEuNQxHmgj+mzjrYtL9vHwWCTTRNOBLHJyYhtpfTYbXxOZOpJ7Ck7sxLFChqL7z9y/HpkU04d9/ZD8WtVWzZQggEIWdRMbi6a5KSm1ASAeypEZT2b/Yc5zdO5oLZya0pBI/3/+N0AJy4eDw3bVZo1/T79pDl12xC12uAOZBWl6ooHSvlUHq760rO/T9kGVFWxe0OEb18L6+kMu+q+ENCOJhKyWpXFC4fBENl23BTJ0ZuS1i2JiSaTVQJEMYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a660XIwgSsX4kDUlTvtZircu8JIdnsB8mMoFok6TuHo=;
 b=jGWwWlNCuNj4zUPbZQO0Zm4h4IDA3FP8ejwNbj8z3c0MFWOHep5Wc9JBXEOBJDaTwuL3jFB5EHO3cNX/5z+iAKeV9zJ36UkDUxGun70kSRfrS+sjLMEO1NdixwpoYXhhqhkt3NVAQfM3ue2r+itur0iK9JbSGyWWH7rgQEyleGs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5365.eurprd08.prod.outlook.com (10.141.173.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 09:31:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 09:31:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0? 0/9] block/io: safer inc/dec in_flight sections
Date: Wed,  8 Apr 2020 12:30:42 +0300
Message-ID: <20200408093051.9893-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6PR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.139) by
 AM6PR01CA0041.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Wed, 8 Apr 2020 09:31:06 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f30d63ac-ea32-4b1b-5301-08d7db9f9071
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53659D4D7117540968614AE2C1C00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(346002)(136003)(39840400004)(366004)(376002)(52116002)(6506007)(5660300002)(2906002)(6916009)(2616005)(956004)(4744005)(478600001)(16526019)(186003)(26005)(86362001)(66946007)(66556008)(66476007)(1076003)(6512007)(6486002)(107886003)(4326008)(6666004)(36756003)(8676002)(316002)(8936002)(81156014)(81166007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7jJiI4D9HVViMuI0QRgi1thW1cvX7aQvNLTXLejHt+MN3PDuzsQ16ooq09Ez5mfTrQTWSKdyGJHYKd9z5JOMZxf051votvbow3zjmg0aKK7UKwvsqmO4rT0LK6VOxrTEbgXjSC3w0iiONG0L4/gFia7UjbKeLNdjD/XLP25jj3YUiMaj1FlWavPV00sba/lstF49P328Pz26S83khA/2KJtql9pmIF1RIzZ6PAZyKjrqQ4bEUWU2rQiy9x9iT8q8rE8+AYQHDvWQMi8pX5AQLYEV7sLUU96Gdq0zVm+4jdWuI81GcJuwF7sINHtSmigcvOZSEPECappMloxmQ59sHUBL4NzCBKi55Do7feKzcaBiqwlJlhD8XwXsX0Aq7URXAsKaxuecybitFsYfG5YFlCVVPz6RdnEvXb5hNCf8mC1ZQOIebCE05G4vDMdy3nf
X-MS-Exchange-AntiSpam-MessageData: uLe8y3QAJgDhmhqTVtqZ5ZEXCDkMLhMRahS3Qz/6E1C090sbV762I6FDuTb19qDIOucACrFRvkQFnRvSPQAsRK4+rrFKo0ixbvev0kRjKLp/YUezKPRJyHLMjgtKfCtRFI9EZTYH20ruTrIT6/vHUQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30d63ac-ea32-4b1b-5301-08d7db9f9071
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:31:06.8242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cExyYdfPoPkomgiuVYoUcNZEkqEjpS27boxnyV+++DlCNuVtOGGlafPFdD0qavXsghX4BarJ7Qi6oFvJBhwoI6gCSwMbP1lbpN4lwMilL6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5365
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe1f::705
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

This is inspired by Kevin's
"block: Fix blk->in_flight during blk_wait_while_drained()" series.

So, like it's now done for block-backends, let's expand
in_flight-protected sections for bdrv_ interfaces, including
coroutine_enter and BDRV_POLL_WHILE loop into these sections.

Vladimir Sementsov-Ogievskiy (9):
  block/io: refactor bdrv_is_allocated_above to run only one coroutine
  block/io: refactor bdrv_co_ioctl: move aio stuff to corresponding
    block
  block/io: move flush and pdiscard stuff down
  block/io: move bdrv_rw_co_entry and friends down
  block/io: expand in_flight inc/dec section: simple cases
  block/io: expand in_flight inc/dec section: block-status
  block/io: add bdrv_do_pwrite_zeroes
  block/io: move bdrv_make_zero under block-status
  block/io: expand in_flight inc/dec section: bdrv_make_zero

 block/io.c | 780 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 516 insertions(+), 264 deletions(-)

--=20
2.21.0


