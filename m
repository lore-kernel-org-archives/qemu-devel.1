Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC121C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA01C206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QtbFZJgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA01C206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0OX2-00045n-UH
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0OVh-00031t-QI; Tue, 28 Jul 2020 08:15:10 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:11903 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0OVc-0007Nu-TY; Tue, 28 Jul 2020 08:15:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjLH3oZnymqaXXrmi+HwJccoiaGjdCyvxb3YuNBpITfzPxFw6Krq9LOkjnGUD43/FX++QXLzgdZHF+YLPJSYSK6waDEUwCtBdOrfPjA935HsbcdtAs1baDQNOxYpHxdLlDQ48fReZwYvvv8UGa4LsflVcNPxYgQr7ghcVFvmlVG/dzD4FyZfSy47g03KPMybsPTGNCEjT63IMQN8AY/grWXOnln+fRJG6250UF7VS9zI8H1OGXlXY4swv1cJ6FeYvECjXXPIBrai3Y6zuYvJKe29PxmzSPQoDChwPQZ91S2A/yJg9UpE+czm1f1ER+iEJGW87853quvyLPXtuWidOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w54ibqYZtuSpyF2n6wFvs8nPMKaTp9YCi4mdQ+ODEd8=;
 b=KIRDBBVXiZxPUTKaHlk1P+Bm4Xp+ffr/wF5FoEuimVzolaNFKzfVkB2fVaP/tdMZE8w4RIPR9IsznUZZNWwauwkJnq8YrASawEN/5arS4QMY1DLVlMSN1dnZsZ8F8pMkWrGo9z43N7fRK10hGCEajNrse860JeryszsBT59hGRIcmIxCNiGuMTs/1qFkeEU7JxY+K1Tx41cvZawN25cW5vbQTb97Is3/vfiVscZTcUat8ePO4QncZha9LbVp+PldStMMAytUfUTZeYRPwpm+6uF19wnf8+HmRdsG13aDf2AAXKoeRxhKgzde+6fiCJ7oemHoH5u7rpK2Bqt7lnVO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w54ibqYZtuSpyF2n6wFvs8nPMKaTp9YCi4mdQ+ODEd8=;
 b=QtbFZJgn5oTuLDVWn7a/rF4sp87/pl7nhUILFX4/763uRX0W938qMfKnRmGf+RDWVxFyEsoJSh+QVb3XdthalAjmHQ+q7c0LBISjr4wTi+OEhwhg6b2cfZS3fb2XCQ/SFKpos1kGQ1D8UP5WW+87OZM9GLSIYUj7pe+KOFMyTiU=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4723.eurprd08.prod.outlook.com (2603:10a6:20b:c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 28 Jul
 2020 12:15:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:15:00 +0000
Subject: Re: [PATCH for-5.1 1/2] block: Fix bdrv_aligned_p*v() for qiov_offset
 != 0
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200728120806.265916-1-mreitz@redhat.com>
 <20200728120806.265916-2-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ddea3b01-6dba-665a-db7e-89abb521ba2d@virtuozzo.com>
Date: Tue, 28 Jul 2020 15:14:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728120806.265916-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM4P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 12:15:00 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acee72de-32e8-44ae-2b7f-08d832efd9da
X-MS-TrafficTypeDiagnostic: AM6PR08MB4723:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4723CEEDC9D5D10877474117C1730@AM6PR08MB4723.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OmeTGHfOGjBLmc054G9WxSweLpYSR8a56eQzBGeB5YpiVdqzUKW54H7fSewwjmXwJXPIZ8es9j5irxUdAHB0WmfQuHqis3ps4EeigE0i153qYF8ZkJoF+ZHQkQii38ByX5uKv5AZXfnO9iEmROLPTJitW6NY/8GvK39tripK2kduHJryEhXopjt4iRf1JDK04haFxGwlaIdXTjdaA7gyScVFnF45AvQ0RR9iDG6QdKGNa47YTCLv1e1pdXNpxSWmctnn+L7DKDJR/8LAuCBBzE38cWy+pgRgBMvc7Sbi/Zr3lJSRTbOz+PmUKlfVGKCyqzlmQox7fuH9CNCDd8Ptko0ljh8yTZFsLsMWEDxeMNOrXufgwpwbzMsjBBSfFV8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39850400004)(366004)(136003)(186003)(16526019)(26005)(54906003)(52116002)(956004)(2616005)(31686004)(5660300002)(4744005)(66946007)(66556008)(66476007)(31696002)(36756003)(2906002)(83380400001)(4326008)(86362001)(16576012)(8676002)(316002)(6486002)(8936002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oZGO0Nn+QSivS8rJ6bNqmuJcPtMUYm88Fb23apBKytxcQ5cci5kQLYeZCeKDcDWVFDqiCvRVRHx+TWFgQpSfuxnKrJ6eOyi6xBblRcbF9XtOYGbR9ZOoAlzfOHWyD3TFGKSfwTNfzdH/JXQSInf+XQesOaUecNjE68tYOe8oFPgKXG1EmGDbf5mXXSH2MebJ2UcykumgHZ6att7Tv9cZvQWOYvc3azIBR1Z+agNSKOoJCrrKaMP7CKLLiT1DvMX/G3PanorJELTn6MN5zJSrLbaN2ebxTQzG+Apt18JzPFX5SRFantVZ5HxsDpUC4vLjKFhuJ784zEr/96Bq3uCRMi8MUYlW+GzMNfV4DJSNozuBfSypG7AzZplL9/niGl2XebW8YnxlPlwyzT1ztlRqf+ECyv4qMD6zJfVAe4kFGG5Us457CkPWaDlCyTmlQ5ZPI+LCuiNK+Q1NXRMBz8gMxuV9bLURGPjdf35/i4sO3HKHiTV+JVIh/xjgg3/Q/p/iQGXZ+aFzNBzlEcDzT4QE0feT4UviHTBqGD4Bf6UqdTVfxcHU5TRJiV8VzqPrz9Ahy/CHp39E9+vFGeOgNRzTtjhaz2+K/n4WRfH3xS8B5FsELEzcFJBR6qK2wJhDE8zhhimy/PIeI0wNKLOm3xfWIg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acee72de-32e8-44ae-2b7f-08d832efd9da
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 12:15:00.7267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhE/NFJq/NsbQeIUwt8OqLDUlmu2kXdx/zgtb0MHHKg7L6AYXeTg4qsJBAO1mR1P1soQH6i9yPhvSRY6fdSkYrdLiZNb+FP8UnztwoZ2ATc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4723
Received-SPF: pass client-ip=40.107.7.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 08:15:01
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.07.2020 15:08, Max Reitz wrote:
> Since these functions take a @qiov_offset, they must always take it into
> account when working with @qiov.  There are a couple of places where
> they do not, but they should.
> 
> Fixes: 65cd4424b9df03bb5195351c33e04cbbecc0705c
> Fixes: 28c4da28695bdbe04b336b2c9c463876cc3aaa6d
> Reported-by: Claudio Fontana<cfontana@suse.de>
> Reported-by: Bruce Rogers<brogers@suse.com>
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

