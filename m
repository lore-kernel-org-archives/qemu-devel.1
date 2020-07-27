Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB92C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03F42070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dYCeXNy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03F42070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k07CX-0004Ub-5b
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k07Bd-0003ff-Lx; Mon, 27 Jul 2020 13:45:18 -0400
Received: from mail-vi1eur05on2104.outbound.protection.outlook.com
 ([40.107.21.104]:59873 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k07BZ-00062q-TJ; Mon, 27 Jul 2020 13:45:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMzXIy4PgjrUlF2rJBc1yyUOOgDDeCLQv695a/ISOBKmbMXVjnf/DsOOkax7fXmSOqmch9LblnCn3kgJqxbpCdvaVkpqP6cGRGNT8kSF6wh4d1ORcDq4L2tk5WtncUaQSUGXhCJGzYt19nn461cq2pkjrbhvmZFjgmyj3ynUEdzfgwfNrnpy/10xG3evMi1Wo0Evv6/Gr8T1/+oq9YvGTRkepPYEemWyz6zQ4Kg23/pftRYpx20k//hFxcvCFNSCnMVztLe4+wUNoX2QDRzmJ06GGQSJpaOJ0pUETB8wrkRGYvgifiCOEbYUCE6RFpsM/QwQP3ffcfW9SO7P7YVteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceBaObO+imxY0tzqUt3SM/M90klFkZkQyAZNlK0TMYk=;
 b=JSzmXiZHvV+jWr12QzXNYf0Udup/pBUqjW164p6ZzhX1UtYCS+mcozFRFoB+MW+L7mLKc7AzWAmgGdSOZlrKZgwRpKceIlnAUD9Re0fdOgai361bPWz/sIRaEwKIlvQ3Q95RbsDC5v3USray6J/1ElIMQCSQ8QDw3EXA3WXdonhs37KHABu1xGaO8PcBwyl5L4VmPaxdh4YHDHrBRDC3j9vtD7zPjp+1e+2FflEEubCZs7AF0bbzpp7jWiwPnq7n0jr3Z/buxTmif9yHlf7QBFi9J5dgo+fh3nYfovQ/y7BTfB3tadR5aOU0zI2kd7PI0inVIXhX3Y1DyR4bEdhT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceBaObO+imxY0tzqUt3SM/M90klFkZkQyAZNlK0TMYk=;
 b=dYCeXNy7zGNKHqtHr+sf5hgL7YIgs2hLNetJs6+oMpIQ+tJGhxUQcPs+nAJDtUKMTifImUjtHMkLFnUaeFD6AyE+CFwGo6RPxlW3ko4ZMrXeVEDMKcz2Rq1jkTZh0JYMr7ozJBJ6U3o5CQVNq9W+5fYy6kIqtWTbIv7ldTSqgDk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0801MB1651.eurprd08.prod.outlook.com (2603:10a6:203:39::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 17:45:10 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 17:45:09 +0000
Subject: Re: [PATCH v7 44/47] iotests: Add filter commit test cases
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-45-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <2c1c30da-a1e5-3bc6-0620-50ebdccb7dfc@virtuozzo.com>
Date: Mon, 27 Jul 2020 20:45:04 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-45-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Mon, 27 Jul 2020 17:45:05 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0ec9041-e94e-48a1-760b-08d83254ce7b
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1651:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB165184A09D265DCD1F6C5935F4720@AM5PR0801MB1651.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5KLil4Vag03FnXGylGPOdRCVkZUC08Z2FaGULlMQGFmXdGnsQ+/RMszFDZyqCzPWbH996ovt7/aWMShbJaSlbUwFzYrB/cVfo+ihaF7r3L/9J4Dzj9/pCJF4ht48rMNe6F3fwt/j3eoqbmNBRI82uDlKPnZiVDjC8pznTu805HDh3tfwM4zGLF3pbL+nRfpCXl124UaJRuDGiZhCgb1pomeiDCEb8NnohV76EngJE91RL3tQ7nV2sYILHoNsxl9x7BZT4wSq0t0NC7rxi1LVrFh07UZirwfSVNAVKCT/qWXib8SDVpqfgiGLczlQ0+mPLBUu2ZtHfqZaMWSWU3UFl2Mcir5nblrf2Shvv12yYJ1ZQnTFG04X181bFOINYy/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(6506007)(83380400001)(36756003)(52116002)(53546011)(31696002)(31686004)(66476007)(66556008)(86362001)(66946007)(5660300002)(4326008)(2906002)(186003)(54906003)(6512007)(6486002)(478600001)(316002)(2616005)(26005)(956004)(8936002)(8676002)(16526019)(44832011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LN7a18njthA1RQKf53sncTaKYjlObQfAwM2l04BRXLUXsunCMD6Eh5mS5AQk1VUpmJzbQWIH/aNmuwggsAEYXaQc0OMIz0VUduB4A3PXxWIiB67j+MCUT/bRHEsrft0v4AqGSNl4u9MQ/HUJuCD0705iUfRmOpPV+DWPOArEIMNyuSU4spgqzRz5nnkn5QD9krIzPibivKvw+2YPTwKYndLGaggwJURHH8QNfJxbsEM4AHOiAdjmRV/sPW1vhWxm09zeGqwUK7+h7p7yJQMvIVQQqBdchMk3q73GOBJKhuQN5UqzHfkYXAD16CNYMPhd6ew3bgl9BzuoDPznjiGWi//6ND7k50SvQlbQLDmh/yFV8SdXD9xAacNRX4GFB2XsG7OJLB+kcRxi8SPC90IOpSzfSGYiTE7IevSJyU80wtYjBx1bVJcRbINZHc3JhzenM9jdJeUUQx91+cWwOq9oAjXhpTKZvqM3x51qydTw3rpMWSRW1AZSNOrxjLcMXBYf
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ec9041-e94e-48a1-760b-08d83254ce7b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 17:45:09.7813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c9wMwrUYF0FA64HY9iglcnOSafDqWQQSTvbu6nm/hQCoYNKgldIs09Qzhrp2/NNMkaPh1/TUkjlv91ZPpysbYN0ZeA4+5SlnsWv8Hcqrrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1651
Received-SPF: pass client-ip=40.107.21.104;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 13:45:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
> This patch adds some tests on how commit copes with filter nodes.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/040     | 177 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/040.out |   4 +-
>   2 files changed, 179 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index 32c82b4ec6..e7fa244738 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -713,6 +713,183 @@ class TestErrorHandling(iotests.QMPTestCase):
>           self.assertTrue(iotests.compare_images(mid_img, backing_img, fmt2='raw'),
>                           'target image does not match source after commit')
>   
> +class TestCommitWithFilters(iotests.QMPTestCase):
> +    img0 = os.path.join(iotests.test_dir, '0.img')
> +    img1 = os.path.join(iotests.test_dir, '1.img')
> +    img2 = os.path.join(iotests.test_dir, '2.img')
> +    img3 = os.path.join(iotests.test_dir, '3.img')
> +
> +    def do_test_io(self, read_or_write):


The method defenition could be moved down after the ones of setUp() and 
tearDown().


> +        for index, pattern_file in enumerate(self.pattern_files):
> +            result = qemu_io('-f', iotests.imgfmt,
> +                             '-c', '{} -P {} {}M 1M'.format(read_or_write,
> +                                                            index + 1, index),


The Python3 format string f'{rad_or_write} ..' might be used instead of 
the .format one.

Andrey


> +                             pattern_file)
> +            self.assertFalse('Pattern verification failed' in result)
> +
> +    def setUp(self):

...


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



