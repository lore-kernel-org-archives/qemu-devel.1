Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF1CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA92207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e6sIqBeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA92207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMV1-0004kB-Uk
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeMTr-0003KT-UM; Thu, 28 May 2020 13:38:11 -0400
Received: from mail-eopbgr20114.outbound.protection.outlook.com
 ([40.107.2.114]:46945 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeMTp-0008QX-63; Thu, 28 May 2020 13:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVUD41F7wYYniNKTwK3WG6piN2LBoze03MwiHgqXAxTqQN1q42/YTfXaXh11eyacwKb5gQ4/6BqNbZmjJZrZtOttNqBbVDVk7BtkUGp++7ArzxsplvffPtyX9/TAj6WOKTuZ6EdFmFDdNGEIwotjnRHowf+0xRkyg0l0sgNucsnRdtS/n4hbbMY9BNxFusx9yBaN/wDQvRgYeGHpFViuPWOpxWnZLbjz/CVRwCQRBDVdtXvZoDnXqfRIaQtod29wloSec39BgiBatVxk8ZMJck6lTtbS0/jrqbu24efg6RkzjvjZK6Pma5o3Ah+f6vr5vPqPK1PHsxW7D/LvohYF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w518G8faY498IqbjpCAoUCqSewfxNeRfNHRxeYJROL8=;
 b=SESX2IgdJ1939iCoZyMFu7ytEyMCI4GBH6Rzhuu7tLWRkUq5BSoTRF8m+Jqw2/zewjx98SZedyZQHaLIsdRkZAE2hzm7AfVR0p7byWpG3Zw2kv9pcygUwE7uOg2OzdXPtKTHbwRTYBwfEqjMuGlgYolGxGiDqT4hrso5PFEAlDatpIOlWzV1KipX12xb9WrNgxVmcUhoIxr/GWUcxQS+E6A62QNIssX77vbEubDFaTTeM30oD1fT20m5oudifJmpzkBxSuMRdynC97Oj3cuGKTuRZMVQDfGajCwqAI+NzAADrtHi5WOy/y24+uHmwTCjAbnsUYJKHO8FYVGBZd6nlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w518G8faY498IqbjpCAoUCqSewfxNeRfNHRxeYJROL8=;
 b=e6sIqBeRpbBYfvArmr0ZzfyDqbji40q0JX7EZzoH1p43mEdj9jYx6y1QKMc1Lxq5nVOX0msFOJIwb+YqInwMsarsIljjPDLbf/ZbDfHhQpZBAgUJOV+hCLYruys0N9ZdyLl6wy41Dmmf/f/3zq2gLCXCr7EpnoXYGcJglkaC+OY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5413.eurprd08.prod.outlook.com (2603:10a6:20b:10a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 17:38:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 17:38:06 +0000
Subject: Re: [PATCH v3] block: Factor out bdrv_run_co()
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200520144901.16589-1-vsementsov@virtuozzo.com>
 <20200528151707.GH158218@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <99f13039-ae61-fc5e-43fa-8cbc3f3e1bab@virtuozzo.com>
Date: Thu, 28 May 2020 20:38:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200528151707.GH158218@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0119.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0PR06CA0119.eurprd06.prod.outlook.com (2603:10a6:208:ab::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 17:38:05 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c594b08-ba84-4ec3-d7f5-08d8032de107
X-MS-TrafficTypeDiagnostic: AM7PR08MB5413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB541317D61B0AD9843C387F73C18E0@AM7PR08MB5413.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7fQ6SIgydNmtvOKQ9ZuTTKIs5TOmk2OJ0C6m3X7KcnMs6XmZDApRW9MXzxGDrX12vuPga/mKdV4Y6CWKOmDZv8UZbO/f5F0BauBQ0TDUp8M2Ragl9t51DZeODN130Ry9PPwTB/Dybmz6DjAji9EuO6UfRXXjLFKaChx6uVIY0JBbwZb2F/HoFpAKuxHC282sssmLZI20xhskADvsGnBw9qpoEgVSv3b00klXHohKv4hfjI49+Hn4AfvHCeZ15p9vTmnh30ptPoqTG216RxP0SfnTPGyDaN8UYT3bYQva+v41tSz6C/F2vAa092z1e6KSGpgwcm+YTRGEeVovjN7uBf5ICSGnJRJbSYuqSRwKOO1Hm21ilxcPPXyMd5RIknEosqrViK1A+zPQnyBNqEAYiypK+w5KZ5oFaKAi31KFMlkECyI9B9/yuQjG9kNdmLsTLXr8Hq4KWqv23n7iUobLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(396003)(39850400004)(376002)(52116002)(6486002)(16576012)(107886003)(66556008)(66476007)(6916009)(4326008)(316002)(66946007)(36756003)(5660300002)(31686004)(8676002)(8936002)(26005)(83380400001)(31696002)(186003)(16526019)(2616005)(86362001)(956004)(478600001)(2906002)(966005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gZERXyBISDYCgzVrHkzSSaWS07mcHzcQrV4IL82vfYE0yE0omp54t//7e/uyoL9M9M4caORYpU6qp8ceHGCJMBIg/IMMeOH+lrqGeuHkWgL46E2da1sWXFh0p2cjl4ZezlwXsw2yDtKNdsNqVQVv6cVR4sRrdxG+aVQkVVXpecLZ6ha7jXrmrq9CZYDTc2BbsFKbDcU7LDVHmpFpoJIc6Bvm20Xr4ZhAqdIcbN2aGk2S3vXl+j/YZzBWn5T0IE7yaHfmxbfrDGiOAx8OFjoBCoKQx9ruJjgVnja52kpZi+KzJIHU5XsxYDnUS5P+OfCCMXzbQ65jdR3DdIPsoFBl2p/u/ce8wDWjk4L61rQmyPtS2HwaxrtnuGgyt500X+NV6k0ZQubF62Zp2RR85LuPtDQuQM17GsTOcQeeQnCTapPzItBTpQIzMWto+XMUhXxFMO0/J6F8yfDFWuBT4ziA/j5lYhlMMVMJWJjT1PcE6eQcsCw1Wisk9lQjeV8thfUQ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c594b08-ba84-4ec3-d7f5-08d8032de107
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 17:38:05.8845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TipISg4+NGnavHMOiLk/EqIuI/wUocueFpOq2hNhjC7GZ4vliztgJtnY+X//bsHa9LTcNyWHYCyOqTB52MeEamhEaH4+/rU10EJo0Qa1Jpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5413
Received-SPF: pass client-ip=40.107.2.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 13:38:06
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.05.2020 18:17, Stefan Hajnoczi wrote:
> On Wed, May 20, 2020 at 05:49:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> We have a few bdrv_*() functions that can either spawn a new coroutine
>> and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
>> alreeady running in a coroutine. All of them duplicate basically the
>> same code.
>>
>> Factor the common code into a new function bdrv_run_co().
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>     [Factor out bdrv_run_co_entry too]
>> ---
>>
>> v3: keep created coroutine in BdrvRunCo struct for debugging [Kevin]
>>
>>   block/io.c | 193 ++++++++++++++++++++---------------------------------
>>   1 file changed, 72 insertions(+), 121 deletions(-)
> 
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block
> 
> Stefan
> 

Actually, [PATCH v5 0/7] coroutines: generate wrapper code
substites this patch.. What do you think of it, could we take it instead?


-- 
Best regards,
Vladimir

