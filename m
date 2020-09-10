Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF75FC07548
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BE12145D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n4HgdZKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BE12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKWN-0006RH-T5
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 07:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGKVe-0005mX-Sh; Thu, 10 Sep 2020 07:12:58 -0400
Received: from mail-eopbgr70123.outbound.protection.outlook.com
 ([40.107.7.123]:4494 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGKVb-00084l-GU; Thu, 10 Sep 2020 07:12:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRFiIE0xrvRNtdcukvqIHMpFmD6NYjXGXP6z8YFZr36n53zRlqJZnKscLx/JDjks1TsMg4x9nV8WvCVOp0ujdfaP+iT5IjrF6fJRSdTTKSVchbhZk9HeOmZRG4Wwk9W1axoWFPrwY3c5WZYflj5QO499Z+sovQk/fFwN3yzCQNxWSKpz+lxdpJo/BvPGXFeL/d0/V2Ow/br/sqzSRazXgQEGangNGFNCNGVNxiluGFmD7hBTbKx1DsRldhgAwa+S3kS0JN2050PxEsP4MfHO0sog1qY8cbjKpIo/Acx2wEtBKrfKljSfQeQoQaGId6VJlBh40hTK1tFXYf9PeNzI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmHyDQFwT47Dr2wK9PCM8Gxz2KcZCeKpkYRGaXXD0P8=;
 b=Bk4g0uFA0GUiDxL4zqi/6uKQ8KogJ4jwEVHpWW2rZPqluIE3OQR1hmegUW1HP7SKqA+ybBsglnC4jOn6pnUW9hdlVRIYvZ8DYURWxd5tpVTBelMZ2m8V1sTOlmaY/jTIgV4jnEK3E5UVAXfN8xctn5b5q8I29bA1yh4aPcWIxSTmYeKXbOjNbJUC1fHq7xJ00A562VyNfOA1yh5uPHrJzte7vFLdNleBEK3EvUwh6Q7T2Dgc0mw/6kgbd+wUG89o8UbGLMZWcb6WxeQb/9fyMaWNEZjC6+R3ShgsAKQ2P8/Bpa5KTuif2htZ3mvE2fCTXr6tR5TbLP3HdYPikDrKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmHyDQFwT47Dr2wK9PCM8Gxz2KcZCeKpkYRGaXXD0P8=;
 b=n4HgdZKCqTAIOaj61eJ2yyMJj1CXF6fGVtkZxci/PNhzZgCv9krMIQj1YJlN3gg16Fsu4qZl0siNbiKpjawoPFrNj65RBloLB1/8hOhUKNOGThmEbJvH2eWxKdZ4fo12z2FcVcQIjlfL1/DKfmMCyO0KrrQgWIF2N8iKbnPpnDI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3285.eurprd08.prod.outlook.com (2603:10a6:209:4b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 11:12:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 11:12:51 +0000
Subject: Re: [PATCH v4 2/4] block/nbd: define new max_write_zero_fast limit
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 fam@euphon.net, stefanha@redhat.com, den@openvz.org
References: <20200611162655.4538-1-vsementsov@virtuozzo.com>
 <20200611162655.4538-3-vsementsov@virtuozzo.com>
 <ba407503-d235-da74-6b19-7774605b4ee4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1b784ce0-97b8-8b54-c852-8ee6691b7fd2@virtuozzo.com>
Date: Thu, 10 Sep 2020 14:12:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <ba407503-d235-da74-6b19-7774605b4ee4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.150) by
 AM0PR01CA0082.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 11:12:51 +0000
X-Originating-IP: [185.215.60.150]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 161c2469-37c0-4f6d-a062-08d8557a7548
X-MS-TrafficTypeDiagnostic: AM6PR08MB3285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB32859A791119FBF3D68B41E3C1270@AM6PR08MB3285.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhlxehju9AiwBMzSRF4HAQGvp5ejB7Y+VC1rvpzPpPxWJUSPmvUEKbErxKIG25Ks6NKRLShNCaNfoRbup/ktFXAMOAzWhDaTnWKsXHiRa99Ymn3ZKfnUt0GC7uwVXL5ZV4JpumX7KRv265yFpk0KSfrtxLgJaFWDqC3A+ylmD58eL44isvMT/TmOMaxlWVYr3KI8jDGLn3ZOdsWtm/DvG12b8acSXHxlW/myMqI0zlod4JG1MrJDMRB9CfWwGqDaBKuXpTsFX9NePoRbZWJyJvz66OanhXXiQ7IvVZHbnzKDzBe6POWg62rfQb48Cxne2nJQGD9O4EQsg7L64Daa3bodL0/A/PSqLksznwRAiJ/UxVcfc0vysCq1MQZrPnNj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39850400004)(136003)(396003)(86362001)(31696002)(107886003)(8676002)(31686004)(83380400001)(16576012)(36756003)(2906002)(316002)(53546011)(4326008)(66946007)(66556008)(52116002)(6486002)(66476007)(478600001)(2616005)(956004)(5660300002)(186003)(16526019)(8936002)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Zu4ogaZqXuXEW+rwQFdd21SYalaatMGnMPuvoug7Utc4MQmv6R79d5Mhfr4lUnIN4JeQtiLlZY5+uVItBdvrl1uSmMYtgdk+A9qMvtsL/+WWQC/22g4HnQVAOM+q196LoEBYmBM3LjYlaCqwBpnhbJDbgWmtn3wjiIbIFMDJol/EhPV1NDTy5zLtWniqwEeqhtDQFOFIrJ1GH5m2J9jPKbLUCPpH9htLxMH6Ztf4bjfwlMn4yyhdbyfDbJ01xMd868KV+d/mapfwOIUDsqdA9eWbtLMp15B0TnKCTagSBUCVGIN5wupDv1OpkG3cwIRYlUeyL9uE8VtMXwVpvdUz9HNdfCfCb7m+FGQqG7+SEBcRdeaH2RleZh+aiXFBrQiM3tRCYabaB8dvc7Ykv9auSVVGYD51omAj7/yVXjmTZHb89ebnUHjgn26pOwxfS/LQxCbZTLEy+ZsWf+mh8jc2edo8h7S+Lk3TVzPFFb05+7axSkRN7+8Vj/YnCyBbeCvXNvJWpNk5yHmYJYZkeloK8UApDEOvkK58lUmbRxFFE0ZuSzaonb1EZ/FNFbPG9sl/+d/JvgoZi7G474F+AqNO4hg8CmjNDmOS1VZWRiDwrV7h7SPp8gJSsNO+nKI+vb1AkP3VnGs2B7NaktBsdjesgw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161c2469-37c0-4f6d-a062-08d8557a7548
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 11:12:51.5985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJ9mbUYuwjMEt8iaSzj60A4pzUeQj46s/bVJjcZlbXmW9zG6eYlm2R8TSPGYrVoefteopknx2VELPm3HB8IZMOOfHGv4FEGGE4pz35S9XRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3285
Received-SPF: pass client-ip=40.107.7.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 07:12:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001,
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

23.07.2020 23:32, Eric Blake wrote:
> On 6/11/20 11:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The NBD spec was recently updated to clarify that max_block doesn't
>> relate to NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which
>> mirrors Qemu flag BDRV_REQ_NO_FALLBACK).
>>
>> bs->bl.max_write_zero_fast is zero by default which means using
>> max_pwrite_zeroes. Update nbd driver to allow larger requests with
>> BDRV_REQ_NO_FALLBACK.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/nbd.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 4ac23c8f62..b0584cf68d 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -1956,6 +1956,7 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
>>       bs->bl.request_alignment = min;
>>       bs->bl.max_pdiscard = QEMU_ALIGN_DOWN(INT_MAX, min);
>> +    bs->bl.max_pwrite_zeroes_fast = bs->bl.max_pdiscard;
>>       bs->bl.max_pwrite_zeroes = max;
> 
> Do we even need max_pwrite_zeroes_fast?  Doesn't qemu behave correctly if we just blindly assign max_pdiscard and max_pwrite_zeroes to the same value near 2G?
> 

Without BDRV_REQ_NO_FALLBACK, max_block is an actual limit for WRITE_ZERO.. So, in my understanding, it doesn't


-- 
Best regards,
Vladimir

