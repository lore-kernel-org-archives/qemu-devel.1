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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F42C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7858821582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LfRysbdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7858821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSigj-0006CA-Fc
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSicJ-00024w-Jb; Wed, 14 Oct 2020 11:23:03 -0400
Received: from mail-eopbgr20126.outbound.protection.outlook.com
 ([40.107.2.126]:61767 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSicG-0004ZM-Eg; Wed, 14 Oct 2020 11:23:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2pxwYa4NdRulCN5rDVZ6lXNB79CoCTOPUJOEQm+dUalqt6Wzd7oex4slhA9x/FBHK7Y4M7KoCtDd9856FH+2qmus29zV0kBgfJ1gs+vaxTPBdPXI7DH9Z3M4LASzipI7S4Xm9mZivyCQOH0fCebo61PVHZDuEbod+I6kTByR0ZBoS75D1p562jLjPPBgxyJczguCCH6hBybf+nK1uHZ3a6oO1ohNJzWxnIDVk4g6C+8U07Ah+MT8C3MSwOdNpMY9oCCDVdxCkIdxh0Fazt9Oixo1KKyrfy9wVXCCTzgk9B1siEFMrG+fgNnyGqSgImp438Z4Jh3fXXNP3Np4t2cdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN2sOOWsfZjUVpI9I4bAkTaCY0GLwcvIam673bx5gPo=;
 b=NyyGelARZbvCDEbff/i2kW/vJHJ8RevNpCvUi4DsJxhbnd7+knHLw0hSCOSByiaCv86JBRm6yQ42cRSxuGYV43Jn/heAYh28nZP5skAOl4jmb4i72GdstuXJ0bkTZSisZ6fJ2Wj0GOt89I83a4aP9oOGPrKDIIIPZdl2c17IG7A7qmXRSsN36zOTlRfHN7XjIf+FkR8HDOMhAxGN1woOVeJnMv6MMaQ4LqfXpIw+XgxEcpiRAuZoHfHTkWlCSZlixrR0LQ6MeDgk7TaWFSnBIEvAcqfaDCH4f9SjsooEQpwpxuBISIG91pPtSKktpcUaPMOhTLw15nMRCKkjfZeJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN2sOOWsfZjUVpI9I4bAkTaCY0GLwcvIam673bx5gPo=;
 b=LfRysbdB7GazNu4fbQpaJA+CDE6GrthqiC8WfQPG+qQJA4yQJtKJ6C5zkLlupThMb8D/xlRRfTNWi4Jp2wlKVX47isiIyzS4MNYpjLdEh0KEVvOIyvGFXwQLbndzgJXSKx1fQIVGNnq4GvKNLHP3SGmnBl2WShrkKS2vWnWhw7c=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3093.eurprd08.prod.outlook.com (2603:10a6:209:41::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Wed, 14 Oct
 2020 15:22:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 15:22:56 +0000
Subject: Re: [PATCH v11 09/13] copy-on-read: skip non-guest reads if no copy
 needed
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <59ff1f29-149a-0870-b600-1a54f0421c05@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c363d263-1854-d766-e9d3-c8ae8008740f@virtuozzo.com>
Date: Wed, 14 Oct 2020 18:22:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <59ff1f29-149a-0870-b600-1a54f0421c05@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM0PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:208:be::46) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM0PR04CA0105.eurprd04.prod.outlook.com (2603:10a6:208:be::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 15:22:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e5060b0-9f8d-4971-15e6-08d8705506b7
X-MS-TrafficTypeDiagnostic: AM6PR08MB3093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB309360C3186DD0FC54C42F82C1050@AM6PR08MB3093.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEf+SjGzErLrYgEyY3WrVCgNswdldKFrnplwdeEbTT0RoTrKRN6pYL3kUzVX/Nt4Vgveui9rVhquWPbxLCrlmZYtrNz0VAt4x5+9caXhVsRlqGHaHVkmsDvoDfZmfDfWG7PRVqwaALrlGFEBaBpER8JlnV5Oj4FoF5rzbn4iUkB43pyWfBOAoCKRsglFCZi4Zz5ucKBbPhoC89Ggpp/m9G4y3djvI4uoGwzmX9kSbi5O2Y7ZDaNQc1cFkreFovSP8sBroJvn1ccO+nbSjCBFR2SVjJh/3nIK52LIo64+QTn5uJXiWssBoky+N1uHtXd1LI4s+H4wasTEYJAs9cgYrPIjXw67dvjAnaa6JjS1cEwPIfj9MvpKjGT1AEQg7XsQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39840400004)(396003)(136003)(366004)(110136005)(8676002)(6486002)(107886003)(5660300002)(31686004)(4326008)(66946007)(66476007)(86362001)(16526019)(316002)(2906002)(8936002)(31696002)(26005)(66556008)(7416002)(2616005)(53546011)(478600001)(36756003)(186003)(956004)(16576012)(52116002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sBNg0hK9Ffnvn4QZomk6ok2mE6z4E203XuhRYQ9mSgwx9ThMOuGfF9qIuAOIrqKj0swAMk+CDkfb0WhEDs+AXD/qkv+X+t/1H5nt6Ov29RIVSrMBYO7fRNEupQ4V9d2TUdM5WOQkfi0Wt+bpHJLWa03bicrWlkuboMrsNxGFlwTRXNzATqSL6ag5CCPfk1ufmUWLNPIWZo5mCVq1Vc9gw0mzbG3QTk2sgwlDgpt/ztVVSfatZNP2EsvZZwEOrjLVAVf7cxdXy+G+x8SedQa7ZmK+qahpLn4kL/H0aZVHwA8drzxTx4YPNDbfJ4mXan2UGm9rp2iR8X+TC+O898I0ZCDemK/YZTYR/WCAf1TX5uz1bWBIjD02S5jqUX8Wn2X09xez/l+6wZEi+aFwwHS6okqIZFdDw2Xwjxr7kP0V1pkOnbJDlWi2/g+NluW3+2uY0QE7BVXH4L/vB/tQTjFv/HOl4NBapNlCm2yTW0s3eEJHbtWecmxPgB6ywZOBOGTlyrRVsmHX+FcBqg7JJshhn7fO5Pm7Ad+iczYqRZrEzw7VYMmKf2LrjJFgCnrmBcf3y1lypedgm+nG4WTIay/ohDWxGrF0AwRRpwesnfSSw6X5/agMPjV3y0nAeoirqmN8jvP4TwFLxSR4WBVqMFr1OQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5060b0-9f8d-4971-15e6-08d8705506b7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 15:22:56.1372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uHuk/4IGYpGfnMU+ZfAQpZU/fjY+AzrFMXF71Hj11MfLGOZTpn2wIZvHN26caEHzir2hIghhc/li8+dUy2ekHnzSLMNj8B32hOTMcEjvDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3093
Received-SPF: pass client-ip=40.107.2.126;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 11:22:57
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

14.10.2020 15:51, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
>> COR-driver to skip unneeded reading. It can be taken into account for
>> the COR-algorithms optimization. That check is being made during the
>> block stream job by the moment.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 13 +++++++++----
>>   block/io.c           |  3 ++-
>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index b136895..278a11a 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -148,10 +148,15 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
>>               }
>>           }
>>   
>> -        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
>> -                                  local_flags);
>> -        if (ret < 0) {
>> -            return ret;
>> +        if (!!(flags & BDRV_REQ_PREFETCH) &
> 
> How about dropping the double negation and using a logical && instead of
> the binary &?
> 
>> +            !(local_flags & BDRV_REQ_COPY_ON_READ)) {
>> +            /* Skip non-guest reads if no copy needed */
>> +        } else {
> 
> Hm.  I would have just written the negated form
> 
> (!(flags & BDRV_REQ_PREFETCH) || (local_flags & BDRV_REQ_COPY_ON_READ))
> 
> and put the “skip” comment above that condition.
> 
> (Since local_flags is initialized to flags, it can be written as a
> single comparison, but that’s a matter of taste and I’m not going to
> recommend either over the other:
> 
> ((local_flags & (BDRV_REQ_PREFETCH | BDRV_REQ_COPY_ON_READ)) !=
> BDRV_REQ_PREFETCH)
> 
> )
> 
>> +            ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
>> +                                      local_flags);
>> +            if (ret < 0) {
>> +                return ret;
>> +            }
>>           }
>>   
>>           offset += n;
>> diff --git a/block/io.c b/block/io.c
>> index 11df188..bff1808 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1512,7 +1512,8 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>>   
>>       max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
>>       if (bytes <= max_bytes && bytes <= max_transfer) {
>> -        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset, 0);
>> +        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset,
>> +                                 flags & bs->supported_read_flags);


When BDRV_REQ_PREFETCH is passed, qiov may be (and generally should be) NULL. This means, that we can't just drop the flag when call the driver that doesn't support it.

Actually, if driver doesn't support the PREFETCH flag we should do nothing.


> 
> Ah, OK.  I see.  I expected this to be a separate patch.  I still wonder
> why it isn’t.
> 


Could it be part of patch 07? I mean introduce new field supported_read_flags and handle it in generic code in one patch, prior to implementing support for it in COR driver.


-- 
Best regards,
Vladimir

