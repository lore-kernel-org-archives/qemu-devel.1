Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5B0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B644207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mXwWxXQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B644207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbj4H-0003wA-FS
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 07:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbj3g-0003Fw-Dy; Thu, 21 May 2020 07:08:16 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com
 ([40.107.5.97]:63968 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbj3d-0002UM-0G; Thu, 21 May 2020 07:08:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5gphj3T+X0fHCq6y6cM4gt37j9GtwerfKDH69A9EQfMOfinrzjtVzMTE0HZQjK68A7bgVDYRCXcDgshCYuL4czqRQRvTbF1ACESmrsrAxR7b0n5iZlp5bR8E/6cTtdJW0rASLKtK6qgXe0pmRZ0g1WWfVZoLUBn8+INHeeDUgILHOBd+0UZv057d5zr3PCkxs/HLwzFRRSJWSfYxHbWIgKOIy3iyD1OQblHlygPKCmEigtOM49uOVz1Qz5U1n0MUtd8H/i6M6V++VGng/KIGz6oZtONe0jVIba5PfRMfFQ7u1dNmr9h36oU2bH9amGmg8USDRR4tx/wdWdU+fYixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eMM+kDJGfOGPQ9v4AVjTLtXTrb7Etyfx/4xp/JCS0E=;
 b=P6y5uUlN89y+CS9JuXrhTei4XsfvyP5V7xbB6LTg7Dk7BMAvzGtTgZhYZkRLLAMCz9iH0yvEfuLuuhFyn7XKDjtrUfhSpcj2B7m10IETAQsd+CDlyFfvuWnjzXgNqHJAu0ZIIpqcMSkFc3VZfTAHCnQ9I68vQhCkMBgwWKBatVknt2NDjuz+gWEDQApzCzgeKBc2pKYE7z3395ohy+HLZjmdopYhZvIs8wRbBlJQ68ZIl8CRO9hpK8XM+R6pErz+llBtbbB+bJBH+IGP5GG5SslbJvzeg0w+2HnJ29u5xCVuU4AV7tal+jkXk4qtV6V977efTnIjjTMkWeE8mUXugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eMM+kDJGfOGPQ9v4AVjTLtXTrb7Etyfx/4xp/JCS0E=;
 b=mXwWxXQ3kMEC8ty8cC81oKGXeK6nxTfj+0H8ldOt2laYKYhzoFECW8HBvA3rrUZ/evgYaE7arEVMx4FDnYweLGsYOXeZ2SnnAENEOch2OrIZyv5yMZ0ZdlXtsfMpcyLLPSWXZmCzuZRoB67eUyGhoqNej2N0X/ZiRB3LzSqF8zU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 11:08:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 11:08:09 +0000
Subject: Re: [PATCH v3 5/5] iotests: add commit top->base cases to 274
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200520083520.25793-1-vsementsov@virtuozzo.com>
 <20200520083520.25793-6-vsementsov@virtuozzo.com>
 <1c203598-24c8-e632-f654-7313a97b6e71@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <940e2fb9-dc18-abcb-57fe-fef6a39ce7b9@virtuozzo.com>
Date: Thu, 21 May 2020 14:08:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <1c203598-24c8-e632-f654-7313a97b6e71@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0062.eurprd04.prod.outlook.com
 (2603:10a6:208:1::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM0PR04CA0062.eurprd04.prod.outlook.com (2603:10a6:208:1::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 11:08:04 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aefd763-61ab-43e0-f2da-08d7fd773ee8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5512AB3B91FDF992259DE8D9C1B70@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:129;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwuM8sIJLiqHW9Tl7T1jeN0OTmNHlxVQJzzmySDSgiwYgW4dyuZB/JV5JwElKOMi5J5Cof1+ACMIICZRNUJ/4X9mpsT6NAj8SgLVF7u5PfK2HH8nrFc9dkql8J3Va5UBTuXhwApazspSPHDMkMArtFBoNUoCn6E2ugt1DyiKwJhA3t5hvhPGbTxPjRKHBtNVAluVG4FYi8fCcE43A2v5PDqcYiNlthQhtN9lMcmaA2WsQwmyKSXZfLXl8OyJFSBtF7w7iF2uWBLPEZlM+YkmatUcxgPc9xkKU1UXVoqmWaj4Rf4lDzF+Y11wxqdGq6qkiNi7MVFMjMnvQn2Xvl6UTywhc/SKaz4oZ72Mhw06WMr5kdCzgdqbuiRlwJ85/v43
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(376002)(39850400004)(136003)(8676002)(4744005)(186003)(2906002)(16526019)(316002)(6486002)(26005)(31696002)(53546011)(8936002)(36756003)(16576012)(107886003)(478600001)(4326008)(52116002)(86362001)(66476007)(5660300002)(66556008)(66946007)(956004)(2616005)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4dk0Dv0gsVGlvgHygqFn3kCISPt5TgdDYMzOQf9R2jLqm8wZ+kqBKEFWv/cBaGYH/56bYWSKcmyEikYuvv6SHsOfK+JdCoPEkDA+AjHUM+3rsTlbT4E5w0pQaJ6zmqUuoJ5dCDPsmt02kzBRPOvBS3jAcXSXaYdHNRR3D0BXPFjA5O5TwsS/XJ+mMKrVn/0wCDoGxnJP0c37JwFrOMSovg+uZB6yytKDiLkBcADnrJSKOm3V4C7gc2R+mUDDV/uj2k29uFfyyu6XzbAEt+U4/t5U5ovFhU1RC9MZ52nqdVQBkq32MSaQ7UKA+i/sXg/4mI69pXEjq2yArt0uhK8XO884YujsDPOUV++rk/GE5auuS7SDuwsNOi2YUIu1d5yJ4mX1pefeAFP+gSP8SUx4MLqXgbLRHl+8xqkuhOTF7WBPTuVeapqeFThTl0df6Nu8J4gOp69rtSp7zWLy4NwoBGKNvP2rv3sD0D9sPvfPbmcBjmPEBdUJ0Xcq9oRhij9p
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aefd763-61ab-43e0-f2da-08d7fd773ee8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 11:08:09.5938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUsdEVehViL2YjNrljl5H/7LHtihZbMjyYnArpkiB3ysHMDrN0zHaILrsGmNNvHijlHioQ7WH4AwgOnYnfuUAPvFdaQTBE13jcZ0n47Sxjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.5.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 07:08:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.05.2020 19:39, Eric Blake wrote:
> On 5/20/20 3:35 AM, Vladimir Sementsov-Ogievskiy wrote:
>> These cases are fixed by previous patches around block_status and
>> is_allocated.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/274     | 20 ++++++++++++
>>   tests/qemu-iotests/274.out | 65 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 85 insertions(+)
>>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 


Thanks a lot!

-- 
Best regards,
Vladimir

