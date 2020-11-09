Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397BEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55BE2216C4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PUr6K2MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BE2216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcAgg-0000X8-7D
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kcAfA-0007hQ-2K; Mon, 09 Nov 2020 12:09:04 -0500
Received: from mail-eopbgr60128.outbound.protection.outlook.com
 ([40.107.6.128]:48701 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kcAf6-0007Jm-BG; Mon, 09 Nov 2020 12:09:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W135UVpP9oxEY/jIXukEFB7LDZfIS1vnNLoDtV0joUyP7yqbaF2vqVRYXvt63i+8EhcCOJClk9K/xc5ja2ZucrmaZPgAcs0AWpm4cTdyw2EjrRDLYZXsf/gYzF12VsLiDoHcomdtNzUF7WqCCpg8e9ANYhXGsbMz6Rj2uZ3WgxPtqqjMl36KeLcPt9JXOfhS3BbNQ6V+TKiYdRLri6PGPCgJbei08HtHNS0FoQR6jBQWRgcKdxZcYIiQTnkDuIvm8ne9x+iO9v+LuS54zRuYrz1qjdGCp+iqMaBaoJa9CR/Yk7DvTt4NZT0nBdwt6XKd9tc8Hs57LTmywDNDo8StVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owvfuS7N6r/FsyF3kqthBIeIKvXbMQn/cg0VmbcuLO0=;
 b=dBujv1p5U1OAJz0Hhm9wQMhkvkkX31wCwmsWeD96qHw4KefVXv56NNil7HX/w5X2ZkMnBmukuVtPxmew2U05F3ardAkUQIhh8fPeyMh1WMIKylPQLc6kxPL5CNe3ilxxIaxH4VdIJXAOATODBvNKL7q2ooYY5HrKzA0kXN4/U6G7cdQdJzDSxGQlJXxLF8en72wJ+dmEb19zrCvRQMOxpD+XEssGJ1OXqh3J2WWAjXvXTNgsZzHCodJRolDSlUf3N1E6J+sZ4KKD07G2V1X3oNIIBjCGSkSzVm1n9TuQTxpu9duu2EKPEIqcm4inLUtx0+PZvkG95vD8zsLlfercUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owvfuS7N6r/FsyF3kqthBIeIKvXbMQn/cg0VmbcuLO0=;
 b=PUr6K2MF3tPDBpAgno8c46n29BfswxfDZQZmjYR8QCXvHjNJ+t0ok6H1GM2y0+KI3IMkejnlmQJOH293GEbcTmqNCaLZO4x92tQ7KrPuT7mXr/mnvSHYnMsQWXxbJw+648LbAqsihnO0dRbVx9J4O10sLlb0biOoUkE7Ghqr/ME=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2857.eurprd08.prod.outlook.com (2603:10a6:7:2e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 9 Nov
 2020 17:08:49 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::7822:a9fb:4940:eadb]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::7822:a9fb:4940:eadb%9]) with mapi id 15.20.3541.023; Mon, 9 Nov 2020
 17:08:49 +0000
Subject: Re: [PATCH 0/2] Increase amount of data for monitor to read
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, marcandre.lureau@redhat.com, den@openvz.org
References: <1604666522-545580-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <0f18a6c6-5eab-3ed2-98e3-04969da7bd7c@virtuozzo.com>
 <d48af433-a39d-27ba-8aed-a6957c89d2d1@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <8eb2ee1e-78b1-7819-334c-48e36d48727f@virtuozzo.com>
Date: Mon, 9 Nov 2020 20:08:46 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <d48af433-a39d-27ba-8aed-a6957c89d2d1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [176.15.95.41]
X-ClientProxiedBy: AM0P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::35) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (176.15.95.41) by
 AM0P190CA0025.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:08:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e746c55-9ab3-4a91-b4b7-08d884d2203b
