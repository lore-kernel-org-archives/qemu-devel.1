Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273CBC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A81206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CR9SZGcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A81206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRTc-0000yc-Rw
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kXRPW-0003yi-MN; Tue, 27 Oct 2020 12:01:23 -0400
Received: from mail-eopbgr140123.outbound.protection.outlook.com
 ([40.107.14.123]:21294 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kXRPS-0006GO-67; Tue, 27 Oct 2020 12:01:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kofgdjdyxyCAUP88CxPmLVIPKDoMUlR9kCpyGYByviYf3bK6/bErWm+RHCYHrvz7jpYkE/jHYgXevF2Bi6lf41RvrSpRKCPNAH1E1HcAq8VzVl0roQPBtNgdFVBrbEf4QV0L3Yafdq3T5g1f/voDOw9X2gx1H0rADuqRAfWKtZ8bNunKQ8cg+XFKvZjarI5aiS5yXB8AX3q8Zd8SUABn52CnoJSiuV3zm6/tFPt1fsdIwWcr2R/78IowoAj4qczGgwFy1y8yuuC3ocXhWZlUZ5cM+eFILRdzifp2bq8gMmky/LCli4re4c3M2EyJIjxL+kge3liOAqKPjCpmdn7qRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeITrWJCd8QmUl9YjSgWiBw0/wQiS9SD7oYl8XSqDmc=;
 b=ELTB3+RRXXEJvXEgjCvfz2OumnHJ96+jtzCFBNQV3mTECRnyWGltjblEkKElHmiArLnlC/pPsL3R3vb9RzbcZJLaRrGwFY30FQM8+544xVsDmTxcHysRfpa2Ar85WTkSs7urZXYVuvyliubm7NfVPRqeYYJfrfqqYFNjxxFCHwakC20HbzvYiKdzoUmOy60NR3CCITnGoqrWdo2f+OQjob0vbPJQQAovqbtXh05ADxRo0J2HnvoheJ2/VB2ck5OdA6dNzmsyhxUqLSqK4GjBE52teLH00qQhegmIyh8rmn3mSwcui7f+firn1LhpAexEtwO0mcrKCpCib0wdaEqhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeITrWJCd8QmUl9YjSgWiBw0/wQiS9SD7oYl8XSqDmc=;
 b=CR9SZGcVGwOYirpHkhsttmsthhhUCo07IUf/abGNK7RbnAKieul0//uJaOEMwYFuet6BxIwyjQRn4Z1v0D3MlPn/pZ8zezMuCFIf5cWPh0Kq1nGpGj7SYb95el8Ao+qa17U8RTVnHKpdLsFM7LQ9KrDy07QmGXZDmu0dhfdzcaE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1769.eurprd08.prod.outlook.com (2603:10a6:3:7f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 16:01:05 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 16:01:05 +0000
Subject: Re: [PATCH v12 13/14] stream: skip filters when writing backing file
 name to QCOW2 header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-14-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4dadeb14-0744-1cbd-04c5-516ba509cc14@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <fbcca331-9cca-12c8-d829-4fae360c8ef4@virtuozzo.com>
Date: Tue, 27 Oct 2020 19:01:01 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <4dadeb14-0744-1cbd-04c5-516ba509cc14@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR08CA0034.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::47) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR08CA0034.eurprd08.prod.outlook.com (2603:10a6:208:d2::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 16:01:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e280f953-6c70-419c-02b1-08d87a91821b
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1769:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1769034EE91512C880F4BA38F4160@HE1PR0801MB1769.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9FkigtEjaSE9cIzhryamRMBfiT8zTfhDOZ4VyrejNb/vvxrR/OzkbVlf+ptphsrD8pk9zyjf0zgNadegqsWa6BHbQpUfp1OBzDaKdcu+qHbA4fnDaGiExX7XbvR+RGWm97VZqL+6vW4lb9u+nQJwU+XkfgihmkohIcGXh1+5SBA/KzI8iaQxQxvYeiuJwRRg74vsBEKfTOX9a768BSH8nChpRm/ThWFnXQgSIgqrRYBDYn2O+ofzTi0iwMT/yUU6xJhXKs0kOpgorK5cJWDLF/XvKfebYHeS53KpUOF7+oUJP835gLxb1Pbz5r3AMVmhNK3rnDhxcWfacxRknDcYTAh9w57qv8uWiG6Ciux/YFYeJ1Ufo3fya6gAwVHo2Gv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39830400003)(396003)(376002)(136003)(346002)(316002)(44832011)(107886003)(86362001)(478600001)(31686004)(6512007)(4326008)(36756003)(2906002)(16526019)(8676002)(6486002)(31696002)(5660300002)(52116002)(6506007)(83380400001)(186003)(66556008)(956004)(66476007)(26005)(2616005)(53546011)(66946007)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +SUIH0/lLufd5gQQTacjM5y2bdVQdQMvIYqIR8xbvL7sqCu+bNSVMOnEnDY3kRp7b63b39f2+oKl/Tl4b7x5tWzR92N1A61qOzoYCLI9x33b2/20xbSVCSpdQO6lcuARwZH9yXCYTH4Ny5dqLHsCh1e2JnFKCyjU+vJNwHj6fpiEM04zb6xRsSTC2byjPwDxfrbRBdQoBPfp7NADIp11y8k3ZWXNuHsCZkDvq4cCGEgW5rJKF57aL4cg+AUJZ50NVyJVh945EDDD1hO4gr98OPj6IjaUfgGMhVIGzuO3bOj4vp8Bo/qLT0qZ7K6ouvE8F+YHopAgC2INpXzlHdXfBECA9qFgbR83jO+wcaPMxUdOeBy8ndvzI34QE0dLVT+niISPcAfFesCnM7n1aeG/WSguJ6FOMWVdGRp0Jyv90hfqKisgOhdqjHeIqGCVuRX7Kd0zTUGadwWD7pV+t7ghUcMZuSG34WAQnBG/jkenVsavgeHIUTkmgPk/4n4u4rVqDA+4jrzlE7XZVYR6UHYAKtqULfzR3CVX6bR8y0NaLxCkcv9v6zO+6kWubemXM0O8ZWWgFGAtu1hqVt1dn7cNrWmXDubyueLBsDARHRoEUd86C16AXNxI2ykAJ6F5bqwl7NwH8kj/kBw3Ehi9ukhdmg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e280f953-6c70-419c-02b1-08d87a91821b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 16:01:04.8268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVIUtwpEjEy/v396V5pkbr2B73/y+FwEApLc/mbNsz6R0nIJBDH8jIsbVYm/rwXtdXJtFHToTyKvPSO51t8CH/JXdJNEueH8H8s7BEIOosk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1769
Received-SPF: pass client-ip=40.107.14.123;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:01:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_LOW=-0.7,
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

