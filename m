Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73512C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6DA206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Sypz6bnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6DA206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklf8-0007Sn-HX
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkleO-0006My-A6; Mon, 15 Jun 2020 05:43:32 -0400
Received: from mail-eopbgr60107.outbound.protection.outlook.com
 ([40.107.6.107]:6375 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkleM-0006E8-Gh; Mon, 15 Jun 2020 05:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FevLTcqbbFgAxJUuzgorNZeXjwrtonycFOQ9LfzMXQrRLmRcAMVIHLz/VJxNtmlGrQ28e0P8gg59mPXOtirYDIbZH9QcjsEwXYxP7yTn7LBk2Z1c+O1E9RYNJRhvcIOm/Xlb9nOhkgosBBab3pvrjZ+eVfqWnzNbHcy/zHn16W+ljhjigWy0xLVI3t701pWyL+gyNBmG3ls99JsrMB3Zqo9XrrdxJs60TEAzeg9YOoEH2ancogZW0dcFA63Sh/XRMYiwNgRn02/Q7ygQPlo5Ch1cEkCIftnozrgDmOzbPDu+4g296ridrolcARNTYqFzuFPbtsNoaoL8i8HEi2A9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf4y6XcWyUrtmEeRDL0oxCH4CVPEYflxG1jqDuKM91I=;
 b=BVSXkr3ScicmFh/Qnoav7yxbKOqJl70CKdCTCvd37X42DYCvWNT9Ofa4FpVVIVchB0Ty/CVSsMtAqMWhBe22SYX8DbvgCGHXcu7mGGSF9up3f6CWpv00rqGpU4yClQEvRdgnmQ8nhLgyPWcv+QSBRnTCVuALqQ2vngUtcquBP7KlDTwn09PIZd8ipcEF5ZhfXO00P73UWB4lRPV6GovT2/7wAoeTxAa3WxxICap02QYSVddg8JzUE42Kg6SVeoLthkzBBL1ntUgA8o41355g7ybrw1zJhtewkeC4wIyZnBr29v5JtBZI7iL/0cBzZZVka7sysQNjsUDO1xWhceY17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf4y6XcWyUrtmEeRDL0oxCH4CVPEYflxG1jqDuKM91I=;
 b=Sypz6bnVgVszgIlqX5fXxz9FpnlwCN3Wfx4YFIiEHDJ/rtKXqou55s3iKgvQ5xeivK2UP2A6AoX9P82wSq01pcrEsoGWmzavf0LN/asWAVmwc/jzGVDgW6pY9ZKIYS24BBCYxxPH0ax14uzhwAKCyCDIsh8ezBNegDku7Q6EJFk=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5415.eurprd08.prod.outlook.com (2603:10a6:20b:10d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Mon, 15 Jun
 2020 09:43:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 09:43:28 +0000
Subject: Re: [PATCH v7 1/9] iotests: Fix for magic hexadecimal output in 291
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591920302-1002219-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591920302-1002219-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e5690bd9-0da3-d330-4b35-9b675f5ed68b@virtuozzo.com>
Date: Mon, 15 Jun 2020 12:43:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591920302-1002219-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.25 via Frontend Transport; Mon, 15 Jun 2020 09:43:27 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c3abe63-b3f7-4272-9526-08d811108e67
X-MS-TrafficTypeDiagnostic: AM7PR08MB5415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5415297014AF31566B41DEC6C19C0@AM7PR08MB5415.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNL5zwzkMTsz9vYLLaWYQFDNunzT7mMHTm1tXvnos8dL9Jn6LRqd0jkZ8mxRMjg0GaC3C9n/2rlVcZsD2H87y3UU00etbLCIEJsgMEZDVL0EK7pj9qj9rlfx+uzabPKblA0tCkjV/FqOEKkydg5HnNTfqYYtX3bfn8dTyXoEdvebSQP/OggD12s6+apo6Rdnq9GECidE8oUp6xa/wyKHA+Hyrok2NQCJEZcLwZ/4s+DxflsvMcGHrYGLwXtXuysAzalqwsfmwWUO3Cy2uRnJ5/5IO4kS2wa9iFmLMfRoper19q7S3hbwpqCRrnWwwzTOS19tVavHh4rl47XiK7o250hSHJfTlTLX3+w3yiubN472+Yg3mHtfxzqStwt3rpWzKfqObZ9XJ5+4toP0ZsFPGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39840400004)(346002)(366004)(376002)(2906002)(83380400001)(4326008)(36756003)(107886003)(5660300002)(956004)(31686004)(2616005)(66556008)(52116002)(26005)(8936002)(186003)(316002)(66946007)(66476007)(6486002)(478600001)(31696002)(86362001)(16576012)(16526019)(8676002)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pC7mhscP0ggoIofNnSzFT8eaK44FdAmHgJz6crypjhu7h0MlunYNrlryZrpBAKtU2g7KHPAD3FThrvWMnUkJhA8kl2xVwIESEruAmgnfvmS6VWOIfYoBolzzo6s0tnymnJUNqYNx2eGM8narrBpfnVeQ029L0OM4Y3rwjpxQinYQqfHgy/M/DNPtBrJ/8eWqHqio+ndGbiEBuJKHoym5knNjDQLXXeEPzYGjeZkkLUcgqtE853OFDskwpHV2k8LG0Is6pCCKg+meN7AqBNj3MAX4FW9zPCssYREHv7EMvoEXLKYyDBXcd92VF9pIOB1SiT/mLAV78JpXzc06tD4dfyKlzb+YaA3dhKtKV44NhsX/hk5wQBEkB8ELtg9xjoYSTdjyiky3bqiJK3x5UWMb7nILmVky2GzwLymwyoCijx708AGHbMSYmel7foef/xOpY8iSksZGM+lTvQZlXyI9mhTPzp407CMOHVOr5ln6T+0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3abe63-b3f7-4272-9526-08d811108e67
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 09:43:28.0531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLB6sz0IZ2F6dHFSJrczNbnacxmNZXarPxurax758AHQ5Ws2BuUdHjCt0vAKtl2PC6+FVxJKTUcZLCZZqSn4rPBL/aZhFC+h/eWqiz68YZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5415
Received-SPF: pass client-ip=40.107.6.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 05:43:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.06.2020 03:04, Andrey Shinkevich wrote:
> This issue was introduced in the earlier patch:
> "qcow2_format: refactor QcowHeaderExtension as a subclass of
> Qcow2Struct".
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

This change was squashed to original commit

> ---
>   tests/qemu-iotests/291.out | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
> index 1d4f9cd..ccfcdc5 100644
> --- a/tests/qemu-iotests/291.out
> +++ b/tests/qemu-iotests/291.out
> @@ -16,17 +16,17 @@ wrote 1048576/1048576 bytes at offset 2097152
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   Check resulting qcow2 header extensions:
>   Header extension:
> -magic                     3799591626 (Backing format)
> +magic                     0xe2792aca (Backing format)
>   length                    5
>   data                      'qcow2'
>   
>   Header extension:
> -magic                     1745090647 (Feature table)
> +magic                     0x6803f857 (Feature table)
>   length                    336
>   data                      <binary>
>   
>   Header extension:
> -magic                     595929205 (Bitmaps)
> +magic                     0x23852875 (Bitmaps)
>   length                    24
>   nb_bitmaps                2
>   reserved32                0
> @@ -86,12 +86,12 @@ Format specific information:
>       corrupt: false
>   Check resulting qcow2 header extensions:
>   Header extension:
> -magic                     1745090647 (Feature table)
> +magic                     0x6803f857 (Feature table)
>   length                    336
>   data                      <binary>
>   
>   Header extension:
> -magic                     595929205 (Bitmaps)
> +magic                     0x23852875 (Bitmaps)
>   length                    24
>   nb_bitmaps                3
>   reserved32                0
> 


-- 
Best regards,
Vladimir

