Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E575FC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 06:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640ED2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 06:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S8QZY4Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640ED2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRsDH-0000BJ-JJ
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 02:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRsBN-00067R-RH
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 02:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRsBB-00081T-Rf
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 02:51:28 -0400
Received: from mail-vi1eur05on2097.outbound.protection.outlook.com
 ([40.107.21.97]:46401 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRsB6-0007v3-Jr; Fri, 24 Apr 2020 02:51:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+pwSAT7LT2q7w5tVT0KLNw0uJULXYcYOJvIHHoGPiIA7Go8jAG3UTWEZfLO27nej50c6Rzodj9mdpTJrhuW/wmPxAHcCca3BbzoGEtXXUtAoJ3tMfQ9mRMkTwT0X2Sy6TClorlQnP9CEtENurjZtWYzcN1wpoRl1ucjpdxGcOtaeoquTC3tT2J3zi1sQXkZbKgqAu7v1mEAw8OJtRlXweQjUylWqVpdvyYec4jsApfxJZ2l67x5DLP5sxIm9mL6UxNdbeqWZL0YvKt6ubCdGjjrejeEG3dv6+obXNzC3C2EcLUfcplJlqy29LFz5TG2D2vHaVWQrqm/9GlUpQJqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj0rftf2Gue13RZeVzbwkpIeaidn3hRMhtjAEsWfuhQ=;
 b=cZV25LGkGV5FlTo0IN2n5zgZ6JRtJDiTnISHaBPQgtuFwQgrLZuDj0qkyfL7CcSpbNg+rYDvc7smIuWhlgJhZVsH6ZAAda0K+NKZncXjKlhD9CBLk2zFQOAoGlV01+OBkSK02cicYAjuMe8RBhD0OkwwVA4FF7WlKj2H87zQ0JRGTcQK9ZvQ1l7qOdIUkGjOglffw8Q/8cbWIUdqa4rk4ovdM9E4qV+OBxeimJqAFf53JrOphFq622kIdPawyIWTAtg1rDY7kNkFVPS7jfWqR0qUask2sxabEWMO2iYXzVdM0NhnkkLFC8/Jd329x6Eb9YDYxsM8Tele8KNisJt1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj0rftf2Gue13RZeVzbwkpIeaidn3hRMhtjAEsWfuhQ=;
 b=S8QZY4OcbwbIVSFZbxi9OrbLPRuDuxUWJ1FKUHPLGZrwmZ3k3KB4Rr976HC2wNRmbXKjFh5aQN81KdH6F17/9wFdYYiyIK2pP8d/YPSVxiB58H49j7fOBGvXhuuX4/FDAIGEuQ0lV9Qvk8Czu/mK2C+caoGu0UMW1coNAcI8mwo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 24 Apr
 2020 06:51:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 06:51:08 +0000
Subject: Re: [PATCH v6 08/10] iotests: Filter testfiles out in
 filter_img_info()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-9-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424095106504
Message-ID: <b919c6c7-5b3f-3b1c-9a2b-c1366d538507@virtuozzo.com>
Date: Fri, 24 Apr 2020 09:51:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200423150127.142609-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.145) by
 FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 06:51:07 +0000
X-Tagtoolbar-Keys: D20200424095106504
X-Originating-IP: [185.215.60.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47d4dc5d-b770-474f-d350-08d7e81bde0b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53660FCC42F4E139D4644137C1D00@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(136003)(39840400004)(346002)(366004)(396003)(478600001)(81156014)(66556008)(66946007)(26005)(66476007)(5660300002)(52116002)(36756003)(8676002)(316002)(2616005)(86362001)(186003)(16576012)(31696002)(4744005)(16526019)(2906002)(31686004)(8936002)(956004)(4326008)(6486002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RFDNHRif3xuXLPkwJQjY8N2Ar7UnTEg+/1QytSGYAuwsqPbA5Ls/gubxgJqR600oV4R0kBOPDoZkREHdTTxwBlU5nTuhFhz+V5zrpnCBE+vWXn5ei+OtpprTIKwv0eZomDdeGYsvrwPfhX1HNGjE+UUSZwqvPZE/vrXBFtM0tJ8+LJl8vekK0hwoO3SNP31Rf1k7Ns08YdmGcXpECyvxwzPMoWFd89VthQJXaYRBKJ+5V0I4UdEw2lNcIadjOBkEcpTwcJyi9sxRQXoFPB0gSSY3/bBS6x7bpy9EEybt4cGTzA00CpnS0i2iiXBOOdxynXHCnEd8UFII0Xz4Q9LBGzw4/VBhNBDW+qIlSQUFjtpzfmhijJv2KWCJ8fn3TQHHPmwCJraiSTLHEaSbIrUew5ZZMfg3eC42FQR2AV7og2i3xn7EE7vCbjr4f6jBMSm
X-MS-Exchange-AntiSpam-MessageData: yofPjM8Skw6m/97nR2woU2gGDYxTo08uS62MQyLmElGksnfeePML4cDRfSeqlNfe613GC3qXTquzVOxeEYMuvKWtDQ9QiekJ0faJeljedmStmhpwC67Dy+4YX6cIl3LjHbjdgfRGzrBoVjoQIN2IfQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d4dc5d-b770-474f-d350-08d7e81bde0b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 06:51:08.4198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rl/tyFNiJPbx0LNSy7YU7IVJXCqqghKjZOzxNh+63T9pkt/tsqsFCWaYcxCnwEPTKk4n8E/QDthJhQWMUd2wbqL9HrrCcGyGt4DyZFpW8TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.21.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:51:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.97
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.04.2020 18:01, Kevin Wolf wrote:
> We want to keep TEST_IMG for the full path of the main test image, but
> filter_testfiles() must be called for other test images before replacing
> other things like the image format because the test directory path could
> contain the format as a substring.
> 
> Insert a filter_testfiles() call between both.
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> Reviewed-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

