Return-Path: <SRS0=xk1j=BM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85333C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 11:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4791920738
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 11:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wewJ0GkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4791920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2CPu-0003tZ-IZ
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 07:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k2CP0-0003Og-6X; Sun, 02 Aug 2020 07:43:42 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:37349 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k2COw-0004Cj-TX; Sun, 02 Aug 2020 07:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCjO2aAup1Mhe8vcWbP7RnVNvsWAXdZvW5XhzccPfx+zxUWfcbh4pCQqYCGQpvERAKtHquAjGX/3zPQbtBVfKQA6DB7Mq2m5facALv/E36ypjGt3rqvb8Y0ERVKb24Z0rF++qg72+SnXNyYOfWGwax3g6VFsiYqPIhSp8mpFBEEWS2qPf2hFH1eOLSM/ty7jiI5HIBAU29bcL0F/CLw5ulqHOzxspoIteq52qe0n+pk2WjXzi70vevlGKvzk8JEfFd5aiZjSBDXKAY6oX6NYDDBwk6dVS+DEOQpQUbK4MBV1wJQP/z5zXiwbOMzs4GWSaZlwDLEEDIYA1Q7XjgbaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmkKWkzNTxLWmZzjg1yjhDd9yIAQYduQLp41hpfLZ8U=;
 b=B2NmuRaredmIKI+S3SPoM4PocYJ9160G9pKMQRtkH4RXNKz/Q4WP5Q9uxEk9RXsBIilBKLHFsapOBMsAATlw7VxqvBb+K2z4GW4BT1eVz+PK7DH0Vs/UZF+RTdtDvmhLQYi/k6BQnwrjhLIPaiJg7vJt+y68GPWWz6M8d+xv/Gq1/sBaGophOWRNZX1vQR+Wyay1K4gvPPceDxqmFm8fmyk04jy++gw1YuxIV9lXc3acU7Daq3+yB5oHBO5+0bfOWZ/yDO9mIo89kDoqsYBaRxK2JptOD3ZzADmTaJaiWn3AdtZwQ2J/Uf5hsht2GYlGqZba4yto8tkDkh/AkgliwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmkKWkzNTxLWmZzjg1yjhDd9yIAQYduQLp41hpfLZ8U=;
 b=wewJ0GkK8BUonG4HrTpmKK77WDksZjsFMHdnrXeWbtqv3a7rXvVlmn3CacPEnYt7WbmoK1hEMq3xyehya+d30geUJapXac5TXpk+pyow+u/zEtDjjKo4w9chA8+FUoYfn3obZ5NSOH08FyaYcJmIGVBBKuz8NjvXr0B5WXUTi3s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB5030.eurprd08.prod.outlook.com (2603:10a6:20b:e1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Sun, 2 Aug
 2020 11:43:34 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3239.021; Sun, 2 Aug 2020
 11:43:34 +0000
Subject: Re: [PATCH v7 47/47] iotests: Test committing to overridden backing
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-48-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <d3344dc9-1e91-4405-af2c-50812b10ee86@virtuozzo.com>
Date: Sun, 2 Aug 2020 14:43:31 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-48-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR03CA0044.eurprd03.prod.outlook.com (2603:10a6:208::21)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR03CA0044.eurprd03.prod.outlook.com (2603:10a6:208::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Sun, 2 Aug 2020 11:43:32 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0958887d-1bab-43f9-2071-08d836d949bb
X-MS-TrafficTypeDiagnostic: AM6PR08MB5030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5030C99CBBB1CE18A09D32DAF44C0@AM6PR08MB5030.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUPrB4Qx7nt+tBl9gYFzXwKrxMKuqSgopkCDEG73zSMA+B4slYIPx3hc2xR4qa9ga0Zes8Dup1r9pEEr8gPJ2kj4+eTZG+CCus8ZsYM7BNfMwqgGIA/IsFHWVSaH0bpxqiffkoroMAbDq02jGMN9ss7ZBYmXO6/xjjNC9PX93gaQWsm9dnqFfZ02LrDcXKfpAJCXKgcSFdNVfNbbfF8Hj7NdC2WbJAxXhTC1PqQ5K3ayaewhvYuWUpD3c7L6MkQsut6qHUm1vyalKQQMK7yzHLAtgvVa43s3j75ld2cOWRjGVp7bfAQjiV96g3qthtkYs6DP1EI19NFFl9G/z6tN+OqwpEUPBHKUQa+K6hyUWtPX5uq14mGGZWD+1v9lhLmj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39830400003)(396003)(346002)(366004)(136003)(376002)(6486002)(26005)(478600001)(8676002)(6512007)(2906002)(83380400001)(186003)(316002)(4326008)(16526019)(44832011)(8936002)(54906003)(31696002)(52116002)(6506007)(956004)(2616005)(66556008)(66946007)(66476007)(36756003)(53546011)(31686004)(5660300002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jidygCVrk3hVUrzBG5VvntnzKIWFHP1mF61IEW7WDtBWFfOCn5nzWbaZVEIhFMDUEteRU+Ndva1QJehyLzqQ/aKOzCXAALnbVoqLq7c4kJmsQ1+PqICzgrL+TAek9d/skU96gwjec6xPmiGLvGl+zDcGxuxmx3nwWfqk03KJ3bgOCycGeaxwMayUZfeQsES0NV2LEn9wOdM8J4wi4++xnTjM93ADOQ+C01CPnCjC6Vnj+W6mPXoi03CnTBUB6bdWSe0nWl27c2iieDYKjJs+dqKdPARS/nncFIoLxASd22OxnUlCP1ES2+4/Ea1yKTFAR0TwkvpPMITIDJE2ClpYo7V2/DlS0H6+DC1tkWk1YUPsOUZGOsyXMMU5ZFw9OiETKdO3FkT+qBb1tEGtU2fY8FRwHF+CEQsK8Ng2LQoCO/oMpa7lGDqMxx0hhrs09HIDQu4xEtG7X7iRT5Qj6KBM5KZKsw1Du3fqoeZnhgdlPMuDkT3NxjIitIvx2XjpK6tzN7vwC7zCQPFk4a8dy2tXCmR8JBtXHObham0nVW/ieBEUkShg7XCqL6hHKVhkzOXtaWbjmaLxgTPlYw1oSg2W7el1gxbP/8kbkfjZo1DheT7SVJ9EfcLwZtTgVl5QI3MxnMTPaKEw8VVb3+JPSGdjPg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0958887d-1bab-43f9-2071-08d836d949bb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2020 11:43:34.8227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fRhAlXZiI3ilEn1CZ9an9d70YRIJuH07BrjbKTECh+hsz3JQOGJQoTatbU/ztB3716eLbxAAET3tIMlfViMDSaHAdeVr6qc9kCYBqMPbbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5030
Received-SPF: pass client-ip=40.107.4.94;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/02 07:43:35
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:22, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/040     | 61 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/040.out |  4 +--
>   2 files changed, 63 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index e7fa244738..dfd46ddcbe 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -890,6 +890,67 @@ class TestCommitWithFilters(iotests.QMPTestCase):
>           # 3 has been comitted into 2
>           self.pattern_files[3] = self.img2
>   
> +class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
> +    img_base_a = os.path.join(iotests.test_dir, 'base_a.img')
> +    img_base_b = os.path.join(iotests.test_dir, 'base_b.img')
...
> diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
> index 4823c113d5..1bb1dc5f0e 100644
> --- a/tests/qemu-iotests/040.out
> +++ b/tests/qemu-iotests/040.out
> @@ -1,5 +1,5 @@
> -...............................................................
> +.................................................................
>   ----------------------------------------------------------------------
> -Ran 63 tests
> +Ran 65 tests
>   
>   OK


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



