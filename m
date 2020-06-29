Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A540C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B5E23D9B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VF/ze6Uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B5E23D9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpudT-0006sh-Fd
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpubz-0005uS-6T
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:18:19 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:47904 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpubv-0005jw-Dw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:18:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMRLM6CGE4bdhkoQww+Y7971hHCcSpKx5m0CDTWU4d1hoLGI6bI2QucUIW8VuIYmCRa1b9aXtvt2JLhnd4eZaZRbRGGHcekOiAXxiJjuACCbGgPSpIlZr3mJBehkdzq/W8OVWb36h+QLyst+mFZtLmLb+R8cDgkIGZsQBzXoJ+m94rcZGSSTccrjyrCerNPN8DC+ssb8JiuJkXvlGbh3IdqNyV3LJi4xTUut4bzQow9MVQvz7Mt/bvTSoWF7cUajLg9YHkwEPq5ieWOqzblfei/XpKYD2im+6loC4PlITQG4Rp4bmS1FLqQMluwXjoshqXGVLfpnMzAYgCPZSYKKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIygvcGneGQh/0oNJ5VXzhygioOa5+2xC9sm50R3Q1E=;
 b=aWftnHKxDftUdo+sS2pvB1pQBmB6bVeDlF/fMYDw6IWrn5Qv/HIYpH/hGpwVWOoXkXJVJFAQZ3WLoZUifnuNAr6EHhll3+eTmatj+lk02mBwssCj2FyDNPddadXTnHtztlGViSyJnKCR1asyWRvLnJ+kSskzVOhjCKUHJF8y95NwGbMHIdDFiHOp/v5UnbCLzuOjITVChIHZPtFR7pU1EQPB+N8gLSilzge6x7+oWGr5lCoZD5sR1JFdZvd8peOgGc1TkPfsjuT8Iqmg0SjSgLhBpMJInez9aGC/29Z/kaUH5/MewP5JftXUR/6VNxykjvZVWXi875YraoZH+wMigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIygvcGneGQh/0oNJ5VXzhygioOa5+2xC9sm50R3Q1E=;
 b=VF/ze6UwzFmpEmqvg8/C6HR8Cp8+831SBg4usjbX470U8Mm4mD5gi/j4uWbX2VZmKop2NQKWSVQuWtRE9Dn0XTZ52mVwYu+SX3lOmvU4THvCcQTQuZW7bM0fU0P5L82MFn/St9m0cgWKQI0p/Z2ibUcy2bruYUObAdtWK0fIWW8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Mon, 29 Jun
 2020 14:18:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 14:18:12 +0000
