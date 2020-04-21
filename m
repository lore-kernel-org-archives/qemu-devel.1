Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD1BC54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B892076A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xn6RzJqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B892076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsi6-0006bE-J3
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQsh8-0005fV-Sl
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQsh7-0000f8-8m
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:12:09 -0400
Received: from mail-eopbgr60122.outbound.protection.outlook.com
 ([40.107.6.122]:32578 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQsh6-0000eA-Fx; Tue, 21 Apr 2020 09:12:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNlCiObzRUZRHlw/kBEyE7fMEWki2+7Sh0AlLBv9R/cwL2r4ts0pZ5ZFVAefnFMb6InXzdICOeXes/HD6tAbPExr2TcTRpw8UegRNO0xImYwMQEm4UFYIAxokykzA05ob639SaRRL3ESEvEpf0XW9VcJ+3cn73KQIkbIzn3/sqrwyo7Y/7KUrbVrwfW9SXOjRCbJnS99mDTQZTYmGoCcqmVxe4rCpk61PDfVFi0V4XW+/caw5VQccgr9OpgyWEmZdDKec/xYnv0fcD2PnRv6V882VexxerRAyT5Nfq4DJHqLZ/v/UIoUhAJPdjFTWRY2XD5reKt9k8UueKJvw23RSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPtJ/uM7J1EG9YhfPlhoCyn/qgNBjgg8asKcDxOqYxk=;
 b=EWTrh+Rdu71wmZmo3l4+IAZJOS/fy6ZtfAZ4fSqEf08jeW4A68rtctL2KBbTplcuTTeNHcINl30a6OLT7JrmVt/OneHxQ9ilNqIlAi8q0vmfTYbAERxkjqu/ksfWAERSUE9yp+OKh8NPZknnqf2FiOuwuEqbFmEBJhSQKqVGNTt/XalHKKsmUsbqwArCZxZFuS3O79WO6z0Ubnx1rkBjRWrC9VyuCNPXQ41QQ8CG23ezHHEOWqUMFaRVdNk2jTF/2lPNhjrL2o25+dBQzVoVNfQop7w5PSjFNaw1xbJ7qRnGLwHfkOHZcgJOYGVlg0ro0Q/f1EW1nLnU4sN3fjhWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPtJ/uM7J1EG9YhfPlhoCyn/qgNBjgg8asKcDxOqYxk=;
 b=Xn6RzJqU561NdLVFuV8EWF9hKAVL2kfn1OD2yhNi1n74G3UR2W3lw11ZLVy4cu4xQd0lM4Iw6709lcs7TvBPUu8ChE1TS/c+0/xuqyidvWrHQdz3c7sHigMW2JbhdMHXIIbQGDoOuOWvZ7r69eEu6Dp2CWWLJEF0fTUCuuwN0mc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Tue, 21 Apr
 2020 13:12:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 13:12:05 +0000
Subject: Re: [PATCH 0/7] Apply COR-filter to the block-stream permanently
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421161203483
Message-ID: <f91a8d20-b60b-7fe9-443a-875b6232af46@virtuozzo.com>
Date: Tue, 21 Apr 2020 16:12:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Tue, 21 Apr 2020 13:12:04 +0000
X-Tagtoolbar-Keys: D20200421161203483
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a69148f5-ce2b-45e3-a57a-08d7e5f596c4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495102A4EEA5AEA15E5A870C1D50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39850400004)(396003)(376002)(346002)(136003)(366004)(31686004)(966005)(5660300002)(26005)(52116002)(8936002)(66556008)(81156014)(8676002)(16576012)(86362001)(66476007)(16526019)(31696002)(66946007)(478600001)(186003)(316002)(6486002)(4326008)(107886003)(2616005)(2906002)(956004)(36756003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXW9mlprWPDQwVCs8SibQPHy6D100OQ1IxnXDHKjgn0N1Isymh6d5SqM/LClcjsb+diS8dRuOLy6Z3KtSLOPou59w+TJZV2/T6ubhkU22BRfofdUErKs3X9os6CxxeVGTzWfeE+G1emrJ25OtRt2UiEvdYA6amlOgPvAgx/XlWunPyXdvGSBXHUYg4hR+kVtrXmjSEPTDchSypc1/HljCpjvoSu13KQf8AmKWCktEbD0FyzwvAy2c6p748xTLuoNTrDiuxiloT7olvMCRDcn0OJxWb3rZO0L+tOpSMXgIuEmjjCPRbZLFeSBVyldRADzruAIPt43L8u2lzcv2HmaYgMzbsirMin8Gg5duT8jnLyQGMTxjNy9ngQcddkNCZZgi8/lnPPjRK198qoTaIr/liDh+xliTNmvRhCSuBqE9cV8x9x2+lkowQwW9/5DzmR/KQYIS3iNEOA2J8VWYVcG/USB6T4Tll483BzlLd4eyKf1wIyTGkuR34pgKjIlZ+3Z
X-MS-Exchange-AntiSpam-MessageData: 6NkOthY8XuiaTVoscX+G1xZWMwHCAHKhUcnnYnveN/H08FRY7zRjw6WdoUJw5/A6cb59pyDQth+alF9ISBoV8PRwKV+K+MA0PHuJZUvKa1U8Z0OO7X4W8VIIP2cliKcvk973IGacLBuT0RRGsiHYAQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69148f5-ce2b-45e3-a57a-08d7e5f596c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 13:12:05.7244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0IKajJrGcJYeDUohOVodYrOiqrsmZJgc/DheguMErDOZ/E1mepEIGvkAVjb2L8Znl+1lXe1Y67YIruh5tZnimoLekYQDEtLorsy9/wIG7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.6.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 09:12:06
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.122
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 21:36, Andrey Shinkevich wrote:
> Note: this series is based on the one "block: Deal with filters"
>        by Max Reitz that can be found in the branches:
> 
>        https://git.xanclic.moe/XanClic/qemu child-access-functions-v6
>        https://github.com/XanClic/qemu child-access-functions-v6

Would be very good to not make a dependency and keep the series parallel. I believe, that we can proceed with this series taking a small subset of Max's series.

> 
>        When running iotests, apply "char-socket: Fix race condition"
>        to avoid sporadic segmentation faults.
> 
> With this series, all the block-stream COR operations pass through
> the COR-filter.
> 
> Andrey Shinkevich (7):
>    block: prepare block-stream for using COR-filter
>    stream: exclude a link to filter from freezing
>    block: protect parallel jobs from overlapping
>    copy-on-read: Support refreshing filename
>    qapi: add filter-node-name to block-stream
>    iotests: prepare 245 for using filter in block-stream
>    block: apply COR-filter to block-stream jobs
> 
>   block/copy-on-read.c       |   7 ++
>   block/stream.c             | 170 +++++++++++++++++++++++++++++++++++++++------
>   blockdev.c                 |  15 +++-
>   blockjob.c                 |  15 +++-
>   include/block/block_int.h  |   7 +-
>   monitor/hmp-cmds.c         |   4 +-
>   qapi/block-core.json       |   6 ++
>   tests/qemu-iotests/030     |   6 +-
>   tests/qemu-iotests/141.out |   2 +-
>   tests/qemu-iotests/245     |  15 ++--
>   10 files changed, 210 insertions(+), 37 deletions(-)
> 


-- 
Best regards,
Vladimir

