Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1637C46466
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891A4207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pQS/rDUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891A4207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTe5-0008O6-JN
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kPTcf-0007Ry-He; Mon, 05 Oct 2020 12:46:02 -0400
Received: from mail-eopbgr140103.outbound.protection.outlook.com
 ([40.107.14.103]:57733 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kPTcc-0000x4-CB; Mon, 05 Oct 2020 12:46:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBLAsXrGme1pXf6I+n6XPct1jSuBK4pFuDM+y7r4SiGHZmYP9JgsXA3kq6IGfv4oVQe/y2hL2m0IfhB00rtUGhkRoEaHNTlihbCaVVM3GsZvuyUa/d5Q7kZ9kCKCT/YRRVBNhUiZHGMScsd9E9Di5xJG52YfY1pgd9ujbJiSkZgKyEKUzRUe8zgRSWR6A2a2XREPoLFggHBUae9+JuXgukHLL2rstppcVmRshMJCYECawrtRBUdZoonJjnl9cyu/NkKA2gjmwt3L5cGraNCGjikmTm5lyfD5dUyQR0rIhxLqP5rZJTDsV1GbnjqXGjt6Wa9Z8yW8xcRpGy5rCoA9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJRttDJuM1nUrYFsj0DsKkwGgQ9f25QTfTXtLS0MwhY=;
 b=EKF2diSs/aKsfhbafUi0F28LutxBpFLeRJjyFmU65qB+mLZjP33nZUKuglVnIUKk80pfO+M6FvC3MJwD6n9SoEOcnCSdqsXxABIchHLVX4iKp1Ej7ULrRG0rIqVra7LxB93JHhAGiMHEDFsUBoT2xQoICAdvDc4VbNcD3XD+nNXN5NlGztgDe9Ax6T+639kTftsh+zaIuvfOkKetuOiV3t/9nN6Eq15NfUR6rPVZ6YLrMhp8lGpqUqW6zAyyuJGXiZDnrru8fk1fqoZqyA+y2dCXucUJT9iKyyBof7xCRkOG6Y/63TluHvNNVFrFNymDbWNOx5Cjj0u9LnxIdIuIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJRttDJuM1nUrYFsj0DsKkwGgQ9f25QTfTXtLS0MwhY=;
 b=pQS/rDUPQ4D0gulm0RhgFwwLEGk7dAF2iZeFXOCb4LoF1PAXXR73WVIsBHNsOPY8orEWXfGjgAXPwgLcTjz4VHSTYLsEmSg39pxV5Jj9q70nCNwuWJSyLKMPGT/+uibIX23mLkbBqkS+k518GGHH1qcZ+AGNgzaM7hd47lK/hXw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2617.eurprd08.prod.outlook.com (2603:10a6:3:e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Mon, 5 Oct
 2020 16:45:53 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 16:45:53 +0000
Subject: Re: [PATCH v10 5/9] copy-on-read: limit guest COR activity to base in
 COR driver
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <ab11d5f1-0832-ced7-cee7-c791d65b7131@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <d2e965a0-8b21-c8fe-1c91-f545177369a0@virtuozzo.com>
Date: Mon, 5 Oct 2020 19:45:51 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <ab11d5f1-0832-ced7-cee7-c791d65b7131@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR03CA0050.eurprd03.prod.outlook.com (2603:10a6:208::27)
 To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR03CA0050.eurprd03.prod.outlook.com (2603:10a6:208::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Mon, 5 Oct 2020 16:45:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2058a217-7b0d-452f-bb0a-08d8694e1fb7
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB261727D3EFA0D11B5248EB31F40C0@HE1PR0802MB2617.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7G9S6Dg5DsCF+limKmB2mtuKA4KwOY6jlOBgDTLuIqDXtSZyuOrWyLDGJFF2udqUlTJ9DO3eol+iwNlKqKotHV1rTHhOAitivMyGRG/ePcj1f7khew83aQ5gnB6NNa5naMnv8crMErEKcmngbY0eYUhNkhQxQQkRLBsQ7j6cgad2HUrYb/uW4gd4/NVOEZ/56mtVJ7OV/43Bn6YOhzni3CKsnCVwf2166slT+z3d43TWdDP4mT4N8dAjVejKF2eIqxLT5nuWRUM2nktyEn9pTuZamhGOgbkXrOOPm7/CufaIeNMkZbZ/Mk1I/5JOC7guqy9r6NBgFHSu7qosGHeACZ6yB61+UxzbG2avGD3IfAIthqbU8A+KA5Xd/qBEVtuA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(396003)(346002)(136003)(86362001)(8676002)(6506007)(53546011)(26005)(316002)(6486002)(2616005)(186003)(44832011)(956004)(31686004)(4326008)(83380400001)(31696002)(107886003)(66946007)(66476007)(66556008)(8936002)(16526019)(5660300002)(36756003)(52116002)(2906002)(6512007)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0R4SUK7+XlIbmn4Ftd7fIL4PNVQHcnBrkKV90RuE/fKXP3RS6f10H3vRdEZDPDOTVOZbHXPYgo2TTeVPSBLk+KPV2m1hdnHuBDiwRFYSbttzWdm3zPmgjoytafPVA9ngtv79Lp4K2IjzTK3RaPM+8VhAwJx5lIYMlDhLXThpRQgegiuZtRq1lidgxma6HlF8+Qs5Mxa3TriXhIuUtmyHx3USnwITV0kHNa8GtnoZHkj5SRO42gybqYQ+zzz20/bxRnVHPvkAszfECgEkZEv30jEOT8CHU7m4TNuXHeD9mrOrk+FDtACtcOX7ekLuNJ7UIdTWxOJSW/etXXCpNc3iB47WVh23ktx0uM6gS7aZ49wSB6Et1gl+PSpscjTRddNwLQeUdbumhBa89wbVLR1/gjHnZ1BOMjwxYvxSyjZJDy3w3+Pa7QU5VUp/QgwDh1Zv6AdewD7SXguGnGR0oWSuACxaLTLJbFFrsYCkDEEW6Y5njJdRCDGKwUA/qFuLHp5G23/cgsrvMntQ4wrUBkQhPyTbpWYAilA78LA58wyAS0CB3gxX2R6h8ylRqOAhe6Uq9NqfCTAWnj6azMpjZmR3TwjnNsTpBZ4RapUBoorzqqvRdz+PLTC4gSoJ5O6irmpPKK9uzvf/8Fc/+hJsAHgAvA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2058a217-7b0d-452f-bb0a-08d8694e1fb7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 16:45:53.6004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DHyIjIOR4C32UDr8/bFMrUZlGpy1GEAS1ZilRWzR9Ca3I6CnR8Sk532zjPCZQ6KFMEFAMXbk34FdOMG5gav7Mm0tyBzbUBnxEVBjHgu3dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2617
Received-SPF: pass client-ip=40.107.14.103;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 12:45:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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



On 05.10.2020 17:58, Vladimir Sementsov-Ogievskiy wrote:
> 29.09.2020 15:38, Andrey Shinkevich wrote:
>> Limit the guest's COR operations by the base node in the backing chain
>> when the base node name is given. It will be useful for a block stream
>> job when the COR-filter is applied.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 38 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index e04092f..f53f7e0 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -121,8 +121,42 @@ static int coroutine_fn 
>> cor_co_preadv_part(BlockDriverState *bs,
>>                                              size_t qiov_offset,
>>                                              int flags)
>>   {
>> -    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, 
>> qiov_offset,
>> -                               flags | BDRV_REQ_COPY_ON_READ);
>> +    int64_t n = 0;
>> +    int64_t size = offset + bytes;
>> +    int local_flags;
>> +    int ret;
>> +    BDRVStateCOR *state = bs->opaque;
>> +
>> +    if (!state->base_bs) {
>> +        return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, 
>> qiov_offset,
>> +                                   flags | BDRV_REQ_COPY_ON_READ);
>> +    }
>> +
>> +    while (offset < size) {
>> +        local_flags = flags;
>> +
>> +        /* In case of failure, try to copy-on-read anyway */
> 
> But you add the flag only in case of success.. On any failure of furhter 
> is*allocated calls we should set the flag.

Yes, thanks.
Andrey

> 
>> +        ret = bdrv_is_allocated(bs->file->bs, offset, bytes, &n);
>> +        if (!ret) {
>> +            ret = bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),
>> +                                          state->base_bs, false, 
>> offset, n, &n);
>> +            if (ret > 0) {
>> +                local_flags |= BDRV_REQ_COPY_ON_READ;
>> +            }
>> +        }
>> +
>> +        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, 
>> qiov_offset,
>> +                                  local_flags);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +
>> +        offset += n;
>> +        qiov_offset += n;
>> +        bytes -= n;
>> +    }
>> +
>> +    return 0;
>>   }
>>
> 
> 

