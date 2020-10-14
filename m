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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36270C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E19D22248
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fw0L7BuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E19D22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnAw-0004ty-4a
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSn8r-0003nN-BU; Wed, 14 Oct 2020 16:12:57 -0400
Received: from mail-eopbgr30121.outbound.protection.outlook.com
 ([40.107.3.121]:25153 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSn8n-00080Q-Iv; Wed, 14 Oct 2020 16:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDXfSzmIAAVBkXuAbTnI2qBT9KtJl+hmARBHIg2WpX7r52WPu/4iCk24RXJ0HOSNAvv23LiF9OXEBatMQteigYD/3WExqDDPKxDgfijphNTKGAfuQT7tsDb8m7DM8mI1Ba7Hj5+4RuGnJo4kl4zq50wEk/6DRNbQBxqHIiwf/W5X0beRWfm/chjBbaE+hb4Hl0JNlbUsiMjVueD9KE69H/TShhdggDLTP/AaDbk1N+gH3EYNa4iGU/oUGVmqxLdpRYp073mlv1hBpTUZCt8tAwZm6MNM6MW6iPHe0WRxJrorB4N/+Kc15QoY7t77ByEFNV7DNbfak0SEvQUwIu6rtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+OrvYCbwUM7aDZUWCFZFpuaWWR1AjiE/vFzDMQAYC8=;
 b=DMU1yiNMPDnj1TRJJGLmx4Wy2ltgOiPNBfahdaI4SG6qwJqIZgrPSwgOQVgTWNoln1zBH6PWMWmnwoWGOK5khvQ0eSOcpGkNkePAyzOkWk1Lj+w+lt9orlbFSgcDnFbxuELK1GFmYxHrq1cktB4IEPjaAiUB7AJX2CjMa3su4twpk42XI35v/N9D1ZUofSavPuHgG/TBnIcjhFU+NwUShfP+Pecb+euYhupJ8d0NrohWcSh/w7EUSv9rZW7L+3HUroiGeLLYwgQ2hibBQokcsDRBxWAScNhDnERAvCHUC7d1ZGAuMO3K5izQva0pUwXd0qmWLxdMm+7R1O6cnis7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+OrvYCbwUM7aDZUWCFZFpuaWWR1AjiE/vFzDMQAYC8=;
 b=fw0L7BuNKOAZ+Q8ecVAXl7Wyd/rWerCrFyvEqivzDkChS6mck0TxG7UoyMHY9fqruCaQVodpPDUJ6tde2kSMnBPNqWTYSkm70tLAZlU283MjnljwxioXkoGbqzHY2b2qbKFC9elUthv2frFLLGZLhvAcwLFwKVIApTarWGvvqT4=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2522.eurprd08.prod.outlook.com (2603:10a6:3:dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 19:57:41 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 19:57:40 +0000
Subject: Re: [PATCH v11 06/13] block: modify the comment for BDRV_REQ_PREFETCH
 flag
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <092bf4f6-ef81-872f-4712-016f573f7188@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <87fc2f2e-4edb-496f-b48c-e535e237bad7@virtuozzo.com>
Date: Wed, 14 Oct 2020 22:57:37 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <092bf4f6-ef81-872f-4712-016f573f7188@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 14 Oct 2020 19:57:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b6ee5b7-de6b-4e36-7ce8-08d8707b6832
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2522944852D1CE7172729AA5F4050@HE1PR0802MB2522.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAt2soYTI/0NJRPvp0tJE+uS5gE/k7hmZ7qn7XZmkPda3jROv0QoEmexPtXZaq8rNvJ0982xYeqndu4X9N6ul725bhHssbkRcWCa89KK+USP4aGLfRa0vo46+9aWrty3UEZlX3rq6EKeQ/bmnXdX+KLwIpUS3skDJruOScx+UF6ez9SoVe04FEyIZXwF8uma6EevtjEqc+R4p9huB7DEyqfUpCDQ5RhlVsqra77I4RAixtmqUfixKmXyzHjiKbQjO0Etg3oWDfDx4HhlCErtmpeKtHkUJpoiZwi+YMTI7SsUba2+x85xLhPu8KBvdYdz/tSSE5TYzQYVJJl0ArucrPQgKdfW3fabQT5Lt0eFz4/gzVRnJaNHgJ4GjZnGqRje
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39840400004)(346002)(396003)(136003)(366004)(26005)(53546011)(316002)(6486002)(8936002)(44832011)(956004)(16526019)(186003)(2616005)(107886003)(2906002)(4326008)(6512007)(8676002)(52116002)(83380400001)(31696002)(478600001)(7416002)(31686004)(6506007)(86362001)(36756003)(5660300002)(66556008)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /jEUIb2k4YNypazqIut2ldVfL/KyGgOfiDaYVSRHBSWeFO0XebjnsniPude54aDw6Oh+p5zvi7GzaVKYgOccMMUG9QFDJdCeYgUXBIruGHiikG/O28DOHXjn6BlWyrNZATsJXoVxWrFUM0qB8A/0wS7G2Sm5MKEadKQ7YkZfgQzlCUKGLzJOgHEtgyQ4nEsTow575KHOiWlNHkoP3AotDA76Ai0Blu84V3sInqiTgA1y/hPOO4XXL6G/pseA/KrO81euY4JSsqtds+58LT5ZiIjK7sxObVL1cFSAcMAKMWiU3NDZCWokC3w12njjL/hCLwNqrKbKeIn52eiJwZK6WHY07g7XDAgrlo0NSRDWAygMpBZnkiYZJn3Stc7Dz1ooYOkIrWKksGkTxwFc6notc6wI1vA+hJQXtsXQ8QjkkdGTYjaKtCHqSTs892yrJiFrx+tr+svExviPr0KdbphYNzrXKXkz/0NyhW6vUoqDlDRu6i+jNWxjUEm+fY6LFgmiTUn2Iep+kQi32PYrAdRw1sKjnBZpCwpOwqpwajuW6o552XFzVeCIapQy4dEO8IpHJpzU0D61521pVRif+aurVzyxiwRsMo5/Xzplv36X5k0Q80/Npngcr9w6V9m5U9y1ayT2/D0ovg4Fi3vqU2Fqsg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6ee5b7-de6b-4e36-7ce8-08d8707b6832
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 19:57:40.6141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDI9jJ9IePkK1AJl653Klo2zNMmH+WcSr6E7iBbkF7eozTHkubpUM10vl1BwhcDAlpslmYWjQxVsC5uy01E8TDOGonTt3P6KDplg3IHcG2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2522
Received-SPF: pass client-ip=40.107.3.121;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 16:12:50
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

On 14.10.2020 15:22, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> Modify the comment for the flag BDRV_REQ_PREFETCH as we are going to
>> use it alone and pass it to the COR-filter driver for further
>> processing.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   include/block/block.h | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 981ab5b..2b7efd1 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -71,9 +71,10 @@ typedef enum {
>>       BDRV_REQ_NO_FALLBACK        = 0x100,
>>   
>>       /*
>> -     * BDRV_REQ_PREFETCH may be used only together with BDRV_REQ_COPY_ON_READ
>> -     * on read request and means that caller doesn't really need data to be
>> -     * written to qiov parameter which may be NULL.
>> +     * BDRV_REQ_PREFETCH may be used together with the BDRV_REQ_COPY_ON_READ
>> +     * flag or when the COR-filter applied to read operations and means that
> 
> There’s some word missing here, but I’m not sure what it is...  At least
> an “is” before “applied”.  Perhaps something like ”or when a COR filter
> is involved (in read operations)” would be better.
> 
>> +     * caller doesn't really need data to be written to qiov parameter which
> 
> And this “written to” confused me for a second, because we’re reading
> into qiov.  Technically, that means writing into the buffer, but, you know.
> 
> Could we rewrite the whole thing, perhaps?  Something like
> 
> “BDRV_REQ_PREFETCH makes sense only in the context of copy-on-read
> (i.e., together with the BDRV_REQ_COPY_ON_READ flag or when there is a
> COR filter), in which case it signals that the COR operation need not
> read the data into memory (qiov), but only ensure it is copied to the
> top layer (i.e., that COR is done).”
> 
> I don’t know.
> 
> Max
> 

I would modify a little:

“BDRV_REQ_PREFETCH makes sense only in the context of copy-on-read
(i.e., together with the BDRV_REQ_COPY_ON_READ flag or when a COR
filter is involved), in which case it signals that the COR operation
need not read the data into memory (qiov) but only ensure they are
copied to the top layer (i.e., that COR operation is done).”


>> +     * may be NULL.
>>        */
>>       BDRV_REQ_PREFETCH  = 0x200,
>>       /* Mask of valid flags */
>>
> 
> 

