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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1D12222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WV+E/0Ae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1D12222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiuc-0003oC-PD
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSit1-00036G-DB; Wed, 14 Oct 2020 11:40:19 -0400
Received: from mail-am6eur05on2130.outbound.protection.outlook.com
 ([40.107.22.130]:34977 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSisx-0006rO-Ae; Wed, 14 Oct 2020 11:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLYVZmWmnht22R6RA+VpX2aYXLlhvcAqXkUOBwYNPcT0/npm5zDa8j38ywHbXCn7G/Nta3M3fSamyMjUvUQoEfz1fTYvb8g+q579T9t3VAvVPdEeApg/zGXIoPO/qU8XRcAdp2SXUxqopQu0Fqj6r2rTlWuTLe7hGbVBY4J0tW300SjoAnTVpYSuwLs5cgtK7l/6+edGXRAS45tsFRwXK99j33N4azfDIlfOPE5P3V+DytX65m6QCkfyYe9kxxWHYAdhemyxP7IYhoPXAITGjz5xWOs0VQsRaIAivTu/ZKWn9QPtBpgTk1L3RR5+6QSAXFXVCEF6UvDb6aGnZp6tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgon6kLQhtYst7EyzoUMdas7UNiQjJYVWsNXBj+DC3M=;
 b=l2QcJVSxsupwWNMw4EusafvXagl+sTxGJx51/Alm3E5dbAi2wqD8ZN6MSS7YfZroFdfDs+aHHUfzpXxI6Yzr73ICcA5E+tBEc3rDLhj9t5FqhwLmtIADcRaroKNiBxXJYnUTZJpMsW2Sm8t88u5KU3OOBk3Xfe/kDRLqBT9vpesGiB8p24itwZUd9TRbvTE+EwFgMO45zYR9OQtu4und0MEC7N+fq6mCCuAplkoKwiLbaYZzDAZqWefk35Usu3hahwJKPMy12OLzyDW3MBMwZbWHZgJ8zQ2RCCypjSioPNNSqzmTmaeGseMd61tRHEmisCNpTuf/Cy5Qm3IvDoo0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgon6kLQhtYst7EyzoUMdas7UNiQjJYVWsNXBj+DC3M=;
 b=WV+E/0AeHRQyQIwVyDiO7rbLb4LgMdVO4owQj/qNG193R02Qr31Y4yIUxl5Xn1q2ZVH0e/XhA7+ExQiPzm3Uf6u3gDp75oU6+zvV4kVlgVeUrUdVMoWs4gP5Ok1Ngw5ReuUhTMX92nOYcxnUdgQfZlWECNA/q8vZUgpXYeD8Ncg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1716.eurprd08.prod.outlook.com (2603:10a6:203:39::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 15:40:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 15:40:05 +0000
Subject: Re: [PATCH v11 10/13] stream: skip filters when writing backing file
 name to QCOW2 header
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-11-git-send-email-andrey.shinkevich@virtuozzo.com>
 <582fb55d-0d3f-8a16-2134-67d73643da9e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ad827283-c9a0-74f3-2e04-8fa8d37e2dd9@virtuozzo.com>
Date: Wed, 14 Oct 2020 18:40:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <582fb55d-0d3f-8a16-2134-67d73643da9e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM4PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:200:89::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM4PR0202CA0013.eurprd02.prod.outlook.com (2603:10a6:200:89::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Wed, 14 Oct 2020 15:40:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d74b529-b3ef-4072-b22d-08d870576c19
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1716:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1716EC3584528D04D07C7185C1050@AM5PR0801MB1716.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10UQuz25r5KoQkOsDgyYZU2uUqwkxLo8kyx5XIMbpBA53xDRkp7GiqQsTqBEqdMHRrR1vmDdHBn6sZxGSLo5pT/om/GyL5ef2p7PZOcYH3fgc7r1Wa3cAtCBatPMnDAw9ASB7iV7Wz8nahPY2O2w4llqEqGDkBdAqgxaQTPMslqo3f1OjrTHIbF9D6lckful9dwtdK2bLxAn5rRgT8w6DAdOxjQDPSeG0d/ZsrB+uE6z5TCriXIZxmLArk9Hd3lhC/gBxqDdaX2dexqmW0c7uo4O5vy4bcHTjvIpx5Xl7WZqLDqLI9oy/ic2jLm6T9O82TrLy+N8PjCZwkJRFKrvAWPlmqInh9bf6q/YzI+1x0+l8IzkK+KYWaR6MTAuWodX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(136003)(396003)(376002)(366004)(31686004)(4326008)(83380400001)(8676002)(66556008)(52116002)(5660300002)(2906002)(16526019)(31696002)(66946007)(66476007)(478600001)(53546011)(86362001)(956004)(2616005)(316002)(6486002)(8936002)(186003)(26005)(110136005)(7416002)(36756003)(16576012)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dtn7/BS4R/gOQnNeBtjJeKuiTHx2jwRXjpDHpefIVQo6UEwmUtZEtgdfXknPXWn8wI1LhBZM8iUDZ8vLOfeHLkfCNO6tWbn998Q3VKqouDhUqmhLEPSi8YkHgy82t+VNMcKpk+8aFMFUbOQB52F0lgy8OBVqVvBs4taUHAChUwF1/xYRDSuDkv9Ra1IerG3kCXOucQNQASck1XrCD9Q/XfDdi3mMj8YjBgms5DDK7KwCKy90Ixi66E0qwzKgn+jy2gcwUtBuH1Lp5tIsZ2Pa2LDbg/mqHw7S1xMAbKFpMLOqiarZGb6PcZczoQsmZUv/f6JR8UGumasISrdwfvOu02TIKJ3VpIhPqv0Ahz8R9AfuV8eKiFQ5OAldVQ0PwkfrAl/UU6QRK/oDyRUtrN/LrarCGL8gcupw19OMoPPL85UZxZBox4OAouaJyC/QSUlMUgPOoZ/cKLTHZgbMKsNzrm/UT9GiufdoovMvWLub4wOuidOrqIfKbSDpR4ZGxphHJCyjpLAh+7fCFm64WQRPjPB13Qc+StHqilrHkkHivBlhU+FhMocnCliLzYYW1DqeI48eszcCj/W1bGdzD7vClM6pqzzGZrB/LG1XdlkTRFUdQtEBlbXatGBZGJPDIOY6t2/Rj3GU//z8XTPH1WLdtw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d74b529-b3ef-4072-b22d-08d870576c19
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 15:40:05.3045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axd0lM3TR+2tjw/DoF68t65waWqmXYNAwPlmFXoej0ebtXmdBDgHQd7PppJL78Pdw4Ph/mc7DO8ASwHgO6DkwIMvBaSyjBYWPDRX3FSlOLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1716
Received-SPF: pass client-ip=40.107.22.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 11:40:12
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

14.10.2020 18:02, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> Avoid writing a filter JSON-name to QCOW2 image when the backing file
>> is changed after the block stream job.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/stream.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/stream.c b/block/stream.c
>> index e0540ee..51462bd 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -65,6 +65,7 @@ static int stream_prepare(Job *job)
>>       BlockDriverState *bs = blk_bs(bjob->blk);
>>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>> +    BlockDriverState *base_unfiltered = bdrv_skip_filters(base);
>>       Error *local_err = NULL;
>>       int ret = 0;
>>   
>> @@ -73,10 +74,10 @@ static int stream_prepare(Job *job)
>>   
>>       if (bdrv_cow_child(unfiltered_bs)) {
>>           const char *base_id = NULL, *base_fmt = NULL;
>> -        if (base) {
>> -            base_id = s->backing_file_str;
>> -            if (base->drv) {
>> -                base_fmt = base->drv->format_name;
>> +        if (base_unfiltered) {
>> +            base_id = base_unfiltered->filename;
> 
> I think you have to leave this querying s->backing_file_str, and instead
> change how qmp_block_stream() gets @base_name.  block-stream has a
> backing-file parameter that can override the string that should be used
> here.
> 
> (Or perhaps you can let qmp_block_stream() just set it to NULL if no
> backing-file parameter is passed and then fall back to
> base_unfiltered->filename only here.  Probably better, actually, in case
> base_unfiltered is changed during the job run.)
> 

Agree with the way in brackets.

If user set backing-file parameter we should handle it here.

If backing-file is not set, we should use dynamically calculated unfiltered base in stream_prepare().

-- 
Best regards,
Vladimir