On 27.10.2020 18:09, Vladimir Sementsov-Ogievskiy wrote:
> 22.10.2020 21:13, Andrey Shinkevich wrote:
>> Avoid writing a filter JSON file name and a filter format name to QCOW2
>> image when the backing file is changed after the block stream job.
>> A user is still able to assign the 'backing-file' parameter for a
>> block-stream job keeping in mind the possible issue mentioned above.
>> If the user does not specify the 'backing-file' parameter, QEMU will
>> assign it automatically.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/stream.c | 15 +++++++++++++--
>>   blockdev.c     |  9 ++-------
>>   2 files changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/stream.c b/block/stream.c
>> index e0540ee..1ba74ab 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -65,6 +65,7 @@ static int stream_prepare(Job *job)
>>       BlockDriverState *bs = blk_bs(bjob->blk);
>>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>> +    BlockDriverState *base_unfiltered = NULL;
>>       Error *local_err = NULL;
>>       int ret = 0;
>> @@ -75,8 +76,18 @@ static int stream_prepare(Job *job)
>>           const char *base_id = NULL, *base_fmt = NULL;
>>           if (base) {
>>               base_id = s->backing_file_str;
>> -            if (base->drv) {
>> -                base_fmt = base->drv->format_name;
>> +            if (base_id) {
>> +                if (base->drv) {
>> +                    base_fmt = base->drv->format_name;
> 
> hmm. this doesn't make real sense: so, we assume that user specified 
> backing_file_str, which may not relate to base, but we use 
> base->drv->format_name? But it may be name of the filter driver, which 
> would be wrong..
> 
> Any ideas?
> 
> 1. we can use base_fmt=NULL, to provoke probing on next open of the 
> qcow2 file..

I would choose this item #1 but have to check the probing code logic... 
Particularly, I do not remember now if the probing is able to recognize 
a protocol.
The logic for the format_name in the QEMU existent code (I has kept it 
here in the patch) is a slippery way for an imprudent user. That's why I 
staked on the backing_file_str deprication in the previous version.

> 2. we can do probing now
> 3. we can at least check, if backing_file_str == 

Not bad for the sanity check but we will search a node by the file name 
again - not good ((

> base_unfiltered->filename, in this case we can use 
> base_unfiltered->drv->format_name
> 
> 
>> +                }
>> +            } else {
>> +                base_unfiltered = bdrv_skip_filters(base);
>> +                if (base_unfiltered) {
>> +                    base_id = base_unfiltered->filename;
>> +                    if (base_unfiltered->drv) {
>> +                        base_fmt = base_unfiltered->drv->format_name;
>> +                    }
>> +                }
>>               }
>>           }
>>           bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
>> diff --git a/blockdev.c b/blockdev.c
>> index c917625..0e9c783 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c

[...]

>> -    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
>> +    stream_start(has_job_id ? job_id : NULL, bs, base_bs,
>> +                 has_backing_file ? backing_file : NULL,
> 
> backing_file should be NULL if has_backing_file is false, so you can use 
> just backing_file instead of ternary operator.
> 

Yes, if reliable. I has kept the conformation with the ternary operator 
at the first parameter above.

Andrey

>>                    job_flags, has_speed ? speed : 0, on_error,
>>                    filter_node_name, &local_err);
>>       if (local_err) {
>>
> 
> 

