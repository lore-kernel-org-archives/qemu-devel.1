Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D005CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 18:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4AF20760
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 18:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RxuvigJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4AF20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtENX-0008A9-VD
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 14:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEMP-0007Xn-9b; Wed, 08 Jul 2020 13:59:57 -0400
Received: from mail-eopbgr150120.outbound.protection.outlook.com
 ([40.107.15.120]:60676 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEMM-0000cT-O7; Wed, 08 Jul 2020 13:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VW1g/nY7dAsYIIrcIpYXBd4da3YCsK8eVzjvtDU+hy+RMJ8ucNkgZ6njQ8cN2t7KuFYUXGs8AIAlBAdStKQVwklLLMIf7TOkuH/JPuOzSdP/GLvxYU3f9cankJBMNjm0pguq4MIxnAkzbzVCAZzCQO+1FHMkf5isjrpt4H7IlM0xZ2+kG6kWfXjVN1BoMZwuKY365WAOyXIuw4HoeNp7IE2FW/xu9xMO/jyCbPprDQFFg4lNYF50cpB/Im+di/P5m2PkKR46rNDggqBw5vL0malRavjuHJiOQYaqVxolnJS/Vta3tds+IQSljnfqUI0ZhxXRSsmnnIgu7ZbWHJWvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjGQA7ZxKnEfazb0vphmnFtq0BSJv0uqo8FxxnP3/04=;
 b=Sr5noUcrLvne3fbpQuPiZyWq0Fpr4mlhE77LpqTc2devb2Ct3jJSu5sYjVMwEBBNbvvkZ3zGYeerMfoMfiWKhFzFSGY4De3THItetbbPWUPiykD0LKlQmqLt67Xoal0fwHZcuYCeBxDB+bGavrRmi5yg5hUYR+eIngmNBehWDqOLmNIYxY29WULGHQj/8fmgxaWGtn6iHCjXi8N0GMW/cRrvf0h4CRJOAJF9nOixaJfWRyuqAbh8yiOhib91eFTWoNFDbiJhit3htZt1zC8UZNCiEe5C4pRIEhWJobW5E3JcYK9hrNk63pyAjRkHeb7wM3K6KOn9xMQB2i6DK0Fjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjGQA7ZxKnEfazb0vphmnFtq0BSJv0uqo8FxxnP3/04=;
 b=RxuvigJHSt7B2evn+dkwEfYg0x2tqcj++f1SEjmwYS5PaeMUT+yGZtfKA/NOz1pSvKqVC6RR9vvPWTXc0nCpB5AXED6UN24TLd/4BWkKGnwu3enNghEsMtD6+2J20p22ylaRwYb2rJxiJBLFO8ogMdVryqkdE9lnWXq5Nn/MCF4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 17:59:52 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:59:52 +0000
Subject: Re: [PATCH v7 11/47] backup-top: Support compressed writes
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-12-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <3e7954f8-c5f8-c016-7c31-ed77c3317a49@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:59:49 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-12-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Wed, 8 Jul 2020 17:59:50 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84437dc6-d1d2-4b0a-32ff-08d82368b683
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610291BD92A210D00C0186FF4670@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPkofbixdF7LnduGS8390jn9qxigKMbXYC7Qd64HoFKtHB8WwAbpiZkVzycicEDeNHb4mp3Rc0DQdjNrTfjDUZwBoCcDpioH7ljEqaHkCZ2mYUmy9YKJVxwhbeRLClLhr0XHICdOwX9YEgq12WcuNgkVPYOkMNrHXQN+EWtZ31YZeZI3NDPkZqXJW9awT+0ayr005UQ7jJvSfGXODQv6dZ5oKIOCR/mQYilpmpoBuz7XB0TmrAzjNg/LaLtkHi1XDCiku+VSywKAD9PSOwhuOM5y7H+kdenKTOFaEddoSiT+QGTkTrVwfN3lds3S5ptPdgpDq2SPtnsMmyl43dxrTsphEdTnm+KQvW4NB2eI2IxeS9UpK2DXhaffAK3sCLCc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39840400004)(376002)(396003)(346002)(316002)(5660300002)(52116002)(54906003)(8936002)(26005)(6486002)(53546011)(6512007)(2906002)(186003)(16526019)(6506007)(31696002)(66556008)(86362001)(66946007)(66476007)(36756003)(956004)(2616005)(4326008)(44832011)(31686004)(8676002)(83380400001)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ds2VrH9KAjiB0vL15UdC4e2SJyHeXx8SYqnMDtwG31Vjkg0Tu8ynnxHc0K8r7I6x82byj0CGz8k5avDSaUUaizuKwWYsR1kYVbx/kWnuBImc8noNrJoJlK9asJrkqsC8ikRIERJNBOunsrr9D6raaCog3/ykl4CY0t2FNr0/gaXGsH8bSwp8FvdN8RSqL4kwRtQF88GnQbCfM/6I0n06pPXNm4va/6D8GGvzK+ZCvRoZUtEqEDWw1+kJJJsgr8ZQ0OUAwkCGVuDnRiZY6ozlRZYHDQu3oUTsP6MIOkvq0b1VHQgNZFz97EyHK2UYuuXo2lJCXgZlMf2xXgM2iTpwKWB+K1Zs8VRFLZn9z7Ye3nhjGxS6CaADRLDQz0Gnb8ui6DJFMk2wJ7hl3/gwmlVx/XGsIUJnpP/3y92uaIY6vY0gyX2oRFIj3r78PnFufiDkrQV7XZWW/6Pme+uHR+ZF9Pqyxcl3c3orgC61Wx3Ooesk4yIqmZgobGYd26FqbTqq
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84437dc6-d1d2-4b0a-32ff-08d82368b683
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:59:52.1046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU2bF7wFBs3KoV2T+deNHBpB2WEhNj4e/o29RLRy+aaY1PmxqkNpxhtRRA/6KsbLewraIYaupHz28vbuogO0R0GJ9WqM6XR/nqJX42nJvbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.15.120;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:59:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25.06.2020 18:21, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/backup-top.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/block/backup-top.c b/block/backup-top.c
> index af2f20f346..f304df8f26 100644
> --- a/block/backup-top.c
> +++ b/block/backup-top.c
> @@ -99,6 +99,15 @@ static coroutine_fn int backup_top_co_pwritev(BlockDriverState *bs,
>       return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
>   }
>   
> +static coroutine_fn int backup_top_co_pwritev_compressed(BlockDriverState *bs,
> +                                                         uint64_t offset,
> +                                                         uint64_t bytes,
> +                                                         QEMUIOVector *qiov)
> +{
> +    return backup_top_co_pwritev(bs, offset, bytes, qiov,
> +                                 BDRV_REQ_WRITE_COMPRESSED);
> +}
> +
>   static int coroutine_fn backup_top_co_flush(BlockDriverState *bs)
>   {
>       if (!bs->backing) {
> @@ -173,6 +182,7 @@ BlockDriver bdrv_backup_top_filter = {
>       .bdrv_co_pwritev            = backup_top_co_pwritev,
>       .bdrv_co_pwrite_zeroes      = backup_top_co_pwrite_zeroes,
>       .bdrv_co_pdiscard           = backup_top_co_pdiscard,
> +    .bdrv_co_pwritev_compressed = backup_top_co_pwritev_compressed,
>       .bdrv_co_flush              = backup_top_co_flush,
>   
>       .bdrv_co_block_status       = bdrv_co_block_status_from_backing,

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


