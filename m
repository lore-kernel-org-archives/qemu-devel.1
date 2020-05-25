Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E375DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA5D2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YyqNnben"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA5D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd7IU-0005l5-VU
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 03:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jd7Hs-0005BB-My; Mon, 25 May 2020 03:12:40 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
 ([40.107.7.127]:23937 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jd7Hq-0007LW-ST; Mon, 25 May 2020 03:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMxaOqmXvOeqETvNyT6tzP7WcLBAela6Ytt/jUyByQPYZ0lBuvgHVPs1h/Fdn1OmU1Hl7y9gWFh9b5tOYoBk19SqMT3FsDVEVCtOpdLnaB6cKd8g7KWDbtTA2tTyWS62j5ep6ONb+UFf3k2Fcasri0zFfIYIJBH6QPc8q9xfs1NSQuvnLX16EAyWiK29GxICQnYd/FHWJzGdqnwaj0WdQTlv05rqbAsssyW353stqlJQHZJ1BhRDGFCygQG51Al7UV0iaSY0awCBcGq+/hc/Vg4hoEVCpXXFXfkf4bDC9sjmmH+Wvvc9vixLEfYQqP4W5U/zQU9hTVlF3S3tMMSqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqRQGGp7lZawa5v9bxAkySOdT/go1JTMXVZbnsyUy2E=;
 b=NjNDHXyyQIXLQxLUdxtQRfd47Sv5KO1eHYJwzxPR77BABVjsw7VoVczKxApbf9oW3vbnU+iACub05J3ZqQuD8e2NVRPzzZXzTr/D6xvwD10tUklVJ0tgbjWN+vwJP/8hsSl9ql5fufwShAQO8VzqJTK7W19m0YlITi8xwb+jQ73IE4EibpmMrdYXv+llKuHsrL02qqugbYchfYWFZZB2rZIeOKxV9UJaonUFUJkOeSu3mqayqCL6WeilOcfwwGxosr13gW+dnXhR0h5DxjE4FYJHjR5LT/DAhd1Eo5s6gTmzRsH07ng6vrA106zxOPt97u742b6KROa37Y4tfG7J0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqRQGGp7lZawa5v9bxAkySOdT/go1JTMXVZbnsyUy2E=;
 b=YyqNnben4xj0riG2UYp1hsMYBFlkNBreCmxcvlwvfNZwz/O/o2Yr93SuQ1+D8JgGnOLJ//lXPUYK3+ldmkkBOgjw+9Knr42/93YBIy41LtJE9X9/qGujR6zTgRZlQAdnDyai7FsKE2t56MyI/evnMEkydJFdCpY0Y27s/W0/TpQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5368.eurprd08.prod.outlook.com (2603:10a6:20b:103::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 07:12:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 07:12:34 +0000
Subject: Re: [PATCH v6 3/5] qemu-img: Factor out code for merging bitmaps
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200521192137.1120211-1-eblake@redhat.com>
 <20200521192137.1120211-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4739a72e-2629-8054-39f2-f2097033df83@virtuozzo.com>
Date: Mon, 25 May 2020 10:12:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200521192137.1120211-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0138.eurprd05.prod.outlook.com
 (2603:10a6:207:3::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.147) by
 AM3PR05CA0138.eurprd05.prod.outlook.com (2603:10a6:207:3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Mon, 25 May 2020 07:12:34 +0000
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 252abe57-b21d-47d5-732a-08d8007aff92
X-MS-TrafficTypeDiagnostic: AM7PR08MB5368:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5368BC16B028039F2AB17460C1B30@AM7PR08MB5368.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lLGWb+K037Gl1yMZDxN1naPBu7ca9lFEtmUnZVE1NhlS3/aKbtBHvnnK+Dz6bTNqbfSiwBJ2ltelw7WQbgWtn0Z0LHUu0eigZFwoJrT8MW6tT8IIGh7ITg5uxwJx640yxphJgI7j2lNmt6iIG6LV4MXkzTBOPbFgoBggHnuY4edz9VOwe+cXm17bdtiucaQX/KD6C0fkc81UAKUbkcf6/VIBlFFH5Hzm0kJoyeerbhuTZYC5cjfdIYR5MjWQDOv/Q7qdMFZuE9J/m5VL6qkvP/dH/YEIxG0cYzpwdc1MvdfE1exKF+Aq2Ad2kr0zLhr8VSdMuwC3j/Cv43BK4cuzH1gnFh4QqbCQWHvK6r9BhT5yFH46QXjyPvi76FliVK5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(376002)(366004)(396003)(346002)(316002)(26005)(4326008)(16576012)(16526019)(186003)(8936002)(86362001)(31686004)(66556008)(66946007)(8676002)(5660300002)(66476007)(52116002)(4744005)(6486002)(478600001)(36756003)(2616005)(956004)(31696002)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Wes1+xF2FEhMQBorsThl1dXtjfvxglSWRk0lJDWU8mKmICTbyxztfekCzD6LVPsCeIA+Z5ptHq/HRr9/1iH5ElokPruiQyxdoIXyv5OsT4KlXZazpjz/JTGLBm5sv8VPRKqRJ23y6B7kvYBWQ4yl14Ulpe4zU/cMbGyTrO5UkHxA5DkbfvDJhjmGiKEUm5+eVohgQd6jpKTFmmD+gMe+yxGPl661KaaAqgRT7xd/GxzhupWNRAMj0RSBP1tn41LUyGIv4ipbopmdId1bUlJeuIM/hbMLVwA/4LCCIhAsNcz4SYtC0rGqs+U/4oB816yzgM2ORXbEjqIceMKXB3bhROKM7CksQ79iwTTw0SY6NCnHkMh0zKm+AaJuKjYOfbe6AYteNc3SRPrDtLsiFF+QVFLPvnRC3glDvY3pmsQhT2gpWoy8XIaryj1Ds+mZVKARBhg0Jux+csPXvlFaZojVdHIIl/4t/UZkntHiZnxr5B6MGfmaL/iTr2x3r0XgTNnI
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252abe57-b21d-47d5-732a-08d8007aff92
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 07:12:34.7659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LxOHsmFZJcRIO/RBi8JR0inwk48vlVrJdW9g2G77mWtMca3vLatDArjljQw5ByGlKaehEIpGQXVN48gHBqPn826labV3AajVzgM+yaKXj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368
Received-SPF: pass client-ip=40.107.7.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 03:12:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.05.2020 22:21, Eric Blake wrote:
> The next patch will add another client that wants to merge dirty
> bitmaps; it will be easier to refactor the code to construct the QAPI
> struct correctly into a helper function.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

