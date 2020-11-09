Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FC4C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0096920789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L4KNFjMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0096920789
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc6E2-0006lT-Qo
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 07:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc6Co-0005Tw-Ct; Mon, 09 Nov 2020 07:23:30 -0500
Received: from mail-am6eur05on2097.outbound.protection.outlook.com
 ([40.107.22.97]:50979 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc6Cj-0007lJ-A4; Mon, 09 Nov 2020 07:23:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8eq3HzjukgE+t/IXGAPkjkG2irVnlPOjyd5JGw6GMSIrBpsTVattM2hKLaGMV8fZWFsL5h+d1ETAUK3Mafu+73KermWEAopK3zoA1lVVpFw3CPjyDr3wCRfTW8Fs1HUO53hPiGdEapY+afu9P+lrORvPXRerJGTGsVWWeSejw5BcpI7l2NZF6ae3ciKFQtu+RdVkoLFlWYBKj7ebAB4YOcQg21o9AWP3MSiqn56MrH2bOnbpqJwOSgR41szsrzXqjCvQaqhruSq3M0aIAgH4K2JxQSPqe9McA/i0ioBJlqEDJ26LAJc4jt/KuWBRTb7UZPAFfzGpEKMbGq+reFdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iz0zx7F96iAkL097fl4Gr8O9pL0zHikQRBfh+nNoW8=;
 b=XFMsW0YH53lOyYr9Rd7NahDq13yzPlFLR+Iv6wkSFZWQYM4oebZzQyQIl0iQ15UWM0nNkZo0aMKdexjOEezQxbkWkhWw2Hfx2/peQrqaUUNgXdRsFiDvv8KJgfOwJOgdR7f5Ygid8SlGFVUwR9Q6ogEP01XBwPlX6k5DqgSDSgFCgeiV7rRbhWApI0r+NUNMd+nExNqm4Wyqe16uSeFu8GEe4c5IBvJBFYB3OOgtO5hQV9n/5bd6XBrXelr5NCPHSYPSM6JCP3gLmI/sGZS+oNis2LsKgYmpOi3cjCRunaPbE83usFVCmAwJ1gO9pNLMTMjWGJNxUgF6zNIAHJqhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iz0zx7F96iAkL097fl4Gr8O9pL0zHikQRBfh+nNoW8=;
 b=L4KNFjMvEc0G+O2Pixq4EXcHcuLIqNEDCLgbKxJg1iSjktzefylji+PymZOhdtZXCYyT/ocH9NUnGPJsaJLDTHxho8zbvqTAw2JZm1SOwyDypmJD69L+X/FIM6kZ5Dqph2ak1kTTK6TdZc1Ohw8TjeC2LCZZ6MZZn4b72RP5VKU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6038.eurprd08.prod.outlook.com (2603:10a6:20b:23f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 12:23:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 12:23:22 +0000
Subject: Re: [PATCH v3 11/25] qapi: backup: add max-chunk and max-workers to
 x-perf struct
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, jsnow@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
 <20201026171815.13233-12-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5cfa33eb-e2aa-61ed-da50-c380a3440875@virtuozzo.com>
Date: Mon, 9 Nov 2020 15:23:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201026171815.13233-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: AM8P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 AM8P192CA0025.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21b::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 12:23:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819a626f-0239-4303-b8da-08d884aa3f8b
X-MS-TrafficTypeDiagnostic: AS8PR08MB6038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6038C4395752BCD86EC8642DC1EA0@AS8PR08MB6038.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59nyOrNg3eAxerzAh0rqnaOgjBpZh0SMdmCIt00T67g3ciEpTg+19hMsbIw71EOWkG1l2NPt18wG5GaacQvq+lTnFIsGkZFt87Si2bSmS/+ds+dq0Jwm505cJ7gvL6uGZFBrISi1GxOjR3l/ulCoQVP0vUcFCohxXVtEPE6RSO30RHWQPWQ5YcTVAGrUaxKZYmaExqST1Oq2kkQz6e4lK5bDm9F49rksEHpB7RvklpXchQt7bV4dUmu9hExCD6RTJGbLyn0kz9n3omFfVCOhQ0WOdn44h5fZJMGG8hs1FZgxX5Z53hqd7Hu8muMs3PZzSL3WqqOumQ0alNePtBUg9ml8OazwyNqIwplseWfQ/LmuHOZnBUAJgtFioXS1gCy1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(346002)(366004)(136003)(376002)(52116002)(83380400001)(26005)(16526019)(36756003)(186003)(66946007)(5660300002)(66476007)(2616005)(66556008)(2906002)(31686004)(956004)(8936002)(16576012)(8676002)(478600001)(316002)(86362001)(4326008)(6486002)(31696002)(6916009)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VEHhtnOMmYOK/LnUUO/pDVtR6pWE5hfaQr6yc6AWLZYt5l54LFVd9tqFHsZJlCLHsO5O6XscO9CQFp3wRJCkgvnuXHCkxftmWwEpWBRsyzta3jaXzQUhBEIuSoxd1KEwq/h2fmpzTB5rvwFgeGB+3BdurspghuzJPtvHzjooKl7xd1WYSCoF6tGJCZO2tYL4yF/VX1GMa+S1oxmQ7JBul8YAWuJ2Wujc/soEPbB87GGFe4VXHG/SvJhF59bSdVKILtPsnM8C6wnLjfNPgCxqfdFTdb2B2Khz3GirqJ9doItwVM2tqkq7FStaiZc3JhGvNqK5MY94KAAMq5wibfHjlarQ4oJ8rTRvtKS97aRuwIqTrusTPiFgSvTDlfTRXHTQlf21rbDWDbro2DCA3feeCR9NHtfBGpv/AlDzh9c4lgoBRhr1X8jVXSVBX0ynzyiwxnoh3wUDAB+tnypK8uxbhwr9tdE0hmwgdlrsrOjunQOQ3U95DFTME4ko787qcmKPsElhM5OEtaNKqxY237E3h4/PRDKTLTf7QrXYVd8D+GFLm7VKZG7i8qcCBk8/IYvEipsXopjfCjSox/2l3Z8jx8Gg9/agxneL5K26q2S4/YgxwCan6bP3yiIOk3uN8iCZT6A7OQDRf/SZN9k/bJ1Zfw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819a626f-0239-4303-b8da-08d884aa3f8b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 12:23:21.9687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm9YAKOjAnwd1QxUjXkEK2n7ou19oe6MdFHieEUKPXsppFKiOIZdJ6LgwvzFd9D3OPL8NQcXbv0iCeI8/tvvD7o5D/6byULs9Q+SfocB+Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6038
Received-SPF: pass client-ip=40.107.22.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 07:23:22
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

26.10.2020 20:18, Vladimir Sementsov-Ogievskiy wrote:
> Add new parameters to configure future backup features. The patch
> doesn't introduce aio backup requests (so we actually have only one
> worker) neither requests larger than one cluster. Still, formally we
> satisfy these maximums anyway, so add the parameters now, to facilitate
> further patch which will really change backup job behavior.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block-core.json | 11 ++++++++++-
>   block/backup.c       | 28 +++++++++++++++++++++++-----
>   block/replication.c  |  2 +-
>   blockdev.c           |  8 +++++++-
>   4 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 71e6faa15c..5a21c24c1d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1378,10 +1378,19 @@
>   #
>   # @use-copy-range: Use copy offloading. Default true.
>   #
> +# @max-workers: Maximum number of parallel requests for the sustained background
> +#               copying process. Doesn't influence copy-before-write operations.
> +#               Default 64.
> +#
> +# @max-chunk: Maximum request length for the sustained background copying
> +#             process. Doesn't influence copy-before-write operations.
> +#             0 means unlimited. Default 0.
> +#
>   # Since: 5.2
>   ##
>   { 'struct': 'BackupPerf',
> -  'data': { '*use-copy-range': 'bool' }}
> +  'data': { '*use-copy-range': 'bool',
> +            '*max-workers': 'int', '*max-chunk': 'int64' } }
>   
>   ##
>   # @BackupCommon:

squash-in:

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5591189b75..276ad5e6a8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1406,7 +1406,9 @@
  #
  # @max-chunk: Maximum request length for the sustained background copying
  #             process. Doesn't influence copy-before-write operations.
-#             0 means unlimited. Default 0.
+#             0 means unlimited. If max-chunk is non-zero then it should not be
+#             less than job cluster size which is calculated as maximum of
+#             target image cluster size and 64k. Default 0.
  #
  # Since: 5.2
  ##


-- 
Best regards,
Vladimir

