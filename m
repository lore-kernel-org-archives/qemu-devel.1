Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC232C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D8F20853
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wsitsxSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D8F20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyQe-00029W-Kx
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 10:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVyPf-0001hH-D7; Fri, 23 Oct 2020 10:51:27 -0400
Received: from mail-eopbgr80119.outbound.protection.outlook.com
 ([40.107.8.119]:32174 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVyPc-0004QH-Bu; Fri, 23 Oct 2020 10:51:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACILcFhbWbm6Xvo71uLqZkSgbaH8cvHjIBYtdb+dfnTrCnSSjOOsXukDZCnigkO2Oij5xwFSyRjlOKa+PzlFIJMUHM1qesjQK1rhA7yold3G3Hoqv+XNoVd6EW7Q+MmJu8XmG/MXsvUGt9+3siPPaTaA2iv+rbXzFlvqq2/Ujsdq1XmWmqDw8LVl848P67fSf+Cfe/e2UQjESdmHMxlYBSsGSDSuYm8W0RBw8FXTQ6bKZI/m6VufF0w1FEY+B/sUnG0vITj6JPFP6/czJ5mQC6cR3ZoLU+lLwUExwr9ZwrsC/BoMyCdbK0aSCLoptCo2jPYoStlApb/Yqw7qt0areQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYFJbYKoHuKUjAinnf60OI5kBdlPEXFrhy31cGqLAI8=;
 b=I/c8qnSaRkNckqVZ4pyWMG1kkQpHWrqssYYNDCs3YVVkngm4B6Hcmfpzxz6lSHGmwsUlew6A/oWyiZE/z+/qu1YOQWtYA7rFDQQWhSS9g7OkxqhoUrZHWuQtZm+cXIftTihMoe4hvwBVtLD590HTOYwKy113JaM/p53HEmBB3VY77ZwFq2FGsq9TGNIi2Jd/pJ/DcKXtnu3fTfDtFQ4dm56FEQFw8UFZSqpo1agM/x9kvzyE00AsTetxypKV0t3XgQLk920azha/Z89EodS51rxO8NERNtlj+uHqea8/LwY9HnUgvmeegtvtku22i6nS13X2dGNuNesgEEDn3YSfjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYFJbYKoHuKUjAinnf60OI5kBdlPEXFrhy31cGqLAI8=;
 b=wsitsxSShv9TNIswvM+TfYMSZgSdPeJq8iVCBqB5NPgBitWZfAKeqokSLpy6p+GW1Nu1Mql8lp9hRHxtOrVDzPyXjP3w555xAQWVsSfGFsKnsVjYCTqXp4F5K2JQsM3av3K4yml/f/MdvfahIgvlH5V20JwinnkEmdQEApapnvg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1780.eurprd08.prod.outlook.com (2603:10a6:203:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Fri, 23 Oct
 2020 14:51:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 14:51:20 +0000
Subject: Re: [PATCH v12 05/14] qapi: create BlockdevOptionsCor structure for
 COR driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-6-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f405f8ba-ffbe-7fa7-d935-6df2b94dca2f@virtuozzo.com>
Date: Fri, 23 Oct 2020 17:51:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.98]
X-ClientProxiedBy: AM3PR07CA0090.eurprd07.prod.outlook.com
 (2603:10a6:207:6::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.98) by
 AM3PR07CA0090.eurprd07.prod.outlook.com (2603:10a6:207:6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.11 via Frontend Transport; Fri, 23 Oct 2020 14:51:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc394e92-8a2b-4170-dcb5-08d877631a59
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB17809C50938F786BDD1591DFC11A0@AM5PR0801MB1780.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/KI5mYBmFc2sO2IdSDfHsS8dgfoY1+GzzEPlF5J3qxnSqc91DkO6maTjmdIh6uIfTtqCY6iKM3EB/fC7xpLxMuy3IBWvM8JOh5ozbT8SU9gXciZcW6qGYlTlJmlBNjn5wYwr+0gwLUCsSd5Jz5Rlw4gObPabEi875C7er9d3GCesOdnT08q7vXrKSPok5wZYu18dCM1LxJ30PttrN0kMdnsbUQaKyBMEAZ9L62o2mIGdqdSCNK53wkiIlsleQFtHcZkTXe774SOCtF6n3W581ElzR8sPPsnWi3N7QppAQQYs659QgR4VpTiZgBhpY5HCSKodlKfJl5pdrU/6jbXN8s+gTh5O0bTIUFqT+SGVvLEVM++p2sCJ56u2KS1VykE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(16576012)(8936002)(26005)(83380400001)(316002)(86362001)(31696002)(16526019)(6486002)(2906002)(186003)(66556008)(66476007)(31686004)(478600001)(8676002)(4326008)(5660300002)(36756003)(107886003)(2616005)(956004)(66946007)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ufm0ndCuqQ2lhUrF6vQ1he7ECM3/utqSR1E+KcPcUmzNUYpAra4f46ipWThnS/rcRQKQcuEhHHIwE9j+JsBVXWNwy5lYp8vsnhwwgFkCXMiDgqA07tAHqNFlLGIUjMS1mjGWXlwmW7AA5Wh990NLisvUqE9vxckHdlUfE02i1gqky63QU2au9OdRWKi8gzhwXyDe2pZdkdLyrH2ekhj3AYKiHbLR1BmLHKDbVHbmN1+re63OR6zvBInMAkWgBqhxFM/1VHJh7VqMBS/wt4ghLG160VI/2iq39JQeVY1ODsXinwojHyGjh/OANb91Yq0jm1POlzFzCVk3qWz7hYp6OZYlGcH+JPdq1SAi0E09xvpUS9pJ8vFCjkYgo6tFnlytos0EnrurdLKCydtzGNWx0BO3miJPLy320omiq2fhXYgDyM9fq6kG0LUfzFc0rFzouIh4viypWykvetrtb+zoASgQvIfMsjBde4jtRSPgyQloFYqM/wIY5ZeLeGl7rajdqFevH0AvmmZ7rO/CkOK0GluB8Wtc7mRTY6RitzsIvFfIcS579hA6HfiqR/X5hkwbqDIXxp2noFQLv2mrCHjWe59gfhrqyWuY7VXUK1iDoXxXCsAqm/8MDJM6TJfZ8XztfyECnboHuwelnXADALPr0g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc394e92-8a2b-4170-dcb5-08d877631a59
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 14:51:20.1455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gM3KZ5v6UEv3+ra+ytZskvRex2kHZoSyEFU4m8YJv3+ONrRjf+s/06ewiEYuOkg4RV/Xsh+mm3eQoDm+geK38QFiiZRzQjVovTellrLj0hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1780
Received-SPF: pass client-ip=40.107.8.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 10:51:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001,
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

22.10.2020 21:13, Andrey Shinkevich wrote:
> Create the BlockdevOptionsCor structure for COR driver specific options
> splitting it off form the BlockdevOptionsGenericFormat. The only option
> 'bottom' node in the structure denotes an image file that limits the
> COR operations in the backing chain.
> 
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   qapi/block-core.json | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0a64306..bf465f6 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3938,6 +3938,25 @@
>     'data': { 'throttle-group': 'str',
>               'file' : 'BlockdevRef'
>                } }
> +
> +##
> +# @BlockdevOptionsCor:
> +#
> +# Driver specific block device options for the copy-on-read driver.
> +#
> +# @bottom: the name of a non-filter node (allocation-bearing layer) that limits
> +#          the COR operations in the backing chain (inclusive).
> +#          For the block-stream job, it will be the first non-filter overlay of
> +#          the base node. We do not involve the base node into the COR
> +#          operations because the base may change due to a concurrent
> +#          block-commit job on the same backing chain. 
> +#
> +# Since: 5.2
> +##
> +{ 'struct': 'BlockdevOptionsCor',
> +  'base': 'BlockdevOptionsGenericFormat',
> +  'data': { '*bottom': 'str' } }
> +
>   ##
>   # @BlockdevOptions:
>   #
> @@ -3990,7 +4009,7 @@
>         'bochs':      'BlockdevOptionsGenericFormat',
>         'cloop':      'BlockdevOptionsGenericFormat',
>         'compress':   'BlockdevOptionsGenericFormat',
> -      'copy-on-read':'BlockdevOptionsGenericFormat',
> +      'copy-on-read':'BlockdevOptionsCor',
>         'dmg':        'BlockdevOptionsGenericFormat',
>         'file':       'BlockdevOptionsFile',
>         'ftp':        'BlockdevOptionsCurlFtp',
> 

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Still, I'd prefer this to be merged with further two patches, to not add non-working interfaces even if this will be fixed two commits further. We do similar things sometimes to simplify big commits, but in this case merged 03/04/05 doesn't seem too big.


-- 
Best regards,
Vladimir

