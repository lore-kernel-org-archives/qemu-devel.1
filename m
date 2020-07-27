Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C60AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9F62072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mIPf8icT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9F62072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09Hy-0004c8-CW
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k09HN-0004B2-9Z; Mon, 27 Jul 2020 15:59:21 -0400
Received: from mail-eopbgr70139.outbound.protection.outlook.com
 ([40.107.7.139]:15926 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k09HK-0005jW-GD; Mon, 27 Jul 2020 15:59:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krwApBadNFDDwUV2DK1p8n463tusHaj0IhdJ3NPu5/cDgzYxGjT0xAI3FDwiHF/GVKWYa2ufbfx0DmPe0aTscu84UT7d/p60p87TrAKoDwx9qc31I51gAWXGqyvCZoL6xESF82DplpR27Yj8Wq5tecziqMudaj8609n3RmWprQ0dhIsYYzMoT+YBTGBR24z+d7KnizF4sE1CejvVvb0mKHlz7rDT4Xrd1ehwun6sV2XphA684MFU9B37kfwZEK53X1IpmpR+7WVC7EqRNpjrScZMzkh9DRz+24YgXykAcnAkYFRMRDfoAJf0/V2jwqO81FuvVeBz7DL3B0PBCRNapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rUTy/77Efh6VkCSGLWgmB77EqZ32spwfhLMGjX69Ss=;
 b=Qhxi1DZBKM8YIsPRddfZI+4QWW1k+g+kesxGTijqh9gRgAHOMx+jnmLzhrah6+VF9u/QaxRAv5MuxeECmjKbMI3u0TxqrLSiO+rEM1smIy57mekaCiy8UcEyegpPXbZgWzWnx5gMbvN9kk+CG+crFtE2N9yP6j5PbykFyGkCMbO/7ih4GyvUqNRAPWyra4fBg3FgaeU9I+jabsSpDz7N5DsELeo2+fr+7A8OcizcEI1irbjY4737+9b0FTj5MVX1oLwuNkOpbESoivDnF+Hrfl9WS0UWCOIytCB3oZjRFu+xcng8NaaWGQPfB/DTc8UQ36aGBIEgktcU1s+h9rXBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rUTy/77Efh6VkCSGLWgmB77EqZ32spwfhLMGjX69Ss=;
 b=mIPf8icTrsfbRaKvcFtfqy3lUft3BwElmwik+qT8ASEk7OPIyDOprh4KvXPSyOQ28eJ7fEaokmDT0MkVoqsrZenfqN2+yiM27jPApK/ZR03RXBf24gz2Yv+hHFUHap5j+YLp58oHJP5OcO3HQs6YK6SdHBhYhax5WBDFtPStids=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4024.eurprd08.prod.outlook.com (2603:10a6:20b:a5::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 19:59:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:59:14 +0000
Subject: Re: [PATCH v4 for-5.1 00/21] Fix error handling during bitmap postcopy
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200727194236.19551-1-vsementsov@virtuozzo.com>
 <c61f9429-8f2c-836d-be76-34a32bfae470@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <390c86ef-78d0-17f8-a5d2-f0b533054ea4@virtuozzo.com>
Date: Mon, 27 Jul 2020 22:59:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c61f9429-8f2c-836d-be76-34a32bfae470@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0107.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR01CA0107.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Mon, 27 Jul 2020 19:59:13 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 807d0971-1c7f-46ff-5f4a-08d83267896d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4024:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB40248B5F50B5EC6BCAB81680C1720@AM6PR08MB4024.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POarYCk5pW4aABKDh/DPq/Jb5RP4FrwZJlRLu2aaTTVvJEcc5WUggYDeFtDTwp6OGlIOYdN4qv7Wt7ZiqLpeCKTZj0M/B8yZCiagGJI4AKT4UaqgcOqZAg9fdGJcEszyIs8mDBfzRWNiFHRmGERbePgHSRr8xrOP2Dk/AuxsHjBQhii9AnHRWrCV1pLp19bclP+0wtNPLK8KlNRDqGely2+MfsxP8MPPAr/NolcULGRRDIbx9g32oCeuq7A/N0I4QiWHjgyEHi2ziIyIORuX5hyUyaeF56zDjtFS2j6qA/Qt1Qp+X4U+ab+wj0HkFey56XRq8ZqbL0lcRedpw+STVRFPampZSId6h2z2jP5CeGQbicmS9sPwQ55cozuQr9JG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(396003)(346002)(136003)(376002)(31696002)(8676002)(31686004)(86362001)(66556008)(8936002)(66946007)(83380400001)(478600001)(5660300002)(66476007)(4744005)(2906002)(107886003)(6486002)(4326008)(16576012)(316002)(36756003)(53546011)(16526019)(52116002)(956004)(186003)(26005)(7416002)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jdqDFIFyQq1VMdDy2X3HoJ4uKh1s8oyl39Lkmi0LkGN2cpp6bxhx+eEBInZITTY6mlqp2O8keXIgXxmRlXm8pJkbDrMyBmcnL3arXOsuC1fltrJbK7MvWYKdlzn70h2mxZ4qfQd/44qOx73Waf00esw+IfQIen1h2KQxJLgk4p7qrL/e7RJSd9eceC0nrYQ15Dd6T1FRW1S9X615nb5gwMLTNxanJ8D5NVagRex3JXVTkvMPrExNvslgpnUZ+gM/KLfrXY4Y8Ccytyl5WiQhaXmWWj8aW3VeoHZLvEd4RsV6LuBhCv3R5XyQmX6RUmuIzOba+ib+VU7j39+G18bXZ2z4f2Z8IbV5rrbRROtAA6kcw9pKYeqRdxECSO+e9abyzoOGXsBySJ3+Q80sVkJSR43yWLYsUV90AKsLwRUGCPOxA6rUnimT/zVj+jrdz76EgynVsbhgVo7h4zGE2HAE2E25k0GiGa4tC0S2FTLqvJg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807d0971-1c7f-46ff-5f4a-08d83267896d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:59:14.2816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rjFN7pQFwC5Wa57ibULdYKtyUnHAIT4dsuWLe+pfnZ0BJZLOzSLUX7ftTOr0Yk3RrOzLKlSultSXPd/TA0bzxiSgJw+3YSw/35f6rN/RLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4024
Received-SPF: pass client-ip=40.107.7.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:59:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.07.2020 22:53, Eric Blake wrote:
> On 7/27/20 2:42 PM, Vladimir Sementsov-Ogievskiy wrote:
>> v4:
>>
>> 01: typo in commit msg
>> 07: reword commit msg, add Eric's r-b
>> 10: add Dr. David's r-b
>> 15: add check for buf_size
>>      use g_autofree (and fix introduced in v3)
>>      use QEMU_LOCK_GUARD
>> 17: fix commit msg, add Eric's r-b
>> 20-21: add Eric's t-b
> 
> What timing!  I was literally in the middle of composing my pull request when this landed in my inbox; I'll refresh my local contents to pick this up (and see if you tweaked anything differently than I did).
> 
> Therefore, my pull request is now shifted by an hour or two, but will still come today ;)
> 

Sorry :). Thanks for your work!

-- 
Best regards,
Vladimir

