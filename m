Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E8C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776E72168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G5eU4GB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776E72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQEkk-0008QX-BP
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kQEhL-0005iR-1o; Wed, 07 Oct 2020 15:02:01 -0400
Received: from mail-eopbgr80120.outbound.protection.outlook.com
 ([40.107.8.120]:3131 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kQEhB-0004LK-T4; Wed, 07 Oct 2020 15:01:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6PpryH/SfjlPHNcQaAM/k2gT5YIbWbTB0T+R2lAjk9r6l9CqoNUlSFNe6A5duCoqziYH0wCEJCc67VAvknuVoaLaOYX4Ec2wrcW8Qim4Uo6wVV6AIYtSwbESGcg/icOQqTu+zxEsdzqdw04BTKdKh1XYiqQDZcOwR7c2ek8ZcODt20ysWOfbX+R3i+9AMZJ9Qt4JodCf8C1Uz/R0A+hzh7IsqP0ljH5iRijE6dVIEnfGBvMjs91WwcWkED2JV5tyCwOgmSTt3GHfaRwBC/n+wXQvIYt5n67gqdrZmyC2E0TCOXoNI/1voe/yHVkcn1iByKupRlzfNw3jTxJ+GQ3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iYDv2GtdToOmJy3j9e5/MpeyTLODNfAQ9L6OJVR0ec=;
 b=Wbl9kO5ktCUYRVlE5xQTrzxkGNDvCa9cGL5wAsmEP0aS71jGjHBIjIiZC3RE21s5W082rMWoRzabjMXLtAV4hnFneyIPKzTVryDHJYHJezy8Ej4xSyfqm0nZQdc8KOOu/q+0tVJhjg24t0kr355/u1Cl4hGm/DuhkEjfQruINbBWmzv3CntDXfdNcBqnY7WuPLShqc4oZMSeVd+ZgUTbbyxaV0xQO/mlFrj9wMaqffSXy3qC42VHU+wF/T4c49O0+FqMTrAkkBv79jMymp96yWU5cz/UtUBq93rN2hLjdo8I6gqLx5nut1aFdcajSsDjEIR0qZAbsv1juluW8aEOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iYDv2GtdToOmJy3j9e5/MpeyTLODNfAQ9L6OJVR0ec=;
 b=G5eU4GB2ox8IALLxAmyQ2LrRbNuGNobFJnGEZTxLQyp5ic78hxCsdVkaLV408JMqU0f6N46IDQs+1fFCAJy+gyQ7LbDu+X90i/9NcyTWtiGIKj6GyKr213+Zyxxz5ruDeeF/T0rsr015Y/Mc5lr1JlKbR8KZzyh2kMDREqF8JOY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Wed, 7 Oct
 2020 19:01:43 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 19:01:43 +0000
Subject: Re: [PATCH v10 6/9] copy-on-read: skip non-guest reads if no copy
 needed
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <531a938b-4b76-c506-59be-eafc1ea85159@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <de411799-a8a1-4bff-a48d-2692cc29be61@virtuozzo.com>
Date: Wed, 7 Oct 2020 22:01:40 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <531a938b-4b76-c506-59be-eafc1ea85159@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM3PR07CA0119.eurprd07.prod.outlook.com
 (2603:10a6:207:7::29) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM3PR07CA0119.eurprd07.prod.outlook.com (2603:10a6:207:7::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.15 via Frontend Transport; Wed, 7 Oct 2020 19:01:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29e50c66-c34e-485d-a3af-08d86af36e19
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2124:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2124FD7BFC9E1D78CEB2AAB2F40A0@HE1PR0801MB2124.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reXEfWDBJfQgNbvwh6+uVnyKyk1SWtEt5K4XoEdOToUxNlBjOKZLVaGcm81mC4a+8eaq9V0c0zrNLVK0JR0u1oWNlYO8j6EqtylV8KmiWXQJevXUsj/7di7d6UVbJVJfD+VueBUcxKIbcv7BQeQabQkMAOO5A3yxFTWmSycYgqGGW6K1EtYqfZMiLCi+dF2u6GRUNfw1SlVnojcF7dn3kf6QFtqwwHF/sLk7MHTPEZQkRqbL/VjYWSY46uf51+lbmciA9rKqsCjg7mtI1xb/gDdK7HljiUvTJdonHSesxYUl2vIAM1C27W1mAH1c8A/mqqf10vAkOLocd92LQkYW38mkwKO8JIWNCwOSBmnNUKC5Ewbcg1iPQ9eJVI4S6wif
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39840400004)(136003)(346002)(396003)(66946007)(6512007)(66556008)(956004)(83380400001)(2616005)(316002)(5660300002)(31686004)(66476007)(478600001)(36756003)(4326008)(2906002)(52116002)(186003)(31696002)(16526019)(44832011)(8936002)(6486002)(26005)(8676002)(6506007)(53546011)(86362001)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fJVhoubcgSpV/E6lUA7AhhAshmTIeyMiwVi9O/qt9gta0f70ynnz7dLZHnVgw0d6sY65vM1Sht9wCaQeK0SmbRo5TrV4zBebALRr0g0ZeMxiI60GPy4pprqSIJhMK6yrV+S7aBBPvbOfQpN/F56iaE6cyit69Y9VdDb1HShTG2MuPl/pd5kc9MhobTaCjD7fEczdtc1fqdLXR6lWVuWANlKIc0yAcDy0R8Qghi2hNXEXp8hXMomuwMOvQD6M0lyEkBVdOQx86UdlsSLOkrfoOTwnkuIo0b7P9IKhd9pEWz5uDunEZqGldn70WdxwdBqHFEqefoM+PNpYuK0HPcnOcwnW5tSWniWwgsZUd0g7Ot2eaymMkaFlNHWCLH/JUsS1cKD7gq/kx8uYv34UO+bcB7PF/KBtzmQYnw7k/P3q2UtBgW7UvIunNADEyZxKR0JoiqFfJeV8j+hLsMyGUOKkcDT/Uf0wTwdZKv5O95Td2Lrse7ny0K/AfR+LhgxqFkQQYdyfgRQmQjCQxSzncN+YyU4hwZ4N+Mwd6iWbI4hzRVe7Nx15XriMraurcpHG+DdRbuiyxyugq9MZlanu1O+WNFX+kfH+5A9MoY9ntbBBv/UzOhCwgUKZieJm17RndKOpj9I1L6W5h6y+GOZ2VeeQfw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e50c66-c34e-485d-a3af-08d86af36e19
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 19:01:43.2325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpptT7yCmGfl56o2JCooFy9uO9/seA0zRT46BMECy9YCrEk2O4Cl+M0H/GwFAMP4O10Vfe/YmzkaZUfoEBKAZ1zXrBW/NHHnyoVaGw/Pmmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2124
Received-SPF: pass client-ip=40.107.8.120;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 15:01:45
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


On 07.10.2020 13:06, Vladimir Sementsov-Ogievskiy wrote:
> 29.09.2020 15:38, Andrey Shinkevich wrote:
>> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
>> COR-driver to skip unneeded reading. It can be taken into account for
>> the COR-algorithms optimization. That check is being made during the
>> block stream job by the moment.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 14 ++++++++++----
>>   block/io.c           |  2 +-
>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index f53f7e0..5389dca 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -145,10 +145,16 @@ static int coroutine_fn 
>> cor_co_preadv_part(BlockDriverState *bs,
>>               }
>>           }
>> -        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, 
>> qiov_offset,
>> -                                  local_flags);
>> -        if (ret < 0) {
>> -            return ret;
>> +        if ((flags & BDRV_REQ_PREFETCH) &
> 
> BDRV_REQ_PREFETCH is documented to be only used with 
> BDRV_REQ_COPY_ON_READ. But here
> BDRV_REQ_COPY_ON_READ appears intermediately. We should change 
> documentation in block.h
> in a separate patch (and probably code in bdrv_aligned_preadv())
> 

OK, we will come here without the BDRV_REQ_PREFETCH flag set.
To differ between guest reads and the stream job ones, we would set it 
here by checking for the qiov NULL pointer:


diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 4e3b1c5..df2c2ab 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -144,6 +144,9 @@ static int coroutine_fn 
cor_co_preadv_part(BlockDriverState *bs,
                                            n, &n);
              if (ret) {
                  local_flags |= BDRV_REQ_COPY_ON_READ;
+                if (!qiov) {
+                    local_flags |= BDRV_REQ_PREFETCH;
+                }
              }
          }

Andrey

>> +            !(local_flags & BDRV_REQ_COPY_ON_READ)) {
>> +            /* Skip non-guest reads if no copy needed */
>> +        } else {
>> +
> 
> extra new-line ?
> 
>> +            ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, 
>> qiov_offset,
>> +                                      local_flags);
>> +            if (ret < 0) {
>> +                return ret;
>> +            }
>>           }
>>           offset += n;
>> diff --git a/block/io.c b/block/io.c
>> index 11df188..62b75a5 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1388,7 +1388,7 @@ static int coroutine_fn jk(BdrvChild *child,
>>               qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
>>               ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
>> -                                     &local_qiov, 0, 0);
>> +                                     &local_qiov, 0, flags & 
>> BDRV_REQ_PREFETCH);
> 
> Why? In this place we want to read. We'll write back the data a few 
> lines below. What will we write,
> if underlying driver decide to do nothing because of BDRV_REQ_PREFETCH?
> 

See my comment above please.

>>               if (ret < 0) {
>>                   goto err;
>>               }
>>
> 
> 

