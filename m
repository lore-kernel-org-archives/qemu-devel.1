Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C37C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 13:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E34A2073A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 13:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uK5Z/iLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E34A2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMA8D-0000KA-3Z
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 09:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kMA6p-00089O-DH; Sat, 26 Sep 2020 09:19:27 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com
 ([40.107.8.103]:6961 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kMA6n-0000Rm-3Z; Sat, 26 Sep 2020 09:19:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq4J2EcF+XZFCObhw6rFMP+w+AU98QaoRAxNaY8vew6fDZlTGk/Y5SwKphV8ivun5Bp54sDutOukHRwp/9vxkTF5FTRUlegWYZUO6YoWQeMkeaKccSwxzjepBkJckBoDwhlAfsTajZNJD+bMlOqFnJ4Cu3Weq4ggaY5MnSmF03Mc5QQ7USpqMtN78rZzO9o5XJ5aPcPJWLK5LMdZFWM6ZpCYlXGUrTdrAnQmKNfxBqmL9lDlv2giMuLz7m6RmpfRmnhg5liKB/YFCom6mcDCGSHN56B6p42YftbcIwtz7wf5jIhUIMANLL4uGKc/ngpy4e2OckTollNlXnRJGVY0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFaTFABGZHK8k7VwH8ha1wo2Elkub0uZ9+jPu+SRBdQ=;
 b=faSBX/0Jg70wvztd993yFvEDRQCXKaZEI3aMLz0RQ465ZT1Um2rccboTZefOOjbUUoJNhphwQuH61BdhVRJPaVgpEuiZ5pkKLyVBaEgzzSkmq3L1QyVC29PZ7HzjXPfGjsb5Rb7kskeFCKg2/3s+xsBBA7AnX//cNP5ujKJcQxZA4dIBvOIZg6lXUv+FLH6hsry+dx5GsfZhHWDQBdXEOqsOkXG5OGrpcKDNTg9nziPaZh5AimypAw2oM9ndfioICOxJbbaOLDwyecJD46CT81ptp811vV+Nf96YLfJhRIDWq0XwpDFbD7ndlv94tgAlZVOSODbe/DfUFta9019doA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFaTFABGZHK8k7VwH8ha1wo2Elkub0uZ9+jPu+SRBdQ=;
 b=uK5Z/iLd4CYzvuJCHr1JkJqA4lIciINekMfFMgph8yjKGz4KdM8vrKsSmCeZ7whNdrJq3SYYJq0LzBQRJnv89LEO6WEckDmpt11kSjUF8c5VmOUx2ewdGfytpwpLYW+x90XxZP8rYcsx2sIiBeSiF3jpBtw6wlaGjCSG9U3ZvbM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2686.eurprd08.prod.outlook.com (2603:10a6:802:18::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Sat, 26 Sep
 2020 13:19:17 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%8]) with mapi id 15.20.3412.025; Sat, 26 Sep 2020
 13:19:17 +0000
Subject: Re: [PATCH 2/3] nbd: Add new qemu:allocation-depth metacontext
To: "Richard W.M. Jones" <rjones@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200925203249.155705-1-eblake@redhat.com>
 <20200925203249.155705-3-eblake@redhat.com>
 <20200926073308.GV3888@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5df4a257-8275-05e9-a3a5-769a432b2760@virtuozzo.com>
