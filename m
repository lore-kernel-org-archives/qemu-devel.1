Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD70C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A2A20575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jj7OjnV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A2A20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6Ia-0005ag-Tz
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ6Hd-0004q7-Fj; Thu, 14 May 2020 01:19:49 -0400
Received: from mail-eopbgr150121.outbound.protection.outlook.com
 ([40.107.15.121]:35653 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ6Hb-0003Jr-8o; Thu, 14 May 2020 01:19:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtH2cu16yTHkC+1zHsh4Ml2BAM0s0RvyckIhrc8dksrLtnRHPYJv6SIGM2hnFYzlR8cXTyGK5iouus/sU5+bd+ZiZPmq2iGUss5ivY+kv9cnooAt+Zi5OIw2hmtMWx/dwTOhbiHm4gidOTZKKDJTeVHYYL81Yk9zhbAA27iQS77VW8buftSHe2SBaZDnHPQ+A9rw4cIkQq+/qucmKLp0UCgCJ+Ts4iEJBx2kuwPWd1C1Lt7nd1ZyrcN0SOxFpDXaFPR85lQi+mdMFzYA1c7bMrCPOrJ7LsV17GpzA7tlNLWZaBwFJ93SnFFrSYrRtFpxFiNVJ2i8Wo3ZCDXApSDEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZbHwfIYzhI20vtQ5iFi/xCLTfdTyOSLKh41YHw9ZwU=;
 b=FsLThGWa83b16rBEABpd5p14V9U4QUUVj/oiHbNv31f/UkeATdC2AXGDVlwzEeIx7vQVaFSdk4Tb0B7TP1W4RJJlpNMItaL3bcVgRDIQvj0BiGKSTTcrr3tV8gcsnpj79HDpIGXyd5hanXDP7wn+ZQwMKQLVkAuII8vkRAwIBYSxvalrvMlzDOOx5ScocbS/Q/FRv6ZVaxXKivwGEXJWoCmbvplylFgw9N1teRi0T88wNacRBwSFP3ShCicLwFy83w2i3h7edSjIjztlr/+YmlhzdWHhvjvHH9xKRLOOSsHGUE7OJBWfi97vflyFn3jela8OudTR9PjTAgm4i/K+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZbHwfIYzhI20vtQ5iFi/xCLTfdTyOSLKh41YHw9ZwU=;
 b=Jj7OjnV3UnJTmHsCFzLEBGtvrk7kBCKFGJ0RYpQTq0EzmRnfuMI8vh6oy556500TeDjbf61fAZ0LdrziywDEYtNacBXXc4Nl7H5x9TX5G7fhFrS1wXSVJ+alIUsLQkkLcIFzARU7bVwCxvpIFYuGES4Ju9RSqaYZfBj2G9mEr28=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5302.eurprd08.prod.outlook.com (2603:10a6:20b:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 14 May
 2020 05:19:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 05:19:43 +0000
Subject: Re: [PATCH v4 3/9] block: Make it easier to learn which BDS support
 bitmaps
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f688d988-43ab-8c3e-f742-68177b8a85cb@virtuozzo.com>
Date: Thu, 14 May 2020 08:19:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0013.eurprd05.prod.outlook.com (2603:10a6:205::26)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM4PR05CA0013.eurprd05.prod.outlook.com (2603:10a6:205::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 05:19:42 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72471f11-07f6-46da-6b64-08d7f7c668f3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5302:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53027C59654FB761966683FEC1BC0@AM7PR08MB5302.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSHY6FR6E9V1+zV1C8mXXbABG0Xc57xDQ06vpB1wUeZ7gqTVVzomODvO6Ed6UPq13KZrjVOhjPVrSmK2LHMBLJW00OsvJFzjKgIE94/suYggTVy7xDfnoBvOekby21O78s4/3ToU3XEdldodGbOtigd26szUG0WNX4Z825+nS7ABG/kL5VrQy3gcsld0ZgMEuTsG3XuuuFZl2P0RsCc8powE6Wideq5McpvFhW0vkhoVkQxXDcKx9vuJ9AcXg8OXDKQDliNICUg1RFJ/0pf4nceeJjzQc+eiYl5yKn1A/46mlJTX81ezrtFItopuP2F9DwQd0BZeeSvsp2udZgIwVrO4IRLOEU7S1So2LrXJioX0Gt2jjIJz2WRzH8CxcGEnUoNjl2+dzIlO8z+lH2X8YLzmnxMkS/E0piNCwzuwsmYihJjiAFIHJYDNQUwtYcW240m+Z58PbR6BFHPdSKEbc9Rw2FkRnxEBshOVtasrAK8hQuIFxbCQ5y/l4k4CLpN+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(396003)(366004)(376002)(136003)(66476007)(66946007)(2906002)(66556008)(8936002)(36756003)(8676002)(86362001)(956004)(2616005)(31686004)(6486002)(52116002)(5660300002)(16576012)(31696002)(26005)(16526019)(316002)(186003)(4326008)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sft98j7G4l5iq62p5xsyToIATFJL3JnT09cbGMUXyIh++DkBpZgEnGv99IusRfGyLEas4KXykjBoyoeEC/yVllsqdyCj40iCHHK2003zoQATS9RQR1yAiXCqr5lEZfuA3VU/39fx0YheRUUa1vVWXiNfSbtV4hJ6MhI+8zg3hA4xZMY4U5oNWhOdN8/QNL7HW8WnZcg5yUzj79Qgbw6JcqMDT9laxL5cfBbZ2zbDdKw32M/4c/0P/VS7fx8agoeds1m+d44MGdFiNu6EsEMOycWDEnmafmFjpxDlHmJFn1MWRlJt//SdS5ci8hRHl+0FrSTjS9k86+ciRa/Zlqn6IWT6WLQBJV37Y+qfSN8la/nI2niaKabBh+ar14Ng3zNfETW2M6SLf8iakB4vbmQutun3piRJ7Cuam+uFW5pA0lMwy7fRE2iy4irOcw+majdza0f7YT6SrLUBOqZEFePoqA+IR8I3lQA7g9dC05aS9ZtxBmmeTPPYvF1PlHb/EE1p
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72471f11-07f6-46da-6b64-08d7f7c668f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 05:19:43.3917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNxpJI+MfAhRtBQ7OW4FqHxtf0hESc/6eFU+S+VgESzudUyF0mKqS52T9PBVAhGauIFSn6/+AFs7RSIc6DwzQYFyEjbXMF8f8L9emWuWyFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5302
Received-SPF: pass client-ip=40.107.15.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 01:19:44
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 04:16, Eric Blake wrote:
> Upcoming patches will enhance bitmap support in qemu-img, but in doing
> so, it turns out to be nice to suppress output when persistent bitmaps
> make no sense (such as on a qcow2 v2 image).  Add a hook to make this
> easier to query.
> 
> This patch adds a new callback .bdrv_supports_persistent_dirty_bitmap,
> rather than trying to shoehorn the answer in via existing callbacks.
> In particular, while it might have been possible to overload
> .bdrv_co_can_store_new_dirty_bitmap to special-case a NULL input to
> answer whether any persistent bitmaps are supported, that is at odds
> with whether a particular bitmap can be stored (for example, even on
> an image that supports persistent bitmaps but has currently filled up
> the maximum number of bitmaps, attempts to store another one should
> fail); and the new functionality doesn't require coroutine safety.
> Similarly, we could have added one more piece of information to
> .bdrv_get_info, but then again, most callers to that function tend to
> already discard extraneous information, and making it a catch-all
> rather than a series of dedicated scalar queries hasn't really
> simplified life.
> 
> In the future, when we improve the ability to look up bitmaps through
> a filter, we will probably also want to teach the block layer to
> automatically let filters pass this request on through.

Hm. I think that bitmap at filter bs is a valid thing (moreover I have a plan to use it for one issue), so I'm not sure that it's good idea to do any generic logic around bitmaps work through filters, better to always address the exact node you mean..

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

