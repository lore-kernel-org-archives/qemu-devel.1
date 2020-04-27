Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE59C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DB420656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sWmWSgiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DB420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4yp-0006lM-K0
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v4-00089G-7j
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v2-0007jP-By
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:37 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:24288 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4v0-0007iF-1Y; Mon, 27 Apr 2020 10:39:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVjOresH1nByt0ZjbEjd3eeaRKFMc9+pSm3aAPkXtlSCSdTY/twe59aGJBmh1B86jBoajoYON4aP8geYLuNqcPC1gJY9LDohHv6MVRlIjtGBjwk0cvALFcFnkKzF3En1JaZbT7/iRmI8zdocWYpjPkPQfQJaXJunU3S2BPTTbLrS06YBWqiQs3feR32kabZ7PN68ZnN+UNyHO5B1AETEvTA3Ob6rRNHd0xVYOjENtrBPv1G0tQjfOWdUAucXrkskHZ/4YSvyNdvsSD0rqQc9lVOgzgWfJXtIFdB2N6Hrjq7/Dc2Z3TQc3+UZ0ZxPF3Ep5IZcJt7LEvHqYEPabK+goA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B+s2HYvJ2kuiftw/j118dSIIl0vtnCFLm2+n0rT3Bc=;
 b=KMVWyvMWImHJWbSELd4qKwY/dOohg7m+ZkL3756EA3cD+mBRWnDUNDKKRCSpPFZlbjq49/d876wJGlajKyNXCPqP6TnyZ92/wVR00n3Jl+PfHLG1VqeLZA6y7eLqUfHd4xZguf5R2JYNxCDgKJJWnIn8ogEyyqEOYjf85cPBOyYhkol5rAKKNv50CBmVY4dfU+AzrcQoRikloPFQ6NHxSmymNX3ecNt8BfwwDJFy3EFQMrYlQyPu4KvO0wVmjt6wCFwVIz72B7dlGRbwWctRBnPgPKpqppaDACgsTrx1bqIneeAI6LqIoeDQKuw9yZftCAOMVGifzB6fFGiuNLcMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B+s2HYvJ2kuiftw/j118dSIIl0vtnCFLm2+n0rT3Bc=;
 b=sWmWSgiF/hA/8rFdpXdp6RyBE6cbHy9ibKT1mnC8tnCTRqdh58sbvR73zAR+tvPE15fN9FQMkan7xuanCRX+0FNBI6vjv5g3ieegaxDQ7U4Od5Gh3uRtuWoHXCfwrs7ZJfvsSHPF0m6E+pjlXeZsmHaqlwuCZMlcsSNFlbsS3Ng=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:39:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:39:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/9] block/io: safer inc/dec in_flight sections
Date: Mon, 27 Apr 2020 17:38:58 +0300
Message-Id: <20200427143907.5710-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:39:30 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9a3d6fd-cafb-435a-4269-08d7eab8cb83
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5527AB8F83B0F3FEDB4A782AC1AF0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(396003)(366004)(136003)(346002)(5660300002)(107886003)(316002)(2906002)(6512007)(478600001)(6486002)(66946007)(66476007)(66556008)(69590400007)(1076003)(2616005)(956004)(81156014)(16526019)(86362001)(6506007)(52116002)(186003)(36756003)(8676002)(8936002)(6666004)(26005)(6916009)(4326008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVMAC8lDkFXEF1Tkx6G2RgMNYYs0HZ+76ZH7lG/4saDKDegDuqwRugRG+ndZfreFlzRA0yJDEqjoeFvcGpZDD2SXYZ3HL1lv5TL7i908S8i/T2vV0+YSxRr5oQGJ8ZLNWYWPCL3+9v/iGmXtktQX9KLVMEaNUWvsOX26y/zK5ShMOy2RnKhFGA/4XwdvdH2OrXl/5a9+vk4ijXQ29CruA4wl6Nx79mkYrl79j5jRZV1YBwsN/aNUxdF/JhOlMm6daJ+63GlEWZe/ApKMLmpNDbc9H5C9ZqfQw1QCwB7wPhYGvFBMtre56N0StkX2O5g15vWwgx5Fl5IeA2FjBUdGisAkVWn1bsiGe72J0A8x3wFkzO+woSZaEleDJqaNLdx/UiOOI7JbJOcco6WRB7PZ2NYkvGJcAUwYfhE73pL9EgRx/7+3RUCdhqve1xJpWb4N/RpTpYt2MqT5Yfen5QpJeLV1ifD8iInsM/XVaGj6/LD2ITgv48N0u0YDTq7vDvSE
X-MS-Exchange-AntiSpam-MessageData: HVQF799ev/8gbrc+ugJIAuPWsiSRwOgTnWl2xdOC9EiU7DHZLdIUIUyE7p9Q3gknWTaSnhmpdaC9otsdEZynPOmBTnTxtPnNihXGO3MskBuzNMhv/1scfC3ES8pqvMK31TQipdM6P9oGjKJkt2YDJ8LahGje3kTk0oLrjg9gVx60TjTv1vOlB20unlFYVDTU+sSES3tAxOYT4X7vT6AW0TAq8FeWggFUWfSdaS8e+b6+N6w6DiutLn1hJBWpKNF/BeGxN9PyD0mn73Yhqc8eho1ROjsSthcP0PjAaMSAJOatz+L1ixBkJVrY/eVMHhv2qof5ub8465NPlOT0EPOTRC9cO3ecwg+DUSrNYgl2aYCidYiW2vyQVwjKlbHYCIpdO1FMBfpw/Cp1YA76fMRNjGTNQbNOaeKTe2eBNrpXoPhkShqPYC51jPFvktlcToGW5c2uKVT16zJYGpMnjxmYpeUjhQNrbA6X5KXl6O9UZe4ovRNO9aMRqnpgZsA/SafJ8zuoYGahW18h/CQE4ATJW1tWc3Bl3XqFVnhEUG1Eezqt7aqZ+zp0YaV/iRh76ES8TEgvg5VWECvhZcAddX3wngRum/m8hNVP85UyyonVL87ngYdk9qRSD/lGgNqpZCSPi629cr5jJxT+BASbtVnWjFPYT9kcizY9WhqYMSJG4+1WjdrkRzfC19fdIEoGgPM0eyk6jul7w2YUaeeBIkyditgY752PcpmQYSwFhaUSKY/rY5lWPtAFdhdbSeRHCgC5hDyQeaDhzZ3+IhWJLt2/WRXuqzZlwLqLfhYK+1jbkWA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a3d6fd-cafb-435a-4269-08d7eab8cb83
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:39:30.7156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5enwV2oY5EyJ6W0CfPoDn5rLDy8j71KRJULjBNhRH14Xjuh5W5k41J79Vw6vjZidZUmiGDw3KpEWcGg9u4ASZRkLUxvZotEQVwdlXy8dj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:39:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.133
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

v2:
01: drop coroutine_fn from bdrv_is_allocated_above declaration
02-04: add Stefan's r-b
05: improve commit message
    fix typo in bdrv_do_pdiscard name
    add more "To be called between exactly one pair of bdrv_inc/dec_in_flight()" comments
    drop unused bs variable
    fix bdrv_pdiscard_co_entry to use bdrv_do_pdiscard
06: similarly to 05, add additional comment to bdrv_is_allocated_above_co_entry
07-08: add Stefan's r-b
09: add "To be called between exactly one pair of bdrv_inc/dec_in_flight()" for bdrv_make_zero_co_entry

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

 block/io.c | 789 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 525 insertions(+), 264 deletions(-)

-- 
2.21.0


