Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DD4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53EB208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b+wH+1G8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53EB208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMZu-0006Wb-Uf
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeMZF-00065w-6a; Thu, 28 May 2020 13:43:45 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:18882 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeMZC-0002Le-4t; Thu, 28 May 2020 13:43:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW2VdFqNKRks0CM9HyqyWDclK9tRWZ+dkKTCsC4/dRvsGBLT+voc6surx4mtWG26kIM/TIdCFEyiDNBO4t9B4uK+EvWrhkBjTyxNs+c4nu1XYOrBAkweRiJ6LjE0ukurrbrIg2viVb7CjdMJOvKIwXfO4C107Mudn/tWSV7kWKnkm5xXQVYJmO7V5XxRtXBf+6XvO2xUvMtZsZ27fzl1mP86apCKeCEMs0kxKy+0OmjaagrHC1wH3myukFFq/qK8eJFvvXTgMvOHTEvWIQlXJPuMNkWJ2zU4eHsLDJNeUPLvUt5E6U4pxGcLt6f4SZqNItHYInM54WqJv1XCAsg6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqibtgBM/+dL9J9YrtxMjfzPintzrFinQyVo/XyDDsY=;
 b=LvhrfWm3MYf6P4UCIBn2axUxD6GQ45VResTyuWBsLVr/V9PQTnmGnMVA0B5u8y7n//ziFInr/g4Ohc13A6mJJnZcQCQetP5v5xOzZwgdonP0elUl1XPhV3bICiMm/XhAuDMXd6gsccbIRkQ1PtbP1w2vwELWbCnHpIiCQsrJguLA++tvsPJ/GvTalO8daPfGZptSQ5I4/vmv/7/8mdP6zC82deI2/yOVxHmldeaaX/HbkRa8jRpCVNOQWtKuUJbDBzlMiYOmHpK5BRbNwpkyafvDtGoV9G/f+HOcYsJI2xM/7Fn3Ij9OfwGGKntoCTwkL2CFtOx1SPbzAcMpMfnGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqibtgBM/+dL9J9YrtxMjfzPintzrFinQyVo/XyDDsY=;
 b=b+wH+1G8L2qQGzzB9rwKiMsQ9QohqHF6AeV2xtIpp2G/QwgkfHnTNZmiOvvOxqeHxgLzFkX1VhQyYGotc90F/az7iDaeXn/mspwDchwp15PnwBWwMA9o+k/tnyHRV4DiqcrwY4eLV/mZ0FuJIAWYWzYmbPO4ORjO+wKturswIXE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5477.eurprd08.prod.outlook.com (2603:10a6:20b:10f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Thu, 28 May
 2020 17:43:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 17:43:38 +0000
Subject: Re: [PATCH v4 0/5] fix & merge block_status_above and
 is_allocated_above
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200528101507.151161-1-vsementsov@virtuozzo.com>
 <20200528170935.GA163714@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d8eb8520-cf68-9f73-a9ce-18a041d29991@virtuozzo.com>
Date: Thu, 28 May 2020 20:43:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200528170935.GA163714@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:208:122::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:208:122::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend
 Transport; Thu, 28 May 2020 17:43:37 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c57a9545-e32d-49d9-8032-08d8032ea74e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5477419D44DFE1918382B767C18E0@AM7PR08MB5477.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r//t5iISZ37lHPZI9XwZnfHcjfB5/9gI2H/dCKT182Pj89mriAqS3Gtt+HpC+E8sD+c2jGPPj2OcKHja54PZAeaCd6rmMt9aO/sR/ywBSFLwVkTlKqLGzD5mHSExoLAdT/9/3HGM1lmEgtCxFUxAlD7KThdE4ZGNFy1ASOGdb3ErBbwFQfcZIgF3KjTeNVZYq4DrBHAPAP1LZtI3FT6edazw3N9vPcfQBKeM1EFLTRlXshtnkPmDvsjPqG1QtE5Q3jFeVql7r9ItPhT6ZAHbF5xEgnF/p9a78mn9ILJrJOugw2WCzyr6P0W+uXknw6k5/FDLW+jzEKXO6eo3iyPHnIIquPh1v7BDCxnL9hCr4L52ZuizBelRWI7nbqyJtt0EDSnOJReTPMab7l+3JIgWNTeLDDD4fx7KL1qtfgPr75J6SodmEX8Ztx8qAF62AJK4ktg+kydzlB4HbqFnQul25Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39840400004)(956004)(2616005)(26005)(6486002)(966005)(31696002)(107886003)(4326008)(478600001)(16576012)(2906002)(66476007)(66556008)(31686004)(66946007)(16526019)(186003)(36756003)(5660300002)(86362001)(83380400001)(6916009)(52116002)(8676002)(8936002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: f57WVGLfv6Dad932Az4Gp9uakCoiSqkADAhvOrhzb4zeTL2PPjzZAWgwTukAjPt3ft9xYKNkbky8eIU0Wb5akY9VR0Wy0qvGdfVpO84zoU+hcSojRkfcfnoaCsC9uvaIhsiPkRW33YLtpuGGSU8e3OaPRaHB3B3nay85IdQlNI4Xagy2d2zZzBr0VY8SykCLlXEEx5J7GyzvXv/DPW1NjLI70rsUXb6ZU+bjcaDzQrY/MvkqxlbtUZdnFWKiMFQTeKfQYfabrKmLkVW149LDEgbp7yr4qaNeBPXb5EAOjmvBWTxSx7/PKIgqxp5QZsWbDMDJSYYryerPtV4rTaNEs1pbN5mkisT+FwrQ8PkWQ8ppXN6bEYZzYCr/xBvvYwCzMfEjYBZz19pa0jLaHJwGQWVHeNBMf6QFK4BIkQ2sEH+kcUBNwnomdipm3QN2QcJElUPhwrbPf0YesJS13YRYBn6mx/+aENdgg8C3uWg7DlwgR9fZ+MTm6TLeLauvo9AN
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57a9545-e32d-49d9-8032-08d8032ea74e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 17:43:38.4518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2plPeTRtNsnVg+Np6YwVXfdmdwXTe2udPI34BcTC7DHlymfspFjZkqirAbH/qrUWiBwX4ncMXoughjkRlrng5A5GFGFteede/8ucMOq90g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5477
Received-SPF: pass client-ip=40.107.7.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 13:43:39
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.05.2020 20:09, Stefan Hajnoczi wrote:
> On Thu, May 28, 2020 at 01:15:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Thanks to Eric, the whole series is reviewed now!
>>
>> v4:
>> 01: fix grammar in comment, add Eric's r-b
>> 02-05: add Eric's r-b
>>
>> Hi all!
>>
>> These series are here to address the following problem:
>> block-status-above functions may consider space after EOF of
>> intermediate backing files as unallocated, which is wrong, as these
>> backing files are the reason of producing zeroes, we never go further by
>> backing chain after a short backing file. So, if such short-backing file
>> is _inside_ requested sub-chain of the backing chain, we should never
>> report space after its EOF as unallocated.
>>
>> See patches 01,04,05 for details.
>>
>> Note, that this series leaves for another day the general problem
>> around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
>> vs go-to-backing.
>> Audit for this problem is done here:
>> "backing chain & block status & filters"
>> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html
>> And I'm going to prepare series to address this problem.
>>
>> Also, get_block_status func have same disease, but remains unfixed here:
>> I want to make separate series for it, as it need some more refactoring,
>> which should be based on series
>> "[PATCH v5 0/7] coroutines: generate wrapper code"
>>
>> Vladimir Sementsov-Ogievskiy (5):
>>    block/io: fix bdrv_co_block_status_above
>>    block/io: bdrv_common_block_status_above: support include_base
>>    block/io: bdrv_common_block_status_above: support bs == base
>>    block/io: fix bdrv_is_allocated_above
>>    iotests: add commit top->base cases to 274
>>
>>   block/io.c                 | 105 +++++++++++++++++++------------------
>>   block/qcow2.c              |  16 +++++-
>>   tests/qemu-iotests/274     |  20 +++++++
>>   tests/qemu-iotests/274.out |  65 +++++++++++++++++++++++
>>   4 files changed, 152 insertions(+), 54 deletions(-)
> 
> Hi Vladimir,
> Which series is this based on? It does not apply. Is there a dependency
> on the coroutine wrappers series?
> 
> Aside from the issue applying the patches this series looks good to me.
> 

It's on current master. Yes it conflicts with coroutine wrappers.

Still, actually, "[PATCH v3] block: Factor out bdrv_run_co()" was substituted
by "[PATCH v5 0/7] coroutines: generate wrapper code", which is partly reviewed.
Sorry, I should have answered on "Factor out bdrv_run_co()" about that. Actually,
it was mentioned in "[PATCH v2] block: Factor out bdrv_run_co()", I just posted
v3 too early.

So, I'd prefer to merge these series now about block-status, instead of
"[PATCH v3] block: Factor out bdrv_run_co()", and then I'll rebase
"[PATCH v5 0/7] coroutines: generate wrapper code"


-- 
Best regards,
Vladimir

