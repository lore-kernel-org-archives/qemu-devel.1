Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D49C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C48206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HJ+qNabP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C48206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQ8B-0001nf-1v
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrQ73-00011H-19; Fri, 03 Jul 2020 14:08:37 -0400
Received: from mail-eopbgr10094.outbound.protection.outlook.com
 ([40.107.1.94]:15525 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrQ71-0005vk-3f; Fri, 03 Jul 2020 14:08:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl8esQEklFqcveEiJ4LLuKFGabk19sKZB6J6fQcXuMVpqN+3usOjQA5sdOpnaXO4tpP5Ev5Z2/jGHaNzSjhiGG4ZAlDQabEF9xzqlKGG+rqVld0fDl9MxO8QztSS1tjdn5Re1aQCqjTpwGu9dbWHjI0tn2/VAFx7Xzf/9tfSDzpIT4mc++HOFTy8RXu3ttEzJLirOhiZn22vSLreG00rdSJ3B5npvprMm1stvAYiOS/Q3JPd8qNdKR3kPeKsUYPDclxJY/s14LCmhTZjSXiAI0SfIh20+8MQ2AbtqhcqlQR2YEUSsHCnHxJHNcJD42SYwKVJWaSxPVOoRVMEKMusFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BRxcqyhfN4BFMHbaxxA1LSgeTBDZ/YsKJVHB40GJXI=;
 b=VZNOZZtzbUhooQ598RfewxBc3H5PqiI5U9yk5oSA/ZsAC6jK/8/dPmPIPwbDRBfe1uG/9pA7UTezCN+qMAO5LJF3BoMAB0xQrvLcHrTKLvekVO0GzO8/ZYn2sYztsWlsw5d+YaN7fikv7KgISXK/qnPB2TWZPpagAh9pYe2f2CYeQlXmX2h4ZKLgdAYZFscTTCvFZV3v5lzhsRl1pRImkU0bEEHP1yqGx9w1lJThH0Fi+/R8PUPLqkESew4aYT5B7rXdKl6WrFniKHyNvrmGLmOjb7JmHoR4VittiZ5xtkCj68rfmyIk8dtAwsiJ8JkTmY8aF36yVIYlvdWbyGmuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BRxcqyhfN4BFMHbaxxA1LSgeTBDZ/YsKJVHB40GJXI=;
 b=HJ+qNabPTRutBgp1riy7ld+14naPKs+NjyqzlAO9U1ECHGV7HrvQpjOKpuAuwoMpqT2E5CANZ/e/gnP65Btl3z4V+NLBy36KZ4K5hu5YNbnGZMj8fwwqWoAirC9L3tFaDMe6Cd2TEnJKkTmE0rxhVFK1Lvjrk9JcZMGPfK4d/hk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2685.eurprd08.prod.outlook.com (2603:10a6:802:1d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 18:08:31 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3131.036; Fri, 3 Jul 2020
 18:08:30 +0000
Subject: Re: [PATCH v3 00/10] drop unallocated_blocks_are_zero
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200528094405.145708-1-vsementsov@virtuozzo.com>
 <68480ac0-8186-4dd1-86c9-2789f85f3e3a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <15511ebf-656f-1d56-3ba7-284daccc81a2@virtuozzo.com>
Date: Fri, 3 Jul 2020 21:08:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <68480ac0-8186-4dd1-86c9-2789f85f3e3a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0501CA0056.eurprd05.prod.outlook.com
 (2603:10a6:200:68::24) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM4PR0501CA0056.eurprd05.prod.outlook.com (2603:10a6:200:68::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Fri, 3 Jul 2020 18:08:28 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5038e3e-6f19-46ee-0c61-08d81f7c1741
X-MS-TrafficTypeDiagnostic: VI1PR08MB2685:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB26855A873D5C1B8065ADA572C16A0@VI1PR08MB2685.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DMJH/4x1Q0JWj6gxYuZ6Bl5UuTS5tpJ1wYTLYHBOMTKrgLTZ8Bc321iUQlNbeVMUZ5vxvppu2mjk9BhyA0YAlRDkcIXBp8397EXbd81Hz96dqlBugzkWY+5p+jNwmgvZD82KV8DRpN34M3+QXskJE/TpEr/ZSBepvGB/4hicxuy6uWey12aCzxO1R5slITOjSvz60J0Ou4U5fECR49427n3ts0AdQCy0koVyFRgGyXQgm38PFKKUfjle78MxDYDdFZSayy2kY0VeuEqzT/S+SfW5tePUntj0L4SpWVwb7BTIiuO/iVwZqDlLbUoa3XHt/xnfSlue85sp2mBO8ga51aRO7y48fVIxBxIsyxGCL7ULAUlDv0wkWQufm0W+HrnI02V1MjI4BiQmGWAA+ad8ZBiTLBqm5KnnbSthvR7+ZXPmCrwcbiuI6XaJk+oEeerYQv2ZhlolN7qyV4H2/DtYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39850400004)(346002)(136003)(376002)(31686004)(36756003)(52116002)(316002)(31696002)(83380400001)(7416002)(26005)(4326008)(8936002)(16526019)(86362001)(2616005)(956004)(2906002)(5660300002)(186003)(478600001)(66556008)(66476007)(66946007)(16576012)(6486002)(4744005)(8676002)(966005)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EvnAiKI6y5GbmSKmOmbSUpC9MhVgRkq3lNy6NUF94KSs96H88NcbFUJNseUlgLrQq8lMWnMzGfIjXveFmG+mGKnb3f2WkdeqB6NLItQ0JI8jBvhH68AfxDgoG2WYZg0ZXuaBL0hMujkPdnhNiRznBJUna2rSfA5JVFwgiIM8xTsj4R7lE8+ziI/LW9yOfC1fWoQj1KlxNJ9f2hDudaU6xchfIZV58imbxLcBqeSQFKYziKMOX6wYqRiHxNg+/G0TGACmwoYhIsbOut1dtgFQgWE2tIdcpH1f1GggEpFmkTYmvn4nEZGOPNEIeasPOEkSe9RexRHYauqAW4GyNUGxrYslVvN0AfWBXNQRinxGV6Lm+dPOKG/aYDZAA8o/QVisocLtwuy28u09D9zpRqXh8T/MLOja1uHpxBuyx0jpsiWRAf2lGpxjjVwQLxqWma6XCfQ8AkUFmiNdViqcp69f47qln+rFzQXoCPx3VkHMo5e13fA9BkH7xRWgY+HlVXZf
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5038e3e-6f19-46ee-0c61-08d81f7c1741
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 18:08:30.2436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4T6i0cri2/shRTzZmtVzoY/7MHmC8/HuijaHx/E10lLbg6ee5nP/8sSUClhHKaf7mG2eFVt0ZJPaTJTIhiIN77XUzVWZarzduXlO+rYfBZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2685
Received-SPF: pass client-ip=40.107.1.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 14:08:32
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
Cc: kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, codyprime@gmail.com,
 sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.07.2020 17:06, Max Reitz wrote:
> On 28.05.20 11:43, Vladimir Sementsov-Ogievskiy wrote:
>> This is first step to block-status refactoring, and solves most simple
>> problem mentioned in my investigation of block-status described in
>> the thread "backing chain & block status & filters":
>>    https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html
>>
>> The whole series is reviewed, let's proceed with it please!
>>
>> v3: rebase on master
>> 02: grammar fix in commit msg, add Eric's r-b
>> 03,04,09: add Eric's r-b
>> 10: add my r-b
> 
> Thanks, applied to my block branch:
> 
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
> 

Thanks!

-- 
Best regards,
Vladimir