Date: Sat, 26 Sep 2020 16:19:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200926073308.GV3888@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0142.eurprd04.prod.outlook.com
 (2603:10a6:208:55::47) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM0PR04CA0142.eurprd04.prod.outlook.com (2603:10a6:208:55::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.23 via Frontend Transport; Sat, 26 Sep 2020 13:19:16 +0000
X-Originating-IP: [185.215.60.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f066425-cadb-4d8c-35ee-08d8621ec52d
X-MS-TrafficTypeDiagnostic: VI1PR08MB2686:
X-Microsoft-Antispam-PRVS: <VI1PR08MB2686817A4E0EBCDC2AE829CFC1370@VI1PR08MB2686.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfQZYrI7xsA+rEwmJQns+9nOXNaFH1Q03hbI34cDG9DFqopqIQPtmhwYeMwOjbAID3meoUvHPw0ApqMv77GNG9M8XRu9IcxRNUnv7fthKBldCDBJcD63QOcdX1GEdoroQsQErjtm6ZHwkmM54XtqihrEgNIAQj1bkWZF7/KAoBKwsFhk9vjHy520yeNG6xYPg59WSFbEaJHocAfwlQjgpWGvzu1eHggIMvBXvNl4S1+OTqww2+AUSKm9jxYCC+Q9y1wZ3uMERGJ08hw4h8Yk/HRqg6a59nu06uvkDT4LMPR6ZGEHz27t6Is8YMNyKl924hu+JXinj2OFPMoESUvX/9PAeBTqO8hT/zkr6OKjMS5e21g9EmnToE+AnQ6Q/q4keR60WkYxWp+MjD+J6vyb6VYjrGBAyhTIy0Jmi0qtrgiAUQrvXWpTBbxVWEkOY33q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(136003)(346002)(396003)(376002)(186003)(52116002)(16576012)(316002)(31696002)(54906003)(110136005)(956004)(2616005)(6486002)(86362001)(478600001)(31686004)(26005)(16526019)(4326008)(83380400001)(5660300002)(2906002)(36756003)(66556008)(66476007)(8936002)(8676002)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: m8lM12EEUzU9yfnlrVJdJN+n4PYwWgq/kiqqgJm/IuepGYAeyS+tVCnCLgpcZAl9+6Q/nOQuzr8HAAfDeh9K42uzmPaZsiiAwe1ClCJ9gIuZAcdjRYhJmNmFIt/mDgrUEhqWYogG7FGCr+zjX4xYiVcVRN+8WSwSBwk8ej/OV8mqjP0fyQ6wFMDA+cpjBmmKE/Q/vhP3ewEzF+AiYoBqlI2UvqXIy7F+vwmyxi+j2t0nN7GH3JkNnJEZDlhFR253YlZsAOo5bMvdQM1ZcqA7uxjZl5qXB303UIN6EsJuYoqqZTtgcZlqhlPsyWdNLEeqhhrDTyYnXnucVpHsVtZ1SpRxGtsvz1+GaCaHp3ItWcoNHvFrXqBuy2BQQY4tIW6FNnO+Rh264XD4r3WssKhayMhHqIAQKSowzsJKLgids9ajk1fdJ24bgaQyEynV3yt2ZJ6Db2Cc7i2w6Og7cnnluWrq44jwBGDXy2GD5fp/QIIKfJskJFHEPhhHN5026+x8gmBDsZT0VxnxCEpAczQVGODTWRFL27saUiQgrWbzEWxMPgrzBb9zRm1BMpRUUtlYXi9qMhQ9I9zCizIeP9P6fyIu8K4IZzMS6YpWSRfiT7F4F0tBlvD5aG7Hd4hBzxUHPz7m4kpSmKKKBdPpjnWx5A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f066425-cadb-4d8c-35ee-08d8621ec52d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2020 13:19:17.0297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaAACn9qaS877XRyIWNyAOuhHa8kJzvtnezX/YvlMApp4YDyAN0e2BXn6qW48bHH52lRer4uRuGxmm2s0tObH4tNcijlB7dSuxkyPaeIZyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2686
Received-SPF: pass client-ip=40.107.8.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 09:19:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.213, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

26.09.2020 10:33, Richard W.M. Jones wrote:
> On Fri, Sep 25, 2020 at 03:32:48PM -0500, Eric Blake wrote:
>> +The second is related to exposing the source of various extents within
>> +the image, with a single context named:
>> +
>> +    qemu:allocation-depth
>> +
>> +In the allocation depth context, bits 0 and 1 form a tri-state value:
>> +
>> +    bits 0-1 clear: NBD_STATE_DEPTH_UNALLOC, means the extent is unallocated
>> +    bit 0 set: NBD_STATE_DEPTH_LOCAL, the extent is allocated in this image
>> +    bit 1 set: NBD_STATE_DEPTH_BACKING, the extent is inherited from a
>> +               backing layer
> 
>  From the cover description I imagined it would show the actual depth, ie:
> 
>           top -> backing -> backing -> backing
>   depth:   1        2         3   ....          (0 = unallocated)
> 
> I wonder if that is possible?  (Perhaps there's something I don't
> understand here.)
> 
That's possible if we want it. Probably the best way is to add *depth parameter to bdrv_is_allocated_above (and better on top of my "[PATCH v7 0/5] fix & merge block_status_above and is_allocated_above")


-- 
Best regards,
Vladimir