Subject: Re: Properly quitting qemu immediately after failing migration
To: Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0dce6c63-4b83-8b1a-6d00-07235f637997@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <92ce741d-ef67-fbf9-a889-27d9ae218681@virtuozzo.com>
Date: Mon, 29 Jun 2020 17:18:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <0dce6c63-4b83-8b1a-6d00-07235f637997@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0095.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM0PR10CA0095.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Mon, 29 Jun 2020 14:18:11 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 744cb642-9070-4b93-daa8-08d81c374184
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-Microsoft-Antispam-PRVS: <AM6PR08MB48527EC47518B5671E2B0AFBC16E0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KTdL1RKqgzpXcQQkxDP/K8ixvHoWJwHvWyyJhlY46JTNNOuJzOTYWnEGhRyXUPYZkeanEfMCY9APnltGOCM08hO9UBUz+Z2jdetCBaiyFjtxIQOrMPDzBA80Li5P2wbhw/RnP35kEQzpabRFGeoHUaaGz+7GJ/bZBsVdsCnZN7iWuKPD9N+0Pc7/fazazCVHKu3H8oRqerZP/ltKVka+EmPICgFX5I9rqReTB2S0Yo1CnV221oetynVXPgKia0UNRCyYWLJhrrdE6Z8j0dS4PsPwccOQbfd4d0i/VxErWaRMoDk7psSK7P4M/4ta4flNyTfnQvz/5Ih6Vjo2YsTXIwH7bFmcd98h29pVTwsyInhfedSUGzKJhvvHbKYLFuJrk1n42VRXfvYhrBspY+wPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(346002)(39840400004)(376002)(316002)(83380400001)(31696002)(478600001)(86362001)(16576012)(31686004)(66946007)(66556008)(66476007)(110136005)(6486002)(5660300002)(956004)(2616005)(26005)(8676002)(52116002)(186003)(16526019)(8936002)(36756003)(2906002)(14773001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nkrYWYD78/yYUKa3ki1EQPY6PGGuITlKIMkVMQz4O83MRSFbA9oPKnnKRTuFikepOlbi4SGT3EOTZvdDcQsCn7ekAnPKgU9FRWTx1PUxJSEe/mr8vEr8SRldssFyh1RjCCv21kw5NuMovHbv2aiMHrrRN4zgU20dLMhhkeaXNCQCnoCNVgtYW7il7Kn9l3OPudQuan2d1MAPxW+w5kIG05jFfYPXhGf0tel0xrUwc1hK6Usk3QtwSbTF/9ZequKOhVBfl/68kqQCzHNho8rJNm8FOm5VTEbszmWqJSQBZJ8vchoAPudzCVKvO4gsrPGu63+bCLrztXU9DvJc5V1YX+QsCNZiJYE1TsmMVUu2/juRqgll2ykwCyA0tjY1une3OboMbfVn6SO59QQO82uRb/fxGV2qn/DVeBrsTCIDmTBIJ45HAFFrCVmHqZFRwwMkN7JV1R5aqDjr/r4J52ysU5FuU3JYpzdxlYfv323YlUNNeDDuZkOHz6cP7Wz2vlUH
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744cb642-9070-4b93-daa8-08d81c374184
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 14:18:12.1716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi06nQmx4xvjV66RhPvOo2mazUfHFEZfUILYFjtJulDaKqpcu/KNk65M2BnhhFlDGLhj1rLET1aTl8ImS5+dRL72uoWfgFeu3RjGS6wIAvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.8.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 10:18:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.06.2020 16:48, Max Reitz wrote:
> Hi,
> 
> In an iotest, I’m trying to quit qemu immediately after a migration has
> failed.  Unfortunately, that doesn’t seem to be possible in a clean way:
> migrate_fd_cleanup() runs only at some point after the migration state
> is already “failed”, so if I just wait for that “failed” state and
> immediately quit, some cleanup functions may not have been run yet.
> 
> This is a problem with dirty bitmap migration at least, because it
> increases the refcount on all block devices that are to be migrated, so
> if we don’t call the cleanup function before quitting, the refcount will
> stay elevated and bdrv_close_all() will hit an assertion because those
> block devices are still around after blk_remove_all_bs() and
> blockdev_close_all_bdrv_states().
> 
> In practice this particular issue might not be that big of a problem,
> because it just means qemu aborts when the user intended to let it quit
> anyway.  But on one hand I could imagine that there are other clean-up
> paths that should definitely run before qemu quits (although I don’t
> know), and on the other, it’s a problem for my test.
> 
> I tried working around the problem for my test by waiting on “Unable to
> write” appearing on stderr, because that indicates that
> migrate_fd_cleanup()’s error_report_err() has been reached.  But on one
> hand, that isn’t really nice, and on the other, it doesn’t even work
> when the failure is on the source side (because then there is no
> s->error for migrate_fd_cleanup() to report).
> 
> In all, I’m asking:
> (1) Is there a nice solution for me now to delay quitting qemu until the
> failed migration has been fully resolved, including the clean-up?
> 
> (2) Isn’t it a problem if qemu crashes when you issue “quit” via QMP at
> the wrong time?  Like, maybe lingering subprocesses when using “exec”?
> 
> 

I'll look more closely tomorrow, but as a short answer: try my series
"[PATCH v2 00/22] Fix error handling during bitmap postcopy" it
handles different problems around migration failures & qemu shutdown,
probably it will help.


-- 
Best regards,
Vladimir

