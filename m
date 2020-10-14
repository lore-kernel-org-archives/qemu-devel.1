Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3409C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C64B20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TyssIPXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C64B20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjlx-0004Be-Bd
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSjU5-0003VA-LA; Wed, 14 Oct 2020 12:18:37 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com
 ([40.107.20.117]:42148 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSjU1-0003D8-GJ; Wed, 14 Oct 2020 12:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlG9aKVZqmdOVLaKNSxx1U27GwaOmZ0zCuUReY5vcGB20o6rkEtZkAk8sQp0QZ6Ma7b9FglQaZD0dVb055l2FB+AAoV/UVUwXh9W9dnb1FQXP0/4q9whPhIAqhV+gPdugvMdGCCxp0pZ7WVwXCH8/sTVxjDYTWCQ3L9d07E9F4bphFPguVCI99QJ2QqaSdpFf0VyTPl3o0LjZhO1enx2Jxxy+FMRnX9rnEwh3ONLjso8UTiNsazFtNbkCGP1guLYVkRwLdaVX8BMvQ8RfcSml1fAcaZrtyhLC2C1yHV4pP2C5Mgxh5FAgyKHZDOGESof/HgmMmxf1NFUi03J341ccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3wfLbnhWAa5u5os4NJIqctnkHoc72E1hTNXuC6SIJY=;
 b=JoxgORIZlLvIEWNxS6+XA+jAVWu9gqzqZHRNSam+IS4mkohlp1nKAwm2kbYSNzHCK9vRXBqcv9szAaiusF0O/qtLX9RSf5Hl0VFOAYIhPudy11aj3r5WDVZOuu4VJ9CzBbph8kZsfKNBDy94DIeECQ3w1NWyXX4sZ33llJV4LY02pZ9D/IERJQnQ5LGj5c0oOPUTM77YhUR/PBm5/d58YDGkjblW1Sqgy32aji5uOx8tTshBuZJWq81F46W+NoHWJq7TwbmxUpkXsKeSgGHQ9b7f6Smey0YipIH+/hUHHSeBUChi3HiVBVtfNApZx3VQRr+WEXc/sLxjn4u1ZnR8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3wfLbnhWAa5u5os4NJIqctnkHoc72E1hTNXuC6SIJY=;
 b=TyssIPXtpux+bWLGrnWZRdn1l6cBeCB7J6qzpIVeeEjtmSiK06rLah+ADuMLNdxe9YQy58vzX6NQGj/rkWnuJLTZZ0dOlifbmr9upVK1MYsAE1M+OmSIAlREME0uKE6xjFm0KRdimSeDanTIT5mijY4SSqhC9LOi9MmUFe7bcSE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2612.eurprd08.prod.outlook.com (2603:10a6:203:99::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 16:18:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 16:18:30 +0000
Subject: Re: [PATCH v11 04/13] copy-on-read: pass overlay base node name to
 COR driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <3c6699f3-e061-c2ae-c5e9-a12660405624@redhat.com>
 <89965a42-cee0-a98c-f97a-a03b5d834418@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b1892d3d-cef7-c804-09fe-1fe9db86a438@virtuozzo.com>
Date: Wed, 14 Oct 2020 19:18:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <89965a42-cee0-a98c-f97a-a03b5d834418@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM0PR06CA0103.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM0PR06CA0103.eurprd06.prod.outlook.com (2603:10a6:208:fa::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 16:18:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cbdcc86-f57d-4055-d9ec-08d8705cca1e
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26129EBAB8E4D8B7FE05D4F9C1050@AM5PR0802MB2612.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8jOmDKCuakkRcKeWr7K8vU9E5KCQazFQRT8OtQXeyQOB0nVzPaugwpCHkxK7R27P2L0mAzv7Imz7usv/toZ/lrX8YSERULkOKSTySnJQtAZjfPTPXQ/BUYzFzIU8m197Nec9cyihW5USOCS/shVpRjWYoFH7AtheA8Nq0WysCEUH2JkMMLDag29vozTDsALCA8tAL+Ej0vHlC+TosYWS23W2ZfHizFehr6tebtnCIEDIshcU3Zu27KnX13dtKVNWt5D9nRMC7YAOr2orLJPBXUg4Zylz6phYuTV5akOYZlUiA0R/fqG2gS7o5kAWu33vWtxCaZYY879GZNcKGD45Jr0qwRcG5HO8gXU303+etaBLgRXDTLNC9kt85g7zTEq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39830400003)(136003)(346002)(366004)(376002)(8676002)(107886003)(478600001)(31686004)(110136005)(7416002)(4326008)(6486002)(66556008)(66476007)(36756003)(8936002)(5660300002)(66946007)(52116002)(16526019)(186003)(31696002)(86362001)(2616005)(53546011)(83380400001)(956004)(16576012)(316002)(2906002)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KYPMPBx+cJcx2ekekiA1XqNqRuyOwvJ/ELG+Oe7o64OU7rO4fSu2JCu8Rckov+bHC7r6lQAId+t31qKS8MZ+eAVT461sVvPcjV3/nci5/fWw2IPyPUWS1NaHI+Pwep7x1BTAJF1bs73TgjiaQxa/HnMyQvXLPFR5tiYwqAI7wBqx4SClX+sLA/MhmfwtCB+O/JkUPcM9FnEn7LOmvuxIN674K0kVqJRCokTBFmpxlKuevooZ6QLoEuSSlJ0r8I8X9cQIkpxppplR/VSeucvEFwu9VOvEi/gSyTl50ahAujjAPq14nqd+urlsNm6cDUJ5UosoYfBShQjirBRuRJo/rQCM6BbT6cbZq3fC/RAQBg3wzCziiglldRyS/lH1An82bHTlG4kz9iElab4Wxcf6F9Gz1sTaY4Ahr6hiBS5rdDc7HfHX9wOFcKZcQva8j7khmCRsTjvbqGGcqIV7H1qC1Kc6kbroJhQKwCQvH/o3y8o21Lcnawkzdi1tURnJ8o1Ag9zzG0pI1/eRzZ50owIZfjhr2rcTPbY8obaLwKzIUujknhFfUy+9pAcEyp6PkVb5Z3K+7YWK145yG76guF2llCJk8vLoiShF9D0FmDFcksgrld28R79CquTIorm0AOgt7eSyrcQYQ9J0BFR9Sww17g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbdcc86-f57d-4055-d9ec-08d8705cca1e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 16:18:30.4770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqkTOhqhLinA1ZIItsPR1DzRNhw+dmgQyEZoTj11brmUPw1XXU4pfalQXGVcQxSxe++rmJXOh6Owrqv+ZPBlj3AveBezs76zI7sWm/Aumhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2612
Received-SPF: pass client-ip=40.107.20.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 12:18:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

14.10.2020 19:08, Andrey Shinkevich wrote:
> On 14.10.2020 14:09, Max Reitz wrote:
>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>> We are going to use the COR-filter for a block-stream job.
>>> To limit COR operations by the base node in the backing chain during
>>> stream job, pass the name of overlay base node to the copy-on-read
>>> driver as base node itself may change due to possible concurrent jobs.
>>> The rest of the functionality will be implemented in the patch that
>>> follows.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   block/copy-on-read.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>
>> Is there a reason why you didn’t add this option to QAPI (as part of a
>> yet-to-be-created BlockdevOptionsCor)?  Because I’d really like it there.
>>
> 
> I agree that passing a base overlay under the base option looks clumsy. We could pass the base node name and find its overlay ourselves here in cor_open(). In that case, we can use the existing QAPI.

Actually, there is no existing QAPI: if you don't modify qapi/*.json, user is not able to pass the option through QAPI. It's still possible to pass the option through command-line, or when create the filter internally (like we are going to do in block-stream), but not through QAPI. So, it's better to make a new QAPI parameter, to make the new option available for QMP interface.

> The reason I used the existing QAPI is to make it easier for a user to operate with the traditional options and to keep things simple. So, the user shouldn't think what overlay or above-base node to pass.
> If we introduce the specific BlockdevOptionsCor, what other options may come with?
> 
>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>> index bcccf0f..c578b1b 100644
>>> --- a/block/copy-on-read.c
>>> +++ b/block/copy-on-read.c
>>> @@ -24,19 +24,24 @@
>>>   #include "block/block_int.h"
>>>   #include "qemu/module.h"
>>>   #include "qapi/error.h"
>>> +#include "qapi/qmp/qerror.h"
>>>   #include "qapi/qmp/qdict.h"
>>>   #include "block/copy-on-read.h"
>>>   typedef struct BDRVStateCOR {
>>>       bool active;
>>> +    BlockDriverState *base_overlay;
>>>   } BDRVStateCOR;
>>>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>>                       Error **errp)
>>>   {
>>> +    BlockDriverState *base_overlay = NULL;
>>>       BDRVStateCOR *state = bs->opaque;
>>> +    /* We need the base overlay node rather than the base itself */
>>> +    const char *base_overlay_node = qdict_get_try_str(options, "base");
>>
>> Shouldn’t it be called base-overlay or above-base then?
>>
> 
> The base_overlay identifier is used below as the pointer to BS. The base_overlay_node stands for the name of the node. I used that identifier to differ between the types. And the above_base has another meaning per block/stream.c - it can be a temporary filter with a JSON-name.
> 
>>>       bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
>>>                                  BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
>>> @@ -52,7 +57,16 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>>>               bs->file->bs->supported_zero_flags);
>>> +    if (base_overlay_node) {
>>> +        qdict_del(options, "base");
>>> +        base_overlay = bdrv_lookup_bs(NULL, base_overlay_node, errp);
>>
>> I think this is a use-after-free.  The storage @base_overlay_node points
>> to belongs to a QString, which is referenced only by @options; so
>> deleting that element of @options should free that string.
>>
>> Max
>>
> 
> I will swap those two function calls (bdrv_lookup_bs(); qdict_del();).
> Thank you.
> 
> Andrey
> 
>>> +        if (!base_overlay) {
>>> +            error_setg(errp, QERR_BASE_NOT_FOUND, base_overlay_node);
>>> +            return -EINVAL;
>>> +        }
>>> +    }
>>>       state->active = true;
>>> +    state->base_overlay = base_overlay;
>>>       /*
>>>        * We don't need to call bdrv_child_refresh_perms() now as the permissions
>>>
>>
>>


-- 
Best regards,
Vladimir

