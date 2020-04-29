Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18EFC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764B2206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AWSi8peA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764B2206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTew3-0005UK-HA
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 01:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTevM-0004d0-3h
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTevL-0002Y8-NA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:06:19 -0400
Received: from mail-vi1eur05on2123.outbound.protection.outlook.com
 ([40.107.21.123]:47952 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTev4-00026x-K8; Wed, 29 Apr 2020 01:06:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI8G+ocSC+0v8hnSTGdPYALlJLG3+2fdVYAykpPmFK+G6NknKg4bdk6DPTWYNL1hPXWEE0uUMltCQNK3L3j8Mofr69P+pyeSSelQj+vBF0G9iB2Y5vqbUWv/oJL68dR/XvUnn3467cU5y8GXrAcdbtOnXyNqYrk7pUVW9UD7bvE+upu/Q5RUv0SyudQ33EEz7aqEU1gG3615ZcFhu2ekuMRsV2bqszK+7mDDCvmjqP+GFBzZRyKgBdoDrPkzB76UCaYgAdN+O7hT9z6nC8bTSJZBEwuzBNZYJTH4FazcvJJY249YkUtWmIwh/QFNyUR4Qon3dDp9Vi6qtvcRHWxMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztZeSQ4TbdUMefDpXsrM5s9wza8CqbKlCcS/MfRtV54=;
 b=id2n5DXfdbTTJG5mbQ/zm5k4SSaU/xBAUOCbpFbMlLnk3aXGPnXSIBMmRTUBbXYzImYt6Qaz+MD4yakWmPyBjl2dOle7IJEcxsME4xcIyPqwfTgOBKznEdNKZ/mAq5XRMjN72PbRtkgAX4Oq4NSwUOewCjO11Y0ke0T5cMbtDOiQCWuFxxd8s21gf7qWwzEvaWVndvqIKICNorkEGRNGU29tXUYBonlvj2mN3nXJHdLlA9kiVA/d3KWbsM/fjmhCUYAPavrDmXA2LL5rnONfthTae0wbI1VSHY0RAoaIEQt1jx6kY2T4ZkCSjCUUSDY3XPonv1x9K6X9atOw/kLwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztZeSQ4TbdUMefDpXsrM5s9wza8CqbKlCcS/MfRtV54=;
 b=AWSi8peAKvdVHVGLbISdv07D7+QJGcA1HHEG3OcJUnr6iFr1KJHv/+FV48nm1tVcsO5lJ1hqgZqz3XieVhNbI0eXXUduTmr7ZEKmMS0GxhJfn6v5qXg47/llvzWWHg7wWUdZ8vaO2EPtbTsa7vQRrp2DezO3+D9lG5of7/VHzpw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5320.eurprd08.prod.outlook.com (2603:10a6:20b:103::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 05:05:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 05:05:58 +0000
Subject: Re: [PATCH v2 01/17] block/throttle-groups:
 throttle_group_co_io_limits_intercept(): 64bit bytes
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-2-vsementsov@virtuozzo.com>
 <ee14ab9f-023d-b913-7040-d4e0bd1d3104@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429080555732
Message-ID: <f62763d5-cd42-41dd-e09d-79087a67e709@virtuozzo.com>
Date: Wed, 29 Apr 2020 08:05:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ee14ab9f-023d-b913-7040-d4e0bd1d3104@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM4P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 05:05:56 +0000
X-Tagtoolbar-Keys: D20200429080555732
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca626d8-b9bf-4a48-a121-08d7ebfb00c4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5320BF36B4715958997D76FFC1AD0@AM7PR08MB5320.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39830400003)(136003)(396003)(346002)(366004)(52116002)(26005)(107886003)(53546011)(36756003)(31686004)(956004)(8676002)(8936002)(6486002)(2616005)(186003)(478600001)(16526019)(2906002)(316002)(16576012)(5660300002)(31696002)(4326008)(7416002)(66556008)(86362001)(66476007)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3LSDLsJIXJLRpG9OMyr59cxiXwClAsGclgYYn7synHPNuwlgUgnWMSyhl7EpzhnZLHb3SH30XGoJ16dBJJVjdhJ8OJF2bR20YnKpo9eOkCDlb7lgMUU61Re+XChxEgz3xe0Jm47xdHLE/FIjmlB8W7Mii/c5eiUhupv8lNKUdbmoWjoQZ7sBVBJv8GVyTFC4UJ04iICql1DnFYdoWc6PzkLIMig9CSUIy63E5TC9Bf8SwgoALkmVXwp1StuzTYK6zXEBORiT7vu6AgUgTy/siqw3WysVZuonHxZo6wpxbyv4TMpiQIqH2mWSsbvsBWpoDhFk4hyyDVPLlCFdXOAFj/90BD9hjv1TaVriZedjl4XkFFrzlAFL2ZiaYNacq1Xt9N8GaoQcQpgz+Ol/bWn4mIixC2Cxd6pLIIR49IMN9GbcnSxam0g84j4n9e6l/3xK
X-MS-Exchange-AntiSpam-MessageData: 6YR+OeELMoHz4FdqH+AaN7fcKEYR13l5ieArjbVgD4OH5jogZOHlsLbkDOjDujF7nBHUbCXKRk8eCm70+H96oV1EuZAGv9I4Mzyg0iZNmYdSQLmB6MC3R2Whe3+vePcfFuCC6PFvK+vmSk6SSRjtzTSJUdCybw9QqbvhG91WklyIaQpQsE2mo4tMcuv7V0zomBKPtopqZRInpYlO3mkbBZIBSBZTpdMhLm3TwL9sJAt4kkv+ozFpiL6EP4QUhLNIVrhrwlP/Rhswl3EMBtx92k+vqkpSBT6EJ2R/Z61v+aR2oUWvgnZkpEOpIDQtkaGnHZskvAGPtrISda/2yWsqeRpDG2TKoYsr5JemtbksxDoAESk9BilV3Q1OLKUPw23rTiwqX4aGtU2E5+MXB75KTg9nxCaW8QXLSPM8bGkyXOe9f1lWEH7zzfqmjmvAjnWfqgS8Iz4VGkczMu35/dUvxCYyEyVp5dInwOdVk4oxkk/FEzsWlNeG0Gt5SzmqDbo+Slqk2KsP/FDgkDWrXVLGn/sI+XkxRFf/ybiBNdUF5K1zuFr3jnvwIdysxLL/W1LsEcwZ2SYhapPr4eS9gGi21rNXVUfbYq15fAnj1z772s5khA8qpjYRhpGVg4XPqdD+kwt/qSPILLMWD81Gnfwe44PxWvjNzqTHhuJJFRMii+VamFIoxpb7O9IlaVoOs1cNKKizpqmXQsnQTcI9lCv1KcNPf3HJGx+WY+wDimHXsyii4sMSii9sopIsOn/Zqx5v2movQlNloB7neNx7VgrmvXJ5TGdMnGUBlHOHgT9JKmk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca626d8-b9bf-4a48-a121-08d7ebfb00c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 05:05:58.1844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w08WGWk4QIdnnFr6JrzoXZfyTp+wh62H+jSSnUWnl99f+r11QejJIpRPAPtrN/hwWRUnICL8yG/1RaD9IJKPrcCCM0hwXwyJkQajGqAj198=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5320
Received-SPF: pass client-ip=40.107.21.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:05:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.123
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

29.04.2020 1:09, Eric Blake wrote:
> On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The function is called from 64bit io handlers, and bytes is just passed
>> to throttle_account() which is 64bit too (unsigned though). So, let's
>> convert intermediate argument to 64bit too.
> 
> My audit for this patch:
> 
> Caller has 32-bit, this patch now causes widening which is safe:
> block/block-backend.c: blk_do_preadv() passes 'unsigned int'
> block/block-backend.c: blk_do_pwritev_part() passes 'unsigned int'
> block/throttle.c: throttle_co_pwrite_zeroes() passes 'int'
> block/throttle.c: throttle_co_pdiscard() passes 'int'
> 
> Caller has 64-bit, this patch fixes potential bug where pre-patch could narrow, except it's easy enough to trace that callers are still capped at 2G actions:
> block/throttle.c: throttle_co_preadv() passes 'uint64_t'
> block/throttle.c: throttle_co_pwritev() passes 'uint64_t'
> 
> Implementation in question: block/throttle-groups.c throttle_group_co_io_limits_intercept() takes 'unsigned int bytes' and uses it:
> argument to util/throttle.c throttle_account(uint64_t)
> 
> All safe: it patches a latent bug, and does not introduce any 64-bit gotchas once throttle_co_p{read,write}v are relaxed, and assuming throttle_account() is not buggy.

Should I add this all to commit message?

> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/throttle-groups.h | 2 +-
>>   block/throttle-groups.c         | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks for careful review!

-- 
Best regards,
Vladimir

