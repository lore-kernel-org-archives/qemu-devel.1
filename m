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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD0BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 11:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07222075A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 11:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iSctxikU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07222075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2C3l-0000L4-U6
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 07:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k2C2y-0008Gy-Aj; Sun, 02 Aug 2020 07:20:56 -0400
Received: from mail-eopbgr10112.outbound.protection.outlook.com
 ([40.107.1.112]:1662 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k2C2v-0001my-A0; Sun, 02 Aug 2020 07:20:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Enb/rWwRk8tG6PUgq4waKZ3HSPPDOUBCdg7qbWt4DFNOSvJ78AVovINMKaly2i2BwUTDUYjiEnTD1B3Ui40MfNblbeIujzL/+solHEeTJvgukc7PqyGpAD1FLhUDskMuZeXfmKAxwjJEv3wO/2PXGAxw0jkc3Eh4uM1GcF72RxG6pF7ne8dOSwpYfo48f0gJUjH1IkThPzYsJiGTnf+nP7aPXjcYdfw15hWEX8gqgQCwM5ASpsxxThCWPQMUUwe6wvFnHMs/A/9juhqloCB7xdQfUlSsv8M1ikKM8zTxF5+JQZx6MH/ZlBhhGKEBJVRn+rf9Lfxe1cS6jfA6VGWabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMh6c2I0pE5mVg2fkzy1YjSYwIRa97f/zAGMDthJ0gI=;
 b=G+TQEOFcG3t6qXL7100+EtmLMzGmpkR9YsfcpurEJBvLCpvb3YerFAUy5kGUTN5T9ZlcFIcDpDOTxp2G69jW54xE9bG2hku+Gf/zEorvTZYDhgDkx4EU7Iyz/kcnEocQR7rpPWFU/FLAKBZ/LXduZkA++HLXiAnK1Y/uVJ3w9dAPFzZR1DiquYEbVrq7u5YCqclxmedTUDsrZ7tMg33BRABALyAw4z76K8MaVJUPqlmp9SvqN2NtPUTO/CSr4icrrUJu+RphBcCD4gZQlbaZCSq9fyB+ERKkp2Wc2W+NZwkKWXXiiqbWrqAuckYTUTtZvfoHrScZ2UUgi7cF62nxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMh6c2I0pE5mVg2fkzy1YjSYwIRa97f/zAGMDthJ0gI=;
 b=iSctxikUuerNaeTtDVXqLSCKcdA9xBsVHDLcnn4WcMWjkfi3RGk1iQj7zRaNtvtS86/wAIC9Tt++bY4Efy3TwxVWtev3XuNKFDDANShAiNy96LtYghci03yVUqUl/gGV3+WR3cTadvL9YCNAiKOXDVwfk4NgjkaZbKuX9zszdp8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Sun, 2 Aug
 2020 11:05:47 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3239.021; Sun, 2 Aug 2020
 11:05:46 +0000
Subject: Re: [PATCH v7 45/47] iotests: Add filter mirror test cases
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-46-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <f2d492a1-61de-90d7-3bea-a3244c2da3d5@virtuozzo.com>
Date: Sun, 2 Aug 2020 14:05:42 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-46-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR07CA0092.eurprd07.prod.outlook.com
 (2603:10a6:207:6::26) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM3PR07CA0092.eurprd07.prod.outlook.com (2603:10a6:207:6::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.13 via Frontend Transport; Sun, 2 Aug 2020 11:05:43 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 762f2558-2b0b-46b7-2f37-08d836d40166
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1652C9E282082421C504725FF44C0@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:129;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMPzYrQPt+w5FeTtqTeYtRyi+mXCP+fETyjenAG3nmlgXfNQCwRe5uObhs+lwvIdU22jo8KFEQNgc8W/dBmDeUcVEeeX2RkOE6qC45gh/s+2Uh8oxM9ZTZJn/ILXg/NLjvOoKzU6j92hvp2634b31C6oxA5tq6iSyN7MWZzUkxPLiIHWGQ5d77GuAwOE6oizZOu+S/VtWRmXibxLDVRKrycZjjgw/7sfhv6eIzLaw+OrV1n+Sv+Mx0mC6q8vEtkuV9J4ihASThl3eJnqkL4VkfmmvE4hVFIz9G6dOHdpmXhoRdk1AsSAoSEPIuunvLfdIYmW2OI4NIYbWU/OqQkIO+NkwwV2BMKE1JF2j9yWTTACdQdbrCD6L/FiILeYKfbU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(346002)(376002)(396003)(8676002)(316002)(16526019)(186003)(53546011)(6506007)(2906002)(478600001)(956004)(2616005)(44832011)(54906003)(66946007)(31696002)(52116002)(66556008)(36756003)(66476007)(86362001)(5660300002)(6512007)(31686004)(83380400001)(8936002)(4326008)(6486002)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UlW8D2O6qZa3qJB2ZPkL7Mx2SUfnms86+LRiNY7nzZ5rMWrJfnxkPPBhEK28xDPgkiOxX2sdKqv1EGtrdWTkLYHwwvY65IQODPFTm4O5Cxj4lAyU7GbjQAFWS+r71nIFgm/+JU3NlTUowlvD2UGzZQbDUe5LcAZZByD253I6+u4V0mpodyc65+EnvZxXtwHkjx8on0iAsOAZY4sA60Usa0kCanCQTsXWnSK/xAw4SOi8T1kSeSR7mEfhOtUKEClCILVoCRzCEyBmr1hW1TAuhVINBJUCWDcFD9dX7EBIl0RAXOm+8t80bUvkJDFmAQJ4j+Wt3jSbfO3uuMwQnd7KRUxcsg5zZbQs5phvsQa35mBG96934/MjqGAZPogDdRZlmfHlwf07W34sxxbdqwEsRP88bYWJBQiemDgaY7MpJUw3f5maG+bLSanUXPXYU5f+EFRVrgm6/fo5RIQ3Qyskx1Kc11Ce6+IjSa8iBesZ1k9ITk7K2ZhJ6IYHbMhIpnro0dekwRCWsKpnlvbmbbmJXMgreDjj0qz+NQJ1p3jEsu3pMf8IACYeAeE0YtyWQtPPZlLGWQmxB41ZWAt4rnIYWdDUz8HUh4Czq248siL6lnkfcRc/nvRZcxG6vDR3noFBdPzRHvWrqfR7sc/QAqrXOQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762f2558-2b0b-46b7-2f37-08d836d40166
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2020 11:05:46.9478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qg9JnUpE+NDwxt/NpPknAMG1qB5EJE/sTIGVKpV+9zvmOPP3+9QSr8wPl9mKdvnX5x4dDNqVszan5bGLLas93/P7M5g74WyyNpkZUxWlb60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.1.112;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/02 07:20:50
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
> This patch adds some test cases how mirroring relates to filters.  One
> of them tests what happens when you mirror off a filtered COW node, two
> others use the mirror filter node as basically our only example of an
> implicitly created filter node so far (besides the commit filter).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/041     | 146 ++++++++++++++++++++++++++++++++++++-
>   tests/qemu-iotests/041.out |   4 +-
>   2 files changed, 147 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index b843f88a66..588bb76626 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
...
> diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
> index 53abe11d73..46651953e8 100644
> --- a/tests/qemu-iotests/041.out
> +++ b/tests/qemu-iotests/041.out
> @@ -1,5 +1,5 @@
> -........................................................................................................
> +...........................................................................................................
>   ----------------------------------------------------------------------
> -Ran 104 tests
> +Ran 107 tests
>   
>   OK


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



