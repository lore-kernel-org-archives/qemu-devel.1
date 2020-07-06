Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5F0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D55D20724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="o49UeugI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D55D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsNLR-0006m8-Pb
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 05:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsNFh-00048b-6Y; Mon, 06 Jul 2020 05:17:29 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:26279 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsNFd-0005Ys-V9; Mon, 06 Jul 2020 05:17:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Jtb03qvMKuQKqzjur7krcG3Zq4x5n3jE5bkRmSyrHIj4GCV2CQUUpvwGdT3xhqnJOLyfxCDnmeBjGoSF22PcLSeyEVK2kWyxjJFSpmG4qthKKl+bY848UA65e/3KLFttBJSdYcIXSnQtqR2G9GZhE7qxrmOxAe4oQ/89V3wI4RMg+oBys0KU5nR/gU410pz7+gg7ms50W9WopSvDbHgCRifwxT5xWZF3y/LdqPjLbxQOSOLUHT4Y8OuuIF4j8Gi8RbOOzlqXV3yrqcrcNZL7lRtmtzRDKeGbrzmdG4Ci2mQHUmWXD83KlgD0CRXG01k66YytbtSK80sQ0t0moMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/IytYFuaRtYIDVw8EQDfhXGqnZkHFkyvhIUXSAUEBc=;
 b=a5sZE/EteibrSo9iMJ9CGKpm4CsUJs3sLh3FBmnQhX/sH5NB7+rirDl4jUBGwi1Wwh99yfLwbBmm9sSMdr7hEOA9OAvNaQ5082M+W7Y3/+AveU2OpVTMiQgJzYmltAPztFEVPyzuIA1gyybshVdn8zZWqvU3aQ/U5LeOz13Q3enVRancCJW55skYh5yYQ0C4xOyB65w3Y+2/AnsRkke40t3CQe03c1gor2Ki05nqp/grXs/B/5FtNyd59PM025WD14MGIr3Yoa0GE4z7xQwNJWonnhR0+vwVYMPY25zaBmnBrtTEJbRrXfQgGQOYOfOjJytxUHlwOLil276dT+4OKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/IytYFuaRtYIDVw8EQDfhXGqnZkHFkyvhIUXSAUEBc=;
 b=o49UeugIph9XQ/39P3tQ66KT8tJr2qp6ZImn5HgSDJZ/LxXpelAWe8/PqgYXwL8mNB9AYdhXqRm5t0aFjSyOXdw59lFh3VTJS7YrhI6jUxVv2icHE9Y7TKFRwYAZp5fv1qeAeZ4CzMD6eqKKAW9P0y717eMBaq6O13DvCLTW3ME=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4279.eurprd08.prod.outlook.com (2603:10a6:20b:bb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 09:17:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 09:17:22 +0000
Subject: Re: [PATCH v3 04/10] block/vpc: return ZERO block-status when
 appropriate
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200528094405.145708-1-vsementsov@virtuozzo.com>
 <20200528094405.145708-5-vsementsov@virtuozzo.com>
 <3b1bd97d-364e-2a7f-0013-853c89a1723e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b24c2d48-f57d-7a08-839e-ee441e91245b@virtuozzo.com>
Date: Mon, 6 Jul 2020 12:17:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3b1bd97d-364e-2a7f-0013-853c89a1723e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR03CA0067.eurprd03.prod.outlook.com
 (2603:10a6:207:5::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.58) by
 AM3PR03CA0067.eurprd03.prod.outlook.com (2603:10a6:207:5::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Mon, 6 Jul 2020 09:17:21 +0000
X-Originating-IP: [185.215.60.58]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffdbbbf0-e5aa-4c10-50d0-08d8218d63cb
X-MS-TrafficTypeDiagnostic: AM6PR08MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4279D80561851EF93B958F22C1690@AM6PR08MB4279.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ieESrGdfknx80/Vt2/RutJ/M6Wvz3a/4MJyFlfuRiPDSOpxolokJF5fVqsZhfoqe+pWA0WOhBySmaNPgAMG/yeS0GMWjyETIzSEzTV0QEL5FbdpReRqUY+Fi5BmDbxZLJBlXRFN7vB25C2UtxuScs2CuXJ4jvYmmxPRf1k+Bqi/q3pv5KsMyKSFJEi4UNqVFbzTMc52vBr2zSbb6JZKYNjH3dk6r955seHDhmenZiouveJPgpknE7O97IGgdi17vBJ4O3b5Nyh4dhjvYRxdNZ5Mig2DmDyp1/tPfYDxbjbtuGsukDyJK61di1JXFWWhtcaFoQTYyh6PyWAgv7xGjnK0NalS5mfK7D6ABizRnhHZx/CnhVipJcsPaE3ScdFeu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(39830400003)(346002)(136003)(478600001)(83380400001)(8676002)(31696002)(6486002)(2906002)(66556008)(36756003)(2616005)(66476007)(956004)(16526019)(5660300002)(186003)(53546011)(86362001)(31686004)(7416002)(66946007)(4326008)(52116002)(8936002)(16576012)(26005)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hvpJFp+Zi16OsJNqLKEv3hVp17HFFIKfBL/wR7fkmxDJCXC9L5dW0K+RD0QrX+zwqGwWQaKgf1WYESCzbW5mGzkKOfkQh1LWoQP95hp+02O7qCdd8N0XMDffhud963W+Cg+i0roBGBtcWz7C4LUQDxzXch846oBItn9Eng6t1ufNym+mWtOPolcdu1TxdKZX4IDqaNGLZ8ZL0y2fCs99ZK8gEVA2jAxhVYXvJTQ9q/DRCJ1HAjQlB3FEOp/czswipG3WtOeewhXuIkV//zgJRDveoBZPQoZR656jSjuo4fIAAx3CRkDdKQgury1xYT36A/JypC3x2AaAkLR4soPsCUKXdNvR2fB/+HRu7WWRUnnAy3VLvXhnU+piYJ+ZOhbsaIYDiDVOiM+uaHuqeMYgX01VE2qWSlS8nCbqsdICWM7Xosc3TR0bI/ooP6h9rZRzEakRlvtHYPHO5KIhtpEEZ/MwIFos88KHpDD7q1DOE+M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdbbbf0-e5aa-4c10-50d0-08d8218d63cb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 09:17:22.2743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCROluANJr9byfa7Iktkw3UuBU66VuGy9ToQ4lM0jScqljhYIFdsDioyVKIMXwcRlHkbE+k0FeNxpaj02FznusYQZPYpounTZKUt1eHbagw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4279
Received-SPF: pass client-ip=40.107.4.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 05:17:23
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

06.07.2020 11:28, Max Reitz wrote:
> On 28.05.20 11:43, Vladimir Sementsov-Ogievskiy wrote:
>> In case when get_image_offset() returns -1, we do zero out the
>> corresponding chunk of qiov. So, this should be reported as ZERO.
>>
>> Note that this changes visible output of "qemu-img map --output=json"
>> and "qemu-io -c map" commands. For qemu-img map, the change is obvious:
>> we just mark as zero what is really zero. For qemu-io it's less
>> obvious: what was unallocated now is allocated.
>>
>> There is an inconsistency in understanding of unallocated regions in
>> Qemu: backing-supporting format-drivers return 0 block-status to report
>> go-to-backing logic for this area. Some protocol-drivers (iscsi) return
>> 0 to report fs-unallocated-non-zero status (i.e., don't occupy space on
>> disk, read result is undefined).
>>
>> BDRV_BLOCK_ALLOCATED is defined as something more close to
>> go-to-backing logic. Still it is calculated as ZERO | DATA, so 0 from
>> iscsi is treated as unallocated. It doesn't influence backing-chain
>> behavior, as iscsi can't have backing file. But it does influence
>> "qemu-io -c map".
>>
>> We should solve this inconsistency at some future point. Now, let's
>> just make backing-not-supporting format drivers (vdi in the previous
>> patch and vpc now) to behave more like backing-supporting drivers
>> and not report 0 block-status. More over, returning ZERO status is
>> absolutely valid thing, and again, corresponds to how the other
>> format-drivers (backing-supporting) work.
>>
>> After block-status update, it never reports 0, so setting
>> unallocated_blocks_are_zero doesn't make sense (as the only user of it
>> is bdrv_co_block_status and it checks unallocated_blocks_are_zero only
>> for unallocated areas). Drop it.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/vpc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> This breaks iotest 146, I’m afraid.  Now everything is reported as
> allocated, which is of course what we kind of want, but I suppose it
> renders the test a bit useless.
> 
> It seems to me like the best thing to do would be to replace the
> “qemu-io -o $opts -c map” calls by
> “qemu-img map --output=json --image-opts $opts”, so that we get
> “zero: true” instead of “not allocated” in the output.
> 
> A bit of a problem with that approach are the “allocated” entries,
> because those are split into 2 MB chunks, so the output gets long.  But,
> well.
> 
> I’ve attached a diff to that effect.  Would you be OK with squashing
> that in?

Yes, this looks reasonable, thanks a lot!


-- 
Best regards,
Vladimir

