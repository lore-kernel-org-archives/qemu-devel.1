Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2378CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA44206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B3N+QL+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA44206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpcm-00045v-MK
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYpOH-0004EM-7v; Wed, 13 May 2020 07:17:41 -0400
Received: from mail-am6eur05on2125.outbound.protection.outlook.com
 ([40.107.22.125]:31968 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYpOD-0005mB-UM; Wed, 13 May 2020 07:17:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfRaf5vdCMI2TdZSRhfLfsI7iiqIhRJJ55RYvRV9Ccd1B7xhljPrL7TftK+kyQxewCRzcGGdShaqahAYS5AH37pvyH4lBKteEouwP6BVc7hudL+pOpPgTfFRu2IugSktJL0kwVuQ7Iq/gPzp3v8aUfD92Qw3JOZAP7LWHrOd/CBWvSNj80zdaIOX2wrBROwjsj4ekFsK12y3WhhkrcPGYn7t7BQOYvW7pr3CauqgA2W2AIeZ7snrAded3774emzp4gJcU5V/hVlJWH/8UC5xZoyZNcscE5UdCA85YQL18GC4pRJEHKEzhL+uFj6RfZh2VkItiJYdLLG8I6eaO3jWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKUXpOBRaUi5C3PAMHxTwmIfYo9b0w04eHl/Tt2HYK8=;
 b=cOwoJdPTXAPau9DrZ9VAV+Y3/dix9t7VME71MYrD7r4o1m2ZcZdzrjNaViCmQOKN9/qF6qPtpFJw+69YUankrRrSm2IyRl6HL2mAg3h0RHJKW02Ig3l+rgSJI3NksgPO3psRLqau7JqYlscuVVkAgytRNPporznn9py1eXornaZHl4UN0DXBCJcEy+4XJopES5LtII7oJ5Av9GAQUByGxRM6Zl9DGIt1ewohHcaQY+9XQdbF1HKBzurg7vbOmrDMQ10zWGucz/tAIRxnUQB3FnWcri/ntMg2bYR51TCgxYlzvi9QAyW80wAR4QvleqGVzBagaNPPXAG7TI7/CgTVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKUXpOBRaUi5C3PAMHxTwmIfYo9b0w04eHl/Tt2HYK8=;
 b=B3N+QL+azQkLWi1fpz22otp2304/7qXuSfwOoLTnNsJLBYLc6vr3C8Ltw1bIOZZHVxY8D7FxIAQzEa1+N01l7Sf/S4PjV3RLXj3H4PU6OuN/WE8X70BOgV1PBS6Cd4JGE+djtMnbsoPg99pFkKTUNV8YmfMDzvS3suKvGvxdd6A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5511.eurprd08.prod.outlook.com (2603:10a6:20b:10d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 11:17:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 11:17:27 +0000
Subject: Re: [PATCH v2 4/4] iotests: Mirror with different source/target size
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-5-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bb5b1e29-652f-6765-edb7-55a7fb63328d@virtuozzo.com>
Date: Wed, 13 May 2020 14:17:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200511135825.219437-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.179) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Wed, 13 May 2020 11:17:26 +0000
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64e42a35-0415-4874-961a-08d7f72f37ce
X-MS-TrafficTypeDiagnostic: AM7PR08MB5511:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5511D93B98DDC74DCC6FCAD6C1BF0@AM7PR08MB5511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCg8Dj4sTqaH8I+O9Pi/PbHZ+mrK5MOePgCnAYHKN+/jOrY+HDI73ttkbpNJWvJZspq3/eAjOhc0aiq4+etiWucy1ddybMfaiB34VPBD0dpFN/Mv3fftwangDMRhns4YomLKP1tLPLy1uyrHsYs/6precYB5LJJg+JZQzv2KmTS0VFbCn15AJG4vvU/d/7Efd9XH+3ZgmtW5zLWlRw1BqFR85Sxlj6dpQ+FFeMEk1PVg7cRWN/chZUgf9ubTrc5pTF3BbRQmedzF1Of/2qe1jLL6z9W0UjrcluoDhu2j7zFQ7j3t0MGshXVxnMgp8UZEnsk5/lU6A0q/UESAqjgzqdEyRyjBzNtqNSKRZQW2CDMJdn3mLXpxuH0zAWx/EIbRntFJipAZ49CSPWqrlp7eoI016OFFIHWPnbh7P1kpwL1wstwhPEcPvzY5DX1lVq149DMcHtPxvJyHhAUNyFDbD1sLKDc5b+zYTms7rpc1ou7qMw/gZxrAn4t4hvTrvckuBYWzL6LlU1PDexcTQXWT9lJlKYb+HjRlZZfAM53hYLDblap2L6WUw2EJ4r1ysl4Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39840400004)(396003)(136003)(33430700001)(26005)(33440700001)(6486002)(316002)(16576012)(16526019)(2616005)(4326008)(86362001)(52116002)(956004)(31686004)(5660300002)(8936002)(66476007)(8676002)(66556008)(36756003)(186003)(478600001)(66946007)(2906002)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QtB42QQuUGj8NG7C5raNAQ97aEPwMBgnIOW8AKRIyUzFqyg71zcFsr5ZydFkqu9kC0SF3q5pRZILOqrkv/rya5omo5uLNqEDothhAYNPeY7DNKYgWtMAAjU3Kle7diXDOEd9veOhEfyCN1RHAbbhrIyWVT+gYyrgTZp0yd7jpa8WZLwSei2fgRNBQI3GgcG/+ByzEdUp5t0tN/zcvApJAV87qrXRSvT2e/3ccHdxegsAW7XrmRwhGs3/f27AATGbpW5JJFqdSL/F8I0x7L+wS8gKv+2pVYz1JZxnRrCclFusneslvuW5iTbv15Jqj7kW9+HQ1Y0fZIrdhF+ITUMOzKLYvHl3vo+6Uz6h4U5uhm0l2Kog0e/1N0uSLRvPyQpx7mnZ2pv4rtMXobfgtW0j2csUHQKbDXOWpCDuoimGGLW0vCOvm9FXk9meBK/8k2RsLaMGEViHT/mw53yEIG9vw6xGnYKs6wT4Mcnxm+NSlhdZlLeDwtQ7KVd9U9K+7B/i
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e42a35-0415-4874-961a-08d7f72f37ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 11:17:26.9397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5565AEIOP0toRr8wHWpI+tZLQZrUinwk17QzbOgvT2Qe08gOCbb5uoBgFptlKcvF5Ixixh5Afyxj7Ws7o2CBJ4gN6tp2IkEtzw/+42Ol0rI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5511
Received-SPF: pass client-ip=40.107.22.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 07:13:25
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.05.2020 16:58, Kevin Wolf wrote:
> This tests that the mirror job catches situations where the target node
> has a different size than the source node. It must also forbid resize
> operations when the job is already running.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Message-Id: <20200507145228.323412-4-kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   tests/qemu-iotests/041     | 45 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/041.out |  4 ++--
>   2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 1812dd8479..601c756117 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -240,6 +240,49 @@ class TestSingleBlockdev(TestSingleDrive):


Hmm, probably resize tests would be good in the TestSingleDrive, to cover drive-mirror too. Still, there shouldn't be any difference.. So, I don't think it worth doing.

>                                target=self.qmp_target)
>           self.assert_qmp(result, 'error/class', 'GenericError')
>   
> +    def do_test_resize(self, device, node):
> +        def pre_finalize():

[..]

> +    def do_test_target_size(self, size):
> +        result = self.vm.qmp('block_resize', node_name=self.qmp_target,
> +                             size=size)
> +        self.assert_qmp(result, 'return', {})
> +
> +        result = self.vm.qmp(self.qmp_cmd, job_id='job0',
> +                             device='drive0', sync='full', auto_dismiss=False,
> +                             target=self.qmp_target)
> +        self.assert_qmp(result, 'return', {})
> +
> +        result = self.vm.run_job('job0')
> +        self.assertEqual(result, 'Source and target image have different sizes')

Hmm, and this proves, that we are not very good with handling early errors. A lot better would be to fail earlier, on blockdev-mirror command. And, as shown by your previous series, backup works better in this case. But again, it's for another series.


-- 
Best regards,
Vladimir