X-MS-TrafficTypeDiagnostic: HE1PR08MB2857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB2857845B9D3ED0A4BDDA8117F4EA0@HE1PR08MB2857.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vP28qp9PC4mC0pEV9yItntqpCeTRwA9TZCBv+5W+0S6+4DBpsYoIaTVrznnuk58a05/1WrKoDNIK0rJazK1pgd++5r3t/pppHMYbqzEdWKdrFF/YpQQa5lBwlEE4R6k4FG2CmccFD3a+EsLo6Em4z59pjtNIGwKVgrZm1+zSUTQDCDEYOr6GhhDujy2yl1ClAvUxykFernWcwe58+4hsxR38UBr68bgwZq1JX2NYYGqhvYnNFT5+0gLQvu+gmTg69bZxLuu91RIVVWKPuKMNoB6JPIZhjuqVTGMTwciE1PhdL0Zy18VNK1yJEXhI+Zd+efsAEDU/KalRnOKAACkiZgx9ChkCJLO+QbIDWfKbp6mThCxyb0QEjqK+dLfcLXqZ68yo0wqLuUzaW2Eo+K2lSiiC1exLwiUuClbYlrVyvEMvxo2A0dfLHs/jQ/kiD1fDSkVSk0mtEzFDPfcAN9fAdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39840400004)(136003)(376002)(366004)(31686004)(66556008)(66476007)(66946007)(966005)(6486002)(5660300002)(83380400001)(8936002)(107886003)(4326008)(6512007)(186003)(16526019)(53546011)(2616005)(52116002)(26005)(956004)(6506007)(478600001)(2906002)(44832011)(316002)(86362001)(36756003)(31696002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3vqYBE0cHKxF4t4W1ecMv5eIc32wXAeKgYBVltjBvRJez+v53b6u2bNQ+Oe8PJY6Iu5Z9P2/m3yBQ+T2d7wESN0z2mhOVOCrvrajfDUsFmeZ4PdwUNM7jeUb7eYJ9i1hSm/sReA5l2nxCt/zx9e3VFQWpWjHh2r+EeoUmAdS1KJLo7RC3d/XDNIzTfSb5ywOl19QUp7D/nQbpUswrlf2ds/DT9JAa7Resd3upopk8iz4RZqISA/r91VTy7jk8l3fHnWMF21/oB4aKxSsFaPPaSIufRgU8kNaimHzq1YTkOVzpzrYjoO3VWL5D9l1InEi2eJy+tEtulVuCtL9wYWSmSbA/pgLPHS2Nze02moPsEDukNieorlFwXUDjdYOiVtTaInK0Z+TTVUkkef0tLY4CEBGOz5w4TSc4qnQlUguAPX9371MwPB7v7fqMRg8bhBYr93smum7/R/YClKF+FWaBo+NgdlW0hHoNrBTw4FVsNxp0VV71kcNfpw1pysRRz7CqvTJ5Isl8km227xzKeQ07/C9JjGzht2/6q68dJbUgeHsoVzW2Bvn9UG+ptRNSdFY/K29QVBY10JAcMCZT0N4Oq3R0e4M89urd4l5Ybf4lN6UtQzQmmVQ2P7yZHmxOUskmuZIIRq1ZjyxUb0nNCYOYEauqZho7In4ZxUidbodbsGoIyCPz4NqaDiKxxEeuUIwcakVAWNQhcN9aIA4dcsWgOWclZPgxXsogYXfaLbbHHb1ovqF8fbccwIb4xq4pQKeJS0Ofh02HBNbSNvCaPTUIfxfQT50CKkxiZf83QQa+0gIEtDoBHEg3SCgOlQ3fE1ciFGoO7+ljJblQzBmSqmktkhPuRjwpM05fR1VRyPtAq6KyIC88d9iUbFw93+yIfqe4EN5B+xY9gRKSFNVa5MrSA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e746c55-9ab3-4a91-b4b7-08d884d2203b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:08:49.4256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsEZOLdyfmoh3zM+URbYrmhsl2e0p2SW0rHc/wJnGDlGjfowZNhtnFGzJ9fXF5WH6wRnrYxg98DlfKQpymrkvHhMHHt0aBCqBAc0lVdgIPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2857
Received-SPF: pass client-ip=40.107.6.128;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 12:08:57
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


On 09.11.2020 13:04, Vladimir Sementsov-Ogievskiy wrote:
> 09.11.2020 11:50, Vladimir Sementsov-Ogievskiy wrote:
>> 06.11.2020 15:42, Andrey Shinkevich wrote:
>>> The subject was discussed here:
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00206.html
>>>
>>> This series is a solution for the issue with QMP monitor buffered input.
>>> A little parser is introduced to throttle JSON commands read from the
>>> buffer so that QMP requests do not overwhelm the monitor input queue.
>>> A side effect raised in the test #247 was managed in the first patch.
>>> It may be considered as a workaround. Any sane fix suggested will be
>>> appreciated.
>>>
>>> Note:
>>> This series goes after the Vladimir's one:
>>> '[PATCH v3 00/25] backup performance: block_status + async"'
>>> To make the test #129 passed, the following patch should be applied 
>>> first:
>>> '[PATCH v3 01/25] iotests: 129 don't check backup "busy"'.
>>>

[...]

> 
> 
> Positive thing: the patches do increase performance:
> 
> for me, the following command:
> 
> (echo "{ 'execute': 'qmp_capabilities' }"; for i in {1..10000}; do echo 
> "{ 'execute': 'query-block-jobs' }"; done; echo "{ 'execute': 'quit' }" 
> ) | time ./qemu-system-x86_64 -qmp stdio > /dev/null
> 
> shows 2.4s on master and 0.6s after patches
> 
> 

Thank you for testing it. I'd like to include the result to the patch 
description with "Tested-by: ..."

Andrey

