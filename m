Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E1DC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A862082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VQmEX91N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A862082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1vP-0004kM-1r
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU1tq-0002L8-UY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU1tp-0005yG-Q0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:38:18 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com
 ([40.107.5.97]:41478 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU1sp-0005O6-NR; Thu, 30 Apr 2020 01:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TirpeV83doL2u7YIkCTcBvsghu4U6t3bukbkLksuyRJNsNW7UKSKjHaILZZCsj1L/pwE3yY3eWaOi0rvo8IptHTS0JgABmDniUp17WBlZpRFIkgW60H2dwNIkpquMbUs8dprw24kG+AyiTknCDIQzouHIfnlHbmIu4a5EBUtOJVXxL0gBJ17yAWKYozWK+z2HgZ29jSMh06P5tUnKpPthLoxd/65aeTC5sIYSSY9k7RjL+vTLZRNthqyPDlrpl11dmf0nnC6Tkndy7YEPiI+DT7zMoIrwrNckMAUuKAHRgOkfuArnBm64pC5SAaJ/H9Eyyfu0ZA8tvL4e8t0x6RI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8/KNNaT7NJHWrMD7AGxY+FnW7hpnYkmlwnSq3P92TM=;
 b=UfPDTrK85ohPm3P9/VKtBjQeyQ85DSJN/T4GOrGNe29IFrRdy9DRePdxQx5yCeUqB4Hxk//3GQSzmtwd80tQHZ5PEmVNUGgXJ+5rjuzOYe/FnFAIVIJRQC0OPSP/PUbF97eJ9ARj9GrPPAikQ3XuaRGpxQ4Cd9XPSY0nwfimWOktWn4RxLKP4uuv4mBMQixRchbm52pwr1vAJrqZ4r8Gj4IMZcedyrNZ+t1dqV+ksOMu392rTLjkjloTZby7lyL32JJeiO8iKaIaAwbQe2WEXeI9+fChfBjfu4ZyCZozB1aTItQ03Jk0+dobC0JMkeb0cS5x6L+0GQb6U04ebV99pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8/KNNaT7NJHWrMD7AGxY+FnW7hpnYkmlwnSq3P92TM=;
 b=VQmEX91NPcTIxe5GGbDDex9ZcPn7/don8S9+ACxFyEBxdaZcQH3oWQHkR/2qvxqvJeUKGUautsWqWwtmEJB7Jd/oBqszdACwXKkF27y7+WDxZLzOpaLKbIvUMnB7V+ZVsjpsCOJGxzR/k0sr6H9C5ujiY9tqk4auTCfT+Ldu5wU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5351.eurprd08.prod.outlook.com (2603:10a6:20b:dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 05:37:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 05:37:12 +0000
Subject: Re: [PATCH v2 06/17] block/io: support int64_t bytes in
 bdrv_aligned_pwritev()
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-7-vsementsov@virtuozzo.com>
 <f45f380b-8e7b-1483-d685-4e7d4729562a@redhat.com>
 <7d64fb96-87b3-f0d8-144b-68e3775ed9d0@virtuozzo.com>
 <3b8fd6f0-21bf-0a52-1168-36970afd3d02@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430083710271
Message-ID: <8a2a99a0-e37c-8a2a-a395-7a83292733e2@virtuozzo.com>
Date: Thu, 30 Apr 2020 08:37:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <3b8fd6f0-21bf-0a52-1168-36970afd3d02@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 05:37:11 +0000
X-Tagtoolbar-Keys: D20200430083710271
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5b22342-70f0-4ade-ed0e-08d7ecc88893
X-MS-TrafficTypeDiagnostic: AM7PR08MB5351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5351F22AD37AF206EA166CB6C1AA0@AM7PR08MB5351.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq+k5CpjDSHU0CXbsTz0yVC2nYQCbKYHKBgFeW0BhQ1Xl76ITVDUobr4EJhhaDd8wl45WsT3bE2pYtrLxKq81bWoPwsINltKqm40GjUtlaAFW3NQKO002xUCOafG1AhbGE+K8f9VADEeN0B7WK0fkikookskCdDFy5+AAd656yC9Iak/w9Ci5nU3fgoQMQurJw4yLP3JhxUGL01HcsknojJgyzAaNWASDzWie88wiRUdQvCQD0WGg2lvb9hLrCaKCQNoZhjVZjJpYQKNCPVelIamJARdK1i9WEXEAEvZL5lwCiIAVVwRV1K4L3HFVABVuOUG3KZKxrh5SAjALRiTIGj2mfpt0ef3KMFHstnWxvlVYF1pDVjG68fPbDZSGqnkhnigrY3JQaGabAHHya8iWYKYK+6qcrLK2FGv+QhsESDdAV8cdBGSUPS8sxztr23NUaqaB9xDvmrcDR4eA1cqjRCoHyAd7TRTcmxZGAAmRRuOXrqFkyuJptAZtNdNh/UT4cIzyN4pZcO3KxpWumEOeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(366004)(136003)(376002)(346002)(31686004)(956004)(53546011)(26005)(186003)(52116002)(16526019)(7416002)(2616005)(8676002)(2906002)(16576012)(107886003)(4326008)(8936002)(316002)(66946007)(31696002)(5660300002)(86362001)(36756003)(966005)(66476007)(6486002)(478600001)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kNO9Bq0oo4TdIZrLa8Rfg1BzEgxWac8llaUYKUitFUXxevH0+4WLoJ6E7cez2S6XUsTN94puB1AZQ6UVEyDSawtBOTP908eaM6AlFUovFaeTb9i7EZR++I1EHPrf5C2mhFvcPvllFmYhasTs9F+8tK7iDZsluvf4dTnxs5keULkIqxdi8U+fh/ft1tqxgY9OkLKg5BMAny/vL3MM+HdcyypQyxOaqkN0UOUftXhW5vPcDZ4LVNZz7RZS38jfGF3/d6Wx64SkBolk735oV67NrMQQb/7JHwnXwSCaxXwdc9YEwoojakszYWk4sQuq6e7cKWvmJ79e//VDwKYPXeV1XhrPr+e8Wub5hhUUBnqu0Nw+y+SByGX4G8BOEtqbBXcrWGB/kwlGw7SV8fTdVGJGE1rCDCB5tKm9zJTFly7FmIkwg/h5pht5F0ggcUvxD66ew28nBozf8MY41JTPQDXUBFMHWXYBLR/H8NAUtLTy+xJoApEmxwgPnqykic6MDPZX23rR4jAGP7ztvCh5rwmlQZAThBcJ1ycmdhv4577Tk8KSDC5P74dFa3KnOPZa/ngmQormozPTM+1fpq8cKrxFRXAFTHafIaGCCa2GVT3sjfWZGs4TW9gQbA8KL2TnzdpJcjqvlcVR1lWXB1AJupO9h3LMLwPWgd3+poPYDpn8VjqRrZnrsi0gQTqGW7dphUngCq97vkpsOWFwuZ8yys/lMGuh0HL3KAzfpxOTmBF1w4SwQYYluHLMTBeiwf6TL2jpsV8ygTFqtyFOIRXIJfQgYgxx/ddttMyrJ88J8oOwu7Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b22342-70f0-4ade-ed0e-08d7ecc88893
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 05:37:12.6688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZY/ZyxfMTE1sOUUX17LWrhkmIvUyikV9G+j04d0t1KdGg7QPhc3O+lFS0GpwQDGwPOBt+TjDNVzQJ+YfQiApPQ56nTujFM0zfgHRS8tbB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5351
Received-SPF: pass client-ip=40.107.5.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:37:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.5.97
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org, dillaman@redhat.com,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.04.2020 8:30, Vladimir Sementsov-Ogievskiy wrote:
> 30.04.2020 8:25, Vladimir Sementsov-Ogievskiy wrote:
>> 30.04.2020 1:04, Eric Blake wrote:
>>> On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> We are generally moving to int64_t for both offset and bytes parameters
>>>> on all io paths. Prepare bdrv_aligned_pwritev() now (and convert the
>>>> dependencies: bdrv_co_write_req_prepare() and
>>>> bdrv_co_write_req_finish() to signed type bytes)
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>   block/io.c | 12 +++++++-----
>>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/block/io.c b/block/io.c
>>>> index c8c30e3699..fe19e09034 100644
>>>> --- a/block/io.c
>>>> +++ b/block/io.c
>>>> @@ -1854,7 +1854,7 @@ fail:
>>>>   }
>>>>   static inline int coroutine_fn
>>>> -bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
>>>> +bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
>>>>                             BdrvTrackedRequest *req, int flags)
>>>>   {
>>>
>>> No change in size.  First, check usage within function:
>>>      int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
>>> Changes computation from uint64_t to int64_t.  This causes a borderline bug on images between INT64_MAX-511 and INT64_MAX (nbdkit can produce such images over NBD, although they are atypical on disk), where DIV_ROUND_UP() would give the right answer as uint64_t but a negative answer with int64_t.  As those images are not sector-aligned, maybe we don't need to care?
>>> all other uses appear to be within asserts related to offset+bytes being positive, so that's what we should check for.
>>>
>>> Callers:
>>> bdrv_aligned_pwritev() - changed in this patch to 'int64_t', analyzed below [1]
>>> bdrv_co_pdiscard() - already passes 'int64_t', also checks for offset+bytes overflow - safe
>>> bdrv_co_copy_range_internal() - 'uint64_t', but already analyzed for 3/17 how it was capped < 2M - safe
>>> bdrv_co_truncate() - already passes 'int64_t', passes new_bytes computed by subtracting from a positive 'int64_t offset' - safe
>>>
>>>
>>> [1] except I hit the end of my work day, so my analysis will have to continue tomorrow...
>>>
>>
>> Thanks for reviewing!
>>
>> I'm very sorry, I just need to say once again: the series should be rebased on "[PATCH for-5.0? 0/9] block/io: safer inc/dec in_flight sections", as it is already mostly reviewed by Stefan. Seems, that your analysis will be still valid after it, although patches will change. I'll do it now to see, can I keep your r-b's.
>>
> 
> I mean "[PATCH v2 0/9] block/io: safer inc/dec in_flight sections" of course
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04559.html
> 
> 

Cool! Exactly up to this patch (inclusive) it rebases without conflicts. And the next patch (and may be further) are conflicting. I'll finish rebasing and resend.

-- 
Best regards,
Vladimir

