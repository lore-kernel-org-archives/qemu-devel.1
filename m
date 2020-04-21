Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604AAC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B662074B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fKORvXA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B662074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnbZ-0002Yh-BE
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnWL-0004JH-7P
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnWJ-0006iW-Sg
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:40:40 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:34373 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQnWJ-0006aV-E4; Tue, 21 Apr 2020 03:40:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpTLEUETIeWgchMpt1VysTqZdlbBl8hIaHn6kyvbI94xK1IIcV5kcvfjSnq4RnJxGnPcwbAgVOCo+3vZHOvfX45LyXvuRT7FmM6bvuL+nG7J7oFvRrn4SwKagV3fvxaQfQZjp489ER1shGJQgceaB/Aw1NDGIFZyS3o1ukO9BR5NWNIM2Qre3zrrh4aw0G5ho0VIQZmgA+bbHm7XywXVJlmk9PQ/8pv1KUpuA6krb+3IrydMTSnPLlZz13DBU6C3vixaBgK3uNtYkWOAOtHbOUedaRZORqKqpRm/YF8WeMTDCjWZC2CTlz438UztSPfkBYbWJwdQIlENNm+xjvBsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCA2Ykko1IQfvJu+Z0ri0ghZdTgPJW/emg0IvcrOL04=;
 b=KoBFaXeGtwLkYG1veYoMMTuS9MtoE05VZmJb6Mrtxa3cShrxxB4ixOpOSf5RRRdMLG4II8tHXywig9aQ1mF4CyomRNMrGCZrTbxA01GgBULiuwCYFhnc19yw5bFMgkwMyWyxIlqLAHA97Q7JxE5PfSXwv4ede3np7+vY30D3VfqnrO4SmiFp1Dehdqo7Xq5O7ezq6w/TAwmC3LvGhx7/U+U2Au5o5Lkz7yLABvgYnVhyCEWJqfQ7ItmVLOoT7i3sYLlSmm24NwYf52Mhc0pNy1IhM9S+pt6/efjNtOz2eJ5IzEO9GU4kjwW+WbjHqBzlhyVe0ScwzZwdGaV2ESP+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCA2Ykko1IQfvJu+Z0ri0ghZdTgPJW/emg0IvcrOL04=;
 b=fKORvXA+UbD61LE1TCnab1k8sxyLpPvZD1WjX/U9sno4Epa3hGtVs4nGnJFoHbSlAe/+hsqi4dKuPbLcduLyymfl889uI+hUrHkl8Lh6p0FC2ycb+ZhZCohz1wIMNlEBRfl2Eru+Y4auPKjFBKGLHK2uuvCqYUj3jdgGpvdmMLs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5351.eurprd08.prod.outlook.com (2603:10a6:20b:dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.28; Tue, 21 Apr
 2020 07:40:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:40:37 +0000
Subject: Re: [PATCH v3 09/10] iotests: rewrite check into python
To: qemu-block@nongnu.org
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-10-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421104026294
Message-ID: <817c0dd1-3e51-f1d3-f0d2-227d77c09f9d@virtuozzo.com>
Date: Tue, 21 Apr 2020 10:40:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200421073601.28710-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Tue, 21 Apr 2020 07:40:32 +0000
X-Tagtoolbar-Keys: D20200421104026294
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98ead604-5101-453f-f773-08d7e5c74852
X-MS-TrafficTypeDiagnostic: AM7PR08MB5351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5351F0C5255BAD34ED405435C1D50@AM7PR08MB5351.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39850400004)(376002)(396003)(346002)(366004)(136003)(66946007)(186003)(66556008)(2906002)(26005)(81156014)(36756003)(478600001)(16526019)(4326008)(6486002)(31686004)(66476007)(8936002)(316002)(16576012)(8676002)(6666004)(956004)(5660300002)(2616005)(6916009)(31696002)(86362001)(52116002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfpld2HCGWhjTsEwt8gsQ+aO3tc6/63rZKuneaDEuOlLpUtEUwk6WSwmeWdhF7rbQjJGYl3kW63sBjGlnROO9FnxzG6Oj4ThTmQ6eYBXeaofL8UFQSZ8GGSUdhxcYM8gakplG2RJFLhJ8KHjG4Ka4HOH74sH5FOANfnw3/NaQQIzl2PrOactiS+31OhiSFvDDYsAaO0zxT4c7uWC6AhebjCq3x0j2YfyXUu5NXNY7A5sM0l2t56jn46X7v6FcciEKcyEJot8i6BnQNxwCKUgSfpXVC4p19OefB5d+EDY6QcCxhSnSedoOW2eFCJ3JjM4a3cYTLHgY/OUplsOdQ1+zruihK5FSIOcxjyb40BRPSO5Wi4QFJ5SxxE6ZsgE5H3YX1S5HuNKZ7oucVm64zI4KQ755eeQtrNnRyU61EvF+12dk252aZJFl1dWdAEN+rLf
X-MS-Exchange-AntiSpam-MessageData: QSfRiMMYsHZzR0e4YhGMY0zAdxNLE8n7rKsEmt9WGreTGFlJ3G4uVkc6bmopJReUqdOifUTwDziRgmvxJbpeZgCJajsSa+xlCd6N1o06O21Zwc74v+BSdSNng3ulnZcPTauwEaeeGNDL+LH4C1ov6w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ead604-5101-453f-f773-08d7e5c74852
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:40:37.1710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/D+eL/8Wu5e5jZBni8v0SrUBCpXDrhezygkj4lF5fB4RvbLEmwHHS8S9AHlm/vmsUwUk96ONfJokbIswwU+rEwntdNEJ+WHEL8ZhT5hZ6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5351
Received-SPF: pass client-ip=40.107.6.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:40:37
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.95
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.04.2020 10:36, Vladimir Sementsov-Ogievskiy wrote:
> Just use classes introduced in previous three commits. Behavior
> difference is described in these three commits.
> 
> Drop group file, as it becomes unused.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/check | 965 ++-------------------------------------
>   tests/qemu-iotests/group | 299 ------------
>   2 files changed, 28 insertions(+), 1236 deletions(-)
>   delete mode 100644 tests/qemu-iotests/group
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 03016e1e91..4cb6fd5113 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -1,7 +1,8 @@
> -#!/usr/bin/env bash
> +#!/usr/bin/env python3
>   #
> -# Copyright (C) 2009 Red Hat, Inc.
> -# Copyright (c) 2000-2002,2006 Silicon Graphics, Inc.  All Rights Reserved.

I've dropped old copyrights. If someone think that I should keep them here
or in a new testenv.py/testfinder.py/testrunner.py, please let me know.

> +# Configure environment and run group of tests in it.
> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH


-- 
Best regards,
Vladimir

