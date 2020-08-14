Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD65AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A0320771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mq7Ghg3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A0320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6e3z-0000WE-Ie
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6e23-0006B7-ND; Fri, 14 Aug 2020 14:02:24 -0400
Received: from mail-vi1eur05on2096.outbound.protection.outlook.com
 ([40.107.21.96]:49696 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6e1z-0003pN-Dn; Fri, 14 Aug 2020 14:02:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+KQtHc5B/bEUN6pt3rqLTP8xlns1k4dKEHzVRN9tbMIXOBKjl52z9n5JwOyLwXE4d72S4jPqJb37wSMXG9ckF4asju7lldoOa6BWM6zhHJv6EFzydd5+QQn+39iqGHgr1FBYwGH/K1S0cORhf3dlHXq1Yc3XzGYnLGC0yA1XnrAXtZaUGe4d3HUXJmtCiz10g/FLxPRChTDVg6wgXGFQ/qWuA0V9x6xCY6N3pFyYWB659AhQOjGqU6aHNmx7kNzU63C7GsAzX/sxvTfor8Mv16mBYI4CMZN36+i0qs6GkoOnTefyg76puI1k31U43Rurdf8qlLaX0YrLncWGlaljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZgeV2lwkbbrTRyknpbB0T9t6v9jsxtl2IRG6i4F4/k=;
 b=ZZqY9JzXdrFZk/5Q+R1D4d2wcKsXAJETa3xTDDWPvjJSYK2AAdbQGhY0iA4i/PzGKvR66AQErUIRerPK9yAUge40I9vx008pAUlb5IkfJux9cbdeGNIvwEbsBgGnovfUrLcwenWYyBy5Gs+Bw6aQBnBpA9j6iN/45EEjUxqvdVlxCqh4PKCLU4VaEtPpXXf2hAJHZHxhL5xA6rZDD/39/55fAdwTrJv3J1DIVfTaWVqVfEZhDqjwuWYXHfBFm9awanop0rWpnyksb4tzwCc0rwYNSLTAe/t3aS4+HXvui8Xxh2tbOuLwSveg785OOhXTIATnL2OVP4R845/CeFM3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZgeV2lwkbbrTRyknpbB0T9t6v9jsxtl2IRG6i4F4/k=;
 b=mq7Ghg3VnI7ELm4K0hR5ddbwtp1t0E5qzbvS9SjoQ73FQb6OshyfNbgWTudZhN+OmyLyuWdzzXeopAlmrsXZc7bInGulUpwrwLVmRnP61fbWH1ODckQQzsykKiiZqIJcTKeWkfsHoJzmUz6QfBlLupcv+YO4SKdWP4RpYhPfc4c=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5077.eurprd08.prod.outlook.com (2603:10a6:20b:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Fri, 14 Aug
 2020 18:02:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 18:02:09 +0000
Subject: Re: [PATCH v5 0/5] fix & merge block_status_above and
 is_allocated_above
To: qemu-block@nongnu.org
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7fded805-d8d2-5104-2330-2cdefe154c06@virtuozzo.com>
Date: Fri, 14 Aug 2020 21:02:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200610120426.12826-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0077.eurprd07.prod.outlook.com
 (2603:10a6:207:6::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.177) by
 AM3PR07CA0077.eurprd07.prod.outlook.com (2603:10a6:207:6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Fri, 14 Aug 2020 18:02:09 +0000
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26723590-43f1-4f03-4e8b-08d8407c29ef
X-MS-TrafficTypeDiagnostic: AM6PR08MB5077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5077B60F5023BBBD9B7EC398C1400@AM6PR08MB5077.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQf0+t3rvBgl1WIsnb/84iz8hKNAu7DMB52BMrEkhGCe23rnS/Lor266J/XfFzBfiK5HoFFs6gpQ8KgB8qYVKRK2vyY9f3ORfPSDGhV3sOtdX+NlSel2hF98YzkwxiEs9gUzNnaAjC4U8iremqK/gukEHz6gL1mFTI4zeBgpC/FOGUoYoW613ZOaGEZFbLHbHAaA4GcHa+wX/v0/FMXOEylW7YItGiPR/HPpYFI4G4b/5rko+grSgCTjCmJ8KfApiOAAiVbTySdTdg11D3zN2LZCWIlyN6mUTxEO9kChbB0MvGT0uUdrAcqoVC5yEMC4bVK21JSKPL1cjfbcZ1LKOVuXpqzzsf6ckDAvT1/mgHzjdvkFnb25k6Dn7tUxrXSgRQcbBtuKpMF4kC9vgZtm2Tp/sbtpB21ADjmOyf1CVzPV0+jzG2MjQ22y6pzNedOAnyYWbcUrB1ejsPnQ5lDfJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39840400004)(31686004)(16576012)(316002)(52116002)(6486002)(86362001)(31696002)(107886003)(4326008)(83380400001)(966005)(2906002)(478600001)(66476007)(66556008)(66946007)(36756003)(16526019)(5660300002)(6916009)(956004)(8676002)(2616005)(8936002)(26005)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: A6pGvunEiYyMguy4MhY+xxZ9KcLPeTWnQu+M1EEofDiU4Q4WwfRUykbX1hoQz12gC2Tf9cG8GhyeWHUkEeJoJsipRswD4jTBkVQVK5mLxzpkcxSzRnHi81yYjKvSBW13Y++igKOZLpYldx87Yn4f7Obgwo35WTuguNGHVZZgA1NRB8bDP5dChLZY3M7zIXQ8T6H9LwWVyu0NdSGRBI+Tdr0cgbZJYPOMAcRT8z0wp4iof1kATsdjaqgb64Wwsl45AkpYMQAAb2f0fFK7VPm0RX1JyrJfpuFe4j4li5jRkmGkMAu0T9ZexJetx+kgxbFGsmFUmp7cp5nXQbVm2Oam8sFL7OZQAHh8uBqK6Dywa5JRmz2PnPV75/gJxaXFK+44uhAeK/95QLrmskSUSmiLWeGONXufRbSsBPTcVvg3KSksqNPRx25vX1owu1vOnocqhjNsBXpOs0k9in35T4yApgsS81ZsIY02j0X23ZrUcmGMIL3CpKqUAT93lwa56ZzP2dDsrN30ATbAP6+9TRENSb2Mi9DtNtWkh4lSF+/UWEXwRXmabTW+xQCoJaovKCYwy/+rmnOt6uJhMWrvS8+O4/cp8txO0FEdtfde9xzRUIdM1CHMfr7FkmFIKQnCTzssAaBPybx8yTSLJhyghK/03A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26723590-43f1-4f03-4e8b-08d8407c29ef
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 18:02:09.8796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUkaUY+1O0sUmKrhouARsgvxnUk2u+5MMwCqKM4ajki8srHIpbg0Wjsqx9zZSnPsE83hcIPauJeg1oPpvPUhGAs2vJ5Rn2ANGaZWbjIokZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5077
Received-SPF: pass client-ip=40.107.21.96;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 14:02:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping :)

10.06.2020 15:04, Vladimir Sementsov-Ogievskiy wrote:
> v5: rebase on coroutine-wrappers series, 02 changed correspondingly
> 
> Based on series "[PATCH v7 0/7] coroutines: generate wrapper code", or
> in other words:
> Based-on: <20200610100336.23451-1-vsementsov@virtuozzo.com>
> 
> Hi all!
> 
> These series are here to address the following problem:
> block-status-above functions may consider space after EOF of
> intermediate backing files as unallocated, which is wrong, as these
> backing files are the reason of producing zeroes, we never go further by
> backing chain after a short backing file. So, if such short-backing file
> is _inside_ requested sub-chain of the backing chain, we should never
> report space after its EOF as unallocated.
> 
> See patches 01,04,05 for details.
> 
> Note, that this series leaves for another day the general problem
> around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
> vs go-to-backing.
> Audit for this problem is done here:
> "backing chain & block status & filters"
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html
> And I'm going to prepare series to address this problem.
> 
> Also, get_block_status func have same disease, but remains unfixed here:
> I want to make separate series for it, as it need some more refactoring,
> which should be based on series
> "[PATCH v5 0/7] coroutines: generate wrapper code"
> 
> Vladimir Sementsov-Ogievskiy (5):
>    block/io: fix bdrv_co_block_status_above
>    block/io: bdrv_common_block_status_above: support include_base
>    block/io: bdrv_common_block_status_above: support bs == base
>    block/io: fix bdrv_is_allocated_above
>    iotests: add commit top->base cases to 274
> 
>   block/coroutines.h         |   2 +
>   block/io.c                 | 100 ++++++++++++++++++-------------------
>   block/qcow2.c              |  16 +++++-
>   tests/qemu-iotests/274     |  20 ++++++++
>   tests/qemu-iotests/274.out |  65 ++++++++++++++++++++++++
>   5 files changed, 150 insertions(+), 53 deletions(-)
> 


-- 
Best regards,
Vladimir

